Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8436B2DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCITde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjCITcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:32:54 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B47AFCF36
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:32:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x11so3094089pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678390323;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlMbJ8RFUjqrNZ3nyQ3UxH3pIRl6kRtnRIdmgkJcEJU=;
        b=dGwrQCXfmXHVpty9DfuY6vuVeC+fUW29D5SVOs5Qn2qZmiOZHtiqt2IbTfDZVgp8cR
         24eVwxbOfjDMI36IcW+DwNypZChUZGOZwamdEAkqAzlYdz205bzwIUMTAegLK5N3SDF3
         QNe42QKdIiByZvS9cEJEZgk/R2tVtnewn7Mk80K6ncmAdOE2xIlNqOD/Gti/187aYatH
         XEYPd4dUDwdgl3ywvWf/gZv+9SAAT8iE5EYDzuubz+wjJwSdImHQPFj9LL87CxuMRiNg
         s+1re28ikCD7xxABQRkjCBfILRXbFyIOxfH1ycRfatrkQtS1WXEcQ1dJcfGh7E6wpUMw
         B9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678390323;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlMbJ8RFUjqrNZ3nyQ3UxH3pIRl6kRtnRIdmgkJcEJU=;
        b=WimjnCV2swk64raJ1vmWIu8r0cmtCOXjopH/ATFFYMkxV+PzXXANl4NBxE3rdby+w0
         Vj/zyg4u+/Fpo2RcvSlbVbGJX5Kfw1df36mpcaAU61TbmrCYJY+ZimecafqEccJ4xPP9
         QrtMBeaZi3QTyIIhPlpJi4uSnXybCiffxu9risZwSNDFp6tFD9oyDnznm+imFSELF5Jm
         xc+FQdOsns/YfLlW00/cxSj1Gs/f2LC9S+OXHxyWs/Yd8S+x6jGuAaZftZu8bu8rkNET
         AEbAx3PJIb0aVozSUIEXk7SK6lXRFyRDygUr5p/x28dmBmjtmcSs7gDwTr12d05oVKBK
         sn7g==
X-Gm-Message-State: AO0yUKUx0ymAye2BNG4l/2kxm9hy8nnM0/9otmLVdnOJbkfUsQWM4Lo2
        StFQWDnewr1ItquuBlbjF8zpVQ==
X-Google-Smtp-Source: AK7set/Bw35pT/jjTQF3n73tY439qRrS10p0cjFW8L2W8KJUM41sEW/vQaXrR9/mwQZZvNmKbGEQFQ==
X-Received: by 2002:a17:902:e752:b0:19e:748c:d419 with SMTP id p18-20020a170902e75200b0019e748cd419mr27236838plf.46.1678390322967;
        Thu, 09 Mar 2023 11:32:02 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id lh6-20020a170903290600b0019b0b6a1d5bsm17185plb.273.2023.03.09.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 11:32:02 -0800 (PST)
Date:   Thu, 09 Mar 2023 11:32:02 -0800 (PST)
X-Google-Original-Date: Thu, 09 Mar 2023 11:31:13 PST (-0800)
Subject:     Re: [PATCH v4 12/19] clk: starfive: Add StarFive JH7110 always-on clock driver
In-Reply-To: <CAJM55Z_HGt3iu=trv0v_VzyO3NkVo+aiEaT9vxRURz-MvrbCOg@mail.gmail.com>
CC:     Conor Dooley <conor@kernel.org>, hal.feng@starfivetech.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, sboyd@kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ben.dooks@sifive.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     emil.renner.berthing@canonical.com
Message-ID: <mhng-2dfa0262-dc88-4256-bce9-d7d9bfbd2ba9@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023 10:19:06 PST (-0800), emil.renner.berthing@canonical.com wrote:
> On Thu, 9 Mar 2023 at 19:11, Conor Dooley <conor@kernel.org> wrote:
>>
>> On Thu, Mar 09, 2023 at 03:06:13PM +0100, Emil Renner Berthing wrote:
>> >  On Thu, 9 Mar 2023 at 10:44, Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>> > > The AON clock driver provides clocks for gmac0 which is used frequently.
>> > > So I think it would be more convenient if we set "default y" here.
>>
>> > You're right that if we default y for the ethernet driver then the aon
>> > clock/reset should also default y. Personally I don't think we should
>> > default y for every ethernet driver that might be used on some
>> > supported risc-v platform, but I see now that
>> > arch/riscv/config/defconfig already contains CONFIG_MACB=y,
>> > CONFIG_E1000E=y, CONFIG_R8169=y and CONFIG_MICROSEMI_PHY=y, so maybe
>> > I'm wrong or just too late.
>>
>> The defconfig really needs a good bit of cleanup (one of the many things
>> that I am telling myself I will do as part of kconfig.socs cleanup).
>>
>> w.r.t defconfig Palmer said it pretty well earlier on IRC: "defconfig
>> should be useful for kernel devs, which means it should boot on the
>> common dev boards".
>>
>> IMO, that means enough to boot an initramfs and poke the thing to see
>> that it is alive, so: ethernet & serial, and the clocks/resets/pinctrl
>> stuff required to get those going can all be set to y in defconfig.
>>
>> In the driver Kconfig entries, to me, it's more or less the same.
>> I guess, answer the question "Will your customer's board get to the
>> point where it can load a module ithout building this into the kernel?".
>> If the answer to that question is yes, then don't make it default y.
>>
>> That's my €0.02!
>
> Cool. Defaulting to m in the Kconfig for anything that can be loaded
> later is exactly what I was trying to say, except I mixed in the
> defconfig for no good reason. That means both the aon clocks and
> dwmac-starfive should default to m in Kconfig. The JH7110 (VisionFive
> 2) boots just fine like that and brings up aon clocks and ethernet
> after loading the modules.

That seems pretty reasonable to me.  It's not like defconfig or Kconfig 
defaults or whatever are the only things we're going to test, but it's 
way easier for folks trying poke around with these dev boards if they 
boot defconfig.
