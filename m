Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3137177FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjEaHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjEaHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:22:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90931E74
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:21:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so7298578a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685517712; x=1688109712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4TAHA7x0iJF7j81brHbSoY+8EOqngGbbUKsqhzvURM=;
        b=ZeoMnpARxNKsfrE567KvKbKauHAZbdpvkdg1din0saFWLU+qjDf3U1UM21aGQDFn0k
         RKpvSX2ve8SLu8C0ECLeIF+aAPffF/we77TPGmz4MTg7zWAbN0zkRXZsBPqAYG1uM4AK
         bdQ+Lmzy3mn77596i9QSc7aZfbbpRNU80rfqNUPiLkL1R0fzs1lRvLwpST8sm6Qd4+/l
         v0kMrlgLeGqRK2h+o46vK6CRv+KTMAmgHmjhOlv5SDX6vrgG8r23qlEOGXiJrcliWvz0
         1v1npevZ0s+PD7oFBqAS/v2nC/rvpCtvqXl69vmbfhw3eXPZGlSP0lp1Tsg/k/FoU873
         wjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517712; x=1688109712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4TAHA7x0iJF7j81brHbSoY+8EOqngGbbUKsqhzvURM=;
        b=VU0eeyPmwq34FEZ6h1nOwDnb01U90RGMdJofUS8JOoadhog+lCsS9csqatxj6Df7eF
         HtUZPYXapPAPQi71Q+rWQ71HknsAF1OfqlhclRcOAcZpuP7lsbr5Qm/EYpduA/EPioVM
         l3rhLQTOm29qW4H8+L94scHk7InCk3P8T21YqsGzYSriRHIv9gNw2GfhowouYxNdGV5t
         HDQT26k5n2gUyxEylXKT0GFrgDrpWTEfONZfU21SU2KoaQ6OQs3BUSeTh7dgMcSpP5pd
         f3K8MLmKe+wcgsuUS4D7oKqiWIUZtVPVgcAcuyd9Dd7NzPeAwyDLVHo/3KpUb67V6G4u
         Dm0w==
X-Gm-Message-State: AC+VfDx7VXerTWHVsRYQSPM0xq67StN4QnxpFnebn+k39sf9sX0h9oPN
        5z6z7jIhQ2UffB0nLLB/z0xcaQ==
X-Google-Smtp-Source: ACHHUZ5hrn3tCdyfOdPtVUqhfID3kWZCZIiOWYvMvR5CcygQTLPxTL5zulWCgdk+sGzPVPC5+44ung==
X-Received: by 2002:a05:6402:392:b0:50d:88f3:2e30 with SMTP id o18-20020a056402039200b0050d88f32e30mr3107652edv.13.1685517712533;
        Wed, 31 May 2023 00:21:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id i16-20020a056402055000b0050a276e7ba8sm5267379edx.36.2023.05.31.00.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:21:52 -0700 (PDT)
Message-ID: <52309a2e-f314-5644-96fe-110b8c277e58@linaro.org>
Date:   Wed, 31 May 2023 09:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: watchdog: cdns,wdt-r1p2: Convert cadence
 watchdog to yaml
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@amd.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        radhey.shyam.pandey@amd.com, git@amd.com,
        neelisrinivas18@gmail.com, srinivas.goud@amd.com
References: <20230531052812.2221823-1-srinivas.neeli@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531052812.2221823-1-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 07:28, Srinivas Neeli wrote:
> Convert cadence watchdog bindings to DT schema format using json-schema.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

