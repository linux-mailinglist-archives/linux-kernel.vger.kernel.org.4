Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DCD735167
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjFSKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjFSKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:01:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66035E5C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:01:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51a2de3385fso4584801a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687168891; x=1689760891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mi0odYZrNrQKpGzw5pHs6LQO/1iyCGY9vkdXXwKkTF4=;
        b=L+yWMlBqSShj9sCq4emOy+ZP9U+SEJeb+06+PNfJW+hYojJwsDXMUbgjFV6jKeKpjm
         cxyLBTMywkj8ODTab8jKv3kWzIt98Yp7wvAATmXLFPEwIG43qCzBj8jyn8rRfpa3HAXT
         XFWfe9A3YQfW80ScopExHmLkWUC0hV+g8vEocIXnFgd4P43IHVGQgqBupJ65fcQTGSRk
         AyBbeYvEusX6q2KvMe8+mjmkmxsiCZLhQBAMaioWkENpt3uIe+QSVM2U4DFGWtVv/38B
         GODElrI693wmoWAtwZb7OCxEzHWSueBG/EPLVLDZWnRc37n2iv7Smk+nOdJCKLyUWeec
         19bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687168891; x=1689760891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mi0odYZrNrQKpGzw5pHs6LQO/1iyCGY9vkdXXwKkTF4=;
        b=VDQceQoM8roV9i7MJTkPqAIMS/JhJxIntC3nN3Bg+DAPIykpiidRaLch139ILse7Ys
         GJa9I5+HYOjCgquAVeytMC2cnTL+lCOXWxAuqUFfkIHRGtW/o3amRINMP7gxBbhir2x2
         SVZX3qFXx2EH960zBf1x+7d1eGbehChgTfTtMQXFzi12zIqM4jR7PAJpoDQSuZ/uOjrI
         zO1gIjX1mxrWJ7iWdz7yueL+1S7iM0EIp7c9qilMmAcioTgxY/EUeoehqUGkS5/dOJRP
         O28HJSWS48k3RGPYrJz3f0wG7+dEDmkg2fpymM83GYtxx5VzM2aTcEzt0/JiEmSudB/8
         JseQ==
X-Gm-Message-State: AC+VfDwpU3h4mF1swBcxlZzkuPD/CkUuqJMqWVrK3UxBGM4ybq6UaTnd
        0j2eH6+6onrfEuI1SjexOL5Elg==
X-Google-Smtp-Source: ACHHUZ7iLPMfAVkQt+pj0GE9+mhW4YCjeFhwk799Y3AhojRcbkBWBNp6i4fChge21Aam9eSkWvKAew==
X-Received: by 2002:a05:6402:12c2:b0:514:9d2f:10be with SMTP id k2-20020a05640212c200b005149d2f10bemr6230109edx.18.1687168890853;
        Mon, 19 Jun 2023 03:01:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o8-20020aa7d3c8000000b0051a575c76e6sm1368098edr.43.2023.06.19.03.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 03:01:30 -0700 (PDT)
Message-ID: <c65313c7-c1e1-3a51-9fff-4324701ebfd7@linaro.org>
Date:   Mon, 19 Jun 2023 12:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] dt-bindings: firmware: qcom,scm: Document that SCM
 can be dma-coherent
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>, andersson@kernel.org
Cc:     amit.pundir@linaro.org, Will Deacon <will@kernel.org>,
        sumit.semwal@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
 <e89e574c-db6d-877b-462c-bb91cc9d9ff1@linaro.org>
 <23cecdde-2b24-a472-1497-5da9f1158c00@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <23cecdde-2b24-a472-1497-5da9f1158c00@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 12:00, Konrad Dybcio wrote:
> On 18.06.2023 10:07, Krzysztof Kozlowski wrote:
>> On 16/06/2023 17:14, Douglas Anderson wrote:
>>> Trogdor devices use firmware backed by TF-A instead of Qualcomm's
>>> normal TZ. On TF-A we end up mapping memory as cacheable. Specifically,
>>> you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
>>> call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
>>> down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE.
>>>
>>> Let's allow devices like trogdor to be described properly by allowing
>>> "dma-coherent" in the SCM node.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org
>>
>> 2
> Forgot to press alt or something

D'oh!

Best regards,
Krzysztof

