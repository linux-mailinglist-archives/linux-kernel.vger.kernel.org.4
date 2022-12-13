Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5174F64BD87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiLMTrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiLMTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:47:43 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB39725FB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:47:38 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id v11so4455926ljk.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tu4T3K2HKwcynTbjPctmZ3m/QXC5IAhHVs8lwvc0TII=;
        b=l214eoYPQklA4l1bmpE99Koa3Jap4GclEp6H+yAE971kiSyp9NEUEdmcPCRQIvG2vp
         /3kzZXt66f0DGnSQZsiUSqq+gwkaaKQrRZY4y8VhGN/QErXa0996y6eUHiFk4SnEb1Cw
         6go0nqWEVHMwCf7gGzaqurSBvPrZFkxKLV/r1HyqvgN96ZakbRCNxw6BmIR+u1FraqNp
         x1O+oMfa2nmAb7bLx1Cni2QBtvBhpQHvTxXUP91uXGxnn3HYO0FH4u0kWR4LZ3FKCEcK
         Pz3hjyYJmCEOiURvu3+kuxlEPVb8b0Jghq28I8wdCJ6DsS71HNir5ZcvqY+r4NgqA/0C
         TQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu4T3K2HKwcynTbjPctmZ3m/QXC5IAhHVs8lwvc0TII=;
        b=KQCFvBH4LyHjXjRCKZNImV+/zvYKC2o0Ytf0Ruw/GZYPkCb0BYhFZ71zYUWewDVN4c
         snauam5iH2b2JHZGz5dt86U2HbNKy8K5+K1dfNmdDbbLSFXJKx98wcIg2/XrsMC437NY
         hEY97Y+MyBtnMoe1xkrrZrKmmvM3SwH33elYt7Y02AhL5Krc6yu+RaVa1zX+7bMfZWjE
         ICgghZhhld0n8pxN0Xr9gCYo3rtOu5QhoADAt3/qrQun+txu6MDA4bmf7aP0evvE6GhZ
         cEQ/o1M2ZmK2APRtAN1Ykmqzf/n7jJaIpkZ7z9YsiQPmR7xXzh9z4AtIM6pY4r0Y+zYH
         huxQ==
X-Gm-Message-State: ANoB5pm1nhCW5CR3Ng0Aa5N/oo+8hnykwNagaF1Ef+FCuBptsOS80eQ0
        ImKI3fdCGm+vrRn3M+7odV9MLg==
X-Google-Smtp-Source: AA0mqf4myCPdPeXg3zY++eDaQGhgfFYnJRdwyrjv4AIUvHr6bFcRkg3e3wOeKJrkZrwh/FqtM5jx5A==
X-Received: by 2002:a2e:a371:0:b0:279:e2cd:9ad7 with SMTP id i17-20020a2ea371000000b00279e2cd9ad7mr5254670ljn.0.1670960857052;
        Tue, 13 Dec 2022 11:47:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u16-20020a2eb810000000b00277041268absm377613ljo.78.2022.12.13.11.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 11:47:36 -0800 (PST)
Message-ID: <8739f59b-c551-2da4-5523-a89f960bd402@linaro.org>
Date:   Tue, 13 Dec 2022 20:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com, robin.murphy@arm.com
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-5-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213140724.8612-5-quic_sibis@quicinc.com>
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

On 13/12/2022 15:07, Sibi Sankar wrote:
> The memory region allocated using dma_alloc_attr with no kernel mapping
> attribute set would still be a part of the linear kernel map. Any access
> to this region by the application processor after assigning it to the
> remote Q6 will result in a XPU violation. Fix this by replacing the
> dynamically allocated memory region with a no-map carveout and unmap the
> modem metadata memory region before passing control to the remote Q6.
> 
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

Thank you for your patch. There is something to discuss/improve.
>  
>  	return ret < 0 ? ret : 0;
> @@ -1882,6 +1899,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>  	qproc->mpss_phys = qproc->mpss_reloc = r.start;
>  	qproc->mpss_size = resource_size(&r);
>  
> +	if (!child) {
> +		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
> +	} else {
> +		child = of_get_child_by_name(qproc->dev->of_node, "metadata");

Bindings do not allow to have child "metadata", do they?

> +		node = of_parse_phandle(child, "memory-region", 0);
> +		of_node_put(child);
> +	}
> +
> +	if (!node)
> +		return 0;
> +
> +	ret = of_address_to_resource(node, 0, &r);
> +	of_node_put(node);
> +	if (ret) {
> +		dev_err(qproc->dev, "unable to resolve metadata region\n");
> +		return ret;
> +	}
> +
> +	qproc->mdata_phys = r.start;
> +
>  	return 0;
>  }
>  

Best regards,
Krzysztof

