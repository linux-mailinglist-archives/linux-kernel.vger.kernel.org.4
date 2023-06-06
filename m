Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F33724379
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbjFFNAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbjFFNAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:00:02 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46419173A;
        Tue,  6 Jun 2023 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JBzFOAQ3XIEwIfPf6gzDHs3g12s3r3/k8QYv78kFr9Q=; b=iJ1GBZU7395iT/S0hTb4/CFA8+
        epY/qHDWZSXzrOrO2QucaB9FHlqgHXvlVh3wnykYMiF7GZ+5Bx/xn13fNR+b062vjpD6k2Hn7VLXo
        4bmiea3UoRMbpk7VOeT4HDObgGm1M/qcW9jR+6HIE46xmOGsfwP8qqCD5Uwu1xYx22ms=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q6WH6-00F1Mf-AK; Tue, 06 Jun 2023 14:59:00 +0200
Date:   Tue, 6 Jun 2023 14:59:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org
Subject: Re: [PATCH 0/3] Add MHI Endpoint network driver
Message-ID: <c769c95d-e8cb-4cf6-a41a-9bef5a786bb1@lunn.ch>
References: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 06:01:16PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series adds a network driver for the Modem Host Interface (MHI) endpoint
> devices that provides network interfaces to the PCIe based Qualcomm endpoint
> devices supporting MHI bus (like Modems). This driver allows the MHI endpoint
> devices to establish IP communication with the host machines (x86, ARM64) over
> MHI bus.
> 
> On the host side, the existing mhi_net driver provides the network connectivity
> to the host.
> 
> - Mani
> 
> Manivannan Sadhasivam (3):
>   net: Add MHI Endpoint network driver
>   MAINTAINERS: Add entry for MHI networking drivers under MHI bus
>   net: mhi: Increase the default MTU from 16K to 32K
> 
>  MAINTAINERS              |   1 +
>  drivers/net/Kconfig      |   9 ++
>  drivers/net/Makefile     |   1 +
>  drivers/net/mhi_ep_net.c | 331 +++++++++++++++++++++++++++++++++++++++
>  drivers/net/mhi_net.c    |   2 +-

Should we add a drivers/net/modem directory? Maybe modem is too
generic, we want something which represents GSM, LTE, UMTS, 3G, 4G,
5G, ... XG etc.

    Andrew
