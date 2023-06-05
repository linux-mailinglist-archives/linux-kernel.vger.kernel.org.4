Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589072210F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjFEIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFEIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:34:03 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D289DC7;
        Mon,  5 Jun 2023 01:34:01 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b00ce51caso17365425ab.2;
        Mon, 05 Jun 2023 01:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685954041; x=1688546041;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bOjvC740On4cxmCmZ+ZA5JJyHC5J2DDm+AfE5TCoosc=;
        b=KLbuwANX9h7k39bIyzcUpxZ5b1CR3prX9BMAIPnS8VXqRY8vH5pO0AuCqM+/+qvNss
         kFPS0o9fsYSwhSK422nTgLDisp2HIdNq3nYIFbJxUWE04QRaD3bOikTE8DWQrXBJHZU/
         d6jfD998k3Cj4Xg4+KzOSTgnNOgU74CtzKOZMj26y0q0rL2ipOFuskCpCmj7baYoNj28
         lg54Jpae5C2fQr1bs//XTXbiOGnkk5us0J0gU+l9R9d5NB/OPj+kF8LHs5Ssk04JFVnI
         SB6jPxHEKu3cjnw1kBmYTz1Qs5YWKfEL5uJohHIJXaeJpumQgftJVcdlDXZ77aS/IjTD
         Uy/Q==
X-Gm-Message-State: AC+VfDxW/H2pNPBphyVJJMRkOTbZJYps376mkUFJAVt/vYgh0Uk+N92b
        AgmY17/0Zc7WAzsUEdhVcA==
X-Google-Smtp-Source: ACHHUZ4d+PH4LnVmRIQ81wOVcfEQYf0UiqGR2sd3uq2AHz4k5TauRk+/drYNhLvLXsLopUkmEnnoMg==
X-Received: by 2002:a92:da89:0:b0:334:c74c:4403 with SMTP id u9-20020a92da89000000b00334c74c4403mr15650410iln.11.1685954040924;
        Mon, 05 Jun 2023 01:34:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m16-20020a92c530000000b0033b2a123254sm2218432ili.61.2023.06.05.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:34:00 -0700 (PDT)
Received: (nullmailer pid 208973 invoked by uid 1000);
        Mon, 05 Jun 2023 08:33:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org
In-Reply-To: <20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net>
Message-Id: <168595403632.208907.7805006523202767813.robh@kernel.org>
Subject: Re: [PATCH 05/14] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
Date:   Mon, 05 Jun 2023 02:33:58 -0600
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


On Mon, 05 Jun 2023 09:08:21 +0200, Stephan Gerhold wrote:
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
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/remoteproc/qcom,rpm-proc.yaml         | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/soc/qcom/qcom,rpm-master-stats.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

