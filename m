Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC817656569
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiLZWgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiLZWgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:36:04 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E260D60FD;
        Mon, 26 Dec 2022 14:35:55 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-14fb3809eaeso7875284fac.1;
        Mon, 26 Dec 2022 14:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXw9ffGM0STfm5nv2OP42rA/NLvK1bhEG4FMYvs1IJQ=;
        b=BmkbRxOaTn2INrqDp6S9y/hlVo0HfHP9lKviiRa8bRDohfFbYLJiq9tg9u3W+I0m00
         5cQkg7uIwdMdqH4m3iqHMyXKNGnk2S7M2kpaO6q1b+S2APYPlc4cp6I/IGkSHoZHgps9
         xw3JQ1QRVR+AmYW6hRIqAkc483Uiz7frayamuG6Heo9gR/9NZzVOYe0HMHVY06gFXaDN
         WDXxYHSfHkFULlTbPKZJSZ2bWpSDuQxPyi/E3kiZCJMsqkBCvWhx0TZBDtIMcKw0HRyX
         PkEteC7tGY0Bb45UVCN6XQyBuJqIH3O158PegrLmpIfz0X/pt7pBMmAgjBDgHFyuqYw4
         hkMQ==
X-Gm-Message-State: AFqh2kpD3knWuxy2EAnIXF9NdTjeugUZjf628ZeQ6VWoTKtyGuONlTCs
        p64kkDu4x+ig2yd9R7z2gdl4jKM3Kg==
X-Google-Smtp-Source: AMrXdXtqHkssymZkRQcOlIcbqWQOAhxG9xqARqlEjOUPU6wmQcC5aU0CYeWs3hZzRW6MUwM2J52mkg==
X-Received: by 2002:a05:6871:1c5:b0:14c:2aca:ac10 with SMTP id q5-20020a05687101c500b0014c2acaac10mr10626044oad.23.1672094155568;
        Mon, 26 Dec 2022 14:35:55 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id g17-20020a056870c15100b00148316f78fesm5441578oad.2.2022.12.26.14.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:35:55 -0800 (PST)
Received: (nullmailer pid 67156 invoked by uid 1000);
        Mon, 26 Dec 2022 21:53:14 -0000
Date:   Mon, 26 Dec 2022 15:53:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom,glink-edge: add GPR node
Message-ID: <167209158838.66981.1878172348789642636.robh@kernel.org>
References: <20221223132213.81273-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223132213.81273-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 14:22:13 +0100, Krzysztof Kozlowski wrote:
> The existing SM8450 DTS (and newer platforms) come with a "gpr" child node,
> not "apr":
> 
>   sm8450-sony-xperia-nagara-pdx224.dtb: remoteproc@30000000: glink-edge: Unevaluated properties are not allowed ('gpr' was unexpected)
>     From schema: Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,glink-edge.yaml  | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
