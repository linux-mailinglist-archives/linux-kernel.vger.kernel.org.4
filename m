Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082936F3BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjEBBi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBBi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:38:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AED172E;
        Mon,  1 May 2023 18:38:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315712406so149086365e9.0;
        Mon, 01 May 2023 18:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682991503; x=1685583503;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VY6sg4QHtW/F7ejnI/trNLnsy73rmOwLgxPDQHz9Y10=;
        b=ebu0v04znpWvN+0ABS4WDZUVCiSIccl1PeLVRtO66tvv4eFVKF/EQaIG9umHJju5gL
         wqBnEWEMOrZh08xkVay5GdVSlpLGBR/eKlXV0Eiqaf/5qYse0xbTSaB/cNCVvFT2J/K+
         nulERRq3afjDLx5dCSqWLiLKaPU16Y06Rkt9cSOzBIn84K7SBJhJSyPUjnMrKtDX5I9d
         DJ9O9O62ZmbtJWIFop0Mbd9YH1CdGat1WDtOb4uMv+RyREexVaxKu9EdGlUqzvwNvbgi
         3foTV5Jqe/rFHU9La1trENL1Nhxg9Wq455240i/Gk/HVxhXG+oY4aNJhoMsGE70NvYaf
         qgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682991503; x=1685583503;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VY6sg4QHtW/F7ejnI/trNLnsy73rmOwLgxPDQHz9Y10=;
        b=F/fivyd4wxxd0cJJ2OKiG0xV9yxSyZ1qHCQDVDfwtTskiKWVsfyCuwccLB3ulyiFX6
         GcvtR/xOtD4cwrNVVBSuuAZGWkEz4HRwfYHVi3haFrPD91tuTZ8Q8vTav0WKVJt3yPH/
         b3ir6DAKl1nTy7e7hq5RZ2TVBrQwg6XkyXx0ixjg3g80HvdXjn5UUmQSTdMU4ecWFRda
         CTgAoqjpoRmrODP7bne4ClVdlXBi0PRBhmiRjeqWCnXut0LqjZEWGtbNRdjTHxiPVpom
         u7uOm99OHYip4ENWoQjUscUYUXYoOqIF69LvhN0vvD6rF5qeqF7JJWbaLRVmKGAum2oy
         qB3Q==
X-Gm-Message-State: AC+VfDxn8629zwZj2o3mBeXOKG7K7lzcaD5FtqNvsOhAvACaHVvKZfWn
        WO1v276ynLG1NuhtXhgzekQ=
X-Google-Smtp-Source: ACHHUZ77cqYAYl1Uh3mvhhV6YECZ8gpnoepS0uwwuok5QbSuP32c5Jkmh3BRvdlqJQtHfMd9dEycIg==
X-Received: by 2002:a5d:4046:0:b0:303:daff:f1a3 with SMTP id w6-20020a5d4046000000b00303dafff1a3mr15320567wrp.1.1682991503076;
        Mon, 01 May 2023 18:38:23 -0700 (PDT)
Received: from smtpclient.apple ([91.135.9.67])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c35c300b003f1836c98b7sm35214527wmq.48.2023.05.01.18.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2023 18:38:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v14 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAFBinCCdoaNuQymcjp5j9MHn2jpPWMqXe-+EgBo=5Ot8Bwaofw@mail.gmail.com>
Date:   Tue, 2 May 2023 02:38:20 +0100
Cc:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>, mturquette@baylibre.com,
        sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>, jian.hu@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        AML <linux-amlogic@lists.infradead.org>,
        linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F9DDB93-5EE7-4B5D-AFB5-052968081E0A@gmail.com>
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-6-ddrokosov@sberdevices.ru>
 <CAFBinCCdoaNuQymcjp5j9MHn2jpPWMqXe-+EgBo=5Ot8Bwaofw@mail.gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 1 May 2023, at 7:51 pm, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> Hi Dmitry,
>=20
> On Wed, Apr 26, 2023 at 11:58=E2=80=AFAM Dmitry Rokosov
> <ddrokosov@sberdevices.ru> wrote:
>>=20
>> Add the documentation for Amlogic A1 Peripherals clock driver,
>> and A1 Peripherals clock controller bindings.
> Maybe a native English speaker can comment on whether it's
> "peripheral" or "peripherals".

I=E2=80=99m not a grammar specialist, but I would write:

=E2=80=9CAdd documentation and bindings for the Amlogic A1 SoC =
peripherals
clock driver=E2=80=9D

Peripherals is the correct plural but reads better when you add
context on the type of peripherals.

Christian

> [...]
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> .../bindings/clock/amlogic,a1-clkc.yaml       |  73 +++++++++++
>> .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   5 +-
>> include/dt-bindings/clock/amlogic,a1-clkc.h   | 114 =
++++++++++++++++++
> I have seen that Yu Tu named the S4 peripheral clock controller
> binding and driver "s4-peripherals-clkc" [0].
> Does it make sense to apply the same naming here as well?
>=20
>=20
> Best regards,
> Martin
>=20
>=20
> [0] =
https://lore.kernel.org/linux-amlogic/20230417065005.24967-3-yu.tu@amlogic=
.com/
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

