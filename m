Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4187165656C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiLZWge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiLZWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:36:07 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D473110C0;
        Mon, 26 Dec 2022 14:36:00 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so7302257oto.5;
        Mon, 26 Dec 2022 14:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj9ILcg+bOogopqPB7nsta4PBD3Nt/3ZcFqMZXwiVHA=;
        b=nxy5NSKl7M3k2lwMI8+92FjaN1YyeiqRm9LDbRUjpnxJgtNXiuNfkOXFxEGkM1D9wv
         3s2NhjuP3C7Z67vNsaG/AoJXWt0aJOvcAYRU0zU7pViTD/KqvU4QkSqkhvLcopSt51Gk
         g7TTkf63ksZptJuZduTYPxybir66kWSWBMEitQCQ6rCBUgsSBGulKcGu1sNsWctGnnIK
         SFcJpyUnqKu5zNKw61czDvqJe91hkTuDxeTVS6GKLPUWggidwL+7hfP4JkVYOvhgNehz
         lfpVSNwtbQ4NJwrb0/ppJiiQdnvrvkPTAZ/ICbvlGQrjeOmX1RMO7LuaSzpbNOT3k9CE
         cNRA==
X-Gm-Message-State: AFqh2kr8tAxQt+DLSuBET13JhVgQDGvfFdPFcS4o2WWZJEXU78vOa79J
        eEPNqJ4lXt/VCeYUVl0fGA==
X-Google-Smtp-Source: AMrXdXuUKd9iWApMElBZHyqgOah61WNUz7iZJN/YCH14LXn6Be+G7ggj7P0yhLekXDl67qWKKVPX4w==
X-Received: by 2002:a9d:73ca:0:b0:66a:ea19:28ea with SMTP id m10-20020a9d73ca000000b0066aea1928eamr12596982otk.38.1672094160197;
        Mon, 26 Dec 2022 14:36:00 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id q17-20020a05683022d100b0066e67925addsm5840174otc.26.2022.12.26.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:35:59 -0800 (PST)
Received: (nullmailer pid 61940 invoked by uid 1000);
        Mon, 26 Dec 2022 19:07:12 -0000
Date:   Mon, 26 Dec 2022 13:07:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: split SC7280 to own schema
Message-ID: <167208163047.61869.6167467313153334331.robh@kernel.org>
References: <20221223132040.80858-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223132040.80858-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 14:20:38 +0100, Krzysztof Kozlowski wrote:
> SC7280 comes with interconnects having and missing IO address space, so
> split it from common file for easier maintenancen and to fix warnings like:
> 
>   sc7280-herobrine-crd.dtb: interconnect: 'reg' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      | 12 ----
>  .../interconnect/qcom,sc7280-rpmh.yaml        | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
