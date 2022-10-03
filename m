Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6F5F312A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiJCNZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiJCNY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:24:58 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6361C40B;
        Mon,  3 Oct 2022 06:24:55 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so6723336oop.9;
        Mon, 03 Oct 2022 06:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iBHNi2Sot+ApoX2JfUGrSFvnUvo4HWe0nKSC8q7A+1M=;
        b=ydEEhE9jutJ9O6/iADB3sewbo1uTFqPb9C0oMn4pdGDk3jpxI415G0hZ48QecY7KLC
         XuKmFxCHowihJXXZAn7/YvJxDF7jzdUXpa4E0CDkPT2sfL+lfjLVPXeLb+6WGaCUwNPw
         6aYn95QmSs8el36+TDz5fmfcK0+SR4FnYW5i/nZEMk6fxGYDidl9EgUf/nb05v36mP3n
         01Wcyq6GjFYXcNYQ+wHIdaPzymwGMYTa+0qrwOZFTn7TdelfEyT8efCNjDfQsYgj07FP
         I8yULd7MYeiakd3lXzP0AmpzIQEXyesyH2PkjCBBwFfsFOnHXIWJ3h/cJgLbBCK7qiA3
         7LUA==
X-Gm-Message-State: ACrzQf3NVrS7iyR/o/ycICYzx3u+RH4PO4HV7tVPpSofW6G+1+7p4EZp
        O6LnuCW6IB7iCKpDvxTNMg==
X-Google-Smtp-Source: AMsMyM7kZAhSu+5W9GV63exKqEjegxEDr8M2lTeVBpCtwkyiNsyTuOx97Ry5AtuTFhoZT5ROYsfsBQ==
X-Received: by 2002:a05:6820:62a:b0:476:a722:fe3c with SMTP id e42-20020a056820062a00b00476a722fe3cmr7616925oow.95.1664803495170;
        Mon, 03 Oct 2022 06:24:55 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i9-20020a056830010900b00639443424f8sm2368532otp.8.2022.10.03.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:24:54 -0700 (PDT)
Received: (nullmailer pid 1863807 invoked by uid 1000);
        Mon, 03 Oct 2022 13:24:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, vkoul@kernel.org,
        Alex Elder <elder@ieee.org>,
        linux-arm-kernel@lists.infradead.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <9448dfc974cac4f223982afaf89f65d697a93a7e.1664557657.git.quic_schowdhu@quicinc.com>
References: <cover.1664557657.git.quic_schowdhu@quicinc.com> <9448dfc974cac4f223982afaf89f65d697a93a7e.1664557657.git.quic_schowdhu@quicinc.com>
Message-Id: <166479587655.1659049.10913795163088414070.robh@kernel.org>
Subject: Re: [PATCH V15 1/7] dt-bindings: Added the yaml bindings for DCC
Date:   Mon, 03 Oct 2022 08:24:48 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Oct 2022 14:34:07 +0530, Souradeep Chowdhury wrote:
> Documentation for Data Capture and Compare(DCC) device tree bindings
> in yaml format.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,dcc.yaml     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/soc/qcom/qcom,dcc.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

