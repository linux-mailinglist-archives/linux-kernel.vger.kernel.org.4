Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A0717819
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjEaHZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjEaHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:25:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C9124;
        Wed, 31 May 2023 00:24:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so57155435e9.3;
        Wed, 31 May 2023 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685517896; x=1688109896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGm8dSFUe8oYl2TNz6+RJ2OzDhK9zNEqrtF6bUETRPg=;
        b=pbS5jnd0KtWx1kVXDxSAjb45cGnnDxpRKZ+eRHPO5z2Gf1O8pmA0hnJnj0896zCXDa
         9mzThdBCbFgu19k81bCjxUqei1uwzml3BqcXaKgngGOeiN7dxwiNujCVZ00DoPPyBPwM
         W158p4ui/sGpYve7pXvZMMUwiq4pX3rlCbIsgvDOjHNMJWje/pS9jvZxEMSRTlTh2MKq
         UrGa7S9T1Ea6mrVYf4+5cfpZ8xvl6eGRuK/RngjKsyFTLQ6K9XmndxbG0yLc0X8o1DUz
         Rpz6CTQXVjqzAD7FKh9YofXrqtusQg5HtSrP1ZjS7nEC0XUlNesylMeuBoWFum0wiBo+
         xkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517896; x=1688109896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGm8dSFUe8oYl2TNz6+RJ2OzDhK9zNEqrtF6bUETRPg=;
        b=KO+lC1MAnesHYjaxrN+t6Teqs2ts4Fsf8QWBPJGdIy4cAJd1ChQ0P1tD+txFozvRHO
         bdVVX2meSRhYsb9p5+tew4tdUQTmydvOnmhQxT2/Nx8PR6JiE21a1VBuEjtdpy8DeG8p
         rYWGuubQ7TTwcECn1Zr7blhcrQi+hEYh08Dq6X2K6ax/TkffkHTktQvJ1JokPIJZ9b23
         xIzAE2ON/j8qxrZS4zMNtz+7rYsjWWTgYNvmHNe1ZJub6fek6JKvkutHdUHLLoTjyTQe
         jsedr4n3vNv3WG2OJwwiQF10IDr03e5n7XH5z2AJFSv2XiTlXOpGr1BZBAeu41N9CHYu
         XM+w==
X-Gm-Message-State: AC+VfDxjK1L2sMkiHio3m4piUOLvzQIzYtNYbD+rQ5T4dbNohK/jnOEE
        gwuDKXE2X7agrAXSjv0I/hk=
X-Google-Smtp-Source: ACHHUZ6FAhHU+Za7H9g0Boog+saCu9YGFod3wjMwsWnawn+ag9re32rbUxQSPPglCDOpfLNweXodOg==
X-Received: by 2002:a7b:c8ce:0:b0:3f4:2267:10c0 with SMTP id f14-20020a7bc8ce000000b003f4226710c0mr3464732wml.28.1685517895689;
        Wed, 31 May 2023 00:24:55 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q13-20020a7bce8d000000b003f43f82001asm23321548wmj.31.2023.05.31.00.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:24:54 -0700 (PDT)
Message-ID: <bc8f0ee3-1131-3f63-a982-913f8165aa7b@gmail.com>
Date:   Wed, 31 May 2023 09:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add cpufreq nodes for MT8192
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230317061944.15434-1-allen-kh.cheng@mediatek.com>
 <20230317195453.lpymxjk7oqvbxkq5@notapiano>
 <CAGXv+5GyLeVBAk_DXJoTxoG400mnq4y6pa1JXRD7Svc4rtMQBg@mail.gmail.com>
Content-Language: en-US, ca-ES, es-ES
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5GyLeVBAk_DXJoTxoG400mnq4y6pa1JXRD7Svc4rtMQBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2023 09:29, Chen-Yu Tsai wrote:
> On Sat, Mar 18, 2023 at 3:55 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>> On Fri, Mar 17, 2023 at 02:19:44PM +0800, Allen-KH Cheng wrote:
>>> Add the cpufreq nodes for MT8192 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> Tested on Asurada Spherion Chromebook as well. In particular, verified that
>> applying this commit makes suspend/resume work. Before, it would hang during
>> resume:
>>
>>          Enabling non-boot CPUs ...
>>          Detected VIPT I-cache on CPU1
>>          GICv3: CPU1: found redistributor 100 region 0:0x000000000c060000
>>          CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
>>
>> But with this commit applied the machine is able to proceed bringing up the
>> secondary processors and complete resume.
> 
> Ping on this patch.
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Applied now, thanks for the ping.

Regards,
Matthias
