Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F26F0D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344211AbjD0UXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbjD0UXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:23:12 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFD4680;
        Thu, 27 Apr 2023 13:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PaoRyiL5NMbZKG8v0vnHM+R4OR4L900+VgKYlOeQda4=; b=ufDP2CsnpnHY+S91HzGO+qnWb2
        LFy3df6oS0qEB8im879rtqn+7qZcSxffq4AYGOw3WyMI94aQuDNv4JrK2oSV3pQagWItR5OheDQ1t
        6GO1ohYta6Q8PEL0Ul6IQBshCO2HLAEQwJ4V3SE3+bm5g3Ce1LPLOgkivMfbESYsKgKs=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:49034 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1ps88i-000386-Jw; Thu, 27 Apr 2023 16:22:53 -0400
Date:   Thu, 27 Apr 2023 16:22:51 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230427162251.518a956ce7a9dcd88352725a@hugovil.com>
In-Reply-To: <CAOMZO5BNbRV1fLpwDZWgj9+gihHJBBGeZCvkF1tgm5GhwSn8LQ@mail.gmail.com>
References: <20230427195538.2718661-1-hugo@hugovil.com>
        <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
        <20230427160608.f051241d750404939296f60d@hugovil.com>
        <CAOMZO5BNbRV1fLpwDZWgj9+gihHJBBGeZCvkF1tgm5GhwSn8LQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] imx8mn-var-som: dts: fix PHY detection bug by adding
 deassert delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 17:07:59 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Thu, Apr 27, 2023 at 5:06 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > Hi Fabio,
> > it uses a ADIN1300 PHY.
> >
> > The datasheet indicate that the "Management interface active (t4)" state is reached at most 5ms after the reset signal is deasserted.
> 
> Please add this information to the commit log and please add a Fixes: tag.
> 
> Thanks

Hi,
I am trying to properly add a "Fixes: " tag, but the description for this tag indicates that it is to report that "the patch fixes an issue in a previous commit".

In this case, I cannot identify a commit that introduced that bug, apart from the initial commit of the DTS file which didn't have the reset property present?

Thank you,
Hugo.

-- 
Hugo Villeneuve <hugo@hugovil.com>
