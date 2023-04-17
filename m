Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369866E4988
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjDQNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDQNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:11:34 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FBEBB87;
        Mon, 17 Apr 2023 06:10:59 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id a7so3001896oiw.7;
        Mon, 17 Apr 2023 06:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737034; x=1684329034;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jBonPjm6hFR6zSrloV8u7ZAY904Aai0PvZoTRlUcPtA=;
        b=R8qMcuw/CmlG+BivBAlUKA0dSOJTMpqp9ilLjplda1RebQpBogOqxiJwkHiN96g9yI
         K0OU/Sk9engmF8RzAIAaiH0S+jaoYC10NUYRur2cCOWq9dl4W6STbLhDO1AccfUm5lzj
         n+MelB009qOZ9m37DsG9DWdNhsmrnvkyEOXuToztKBX/hJldIDrOqCJnOtaElsQsSZyt
         odELxyYIa1iXYQEFOk4GZPT/b7aEdZPBC5PJOsxSgHpABisFD49OnyNhAVwzaj56Dvu+
         3lkB9+sxsHOzKs21Do08LHsL5hfPNKiu+kJei8vAFow+kymrEwehSoclBnqWL+YYQ8Qa
         t00A==
X-Gm-Message-State: AAQBX9dUcCrCfaIxSU2O4fzEJEexMDQJrKtfNb6N5c41cGBNU8hpzWk9
        GyG/0HnquDCmBMN7BEi6UQ==
X-Google-Smtp-Source: AKy350YnZq84V4tQgFyHDcnn+eunXYEjW2tATgr53HkpmhsG7LHEOB3RlxH2Jte7iMzDS5GPW95Yyg==
X-Received: by 2002:a05:6808:238e:b0:38e:eaf:cf1c with SMTP id bp14-20020a056808238e00b0038e0eafcf1cmr1069613oib.54.1681737033870;
        Mon, 17 Apr 2023 06:10:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j21-20020a056808057500b0038e086c764dsm978559oig.43.2023.04.17.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 06:10:33 -0700 (PDT)
Received: (nullmailer pid 2588781 invoked by uid 1000);
        Mon, 17 Apr 2023 13:10:27 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yang Xiwen <forbidden405@outlook.com>
Cc:     Jiancheng Xue <xuejiancheng@hisilicon.com>,
        tianshuliang <tianshuliang@hisilicon.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com>
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
 <20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com>
Message-Id: <168173527652.2535566.16838567933859217136.robh@kernel.org>
Subject: Re: [PATCH RFC v4 3/4] dt-binding: mmc: hi3798cv200-dw-mshc:
 convert to YAML and rename to histb-dw-mshc
Date:   Mon, 17 Apr 2023 08:10:27 -0500
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


On Sun, 16 Apr 2023 17:19:34 +0800, Yang Xiwen wrote:
> The renaming is due to the fact that it is now supporting SoCs other
> than Hi3798CV200.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  .../bindings/mmc/hi3798cv200-dw-mshc.txt           | 40 -------------
>  .../bindings/mmc/hisilicon,histb-dw-mshc.yaml      | 69 ++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 40 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/mmc/hisilicon,histb-dw-mshc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

