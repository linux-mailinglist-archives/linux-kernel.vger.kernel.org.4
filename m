Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196E9731F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjFORrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjFORrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:47:31 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544082721;
        Thu, 15 Jun 2023 10:47:29 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso330005539f.3;
        Thu, 15 Jun 2023 10:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686851248; x=1689443248;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eOMHF+PAvYNj6z27LafaLYMbvuVFemfqC8gfypuerIw=;
        b=jrns6R9jDZYO1QHJ7OmXo03ywWp3WwNKoeUHG2ncdDHexiwTw+LYEM7N4Hgj6lxWPw
         K8N7gVMMCab5bzo4zshQL4ny9Mr55oHtL3ZE6XK+ZAr5Yyg7XIfKSSdYD+73EDiXG6iR
         EWn6KSLFTDqGCfOZNYjXt47ec2bw5GyvMESSYQZ90Wcgspmhmijc6zuuuAfOcXqOdgZ9
         AGjyJbCASP0fB/7BQfX+Xwvruia23b79a2dNz11H+A76icEr0F8i7rxywx1ERUPn13Gg
         6GRl/RCAvF7VRJ3ms8e1FHABAEE5smhrD9uO0sTqHa4xYyLvGpoMYGN74BeRRh7OCGTB
         uxkg==
X-Gm-Message-State: AC+VfDwfN1IZPw5hWY9F7Tc9OuQR/6+phme/oxTqni4xQlDTYtcBXZnQ
        9FTerlZD0/FK16igae7Tbgc0iLd3EA==
X-Google-Smtp-Source: ACHHUZ46wBJxsKz51zlhelfDLrhVjW9R4d9vgt4Ap+liLjVoK6rQ9zl9E6L5p1auH+YynCFoQWNxYQ==
X-Received: by 2002:a5e:8d0e:0:b0:77a:ec0c:5907 with SMTP id m14-20020a5e8d0e000000b0077aec0c5907mr121504ioj.13.1686851248522;
        Thu, 15 Jun 2023 10:47:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t5-20020a028785000000b0040fa5258658sm5684715jai.77.2023.06.15.10.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:47:27 -0700 (PDT)
Received: (nullmailer pid 1252771 invoked by uid 1000);
        Thu, 15 Jun 2023 17:47:26 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20230531-rpm-rproc-v3-6-a07dcdefd918@gerhold.net>
References: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
 <20230531-rpm-rproc-v3-6-a07dcdefd918@gerhold.net>
Message-Id: <168685124601.1252742.10827614978463684778.robh@kernel.org>
Subject: Re: [PATCH v3 06/13] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
Date:   Thu, 15 Jun 2023 11:47:26 -0600
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


On Thu, 15 Jun 2023 18:50:39 +0200, Stephan Gerhold wrote:
> On Qualcomm platforms, most subsystems (e.g. audio/modem DSP) are
> described as remote processors in the device tree, with a dedicated
> node where properties and services related to them can be described.
> 
> The Resource Power Manager (RPM) is also such a subsystem, with a
> remote processor that is running a special firmware. Unfortunately,
> the RPM never got a dedicated node representing it properly in the
> device tree. Most of the RPM services are described below a top-level
> /smd or /rpm-glink node.
> 
> However, SMD/GLINK is just one of the communication channels to the RPM
> firmware. For example, the MPM interrupt functionality provided by the
> RPM does not use SMD/GLINK but writes directly to a special memory
> region allocated by the RPM firmware in combination with a mailbox.
> Currently there is no good place in the device tree to describe this
> functionality. It doesn't belong below SMD/GLINK but it's not an
> independent top-level device either.
> 
> Introduce a new "qcom,rpm-proc" compatible that allows describing the
> RPM as a remote processor/subsystem like all others. The SMD/GLINK node
> is moved to a "smd-edge"/"glink-edge" subnode consistent with other
> existing bindings. Additional subnodes (e.g. interrupt-controller for
> MPM, rpm-master-stats) can be also added there.
> 
> Deprecate using the old top-level /smd node since all SMD edges
> are now specified as subnodes of the remote processor.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> This patch is based on qcom/for-next, since it needs the new
> qcom,rpm-master-stats.yaml schema that is only applied there.
> ---
>  .../bindings/remoteproc/qcom,rpm-proc.yaml         | 171 +++++++++++++++++++++
>  .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   6 +-
>  .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |   7 +
>  3 files changed, 181 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml: Error in referenced schema matching $id: http://devicetree.org/schemas/soc/qcom/qcom,rpm-master-stats.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230531-rpm-rproc-v3-6-a07dcdefd918@gerhold.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

