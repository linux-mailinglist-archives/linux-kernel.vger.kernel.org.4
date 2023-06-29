Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ACE742711
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjF2NO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjF2NO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:14:26 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBFD2D51;
        Thu, 29 Jun 2023 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ev7f/SttSlNV0/fZbiCdeWB5/3NyrGGdpFSEpdjZfZs=; b=dw64qHpvoez7kAlXxbwTpcAjxK
        zJbV1Dh7pNxO6aUo91ZAO7nB+5oRF3WhOA8lGPKB5d4NaE4tMhZdm3tNFcjAbg5ztGQOEyTe7AX83
        UOCKZJjcj0r/8P11UMJFxN63ObG46BaYdqKUuDVjQ3wT5NUdx91CzMklpi50RZBtNxA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qErTH-000EAl-PH; Thu, 29 Jun 2023 15:14:03 +0200
Date:   Thu, 29 Jun 2023 15:14:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_sricharan@quicinc.com
Subject: Re: [PATCH 1/3] net: phy: at803x: support qca8081 1G chip type
Message-ID: <48e41540-6857-4f61-bcc5-4d0a6dbb9ec1@lunn.ch>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-2-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629034846.30600-2-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:48:44AM +0800, Luo Jie wrote:
> The qca8081 1G chip version does not support 2.5 capability, which
> is distinguished from qca8081 2.5G chip according to the bit0 of
> register mmd7.0x901d.
> 
> The fast retrain and master slave seed configs are only needed when
> the 2.5G capability is supported.

Does genphy_c45_pma_read_abilities() work on these devices? 

     Andrew
