Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182CB7062EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjEQIbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjEQIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:30:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A17468A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:30:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-969f90d71d4so66502866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684312202; x=1686904202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBwHznQm8CzxpIL8Db7tiHw17drcLtBwGVeWtLImY5o=;
        b=zDV5NJE6zxpmpAcAoalbbVYFRPnGI1edn47vzk7aPH+IpmmDVTkSOlB2gdA0e15c3O
         q9BL3tKrQMe4I02nfkT7NnWVOCeTb/ul0kyzr4BaOfsi3shF4mycLxl1nbiVFLXHh5Cn
         NYZgdhH272FVRbtJrOHThNi7W6Uw5Y5vTWEVcBSacmKR9ykRZMfEuKRLrUs/YAJS4Xdn
         EjaDvQ+b1YsljmVlm9QW1JXtM8naOcjiaAHAq13ApNNA9Il/ccomoLbQmHNusetIxu6h
         mTd8Wg2zMgjgOPTT5KhkdTlde7Yd8xGNVBLnn3Zmzy6czPu2D1/0+BBsRpQ/IIlr6Iqu
         xmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312202; x=1686904202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBwHznQm8CzxpIL8Db7tiHw17drcLtBwGVeWtLImY5o=;
        b=jUBAtW9n2QPNd5QZiovWqZLZLyOPhPU/+d41WjAM7e4bepgspnA3qrdSxz8i7npiMR
         A9Oyd44zmluVD9HFGfJI0lxHqumSVodanmBkrro+PNRTcfUUkNGPHpNESEyFyFfT0FOc
         EF6PG2T0+Z3qRhcl9XScJqr4Xd0DedJ7buPn36JSsyehK4dvOEPpJQgmEW3b+rqgsl3c
         oY806+lhbDmSzrA2jm7jqGIDVjJ6CJPhm1law4csQPsfi9o+CmS+tV/YjPTPGmc8OJrB
         rPhmomiIxsMqZoZjfzEbiwHZc09LULxRFZC4R7Ua782hBmd+0cW7aL8s2IKKvW5XL3rQ
         XmsQ==
X-Gm-Message-State: AC+VfDxcjKnAFETNS5aKz5MN8EfaK2Nm5iFzIYUbmyz2I7a51xgvXqDZ
        KxPHtXPNvWmEUOYF0pYr3gOcpg==
X-Google-Smtp-Source: ACHHUZ5Yl86YlxSEGmlP2DUjKvLji+nG1QDh1NQclrC+wx7+FyYqE5GEM1fOSZuGX2PwoRo9m6iYDA==
X-Received: by 2002:a17:907:2687:b0:94e:16d:4bf1 with SMTP id bn7-20020a170907268700b0094e016d4bf1mr33235409ejc.66.1684312202100;
        Wed, 17 May 2023 01:30:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id fh3-20020a1709073a8300b009666523d52dsm12025206ejc.156.2023.05.17.01.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:30:01 -0700 (PDT)
Message-ID: <03764be6-e8fc-c05f-3836-4979c3898995@linaro.org>
Date:   Wed, 17 May 2023 10:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: ehrpwm: Remove unneeded syscon
 compatible
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516184626.154892-1-afd@ti.com>
 <20230516184626.154892-2-afd@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516184626.154892-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 20:46, Andrew Davis wrote:
> This node's register space is not accessed by any other node, which
> is the traditional use for the "syscon" hint. It looks to have been
> added here to make use of a Linux kernel helper syscon_node_to_regmap().
> The Linux driver now uses a more appropriate helper that does not
> require the hint, so let's remove it from the binding.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

