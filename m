Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1E74BE21
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGHPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGHPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7665C1709;
        Sat,  8 Jul 2023 08:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A5E460DBD;
        Sat,  8 Jul 2023 15:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4FEC433CA;
        Sat,  8 Jul 2023 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688829809;
        bh=LRKuU4wR21FSTMd32UkZLDmh6O5X3KbUUhZ6esX8nWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OkWBrDLThWtCE511INbneL4ICaMtIobUriY1mQMfu2lXzvcRX2PfFMGCt98OYWLzZ
         vowzfrJQtvcudEafsFzuh7qui5Q1slDosfaqVyvj5dwz8nD+Ptw7jOivqV5G5bF2YA
         N+eVP6XGo1N5oItiDUgNhfNw8EC9/GhlcxjGAD3LUE+iTmxD2siSztefUyY70safiI
         QlPalmFDoHMVa0dPmWgo4CU6eQx+fCqhkLtMF5xj/6QS9Ix0m+CLRcc6u74Eiiz4cR
         FNGU+yHPj1MlV2JwxWZ4RDdlKmD/2DAbjhqo9sqY1YQGqxisL970O0wed3CISh83pk
         x1DMqMXtHUmxw==
Date:   Sat, 8 Jul 2023 16:23:18 +0100
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
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 09/11] iio: adc: Update QCOM ADC drivers for bindings
 path change
Message-ID: <20230708162318.1e2b169f@jic23-huawei>
In-Reply-To: <20230708072835.3035398-10-quic_jprakash@quicinc.com>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
        <20230708072835.3035398-10-quic_jprakash@quicinc.com>
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

On Sat, 8 Jul 2023 12:58:33 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Update ADC dt-bindings file paths in QCOM ADC driver files to
> match the dt-bindings change moving the files from 'iio' to
> 'iio/adc' folder.
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>

Do the move in one go.

Diff rename detection will make the resulting patch more trivial
to look at than this multistep version.

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 +-
>  drivers/iio/adc/qcom-spmi-adc5.c      | 2 +-
>  drivers/iio/adc/qcom-spmi-vadc.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> index fe5515ee8451..78ece8fccbae 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -23,7 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  #define ADC5_GEN3_HS				0x45
>  #define ADC5_GEN3_HS_BUSY			BIT(7)
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 6cebeaa69a75..5dfcb770d663 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -21,7 +21,7 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  #define ADC5_USR_REVISION1			0x0
>  #define ADC5_USR_STATUS1			0x8
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index f5c6f1f27b2c..c3602c53968a 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -20,7 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/log2.h>
>  
> -#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
>  
>  /* VADC register and bit definitions */
>  #define VADC_REVISION2				0x1

