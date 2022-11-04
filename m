Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1594619866
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiKDNqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiKDNqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:46:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F3728707
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:46:44 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g10so3045662qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+14ZUWUEMyjcOtsdl5nm/jkKpjvcaDV8XzIujT67FME=;
        b=emY++djerGm0lszovpr9Vd21PpMd2jQrNZj5Bm5+El/7axZfaUPx03EX+joPBi3JOR
         foCSvuo2+ptDMX9jhhVzuudgBAmDweLlg0vEuBWdMmVWmMokkd2JN5gRIGxVQq7ggK8C
         jnV+/Oi7Tbw9v3aKFhHHrKIy87EUItUyHn+kk9JQldlzCggyf+LOyyLcVMgFPq0spEni
         zcFlzW9Uf45dlopko0F8ORhfvlN4NvZr2VQzxfYNFcNjsUwcbhEUJDj7iOYtQroJxAXf
         Rcj2tCwKxRoXPbotImvGB3JqSmPk6J5GZBSb7mFDcC4jTOK9cG4ICKytnRRZiJqY9k/S
         UlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+14ZUWUEMyjcOtsdl5nm/jkKpjvcaDV8XzIujT67FME=;
        b=CL5mnQffXmVQ2Gf1vPPDdhluSI+qkH7LWNvQtd4pVW0umQzQcyVZlbTvQxuXJWgPQA
         On84bgoGchCf1Ft00i/vD6aeiG2ioV/dfJnxXkuoih4t+QTfW6dOin8AJRgvHDTGZmrP
         WkctlM+FOBFWZA/Y8rXnO1KOm0DaJ7v6r01h3+Rb1TfYgJ4AAApLOqv5YtZCbdzYG84p
         1VAIkAFXsaCaUZyJ5NKSTRPpphMbBX+i4ilJDRyKa08cAx7OfcbJa8JNnL/DoZoTWfEO
         /ykuZ9/Sg7fZkz3fyIqtEKBV17mxq5pA1DYm1DMBkIIPoRuk8rjLkYRsmTwp5dcuftM6
         TqGQ==
X-Gm-Message-State: ACrzQf1dP96L8glNyVnCOuypao7IbGK/lt71SpD8xDSygtAEbRI5h0aQ
        IXNDNhf3HGxj0gM9m13QrzrO7g==
X-Google-Smtp-Source: AMsMyM6DU+/lwsr/Q2kZzSsB9Lk0Dfgkv/qiMhXHBpS9JySuwMnyIwbnfcNc1Qkh1nbNtPUJFCjqtw==
X-Received: by 2002:a05:620a:1337:b0:6fa:2ab0:503e with SMTP id p23-20020a05620a133700b006fa2ab0503emr20386421qkj.348.1667569604039;
        Fri, 04 Nov 2022 06:46:44 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84996000000b0039953dcc480sm2463057qtq.88.2022.11.04.06.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:46:43 -0700 (PDT)
Message-ID: <15eb2870-90b2-05dd-5a24-eef9dab6b31f@linaro.org>
Date:   Fri, 4 Nov 2022 09:46:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/6] iommu/exynos: Fix retval on getting clocks in
 probe
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20221103195154.21495-1-semen.protsenko@linaro.org>
 <20221103195154.21495-3-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103195154.21495-3-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 15:51, Sam Protsenko wrote:
> checkpatch reports next warning for clock getting code in probe
> function:
> 
>     WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> 
> Replace it with -ENOINT to make checkpatch happy.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

