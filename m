Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8AF745233
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGBUSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGBUSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:18:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552BE4D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 13:18:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so4382292a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688329086; x=1690921086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCR9aKiKS/1HtQwTZqnWeFMubODuiRALoM63pUyTJCU=;
        b=RLbE7HcZPgIaiC6blyEO4rHMhIXAejRbkQ+QaFRrD3+fDJNHa3bp7iPuLzBjMlfckb
         El3tW28QZBjIFXQuJiV61Afd5QA24xnFNH+NQtFskOH5cPODH5rCNyqHOKEEkUwAdBie
         zH2QqLI1PjyyRMF3uoksnVpE8XosHESkuwaaT4Pjq5kPmiea38CivFMvgLqMWKeoBZAT
         K4pPgEEEkjFzsZJliyEt321jxueI8N4hkgrRKrCotcaEGtWMz5bVz7fS70LyGNye3j/A
         8KasqV+7EFKrAXUVyt02SHeO1WWs5SWtEnytY1JoH/Fc28DYFwwedC7CXMfjHQrpxLCn
         GziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688329086; x=1690921086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCR9aKiKS/1HtQwTZqnWeFMubODuiRALoM63pUyTJCU=;
        b=E4BEsnB3t30RyVlgq7j0E6H9EPnPyAdAVhS1q9OxYrMnsRXJ49FRyqZr4u+nWrLA7p
         KsoLNEcosMi/kIfZERAOj9QG2i3C0YN7UuvfPUxBrPSZjOdD8sJkYB8m+ftLGd6RceHs
         xyw2M3oHp1z+lyb49ThnmBELTsq7IfcYeuW6zPRvBKg9tLuBjd5S45SK2k12hvdjOeK5
         AGD/B2Lh6j5v656xqTziNWVGgD6qQOAPs6Hsx7dnHN+om6Md3JY5EBsehmDr/E8Kufdo
         1vbr7ZFIh+rYI3u0zqlRx5MbzOinxv7BXqwpnPOnGujb0ufEphlwFMXAp8j9xsUI8ZAh
         YHNQ==
X-Gm-Message-State: ABy/qLZsHA/AFSkhtxerExkjyVks1hssJmC58wQmE7msHgGEV2+SP8vy
        nLgXlLcl2hfpKi2j9k55mbMIbg==
X-Google-Smtp-Source: APBJJlFVtPTlxrm//lL1YIu3ZSH+xqtNfZVjv/+8m52ah6lvvQu8iOwxcBLsGx3A/u0rD4Ns0Qtzkg==
X-Received: by 2002:aa7:c64f:0:b0:51d:96d2:6578 with SMTP id z15-20020aa7c64f000000b0051d96d26578mr5758395edr.28.1688329085809;
        Sun, 02 Jul 2023 13:18:05 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7cb92000000b0051bec856cb4sm9461312edt.50.2023.07.02.13.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 13:18:05 -0700 (PDT)
Message-ID: <6136e12b-7a66-b1df-23f8-9767130576fb@linaro.org>
Date:   Sun, 2 Jul 2023 22:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ASoC: dt-bindings: nau8821: Convert to dtschema
Content-Language: en-US
To:     Seven Lee <wtli@nuvoton.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
        scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
References: <20230628085009.1130318-1-wtli@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230628085009.1130318-1-wtli@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 10:50, Seven Lee wrote:
> Convert the NAU8821 audio CODEC bindings to DT schema.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---

This is not v1. Please write proper changelog and version your patches.


You did not respond to my comment and you did not fully implement it.
With lack of changelog it looks like it was ignored

Please fix everything I asked about.

Best regards,
Krzysztof

