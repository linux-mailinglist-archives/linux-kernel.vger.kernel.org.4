Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD8654D25
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiLWICE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiLWIB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:01:56 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9CD33CE6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:01:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so6109688lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TQnzqH82SvQ7sJUIb95QiBqANoSmjRADQ8HXRaKeGo=;
        b=laX6CMBEHL7EUfJH496zLDpje81hgAz9YUzZOLGBqlK1mrnWF0ZnxAsCa9RVayRmxU
         phW2gyFp1TGFHEmGDrgvoUMyZLn1K7yGoseHDNhwtSQKXa/bJvzLBBy78xKHgy4Z3AOi
         lfAns6L4cM8jfV2VWrpeQNRLQWRzpZCAoKjoJn8R7u58hMDGywg2YD8Tca5YKXdZm9e9
         25zz28uYvL2PcRXvGfqnXnllZ36ANyovOhobn9WIfddHSoMsdHnS5f8IsugoNSqVH4I5
         jAM1ueitx4R/EURYfk1pLF4eHLNyVO8YpFoT6bE9IEC0PCRSDLC93dDyj2/te1lmH9K1
         pxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TQnzqH82SvQ7sJUIb95QiBqANoSmjRADQ8HXRaKeGo=;
        b=f8xJJ1O/hZGz0QZiMJwWSo1YM4j5xY9kE/XSwZ70/4GXJyHKr/DBVKgAPPq+EgWpMF
         ptbs4EbjNbbgF4qt7PGAOzu148SF77dsgtFhKDoO/XfVclgZ2sc0vi3dVShytvqPUGeF
         wk+IzDrQ7GXweZr8HcSyfCaR4RfMDRveQVvBRUVhtSGUkzEFlB+fjpsgiLlIFICGcoqK
         n8q4xVbLmuXErKU3SySEiNECZsMLFzx59SqW8PTjqdUhBN3wrSFW64ZwUNxh4jPBrtFu
         Onuz+UG64KEu7VAuCdwnQd9bVGJScg8A+J+KCylpXEo1urKvkMlbBGh5RwGu72JJzV/J
         DWhg==
X-Gm-Message-State: AFqh2kpgseFmAYAQFkXaFFtGjKuZ0NzUhHOlyv4KdrIqR7UIrR9LjbEo
        pXWfC787d3t5dRE0CKB7nA55DdAlgug+IDZk
X-Google-Smtp-Source: AMrXdXuGO/ZSogTkRDNw22+r/TpFw7Rhrh/MFMaj/vVX8Bk7grMsV5aNsENVA9T9S8Qf3E7ZS/gCHA==
X-Received: by 2002:a19:2d59:0:b0:4b5:1414:415f with SMTP id t25-20020a192d59000000b004b51414415fmr3091792lft.59.1671782510766;
        Fri, 23 Dec 2022 00:01:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z11-20020a056512370b00b0049c29389b98sm413584lfr.151.2022.12.23.00.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:01:50 -0800 (PST)
Message-ID: <97100086-8521-f05b-f939-605c84e3cfe1@linaro.org>
Date:   Fri, 23 Dec 2022 09:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 3/3] dt-bindings: vendor-prefixes: Document EmbedFire
Content-Language: en-US
To:     Yuteng Zhong <zonyitoo@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Wenhao Cui <lasstp5011@gmail.com>
References: <Y6Ud9MhRjCVAYMCj@VM-66-53-centos>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6Ud9MhRjCVAYMCj@VM-66-53-centos>
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

On 23/12/2022 04:18, Yuteng Zhong wrote:
> From: Wenhao Cui <lasstp5011@gmail.com>
> 
> EmbedFire is a manufacturer of embed computers and education platform for
> embed devices from Dongguan.
> 
> Add vendor prefix for it.
> 
> Signed-off-by: Wenhao Cui <lasstp5011@gmail.com>
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

