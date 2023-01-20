Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1399A6748FB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjATBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjATBmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:42:52 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A9D241D9;
        Thu, 19 Jan 2023 17:42:50 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so2298013otf.8;
        Thu, 19 Jan 2023 17:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3fa6PPtmv8bHW5qqhtcHqFt8wmFZ+0TFiAlmx2L9q84=;
        b=3T+ShNdcXLXfnfLcOCcxzpVgmEbKRtpaFgq1LliOGE5QVgfXer4OREA7OVtrk4/ynl
         5U22Ax5MCxQWHXGhw7NBY72y9uux31S2rOJyaemU2peQTqrSQpQMG/SNaQKYEFU10vPv
         sfTA7cnaeIL1edRqx5nAXeX5oanxa7CNCB9ddDonL1aQh3MAfchs3bFXgc8A7c8XQnK3
         Nv3KjHQVs0shWyGvWHFv9uuqDSscEB2AARClJoYR0TlhgW9Uh2S9Wod1qvYvCzsWW7hi
         fP6ZrffxkN2ut17mwmd3Oso6nZ2WDDEe9eIblr+IHJJMsk+jZh4BQvwji9oc5HyXfT+Y
         N03Q==
X-Gm-Message-State: AFqh2koMVgVR5AS0RVnnVrnTP6xrcQJ109Ub2tghTd5kgxAvV7beDdhL
        wrgqClo91JT40izVHMLNOg==
X-Google-Smtp-Source: AMrXdXtKmLpq1iI7gLQf60pfLWgE2BZLF1lHU3djaO8Nn2uBr4hptQOjfXMFJ5Pl89bsjX5HNud48w==
X-Received: by 2002:a9d:7d19:0:b0:670:69ad:3636 with SMTP id v25-20020a9d7d19000000b0067069ad3636mr6282024otn.23.1674178969701;
        Thu, 19 Jan 2023 17:42:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a20-20020a9d6e94000000b006718a823321sm6329944otr.41.2023.01.19.17.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:42:48 -0800 (PST)
Received: (nullmailer pid 3131600 invoked by uid 1000);
        Fri, 20 Jan 2023 01:42:43 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, iio@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20230119212632.185881-2-marijn.suijten@somainline.org>
References: <20230119212632.185881-1-marijn.suijten@somainline.org>
 <20230119212632.185881-2-marijn.suijten@somainline.org>
Message-Id: <167417887912.3129483.8810312426567009756.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Require generic adc-chan
 name for channel nodes
Date:   Thu, 19 Jan 2023 19:42:43 -0600
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


On Thu, 19 Jan 2023 22:26:31 +0100, Marijn Suijten wrote:
> As discussed in [1] it is more convenient to use a generic adc-chan node
> name for ADC channels while storing a friendly - board-specific instead
> of PMIC-specific - name in the label, if/when desired to overwrite the
> channel description already contained (but previously unused) in the
> driver [2].
> 
> Replace the .* name pattern with the adc-chan literal, but leave the
> label property optional for bindings to choose to fall back a channel
> label hardcoded in the driver [2] instead.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml         | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dtb: adc@3100: 'conn-therm@4f' does not match any of the regexes: '^adc-chan@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.example.dtb: adc@3100: 'conn-therm@147', 'xo-therm@44' do not match any of the regexes: '^adc-chan@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230119212632.185881-2-marijn.suijten@somainline.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

