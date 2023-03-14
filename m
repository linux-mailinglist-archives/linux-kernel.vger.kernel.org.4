Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAED6BA053
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCNUCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCNUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:02:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99B211D0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:02:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn21so36684234edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678824136;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAsT3cuqeiuUE51X39OV5S/2rz87hdaF+tGn89n6biI=;
        b=T+XLih+NbiaYi4VFLKYWwqizBVlr0iG8hVJndsVq/eIZFn+pWrlenWF8GgbD/cFj00
         8S84zPFmMy/wfZbJdEDCg0e90KC7f3NHsacMVL4A5Xvxjd1WFh9cGkTMbBHIQRgEVTuG
         zCfLwXUcyFjIQCxpFsJT7m3m2ZmWOCTLEWRgCAhGY7mlynyH4waVTcU8IYg8pmdHJAKw
         gU5ByDczHzQb+cBAFkmK6z8c2jydLe6OxfojvRAHh9BYPl4TqyCF4tC74MsAia+gG/Br
         089XE7QEg+xchWJLKkv3d+xN5QF7Z0ltC85HcIpfNhSR0Wi7K01qUULOSzsI/Zqt2Jf+
         KYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824136;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAsT3cuqeiuUE51X39OV5S/2rz87hdaF+tGn89n6biI=;
        b=5S9v5LdIdl+luGDf3MX/JZ+3tjCEWdQeBTZFqCe17B5ZHHohRbGu3fSS1+/gONuh+U
         iLRZCmw+uqhwNC8dcxG3lEiluiGwTVLwa9k3RYYghLxc8BdfVLD4GDOJ6KXgoAcySoph
         Cnze0e0z6nURN8QmmNq1TUIBn0ZSGv7Ts7XKidPOp7VLQKitwwFOgUiIFETvB4CmlTuj
         5gtoMl9KWoCcd5i+I1AWwM0uzWZ3VZ04AHthuNicYK9wohKcUEwT8BwXgPzcQVJCO4gW
         mWLWuyV3qKHe59OCKxMWIHUDtv36bAhTIuOPJwcW1xzEazpWTeJqjU3d0ow0CRevb4cW
         k8Bg==
X-Gm-Message-State: AO0yUKXjbttP9MnT5qsovYQRdmJ9sEQ81ueRGDYAmEnfRRl7Jkwvff7D
        egBN4+v2JJL/JOxxa9dDjXjhLA==
X-Google-Smtp-Source: AK7set/6hJZaokygSLSid5jq08Z7SYeVms7/Q4MpfEYRkLnfJAvGCxAEClJ9bdCMmjzDaiLzWmXVSw==
X-Received: by 2002:a17:907:7609:b0:87b:dac1:bbe6 with SMTP id jx9-20020a170907760900b0087bdac1bbe6mr3841323ejc.36.1678824136270;
        Tue, 14 Mar 2023 13:02:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:642b:87c2:1efc:c8af? ([2a02:810d:15c0:828:642b:87c2:1efc:c8af])
        by smtp.gmail.com with ESMTPSA id m22-20020a170906259600b008f883765c9asm1525341ejb.136.2023.03.14.13.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 13:02:15 -0700 (PDT)
Message-ID: <3ff584d9-a782-dfa9-07e0-df5c960e7e8f@linaro.org>
Date:   Tue, 14 Mar 2023 21:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ9574 and
 its variants
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <1678774414-14414-1-git-send-email-quic_varada@quicinc.com>
 <1678774414-14414-2-git-send-email-quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678774414-14414-2-git-send-email-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 07:13, Varadarajan Narayanan wrote:
> Add SOC ID for Qualcomm IPQ9574, IPQ9570, IPQ9554, IPQ9550,
> IPQ9514 and IPQ9510
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

