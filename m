Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74F37449C8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjGAOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 10:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGAOeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 10:34:25 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC5B99;
        Sat,  1 Jul 2023 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2nT/Q2r3OF8MPGSXSxANqp6p/AG3+1hk6myLkolAw04=; b=6bdjw3ehmO1ACbKSqJPNU3t1+9
        1GzL/Hf8OiaTxBG1VTPou99bw8AX4vbaY1q1QfTbfD13jAAgPZ+geT0MFPIAJ4ZyzFoZb5IaX/UgQ
        67+lRRLzR3Pd/9/1FtAwReaOsiDrL8iGeWna+cNpP2gBuu6BUGFlZHz3QATpnTOJdA2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qFbfz-000N8O-J9; Sat, 01 Jul 2023 16:34:15 +0200
Date:   Sat, 1 Jul 2023 16:34:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: phy: at803x: add qca8081 fifo reset on the link
 down
Message-ID: <d4043e1f-d683-48c2-af79-9fea14ab7cc1@lunn.ch>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-4-quic_luoj@quicinc.com>
 <e1cf3666-fecc-4272-b91b-5921ada45ade@lunn.ch>
 <0f3990de-7c72-99d8-5a93-3b7eaa066e49@quicinc.com>
 <924ebd8b-2e1f-4060-8c66-4f4746e88696@lunn.ch>
 <7144731c-f4ae-99b6-d32a-1d0e39bc9ee7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7144731c-f4ae-99b6-d32a-1d0e39bc9ee7@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Andrew,
> This block includes MII and MMD1 registers, which mainly configure the PLL
> clocks, reset and calibration of the interface sgmii, there is no related
> Clause 73 control register in this block.

O.K. What does it have in the MII ID registers? Does Linux think it is
a PHY and instantiating an generic PHY driver for it?

	Andrew
