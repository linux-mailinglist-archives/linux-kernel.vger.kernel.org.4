Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8579665655B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiLZWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiLZWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:35:46 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30758B3F;
        Mon, 26 Dec 2022 14:35:45 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id i127so11155142oif.8;
        Mon, 26 Dec 2022 14:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4ApSjtRAd7NUBAMOZBQeHR7zx+4MVrnI7FOdbrq6Tw=;
        b=h4J5785nIYvQxeJ2XOCcGiSpnKztLb5n+dllTILGYZ/TpEfHwNn0iEt0z12aPB9bl0
         TS05h1rViyyPI5WYcR35Hot3mr6qg8vO4/Y3ToWy7G/dgUvm6BQaD44ii1kxU6vlTNxZ
         PNcPzr0VU0yUJJBvOMQAsULVqfX5mJZfCNIHeJ5ivec5U+e49mhMEmyoljvXYO3LWqZZ
         WgWMQu+uhn6TeLJzNuDyamJMb1BkP5BPKKFwvhjAafV4f12R9254fP2Iyhqw8bX2ijBF
         KqRGZfGxAsCmg4R6a9RyduJBn+8c/4JkG+VE7OD4uGrCscQF87MH8VdDztuikjB7YOHR
         epUA==
X-Gm-Message-State: AFqh2kpxDN/63G2MyAsnTVnKDe9PYHHwDNchcJjwmfVRwn7EzHPB8p0w
        g2GOQ/LiPcrLlsm5Cwi0rWpqBVdg/A==
X-Google-Smtp-Source: AMrXdXvbtLb/I70K+IYfJmWO68WdRK1FaecWtLoTCLVsSoRjX/3QepcJ1aHHcSpq0FsIjoJGjZ27vQ==
X-Received: by 2002:a05:6808:1509:b0:35f:cadb:a016 with SMTP id u9-20020a056808150900b0035fcadba016mr11647248oiw.6.1672094144451;
        Mon, 26 Dec 2022 14:35:44 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id b66-20020acab245000000b0035b4b6d1bbfsm5169012oif.28.2022.12.26.14.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:35:44 -0800 (PST)
Received: (nullmailer pid 63057 invoked by uid 1000);
        Mon, 26 Dec 2022 19:08:09 -0000
Date:   Mon, 26 Dec 2022 13:08:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: interconnect: split SC8280XP to own
 schema
Message-ID: <167208168673.62952.8370130996583092568.robh@kernel.org>
References: <20221223132040.80858-1-krzysztof.kozlowski@linaro.org>
 <20221223132040.80858-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223132040.80858-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 14:20:39 +0100, Krzysztof Kozlowski wrote:
> SC8280XP comes with interconnects without IO address space, so split it
> from common file for easier maintenancen and to fix warnings like:
> 
>   sc8280xp-lenovo-thinkpad-x13s.dtb: interconnect-mc-virt: 'reg' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      | 12 -----
>  .../interconnect/qcom,sc8280xp-rpmh.yaml      | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
