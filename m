Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A967F90E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjA1PWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 10:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjA1PWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 10:22:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3BE3EFD7;
        Sat, 28 Jan 2023 07:22:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k16so5342220wms.2;
        Sat, 28 Jan 2023 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfCv/QIIYglL4klA+d69bXntv9XoQLGHGOciteN0+rw=;
        b=mVmIzzEVaxX9pg89SWineigvpnE96fHvxvY/giu1pIpo692dxxIpHv3X8rk6OHfjmi
         E/QUd0Ok9EPbVqUXX/jU1v6wp7Q6awA0uOMKwdWDQnvNfyyyd0d3zukCvEPSYA9JMyC2
         qKpcHASg5CHAOSFu08pvPcGuM94iHLrpaL9BH2uWj7PEFEe1SaIVO9wEtpOP8m0lIbHx
         pS4vHQSNnXeYqomy/5ke5sikMlTj3ZCBFA8AGq0ZlGowU9+/iSw+gREc8ZxiVtRgr6IV
         5wRgxko+npx47Z9buTOU87uQEpfPFrhfoNN7dF4VgDKymKJdA1MGmBWaJ5KU23rfxpP4
         iOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfCv/QIIYglL4klA+d69bXntv9XoQLGHGOciteN0+rw=;
        b=VaHLQ0UP9BMf/cE4ZELFygzw5Wc0kLXz1j49xHzQmsY+j/TvhyeYi8xtpK6Y1FwNNH
         B1r3vvIpHM8l4ij3GNTqlE02Qj/BeLY7QXD0O96iHhyLTXrLCnm3jV+yOQdAivgb2QoK
         qPT4GCnYuG1CUbKEOczMGph3ury2iBNMHIC+uBeFeD5yuIwYcoIWLozVY7ShLo2TEAL/
         rP8XCcTnRnhay2uSSUfPUJo9riOlNMbGOAnKqax95ICFE4yTQwIORP+J3OzlVipPbh9p
         ViFHTqVJHS+kUM5emhDP7PU9cX2RMMlE45kkgSBGwcfiTNKsO09Z6QFx8YONpcIX38Bx
         cM8Q==
X-Gm-Message-State: AO0yUKWqywd7aCbPwHdjwqk/7Kj+rre3BXKG0zhL3L6MFtO9mW/V2INM
        SNiiwfrknjCODBbyc/Ny6Cs=
X-Google-Smtp-Source: AK7set8dYyW8C3w9XQl+9XkkwkkPG7WbeLbUyYS88AprB3Hi4J58mycdTjnHYMQjwIlx2b6Q/v0JRQ==
X-Received: by 2002:a05:600c:4691:b0:3dc:24fc:ef6f with SMTP id p17-20020a05600c469100b003dc24fcef6fmr10856480wmo.40.1674919353495;
        Sat, 28 Jan 2023 07:22:33 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c26d300b003dc50c38921sm578690wmv.35.2023.01.28.07.22.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jan 2023 07:22:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] media: rc: add keymap for Beelink Mini MXIII remote
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <6e953652-4a24-6f3c-74e7-07c25fa1c6c1@linaro.org>
Date:   Sat, 28 Jan 2023 19:22:28 +0400
Cc:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D641B9CE-164A-4498-BCB9-CB840B2EC18D@gmail.com>
References: <20230128034117.3983105-1-christianshewitt@gmail.com>
 <6e953652-4a24-6f3c-74e7-07c25fa1c6c1@linaro.org>
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


> On 28 Jan 2023, at 2:11 pm, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 28/01/2023 04:41, Christian Hewitt wrote:
>> Add a keymap and bindings for the simple IR (NEC) remote used with
>> the Beelink Mini MXIII Android STB device.
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> .../devicetree/bindings/media/rc.yaml         |  1 +
>> drivers/media/rc/keymaps/Makefile             |  1 +
>> drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 54 =
+++++++++++++++++++
>> include/media/rc-map.h                        |  1 +
>> 4 files changed, 57 insertions(+)
>> create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c
>>=20
>> diff --git a/Documentation/devicetree/bindings/media/rc.yaml =
b/Documentation/devicetree/bindings/media/rc.yaml
>> index 266f1d5cae51..f390a5d2c82d 100644
>> --- a/Documentation/devicetree/bindings/media/rc.yaml
>> +++ b/Documentation/devicetree/bindings/media/rc.yaml
>> @@ -39,6 +39,7 @@ properties:
>>       - rc-avertv-303
>>       - rc-azurewave-ad-tu700
>>       - rc-beelink-gs1
>> +      - rc-beelink-mxiii
>=20
> Bindings are separate patches. Didn't you get such feedback already?

I=E2=80=99ve always submitted keymaps (and only keymaps) with everything =
in a single patch. If
that=E2=80=99s not okay anymore I can resend with the bindings =
separated.

Christian

