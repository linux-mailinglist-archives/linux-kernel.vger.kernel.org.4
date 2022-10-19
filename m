Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F646040D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiJSKVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJSKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:21:13 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC5B12B34A;
        Wed, 19 Oct 2022 03:01:05 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id o65so14003174iof.4;
        Wed, 19 Oct 2022 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+gH18NMXsLrXdxE5QG5IXpfPb6gpkkgJRS++3hiNtc=;
        b=HaxP/TJIrzOP1fSvUBtD3PbhySohG28AX/Rs413Hoa9jyN0bFl0ofjcLNUcuORn9jw
         9kCoKP872VmdonnjqmLC3pVfnJD02GFt67Ovrq8sO2EtZ9Mcm38NW5K53/4E9Zrzvf/o
         61sVVStnYCeLmbxsI4HyAnP/JB7hg3JGFRi4+HP6Go6aJ6K5LPMIy/Z62caPMuen8Hf4
         NqsvpjZ4ajUcfZQtpwNDxGb9lQInom4CxJFx7KEIblBgLMQmljANIo4F0t8cuTyvk1jf
         0uenQDKuZxEKNKq9lxaOfL5t9OvVhJVuK5eB5xHfFGhxME3eVHeHJCwZwBIB9nPv+4Xx
         3b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+gH18NMXsLrXdxE5QG5IXpfPb6gpkkgJRS++3hiNtc=;
        b=qXzMpmFQJPv7r+AgREW7uDGZ3KrW13a3S0Hi0IxRQXi3r8zS+LColv6JwI3mFjN7Pv
         lESGuqIRmzkiBDH7KN/iLABNTOS/QWTnr95mGY65ICb+AHUSxDibPMveYShK9Rqwu6WJ
         8H2WHEi6DvMQcGAKR4XFPxJy0lQOMfSmQmvqcsWLzLEMcS1x9VJ7NUkdxczmBUNsAqQX
         Ep7M2xr+VQJHUWvcAE+0VvSdis5b2yxzq80WRM4Vby4oqLq8FFsQOEDbjqJ17PjExlDQ
         x67tnMwoZejJp3la6BlBJp9vx/MHABJ3B9hyHkNbIH7pQoDSE8KA+nyuJbEc3f4A+5Vq
         Z+qQ==
X-Gm-Message-State: ACrzQf3dSUbvsfgLf8Bd+o7r3vcCnvI4DV80KUwFswACBXHSiJI7eJbs
        H9oh5gdhBev7HcY/Q1dYwDTHWJmhKEzAt7EN4wZdg5nb
X-Google-Smtp-Source: AMsMyM6xArXqSugR0nN9BNdZbtJnY3QAB/sH1iDiacz99SmY/2A38tLRXBMdEsAFJKv7SCu695euSpu3Wg+bztX3Tao=
X-Received: by 2002:a92:da4a:0:b0:2f8:fa94:9dae with SMTP id
 p10-20020a92da4a000000b002f8fa949daemr5074198ilq.80.1666172904631; Wed, 19
 Oct 2022 02:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221018195122.8877-1-linux.amoon@gmail.com> <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
 <CANAwSgSR6jHRQR6QgzUop_B4gcOsQnfc6LoUXrP0CSTasZkVfQ@mail.gmail.com>
In-Reply-To: <CANAwSgSR6jHRQR6QgzUop_B4gcOsQnfc6LoUXrP0CSTasZkVfQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 19 Oct 2022 15:18:08 +0530
Message-ID: <CANAwSgRLZfon5qUFeKW9U9AbHvSa=uKVaVgqghVk554-H1LVKw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Wed, 19 Oct 2022 at 08:36, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Wed, 19 Oct 2022 at 02:46, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hello Anand,
> >
> > On Tue, Oct 18, 2022 at 9:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Odroid N2/N2+ support active cooling via gpio-fan controller.
> > > Add fan controls and tip point for cpu and ddr thermal sensor
> > > on this boards.
> > In the schematics for board rev 0.6 [0] I cannot find any information
> > about a fan connector.
> > The schematics for board rev 0.3 [1] on the other hand document a PWM
> > based fan connector on page 16.
> > So now I am not sure whether your patch only applies to certain board
> > revisions, the schematics are incorrect, etc.
> >
> > Can you please provide some details about the fan connector on
> > Odroid-N2/N2+ and which hardware revisions are supported (and which
> > aren't) by your patch?
> >
> >
> Ok I got this wrong the schematics below there is pwm controller, not
> gpio controller
> GPIOAO.BIT10 (PWM)
> I will correct the patch sorry for the mistake I did not look more carefully.
>

As per the schematics GPIOAO_10 is controlled by PWMAO_D
But looking into the datasheet [0] I could not find the relevant
PWMAO_D pmw ip block to link the fan to the PWM controller.

[0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf

I could get the PWM node but is not working for me.

@@ -547,6 +588,14 @@ &pwm_ab {
        status = "okay";
 };

+&pwm_AO_ab {
+       pinctrl-1 = <&pwm_ao_d_10_pins>;
+       pinctrl-names = "default";
+       clocks = <&xtal>;
+       clock-names = "clkin0";
+       status = "okay";
+};
+

Thanks
-Anand


> > Thank you!
> > Martin
> >
> >
> > [0] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
> > [1] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.3_20190117.pdf
> Thanks
> -Anand
