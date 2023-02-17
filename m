Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BCE69B658
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 00:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBQXOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 18:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBQXOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 18:14:43 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC65A552AA;
        Fri, 17 Feb 2023 15:14:19 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id m6-20020a4ac686000000b0051f842ba672so226155ooq.4;
        Fri, 17 Feb 2023 15:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQHoZdZQsb0tbRh6zJhe3Ee112VgPcERiRLHL7uWCfI=;
        b=D9qKdIxP6r+Q0e6DWoSA+zz3rjNP9CT+qlx7dfYOKVQ3vLyTQQ5iTh3vFBxbqV8b0b
         B1qQprkwUjwjrDS1NIOgT0E4I1zJknnhaMbT+Nz/QdtwMoxUo4h5xksy9kMbDw2ba/sF
         c7gtvzoJqAhMXpy+opNh9mR9NCIoELRqn7sETyqSNRstpV/GzsFBKOZpGyTzoOxKJhKa
         nRqozj0Nj/EKVd9iN3trJRsvaHzOgFZSQFvxRdSfdEUDLU2w29aKLwwC7HR5WDq+m6f2
         cz2E4equLSyJnuXmYiqMm65mf5Q4N9QXoWAVRocY2MawvqI8s6eDwuWWuxjJ8lH3GIuy
         WJeQ==
X-Gm-Message-State: AO0yUKWZlUVbFmnbXOzNH5YBcvTj37suyOdejlGh4Kze/KCqpCfd1gxe
        K7KrKfZ8Z0zXYkVI3qcsGCqDB7M/Cw==
X-Google-Smtp-Source: AK7set+CeDzb7BytS+6adQqOOA+3tgP8LOA6jxUsKLTuW/NJoi4x/MIxM1bhqcnMWLMWimw65Q9G2g==
X-Received: by 2002:a4a:450e:0:b0:49f:8941:ffed with SMTP id y14-20020a4a450e000000b0049f8941ffedmr1571764ooa.9.1676675611946;
        Fri, 17 Feb 2023 15:13:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y2-20020a4ad642000000b0051ff746e2b2sm1968972oos.8.2023.02.17.15.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 15:13:31 -0800 (PST)
Received: (nullmailer pid 2241205 invoked by uid 1000);
        Fri, 17 Feb 2023 23:13:30 -0000
Date:   Fri, 17 Feb 2023 17:13:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 2/6] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
Message-ID: <20230217231330.GA2238521-robh@kernel.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-2-67aed8fdfa61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217-topic-cpr3h-v10-2-67aed8fdfa61@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:08:25PM +0100, Konrad Dybcio wrote:
> CPR3 and newer can be fed per-OPP voltage adjustment values for both
> open- and closed-loop paths to make better decisions about settling
> on the final voltage offset target. Document these properties.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> index a30ef93213c0..93cc88434dfe 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> @@ -34,6 +34,20 @@ patternProperties:
>          minItems: 1
>          maxItems: 2
>  
> +      qcom,opp-cloop-vadj:
> +        description: |
> +          A value representing the closed-loop voltage adjustment value

A value?

> +          associated with this OPP node.
> +        $ref: /schemas/types.yaml#/definitions/int32-array
> +        maxItems: 2

Or 2 values?

> +
> +      qcom,opp-oloop-vadj:
> +        description: |
> +          A value representing the open-loop voltage adjustment value
> +          associated with this OPP node.
> +        $ref: /schemas/types.yaml#/definitions/int32-array
> +        maxItems: 2
> +
>      required:
>        - opp-level
>        - qcom,opp-fuse-level
> 
> -- 
> 2.39.1
> 
