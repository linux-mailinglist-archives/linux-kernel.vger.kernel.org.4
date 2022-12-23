Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7955D654E84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiLWJmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:42:49 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A593578A;
        Fri, 23 Dec 2022 01:42:49 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so2919953qvs.2;
        Fri, 23 Dec 2022 01:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6m48Capw4esr7BRAr2uCfaQnqi6DTJEEbEkBGSU+S8=;
        b=qixvvbS0zKEsE1IWMNk1avAg3bztMcDHoFNg1v4eXwCzENNJH4dH/Fqp0IV+kfu2i0
         ZrUV67Dmx8CvRO1k6KlBd5I7EDWXXBYuHMcySiRvChV7nyUJWufNadOl1cl2d7krYBbW
         7ZxkLKaEc/eNSXcEIy5eZPmokxJ2x26ialUuMRITOtTQ0RHGrM0al8RN0PX9S2jGLViv
         Yy7gD9ULzpS91NIn2SvLprj3sle1rROhU4JMaITeJ8fu43aVfwQTKTovrrTWyRE7xs1t
         PjFzsVNKr5/2jCjkcBiupUyWNa1CYC9P76wGThwNN09Ckh6vMlZfKaX1tUN8DDdr9pWI
         JH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6m48Capw4esr7BRAr2uCfaQnqi6DTJEEbEkBGSU+S8=;
        b=w2whrt3PFYm1dFQePWOGHzxPrXlBl0wRsk0QC1kcktU/rNJyEoGA+Qw8MJz1NrWUEE
         szQRKg57QqjMgfkksvRCY+ubE9U4nOEa3joNnTy9aom2F5xF9BIjOCtn1XXMLv2oHbCe
         dNi31nRzVwuaj+dErBvx/YOX12labiiM5u7wLXgQ14qrHn5JKV1UwP3er45wUbN6BYQY
         j+AWcHtD+jYkfGyzOVdmI9+I7ZJLIikUz0eW9sqQMmzVOzwNf80vkqXMXhDh5gZ7f8DH
         yyDono/ApHH6sviznB3hLgARwXMU8uNm/83mWCa+8vwAYMspc3G+ZtHnBmBPvcsxpP2v
         M5pQ==
X-Gm-Message-State: AFqh2koCzZ2BxKI/v6ngc6YiuRPz5WORuYFrz1jW4dawt56jT06JQeg5
        2yU9eUTdkU+dfQlqXBYGatWa5ClI9cCCKB6MeEoUJmnTdfK30EB0F2aoMA==
X-Google-Smtp-Source: AMrXdXtPjTeEoOwC9Lky1FEzV3LJQCo+adKpQLLSbRYxZqkGT7ftEEPTUMNJEvGBkP2Q0W9BZG5dscHLvrnSELfJb1A=
X-Received: by 2002:a0c:90ef:0:b0:4e8:1593:e03d with SMTP id
 p102-20020a0c90ef000000b004e81593e03dmr525431qvp.90.1671788568178; Fri, 23
 Dec 2022 01:42:48 -0800 (PST)
MIME-Version: 1.0
References: <Y6UdvrhLjS0/8Oic@VM-66-53-centos> <9a73d8fb-8a73-f8db-2ca7-51bf67cbf659@linaro.org>
In-Reply-To: <9a73d8fb-8a73-f8db-2ca7-51bf67cbf659@linaro.org>
From:   ty <zonyitoo@gmail.com>
Date:   Fri, 23 Dec 2022 17:42:36 +0800
Message-ID: <CAMmci2UkBVaBgYMF8JaZkL==b9-0AB90VPGK7SNdNV5w5Zyzhg@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Wenhao Cui <lasstp5011@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Krzysztof,

Sorry, we do not know the process, this is our first contribution to
the Linux Kernel. There is no change since the last review of this
file.

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
12=E6=9C=8823=E6=97=A5=E5=91=A8=E4=BA=94 16:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On 23/12/2022 04:17, Yuteng Zhong wrote:
> > From: Wenhao Cui <lasstp5011@gmail.com>
> >
> > Add devicetree binding documentation for the EmbedFire LubanCat 1.
> >
> > Signed-off-by: Wenhao Cui <lasstp5011@gmail.com>
> > Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> > ---
>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However, there's no need to repost patches *only* to add the
> tags. The upstream maintainer will do that for acks received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submi=
tting-patches.rst#L540
>
> If a tag was not added on purpose, please state why and what changed.
>
>
> Best regards,
> Krzysztof
>
