Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F115B8702
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiINLIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiINLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:08:09 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF69237E5;
        Wed, 14 Sep 2022 04:08:05 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id d25-20020a9d72d9000000b00655d70a1aeaso6986053otk.3;
        Wed, 14 Sep 2022 04:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2rmXNTNBwGY5J4a4h3i1VzHJdXFIlmwnn+zGBAD+UYI=;
        b=Voga5yjRNeRKMKvtfqtn9e6+REzfgIMAzk6dRoGr6m2+vsPBBqddq/9rEmrnWJF0vg
         Jv1GvmiCOv1p3olpf9I4LPhYl0elUA7OU0L931o5cj6W1fBgncTCF0R4Ocpts+tRCIWg
         aT3tuyzXTWo2PBuUw8K1ZSoXnY2bjjz1LifQiznu/C1w9AduLc/FI2u4ZKDn2xPCuONG
         Y0slGq0QazjdvYQI+Ad4fTqFRO4tSOPq/rbktFqxcIcpybt4yR2qfZwEQfXRvyiT3SPF
         UVVIpAmn7VCnG2OUyXvjfgv0hitaxv651ZhVjXi9a8jpK25TdI7pWfNW+xQN/CJES55T
         cw8Q==
X-Gm-Message-State: ACgBeo1RPY7+Pit1by72NRYl66U196G8sE0mJ/ikY7SBkPAb0opUAIhg
        rTXzm5MCX28O2G4bAflc6w==
X-Google-Smtp-Source: AA6agR7RJKKKW2Pa1sGiCmQlgDBTlugnTg1bEE7BTI+sHywTNfckweBkJxzjZb0uy0FBTY6AHWBJYA==
X-Received: by 2002:a05:6830:204b:b0:656:6b6e:fa77 with SMTP id f11-20020a056830204b00b006566b6efa77mr2632435otp.141.1663153684884;
        Wed, 14 Sep 2022 04:08:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 93-20020a9d0be6000000b00636ee04e7aesm7016797oth.67.2022.09.14.04.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:08:04 -0700 (PDT)
Received: (nullmailer pid 1742267 invoked by uid 1000);
        Wed, 14 Sep 2022 11:08:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, manivannan.sadhasivam@linaro.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, agross@kernel.org
In-Reply-To: <1663135386-26270-2-git-send-email-quic_sibis@quicinc.com>
References: <1663135386-26270-1-git-send-email-quic_sibis@quicinc.com> <1663135386-26270-2-git-send-email-quic_sibis@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: Add dt binding for QTI CPUCP mailbox controller
Date:   Wed, 14 Sep 2022 06:08:03 -0500
Message-Id: <1663153683.714744.1742263.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 11:33:05 +0530, Sibi Sankar wrote:
> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
> controller.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../bindings/mailbox/qcom,cpucp-mbox.yaml          | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.example.dtb: mailbox@17400000: reg: [[0, 398458880], [0, 16], [0, 408486656], [0, 1792]] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

