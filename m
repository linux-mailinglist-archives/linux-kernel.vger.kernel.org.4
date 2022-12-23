Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCE654BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLWDPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLWDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:15:33 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49856420;
        Thu, 22 Dec 2022 19:15:29 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a16so2878240qtw.10;
        Thu, 22 Dec 2022 19:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxQegkkj9vwcwQmlgiRBZpmPiXXLL04ENPvh1dXocQQ=;
        b=Oi1gbFOMd7AGH3Wy/1i0ZJfmpR7cCPmMKckDRTRVtpt9LB88Rov3ZAyQEEgzRuUHws
         pnjJvZGFQ5x2RF7JI1rAZFUNCZzF55KBmb5orCpjKAqMp9mef1OhUx9nLblahwQNxhWp
         Zvdh+8oZK/J75N3T0aXJoiLFw7ABU8bhxgkN98RXh8WOpxri0joB4iqfWaOYKviFMyvz
         6TRLyeKlm5Jlu391C9FgxRDzakxvailmnba3SBcxgtMt4Q1WWtS0H4g7tI062ECUtIpY
         0IMo4c9potFMO2qoouBowCOlXg4jI+6qSEC3ZiocDm9AcLqJYbhHmV+zUDTWQtkRoqiU
         NGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxQegkkj9vwcwQmlgiRBZpmPiXXLL04ENPvh1dXocQQ=;
        b=EopGP0qR8JAd+lQOP2ad1pKbfk7KqVl0IKLuMmfbbJGuQGV5kotDXxKzah73LSDFaN
         E+T5KJ19dsqM22EwjPoxOv+UUcuf6qfMkSsRuqaat+Pr3iffZ3IkUXEw0hFShqkiKISy
         skN3fHvMYOxZ9e3SK3apgrcMGR0nfLXVBMvpq4zTQaTfBc+6nImSTGKCrJ/2b6Y4mWTD
         +14DW0L9htibqiYaPgcDhkWYtLxuFiWoesIaPgkhoqZa7p6X9vd1tSQB72G2jwS0vCNj
         9UPczRFf+CCrvURVbx7HElsFIw+qfiMpENBxijjlbRyLUkuylJQACANjamD8u5ebVjqI
         /OLg==
X-Gm-Message-State: AFqh2kqPJLo7Dtt2XZBTQmhjIxap9AwpNL3TZitf0oPwlpPa6cDal8Nh
        gVIFheHQ3Ujz/hIDoYV9Taztpm+QKZYNX8yYkOE=
X-Google-Smtp-Source: AMrXdXuGcr52bZ3FYkEdkWSYIjWZOP1Sfqc+3hwoASjeqB+nGprCuax5vNJKAX/uBVkFlq6T8nfmZ+8GKpdUHnCLQDc=
X-Received: by 2002:ac8:7a84:0:b0:3a9:8370:63d7 with SMTP id
 x4-20020ac87a84000000b003a9837063d7mr367489qtr.362.1671765329015; Thu, 22 Dec
 2022 19:15:29 -0800 (PST)
MIME-Version: 1.0
References: <Y6UXjiQpMFHQkXJ1@VM-66-53-centos> <Y6UXyMVDu8ZRFvJ5@VM-66-53-centos>
In-Reply-To: <Y6UXyMVDu8ZRFvJ5@VM-66-53-centos>
From:   ty <zonyitoo@gmail.com>
Date:   Fri, 23 Dec 2022 11:15:17 +0800
Message-ID: <CAMmci2URht+NBfkLxebGTPMKtHEC8eUu6gRUA1QbD4D044B30g@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] dt-bindings: vendor-prefixes: Document EmbedFire
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
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

We just noticed that all the other .dts files in rockchip didn't have
@copyright comment block. So we decided to remove it in V9.

Yuteng Zhong <zonyitoo@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=94 10:51=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Wenhao Cui <lasstp5011@gmail.com>
>
> EmbedFire is a manufacturer of embed computers and education platform for
> embed devices from Dongguan.
>
> Add vendor prefix for it.
>
> Signed-off-by: Wenhao Cui <lasstp5011@gmail.com>
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 00493b962bd7..0f04ee30bdc2 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -396,6 +396,8 @@ patternProperties:
>      description: Elimo Engineering Ltd.
>    "^elpida,.*":
>      description: Elpida Memory, Inc.
> +  "^embedfire,.*":
> +    description: Dongguan EmbedFire Electronic Technology Co., Ltd.
>    "^embest,.*":
>      description: Shenzhen Embest Technology Co., Ltd.
>    "^emlid,.*":
> --
> 2.27.0
>
