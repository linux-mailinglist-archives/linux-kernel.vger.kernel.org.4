Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3415E8584
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiIWWCr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Sep 2022 18:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIWWCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:02:45 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2421EDD3B;
        Fri, 23 Sep 2022 15:02:43 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 6B5201A0739;
        Fri, 23 Sep 2022 22:02:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id B26E420028;
        Fri, 23 Sep 2022 22:02:19 +0000 (UTC)
Message-ID: <ac809b03c78355b52c4ce936cc5a4ed3dd303441.camel@perches.com>
Subject: Re: [PATCH v9 09/10] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
From:   Joe Perches <joe@perches.com>
To:     Han Jingoo <jingoohan1@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia.Lawall@inria.fr, krzysztof.kozlowski@linaro.org
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, lee@kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        mazziesaccount@gmail.com, andriy.shevchenko@linux.intel.com,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Date:   Fri, 23 Sep 2022 15:02:28 -0700
In-Reply-To: <CAPOBaE7mcNqgQvsPpqewmq=Na9MC9RH5AW8CHn5ZJFAUsq6_eg@mail.gmail.com>
References: <20220830034042.9354-2-peterwu.pub@gmail.com>
         <20220830034042.9354-10-peterwu.pub@gmail.com>
         <CAPOBaE7rz2F-sij-LbYau6TRxFoOfmoUc=R__Z7iUrFWmZPgrg@mail.gmail.com>
         <CABtFH5+PuK4vptVNmpn4h2FCxNFp3wWvhUrOxgqArx4YxCY99w@mail.gmail.com>
         <CAHp75VeRgRdv54yO51nBwKx8O2pNLvOD2mrqn31zvx4ffSpCHw@mail.gmail.com>
         <CAPOBaE7mcNqgQvsPpqewmq=Na9MC9RH5AW8CHn5ZJFAUsq6_eg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Stat-Signature: icdqc5u914mweh6876zxemizkb1yinja
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B26E420028
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX180tjz2i84oRN7SAvJ/UKULO1Sz9+vBSi8=
X-HE-Tag: 1663970539-507553
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-23 at 14:34 -0700, Han Jingoo wrote:
> On Wed, Sep 21, 2022 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > 
> > On Wed, Sep 21, 2022 at 4:48 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > > On Sun, Sep 18, 2022 at 3:22 AM Han Jingoo <jingoohan1@gmail.com> wrote:
> > > > On Mon, Aug 29, 2022 ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > 
> > > > > +#define MT6370_ITORCH_MIN_uA           25000
> > > > > +#define MT6370_ITORCH_STEP_uA          12500
> > > > > +#define MT6370_ITORCH_MAX_uA           400000
> > > > > +#define MT6370_ITORCH_DOUBLE_MAX_uA    800000
> > > > > +#define MT6370_ISTRB_MIN_uA            50000
> > > > > +#define MT6370_ISTRB_STEP_uA           12500
> > > > > +#define MT6370_ISTRB_MAX_uA            1500000
> > > > > +#define MT6370_ISTRB_DOUBLE_MAX_uA     3000000
> > > > 
> > > > Use upper letters as below:
> > 
> > For microseconds (and other -seconds) the common practice (I assume
> > historically) is to use upper letters, indeed. But for current it's
> > more natural to use small letters for unit multiplier as it's easier
> > to read and understand.

I think it's fine. see:

commit 22735ce857a2d9f4e6eec37c36be3fcf9d21d154
Author: Joe Perches <joe@perches.com>
Date:   Wed Jul 3 15:05:33 2013 -0700

    checkpatch: ignore SI unit CamelCase variants like "_uV"
    
    Many existing variable names use SI like variants that should be otherwise
    obvious and acceptable.

