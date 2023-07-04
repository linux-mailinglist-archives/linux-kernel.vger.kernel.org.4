Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF031746AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGDHcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGDHcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:32:48 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B1A11C;
        Tue,  4 Jul 2023 00:32:47 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-78362f57500so271178839f.3;
        Tue, 04 Jul 2023 00:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455966; x=1691047966;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6OMYh5IbkuJhkVtA222shrGSiZUIaKu3Yl/3z7DSeI=;
        b=WAYpbhzv5GO7tdwh4f7PI44kyLuGEIenr3Nm593vQ8V3/a+8gOVUJQAi62JKQ2UWy0
         gWr+qSs+gMzCX0k5bBKXB2x8b5kQey9bmPsHTw5LJgnK7oljWXwNiqjVaPjPVtlDuGpI
         50EZZUheegklLEc07mRt9zpOwq2ieXGroRUMPC7HFpS5DQ6TAlHr2UAIy6iyosRSA4Hd
         S4py0vrL8f8X8YRd85iUuYLWiubGo7/oNHaejwPJrefW4j/lT2masIDNj0P5H1i54eVj
         z+RefM/vPWBntbkVYnG3Ov63SkkSATSGwoN7cAirvYj8vax92iJfDa3yw5FZmx5jN0ua
         yHjw==
X-Gm-Message-State: AC+VfDyskukHQHdq+QaTCGqsp5ErBHT2VqS4++2vm3deGLU4gAJKrqyk
        bXE6UMV0zUFPN+3Bs5Cm+g0EWCGiZw==
X-Google-Smtp-Source: ACHHUZ5ZBWdw/np7sXrcUFJbEnnFpFSrla7vxr5ZBfA9bINWPkpe4fGc19lM78tkAdC6ByIGl4ywtg==
X-Received: by 2002:a5e:8506:0:b0:785:d67c:d2a0 with SMTP id i6-20020a5e8506000000b00785d67cd2a0mr13546746ioj.2.1688455966313;
        Tue, 04 Jul 2023 00:32:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w29-20020a02cf9d000000b0041d7ad74b36sm5003056jar.17.2023.07.04.00.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:32:45 -0700 (PDT)
Received: (nullmailer pid 1192025 invoked by uid 1000);
        Tue, 04 Jul 2023 07:32:43 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shawnguo@kernel.org, linux-imx@nxp.com, abelvesa@kernel.org,
        mturquette@baylibre.com, peng.fan@nxp.com, kernel@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, shengjiu.wang@gmail.com,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        robh+dt@kernel.org
In-Reply-To: <1688449175-1677-2-git-send-email-shengjiu.wang@nxp.com>
References: <1688449175-1677-1-git-send-email-shengjiu.wang@nxp.com>
 <1688449175-1677-2-git-send-email-shengjiu.wang@nxp.com>
Message-Id: <168845596348.1191928.11987600164269347678.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx8-acm: Add audio clock mux
 support
Date:   Tue, 04 Jul 2023 01:32:43 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Jul 2023 13:39:33 +0800, Shengjiu Wang wrote:
> Add the clock dt-binding file for audio clock mux. which
> is the IP for i.MX8QM, i.MX8QXP, i.MX8DXL.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx8-acm.yaml   | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8-acm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/imx8-acm.yaml: title: 'NXP i.MX8 Audio Clock Mux Binding' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1688449175-1677-2-git-send-email-shengjiu.wang@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

