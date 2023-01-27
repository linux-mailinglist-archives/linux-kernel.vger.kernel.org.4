Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6267E831
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjA0O02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjA0O0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:26:25 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122136EA1;
        Fri, 27 Jan 2023 06:26:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso3583256wms.3;
        Fri, 27 Jan 2023 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQvKuWYbN5U9wXSHPFKMRagSKFxuvpjCAy16zSMxd5s=;
        b=ftRyiXQYN4C/taX6rBMEEtJ4FYiYyGbKiMEy1G81lAEO4Undc3m4fU5sqvhUMeA+ce
         trYLUENe8ScOmKriBWOkIlnMg1ZugngJW1/1nxJDUUl53Ei3BN/D1EXIHzRMls7y5gRL
         yngeTRHjSc7ysN2WfKNfsUH9/I/u5YuX+QnjtsT+6OeEqH+xafvfplXA0AWU7UUWXPkb
         p9sXAvP1U5PbzWj8Z7GUfjHvPqUkBblHPDj03g1g8XIltFJblEd1wz2oh9G/QPOjyDNL
         2mpgaUHUw44YNpowOucgnGJNJoko0yFv0A9E/p8TPJV9ltxGkAyWZHJTTSMMCaIMgYGG
         6T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQvKuWYbN5U9wXSHPFKMRagSKFxuvpjCAy16zSMxd5s=;
        b=rCEIQeszhhNm+PSWYQCwF2rgQZqLQPkRvtjbHGoV3wF8DfYKYkcSZgtCVIjbush6HO
         mRL943SsE/7SliGNNrdqoGS2J/BsDO3Un4K61t7IiUOAqrEbKhRqTrNwD3RXHc66rVK1
         WrcHcfD/0F/8fhxH+b4RMCz7pernT2lFD31v42KF74B+xx1nhhahLXHL1OJkUGhQBjfD
         DK8RP27Ez2nPGDje97c0c/tyBZjN6KSMO1sIp8BqXqGhZrE+65tk4C48f9BhDKUnfgOU
         WQkmvbaxyac2L9hRrwkzFTj8T1J/DKsohvDL0l7Wt6ZAF+DyTdOZY6zedR7UQy9ZVag2
         DxKQ==
X-Gm-Message-State: AFqh2kpnGsNw5YguAcw3FuLRD2zPerZY2S4LI3PMUGD1IaqC4jKMlqNl
        lg2vM4PztyrUuE99W0qRUnw=
X-Google-Smtp-Source: AMrXdXuTsCLLxprVf+MTPCRfzq/gdhb9xh4vISbik9FA0H0my/Cy7zi0t3bSLwwCauop5fVPs0vFMw==
X-Received: by 2002:a05:600c:2d0b:b0:3da:fcf0:a31d with SMTP id x11-20020a05600c2d0b00b003dafcf0a31dmr40316535wmf.22.1674829576580;
        Fri, 27 Jan 2023 06:26:16 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c384f00b003d9de0c39fasm9340686wmr.36.2023.01.27.06.26.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2023 06:26:16 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 4/4] arm64: dts: meson: add support for BananaPi M2-Pro
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <468aef98-2bd7-03d5-0f83-dc58bc4738e9@linaro.org>
Date:   Fri, 27 Jan 2023 18:26:12 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5EFDCC3-AB2F-464A-B5B6-1B1482D7D9A4@gmail.com>
References: <20230127100236.3385154-1-christianshewitt@gmail.com>
 <20230127100236.3385154-5-christianshewitt@gmail.com>
 <a35f7f09-eb19-6cfc-2053-c6b340f10cbd@linaro.org>
 <356B9EBF-B9C4-4CB0-9F83-9E7A62F93F65@gmail.com>
 <468aef98-2bd7-03d5-0f83-dc58bc4738e9@linaro.org>
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


> On 27 Jan 2023, at 5:01 pm, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 27/01/2023 11:19, Christian Hewitt wrote:
>>> It's by default. Did any DTSI disable the sound node?
>>=20
>> No. I=E2=80=99m simply transcribing from the original M5 dts (with =
edits to omit
>> the audio jack bits) and the sound nodes of other Amlogic dts which =
have
>> long included the same.=20
>>=20
>> Q. Do I need to remove it here? (sounds like a yes)
>=20
> Yes

I=E2=80=99ve removed for both dts and sent v2

>> Q. Do we need to exorcise/cleanup the same from all other meson dts?
>=20
> Yes, please.

I=E2=80=99ll put on my to-do list :)

Christian=
