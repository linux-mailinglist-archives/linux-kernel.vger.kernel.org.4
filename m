Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBDE5F3121
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJCNZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJCNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:24:56 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD51EADC;
        Mon,  3 Oct 2022 06:24:54 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso6719401ooq.6;
        Mon, 03 Oct 2022 06:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VwdzdygdgLbBp3fkNJZh/HpOAPaqnsjBDUAQiUXbsnM=;
        b=vCySG/hGZcGh8uFpHPd+ExkjMFEUEFdzgs6BTJduU8W6A0qAZ521oaoipLE0ay5WFI
         htX8rIzqbj8sJvlK5GeHgGjFRpDtPNhe5GTvm0QvEl+oqX7Y3S4jFjean5l+xw5Ut2Gd
         CeVR5MMsFQzRs7rrLyugcw0YZPA+vMrXOLqVPMzR6kuh/VaKs5l4e2+x92zHfbr9d7FE
         Kzcs/ElOSZ55OHquzBDTRfrfFWiptbAC9NnnlfsBAzQajfkP+7hnfxxkSbOzVsG0+vJn
         bBS8yQKODLKjh9FBmm/aySZfG40IcK/SnBFdIY2Jih8kSj7aszKq/owohq3rtdwdfyTt
         yDUA==
X-Gm-Message-State: ACrzQf0z0x6YvGiotsUVryb4/DwAQzEco96kNyIhdrh4HDBx4zxGfD4k
        UBiiP3j9l8vqS72flwi2ww==
X-Google-Smtp-Source: AMsMyM7ArjVDwVFx++um/0TDQxPqWPgM5a1GRKKaEjx9iHWMhV8SvM4Y/13k9L5mN19NrK84JQl+6A==
X-Received: by 2002:a9d:72d1:0:b0:65c:6650:a3c5 with SMTP id d17-20020a9d72d1000000b0065c6650a3c5mr7662551otk.286.1664803492631;
        Mon, 03 Oct 2022 06:24:52 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d1-20020a056871040100b0010e73e252b8sm2952907oag.6.2022.10.03.06.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:24:52 -0700 (PDT)
Received: (nullmailer pid 1863801 invoked by uid 1000);
        Mon, 03 Oct 2022 13:24:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20221001030403.27659-2-quic_molvera@quicinc.com>
References: <20221001030403.27659-1-quic_molvera@quicinc.com> <20221001030403.27659-2-quic_molvera@quicinc.com>
Message-Id: <166479587305.1658944.6390618690246358275.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock bindings
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

On Fri, 30 Sep 2022 20:03:59 -0700, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-qdru1000.yaml     |  74 ++++++++
>  include/dt-bindings/clock/qcom,gcc-qdru1000.h | 170 ++++++++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdru1000.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/clock/qcom,gcc-qdru1000.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

