Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3959650935
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiLSJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLSJOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:14:31 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45917DF4;
        Mon, 19 Dec 2022 01:14:27 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id c184so8078941vsc.3;
        Mon, 19 Dec 2022 01:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R498GalAx5g2v+OpJ0kZs8i4YXUH9AVwRADu/ussHBU=;
        b=BXxScbMnTN1Xt/GFEMWJuIbosQfmu1FKTPjTwFmBKMyiRUZFKLENErPvwGjHmxP52k
         EgQbX8R5nf4SFitljRS8USe3ugJWMdA+7LR7K+JSrCTZIs17o1RAxBYRbiyNeMkoXt+Z
         crDWtp2zECCZyPPV20FmLGEjHTRqxHrIWXLPSvr3Kl1umOfJR+v3rLVEWftMEo6eb0dy
         tWu39Gk1QKYUgDSmIQ4m6Wdg3mEICgsI+0WCYs/etpmSFZI8nsCeOF/I/5+CJRwqk9Ls
         b1uLaGhkVYsWNAUtA0DEUOpgkISS5Dwapxa2jaGq6PHofhYiuzW8j6GEtVswcz/q5+io
         E/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R498GalAx5g2v+OpJ0kZs8i4YXUH9AVwRADu/ussHBU=;
        b=KaSfiZOn7z/mrl2DCtS4SqAI5futvNwVSdf7bGoeCPCECy86fXBs3hRu5FQe7RcUxb
         JTod4NwSBc7Vr/RDladfhMF2sRWejWY1d2oPs0GgYUUCyHFS2MoSu7/BPmsyobXMI+GI
         uEus1mfXs81GG+l926SAJM1MFvNLT8w6B+NitkZsph8rqBbVuAhPhz0b48WkoJcRPkT7
         H9ZOby1yPQqZJEG3xnDwkzzUkshM6fk7gXjUVhyTmocHGArI9HyWM7oekGvRo1X0YTDA
         CNHoCUQdQEvj6RSwBBnQsabTsPnLHoCbQasH7OjIH8293Bo8ZBP69ls2hVcwT/UAVEY6
         GePA==
X-Gm-Message-State: ANoB5plduOyvrcO0A696c7SJva1vXPo+Mp4WAJUnZAT4LeZ0AN5ZyyAn
        uQCnQlV3SjDXH7wnalzl7po/BZxhSxT6fk1Xcqs=
X-Google-Smtp-Source: AA0mqf4pHgdRDNBlqlXzOi8tOkDbR8WYG3O43LofQCy3K4Dlheg0F0ydyONHOCBC4gv/z8571Mz5x6punNdN5h4C9eQ=
X-Received: by 2002:a05:6102:11e3:b0:3b5:1fe4:f1c2 with SMTP id
 e3-20020a05610211e300b003b51fe4f1c2mr2761076vsg.0.1671441266429; Mon, 19 Dec
 2022 01:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-15-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-15-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Mon, 19 Dec 2022 10:14:10 +0100
Message-ID: <CAH+2xPAWo=nycQMLrjye8i3a3textJdyYJcWRG3Jq-tbN0a9RA@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] dt-bindings: rtc: pcf2127: add PCF2131
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Add support for new NXP RTC PCF2131.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> index cde7b1675ead..a8f8c23da4d8 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> @@ -14,7 +14,9 @@ maintainers:
>
>  properties:
>    compatible:
> -    const: nxp,pcf2127
> +    enum:
> +      - nxp,pcf2127
> +      - nxp,pcf2131

The enum is incomplete as pcf2127_of_match struct also contains:
nxp,pcf2129
ncp,pca2129

/Bruno

>
>    reg:
>      maxItems: 1
> --
> 2.30.2
>
