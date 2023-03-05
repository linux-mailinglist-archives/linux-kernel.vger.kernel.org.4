Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DFB6AB00C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCENsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjCENsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:48:05 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FA11498C;
        Sun,  5 Mar 2023 05:47:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q16so6370662wrw.2;
        Sun, 05 Mar 2023 05:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgccpFC0cmADrFfCEi9mRisLTkUSblVIUuRK9wVI2oc=;
        b=BIEgwxzU2sKD58+jNWAw4z4k9A5hBzcNmLPvel+XTp5zgg2dkmqKS8Ph/VhWIaKzlk
         4p4oYr6T2lxSwyVUbQzJZ0L/xgRsKoxaUYoDtNVuTRVZQIAszAdSH5I8PauvEJYfYeWU
         CIK0PIPc6Eb2H3R+ZtpO6q0vjotS0nrLwrqxuZPq41GQI+xz3tjPheuzm+n5mh+wcDB/
         qlUHMtHAqqjWswTW3E4kkhh+Fqet9UG427afoO39HfNSHSVVwdH9rZi8xIdeLzxv1Z08
         O9WYWnLHIEwV8pnGEShyXv1yVAEOkEaDd5RpQkDniv3TbwqHQ7VtRJMGMmVZQ9mFEBl4
         XB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgccpFC0cmADrFfCEi9mRisLTkUSblVIUuRK9wVI2oc=;
        b=wwFKr5CjC1DqC3CBObmIPDMgX4te5LGgCZqoUIh33/MVJfAk2z1aZG8cfFIrHA5Xx3
         tzzNYzcW4INYev50aS8hDPVs0WrZQyxkfAcZX6qjQHXaEgl9BD0Ew8Yeot7Upg+ku4IU
         aSenQAdbbP6xbhH5mh7XHU2gPzbl4JW/tlHFh4+o2cFfoy9XadGQr0TQ2+Q6218nuVBS
         uXdmqcKyNtAFEcBCn5lxVYPGccKPMQQ55t0XY78Hhuzsjfrw4BJpVFN/ClfVqBZj6lg0
         7aiflUhtvS2bdI2vmWdNNda7yvr+fbX/mmwmyMA6ZXuvmLsftg+R2TPfuce2zP/ARF7f
         aFCw==
X-Gm-Message-State: AO0yUKVudozrrBmiixRh6cHjPkz2LCZhtd+B+80riXta3R/Kc/gKpDM6
        NBfX3N3o0yq7ajyjZWU4TNY=
X-Google-Smtp-Source: AK7set/4CfbD2Va0TPMevPmj8KPXfN+Sc7iATlgyiEG3NUSXqB8JwjyKi60XS/M2/2ED+FuhJ6lk8Q==
X-Received: by 2002:adf:e74a:0:b0:2c7:efb:dded with SMTP id c10-20020adfe74a000000b002c70efbddedmr5669098wrn.24.1678024062276;
        Sun, 05 Mar 2023 05:47:42 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id r4-20020a5d4944000000b002c56013c07fsm7313389wrs.109.2023.03.05.05.47.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Mar 2023 05:47:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] arm64: dts: meson: add support for BananaPi M2S
 variants
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <0d2184ee-679e-371e-8433-c38b22c97799@linaro.org>
Date:   Sun, 5 Mar 2023 17:47:38 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9CC246C2-28A7-46DF-924F-8FBF5CDE16CA@gmail.com>
References: <20230305132044.1596320-1-christianshewitt@gmail.com>
 <20230305132044.1596320-3-christianshewitt@gmail.com>
 <0d2184ee-679e-371e-8433-c38b22c97799@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 5 Mar 2023, at 5:30 pm, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 05/03/2023 14:20, Christian Hewitt wrote:
>> BananaPi M2S ships in Amlogic S922X and A311D variants with the
>> following common specifications:
>>=20
> (...)
>=20
>> +
>> +	leds {
>> +		compatible =3D "gpio-leds";
>> +
>> +		blue {
>=20
> led-0
>=20
> Does not look like you tested the DTS against bindings. Please run =
`make
> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> for instructions).

I=E2=80=99m building everything in a cross-compile build system that =
doesn=E2=80=99t allow
this to be done without a problem amount of hoop jumping. I need to work =
on
another arrangement to do this testing (work-in-progress). Thanks for =
the
input.

Christian

>> +			color =3D <LED_COLOR_ID_BLUE>;
>> +			function =3D LED_FUNCTION_STATUS;
>> +			gpios =3D <&gpio_ao GPIOAO_7 GPIO_ACTIVE_LOW>;
>> +			linux,default-trigger =3D "heartbeat";
>> +		};
>> +
>> +		green {
>=20
> led-1
>=20
>> +			color =3D <LED_COLOR_ID_GREEN>;
>> +			function =3D LED_FUNCTION_STATUS;
>> +			gpios =3D <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
>> +		};
>=20
> Best regards,
> Krzysztof
>=20

