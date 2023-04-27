Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7C6F0646
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbjD0M7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243467AbjD0M7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:59:14 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D340114;
        Thu, 27 Apr 2023 05:59:13 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-187ba2311b7so6798381fac.1;
        Thu, 27 Apr 2023 05:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682600352; x=1685192352;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUbPdbUEVpRefm2WfWskYSbK+SXXTuHP7NPaiEMvPts=;
        b=A73eeN/W8yDdt2Zi6OmWVrtgU7rFihEgYZyOLOLDajwSN6GHClEm2d1oX+wJHER3ru
         kXUQBLTtdym8Iv6CmK2vebjOT/cGgWeQx4gooYEWEVQLBR8UZFmhJlGiypuMdELn682Q
         /swhS72dzf0dD/GhplQy5yF8s8AkiRHiI0SZnJSLC/N3ZvYQU8JUHlLVypwLPVIgcKQ5
         j/Y0s8xMrFmDcdMD21I7AcvQ20ByIS1ZLV40t/Xt7QJqhCI7R/DcWhd9loxEmPNFibWB
         ObxFCKHFt8PM+w0RhiJsyS6T188x4ThwGvE71E2D2MhunEroSvuNjzCc9hQujNtosfdx
         mHQA==
X-Gm-Message-State: AC+VfDxKiYqH4WwGEFpXSwgWz3yPNSHASn+RmHlA1QCNABcYH8mnwEYX
        lHp19IkGRK6S5hxChAl36w==
X-Google-Smtp-Source: ACHHUZ52RxEUsGzJRl0FVcWtJTnOarMAM4mqAjabzs0f9nVhPzVogtD3GWscFZ0vmQl9W64kv0mFEQ==
X-Received: by 2002:a05:6870:e151:b0:184:534f:5e7 with SMTP id z17-20020a056870e15100b00184534f05e7mr716676oaa.35.1682600352377;
        Thu, 27 Apr 2023 05:59:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x12-20020a056820104c00b00524f381f681sm6239540oot.27.2023.04.27.05.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:59:11 -0700 (PDT)
Received: (nullmailer pid 2812630 invoked by uid 1000);
        Thu, 27 Apr 2023 12:59:10 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        coresight@lists.linaro.org, andersson@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hao Zhang <quic_hazha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1682586037-25973-2-git-send-email-quic_taozha@quicinc.com>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-2-git-send-email-quic_taozha@quicinc.com>
Message-Id: <168259999089.2806154.10932222963358704695.robh@kernel.org>
Subject: Re: [PATCH v4 01/11] dt-bindings: arm: Add support for DSB element
 size
Date:   Thu, 27 Apr 2023 07:59:10 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Apr 2023 17:00:27 +0800, Tao Zhang wrote:
> Add property "qcom,dsb-elem-size" to support DSB(Discrete Single
> Bit) element for TPDM. The associated aggregator will read this
> size before it is enabled. DSB element size currently only
> supports 32-bit and 64-bit.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
qcom,dsb-element-size: size (1) error for type uint32
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.example.dtb: tpdm@684c000: qcom,dsb-element-size: size is 8, expected 32
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1682586037-25973-2-git-send-email-quic_taozha@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

