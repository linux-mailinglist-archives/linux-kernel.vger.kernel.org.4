Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79973C9DE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjFXJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjFXJJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:09:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F91BFA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:09:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-988f066f665so166975766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687597738; x=1690189738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0iJR1qiOnOHItJJH4VOhUi4FNwu4+h9jh885qlL4HP0=;
        b=OT3cBSaqgJw4XxYazcpaRD93GXIBn7LdLztsnGLlMNIEIyOKPL1gZmj3j+HxgBttPb
         0mtbq5H1u7zAWmKBJW/f0KfaG/iOwrpKDdt1GUksKeFH8ZWYFmLRy4vi3+87B7dBvqhf
         0KeBi3ETipQyEr5aymal6vu3bybyt1J02yrnNhDwoNkpFuSnXguiCsRQ8Hr9zx040nG5
         OXUDtuxjgX3Zif51XMvuX7vtVHt+S/K65CKN/ukJmCw2kuHrhogat9TrHvRn3SrFUSDv
         D4uxHmPtbc92N5zinMsOWc6uhMl5acWHRMK0ydlgNuz8u4P+4M/RLEvht4pW01cBa7Os
         ZJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687597738; x=1690189738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iJR1qiOnOHItJJH4VOhUi4FNwu4+h9jh885qlL4HP0=;
        b=TAmd90W5ro29IzeXRiSpRdn8i02pY1yPaYObtR8kM2TJdF/2L0L17ZCmgJMwDg4jdg
         MBOYA22JpA9qd9j6jhp34TE3E6jj8gZPpbzvm5ZamU7hFc8sw9AqHJiU8VV/DthSeO0K
         rAZ2Se93z/67d8ppla0M5xeWkzUMaF/9Ibm1jIrZ+90yKjSiaBOw2c9fHMPGLWB9XiN6
         RnTl6pwS4MrUvDnpks8hwxyBg161LmxwFFgbShJJAtDezyE/9OG9NfFIkO/3lkrFAVlQ
         tWG+wXVmV4yIFAdnrZdqOqqznTKzY/xqZ/ZDA+LADmzpCsE0oonJie9lFuqnAsSzuNVL
         vrZQ==
X-Gm-Message-State: AC+VfDx57M+dxEgEvMcXd4ebiyrjGH/0onrfrTpzIqHjEbdLLbgtnZbA
        Z30+1Elf2z+PgBixG+LjiWYj0Q==
X-Google-Smtp-Source: ACHHUZ57vhhKgA2KWro0eA03NX7qoeLCiR9NZwED/O7dYzF3Ya0EjhnjcRnSJ+HMRT5ofjOczockxA==
X-Received: by 2002:a17:907:d0c:b0:973:91f7:508a with SMTP id gn12-20020a1709070d0c00b0097391f7508amr22977407ejc.4.1687597738687;
        Sat, 24 Jun 2023 02:08:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p26-20020a170906229a00b00986bf50fe7asm678897eja.60.2023.06.24.02.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 02:08:58 -0700 (PDT)
Message-ID: <55b0ca89-8f2e-5383-59d4-6809e813abf8@linaro.org>
Date:   Sat, 24 Jun 2023 11:08:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/15] dt-bindings: clock: qcom,dispcc-sm6125: Require GCC
 PLL0 DIV clock
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-3-1d5a638cebf2@somainline.org>
 <c9681bce-efa8-9b79-4bf6-837dd6a2dc12@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c9681bce-efa8-9b79-4bf6-837dd6a2dc12@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2023 03:45, Konrad Dybcio wrote:
> On 24.06.2023 02:41, Marijn Suijten wrote:
>> The "gcc_disp_gpll0_div_clk_src" clock is consumed by the driver, will
>> be passed from DT, and should be required by the bindings.
>>
>> Fixes: 8397c9c0c26b ("dt-bindings: clock: add QCOM SM6125 display clock bindings")
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> ---
> Ideally, you'd stick it at the bottom of the list, as the items: order
> is part of the ABI

Yes, please add them to the end. Order is fixed.

Best regards,
Krzysztof

