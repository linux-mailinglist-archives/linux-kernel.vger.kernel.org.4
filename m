Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79486E2368
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjDNMhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDNMhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:37:11 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E7E113;
        Fri, 14 Apr 2023 05:37:08 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-187bee46f9dso83310fac.11;
        Fri, 14 Apr 2023 05:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475828; x=1684067828;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZwurFSObnee2kpIi6/Arxgkud3I9gBHLAMsi3ZlNypU=;
        b=KqMR1vyYcXIliDVgfbU7N20AYm4b7jxk5aFNpruAgNnf+SYHRBMqOdCJf99CyDkfiF
         KM+oi831k0Yomd9+oU4LB2tIdKnzokz7qhOHoZu1BWl3C3ym9vzzVH5fmulc0nsso2Hb
         7Zkww6hy0cL7ajFeNJ99m/XlrxhOqVYWjAnRUfDQ2xTdOCgQWBwrZ5msmPsXbpmrbxlu
         1GTDU6hN4DvDWaMRuKGxDMyTk0HDh1HD30jRErEVLc/7cjneZlXFMa6NDBlnj2Qn7Tc8
         Xndmb85qHkGcDF83L77jK73/yUdI+GDDE7qjUh9i7My8+2fK2aP6Qtl/+4yJhWxmoZ/X
         OJVg==
X-Gm-Message-State: AAQBX9d7LeBV1D8EBwRG2KJnK7TspiLk77BGBl2OwJeigfXLBJjCcinp
        7awAdCpEG4raTpAwLkWf6w==
X-Google-Smtp-Source: AKy350bVVmrhvY61XM75nFRu62Wrf4ZG7s1mswZusecno/1qzJvuME7mfnOdLBD20yqZBjNKf+Kakw==
X-Received: by 2002:a05:6870:b253:b0:187:8f41:9971 with SMTP id b19-20020a056870b25300b001878f419971mr3824889oam.34.1681475827712;
        Fri, 14 Apr 2023 05:37:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w18-20020a056870431200b0018045663fc5sm1712632oah.48.2023.04.14.05.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:37:06 -0700 (PDT)
Received: (nullmailer pid 3600809 invoked by uid 1000);
        Fri, 14 Apr 2023 12:37:05 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20230414024157.53203-6-xingyu.wu@starfivetech.com>
References: <20230414024157.53203-1-xingyu.wu@starfivetech.com>
 <20230414024157.53203-6-xingyu.wu@starfivetech.com>
Message-Id: <168147484896.3576391.17289619505417988717.robh@kernel.org>
Subject: Re: [PATCH v3 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Date:   Fri, 14 Apr 2023 07:37:05 -0500
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


On Fri, 14 Apr 2023 10:41:55 +0800, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add documentation to describe StarFive System Controller Registers.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414024157.53203-6-xingyu.wu@starfivetech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

