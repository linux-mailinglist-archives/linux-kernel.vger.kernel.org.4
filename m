Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF22C60BA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiJXUjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiJXUil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:38:41 -0400
X-Greylist: delayed 10720 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 11:49:23 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E635DA473;
        Mon, 24 Oct 2022 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OHz6g3l6swEzAB25k6thjApk8AJUduADmk1VTYLxLyA=; b=zogi2wkweX+Yln0/3JmVg5tcBs
        MpaFBmkh0Z4Q4IFNImIM0friJaCV4gbxl9Jaw8CGpe006xmBikiykcAsw96ZUqa3Xj8TlyX4PbivG
        19ca6ygqdA5ZwQ52jhs5Lsy6z48oWI3dzolEF5yjEvc8lfFj0Xt0l6Gbvk1DnS4THo7dczedsP3nt
        iMHZb2lZwjfTweaFtrFvFsY4IQWkEQj+0nPp4pRX8tAsrFCriA88mA58Vr43sNjuuK8Ajax4mXe2Y
        EKYc1nWt527aTnsmAFQJ7QfVS90boRqB6QNh+xelNi6YnZpbJ3n6sTcd35v9+ixnoZkpp54RC2HSr
        MIeVAbWg==;
Received: from p200300ccff06c5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:c500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1omyyH-0003Tc-OL; Mon, 24 Oct 2022 17:02:33 +0200
Date:   Mon, 24 Oct 2022 17:02:32 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alistair23@gmail.com, dmitry.torokhov@gmail.com,
        rydberg@bitmath.org, shawnguo@kernel.org
Subject: Re: [PATCH v9 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5
 touchscreen
Message-ID: <20221024170232.6b0175df@aktux>
In-Reply-To: <08cb81ce-7ebd-d79f-3f5c-4df596b5cb95@linaro.org>
References: <20221024111017.43859-1-alistair@alistair23.me>
        <20221024111017.43859-4-alistair@alistair23.me>
        <08cb81ce-7ebd-d79f-3f5c-4df596b5cb95@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to get that thing in, so I am tring to help as much as possible.

On Mon, 24 Oct 2022 08:21:45 -0400
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 24/10/2022 07:10, Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>  
> 
> you miss here commit msg explaining why you want to enable this.
> 
proposal:
The imx6/7 based devices Remarkable 2, Kobo Clara HD, Kobo Libra H2O,
Tolino Shine 3, Tolino Vision 5 all cantain a Cypress TT2100
touchscreen so enable the corresponding driver.

Regards,
Andreas
