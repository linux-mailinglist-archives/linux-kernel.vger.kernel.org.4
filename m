Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E361111C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJ1MUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJ1MUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:20:18 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814231EE0;
        Fri, 28 Oct 2022 05:20:10 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso2884112otb.2;
        Fri, 28 Oct 2022 05:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwwUKBJK2ts9JQbEn+aT2R7CdnRNl0fVI6fqIamBwNM=;
        b=4cqLckJXKqYBpKCyYNC6z5COApqWnQXn0mMNAziNtUChVIamMmyDjW0R/5giF8ivm8
         bqj/KB0w54vNSoernqJ6VSxYKKddKZcRQmV/COmjGqBVOtGZBKaRz0LGEuMivxdglFgu
         xzdPNUHvtoZFsIvkKO/PFfDwUrBlj9YP9RIpgWkvWv8sooZhLL8uxIoDW2o6cfiMEWg7
         AeoyczUU7erPhFElDIeF1cnn7kDBHeeSjNkyUa9cMg5mWRji1Uz+nQAN7vWzd0sviBFe
         1pQy/Fq38/lyP5Mcn/xML8aTz1SH1uah7BYPI4IQPjLEDjCfqEeDW5AHB+cBBkwn55rB
         fEtg==
X-Gm-Message-State: ACrzQf25fjaTc5RMhn4i12ELLvN0P4u6erSvf5zxygWXE0ULo8S0y1kT
        pHnU7D9KXe/gG85tTy+ctQYcQPj9dg==
X-Google-Smtp-Source: AMsMyM61gDqPCsm78gUOyWJAjboELdy4Wi9sePZ0bD4E8MIGa1EEc2Wy1l9L2JynMsaYNH1jsAljrQ==
X-Received: by 2002:a05:6830:368c:b0:660:ece0:ce33 with SMTP id bk12-20020a056830368c00b00660ece0ce33mr26535851otb.146.1666959609714;
        Fri, 28 Oct 2022 05:20:09 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w30-20020a056870b39e00b0012b298699dbsm2039684oap.1.2022.10.28.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:20:09 -0700 (PDT)
Received: (nullmailer pid 1079531 invoked by uid 1000);
        Fri, 28 Oct 2022 12:20:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
In-Reply-To: <20221028034155.5580-6-quic_bjorande@quicinc.com>
References: <20221028034155.5580-1-quic_bjorande@quicinc.com> <20221028034155.5580-6-quic_bjorande@quicinc.com>
Message-Id: <166695949085.1076887.9913893260550976176.robh@kernel.org>
Subject: Re: [PATCH 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3 compatibles
Date:   Fri, 28 Oct 2022 07:20:05 -0500
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

On Thu, 27 Oct 2022 20:41:50 -0700, Bjorn Andersson wrote:
> Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
> introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  .../bindings/interconnect/qcom,osm-l3.yaml    | 22 +++++++++++++------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml:27:7: [error] duplication of key "items" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/interconnect/qcom,osm-l3.example.dts'
Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml:27:7: found duplicate key "items" with value "[]" (original value: "[]")
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/interconnect/qcom,osm-l3.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml:27:7: found duplicate key "items" with value "[]" (original value: "[]")
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml: ignoring, error parsing file
make: *** [Makefile:1492: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

