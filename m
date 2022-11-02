Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB7616420
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKBNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:55:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC31A29CB2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 06:55:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k8so24688436wrh.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=liIWxgnrKB54svAZTpFgbikolxVnlfVc0BGgGZkfhjg=;
        b=Z9Y0jFYRdBXTbT/NsetraCzA6Hx/LsJK8GvYTwmGE7/44i5Dos9kQhq4dyTmyLbP+6
         PfJdJNfxHY4KFvT+XX97pojpx1ufh/8Up64nZcKAmyVqDq9nzPOgtGzG5PmE9V/LgW1w
         /EU7qjBFX04dYaGRArio8gk19Cbw5xbsAxtxNqXmxXtBhtwVP6atTXX1ui3h/Gnt13BM
         0O6/r05ywa3CbkZ4NmLrSxi4aFxbDJHoDSSdzzatYfCldit1bn+1ZLyxrOjXZ95qmoJM
         MHubLiH2tyKfgaRnLU6RoJgmbm7q3SgwNBVfpatEPe4Cyu3hutzQ2QTT40rAfcis7qPh
         C9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liIWxgnrKB54svAZTpFgbikolxVnlfVc0BGgGZkfhjg=;
        b=kaEMNAkfn5RHjeLy8VNTqKnLfTgUWCbWBwR9LAEj8pVgfzaFQYKUvwLUxcsAQswE47
         OPQ2TyYC+V+t2pt6m0HvKMziMRuYlvpxP7zmxxyuUHkalC+nM2s0Qjo74yRZg4F2x/Dj
         EqTUxA0z64y8HaryVY4iatwVRj0kH2uOAIcYR8ieN1DbFNuidOpH4f+WPCLAyjSU4u+b
         PG3Z6OOf2WJy5piBSzmcAZ/Gt5tVUYNs5Za+AqMR2doRnVYoKP2yzw8sz5/gt/PUcWge
         AU/xzmwZrYjQyTnQbNTmF09RN5411fkMZtqcBprljE8Vjlh5Y05/TESR8cWpGi5fjR3n
         5Smg==
X-Gm-Message-State: ACrzQf2bM3dz7Rs9dWEgHyxiolY2N56IPCnR715weqidW8kT/ljAKsdd
        SVI06lyRLtStdgR+6dkPcGhXRw==
X-Google-Smtp-Source: AMsMyM402qsrhIO6ldQJS2gMhEnDQv3oqTkbMUS2+MeWiGtoJh42ic09+34ohyg5+1+SYhUV3rE4KA==
X-Received: by 2002:a5d:598d:0:b0:236:8ef5:867d with SMTP id n13-20020a5d598d000000b002368ef5867dmr14927482wri.162.1667397320480;
        Wed, 02 Nov 2022 06:55:20 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b9-20020a5d45c9000000b0022e36c1113fsm12491311wrs.13.2022.11.02.06.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 06:55:20 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:55:18 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: qcom-wled: Add PMI8950
 compatible
Message-ID: <Y2J2xp9w4Hvethb7@maple.lan>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101161801.1058969-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 05:17:59PM +0100, Luca Weiss wrote:
> Document the compatible for the wled block found in PMI8950.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

FWIW:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Changes since v2:
> * New patch
>
>  Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> index 4c15693f7a01..5ac8605a53b1 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,pm8941-wled
> +      - qcom,pmi8950-wled
>        - qcom,pmi8994-wled
>        - qcom,pmi8998-wled
>        - qcom,pm660l-wled
> --
> 2.38.1
>
