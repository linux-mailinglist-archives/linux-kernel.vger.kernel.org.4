Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186A3690FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBISDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjBISDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:03:03 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83E1643D3;
        Thu,  9 Feb 2023 10:03:01 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id t5so2355337oiw.1;
        Thu, 09 Feb 2023 10:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GWButciOdTQmPQNWu+absQxevMPXBHSKEIz/7eDRTw=;
        b=5fCpiltb3r1q3rQDyE6ySJnZ1zXwUJ9DP+3TOG1SUWVBmWlic0eLtcdtygqSTFmO50
         36eEN9aopiYKXgN1PI9+ciB+zz0i3GvH1+RIF5Al/j/R+2aXnVLhE+cKMprekeYtRTyx
         b4Ymm/sZArxEIM07h14O1Xwy4vUNeBxHFTMGoCUgSRQ5DEJ0kkxAkKlACO6Z3U90oJwo
         5kSKedD5uu3hPlf7dpzdWBz9dM7esrkQ4sWrwzafIAhTaJ7AwjyFpMSA+0kV8PhX/e7L
         NWurwNXFcm9unIqlrdaZkC0q9as4TkuTX42eM8gPy5AEcB//woGeYEsjdXy4q3xC5hqr
         qEFQ==
X-Gm-Message-State: AO0yUKVET/DpAVTkV6QJI8ufhb9dojpuyKmzmWkuTLHzZreEXccNFFU1
        fBUD4vHtgrvjY0rJMlcUbQ==
X-Google-Smtp-Source: AK7set/roABBLCKcG2y9Jt/CeACCdwlHN9T2hjBxB2z+Euhp4uhhi4C/KEYPUGCu4QL1LGuhG/wqBQ==
X-Received: by 2002:a05:6808:3c8:b0:378:9d08:5d34 with SMTP id o8-20020a05680803c800b003789d085d34mr2756697oie.8.1675965780037;
        Thu, 09 Feb 2023 10:03:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i126-20020acaea84000000b0037887ca2150sm1115203oih.22.2023.02.09.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:02:59 -0800 (PST)
Received: (nullmailer pid 574768 invoked by uid 1000);
        Thu, 09 Feb 2023 18:02:58 -0000
Date:   Thu, 9 Feb 2023 12:02:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        alsa-devel@alsa-project.org, linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] dt-bindings: remoteproc: qcom,glink-rpm-edge:
 convert to DT schema
Message-ID: <167596577843.574719.5700574756224769106.robh@kernel.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
 <20230208101545.45711-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208101545.45711-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 11:15:44 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm G-Link RPM edge binding to DT schema.  Move it to
> remoteproc as it better suits the purpose - communication channel with
> remote processor.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. :: -> :
> 2. Correct qcom,intents type.
> 
> There are no strict dependencies on other patches, but the previous
> "qcom,apcs-kpss-global" should end up in the same cycle (or earlier) as
> this one.
> ---
>  .../remoteproc/qcom,glink-rpm-edge.yaml       | 99 +++++++++++++++++++
>  .../bindings/soc/qcom/qcom,glink.txt          | 94 ------------------
>  2 files changed, 99 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> 

Acked-by: Rob Herring <robh@kernel.org>

