Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F01474BE04
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGHPC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGHPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:02:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5EE170F;
        Sat,  8 Jul 2023 08:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6A2760CA5;
        Sat,  8 Jul 2023 15:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB30C433C7;
        Sat,  8 Jul 2023 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688828573;
        bh=SudgGhmikwI/7iRvC6D3J6pIlbxiqog+iL4DTm4N/Aw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l5pOm/NSPES3w/S4QENdn2tDqw1Lc2S2couvy7S0MmA265pNc/bKCqZO4LxidZIHw
         5h3KtZmQsbbMhYvC9fmLpB3qpYJX48K+Tr0BiNfJGZDuHh/D/O93FTI4cNaX5uuXlx
         7ki3OfZP0HCMxC+2PC8/e+bFi3dcsj1CIy0p1lZYjT/soRUZBTecIc3qCf9xW4Hqyg
         eB1PR6eE2GXyYaSaxRmlvJMMVKhVcJXzJvTPLjdCkH4RsmUmeoPaABzasixk+Koriz
         QtGVTrpx66BLVFc7m22jqGrwWdRozC8sn+7jLws4KKjpUt5wNM5P75S+rISwl6ApNN
         UQG8uTzsqSf7w==
Date:   Sat, 8 Jul 2023 16:02:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>, "Luca Weiss" <luca@z3ntu.xyz>,
        <linux-iio@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 04/11] iio: adc: Update bindings to remove support for
 ADC7 name used on QCOM PMICs
Message-ID: <20230708160239.63cb1e7f@jic23-huawei>
In-Reply-To: <20230708072835.3035398-5-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
        <20230708072835.3035398-5-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 12:58:28 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Now that usage of "ADC7" name has been replaced with usage of "ADC5
> Gen2" name everywhere, remove all support for "ADC7" name.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  5 +-
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  1 -
>  .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   | 63 -------------
>  .../dt-bindings/iio/qcom,spmi-adc7-pm8350b.h  | 88 -------------------
>  .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  | 46 ----------
>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735a.h  | 28 ------
>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  | 28 ------
>  include/dt-bindings/iio/qcom,spmi-vadc.h      | 76 ----------------
>  8 files changed, 1 insertion(+), 334 deletions(-)
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index f886977de165..eb7d16e385ad 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -26,7 +26,6 @@ properties:
>            - qcom,spmi-vadc
>            - qcom,spmi-adc5
>            - qcom,spmi-adc-rev2
> -          - qcom,spmi-adc7
>            - qcom,spmi-adc5-gen2
>  
>    reg:
> @@ -214,9 +213,7 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            enum :
> -                - qcom,spmi-adc7
> -                - qcom,spmi-adc5-gen2
> +            const: qcom,spmi-adc5-gen2
>  
>      then:
>        patternProperties:

Hmm. Definitely can't drop support (as per comment on next patch).
I think you should just mark it deprecated rather than remove it here but maybe
you can drop it.  Let's see what DT binding maintainers say.

Jonathan
