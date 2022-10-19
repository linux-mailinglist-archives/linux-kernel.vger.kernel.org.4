Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B026037B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 03:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJSB4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 21:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJSB4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 21:56:02 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D69E692
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:56:00 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o22so9885935qkl.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbuyLOS+JRyzEpmCn5RrPtwmC966MBi27hx/wKKVja8=;
        b=nD8k7jWWU7cz3OlVNvMb/w6F+MeLTIfbudjR4jU3PX2PdmIYS9SexoHxQ9fK51UPQy
         ikGUz34oxoq1mobxI9u2pYsNDSi6UNAkz/oju+BMllE0YeOBM+/vSnyEfbibYrNYj4dx
         GJISc+sNQqmIZqWJLvRJUGOo7fk2plRVoK5tv7CjCQw50fIDBl2VluF6KrimvPEllwYX
         erO5J5pkWGNpgPzu9SNACpJ2KYLuV83FhpGYLksdl9d90e+X6/xNApaGv0sX6OxWG655
         7k2j+jm2QLNVZlh1KswFdsu+Y9e2Bgk6r8rJk9GFnb93bsqDNneU8dDwfgYPcap4GDGr
         EwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbuyLOS+JRyzEpmCn5RrPtwmC966MBi27hx/wKKVja8=;
        b=CxpPU1/cpgBlHzrhmGyS6cBrJatgN6+3L5aBEL5wiXP8JguOrz0C3hYbXvXWQZrnEI
         sHvyolD4lBXe/V6ZqlA7bBID93MjsxhbUv5+mMYNJpPPigsFmqTuoB124AUsD8JUXUJY
         k/F+bAaA+npaed5vQ3p3N2+vj6zdzmr+R3bZ4PPBIVR/XjjNjhgsjq/NfpTiLK9UK+zs
         TH2cOYFBLOLszVRqPamCxDFb0DL5Mv6G1w7+gM3FPT5LF7bBJCK7iQm0/sJScnt/EMCw
         hC4i5HGttjqhfV5aBaauheKvJknFxpGbv9pd46EtasdbZkPdHpMcrVE9Dxrkl4wmhayi
         HHtw==
X-Gm-Message-State: ACrzQf2Ddx9X+UeTnEe0T8/as0wtKUEiSSoYIjgfioKnGyb4v7z2yw3g
        mG5Z6XifHdE66FVph1YdjzH3+Q==
X-Google-Smtp-Source: AMsMyM5nrTseSQrkT4MYX8DqkNPsjNkvCu1M4qfGSoreOtEgPhivaGocJGwdPTxocNa8kVSGzSrH6w==
X-Received: by 2002:a05:620a:4398:b0:6ee:be9f:435c with SMTP id a24-20020a05620a439800b006eebe9f435cmr4037108qkp.35.1666144559726;
        Tue, 18 Oct 2022 18:55:59 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b0035ba48c032asm2966345qts.25.2022.10.18.18.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 18:55:58 -0700 (PDT)
Message-ID: <faf716a9-8dc3-424e-2f16-3e4d66b3246c@linaro.org>
Date:   Tue, 18 Oct 2022 21:55:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 1/1] drivers: remoteproc: Add bus scaling capability
 during bootup
Content-Language: en-US
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
References: <35eb4ce2bb8f3bb78a616c071a012f1f49d8b593.1666127246.git.quic_gokukris@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <35eb4ce2bb8f3bb78a616c071a012f1f49d8b593.1666127246.git.quic_gokukris@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 17:10, Gokul krishna Krishnakumar wrote:
> During bootup since remote processors cannot request for
> additional bus bandwidth from the interconect framework,
> platform driver should provide the proxy resources. Make
> a proxy vote for maximizing the bus bandwidth during bootup
> for a remote processor and remove it once processor is up.
> 

(...)

>  
> @@ -265,6 +340,7 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
>  	clk_disable_unprepare(adsp->aggre2_clk);
>  	clk_disable_unprepare(adsp->xo);
>  	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> +	do_bus_scaling(adsp, false);
>  }
>  
>  static int adsp_stop(struct rproc *rproc)
> @@ -383,6 +459,22 @@ static int adsp_init_regulator(struct qcom_adsp *adsp)
>  	return 0;
>  }
>  
> +static void adsp_init_bus_scaling(struct qcom_adsp *adsp)
> +{
> +	if (scm_perf_client)
> +		goto get_rproc_client;
> +
> +	scm_perf_client = of_icc_get(adsp->dev, "crypto_ddr");

Aren't you adding here new DT properties to the device? If so, this
requires updating bindings.

> +	if (IS_ERR(scm_perf_client))
> +		dev_warn(adsp->dev, "Crypto scaling not setup\n");
> +
> +get_rproc_client:
> +	adsp->bus_client = of_icc_get(adsp->dev, "rproc_ddr");
> +	if (IS_ERR(adsp->bus_client))
> +		dev_warn(adsp->dev, "%s: No bus client\n", __func__);
> +
> +}


Best regards,
Krzysztof

