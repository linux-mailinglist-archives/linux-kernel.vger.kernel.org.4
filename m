Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FDE6E8125
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjDSSVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjDSSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:21:19 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B795558A;
        Wed, 19 Apr 2023 11:21:18 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-541f2112f82so3228eaf.1;
        Wed, 19 Apr 2023 11:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681928478; x=1684520478;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BytL5fcLKRsxYJZE+iS1QqeRvdEysPc/md0SBratCqA=;
        b=Udpihy7IEJkBMAc7IFf4sDFKyICbJK/tZ/Nv5gd2hwHfnumUT3LbAf+82kI1So/D1T
         /TA6GP7N62pBoxy/tmv+O5LXrfVMtqUhZ+XxmiRB8eaoSahhxqH0pQ7o7hHt0SCpR6jm
         H3LMwBlPyXTULJC/byOX9D9U+dwK0zHl8hzIyqYqQw0wdM259w1Ct28yzfAt8dx8lO+4
         9yBqWEKU5K3yhvHspLNG9OCjk6gp7oMpvWY+EnOKAWipM9BVSVQ5j6bgS5cga30BNxnu
         ELEmDCnGVIlXobk4fqsyl8vPiKzgiPDHsCw3S6k+1PbCAvBxXzvOIEVrRL2fQw83SOu6
         L4WQ==
X-Gm-Message-State: AAQBX9dXrQTbvB7IURi3ea8UmSk6Dqj86DTNs+IiUmYMIw3AQHgSsvUF
        d5R9itkRELLKFRXuehrRH/lJSP9KeQ==
X-Google-Smtp-Source: AKy350Yt9qsTaasoCcDlU7nudwLXTG30d0LR9e18XdhMiTcCh9n5QexGpq/0F5we9s7EdYumgsduYA==
X-Received: by 2002:aca:130a:0:b0:38d:edc1:92 with SMTP id e10-20020aca130a000000b0038dedc10092mr3679092oii.45.1681928477829;
        Wed, 19 Apr 2023 11:21:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n131-20020acabd89000000b0038c06ae307asm7336832oif.52.2023.04.19.11.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 11:21:17 -0700 (PDT)
Received: (nullmailer pid 480920 invoked by uid 1000);
        Wed, 19 Apr 2023 18:21:16 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     festevam@gmail.com, V.Sethi@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, gaurav.jain@nxp.com,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        sahil.malhotra@nxp.com, robh+dt@kernel.org
In-Reply-To: <20230419175538.855493-2-pankaj.gupta@nxp.com>
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
 <20230419175538.855493-2-pankaj.gupta@nxp.com>
Message-Id: <168192843988.479874.10918604277415401966.robh@kernel.org>
Subject: Re: [PATCH v2 1/7] doc: device tree binding addition for ele MU
Date:   Wed, 19 Apr 2023 13:21:16 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2023 23:25:32 +0530, Pankaj Gupta wrote:
> Documentation update with addition of new device tree
> for NXP ele-mu (Edgelock Enclave Message Unit), driver.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,ele_mu.yaml    | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.example.dtb: ele_mu: mboxes: [[4294967295, 2, 0], [4294967295, 3, 0]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230419175538.855493-2-pankaj.gupta@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

