Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3773682D28
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjAaNBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjAaNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:01:06 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190134C0EF;
        Tue, 31 Jan 2023 05:01:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12394735wma.1;
        Tue, 31 Jan 2023 05:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcbQEiUfrn1ZLUYtm1to7N6PATT0Q4d4Al24IcBS9+8=;
        b=gxbalLRF7g/piLUDzum6ebHhSbBaltk6UMjAP7SzNURpivtTQRNbXwLEF3xjaouFBn
         jtFHwMyOW0WxQK0V1w2+IWl0yv85YcEJXQf6uPgkCbbSV6zGUMvwpM8jO54q0LJmsfzE
         Sn+g6BOpSl2VHk6D7eM0XrTl34FLD9+JxoVqEcjU4QX8LfQlYpCbtWtzySRmxaTAeiN2
         Yho9h0l1V3OoxmRXvtL6RwynC9iju0zES5zGPs6pd2AaktDox1ymMdOjA/tRnwTAIp5L
         +woUlu2SxAF3KNorJCpALEkhhOF+HRlFpsYDcDjt9frz5AKSF7B80R8n6Bg6o4yi4UAd
         qz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcbQEiUfrn1ZLUYtm1to7N6PATT0Q4d4Al24IcBS9+8=;
        b=g3ycmcJmGxADuAkDuyk85H444mLRexcacPILOnZo8ThX8ymIvqV535YvN0K3G/wTQD
         DqhwCN2JXh/s66oK7LkyrOq4VTo803Myx4HAJ2Vahc6Xw5hARylvMuJ69wNhc9eQvhxw
         duu3daoHEOuBYcOP5fqU7uGF+vmgITpgN1u3qnIqByhSOnuTcOw5fpfX7FADYY+tmZal
         Qjirwv5dhD8Jo6BIulE6lNJ0VE1JHvbA/zBlPWEbvt2KL2e0CCTQ/tqHiJxvTNe3sVFC
         AXOuaHP7I9nUKgqp+m0ak8IPNnm3pOLxbzpQOmUkNVdGawxA/U10wWXcfkXUGI5FZ+Sn
         0m3A==
X-Gm-Message-State: AFqh2kozHCIpCbdhCY7jkuJRE4Qd55beZonWIOkd+qWskXu7Je4tOzD7
        RYm4T5NhmM1TBmZYyoqpsv0=
X-Google-Smtp-Source: AMrXdXuDDJd2SOnxH8EH5v5wZHtF9KUTDRi/lGRngFPYhNv4y5IUyuOEIXA9HCw05LZe4uX1KZugCA==
X-Received: by 2002:a05:600c:a4e:b0:3db:14d0:65be with SMTP id c14-20020a05600c0a4e00b003db14d065bemr48389876wmq.34.1675170063488;
        Tue, 31 Jan 2023 05:01:03 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id g8-20020adfe408000000b002bdda9856b5sm14901344wrm.50.2023.01.31.05.01.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:01:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] media: rc: add keymap for Beelink Mini MXIII remote
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <Y9kJfPqtd98wIQ6r@gofer.mess.org>
Date:   Tue, 31 Jan 2023 17:00:59 +0400
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <34CD7297-AC0A-404D-B90C-D00FA861A43E@gmail.com>
References: <20230128034117.3983105-1-christianshewitt@gmail.com>
 <6e953652-4a24-6f3c-74e7-07c25fa1c6c1@linaro.org>
 <Y9YwbiJz9vOBejdL@gofer.mess.org> <20230130213020.GA3541260-robh@kernel.org>
 <Y9kJfPqtd98wIQ6r@gofer.mess.org>
To:     Sean Young <sean@mess.org>
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


> On 31 Jan 2023, at 4:28 pm, Sean Young <sean@mess.org> wrote:
>=20
> On Mon, Jan 30, 2023 at 03:30:20PM -0600, Rob Herring wrote:
>> On Sun, Jan 29, 2023 at 08:38:06AM +0000, Sean Young wrote:
>>> On Sat, Jan 28, 2023 at 11:11:32AM +0100, Krzysztof Kozlowski wrote:
>>>> On 28/01/2023 04:41, Christian Hewitt wrote:
>>>>> Add a keymap and bindings for the simple IR (NEC) remote used with
>>>>> the Beelink Mini MXIII Android STB device.
>>>>>=20
>>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>>> ---
>>>>> .../devicetree/bindings/media/rc.yaml         |  1 +
>>>>> drivers/media/rc/keymaps/Makefile             |  1 +
>>>>> drivers/media/rc/keymaps/rc-beelink-mxiii.c   | 54 =
+++++++++++++++++++
>>>>> include/media/rc-map.h                        |  1 +
>>>>> 4 files changed, 57 insertions(+)
>>>>> create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c
>>>>>=20
>>>>> diff --git a/Documentation/devicetree/bindings/media/rc.yaml =
b/Documentation/devicetree/bindings/media/rc.yaml
>>>>> index 266f1d5cae51..f390a5d2c82d 100644
>>>>> --- a/Documentation/devicetree/bindings/media/rc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/media/rc.yaml
>>>>> @@ -39,6 +39,7 @@ properties:
>>>>>       - rc-avertv-303
>>>>>       - rc-azurewave-ad-tu700
>>>>>       - rc-beelink-gs1
>>>>> +      - rc-beelink-mxiii
>>>>=20
>>>> Bindings are separate patches. Didn't you get such feedback =
already?
>>>=20
>>> The only change for new keymaps is an added entry to the rc-map-name =
enum.
>>> In the past, new keymaps have been accepted with that single line in =
the
>>> same commit.
>>=20
>> It's been a checkpatch.pl warning since 2018. The separation is so =
that=20
>> commit messages in the DT only repo[1] make sense.
>=20
> Ok, makes sense.=20

I will resend v2 series(s) with the bindings separated. Are there any =
other
issues to address?

Christian=
