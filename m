Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101086E3761
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDPKWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjDPKVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:21:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5D5B8E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:19:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a5so264104ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681640357; x=1684232357;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQ2pSbWS+VnJQa+rka9MRnpcuYtmOv6aRPbfjmRczfo=;
        b=CHgLPHJr3sdJV5BUyzdFwSkUgyZixULskPWaSH2Hn9KzlENG3/SlIOd9rPjsK1RerT
         itBE8Uwcpdo3b8x7BM8vdCKIADKOOi1aOHJ1TqXjOCtKmyfPJ+knH+CPr1P4eoDQfW73
         iYcwAa8c3MgtJAXDlW9GlBp+Y33jia14jaBYANBRn3k9FhtOBNbjJ8Te4voHCAOh2Z8u
         kEPPbqFIgBdAFC9uQn4PEw8wT0P9VQke1ryhMEmaT1f9SP5NnFeZ8gbVo6eE5X0jsvDB
         v+EdBbr+/p5OLefORpS3BBxWjAuIFyQUFLgc2k2VFjIP/22gcq8NxpyAdr4nPULmDR4z
         rO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640357; x=1684232357;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQ2pSbWS+VnJQa+rka9MRnpcuYtmOv6aRPbfjmRczfo=;
        b=HmHB3p0+c7k1jWcioZh8IJDCb8xx9uIG3JN+6DGxCJLc0QrWvFe9uU6urpIPQKReCH
         244marKroxFiqK6S1WI1rKeVXtVvUJb7fjLwJReMxulcczp0hn5v8Nv1SEExaL7c2yjc
         UFl/hNY4SMT1rtBLEsHwXmvilRFKO03GByxntiQ5OGJsh/OD62iyLuUfZpQL3JMiwWCW
         eVVRm3FeaRGx6ktvj2xkqC2oTxRb6vIIQ3apOy1H2BmQAf3oHsSPELGtP+7t6KvQN3sP
         /lrcmlPYtCftZ8qx2bqf/37E3LeTQNS9iOGyAVoypfXdzQbQENnsnv4eGPxk66xQXApq
         fqjQ==
X-Gm-Message-State: AAQBX9e0ISNas+t7AZ+s5xqziMErUsUAu3fqsLAdPezuSLMwNNhurjuI
        NXDPMF8SxILknwQLNl8cFCXoiA==
X-Google-Smtp-Source: AKy350ZJ3oonRhplCGqgST+8seRhbMoZGcq/ItBJs9vGaQcqM0VK6aBZd2ELjWPgX3Z9uNPSET+PWw==
X-Received: by 2002:a17:907:2c42:b0:94f:2948:b15e with SMTP id hf2-20020a1709072c4200b0094f2948b15emr2730962ejc.5.1681640356716;
        Sun, 16 Apr 2023 03:19:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id xi11-20020a170906dacb00b0094f62181917sm394859ejb.138.2023.04.16.03.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 03:19:16 -0700 (PDT)
Message-ID: <1613da77-d77e-94c6-802a-b2d856c5b40f@linaro.org>
Date:   Sun, 16 Apr 2023 12:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 1/2] dt-bindings: watchdog: qcom-wdt: add
 qcom,apss-wdt-ipq5332 compatible
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230320104530.30411-1-quic_kathirav@quicinc.com>
 <20230320104530.30411-2-quic_kathirav@quicinc.com>
 <0569ed09-2241-d981-4e0c-209caa7483ab@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0569ed09-2241-d981-4e0c-209caa7483ab@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 06:39, Kathiravan T wrote:
> 
> On 3/20/2023 4:15 PM, Kathiravan T wrote:
>> Add a compatible for the IPQ5332 platform's APSS watchdog.
> 
> Guenter,
> 
> 
> Without this patch, I see dtbs_check failure in linux-next.
> 
> 
> I see you reviewed the V1 of this patch, can you pick up this patch? I don't see it in https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next
> I'm not sure if I am looking at the right tree, Please correct me if I am wrong.

Are you sure that patch still applies?

Best regards,
Krzysztof

