Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A301265BF73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbjACL6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjACL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:58:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F1AE088
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:58:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j17so23825215wrr.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4iFxkM+dh3GZMqkUFfq3y/E2L+P3aAF71qe6rJEecE=;
        b=GQZDJSTnKCGfJukugZI1PmmDvrZt+Py35mUuJkXHwJVNWP8RpP96jJj/OiWIIXU1rh
         LWvfLuz1E6zU092G5EtUw642DDaica3quP90tminmb/nrDW1vk4giTrMb0VN8ehtpxQU
         xfd9u9WJNx2v6DWshnnn+ce8T05SIgDbIW0G3/ItLQuodQPqXrLq5D1C94HWiH2uq5wj
         cnDD+N5hoZGZ4pX8QmU7mQ5HCtRHTZ8TPwnKOFbWtLuPi2RKgWONg/pCtPeqPFfiBEwA
         XS5HH1YQIjHT9FYiTm8Oa7z2W3/EzHJ7ObEUkoqziiIkMFvMAzRIciCDDTLatWqk6kUo
         D7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4iFxkM+dh3GZMqkUFfq3y/E2L+P3aAF71qe6rJEecE=;
        b=dS6T4RqW5Vhq/r7ZhggZ9RDQ2vBITOgsq04dMtP1EHwQICWQAnW+y8Q2AtqyJa2Mbt
         xXln0ClF4Xlg2iI6VHf/okHYCO9IxKVM2ZbtoWWsnIAEp/0bV36TbIgsgWJI238FHGGX
         7WmTA/T5nKZQb/1fMd10zCBw80+QhenQBsxRufWtjj67nBvUAwOisuRH9jp026yoFwnV
         JW5vn2ASwr7y5tHW5i+pRztipcfHrqqKG16lUuZ/CTcq33FnDIRAkgSYjmvDUcOQCgtF
         4Ve+YsPnUE/8BC1ZQpOyN0PUjzrWs9/0rIwUJ7wF/eh9kU3mrjvyrNQhQuGrnXuy8HAr
         /xJw==
X-Gm-Message-State: AFqh2koSG3rOZHiTzlY499CLjF3pwZuWeri3NM0LDm8TYwQP4TcEoF4Q
        evN7W+snE+l04UmULq1u1lV+qw==
X-Google-Smtp-Source: AMrXdXvNFQ9b1oFY+Th2ejLKkbNL63SK0dhKSNOxFebC7wcsjuEQWoZG+6nQgN+yi9lJazAQt5k/BA==
X-Received: by 2002:adf:a1de:0:b0:270:1c24:dbe9 with SMTP id v30-20020adfa1de000000b002701c24dbe9mr26547661wrv.7.1672747090896;
        Tue, 03 Jan 2023 03:58:10 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q1-20020adffec1000000b00281b594c725sm21634478wrs.38.2023.01.03.03.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:58:10 -0800 (PST)
Message-ID: <30179044-6ac5-e487-832b-ce8d0e19afea@linaro.org>
Date:   Tue, 3 Jan 2023 11:58:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/7] dt-bindings: nvmem: Add compatible for SM8250
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213002423.259039-1-konrad.dybcio@linaro.org>
 <20221213002423.259039-3-konrad.dybcio@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221213002423.259039-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/12/2022 00:24, Konrad Dybcio wrote:
> Docuemnt the QFPROM on SM8250.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 

Applied thanks,

--srini

> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index a1305fd68f67..c3d909387e07 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -31,6 +31,7 @@ properties:
>             - qcom,sm6115-qfprom
>             - qcom,sm6350-qfprom
>             - qcom,sm8150-qfprom
> +          - qcom,sm8250-qfprom
>         - const: qcom,qfprom
>   
>     reg:
