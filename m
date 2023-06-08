Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21837279E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjFHI1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFHI1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:27:30 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0906269E;
        Thu,  8 Jun 2023 01:27:29 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33b00ce51caso779175ab.2;
        Thu, 08 Jun 2023 01:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686212849; x=1688804849;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4vk0QrxAJZUCwNeUbkMMvVo1zLXlArkwoqu5OxCPG/U=;
        b=ejJoQe/iLQ/TWRHmnpQJdmSB1IYftpH3uRDXgkbe4C6LBumHFkX7mM9mfPptyn3tLL
         JjzkNxG/tDGQgQ/5Bw5fuFElQUYX6MQ5enktxNn4j74qpm0cp9TyobhV80XplBaFbIAl
         GIFiW02z79tzUBKr72fi8NpupTBPv2B7eJhfkbKgNgVFZVCB1sWXq8zjlFYzpFo7qwB3
         osm1FYmFZgr3HUQzYTXzahvGjbbDq3P/Nri0YphHo+/9FaMx5Hx0wJ/EqRBipJgN7YSC
         c6BxinlFcyyzWVf4t0ZKiyfzAkh1GEqHivrXmeVArl1LXIUiH+bvgpmKSpjW9TqG1AOn
         goLg==
X-Gm-Message-State: AC+VfDz2JmcxsS8CnqWhpCLibqVYhOH3JAjQMebr3PiPkhGOE/g7m3Z/
        10V7WdxFXtxI8mKmU+vDzA==
X-Google-Smtp-Source: ACHHUZ619U2Ip5Lt8XRETTrvzYz6uAXH+LDeKR/g/LcFeC1bXxSA/7mpU+wN8RWZK1WLeyWpRxtq+Q==
X-Received: by 2002:a92:cc0b:0:b0:33a:9a68:35ff with SMTP id s11-20020a92cc0b000000b0033a9a6835ffmr8400244ilp.26.1686212848800;
        Thu, 08 Jun 2023 01:27:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j3-20020a02cc63000000b0040f91a65669sm152296jaq.21.2023.06.08.01.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:27:28 -0700 (PDT)
Received: (nullmailer pid 1409955 invoked by uid 1000);
        Thu, 08 Jun 2023 08:27:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230531-rpm-rproc-v2-5-56a4a00c8260@gerhold.net>
References: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
 <20230531-rpm-rproc-v2-5-56a4a00c8260@gerhold.net>
Message-Id: <168621284569.1409937.7016655911882350618.robh@kernel.org>
Subject: Re: [PATCH v2 05/12] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
Date:   Thu, 08 Jun 2023 02:27:25 -0600
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


On Thu, 08 Jun 2023 09:10:25 +0200, Stephan Gerhold wrote:
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
./Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/soc/qcom/qcom,rpm-master-stats.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230531-rpm-rproc-v2-5-56a4a00c8260@gerhold.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

