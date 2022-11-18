Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E962F535
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241919AbiKRMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbiKRMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:42:16 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F58CFD2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:42:14 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id y18so1661279uae.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lR6xTYRY7MgkfHig5h9+QBVHckUH85lhudbs/NLAfWU=;
        b=aSWpS3mKYDiCnOkBIsX+22S6pBFOEOgidnAmfkAVD+J2aGHAvlVyr5NsEQISwtWry1
         s714L0cDxT4dIUjWZ26hqjYEf41F0jlvnyFp3tmJ+tNGIkqwsF0iBSgiBwzirjV8BEFW
         3OsAZhXsf6/XNSUVkenujcjaqGH7kB0ROyfh79OYDAtjK3Jm/c1cXe/6Buoo5C9VLBTW
         QTUzrWzvhC+ZRVSCHdEwXukGYQ2Pnl5w8H9OFaw90jnI5qRNpQ9ew6Y/cVB00RwbOUe+
         IJoBozL1RkfQkEbQe4e8BiHKWg6EyHiu/2DORvSGYtSNyYqtTBtjS9s0aLxJZv5sP1Nk
         WfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR6xTYRY7MgkfHig5h9+QBVHckUH85lhudbs/NLAfWU=;
        b=gpriHojZUGM2jiThV1JSc/UcuojMT4+eZ0R9M5qbwlHkSK+HA8QToh1p5TbJ/JvJBe
         ntEbyLDNMuh+id7mA4QuwZDnniHsEJzn6f/FPRsyFx5oJYYBO5Pqq/JVgvorW+4Pkupr
         TNwLA3gzOnGmYenqO3P7vnj2mXqOoc13qfVpJ5OJMmriCKPtkCt2CAmxsQvGGsS6gbTc
         CPSiV6nZvSZUPABbuBeHSNC0qfXwH+wF11t1MLXgFgozbiSX98QSDlKMC8NiEOwBpiIS
         hh69LFday1+77vSWC6giu5VjXJJhWKjF8AccHVQBvP8zO+QC+Ha7tUIt1fGDjvjWNt2R
         g77A==
X-Gm-Message-State: ANoB5pmRSndX/79NraLPTXvMbGIDSVGKEN77TgFfIdiHAFmhAKUxpLQv
        RqmuP6CuX/nFkGxKtcalpfz09DLoSE0/pti6tj0D31e+Ty8jsA==
X-Google-Smtp-Source: AA0mqf7mGBV/TWyE4B8wNnzY/00pkB9i2ya3rMZZIkqwL+3LlYjws14OhWdWW2FOvqapZnlxd62JQdHqdYPgEw1XNiY=
X-Received: by 2002:ab0:6caa:0:b0:409:a03b:1bbb with SMTP id
 j10-20020ab06caa000000b00409a03b1bbbmr3840981uaa.55.1668775333718; Fri, 18
 Nov 2022 04:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
In-Reply-To: <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 18 Nov 2022 04:42:02 -0800
Message-ID: <CABXOdTfB9DA1LX3qj4QiHdTuJwV_OnP3eUEyTUvHzX3L3jnkNA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] dt-bindings: mfd: Add DT compatible string "google,cros_ec_uart"
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:49 AM Mark Hasemeyer <markhas@chromium.org> wrote:
>
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/cros_ec.txt
>

This is now google,cros-ec.yaml

Guenter

> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
>
> Changes in v7:
> - No change
>
> Changes in v6:
> - No change
>
> Changes in v5:
> - No change
>
> Changes in v4:
> - Changes in commit message.
>
> Changes in v3:
> - Rebased changes on google,cros-ec.yaml
>
> Changes in v2:
> - No change
>
> ---
>  .../devicetree/bindings/mfd/google,cros-ec.yaml       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 04962bb29576e..26787e4574b8d 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -28,6 +28,9 @@ properties:
>        - description:
>            For implementations of the EC is connected through RPMSG.
>          const: google,cros-ec-rpmsg
> +      - description:
> +          For implementations of the EC is connected through UART.
> +        const: google,cros-ec-uart
>
>    controller-data:
>      description:
> @@ -222,4 +225,12 @@ examples:
>              compatible = "google,cros-ec-rpmsg";
>          };
>      };
> +
> +  # Example for UART
> +  - |
> +    uart0 {
> +        cros-ec {
> +            compatible = "google,cros-ec-uart";
> +        };
> +    };
>  ...
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
