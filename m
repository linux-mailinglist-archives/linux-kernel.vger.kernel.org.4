Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720C5604E71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiJSRR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJSRRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:17:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C51D2F6A;
        Wed, 19 Oct 2022 10:17:13 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 187so15032042iov.10;
        Wed, 19 Oct 2022 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AlUj/QFNV2i9ZGSPJzeC1G6oHQCEl/zD5yljY4F0lQc=;
        b=ZXMyREUu4xIZz3ws/x/a9lf4cPrx/BaKTr/gdL5w0Ks5jzmnGGlQSLpcXbkCnsDmsj
         0d/k/iCDgt1zBII42EAwqtvXA7gFiETu6evdk6a8vXmnPNfUW4JofkfzlT00Ve9Hpu96
         pw8JV1yY4+VlCSR0no8zmlMbPISuQ5P5yye5lIxr7iazG/MulLc1dxiG9xWwMh2+G3ri
         kgSyOXY9hGj5/ANGR/g2EThUpzl/1vxsKDy7IXpKBY24nkZTu4OpSwO+3hy1QlVihv3/
         ulzf38jMGwmGbb9FHvQI52Gy6QPYQ612GH1mZk9UapDc3IwjC53wNm2rMvRshBEhA+PC
         +LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlUj/QFNV2i9ZGSPJzeC1G6oHQCEl/zD5yljY4F0lQc=;
        b=w6WkL1op/NZAjHgqQRdbUqrw/GUJVC+qqRKNUeTwQ5vsBCsIh3EWT+Jj0+90RCoN6C
         QnlOX+mIxdUwJdddBOMUD8frEl9SP+kpQRQpgxSQ1TmWN9ZiZ4iXub4/LdCReBTkorPS
         8y41SvWe8Q/fqrh7Rg/gugOZeiBePI/uVLm7uZPACrIkp7y1FzFVi2JHaZkI0c8Tq3rv
         gbgIVJo9b+KDIkas3Th97nO0zcoCmUmHaRO1IXKjGsV8abXN9d4aRaoUxEBTpOVIAk4p
         aITz5ri21CSLlDpRhrogfFoYTh/4zshTsCHf4QYAge/zfh7TJKFzKRH9iB/qOsE8HeXx
         EDHw==
X-Gm-Message-State: ACrzQf3eZtD7pXvJzU6DGEoSFUHvmn7g0QzNau3PyepONhxRTt94WfjG
        oDIZZnm5l74X6BsHgOUYux7Cgrxv0T6vv2sJRao=
X-Google-Smtp-Source: AMsMyM45u5EqgmWIvzSP0ManQlUWYAgNb/OwLrfi0zMCsU3sYDTwOpX5k0YBdlf2jwW9lP9jS+bMvGiCCWkvy96GhDM=
X-Received: by 2002:a02:cf33:0:b0:363:ed19:3a27 with SMTP id
 s19-20020a02cf33000000b00363ed193a27mr7303430jar.179.1666199831400; Wed, 19
 Oct 2022 10:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221018195122.8877-1-linux.amoon@gmail.com> <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
 <CANAwSgSR6jHRQR6QgzUop_B4gcOsQnfc6LoUXrP0CSTasZkVfQ@mail.gmail.com>
 <CANAwSgRLZfon5qUFeKW9U9AbHvSa=uKVaVgqghVk554-H1LVKw@mail.gmail.com> <402500e8-b4fe-9b8f-d634-e329191af1b8@linaro.org>
In-Reply-To: <402500e8-b4fe-9b8f-d634-e329191af1b8@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 19 Oct 2022 22:46:55 +0530
Message-ID: <CANAwSgQhWrzeRcpQSSAmfp+i3966dUQdtCLbcWwifQk=1ce=og@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
To:     neil.armstrong@linaro.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi Neil

On Wed, 19 Oct 2022 at 16:39, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi Anand,
>
> On 19/10/2022 11:48, Anand Moon wrote:
> > Hi Martin,
> >
> > On Wed, 19 Oct 2022 at 08:36, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> Hi Martin,
> >>
> >> On Wed, 19 Oct 2022 at 02:46, Martin Blumenstingl
> >> <martin.blumenstingl@googlemail.com> wrote:
> >>>
> >>> Hello Anand,
> >>>
> >>> On Tue, Oct 18, 2022 at 9:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >>>>
> >>>> Odroid N2/N2+ support active cooling via gpio-fan controller.
> >>>> Add fan controls and tip point for cpu and ddr thermal sensor
> >>>> on this boards.
> >>> In the schematics for board rev 0.6 [0] I cannot find any information
> >>> about a fan connector.
> >>> The schematics for board rev 0.3 [1] on the other hand document a PWM
> >>> based fan connector on page 16.
> >>> So now I am not sure whether your patch only applies to certain board
> >>> revisions, the schematics are incorrect, etc.
> >>>
> >>> Can you please provide some details about the fan connector on
> >>> Odroid-N2/N2+ and which hardware revisions are supported (and which
> >>> aren't) by your patch?
> >>>
> >>>
> >> Ok I got this wrong the schematics below there is pwm controller, not
> >> gpio controller
> >> GPIOAO.BIT10 (PWM)
> >> I will correct the patch sorry for the mistake I did not look more carefully.
> >>
> >
> > As per the schematics GPIOAO_10 is controlled by PWMAO_D
> > But looking into the datasheet [0] I could not find the relevant
> > PWMAO_D pmw ip block to link the fan to the PWM controller.
> >
> > [0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
> >
> > I could get the PWM node but is not working for me.
> >
> > @@ -547,6 +588,14 @@ &pwm_ab {
> >          status = "okay";
> >   };
> >
> > +&pwm_AO_ab {
>
> &pwm_AO_cd not _ab
>
No it has a conflict with CPU_B (vddcpu_b) PWM

I have tried linking all the PWM with pwm-fan but it's not working.

# sudo cat /sys/kernel/debug/pwm
platform/ffd1b000.pwm, 2 PWM devices
 pwm-0   (regulator-vddcpu-a  ): requested enabled period: 1250 ns
duty: 0 ns polarity: normal
 pwm-1   ((null)              ): period: 0 ns duty: 0 ns polarity: normal

platform/ff807000.pwm, 2 PWM devices
 pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
 pwm-1   (pwm-fan             ): requested period: 1250 ns duty: 0 ns
polarity: normal

platform/ff802000.pwm, 2 PWM devices
 pwm-0   ((null)              ): period: 0 ns duty: 0 ns polarity: normal
 pwm-1   (regulator-vddcpu-b  ): requested enabled period: 1250 ns
duty: 88 ns polarity: normal

Thanks
-Anand
