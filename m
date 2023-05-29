Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677E8714D43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjE2Pmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE2Pmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:42:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F5FA8;
        Mon, 29 May 2023 08:42:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6077660c6so22044345e9.0;
        Mon, 29 May 2023 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685374963; x=1687966963;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jo5a/JXM5eyW7F1q0/7SeqrmDEnGh/l3ApKPMD9Menw=;
        b=a9GXuJPJ1WwsWgUNonfxaq2F+J/b1NBIb60iy51Z522x3mLN3q1pu2zTaP5SkAbi85
         9bmzZF6Y1t0vtmLk4WNkYV8aOG1x3Vcbh6EhvdA7xqPY6gym6Sjho1uepWWseO25KyC0
         ujYqNu5v6CQ0PaW3wU4Fjw3Y7pAPJNITdWd8OQkFGOSOem3a0cgbm8KS2plJtuP1Elho
         ZUelxc7ueCj5vfCLuI6GOaVwzB3/bvpb/OGd68KTg/Wo6XHyFc71vJKTacYKZN0Vnsw5
         FuvJyMNfOl4ZVptsWiCJTdc1XFYGEArY/JSSYlna3ZXaNrDg8vsj2wyV/8Spl25H2HnO
         xFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685374963; x=1687966963;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo5a/JXM5eyW7F1q0/7SeqrmDEnGh/l3ApKPMD9Menw=;
        b=Us+OapGyYsU/6/w8twVtVHjUOKgSum8v8pTo9o92uIC0EQTFRr2NECcX1rrUSTrDL/
         25/1NFy3j9B1vV4VVsu0nlZCrGAl0ksM2ypKIzvy00/dbOG2fgUiAgz/MOzC6xfj5RzR
         JhGBGyYBFTWUqP7Xx75DUCKEzzpuwYz/SWo8f3aOjiPnns2aWQcd5Oii1uxd0kUskYSq
         01GzQ9vwWckGiXON1OzL0xuaGLDeDBuTfHANH6vx5MjzrFoSC137zvcDVfOup7+uWcxR
         /3tSMuRtUGMLkH+xPe8N3hHbMIuYzwZkduLJKly68auOHb9Lx0eqWoMadNJSo5ly6DoQ
         6MiA==
X-Gm-Message-State: AC+VfDx3SifHLiZ9sOeBZBcQ5PqmKy6JibfsJuXuZLXNMmjWhU+V76sm
        6h8ZJZfqTHjPmQkfN/ychFg=
X-Google-Smtp-Source: ACHHUZ44sfIsfx0Za8jPqM0u7GQcawEC5lcy0s9b1DixpfISlRFlYpxslgFy1XaCY3F/xqRBrpjuTg==
X-Received: by 2002:a7b:c7d0:0:b0:3f6:f152:1183 with SMTP id z16-20020a7bc7d0000000b003f6f1521183mr10002428wmk.37.1685374963211;
        Mon, 29 May 2023 08:42:43 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t7-20020a7bc3c7000000b003f6132f95e6sm18176715wmj.35.2023.05.29.08.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:42:42 -0700 (PDT)
Message-ID: <89e05581-be6e-409b-c4ba-c35297045af6@gmail.com>
Date:   Mon, 29 May 2023 17:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: mediatek: add missing cache properties
Content-Language: en-US, ca-ES, es-ES
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230421223157.115367-1-krzysztof.kozlowski@linaro.org>
 <5590f51a-16b6-93ae-d8a0-ab6b4e2e1016@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <5590f51a-16b6-93ae-d8a0-ab6b4e2e1016@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2023 18:32, Krzysztof Kozlowski wrote:
> On 22/04/2023 00:31, Krzysztof Kozlowski wrote:
>> As all level 2 and level 3 caches are unified, add required
>> cache-unified properties to fix warnings like:
>>
>>    mt7622-rfb1.dtb: l2-cache: 'cache-unified' is a required property
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
> 
> Hi Matthias,
> 
> Could you grab this one?
> 

Applied now, thanks!
