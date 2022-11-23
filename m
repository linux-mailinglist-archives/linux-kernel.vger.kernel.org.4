Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84A636144
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiKWOPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiKWOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:15:07 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1758C2F3BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:15:06 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j16so28310772lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TINdZmgbDrPzV0ASdfCG6s3LtrjTdjbG7XRFv55Do+s=;
        b=T24d+0jcR5lA60i/hDr9pxlj7VcTDNIPxCLYpkwLfYreAl4zRdvR4jE0/1a9wGaBqO
         cBFImhmg84zHF+FWgR1HvdD837KljLtuP8taD1ogbB6N6wHRTeDaoBD54vMZLepU8T2G
         V9PAo7UA2ycJzMbGt4ET3Iquont2aQb9PbJJkJtz0siQvSm6GfajIj5qKHgxLuVs8ZYr
         wPrZV9eNTQV4WfLwDFIY6B+t7vw2FyGpP9fnJDjCC0QmNaiUtEfzxQ7geqbfT2P0lqrh
         RoTN0KPftTmsKoc1Db+91yiCcJmEJRvcl7IwEzom3oC2GyArUbuJ2BlxU8cJ5PUB3tEj
         lklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TINdZmgbDrPzV0ASdfCG6s3LtrjTdjbG7XRFv55Do+s=;
        b=TcPNSaKIf9ItMn+yWCW34w9hL5l5OcC2JEczSK3vdG4IVruSNi+6q1iW02fCXEhtV1
         7TvnR6QV+AhuHlCi6FaI7FvknbvzFR2/slE0EvB7iqG028AbL8XTbiiRqoluPcFeYEnl
         zJtp5TXPvUStMWKxR2rA1KKmf+gRTl98V3rjJqVlb7e5JxbFV3CGhsZkcloanmMjqX1z
         XgQBWTKUMFWoFwman7Am6SLdqbn/yGCt3wOGAyy7IAvPJaq/ylIgrSgiLe6+HQc2AXDh
         tpswGl+XGJpXpoJNyQJiIHPwjVIy4C/TntkZ+/rR6+xra7IoD7C59LEPoSaReDb9hpjl
         aiIA==
X-Gm-Message-State: ANoB5pmN4421hTLT3tO5Wq2dxioz7wbEkDx4qOqMsKhpDTt9sA2R0Zja
        8CdgjiVcptiaFhR9tWg5xWsQbw==
X-Google-Smtp-Source: AA0mqf7us62BlfklbhRWa1ceYpuYyxgP15LQsqJEK1EMlwdIuyjDEP2y6HR/i+RboeD7kufOfcfTtA==
X-Received: by 2002:ac2:5f49:0:b0:4a4:7db1:b853 with SMTP id 9-20020ac25f49000000b004a47db1b853mr9118798lfz.562.1669212904435;
        Wed, 23 Nov 2022 06:15:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512021900b004a9b9ccfbe6sm2930656lfo.51.2022.11.23.06.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 06:15:03 -0800 (PST)
Message-ID: <3df1e707-929e-b0a0-441f-61f1a185aa44@linaro.org>
Date:   Wed, 23 Nov 2022 15:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: increase spi-max-frequency of
 nor flash for roc-rk3399-pc
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, Da Xue <da.xue@libretech.co>,
        dsx724 <da@lessconfused.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>
References: <20221123094827.250657-1-abbaraju.manojsai@amarulasolutions.com>
 <20221123094827.250657-2-abbaraju.manojsai@amarulasolutions.com>
 <4981984.iIbC2pHGDl@phil>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4981984.iIbC2pHGDl@phil>
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

On 23/11/2022 15:04, Heiko Stuebner wrote:
> Hi Manoj,
> 
> Am Mittwoch, 23. November 2022, 10:48:27 CET schrieb Manoj Sai:
>> Increase the spi-max-frequency of nor flash from 10Mhz to 30Mhz,this improves the
>> flash raw write speed by 0.9 MB/s to 1.6MB/s and the time taken to write is
>> get reduced from 36 seconds to 20 seconds.
>>
>> Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
>> Signed-off-by: Da Xue <da.xue@libretech.co>
>> Signed-off-by: dsx724 <da@lessconfused.com>
> 
> who are these other people? :-)

moreconfused.com :)

Best regards,
Krzysztof

