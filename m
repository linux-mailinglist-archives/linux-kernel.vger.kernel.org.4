Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF2717841
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjEaHad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjEaHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:30:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE6C123;
        Wed, 31 May 2023 00:30:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3b5881734so6279890e87.0;
        Wed, 31 May 2023 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685518208; x=1688110208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Decr5ToKuusJ1vsOCi3GGboMucraQ2C0wQliP84kDVc=;
        b=LtrOdGC7HJo1sApDCqRePuNWVdNNXV63xK9ISycJWamft6qwOtumOnVXflAwX6lFnm
         JFjZAFJAXNyROl4nqsslRIpjXzpR4QP+WimLl/3zJqsOleavMjoI7ckDRqwQ8+EaidzQ
         irPA70S61W0kkp8IawqhJKVGV0sJRPFbwZ7Pxsp/zAriJj4rMGl9nEUTaI+vK7wH6X6g
         D6VYR9U5CYk8QAjKGMceTvX3RgPBQJKOgQF/iFYkfRRGc3Lc1waidQhPwyyFwk3uP1jo
         Mlg7RgIeSYLwcbwdFs1mJJpCsWAngGw0iP9P2MWyxEDMIyfj6yie+FUMM9cu8US0pu6J
         LtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685518208; x=1688110208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Decr5ToKuusJ1vsOCi3GGboMucraQ2C0wQliP84kDVc=;
        b=TyW/Z74oVSr/zQq4V/M2KXLc2L12j+dn6Fr/Qjd0CN2CHFTnXCu7MuCCubxRjjrAEc
         i0Zd8Xu65qy2FsTAruvmZglGnca/I1Tjdw70cmjB96oBvZEFHPFdvaDaJgqjx3Z5DhYk
         fLZdYPo8x3F2CxSNIbmKznqKIAryjrjnlOyg17Yn83Dz81oYj2s0xKR4EXR4AFqO95fj
         M7KUg0r0pd5NTssiAR0Sk9X0Ub4I4hZNKcFTMI2TL+48wgjlGzz/GwvXeu3+TgnZmzEX
         0aQMJ3Pp68SBSISsV38BAl6+NDiYN58QGKciLF+rORC89Rl/b9VCRj9Cykbjj/L1wJ5j
         GBQg==
X-Gm-Message-State: AC+VfDxa+silfXMX30tFu4kbGARoAQRBluqM3O7EDvXNEL8eqlRfDc1o
        brEMx9Q9/DT4nNu42Bmj+AffO3XZrLxg+g==
X-Google-Smtp-Source: ACHHUZ6bUGgErD5qHlh8IDTMiiRSsiMsY0Sy2BjrFL/lJ52tDTu6aM/tYw+aZ3otauLHaaEkq7Ju9A==
X-Received: by 2002:ac2:5237:0:b0:4f3:982a:8be1 with SMTP id i23-20020ac25237000000b004f3982a8be1mr1891949lfl.69.1685518207312;
        Wed, 31 May 2023 00:30:07 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q1-20020a1ce901000000b003f423dfc686sm19446289wmc.45.2023.05.31.00.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:30:06 -0700 (PDT)
Message-ID: <90ad9b86-e03c-8e80-88d6-d514bbe9cacd@gmail.com>
Date:   Wed, 31 May 2023 09:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: kukui: Add scp
 firmware-name
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230220093343.3447381-1-hsinyi@chromium.org>
 <CAGXv+5E4_k1jKTnninYkuT6Tf=skB00AowHpM+hc8j_VFM-RfQ@mail.gmail.com>
 <CAJMQK-hnK69iVJhqW_8UtKHHLQ3608Cb74Jk_b+xHH0BBu4yVw@mail.gmail.com>
 <d39b0e77-e013-fe7e-9523-9bdbaacb5853@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <d39b0e77-e013-fe7e-9523-9bdbaacb5853@collabora.com>
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



On 30/05/2023 09:12, AngeloGioacchino Del Regno wrote:
> Il 30/05/23 07:12, Hsin-Yi Wang ha scritto:
>> On Tue, Feb 21, 2023 at 11:25 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>>
>>> On Mon, Feb 20, 2023 at 5:34 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>>>>
>>>> The upstream SCP firmware path is /lib/firmware/mediatek/mt8183/scp.img
>>>>
>>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>>
>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> hi Matthias,
>>
>> Kindly ping on the patch, thanks!
> 
> Agreed. Matthias, please pick this one.
> 
> Hsin-Yi, can you also please send a version of this patch for stable?
> 

Applied thanks!
