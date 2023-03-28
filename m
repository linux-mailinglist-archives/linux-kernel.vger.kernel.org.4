Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7D6CB682
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC1GEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjC1GEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:04:04 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97137171E;
        Mon, 27 Mar 2023 23:04:01 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(26685:1:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Tue, 28 Mar 2023 14:03:31 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Tue, 28 Mar
 2023 14:03:30 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Tue, 28 Mar 2023 14:03:30 +0800
Date:   Tue, 28 Mar 2023 14:03:30 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     ChiaEn Wu <chiaen_wu@richtek.com>, <corbet@lwn.net>,
        <lee@kernel.org>, <matthias.bgg@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <jacek.anaszewski@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-doc@vger.kernel.org>, <peterwu.pub@gmail.com>,
        <linux-leds@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <szunichen@gmail.com>
Subject: Re: [PATCH v18 1/3] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
Message-ID: <20230328060330.GA32398@linuxcarl2.richtek.com>
References: <cover.1678430444.git.chiaen_wu@richtek.com>
 <1df93a583c3f508a7158b83b95857e9bce235e1b.1678430444.git.chiaen_wu@richtek.com>
 <ZCGCGb9E4KYlFNXR@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCGCGb9E4KYlFNXR@duo.ucw.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:46:33PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The MediaTek MT6370 is a highly-integrated smart power management IC,
> > which includes a single cell Li-Ion/Li-Polymer switching battery
> > charger, a USB Type-C & Power Delivery (PD) controller, dual
> > Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> > a display bias driver and a general LDO for portable devices.
> > 
> > Add support for the MediaTek MT6370 Current Sink Type LED Indicator
> > driver. It can control four channels current-sink RGB LEDs with 3 modes:
> > constant current, PWM, and breath mode.
> > 
> > Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> > Co-developed-by: Alice Chen <alice_chen@richtek.com>
> > Signed-off-by: Alice Chen <alice_chen@richtek.com>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> 
> > +++ b/drivers/leds/rgb/Makefile
> > @@ -2,3 +2,4 @@
> >  
> >  obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
> >  obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
> > +obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
> 
> I'd preffer leds-mt6370 name. We already have "rgb" in directory
> name...
> 
Yap, sure,

But for mt6370 leds, except rgb indicators, there are also flashes for camera.
To keep the postfix in filename can more precisely tell what the file for.


> Otherwise looks good. Thanks for doing this.
> 
> BR,
> 								Pavel
> -- 
> People of Russia, stop Putin before his war on Ukraine escalates.


