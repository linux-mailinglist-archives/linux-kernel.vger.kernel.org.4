Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925762DC6C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiKQNPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbiKQNPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:15:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9211A11;
        Thu, 17 Nov 2022 05:15:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48AF8B81FB4;
        Thu, 17 Nov 2022 13:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D5DC43147;
        Thu, 17 Nov 2022 13:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668690908;
        bh=/tCzeZEmzPRx37oBLzkagvQsj8wlh1G9bWayKEYiHts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lzawaooiy6SdnGmw6c/qhCTpcfLDpwM9rRHOpL8+sD+isu0berWV92XejSM3x5Q50
         KNVEp2zBzkqlhlFWDeQ9ijOkQ3Y4nQhZXymMVfp0iLpXSHJihBsQzkNAQ++lfzH/VE
         W3UBJjLedesqiXjwpkhzQks/Ffgiyby9KWnOAA9L1iv1Xq9NdUNsjdjtde1qSatdGP
         iREaRV6reTbOTcxRJRze8cDsnb0X3REr3vM4N9QeppBaOJpJ/k7aI1tU4syAUGsjBi
         bYhlelvc0cob/vFd3rgBlnKbG6zFRFPx8wsNqegA80nxGJ8VUQEVL4tIqIUUHD4TkZ
         WqQea3px/kyPg==
Received: by mail-lj1-f172.google.com with SMTP id d20so2607558ljc.12;
        Thu, 17 Nov 2022 05:15:07 -0800 (PST)
X-Gm-Message-State: ANoB5pna0QRByqRlGJukWwXuwJ4hLytVRSGFFG9P1giGrz3ruXut/Siv
        LCw62O9HC7ompuA6TfT+7irZV9W6VGLINNz5Lw==
X-Google-Smtp-Source: AA0mqf42jQJY2ZXKbN0Unkz+uSk5IpCPI6z0lv6peq7MNZDWv5K1ARcmdUaW1mr+Ioehwfyg6Qtbe1I7JrDQ2WZCs1w=
X-Received: by 2002:a2e:8e6f:0:b0:279:6df:38df with SMTP id
 t15-20020a2e8e6f000000b0027906df38dfmr984844ljk.211.1668690905960; Thu, 17
 Nov 2022 05:15:05 -0800 (PST)
MIME-Version: 1.0
References: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
 <20221116193940.67445-1-blarson@amd.com> <20221116223045.GA1130586-robh@kernel.org>
 <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Nov 2022 07:14:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOvqdP5d52QkE=3qN5hXSxk-+OR-O4SS06Ex=4iZFaVA@mail.gmail.com>
Message-ID: <CAL_JsqJOvqdP5d52QkE=3qN5hXSxk-+OR-O4SS06Ex=4iZFaVA@mail.gmail.com>
Subject: Re: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
To:     "Larson, Bradley" <Bradley.Larson@amd.com>
Cc:     Brad Larson <brad@pensando.io>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 6:41 PM Larson, Bradley <Bradley.Larson@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, November 16, 2022 2:30 PM
>
> >> v8:
> >>  - Apply review request changes and picked the two unique examples
> >>    for the 4 chip-selects as one has the reset control support and
> >>    the other an interrupt.  Missed the --in-reply-to in git
> >>    send-email for v7, included in this update.
> >
> >No, you haven't. By default in git, you don't have to do anything. See
> >--thread and --no-chain-reply-to options. If you are messing with
> >--in-reply-to, you are doing it wrong.
> >
> >Please resend the whole series properly threaded.
>
> Will resend the series
>
> >> diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> >> new file mode 100644
> >> index 000000000000..622c93402a86
> >> --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> >> @@ -0,0 +1,60 @@
> ...
> >> +
> >> +title: AMD Pensando Elba SoC Resource Controller
> >> +
> >> +description: |
> >> +  AMD Pensando Elba SoC Resource Controller functions are
> >> +  accessed with four chip-selects.  Reset control is on CS0.
> >
> > One device with 4 chip-selects? Then I'd expect 'reg = <0 1 2 3>;'
> >
> > Hard to say more because I don't have the whole thread nor remember what
> > exactly we discussed before. That was 100s of bindings ago...
>
> I agree and the example for v7 had all 4 chip-selects shown.

That is not what I said. Look at 'reg' above again. You have 1 device,
but you have 4 nodes which looks like separate 4 devices. The
exception would be if what's on each chip select is independent from
each other.

Describe what your h/w has/is/does so we can provide better guidance.

Rob
