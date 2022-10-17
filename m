Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10F2601B85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJQVvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJQVvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:51:08 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD813F40
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:51:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a18so7603898qko.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asQ6wQfPw4pQZQWUz3yt+YcvcuAHgYbKLKLuCiLZynU=;
        b=eaDBWGwoBtaE0yzMxgPL+Ngn/eTS24uik4vxjNg/Kx4z6T9tRGwX61NGsbBn/WF7zD
         b9RvyBbCLy7LVXQR8VduQRJVCka1P8m1DxCdNFFK2clfrWxQHxP59NB1+1lt/meCdyvy
         DEWSlQU8aH1+KiR559wHDxGstXIUDdYlTg5e2L+yonG37IHqubitMfMN2+flF7BDnwa/
         AXOfPI2M6uU46doh6W+1K9CG0W1Gus1dSZQ0TbAPPcuKUAbUzjJvdCWI7RaSIB508+gw
         plcmFJIHP2XW3P0TfsWsk2DhboiBgSEGkhZoh8LodbxcvUYMNyfg+0D1JrB07zZ9Sz2A
         lfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asQ6wQfPw4pQZQWUz3yt+YcvcuAHgYbKLKLuCiLZynU=;
        b=gXPmcjkCyVDI6KFQfzefITIBYk++PsxRqthhyaNpIwni+eRtisQcEbOaKSuDi9I0Vw
         selT/HF55Kca/jSvGKXnx4C55NNspCD7mghT7Z8k6/BaAhB0qURDJzlz3yits75NJgkY
         reB4LAMg4MRXv/Y0J/QvjIQEEaST1ZGMFCz/x2D31U2zvigL4nPjcXUsCSnOfLBK76IP
         DvkIpJTXBLcqfDgUqRtQ9UUMgKvnuRXcFZceQHQ8vUBgPwWWuDfGBpHgDd7ItVjIvIFI
         a7jxIITozoCVAe6DvEx9FGYM3s3PmG4kStXmTN/GI8U31yGC1m54c8ZqNkPsEKbC5bsM
         t+xw==
X-Gm-Message-State: ACrzQf3vgSa1i4Tq7ETneFsYYE7H6qjfVdPPzUil3Puog91WaINMQL5r
        8MZwOGtWhbPZwkL2hx74rLg5Aw9g5W93cg==
X-Google-Smtp-Source: AMsMyM5gtzXN0spdmBzyo1fgXB5onAsId3ZixrXT4v3pJmureW3+6TW1EVyUaHii2NsfdHMgrNobWg==
X-Received: by 2002:a05:620a:424c:b0:6d9:7c3:fe1a with SMTP id w12-20020a05620a424c00b006d907c3fe1amr9137193qko.197.1666043464741;
        Mon, 17 Oct 2022 14:51:04 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a245600b006b953a7929csm768143qkn.73.2022.10.17.14.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:51:03 -0700 (PDT)
Message-ID: <79d9b77f-f7e1-61d9-2e86-301f07a03721@linaro.org>
Date:   Mon, 17 Oct 2022 17:51:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [GIT PULL] memory: late (3rd) for v6.1
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20221003073237.11488-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221003073237.11488-1-krzysztof.kozlowski@linaro.org>
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

On 03/10/2022 03:32, Krzysztof Kozlowski wrote:
> Hi,
> 
> Late pull for v6.1 with minor stuff - cleanups and bindings fix.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 5514acb0dd030356e628cdd88b266efaa0a22315:
> 
>   dt-bindings: memory: snps,dw-umctl2-ddrc: Extend schema with IRQs/resets/clocks props (2022-09-21 20:34:58 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.1-3
> 
> for you to fetch changes up to 56efd6435c6890a3a38a33d192a0f9d5c835a24b:
> 
>   memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code (2022-09-28 09:30:23 +0200)
> 
> ----------------------------------------------------------------
> Memory controller drivers for v6.1, part 3


Hi Arnd and Olof,

This was a late pull and missed the merge window. It was based on
previous pulls. Shall I rebase on 6.1-rc1 and resubmit?

Best regards,
Krzysztof

