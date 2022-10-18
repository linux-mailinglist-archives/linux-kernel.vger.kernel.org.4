Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5A06020A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJRBzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiJRBzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:55:41 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC06CD14
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:55:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m6so7860633qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dt3s4L6WuN24AfP3E/RhLtFLakK8K9lR0cO6Rs5M7mM=;
        b=eb0O+PgFkBTi7L6kqMTJRH4F7rpAVsgQnXX/yCtmuncA2cmZz2prCyw9Ni8iu6O+Kr
         DNy4A587z7/afs9UMert4Iy9gBRFazJ/2p7wSUehkA5uXTkirx2W2BPYmaHP+ulm/48+
         7gW7PGvliK36Z3fDobFHLjyPYtrGlStXbbyKJYJPcunUlNRShhMJh1tTOIku/KstPedY
         /kf9EGmgGslMjFghzDiabJEGxh/ao0c3RPUL8hDvqFOYfNvHWq4YBSzfuz303zGdJjjq
         uDmpGoRPyfYMQ205Zp7+oWd7Ax3PSltf7wFoMcEFpft/sRmTV9Z4YZJFsqwMw6LSI5yq
         956A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dt3s4L6WuN24AfP3E/RhLtFLakK8K9lR0cO6Rs5M7mM=;
        b=uA+WcaQxb+IWIn1oaqVKQlq0mCN/LeCaKxi5nI327ADZNACn8cWQV7RvN9koNLyBRt
         H4blKITnDg8HGIrXSur0KFcGMx8h8sXFYyjPjujMjC1rs8kb+EweNIqLvqq84klzWJGE
         AHC9Fqll2LK/Iu5mq31673mJS+YAiJot4g57BAo0yKqN4FuHmud+IMgc47O73f/J03t5
         RTW2vq2r2I5y2m5bCdfWqFsU+4JVQBi1iGLMjdiCaByoyLCdlb7yO/6n/syANT4VT5Ge
         J7ikWQZreWK1IlhaENtCIEVdekLXZDv8WpslHLFn4HcbrufsftNDx2fE7cZUBMj+sfsh
         mscQ==
X-Gm-Message-State: ACrzQf3dzVclXOfRNTe+sG7SbWJkD/xM+LPfr9GZXMhfLEXOZBIQkomb
        pD2oby0C37CSfldEhXZb7m8PcA==
X-Google-Smtp-Source: AMsMyM7g9mG/Ju4RyQrOyke7A1ODg1jEXPOIkeWW/ymskM+A2CttCliDmq7Do0jYHcQOck9l7UVhEg==
X-Received: by 2002:a05:620a:25c8:b0:6ae:2408:6e9a with SMTP id y8-20020a05620a25c800b006ae24086e9amr391427qko.222.1666058138924;
        Mon, 17 Oct 2022 18:55:38 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a29c300b006d1d8fdea8asm1275226qkp.85.2022.10.17.18.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:55:38 -0700 (PDT)
Message-ID: <c33c5490-c43d-17d5-f0fb-0b930dd46928@linaro.org>
Date:   Mon, 17 Oct 2022 21:55:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] ARM: dts: stm32mp13: fix compatible for BSEC
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 07:44, Patrick Delaunay wrote:
> Use the new compatible for stm32mp13 support.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> This device tree modification depends on the binding modification
> introduced by the patch:
> 
> dt-bindings: nvmem: add new stm32mp13 compatible for stm32-romem
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221014172324.1.Ifc1812116ff63f5501f3edd155d3cf5c0ecc846c@changeid/

This breaks users of DTS. The patch above did not describe devices as
compatible and that's the problem sending patches separately, without
context.

You need to keep compatible.

Best regards,
Krzysztof

