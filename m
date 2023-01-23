Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1D677CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjAWNtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAWNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:49:05 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2CAD;
        Mon, 23 Jan 2023 05:49:04 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id k1-20020a056830150100b006864d1cb279so7333215otp.5;
        Mon, 23 Jan 2023 05:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=//DHpA5i3hol8ArwazyDNHsWtgrXopGM0+npJVx54uk=;
        b=enDKmJou5pP4b37WDlkkLoFpKYISLc2HZXaK95zh0YlOFb9L7jo8uu1NF5x46Jju2a
         YKhYfJ/MXtevHx4TWuchJzPUNk/VQbPWvCRRQUnDX+LQbC95t6QE0pCGbeuyqv8HxoK1
         DCViK+vAk6tIOSvHHe1RIb8RSOQ7ln8qjW6W2sP7N5WUuyvsupE7/+mZGVAfcKY/5578
         TT2Yh6RGntEtYZHatwb3JpHgdSJQ+HorleH5c9nRGDRGboNRHmdSU5guinvEOk85Wngr
         k+8qXRVCV/PqmUArTsBoMJcyxbuRXJazJNHB+gIpOVsLO5YvNHpqSg/N7LBwQfmv70K5
         f6Ng==
X-Gm-Message-State: AFqh2krJqW7GTD8G3K59qIVd3YFCvCIxfSu6RYe4nCFGSWIeMbqtQQQh
        ItHIeGQdyZlXc8q8k3WvZw==
X-Google-Smtp-Source: AMrXdXtChdgVtk8z2iCt5U76+GKkQLE11WM7nCjWomYuOdXazp6dqBzE2r1fs2O0W/GnF6gAmaULoA==
X-Received: by 2002:a05:6830:6402:b0:684:df6f:d51f with SMTP id cj2-20020a056830640200b00684df6fd51fmr13399888otb.19.1674481743427;
        Mon, 23 Jan 2023 05:49:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h17-20020a9d6a51000000b0068655f477a6sm8025555otn.50.2023.01.23.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:49:03 -0800 (PST)
Received: (nullmailer pid 1354417 invoked by uid 1000);
        Mon, 23 Jan 2023 13:49:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Ilia Lin <ilia.lin@kernel.org>, linux-arm-msm@vger.kernel.org
In-Reply-To: <20230122174548.13758-2-ansuelsmth@gmail.com>
References: <20230122174548.13758-1-ansuelsmth@gmail.com>
 <20230122174548.13758-2-ansuelsmth@gmail.com>
Message-Id: <167448142409.1341200.17721291842108865875.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: opp: opp-v2-kryo-cpu: enlarge
 opp-supported-hw maximum
Date:   Mon, 23 Jan 2023 07:49:02 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Jan 2023 18:45:48 +0100, Christian Marangi wrote:
> Enlarge opp-supported-hw maximum value. In recent SoC we started
> matching more bit and we currently match mask of 112. The old maximum of
> 7 was good for old SoC that didn't had complex id, but now this is
> limiting and we need to enlarge it to support more variants.
> 
> Document all the various mask that can be used and limit them to only
> reasonable values instead of using a generic maximum limit.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0:opp-1401600000:opp-supported-hw:0:0: 5 is not one of [1, 2, 3, 4, 7, 9, 13, 14, 15, 16, 32, 48, 112]
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-0: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1401600000', 'opp-1593600000', 'opp-307200000', 'opp-shared' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1:opp-1804800000:opp-supported-hw:0:0: 6 is not one of [1, 2, 3, 4, 7, 9, 13, 14, 15, 16, 32, 48, 112]
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: /: opp-table-1: Unevaluated properties are not allowed ('compatible', 'nvmem-cells', 'opp-1804800000', 'opp-1900800000', 'opp-2150400000', 'opp-307200000', 'opp-shared' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: opp-table-0: opp-1401600000:opp-supported-hw:0:0: 5 is not one of [1, 2, 3, 4, 7, 9, 13, 14, 15, 16, 32, 48, 112]
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.example.dtb: opp-table-1: opp-1804800000:opp-supported-hw:0:0: 6 is not one of [1, 2, 3, 4, 7, 9, 13, 14, 15, 16, 32, 48, 112]
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230122174548.13758-2-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

