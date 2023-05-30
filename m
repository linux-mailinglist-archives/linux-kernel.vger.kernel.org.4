Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785B27169FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjE3Qnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjE3Qnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:43:33 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903C313E;
        Tue, 30 May 2023 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xYpmKMQmPPeBdM21QayEVgKLDqZ+OIn6t8tDa7bpcxs=; b=WtHfSpWCRwXoq+kq2JbstX6p/c
        YX+EIQlMpx2XWHFoCo4ZsG2THm5d1qtR/HPMmPJkuQ6doVJfHCPAeiK3B/xIguMHpyufiuMdDOY0H
        YoKhAGE6AnMWyg9nRKGQ7jxgIn8rhaK0H0czFxWaZNnJlWCfnZDIs1q2Ac/Pm+MJMeNoVukUiYDuX
        E7MbdiJYJOJLmMmx/GFQaAtHYAE3qjYaISQl7KkISWpkv7mpXtv7EqKf7crF+9tKkgepP7DTP4wmF
        kf/UbMoxUapHGc2R1DOG6/zW1BXxqe6uVc6/Efo+UvgiP+ArjQCYcav/8nSOLEB0y3yUj+MoaqZdE
        /Q/1qS0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55382)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q42RH-00039H-OL; Tue, 30 May 2023 17:43:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q42RE-0008DR-6J; Tue, 30 May 2023 17:43:12 +0100
Date:   Tue, 30 May 2023 17:43:12 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lizhe <sensor1010@163.com>
Cc:     andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] drivers/gpio : Remove redundant clearing of
 IRQ_TYPE_SENSE_MASK
Message-ID: <ZHYnoHK7YDCC7AMg@shell.armlinux.org.uk>
References: <20230530162034.4004-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530162034.4004-1-sensor1010@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:20:34AM +0800, Lizhe wrote:
> Before executing microchip_sgpio_irq_set_type(),
> type has already been cleared IRQ_TYPE_SENSE_MASK, see __irq_set_trigger().
> 
> Signed-off-by: Lizhe <sensor1010@163.com>

Please do as Bart has requested.

Your patch touches two files, each of which are managed by *different*
people via *different* trees. Re-posting your patch will *not* get it
applied, because the reason it can't be applied is because you have not
split it as people have asked you to do.

So, there is no point you re-posting it in its current form. You will
only make people frustrated, and if that continues, you will end up
being ignored.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
