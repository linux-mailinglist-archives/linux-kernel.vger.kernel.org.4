Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF75060E350
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiJZO3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbiJZO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:29:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2AE1119DF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:29:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s17so10595419qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HepF+4A2/3ZWV1tTO7JvfOk/wi0W7kiAoRviokUEQWk=;
        b=xmhb1LPv6lF+utwsSzmBJo6aHeftPiH2Kyv4Bvr4KAlYL2U4tSNzSstC39opm1m5Rs
         Aszx1vnXqIpzkkRmAtd22JdQo95UE/RT1/6x0tAhvHJ4YwrJj38vaAv/uGIvh9sESCX6
         LIaVQCQHFwjJNL6ZhbLZfFEyHVG+XE47c0AoymmQS5/pkgVunpLDSldYJHlsbUivK3n+
         OPsEEcb5gI0GbyofsB8lEcGs5BcpWZJDpHwkM6DUicGJ6YJHxnAg7gQ8HtvxqurK917c
         8lXs2vckc72kTJN2aHETO3eVnL+u5khewCIpyjaqZmDTxILwvBAkGxklGQRLTfLUD7KC
         VIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HepF+4A2/3ZWV1tTO7JvfOk/wi0W7kiAoRviokUEQWk=;
        b=ultPCdBxeOyyb5lUyBKZyssSnch3r31Xd2CfQfwE0hFdSOu5q5tQ116BMEAnylEBS/
         NUqPA5O65tO5eeSksLd0KK5tt40DNAemKQf2MI/Qzdu72A3ozAs6gyY5SyC/YQfxsqDb
         yX7yGtItxpMWQoqu/p5QTSYN/3lh91tTlU7A2GH2M34zL8Hzl85Dsl8+kWQGZ8O/926M
         gOiDGYTyUaHmbzHUP2/EDziyuNBY1eK3t4geSEL1394pSRVDzRTHY5fSklkqFKywL+Up
         CWPdqzaXCrVdjmqg4nPJfdJfGFU2MSX2DN/LecelZuF1VHU+yOBLT4ehc7R2qGcHN/8I
         bxwQ==
X-Gm-Message-State: ACrzQf3+B0oHnoSfZiHkW+ghaCbaVhQnjUqcsiYooqueLOzq3wJvasoW
        C36dLjMlgsEttVX4FuOr7+zcLw==
X-Google-Smtp-Source: AMsMyM6lpu83qpTJZs3g3pyaL3a9mQY9MGnGVNyB0/eSs1gGWO65GWGZ6/h84n2kWseHL1Vvyk1gdQ==
X-Received: by 2002:a05:620a:370c:b0:6ee:cece:c779 with SMTP id de12-20020a05620a370c00b006eececec779mr29445511qkb.727.1666794541727;
        Wed, 26 Oct 2022 07:29:01 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a255000b006cbe3be300esm4011966qko.12.2022.10.26.07.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:29:01 -0700 (PDT)
Message-ID: <5264f9e1-b67e-479d-843c-c92230cfd0c3@linaro.org>
Date:   Wed, 26 Oct 2022 10:28:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 5/6] dt-bindings: soundwire: qcom: add v1.7.0 support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20221026110210.6575-1-srinivas.kandagatla@linaro.org>
 <20221026110210.6575-6-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026110210.6575-6-srinivas.kandagatla@linaro.org>
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

On 26/10/2022 07:02, Srinivas Kandagatla wrote:
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

