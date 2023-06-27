Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEABF73F94A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjF0J4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjF0Jz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:55:57 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6642691;
        Tue, 27 Jun 2023 02:55:15 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-34568286979so19721235ab.2;
        Tue, 27 Jun 2023 02:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687859714; x=1690451714;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0TZ3MSYKMTSwcYTzU8pfjJrA+SIj1fT6OF7x/GirJ9U=;
        b=ahxTVOTh9VDxSJTNbK1LCwlQBozSAPMuOGYJ6IIcWaudz0p5qa9byGCksnt91Y15UJ
         NsJW7ZkWvG4oxhWWUUCzyh+cclp+KUAiqGS09aLMkQh2xGdHKdx2iFkYh01qo9X4gJ3o
         Cpm69b3gkeH7I88QY2fdY3DxH7Bn4o4y2Zih40RbP1SQJTcxxPibDqx3Eo7XNqUaPxvo
         jhD/04WD9+Af1Eoj92ykcmAhj80VWrRoB0CBIIve5luK5o1PRh64V6aYqouq/9h6dCol
         A7Y1QTbA8piXlXCqzdo4IuhahGj9S0A5ingfisOfQjaPNyNvgAC7I6kGn4QTXAv6PIr1
         utvA==
X-Gm-Message-State: AC+VfDwlEvjqp3tXTPmQDFS809Bj0TCBAa4iRB7/jHOJeHjtXvSYm3ts
        e66wdFLto7/xX99fyOZlRJN8oJ42qA==
X-Google-Smtp-Source: ACHHUZ74NSK9HlVoxn1NExoX0rzO816CzJ5JTaA/XJZrlI3UYg8id7RsR1lOBIKFYR8W3ruSs/eOPQ==
X-Received: by 2002:a92:c808:0:b0:345:8abb:5b36 with SMTP id v8-20020a92c808000000b003458abb5b36mr5894921iln.9.1687859714144;
        Tue, 27 Jun 2023 02:55:14 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ep17-20020a0566384e1100b00420e6c58971sm2311442jab.178.2023.06.27.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:55:13 -0700 (PDT)
Received: (nullmailer pid 1233680 invoked by uid 1000);
        Tue, 27 Jun 2023 09:55:11 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Iskren Chernev <me@iskren.info>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221209-dt-binding-ufs-v5-3-c9a58c0a53f5@fairphone.com>
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
 <20221209-dt-binding-ufs-v5-3-c9a58c0a53f5@fairphone.com>
Message-Id: <168785971145.1233664.7985274899454909326.robh@kernel.org>
Subject: Re: [PATCH v5 3/5] dt-bindings: ufs: qcom: Add ICE to sm8450
 example
Date:   Tue, 27 Jun 2023 03:55:11 -0600
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


On Tue, 27 Jun 2023 10:28:03 +0200, Luca Weiss wrote:
> SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
> example to match.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: Unevaluated properties are not allowed ('qcom,ice' was unexpected)
	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221209-dt-binding-ufs-v5-3-c9a58c0a53f5@fairphone.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

