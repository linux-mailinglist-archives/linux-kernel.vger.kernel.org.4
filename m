Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30256BA972
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCOHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjCOHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:37:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45346E68F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:34:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so12561787edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678865670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN6r/G4j178xAjD35LALol+t2Sqvd6w3ZE7XijssN4g=;
        b=ZV9MRWcMuD5W3H+dCtdHJKEvYW0JBVWKD/o0dp+I/pdHGzIAnaQb0FKDlLGCa02veg
         e3bqHSwI1ScFeCycrdJQB/RndpFerXOlMviUhpRWYIxD7ANT0jDS85KK87kNjONicTYq
         /pBZgAhACkm4hGdIqGT9OvBMaoOXVbKYNhlRST4+ARFc8moWToWVKXxx7PK5L+zdBqpg
         IJuoYwlW54zwBaaIUM1//XE/SIn01FXNlHTWQ+h21VIO8yl9NaC5AiAV3+TG+V5U7ibd
         NWrhpDpP2+pzWej4MWgWSXpd+R4c42X+ws91oQBAgKzoG5RNhMpj94H6PL6uLestB6Yd
         5dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN6r/G4j178xAjD35LALol+t2Sqvd6w3ZE7XijssN4g=;
        b=wpxY7y/EeIym93WpxMMvMN8b52jLCeIsucBW76GQcMIweCmtM8Mfhy/8vJSccPr42j
         Ah7cmuipblvCBA0OMJzZXGs5rUeltFtQzVPgpyAkk+m1ZhteNGxMn1RJTO0tz3wdwca7
         fZh0eOIiKWzt9UUSwblbJRyP7DnmfkRuhtVSlSJwH0Z61BOEY/X3PIIRd9gqit/poxx2
         OChF2/YfR/XtFZNe8NiabG7IGQXoB85JpqWvPzWzMP1i5++I8VIrejbj8zp7bNg4qITS
         TYqsnwjvs/w/bW817UjvxKfjA4w9guiTpeQwmsM5Z2q3rBo1IlGa659PBIh8w+qCowwS
         2ZPw==
X-Gm-Message-State: AO0yUKVIR7t+qpsSwfNM+kFrIi6hH/A8Bj7TbF0z1a0W/fgLKnF/rJMv
        Q4RecDkX++8xciA3hwz14u92BA==
X-Google-Smtp-Source: AK7set98BUNTb9ud39ZhAsKm9MP2kP5HH64Ghd6xz6wWcQ+TbJD9CROcMbK6qmdzMzUlMWZgD0/s8g==
X-Received: by 2002:a17:906:1781:b0:92b:f019:d5eb with SMTP id t1-20020a170906178100b0092bf019d5ebmr4736336eje.44.1678865670361;
        Wed, 15 Mar 2023 00:34:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id ro16-20020a170907881000b0092f38a6d082sm213748ejc.209.2023.03.15.00.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:34:29 -0700 (PDT)
Message-ID: <86a63e92-445f-ef67-119e-ab605db6bae2@linaro.org>
Date:   Wed, 15 Mar 2023 08:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/5] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
 <20230313124040.9463-5-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313124040.9463-5-quic_kbajaj@quicinc.com>
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

On 13/03/2023 13:40, Komal Bajaj wrote:
> Add LLCC support for multi channel DDR configurations
> based off of a feature register.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c       | 56 ++++++++++++++++++++++++++++--

kernel robot still reports some issues here. You might be missing some
dependency or symbol export.

Best regards,
Krzysztof

