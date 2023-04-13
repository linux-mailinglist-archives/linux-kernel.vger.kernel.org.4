Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39BD6E0854
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDMHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjDMHzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:55:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4251FFE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:55:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sg7so46619920ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681372547; x=1683964547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYaSNvD865fCT97F0L2xR1Bm2H0BYse+wXALebMN8Dw=;
        b=YeoNBncNdratOA+nG4/QQmfDFmk+aRb6ZOjShBnjbxGcAIXWr5CFcu8lH3rlDEVkJS
         +OOAyx1sXYEyOOmDuET+oXxmkbJNH5bOrZCe7KHlRKgTHwjdAFiW6QDtz6vXm1P0Yk1E
         mZoySTs564ndc1owes8C21jnstyzCwwZX67tza3wC65AqZqLQnX+GdOhMuvKE7oAZt/W
         VeMrqSK8TTAWHLXG095rRnX6IQY8TrdiIRphf28Bx0fYCk7s5dR0FqLqsG67iq1jhNgI
         3/bPm0sEj/+ex3x4ifW5lCtyLkiV/GGYMOKDbTjLs1oRnp8E2BQTRfQDwVHEenbh0fWM
         kJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681372547; x=1683964547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYaSNvD865fCT97F0L2xR1Bm2H0BYse+wXALebMN8Dw=;
        b=iQac4+b8kRWjprKBPisfgPWLO77IoHSB6u+eRsKLmStSHYx0N8cAt2cZiQG+0AtmXT
         Jmr/OGCA5CyUiNpWKQkhQbHfKlnmobbnxmSz0sVYKL6Y+7dHZ8iOl6dOuwuD3KBOy0Gx
         HJ0PX3dvry6hNsO78bWCvfMXbbla2lXUF+WWh7GfDr7aK9dWEHMLrxFQuCOs66p/jmHl
         RkwCK69BQN8TZu54DwilBJQoMvDsL19/M/lzM4crZEwb7hX59IksbZinf5ECQAyHnOlg
         8wwo+alIfkIW/mKzwpf7EFYLeKP1veogQsLKOq+4GpAXfGR6iZOhqkHIomtjxW67o42+
         MGlw==
X-Gm-Message-State: AAQBX9cIMGDby8urZSBzF4+vCfq5ghuJe6yPNr6F7mCbsqiu1ECJenfd
        sq7ZeUJc2SH2hU511mc7TLTDfg==
X-Google-Smtp-Source: AKy350aKrgFbJ+g45nZKrL/st5lbS76IIsZLLcs6i317bpl/6vAUsECE0H23wl9cmPxFfPxWYwk2lQ==
X-Received: by 2002:a17:906:9e1f:b0:930:f953:9614 with SMTP id fp31-20020a1709069e1f00b00930f9539614mr1570602ejc.1.1681372547646;
        Thu, 13 Apr 2023 00:55:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7? ([2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7])
        by smtp.gmail.com with ESMTPSA id lv25-20020a170906bc9900b0094a77168584sm569716ejb.125.2023.04.13.00.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 00:55:47 -0700 (PDT)
Message-ID: <e51d76e6-2fa9-7081-7d52-f78f70080c1d@linaro.org>
Date:   Thu, 13 Apr 2023 09:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek: dsi: Add compatible
 for MediaTek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        shuijing.li@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1681366162-4949-1-git-send-email-xinlei.lee@mediatek.com>
 <1681366162-4949-2-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681366162-4949-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 08:09, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of dsi for MediaTek MT8188 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

