Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238235FFAD3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJOPMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJOPLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:11:46 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41B46215
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:11:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c23so5412493qtw.8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/qITi2sMe/4RHK/tzkxeucS4gyS4NVUV4PzxDYNBz4=;
        b=TdKhvKmT0bz+zXXyglbNGFgqqZtLVMqVo6HEg62mHvPHFDJsju0HoIkx6M/v2TZ6J3
         HNpr2vWla9cw/VrXcEPu8NB6BZWcwSF2M3c+jdp4gejcAHCPvutiIqGeOgwBL/Wu9Zeh
         nQc9Tzq+TUgLkrw+4LfF0ju0MOD6ftoLwNklamSKmf5qgqU4652tVym1usuSE90IBv6P
         4Jejoa6Veh1PjFYoffmxetUN3a3UWRTAc55zG0IYCuyd58GYsYfhq4tF7vNxVAg52I/M
         ndsdGV/+1PYDvA5GW2DAtvy4np3Y1zVhS1LdJhz9ZvHP4x8vX4cRN4fz+wJOM5s/3PYK
         Vtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/qITi2sMe/4RHK/tzkxeucS4gyS4NVUV4PzxDYNBz4=;
        b=MpqYe6XTL3L2TSKzKbJa67jUlVHVmn+nc7iDXt4+0PTO4K8Dyc55u2uG4Dt+9SOeXB
         MrTP/QWRYMm+TFBnqxQzsrfqlUJhStiYtXOYdsOuWiFdJo/NkTd5aR8pd0hRPXa1RDk4
         pgnVg1VemZeqfthAokdewsM83lf4hBQwv5biay30uRZug3j2F/4bB9Z3ZcZPxGFjVlJQ
         dPqT13+cgXJsojkdghIwcyus4fyQ1n8DOfjVQeGWxpgvhg9Pbkx30mupW5LWcRCLyH2+
         Yra0dRmdollMH7eb+wD7yj4rSkkCopFExm1a5aCMrVMsAMbh5T/V1hKzF6g9Q9F4tZ5s
         mmJQ==
X-Gm-Message-State: ACrzQf3RFuIRwX20WjKhTG+mEhag5cbSvfwh4ADLYKfLOwcvxcVW5dZt
        mjPIFLvJT5Jg+SV+wtQbBhKnZw==
X-Google-Smtp-Source: AMsMyM4noZrDRWTjZ8ITC7rg+4g+fK+kvDk6sWhdd4S6RC5TTMPw0t5GMfGZngMX5aiv0vQpo2Feow==
X-Received: by 2002:a05:622a:4204:b0:35c:ddac:9896 with SMTP id cp4-20020a05622a420400b0035cddac9896mr2278395qtb.478.1665846699272;
        Sat, 15 Oct 2022 08:11:39 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9477:c2f0:ddea:ea08? ([2601:42:0:3450:9477:c2f0:ddea:ea08])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e711000000b006aedb35d8a1sm4868000qka.74.2022.10.15.08.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 08:11:38 -0700 (PDT)
Message-ID: <0728b66f-3e1d-101a-3e82-aeb56447e1b2@linaro.org>
Date:   Sat, 15 Oct 2022 11:11:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221138.7552-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:11, Melody Olvera wrote:

(...)

> +
> +	firmware {
> +		qcom_scm {
> +			compatible = "qcom,scm-qdu100", "qcom.scm-qru1000", "qcom,scm";
> +			#reset-cells = <1>;
> +		};
> +	};
> +
> +	clk_virt: interconnect-0 {
> +		compatible = "qcom,qdu1000-clk-virt", "qcom,qru1000-clk-virt";

How does this pass your dtbs_check tests?

This applies everywhere...


Best regards,
Krzysztof

