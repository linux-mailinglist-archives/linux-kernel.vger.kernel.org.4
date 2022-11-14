Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0754B628244
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbiKNOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiKNOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:19:57 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229B26563;
        Mon, 14 Nov 2022 06:19:56 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so12629702fac.1;
        Mon, 14 Nov 2022 06:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T363VWdQ5ocnDSQ5x4Cz3XrYjoogVZHJUwppT1WNaYs=;
        b=fPC7iIMJGuU1X4mMWkcTFVHs+WXS4aXNtMie5HaniXUltcXU0rIa/bdKaIo88gRKI6
         ELVeftegAMTj4qk6xGN6Hnp6rLjimeHv8L/ujO8YvJzg8V5TictttbUlqoX2QF/DGibR
         tTT2MZiSIP9xOxE1hUDeXYxxQj8T7rD62eRdeWusD6yozuo/6Ql6oO5ldTERq9jHSv3V
         z6iM3iHlQVA8uLOTTnS19Y4yFfsdGrCCJBMAkiz3jhecboe4jmMJzAtGBPGgaAcdcavk
         hvt07XTAPFK3zwaJv5GBpjCBwOxfgQJ0oH499eVGSTbTkhNkjtMbntxLboavfrwskneA
         Xbvg==
X-Gm-Message-State: ANoB5pncwS1bjXX2pbXiD98gAwyBeDC30Am1X5vEYx2CkEBJJGk8hJ6D
        yF0EncHityHCRYjeE25RCHUC0r0ksg==
X-Google-Smtp-Source: AA0mqf5YD2ya3ZXS0A73Y8ieA+ETvdMBfmcetHL50rNO1AXEo7hvIHk3FznZiOxaGoOQxPiD6GLxBg==
X-Received: by 2002:a05:6870:8dc3:b0:13b:b3b7:1082 with SMTP id lq3-20020a0568708dc300b0013bb3b71082mr7186742oab.71.1668435595440;
        Mon, 14 Nov 2022 06:19:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h3-20020a9d7983000000b0063b24357269sm4138272otm.13.2022.11.14.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:19:54 -0800 (PST)
Received: (nullmailer pid 2686451 invoked by uid 1000);
        Mon, 14 Nov 2022 14:19:56 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, patches@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
In-Reply-To: <20221114104222.36329-2-konrad.dybcio@linaro.org>
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
 <20221114104222.36329-2-konrad.dybcio@linaro.org>
Message-Id: <166843545485.2679805.16057396300948126713.robh@kernel.org>
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
Date:   Mon, 14 Nov 2022 08:19:56 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Nov 2022 11:42:14 +0100, Konrad Dybcio wrote:
> Some SMMUs require that a vote is held on as much as 3 separate PDs
> (hello Qualcomm). Allow it in bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes since v1:
> - Add minItems
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu.yaml: properties:power-domains:minItems: 0 is less than the minimum of 1
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iommu/arm,smmu.yaml: properties:power-domains: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 was expected
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	0 is less than the minimum of 1
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/power-domain.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

