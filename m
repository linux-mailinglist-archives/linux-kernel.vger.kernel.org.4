Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5A60F8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiJ0NQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiJ0NQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:16:21 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C286F82
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:16:19 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h24so1033251qta.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+oq3QsRUsNah3XNCHZp7kka0MIAB/dhO+Ih97e/MD0=;
        b=xD8rYMu8m+5/wsoqIdFawJVrZfZkOO4NKuKtEhVBAtjEOPNKDNvhaVggJnjZBnKDs/
         GeF69dUImt0Tu2AkCuSmE+d7QY7eUsoXJx1u6434BS7a4PxDurfCMHA8HHbpsAqDzOx0
         vdsljc4789NfeXJAxLrO/Q2F4YZ9c+WFtjEj98LyxFglSzTs8p1y6pqYqZ9J77qCcS8W
         KP6agAgByGqV7MtjtsOcCZCePgoPgvxKJ2Tpf6U7q8kv6N7gsisyEoRndpu+yTHHZ4rI
         3eZATjuhuRgWI/WzEVfloxBJs07fnKmK1IVgsh6aWhzDMnlQk10+mYGnwAXbvBHWFZv0
         /RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+oq3QsRUsNah3XNCHZp7kka0MIAB/dhO+Ih97e/MD0=;
        b=B6FpgbbLCyXTpX+ic0Jk7t80woat3n2y0PaAiCDNbs4TicLtLEJCLXZTiyMmtQyE1d
         JFlHnZNTNVvqdmZ1oq4Z3flJyRQCbm3b1U/Y/dpO//898cUnsEIPi22svLBR5krmSmbc
         /jV8H+gqh23XTs90wUixoGgDlS+kv5s1BTkCM4RHk6K5xhNVaw1PnY8nefEg0aKmLA58
         vbKK8wRUaoagnt6474dX16JOM/518+QI74rDzj2+UDSKBVZC1UmN4pg2QxhYmr6BkTJv
         54ECC1q14vBnAIQC+dO0Sc5Tjz1KxvVNMUV7aDdTT0Vh7EKfNp9RqQxW0r+X9A6S0mh/
         Ijog==
X-Gm-Message-State: ACrzQf2nhIYtnU+u2Dl8lPG4MhvSDIHyBfXW7OFlz0X5NdGuZjsZYHJM
        UKAK2AE6nirt5WLOwgRjQmFGbw==
X-Google-Smtp-Source: AMsMyM56sXvFcb/k1mCEILThX5/x4D0drnzJ+/8BM1VtGEtyAsbveifKToQvA2R8bMaLtRGnk0ahHg==
X-Received: by 2002:ac8:5e06:0:b0:399:880c:28eb with SMTP id h6-20020ac85e06000000b00399880c28ebmr41599233qtx.222.1666876578379;
        Thu, 27 Oct 2022 06:16:18 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id i16-20020a05620a405000b006eeb25369e9sm965612qko.25.2022.10.27.06.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:16:17 -0700 (PDT)
Message-ID: <453cf370-4b59-967e-b7da-9b3a6eebbc48@linaro.org>
Date:   Thu, 27 Oct 2022 09:16:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH -next] slimbus: qcom-ngd: Fix build error when
 CONFIG_SLIM_QCOM_NGD_CTRL=y && CONFIG_QCOM_RPROC_COMMON=m
Content-Language: en-US
To:     Zheng Bin <zhengbin13@huawei.com>, srinivas.kandagatla@linaro.org,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221027095904.3388959-1-zhengbin13@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027095904.3388959-1-zhengbin13@huawei.com>
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

On 27/10/2022 05:59, Zheng Bin wrote:
> If CONFIG_SLIM_QCOM_NGD_CTRL=y, CONFIG_QCOM_RPROC_COMMON=m, COMPILE_TEST=y,
> bulding fails:
> 
> drivers/slimbus/qcom-ngd-ctrl.o: In function `qcom_slim_ngd_ctrl_probe':
> qcom-ngd-ctrl.c:(.text+0x330): undefined reference to `qcom_register_ssr_notifier'
> qcom-ngd-ctrl.c:(.text+0x5fc): undefined reference to `qcom_unregister_ssr_notifier'
> drivers/slimbus/qcom-ngd-ctrl.o: In function `qcom_slim_ngd_remove':
> qcom-ngd-ctrl.c:(.text+0x90c): undefined reference to `qcom_unregister_ssr_notifier'
> 
> Make SLIM_QCOM_NGD_CTRL depends on QCOM_RPROC_COMMON || (COMPILE_TEST && !QCOM_RPROC_COMMON) to fix this.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

