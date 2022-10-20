Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C714606848
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJTShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJTShf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:37:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB28BB82
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:37:33 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t25so531941qkm.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1hBLD4lH/XELJE0KWPJAlY/VEp51da8IvgbYfbE9SM=;
        b=m1MqjUsqQL2MbyAa48c2CVvgvq8u1I50bHLNDjMG1UmYjQuTXWEYox4FXqL9j3G6jR
         woCALKrlvanJEaLbeFrJ84/u56hESDulrFNddmwy58SGRhj3EiEzGT1LtoYHEzYnfJ05
         OCYYNp5ngLSolI5T5FcWxlKqd/KSyMNiJUnTMpq3gUeAc9Hjvb/jbahFh7g0fh8gk8AV
         1oMihPlKcs5XeUd3aha6KF8t9Odich8mjDh2Jd+E/9n1hNCcQDYOey8QxfFMnA/XxlfD
         9mvOHqsQCQHtgaAPmTHWtvv1lyTJ1pEulV28hR3143JLdTg1aVfqv/1MFufOVmRV1lEW
         aEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1hBLD4lH/XELJE0KWPJAlY/VEp51da8IvgbYfbE9SM=;
        b=RbNIcIAlP+YSNRy46WPBfWqj/NBhP4VOz4k87deah3uoamXoeAlyvaeocIZMN3aWA8
         a1cEkMzjgyd/2PdwsHMBYIz/2goNmV9DsL/Odl/UVylXgzAT1JufnihyVUMYypbaCHH7
         weENV9Z67PJXmXrrURUoCmBKj3FCt9ZVHi8tqoFbGF3JrKqItEDPMwAj7zxDVBYdb/sL
         vISXq3kg18Jdl16C5wh1tif6Ms5vN4CoEDXhuehNN5+lKkvxk2hJV/5qtSqjgk/ZX40X
         j+Wnigq32+earj52X0jeFCNeqKpkF9OHP4mHCTEYg50VQ0mbxGg/5b1GF9HoB9O0NN8W
         /tpw==
X-Gm-Message-State: ACrzQf3glUSzlLnf2nF4xgKrkVO+lNsIF2/e6TgQimlZ1lF+yA/NX4MM
        jh5cTvcqlEbRvH9d79GBkV2l8g==
X-Google-Smtp-Source: AMsMyM6K0N51sGcqCNzQyBHqlKAxnwAGBccxXvK+t7f/OxW1GPu+nee4zPGTsttzdLGjy5sQo7B1IQ==
X-Received: by 2002:a37:5803:0:b0:6ee:834c:b605 with SMTP id m3-20020a375803000000b006ee834cb605mr10465392qkb.643.1666291053184;
        Thu, 20 Oct 2022 11:37:33 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id d4-20020ac81184000000b00359961365f1sm6400070qtj.68.2022.10.20.11.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 11:37:31 -0700 (PDT)
Message-ID: <fc302fb5-740a-41d6-2610-dde3cce604cc@linaro.org>
Date:   Thu, 20 Oct 2022 14:37:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/3] dt-bindings: clock: add loongson2 clock
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20221020063624.17548-1-zhuyinbo@loongson.cn>
 <20221020063624.17548-3-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221020063624.17548-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 02:36, Yinbo Zhu wrote:
> Add the loongson2 clock binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

