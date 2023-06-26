Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EAF73DB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjFZJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjFZJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:30:08 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3453B9;
        Mon, 26 Jun 2023 02:30:05 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-345a0cf5b3bso8682275ab.0;
        Mon, 26 Jun 2023 02:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687771805; x=1690363805;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+OtaETWb24m97Ds/UuSIviPp/udpUqkFteTCOvggmng=;
        b=HjEhtpSZrlJBIXPBgyEwMzVVrssHF6MJZQ8i6vFqvk5jMqR40EyvKIrqyI33FTi9NZ
         6bonRSu7Q0ATA8TVDeTsp7UOIRn/BtmQky8wNVACxRxacQdL6DW6tbU1QPmh7ZYF8bNT
         49AWd+WiqLtWDsRB/aKQta6hfrlfpfmQscZZj1orPhMMjL2jJCQ/tfHHKmZZRaWXoysf
         G3CfGop70rxEYw9bGr24bXyMXYvTqKcQXLOa4HYo8XlUnPvw1B0sQNQs7dh7uiCL3/bN
         HuoXrJ6EmbehYPtA8sBDGm8i8LXVXsrWD2q1+g6f7+JeO/lQ59Fg/oA3mVNw+53JbOBp
         1/qw==
X-Gm-Message-State: AC+VfDx/2L2sbfkXFpOsWnFoTriIgnJtsIdH3YMK2MT8XOyXwGP1h6q9
        SvKPoPsD0yet8vLQviJYog==
X-Google-Smtp-Source: ACHHUZ7ma3u80z5g13zdtQF0PPsMHvxWrDwncZTbHWyQ5p5pXLKxhjX3k1XvOGgqqkWOSND7WCI3Qg==
X-Received: by 2002:a92:d309:0:b0:33d:3b69:2d23 with SMTP id x9-20020a92d309000000b0033d3b692d23mr22947121ila.19.1687771804923;
        Mon, 26 Jun 2023 02:30:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p17-20020a056e0206d100b00341fa29aaf4sm1886925ils.39.2023.06.26.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 02:30:04 -0700 (PDT)
Received: (nullmailer pid 2436844 invoked by uid 1000);
        Mon, 26 Jun 2023 09:30:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     phone-devel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Iskren Chernev <me@iskren.info>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-scsi@vger.kernel.org
In-Reply-To: <20221209-dt-binding-ufs-v4-3-14ced60f3d1b@fairphone.com>
References: <20221209-dt-binding-ufs-v4-0-14ced60f3d1b@fairphone.com>
 <20221209-dt-binding-ufs-v4-3-14ced60f3d1b@fairphone.com>
Message-Id: <168777180225.2436813.12641828486385303318.robh@kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: ufs: qcom: Fix sm8450 bindings
Date:   Mon, 26 Jun 2023 03:30:02 -0600
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


On Mon, 26 Jun 2023 10:15:59 +0200, Luca Weiss wrote:
> SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
> bindings and the example to match.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Reviewed-by: Iskren Chernev <me@iskren.info>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: Unevaluated properties are not allowed ('reg-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221209-dt-binding-ufs-v4-3-14ced60f3d1b@fairphone.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

