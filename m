Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916C760E24A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiJZNhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiJZNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:37:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066FC31F87;
        Wed, 26 Oct 2022 06:37:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B016DB8212F;
        Wed, 26 Oct 2022 13:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FA5C433D7;
        Wed, 26 Oct 2022 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666791460;
        bh=UL2LVpGMXmV0M4vv+QD2QvanVwPYtHQCP3mM8/DFWPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fq5bs9HS5e+GaFM8oZ9fQp/meOdajrvz46zeTC+ULT8qOkEkXYJBlfZD8vfelMLJJ
         eNFd5WOk+QpsVZjlSHQVn0XC9dklP4XuaMvUqAkJTwE3FF1wp/ea6BfBvnd5G6r+NA
         2iRNR875hR/DanzkFrRNgGwU5LkAnFnAos2wMg0bD1X2R0BsQg++1R/BbfQwserQbd
         g9SB8hAGEP8Di146ESs7yu88zqIlg9/pOuqrSpc8+dctFyBJVUYnfJ6fPDcPQ2dx1k
         AfQvh6nZULc8qV9gIaXoJFidPKiylIoAjL/vufeoGa3O/tHBnp9H5JS/xDpJzxi4Os
         QEZ94s7A3Jxzg==
Received: by mail-lj1-f172.google.com with SMTP id s24so11451026ljs.11;
        Wed, 26 Oct 2022 06:37:40 -0700 (PDT)
X-Gm-Message-State: ACrzQf03h6ZcSfXe2UHPUR0UVqTNoMGKok/X2ubBcpNZ0Ue7ucWoZbCz
        dWW3BaMcuhjlr+sXevsbAL1CR0YEqHmkJQs7Zg==
X-Google-Smtp-Source: AMsMyM5kpW7MAdB7VpnGWrfcHXb1OJGlN7V6fN1CwSlI6dgAnhKep1S3QF4Mt0l8icI+mQSAGvQ6t48c8gLOjFDgMl4=
X-Received: by 2002:a2e:a44c:0:b0:26b:e70f:a026 with SMTP id
 v12-20020a2ea44c000000b0026be70fa026mr15457816ljn.94.1666791458417; Wed, 26
 Oct 2022 06:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221013094838.1529153-1-Naresh.Solanki@9elements.com>
 <20221013094838.1529153-2-Naresh.Solanki@9elements.com> <20221024161806.GA1855651-robh@kernel.org>
 <dcd22f70-e51c-290e-c11f-9a5ce32748c1@9elements.com>
In-Reply-To: <dcd22f70-e51c-290e-c11f-9a5ce32748c1@9elements.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Oct 2022 08:37:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKT52ULEZjKo9emEAt74nH2OpMO8ymLLKM_T-NzAwqGog@mail.gmail.com>
Message-ID: <CAL_JsqKT52ULEZjKo9emEAt74nH2OpMO8ymLLKM_T-NzAwqGog@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 4:16 AM Naresh Solanki
<naresh.solanki@9elements.com> wrote:
>
>
>
> On 24-10-2022 09:48 pm, Rob Herring wrote:
> > So if we unload and reload the driver module, it should go back to the
> > default?
> This is RPM to be set during probe if desired.
> >
> > I think it is really, 'target RPM if not already configured' which could
> > be keep the setting from a register (e.g. what the bootloader set) or
> > perhaps you already have temperature information to use...
> Yes. missed it. It should be target-rpm will correct this. in next version.
> >
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +  pwm-frequency:
> >> +    description:
> >> +      PWM frequency for fan in Hertz(Hz).
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +
> >> +  pwm-polarity-inverse:
> >> +    description:
> >> +      Inverse PWM polarity for fan.
> >> +    type: boolean
> > As I said before, the PWM binding handles these 2 settings. Use it. Yes,
> > it's a bit of an overkill when the child is the consumer of the parent.
> > Until some 'clever' h/w engineer decides to use one of the PWMs for
> > something else like a backlight.
> I would like you to consider this as something recommended by fan
> datasheet for the given fan instance.
> This info can be used by fan controller driver to configure PWM
> source/provider accordingly.
>
> If you still feel that may not make sense then I'll remove this property.

You evidently don't understand my comments. My suggestion is to do this:

fanc: fan-controller {
  #pwm-cells = <3>;
  ...

  fan {
    pwms = <&fanc 0 500000  PWM_POLARITY_INVERTED>;
    ...
  };
};

0 is PWM number and 500000 is the PWM frequency. The 3rd cell are per
consumer flags. See pwm.txt for more details.

Rob
