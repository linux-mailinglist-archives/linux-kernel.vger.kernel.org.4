Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D56FB213
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjEHN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjEHN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:58:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BC0348B5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:58:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so8307520a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683554297; x=1686146297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BfrDIjMqTKZiD1ewOcwGmbUmHenhPFKey1livh1x2Q=;
        b=HyaKNZGTvaWr3OqxNWmTkbXzYJBVx4iKCVS3IVAaruQK4zZBjX/MxOCx8uKIXMh5Ic
         NEFko5R3TdMOgnTxx4cuQ9xVYZ1p31/0F/nKKFKQuLsg1uYMkWwmbzhzYWw5SuDQowiZ
         ERUPLwuaLM9g2Hm8VtJfRvsYNnr6lkEvyAID3oCdAfok4pawtc9BQG/QnbMrWZKFqFCS
         s8wDPgvkrWXt+EwDaXNAQUv1Yj+BZ3UKetjFDeJWwIqkEz/GonE5AIhu9fI8FjGQNh4H
         vo+9aO35abZFKPihu072s/PIpTfqVNrh+8oN09xj4Nzx72tuHMZBbcxXBZRQRBvfkpsr
         7RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554297; x=1686146297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BfrDIjMqTKZiD1ewOcwGmbUmHenhPFKey1livh1x2Q=;
        b=khwefdvhW7Hfb6aLCUiuJtLd6XTtd2jisBxJmVg2xEzKVcDclXiNkDmb7hx+SiyfMp
         7sLZZj7AImdlwUxNFw1e04zn9+CSA5xAtQw6Lf6nczgiamtDVGFdQMdfm/KfNlJkWTJN
         PY0M+iTVxZz46aQzpn65Og97ybVbB3As7RPkrwfyPmhk3wGNJ+U5J3aFVU1CRP7BFwc7
         vvM76Qq6i31vzxzcX00Tf2EzLmVD0+wTQDsfhnTp8ptfFdlql+21vIDcnx5mBMZSMvN6
         qW86l8xW6M6L7sp5ragYZwj/LGZAWLeaeCDA1/qXD/jYxX1SOwzyRVe+q7SY0YBnBKsG
         9dSQ==
X-Gm-Message-State: AC+VfDwXnHPnBZ2PrlnsmawndHxP2V9mOaKn5itkdLjw4rNf3mrr5PLd
        9lD9AUkEGX9YYdiljo0cjT9Nzw==
X-Google-Smtp-Source: ACHHUZ6VUqRfOfZ9KNrPu1DCqDKOb5ZneCI8h4zb5xcJ/YTsG/2CQz5oru5ZL2Jy2OJWAJEtwkS6wA==
X-Received: by 2002:aa7:c546:0:b0:50b:d4e8:3173 with SMTP id s6-20020aa7c546000000b0050bd4e83173mr8337181edr.8.1683554297252;
        Mon, 08 May 2023 06:58:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402014300b0050d83a39e6fsm3336982edu.4.2023.05.08.06.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:58:16 -0700 (PDT)
Message-ID: <cf9668bb-2e06-fe3a-813e-c49003c4175c@linaro.org>
Date:   Mon, 8 May 2023 15:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] dt-bindings: Add bindings to support DRAM MRQ GSCs
Content-Language: en-US
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stefan Kristiansson <stefank@nvidia.com>
References: <20230508122048.99953-1-pdeschrijver@nvidia.com>
 <20230508122048.99953-5-pdeschrijver@nvidia.com>
 <20230508133325.xllmriwydkczk6lh@krzk-bin>
 <MW3PR12MB43461CD5FEAE22462283AE7CB1719@MW3PR12MB4346.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MW3PR12MB43461CD5FEAE22462283AE7CB1719@MW3PR12MB4346.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:52, Peter De Schrijver wrote:
> No idea what the second error is about. Documentation/devicetree/bindings/reserved-memory/nvidia,tegra264-bpmp-shmem.yaml does not have a oneOf conditional?
> 

Are you talking about the one with following explanation:

'unevaluatedProperties' is a required property
'additionalProperties' is a required property
hint: Either unevaluatedProperties or additionalProperties must be present

? Isn't it self-explanatory?

Best regards,
Krzysztof

