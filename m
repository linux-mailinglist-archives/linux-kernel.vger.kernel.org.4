Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315C690FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjBISCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBISCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:02:33 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F146643CF;
        Thu,  9 Feb 2023 10:02:32 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id r28so2344013oiw.3;
        Thu, 09 Feb 2023 10:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA1BMgoBUMPK4Fv3/YkttuqvtmSbXk4QpQvMxXNCVt4=;
        b=M/vRO0ixOS7aSJOmvtqsLoxF8GboU2oUvH1b4tT8+igqxU6qvRz/RlnokY2FoPt56Q
         5VB/pcSgOBkWdxwEY93lQ94Vtf4bzf1QkF+biyxtkuN7r0xFJQpOxg5C4sLrNv1BlXl9
         8pJKx7PCUaQpTrpn2kZztYQs39rT/MCtYooHaO//xUOoQOjLP1qIWLcuR56n99X787Pv
         Td6Wf0uc17qDz5+hPG9C+JuegWXWKbvKjh363/KU1P6kNbJsJAyAQqN2TUIJw5N28p6m
         37e2jVl4CaiQj+U3BFWfoscmFiAXrjUcmzbrQXXcB1uEt2ZmBLJ0U+6VQWxaHJ5fahjP
         HkFA==
X-Gm-Message-State: AO0yUKXyaaqt6GhdMYqmvWUxaiPBUHWnCzVFiv7PLzhNeOZaQeCibeaI
        iACaI8AcsOgpmCfdbY4HiA==
X-Google-Smtp-Source: AK7set8/+orLwLC0A2fdfoIW91wVKgjaxIZt554CgMzROCCxAQMHvSVN0rT+gmq8t0cm9l0/2tROrw==
X-Received: by 2002:a05:6808:404a:b0:378:7dbd:6da7 with SMTP id cz10-20020a056808404a00b003787dbd6da7mr2354980oib.29.1675965751187;
        Thu, 09 Feb 2023 10:02:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p206-20020aca5bd7000000b0037b364fae4bsm1113691oib.46.2023.02.09.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:02:30 -0800 (PST)
Received: (nullmailer pid 574139 invoked by uid 1000);
        Thu, 09 Feb 2023 18:02:29 -0000
Date:   Thu, 9 Feb 2023 12:02:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] dt-bindings: soc: qcom,apr: correct qcom,intents
 type
Message-ID: <167596574944.574100.7128831798483239165.robh@kernel.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
 <20230208101545.45711-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208101545.45711-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 11:15:43 +0100, Krzysztof Kozlowski wrote:
> The qcom,intents property is a list of pairs, thus it should be defined
> as uint32-matrix.
> 
> Fixes: b2d7616e13c4 ("dt-bindings: soc: qcom: apr: add missing properties")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

