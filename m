Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571D06AB104
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 15:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCEObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 09:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCEObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 09:31:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2B410438;
        Sun,  5 Mar 2023 06:31:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bw19so6377573wrb.13;
        Sun, 05 Mar 2023 06:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76w5hvK4+zlxLtKzkGCJU6IxlpJ/8FKM1yUiTkueqfw=;
        b=EPC78ilt/2Sv3mpTyKdo7Co2wo9EdHjph24EPcUvpzV94z2xdlfkosIeZWp1LAKNRh
         qfloU6t55iTaWB3WpJ2gZzkMWQ/13sJ2LF756yXVQ7/rhnpXiihwJjToplBaP7aSuj/d
         5/GDlx0GkB3dThFCNn9Pr8BFwk1LablmGI344bc3ihxcAzBGrQ5cfaJU/VxnvQcMlKam
         1/4LYc+UX2EzBkc1JQjYoAs7mgvKNyyeVLr7e3Ei8FskRH+N4KFJyhvsq/2YGdoWbiT6
         vixq9quNHce1MYwS9Pp7+g/HzouyE7XVmO8qZCs5tWFIxQ1tarUL3SHgcFoLHDsHcJrF
         8OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76w5hvK4+zlxLtKzkGCJU6IxlpJ/8FKM1yUiTkueqfw=;
        b=yXwErBKGWefyMh4sik5CsXN+zICIxYJEWRX+ObBtJUjZEVZ8vBE71xSFIi3+rtS3Xg
         4Q+JwbsOfLsQj1QQrsbnq/PwJXrdNyp+kIquX7+fARVpAyJX43DUe2vbdkXwWDxBCAh/
         gskFIOZP3isZDB9V0tT3z4qtBuKXyknWbjnnifY9m6aN8yxmfquy0X/FoXLAXHBrp5L4
         E0+ZA/9f4OipnnyAQbWwO4kaubcT/QKo3T2je0tXqwXgvRtoToOP6D7FhsEgECliQAOw
         AL/EUlc27/kn1iL5SscIUTCVORordd9DJ986BcOYiDUmt9HrQ1XeJ9GMojnVnazb/uYu
         0SFA==
X-Gm-Message-State: AO0yUKWO07k7JMEJCMFqokzRcUVrNx/g4QE0EwXotXsyf7SlhDct9UKl
        oDo+mb00pgA4oGdPMEJEDB4=
X-Google-Smtp-Source: AK7set+lA5Z7RZ5wappM/Xh2RvI+RSR6CTr5QV7cnxmXjnjqitI1CkfdhyAxO+j1ZaQLPhqbFibimQ==
X-Received: by 2002:adf:dd43:0:b0:2ce:50a9:6d8c with SMTP id u3-20020adfdd43000000b002ce50a96d8cmr2810376wrm.32.1678026674493;
        Sun, 05 Mar 2023 06:31:14 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b002c71b4d476asm7456916wrd.106.2023.03.05.06.31.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Mar 2023 06:31:14 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] arm64: dts: meson: add support for BananaPi M2S
 variants
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <e52c4a1d-951e-8ce5-4aec-7f2b6d4c6c3a@linaro.org>
Date:   Sun, 5 Mar 2023 18:31:10 +0400
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
Message-Id: <82FF9933-B4CF-428B-9EB7-40FCBD285EEE@gmail.com>
References: <20230305132044.1596320-1-christianshewitt@gmail.com>
 <20230305132044.1596320-3-christianshewitt@gmail.com>
 <0d2184ee-679e-371e-8433-c38b22c97799@linaro.org>
 <9CC246C2-28A7-46DF-924F-8FBF5CDE16CA@gmail.com>
 <e52c4a1d-951e-8ce5-4aec-7f2b6d4c6c3a@linaro.org>
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


> On 5 Mar 2023, at 6:15 pm, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 05/03/2023 14:47, Christian Hewitt wrote:
>>=20
>>> On 5 Mar 2023, at 5:30 pm, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>>>=20
>>> On 05/03/2023 14:20, Christian Hewitt wrote:
>>>> BananaPi M2S ships in Amlogic S922X and A311D variants with the
>>>> following common specifications:
>>>>=20
>>> (...)
>>>=20
>>>> +
>>>> +	leds {
>>>> +		compatible =3D "gpio-leds";
>>>> +
>>>> +		blue {
>>>=20
>>> led-0
>>>=20
>>> Does not look like you tested the DTS against bindings. Please run =
`make
>>> dtbs_check` (see =
Documentation/devicetree/bindings/writing-schema.rst
>>> for instructions).
>>=20
>> I=E2=80=99m building everything in a cross-compile build system that =
doesn=E2=80=99t allow
>> this to be done without a problem amount of hoop jumping. I need to =
work on
>> another arrangement to do this testing (work-in-progress). Thanks for =
the
>=20
> Cross compiling kernel and running this (also as cross compiled) is
> trivial, so what exactly stops you? Packaging kernel for your system
> (e.g. Yocto) is different topic, but that's final step, not necessary
> for development of DTS.

I=E2=80=99m reasonably competent within the constraints of the distro =
build-system
environment that I use and know. I=E2=80=99m very lacking in knowledge =
if you step
outside that. It=E2=80=99s mostly an old-dog/new-trick problem, and =
something I do
need to improve upon (not a good excuse, I know).

Christian=
