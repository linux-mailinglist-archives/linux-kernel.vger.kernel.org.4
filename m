Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5F724EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbjFFVWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjFFVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F62C1703;
        Tue,  6 Jun 2023 14:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F9C636E3;
        Tue,  6 Jun 2023 21:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021FC433EF;
        Tue,  6 Jun 2023 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686086548;
        bh=arMmkPx8p+KotVlOtO31lWA8+Pl1GfABSl2za4V1r20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTHj4vTz7NWJnMxSdDybrPffLiwOAAt/GT+LbZOR0Ea9wmewUx1puAh7RGeWhU72B
         Lqsmu3YUzXRCvdsU0m7+ZK7MOJhH6BGtuRbolezWOAri8oSHNJEw4IlR4zm34jwa+j
         7tUSSbnCwD56iKhsdTxVokZG4P+dfKEMZzrjdWSZ9PdQKm4LKmLV00Tq9FSQsaiEGF
         BbW2Odh+XYTE9AmxtPBskCYfFXfWkRXeoTiNQYYtvtuy7tP7LUN/fXtuo+KqQU/FNE
         44srhnybLUp4f4vWhva+Wvh8muHKen2dr8tw3WA7wKDU3ZG4qmlqr3vrT34ktCMXw8
         VtQhu8TPTcphg==
Date:   Tue, 6 Jun 2023 14:22:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH 0/3] Add MHI Endpoint network driver
Message-ID: <20230606142227.4f8fcfee@kernel.org>
In-Reply-To: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
References: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Jun 2023 18:01:16 +0530 Manivannan Sadhasivam wrote:
> This series adds a network driver for the Modem Host Interface (MHI) endpoint
> devices that provides network interfaces to the PCIe based Qualcomm endpoint
> devices supporting MHI bus (like Modems). This driver allows the MHI endpoint
> devices to establish IP communication with the host machines (x86, ARM64) over
> MHI bus.
> 
> On the host side, the existing mhi_net driver provides the network connectivity
> to the host.

So the host can talk to the firmware over IP?
