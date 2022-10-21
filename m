Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA5606F21
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 07:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJUFHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 01:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJUFH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 01:07:29 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC472187DF3;
        Thu, 20 Oct 2022 22:07:27 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id l127so1390264iof.12;
        Thu, 20 Oct 2022 22:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MEwZHem6XE7/ekLP3cDVQiDet0qLNX4/5trFWKq/TK4=;
        b=MhfhmXR8De3QaEZs1GgnopnDHQU/TldUkkJLZfKo8RH91E3wimNUV609GsUonZMXkL
         tOriKFtKty8u0HT3H/hbnzT4Pxr4xp6d2Q4PDgVtULnkAlptMcSngaeqVa3Q/UrMMhpO
         IQZeN0ar8S7WYAkf6HFjP8pacsnxEhBCJypQmyY8Tv22rdlXBSEynIJOlflWSFUN4jNH
         flt31456ja5+HTaQwx9cRyIvmBXJKrk1ncgt9FwND7xVM8TE9aTsfQd72QqProHWSA2d
         qzPq0jbftOVsKmFzYUBufu9KN09YcFD6h7BSmsVcOFCHspzNXBchYSqH8lKTtVbAlUA3
         6PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEwZHem6XE7/ekLP3cDVQiDet0qLNX4/5trFWKq/TK4=;
        b=kyoCnYMuoSOpSN/6T5QNV6JGKrxlFmwFePE770yDFo9LYhGaSKlbwI5sa7H+rWEGV7
         VbeLj4748lTDU7AzV9aUXLT561jl1pArOVLhf54ebf2bKfVcnExr432DpAKDzC6+zHkp
         07Xe7fKvlSgVTm/SjcaiSEDE7/WGgRG790x9+DF+gM/Q2mMQo6fQfhR625aOBjYkurmf
         J0mZaFm7c7IV1M2l8MCc6RIvzHLZcphvrJldHyWE0v8VvlOP0CeAOKi4JZUMCf/doRjU
         glT3Q4Kvt+9v9Bdd1pX8iXavfxOH9lJtDBR/bJWLPohbTlMnOsm5qZdC7/m9j1khd/HM
         PpRA==
X-Gm-Message-State: ACrzQf0eKMsu+RUVV58YpX/PRSvuJV+5M4QL/SGX8DVKG3cHsWRgBdgn
        bbOlenKHqEOakvuTY9kSHSIa1+6nbnQfj2olZho=
X-Google-Smtp-Source: AMsMyM6U2t/J1APaVQvh2XiaYqqrQH23meYzMdt+B6vkVCvpey5BQkHlr4XgLl/VZwV7wx93EPq7cUKl2q/VRyvhQwA=
X-Received: by 2002:a05:6602:2742:b0:6bb:a95d:7e3a with SMTP id
 b2-20020a056602274200b006bba95d7e3amr11993607ioe.16.1666328847336; Thu, 20
 Oct 2022 22:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221018195122.8877-1-linux.amoon@gmail.com> <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
 <CANAwSgSR6jHRQR6QgzUop_B4gcOsQnfc6LoUXrP0CSTasZkVfQ@mail.gmail.com>
 <CANAwSgRLZfon5qUFeKW9U9AbHvSa=uKVaVgqghVk554-H1LVKw@mail.gmail.com>
 <402500e8-b4fe-9b8f-d634-e329191af1b8@linaro.org> <CANAwSgQhWrzeRcpQSSAmfp+i3966dUQdtCLbcWwifQk=1ce=og@mail.gmail.com>
 <CAFBinCCyEVbc4N7TUEi=sbLFv7Rc-L=y-h8xBuZK446x1oLc2g@mail.gmail.com>
In-Reply-To: <CAFBinCCyEVbc4N7TUEi=sbLFv7Rc-L=y-h8xBuZK446x1oLc2g@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Fri, 21 Oct 2022 10:37:11 +0530
Message-ID: <CANAwSgQ9gJvtdr_r1K0xxrDxQ6aBh5v=pR9aJSxRytia2PSbrg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin / Neil,

On Thu, 20 Oct 2022 at 02:10, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Wed, Oct 19, 2022 at 7:17 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > > > +&pwm_AO_ab {
> > >
> > > &pwm_AO_cd not _ab
> > >
> > No it has a conflict with CPU_B (vddcpu_b) PWM
> Uh, you're right. That's probably why the Hardkernel team uses a
> software based PWM implementation: [0]
> In hindsight they should have used a different pad either for VDDCPU_B
> or the fan.
>
> I think the most pragmatic approach (since the "GPIO PWM" driver is
> not upstream and I don't know if something like that would be accepted
> upstream) is to use a GPIO based fan as you did in your initial patch.
> Not sure what others think though.
>

When I use gpio-fan  I get the following output with gpioinfo
Feature it woks as expected.

$ .sudo gpioinfo
....
gpiochip1 - 15 lines:
        line   0:      unnamed       unused   input  active-high
        line   1:      unnamed       unused   input  active-high
        line   2:      unnamed     "enable"  output  active-high [used]
        line   3:      unnamed       unused   input  active-high
        line   4:      unnamed       unused  output  active-high
        line   5:      unnamed       unused   input  active-high
        line   6:      unnamed       unused   input  active-high
        line   7:      unnamed       unused   input  active-high
        line   8:      unnamed "regulator-tflash_vdd" output active-high [used]
        line   9:      unnamed      "TF_IO"  output  active-high [used]
        line  10:      unnamed   "gpio-fan"  output  active-high [used]
        line  11:      unnamed    "n2:blue"  output  active-high [used]
        line  12:      unnamed       unused   input  active-high
        line  13:      unnamed       unused   input  active-high
        line  14:      unnamed       unused   input  active-high

When I am using pwm-fan using *pwm_ao_d_10_pins* pin is not getting
registered below hence it is not working on my end.

$ .sudo gpioinfo
....
gpiochip1 - 15 lines:
        line   0:      unnamed       unused   input  active-high
        line   1:      unnamed       unused   input  active-high
        line   2:      unnamed     "enable"  output  active-high [used]
        line   3:      unnamed       unused   input  active-high
        line   4:      unnamed       unused  output  active-high
        line   5:      unnamed       unused   input  active-high
        line   6:      unnamed       unused   input  active-high
        line   7:      unnamed       unused   input  active-high
        line   8:      unnamed "regulator-tflash_vdd" output active-high [used]
        line   9:      unnamed      "TF_IO"  output  active-high [used]
        line  10:      unnamed       unused  output  active-high
        line  11:      unnamed    "n2:blue"  output  active-high [used]
        line  12:      unnamed       unused   input  active-high
        line  13:      unnamed       unused   input  active-high
        line  14:      unnamed       unused   input  active-high

Thanks
-Anand




>
> Best regards,
> Martin
>
>
> [0] https://github.com/hardkernel/linux/blob/c109dec94e7e819554830acfac4b6ed96e230179/arch/arm64/boot/dts/amlogic/meson64_odroidn2.dtsi#L356-L359
