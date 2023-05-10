Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6386F6FD8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjEJHxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbjEJHx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:53:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E55DCD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:53:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so66291797a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683705203; x=1686297203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d2ao5xRhAW1VmJRMoMN5yofC1btln79yFSHVXnmazOY=;
        b=vQGYGz+JKKoj0pR444Cmz8AfoMVXi+aedZH2f5tXSguiA5jLuZHv5InQd7y7msUxqw
         pkkJJE6gXJYKt3xeKyoiUBmQvOVIt/HUyqJK4cnTR7Id3n+8LS4ug1j2erzjuP9g8Kh7
         Eoq0Tft3rA++bEWy+Rtz7bxVQVt1xTHayNjawaewlwTNzI1icW0GLHqDTennWLI/5hGQ
         oSLhjz56TdQwhAAFq3M5lmlIt2UfjO5/yaBsdZKxjDIgB5geJ5gMagket7Sh7Z13d1wl
         JBTh44UnmDwdwNH+K8GYQiHxYZxRIcEiZG3AAbRMeTFcfULLRrbHkinEPAVuOoirq+md
         aNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705203; x=1686297203;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2ao5xRhAW1VmJRMoMN5yofC1btln79yFSHVXnmazOY=;
        b=Q+OjdMdfNb28WUW5IBY+4mV1zs3VrnV0YWq/7Pl8mEFdzyBlLcPSzeJQLDZ68viRjo
         seur1gxWzEW+sQzeABrvfpcKb1jw0nuC6AwxhKIrchd/VlyT63oqvqtYGmzbY0yz+OZR
         ZvRmy6Qj/fhPdurHTX2KFe4ySVe5bskmy4hWyaYJR9O3gWmMcRfjGvOAYVuPKDFzrEFu
         rKX98RdqipRfEbkhbPhRBXgvZcKmyZaAf1PY7CjxcZFzuJ3ziprgZZrIyd3+e3HM/XQF
         CHEixaydWVln7OkshAdOxJ8Kc9WObHogdPWjIsebSbId06xPilGgVY++xiQbLDC7cNv+
         md3g==
X-Gm-Message-State: AC+VfDwvDuwFWIYeeRlUIrvNQ3FKmCGJSf+bgSjs/+932liA8Np6+K1T
        3Lcd5WfpopJaO+ksZeJaR+0CGg==
X-Google-Smtp-Source: ACHHUZ7GAZREa4gfDODnMUUUqHW0zX13ApjtIjVoMWTiodkH906xmeobt1vPe7yZEyTTrjV8b+utxg==
X-Received: by 2002:aa7:cb11:0:b0:504:a3ec:eacc with SMTP id s17-20020aa7cb11000000b00504a3eceaccmr14214029edt.4.1683705203156;
        Wed, 10 May 2023 00:53:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id w15-20020a50fa8f000000b0050d89daaa70sm1591780edr.2.2023.05.10.00.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:53:22 -0700 (PDT)
Message-ID: <4d1b7563-046c-e62d-6849-5c539575717d@linaro.org>
Date:   Wed, 10 May 2023 09:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 9/9] ASoC: dt-bindings: mediatek,mt8188-afe: add audio
 properties
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510035526.18137-1-trevor.wu@mediatek.com>
 <20230510035526.18137-10-trevor.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510035526.18137-10-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 05:55, Trevor Wu wrote:
> Add apll1_d4 to clocks for switching the parent of top_a1sys_hp
> dynamically and add property "mediatek,infracfg" for bus protection.
> 
> Because no mt8188 upstream dts exists, the change won't break anything.
> In addition, apll2_d4, apll12_div4, top_a2sys and top_aud_iec are also
> included in clocks, because these clocks are possibly used in the future.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

