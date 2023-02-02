Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0568845E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjBBQ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjBBQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:25:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0BF241DB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:25:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so2195993wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rAdxVm3roeA5Yd8Kny3j2iuhXTXQ8cg0Z7aC8TUjz4=;
        b=XWpTgi/2g1x4NkuioDem8aLIhWUwpsXErZ24GH6JKSekcN2DBLLDQnQL5ZZs0NwJiT
         mTLpdg+mVpNNqKElXOHlhbhplOby0ff/N500abNajnEEiozy53zLZET6/Dw1PHuN/YVC
         pyrBrWYZsIU3xxUcj3uGUb/8nJlFU9Ys6AoL/f/vcSHown1SD4MRC4i4MLF9QyxTc0V+
         JitJk9iOroDY5/BROQEAjw5q5/77sObmtPk14kqnwCzLedk6dlY+BK8PNgIyme/i64gq
         F25ktbCD/6Nn6SUz8nWPEpg0TVs4OhYpwBziGfbCeomwNgypT4XLK+PqXBl3CpzahR01
         4hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rAdxVm3roeA5Yd8Kny3j2iuhXTXQ8cg0Z7aC8TUjz4=;
        b=Wjrjc95CC3oQOcEeqSVzNrNhq2vxGMj9Nmctb+DRvutr4r9DfIl47KzVVknPOUAuH6
         gQ9TixObQM9+RW+Lp2kS5T1IINSmZuqPhjFuhOZfn9x75h0X4RS1+SPQ1CO5MhNwE2SY
         YSth9LcV4hR+jneJcclbh+trJJzbHyFbnb442uNdFgb0BDA2+PLlk9QqpSBUBGmUD0j9
         vyNT7p+9whUcr0Hwff1qN7ioRJeF3ihR+xLmTt+2hI6wYU1rwL6QDs32RT0fOe42cOnq
         zUi27uRZ+m/hZSqYwvMs0PXN4HvZ03EO4xFwqtCGbIIeTDFCbbxE+8Tam3QOA4+EhiKS
         rGyA==
X-Gm-Message-State: AO0yUKVvdW/tAEfQr1kyVCv3tzt5soPVnMk68wvPem/qPT2H4NX/WFk4
        v/MYb09cvjbHkpehOkxqJLWaZw==
X-Google-Smtp-Source: AK7set/3c3RAml1Wu3kiDFYwGoiIM0BNIVFsZh499J3xzKor9MHs93OGo8FIE5/PydYt0UNN4tiwsw==
X-Received: by 2002:adf:fe86:0:b0:2bf:950e:7fc4 with SMTP id l6-20020adffe86000000b002bf950e7fc4mr6432357wrr.39.1675355145965;
        Thu, 02 Feb 2023 08:25:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x12-20020adfec0c000000b002b065272da2sm20207448wrn.13.2023.02.02.08.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 08:25:45 -0800 (PST)
Message-ID: <91bfc10a-afd8-3bdd-2cbb-b881f2f33066@linaro.org>
Date:   Thu, 2 Feb 2023 17:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] dt-bindings: tpm: Add compatible for Tegra TPM
Content-Language: en-US
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, robh+dt@kernel.org,
        broonie@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        jarkko@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
References: <20230202161750.21210-1-kyarlagadda@nvidia.com>
 <20230202161750.21210-2-kyarlagadda@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202161750.21210-2-kyarlagadda@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 17:17, Krishna Yarlagadda wrote:
> Tegra234 and Tegra241 devices have QSPI controller that supports TPM
> devices. Since the controller only supports half duplex, sw wait polling
> method implemented in tpm_tis_spi does not suffice. Wait polling as per
> protocol is a hardware feature.
> 
> Add compatible for Tegra TPM driver with hardware flow control.

Sorry, new bindings only in DT schema.

see Documentation/devicetree/bindings/writing-schema.rst for instructions.

Best regards,
Krzysztof

