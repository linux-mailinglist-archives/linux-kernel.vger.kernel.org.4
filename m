Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C926E7FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjDSRBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjDSRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:00:59 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9237699;
        Wed, 19 Apr 2023 10:00:52 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 26B1A5FD90;
        Wed, 19 Apr 2023 20:00:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681923650;
        bh=OU1NLvRUb+HCxU4lSgffvUw8fBAqCHnX3pFNeD8icRc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=fAlgunqHuIq2ORPE9XrSBxjsOi6AH149QQIKo3TWZKZiA7QHDR5N5zpH3W1Y95TlD
         we2qrtaIxkZY+2jbRZqGbJ5y979PRIASi4Mym40S16rAqyxqYz1YhnAOpiN7Z9kgcZ
         4LlJ4d/UfQutIXxk64iwPhJ3qWojTMcC20QPa7fV8gg9rdFbHb9O2A+IOtBEiIjUDb
         c8riV2VMvytNa3mAcfkQrqSasVePEDtKj5kHhm9KHKZDpIRpe8cmCJtFkkWUTF7G+c
         RjeCAfxdmYr0Ygsp7W73JiI1CwWli5aX6r3rJUsOUZzL8l0Zz3Y+XY3JGpyOCM/ERr
         ek3fRzKrrpemw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 19 Apr 2023 20:00:48 +0300 (MSK)
Date:   Wed, 19 Apr 2023 20:00:43 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     =Xianwei Zhao <xianwei.zhao@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Message-ID: <20230419170043.auzfa32weevmrt4e@CAB-WSD-L081021>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-2-xianwei.zhao@amlogic.com>
 <20230419131416.cns3xvkbzjeyrnux@CAB-WSD-L081021>
 <661cea17-a4dd-75d1-6a7e-16efa5aea52b@linaro.org>
 <20230419160405.d7qfir3nv6tlxx2a@CAB-WSD-L081021>
 <427e79ef-156d-027e-9296-6f4e6513a04d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <427e79ef-156d-027e-9296-6f4e6513a04d@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/19 15:29:00 #21128497
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 06:25:07PM +0200, Neil Armstrong wrote:
> On 19/04/2023 18:04, Dmitry Rokosov wrote:
> > On Wed, Apr 19, 2023 at 03:43:12PM +0200, Neil Armstrong wrote:
> > > On 19/04/2023 15:14, Dmitry Rokosov wrote:
> > > > On Wed, Apr 19, 2023 at 03:38:33PM +0800, =Xianwei Zhao wrote:
> > > > > From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > > > > 
> > > > > The C series SoCs are designed for smart IP camera
> > > > > applications, which does not belong to Meson series.
> > > > > So, Add ARCH_AMLIPC for the new series.
> > > > > 
> > > > > There are now multiple amlogic SoC seies supported, so group them under
> > > > > their own menu. we can easily add new platforms there in the future.
> > > > > Introduce ARCH_AMLOGIC to cover all Amlogic SoC series.
> > > > > 
> > > > > No functional changes introduced.
> > > > > 
> > > > > Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > > > > ---
> > > > >    arch/arm64/Kconfig.platforms | 12 ++++++++++++
> > > > >    arch/arm64/configs/defconfig |  2 ++
> > > > >    2 files changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > > > > index 89a0b13b058d..bfbc817eef8f 100644
> > > > > --- a/arch/arm64/Kconfig.platforms
> > > > > +++ b/arch/arm64/Kconfig.platforms
> > > > > @@ -162,12 +162,24 @@ config ARCH_MEDIATEK
> > > > >    	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
> > > > >    	  & MT81xx ARMv8 SoCs
> > > > > +menuconfig ARCH_AMLOGIC
> > > > > +	bool "NXP SoC support"
> > > > 
> > > > NXP? Did you mean "Amlogic"?
> > > > 
> > > > > +
> > > > > +if ARCH_AMLOGIC
> > > > > +
> > > > >    config ARCH_MESON
> > > > >    	bool "Amlogic Platforms"
> > > > >    	help
> > > > >    	  This enables support for the arm64 based Amlogic SoCs
> > > > >    	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
> > > > > +config ARCH_AMLIPC
> > > > 
> > > > Do we really need a different ARCH for Amlogic IPC?
> > > > I can imagine that it's not the Meson architecture at all.
> > > > But maybe a better solution is just to rename ARCH_MESON to ARCH_AMLOGIC?
> > > 
> > > It should be changed treewide, and is it worth it ?
> > 
> > As far as I understand, the A1 and S4 families are not fully compatible
> > with the Meson architecture, and we haven't provided additional ARCH_*
> > for them.
> 
> The GXBB, GXL/GXM, G12A, G12B & SM1 are also not fully compatible,
> but they lie under the "MESON" umbrella which covers SoC since the
> Meson6 architecture. It's a facility to include/exclude Amlogic
> drivers/DT, nothing else.
> 
> If you compare it to BCM or NXP, it's different situation, the
> different ARCH_* actually targets totally different SoCs from
> completely different Business Units or from companies acquisitions.
> 
> We should have named it ARCH_AMLOGIC since the beginning, but we
> can't change history.
> 
> > In my opinion, it's a good time to split the Meson architecture into
> > proper subsets, or rename it treewide (maybe only config option
> > ARCH_MESON => ARCH_AMLOGIC).
> 
> MESON is only a codename to differentiate from other SoC vendors
> because Amlogic used it as a codename for a long time.
> Compare this to Allwinner's "sunxi" or Qualcomm's "msm".
> 
> This config has no functional mean, it's only a config namespace.
> 
> Renaming it would need renaming it in all subsystems Kconfig/Makefiles
> and will certainly break builds with custom kernel configs
> in various publicly used builds like Armbian, meta-meson, LibreELEC,
> Debian, Suse, ...
> 
> So it's pointless to change, and even add a different one since
> it's not a family differentiator since the Kernel is modular
> and works around DT to determine which drivers to probe.
> 
> Neil
> 

Thank you for the detailed explanation; it makes sense!
Actually, I disagree with creating a separate ARCH without first reworking
all of its subsets - that's why I started this discussion.
Now, I see that you share my perspective and believe that C3
should be added to the ARCH_MESON subset, so I have no objections.

[...]

-- 
Thank you,
Dmitry
