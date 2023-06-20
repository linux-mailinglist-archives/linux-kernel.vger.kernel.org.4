Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA67363AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjFTGgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjFTGgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:36:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DBDE6E;
        Mon, 19 Jun 2023 23:36:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b50e309602so35311265ad.0;
        Mon, 19 Jun 2023 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687243000; x=1689835000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGEmrwD87vPFZUFP2nZhIGYTM3YLut9ycTQ9fNJPTvM=;
        b=nBYjkIB7Fl5l9oZIti5KfGcFEFHV7nBN3fW7O1ANniaQgyfDO+/hk7i8PTgRYQ7kdP
         sP8SoY8l5R5nxBFMt9nhD7Q7MfYoKaz/AOF/rnS4ZEdMb59NA39JwadA511mdG4rBaD6
         N9rZDoet1bKBS30VQZNfqi9oBdB9nlGydX2WybtUCwsdvR3GpzljdgwQXgfDBBWuS7rt
         evvZ/+rnb8V99NrOrlTU1FZkIdO29Of+VAi2iuIhaVO+ZeVxm/T+PvTak+QU9JLtSLch
         VIrmItN/GxQXiuyXOetquNt3Wp51mEw7EL+FDjhCnJ/K1mofwiTN2X00MsWpRNpyq1v0
         Ibhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687243000; x=1689835000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGEmrwD87vPFZUFP2nZhIGYTM3YLut9ycTQ9fNJPTvM=;
        b=BDT4uGMK6ubiMvub/aMhB0euXqb74Y8vqBdz+t/SET8Q0AeAKE9nj4fNLN1sN/lgL+
         AceSEHDVUGv/Fug56Im1apHa+dDssCHAIDE5Nce9kD0ZaX2ID9dzlm2k0mvN9OWOavDY
         LFRgIcIGzCgHgkw2pUbA/Bs7TGqIVdGWElpX5pwppBxctYVJ4z9U0EW4KN5bLWOYBMQy
         gGPmI1w8wz0ZigDLgKyd4T6qCHMMZwalM9b4KvwV7NbJNbkyv6VYa0CTRypq1xcKyorI
         Znu4SF0+svf6z0foNLkHoHw+24KyhdVqnEedIwEZSDHly7L+C7oYvCPJgPiwv9w77pSY
         a1Cw==
X-Gm-Message-State: AC+VfDxRNBitD6xt+898AB+WaEYAXaQD55noIUMzN2sQ2u4b5+rEcRp2
        uJMvOJ0YYkWAEZncTUeqvIA=
X-Google-Smtp-Source: ACHHUZ4/AFBPIzSfplimyzKmDs1iXEkO4b1qEdNgAdAIuPilnx/NFiqQYyVkMBt5HwtM38RTfL8b5A==
X-Received: by 2002:a17:903:2284:b0:1b6:66f1:358f with SMTP id b4-20020a170903228400b001b666f1358fmr4576736plh.24.1687242999526;
        Mon, 19 Jun 2023 23:36:39 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902b11500b001b414fae374sm787522plr.291.2023.06.19.23.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 23:36:39 -0700 (PDT)
Message-ID: <c229876f-5a0f-fab9-c006-adf42bfd892d@gmail.com>
Date:   Tue, 20 Jun 2023 14:36:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v16 1/1] clk: nuvoton: Use clk_parent_data instead and add
 a header file
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, tmaimon77@gmail.com, catalin.marinas@arm.com,
        will@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230620015120.234041-1-ychuang570808@gmail.com>
 <20230620015120.234041-2-ychuang570808@gmail.com>
 <e847c114-224b-fb69-e2b1-7881b8f8ec90@linaro.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <e847c114-224b-fb69-e2b1-7881b8f8ec90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/20 下午 02:22, Krzysztof Kozlowski wrote:
> On 20/06/2023 03:51, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> 1. Update all parent clock string arrays with clk_parent_data structure,
>>     and replace the usage of clk_hw_register_mux() with
>>     clk_hw_register_mux_parent_data().
>> 2. Introduce the header file clk-ma35d1.h to include shared external
>>     functions.
> These are two things thus commits.
>
> This is not v16. It's your first version of this patch.
>
> Best regards,
> Krzysztof
>
Dear Krzysztof,

Thanks for your advice.
Okay, this is the first version, and I will split it into two separate
commits and resubmit it as v2.


Best Regards,
Jacky Huang
