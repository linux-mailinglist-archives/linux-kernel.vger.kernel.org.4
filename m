Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC3A67F72E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjA1Kji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjA1Kje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:39:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A54978AC2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:39:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t18so7100791wro.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBB/UrWepXBkkfPd45IwxI+2oUrHzDJVZIL0q4lKLdQ=;
        b=JTKqHAytmPbQXk3+t7QAF91Sbvylmycvn9b9Xqpbu+tkUZ8DKWjQI5yFlHhhce9C7n
         n0naK1rAnkUKdu9wo0RlUMs9F9TtL+OiKvAhYqDBCni92qZbHNrj2VDPCdRnyjyVdjLO
         dmb4I7d3F/rX9gL9KqCHgzNtb/QLBdfMHAY+6p9gnGIm2+H08Z7wtdNZ4EVOMwA6kaFQ
         0Io+IU8a4OTRVkgELi6/udFAj1gocAqP5GLK6MGloIn6mfa08eFB1lMcTTE/wMW9sr7f
         QdJzc2fYd27TfNohiTNKlb2rs4iLDKxGBcur1sNJQcd//7z8zJx1M3MUSnPo/2rI2Oyu
         dh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBB/UrWepXBkkfPd45IwxI+2oUrHzDJVZIL0q4lKLdQ=;
        b=o5MrfKwaOi96YFk+ar+7/ODSYyw2OQYUFwzzVRDJL/oumLPfs8rTtXvWdVeJ/QDCCN
         moAfRM8BlCo/IEENu0OMdH6YYoj95W+vQKe8wNKjOr14gCT8VOsaQlNO888mD+HHk0Zx
         CUvAuoR6obWyjcx7mKvCnPDuQO4xv6ciQ6WY828BHqEsh4Pr362shrkiwgw44C73hcsy
         Pgbo5Rj6t6/1Xezdif822BKh8OEnA/OxYljamG22AijXWK0YPoTSI2R7tfRTsE51kLRm
         H9WxBZv+/ZoQknD3lVvS3GlqG5KTPXNkEBgiwDZQPXtdNPuRYHN67Tb0uRQRPDI5KTti
         p+Yw==
X-Gm-Message-State: AO0yUKUbj+d53v2W0scYxKYuLbYbvSMumM2KYGthDvHSyoapgdO18z9J
        ClVaSQe5zgO0YHm1jdiphmnBLA==
X-Google-Smtp-Source: AK7set+Zk9DiBCZq8AhGj9ng0r6KKDJ850gbX0mVQjmwnTlgxBxrDed1NWcHnxk7tB3Ixi0Dug+JVw==
X-Received: by 2002:a5d:62d1:0:b0:2bf:d680:e37a with SMTP id o17-20020a5d62d1000000b002bfd680e37amr3988339wrv.67.1674902371978;
        Sat, 28 Jan 2023 02:39:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y8-20020adfdf08000000b002bfb31bda06sm6644422wrl.76.2023.01.28.02.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:39:31 -0800 (PST)
Message-ID: <eeed3984-3ad2-01c3-365e-443ab664bda2@linaro.org>
Date:   Sat, 28 Jan 2023 11:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] regulator: s5m8767: Bounds check id indexing into arrays
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230128005358.never.313-kees@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230128005358.never.313-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2023 01:53, Kees Cook wrote:
> The compiler has no way to know if "id" is within the array bounds of

It has. For the CONFIG_OF (the only way parent device - sec-core.c - can
match now), the id is assigned in s5m8767_pmic_dt_parse_pdata() and kept
within limits <0,ARRAY_SIZE(regulators)-1>.

The device cannot match via old non-OF way, so there is no real bug to
fix. You are silencing compiler warning, which is fine, but it's not a
real case. The code is not easy to follow, so I am fine with such checks
(WARN_ON_ONCE). The BUILD_BUG_ON is indeed meaningful.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

