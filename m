Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F546BA81E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCOGoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjCOGoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:44:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7CA22A1E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn21so41259546edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOa0WQsy6rjgPrmZmoGvG+kj2BjHn9uHAJOnHryaHDE=;
        b=W53RfkmTAM+krIrvhhjC7t3aQVcpgwsBWYDxifRoEGjAQG30P46JqbEphXpWsFkX1I
         gNULgXIuqyQu+TRVwtzRSypJ6kLBZYgoP/D/uqlSrmODKjPGbDNsvXuCd2PsDMY+XLRy
         z7UDry8hpQqOCqfr+2bKY5QuaFcsP26t3LCD82uCYJmbyb/mGVDCvhTwE11E+mDKCFUt
         ATZPwiC7gp8vUa3nSR3efYYi3vAv8YGf433WGubqQqFm5t/Ten2X0j5lpj33ymhVE21r
         M3K9VQDsbjk2YJm9M4772Ygc1vBCiHXJGQOo0dgPMfbzZFBkFzAqvkuvjnNxdwa7/cOs
         cDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOa0WQsy6rjgPrmZmoGvG+kj2BjHn9uHAJOnHryaHDE=;
        b=mRR9CHjlGMdVfg9wNDLqUepe9ZchgbwNBCv+cT+/E1Dom7kOxEEV3E8/IKUIVQ+Fg4
         KeNhDL0DKf9GvghYLELgk7gF7h5Hj0CpC2sF2wF7L3GKEmtTiIgTzVh5MgoxDZjVv6C6
         AW6h5lwRIQdkKOGUocCiYVEyDi0aHSeJttyg3MDJvPfPyWAl/lvKwkbLYxHac2QH8CIJ
         u7fekNsvhvyMNuR9eVrLyFRWURkJkzN0vN8np6rwWZHRd7u5R/MObiq/HoDsjvFuz6hx
         M8drF+Be2nVLvAPz0Jhruvljs6JnhICZENet/eyu5XDHVd1lB9wqzrh3TMg99Du1JWE7
         kD+A==
X-Gm-Message-State: AO0yUKU+XGlylKmE1hwaG7ccl5S3y+5gHnAbJWt4Sv3tyjbFTm0WECNN
        RWBzJ/DPT2ZSyL2PKbYR8RHDVw==
X-Google-Smtp-Source: AK7set9QKOIRDNTWFKYHPmSPe7kxYDMGZw6L5D3m/QvOiZHAwDn7nygVP4kLxb8dCZyAr0ddrJI/ag==
X-Received: by 2002:a17:906:702:b0:913:ff28:59bd with SMTP id y2-20020a170906070200b00913ff2859bdmr5220664ejb.52.1678862616630;
        Tue, 14 Mar 2023 23:43:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906724600b008ec793ac3f4sm2031952ejk.192.2023.03.14.23.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 23:43:36 -0700 (PDT)
Message-ID: <edaa631b-9bf7-5cc7-bd92-fe5420553fa8@linaro.org>
Date:   Wed, 15 Mar 2023 07:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for
 QCM2290/QRB2210
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230314-topic-scuba_socinfo-v1-0-acd7a7ab9d46@linaro.org>
 <20230314-topic-scuba_socinfo-v1-1-acd7a7ab9d46@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314-topic-scuba_socinfo-v1-1-acd7a7ab9d46@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 22:41, Konrad Dybcio wrote:
> Add the missing IDs for scuba and its QRB variant.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 2 ++
>  1 file changed, 2 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

