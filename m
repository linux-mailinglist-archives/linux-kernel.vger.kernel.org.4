Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56DA600411
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 00:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJPW6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 18:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJPW6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 18:58:23 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8EF32BA5;
        Sun, 16 Oct 2022 15:58:20 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1321a1e94b3so11653931fac.1;
        Sun, 16 Oct 2022 15:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y87I5y8One47p+rmmdOCebsJ8OGc+ziD4kkEXvM+88=;
        b=Cl3IM/fwGKV7oDfIECEvXhTabuZCQxaTwJmhaaHwmnRojVK/fUu28R7ta+tp0DgkXs
         +rw9cSYe8ftgpTPwb1FwJXeuxxt0AT3BP6HIVvBrUdFTFcjzVSeQZL61oGQu1+LBQcIz
         FgNOO4TCdMc/ki1LgvA1+dUV0Uu/3oXUYDUW8k1zdVSJc6MeoPt4+30v4a0PsXMmYw5/
         z9h+58z+BpXWGK7nfLMHV5FcJ8xoQOmu0osp4PsETg2VZeKg4syaUcQ2Ggxdsqtu2weN
         fXwkuY8oYfDiyOE3K73HOyXwYp3Vs5AyXkZdCSeDUsFOXJOIp9qESbkZVrNeN079l60I
         VPXg==
X-Gm-Message-State: ACrzQf1PCHdQzd9cbDVtekg3gggs0mvdvGkhbPnFpCTgf3nAXptRjdUl
        f7MTw3HPLvfM8vWqKBrDhfDioQB0hA==
X-Google-Smtp-Source: AMsMyM6MGesx6YMXRfGI+ybf558PQpJkenbC9nU1KqgyID4KBQq+J+KBgulytBUZQIgd1z0vFxps5w==
X-Received: by 2002:a05:6870:160b:b0:12b:8d8d:1401 with SMTP id b11-20020a056870160b00b0012b8d8d1401mr4246968oae.7.1665961099843;
        Sun, 16 Oct 2022 15:58:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n5-20020a05680803a500b00354d9b9f6b4sm3723473oie.27.2022.10.16.15.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 15:58:19 -0700 (PDT)
Received: (nullmailer pid 3904628 invoked by uid 1000);
        Sun, 16 Oct 2022 22:58:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     quic_rohkumar@quicinc.com, vkoul@kernel.org, tiwai@suse.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        bgoswami@quicinc.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        judyhsiao@chromium.org, perex@perex.cz, quic_plai@quicinc.com,
        srinivas.kandagatla@linaro.org, swboyd@chromium.org,
        Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
In-Reply-To: <1665820441-617-1-git-send-email-quic_srivasam@quicinc.com>
References: <1665820441-617-1-git-send-email-quic_srivasam@quicinc.com>
Message-Id: <166596080441.3896287.5989385957462109322.robh@kernel.org>
Subject: Re: [RESEND] dt-bindings: soundwire: Convert text file to yaml format
Date:   Sun, 16 Oct 2022 17:58:18 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2022 13:24:01 +0530, Srinivasa Rao Mandadapu wrote:
> Update soundwire bindings with yaml formats.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> ---
>  .../devicetree/bindings/soundwire/qcom,sdw.txt     | 214 ---------------------
>  .../devicetree/bindings/soundwire/qcom,sdw.yaml    | 185 ++++++++++++++++++
>  2 files changed, 185 insertions(+), 214 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/soundwire/qcom,sdw.example.dts:36.38-39 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/soundwire/qcom,sdw.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

