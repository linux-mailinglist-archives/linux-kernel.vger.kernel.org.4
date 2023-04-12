Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA806DF58E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjDLMiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjDLMiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:38:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A212735;
        Wed, 12 Apr 2023 05:37:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so4135008wmq.5;
        Wed, 12 Apr 2023 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681303072; x=1683895072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqzXeJlC0I7OCnn6X0zvc6BscDwvzPmPZCU3yLPpNiA=;
        b=g11yy33k7UG9ipZVQ9TTaveA9K8uRz761fIaV7l2bVKANwUlHj+6VO9ulIV6KMZ1R+
         1I3cfHUYxN+56k/nPh4m9ceKodMdrpuCOWmSpJKE/dOPIhiibtAwrEzR+0x49wDMNuSI
         sc4v/V0Fwh3+hj70QfO8gBccxGwGOd/cIvrFqRoUmoiKiHeUZeox+oo+I/a3NbVnulwn
         ssmrWOc/7APl2rptNC+KuwS47t6unxlguKwRN2KvpOH/HRAhhRbl/3uZcXGaosLwv0RB
         oYF0ZSKuIK0tVeVriN9wY2CSWBPDAXu4I1xbOEm6YWc1vKsRbd25DFVFh20woxjB23dP
         zMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681303072; x=1683895072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqzXeJlC0I7OCnn6X0zvc6BscDwvzPmPZCU3yLPpNiA=;
        b=M4LsY/tDczAvumng5weu133StuGCUpzUYwaA4FB/jF21D/q3xKRTnheXQnj4AfTh2Z
         nmgOrOdXhqsXgesHLAMkUrgvtC8xoNhEpPXENxWAzCPpOHGfs/9JPcxtCb+FXKf9Y/T5
         /dQti+F34FmZNniIb2drHepEcYgZccKwuDLQI7pwChGaqlnywMIxaePP+6gCuDuY5tYl
         /+64knF7/6geEcN9tldq6qkd+/mAUhMoXxngYxCV3zeMeGkPL6WdyXBpaudonHCED5LT
         GJB24lcESDsBofEoCJjhoq5pqI5Xmdi/14I74BrJfD7le6sYIotwNE3RW4fET07tnJS1
         nagQ==
X-Gm-Message-State: AAQBX9cLM9BO3WzIV3YQMVuqS/OwIIPEx98BCZwMCiJf21E6UYMFYUhS
        UKn1Tbzl03m0kU+j5cXlo3s=
X-Google-Smtp-Source: AKy350YE7V2DR9bqM7GHaBKFa8M9MorPtdk6Hf8fTIr6Fb5dH11dtYMtZVVF1m92uPYPmtcZcNtEYQ==
X-Received: by 2002:a1c:4c08:0:b0:3ed:1fa1:73c5 with SMTP id z8-20020a1c4c08000000b003ed1fa173c5mr1898107wmf.27.1681303072175;
        Wed, 12 Apr 2023 05:37:52 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d514c000000b002c561805a4csm17085971wrt.45.2023.04.12.05.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:37:51 -0700 (PDT)
Message-ID: <fc679db4-8f56-a707-9e28-6eb109b37011@gmail.com>
Date:   Wed, 12 Apr 2023 14:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 12/27] dt-bindings: display: mediatek: split: Add
 compatible for MediaTek MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-13-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-13-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's SPLIT block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,split.yaml   | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> index 35ace1f322e8..fa6dd9b649fe 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
> @@ -23,6 +23,9 @@ properties:
>       oneOf:
>         - items:
>             - const: mediatek,mt8173-disp-split
> +      - items:
> +          - const: mediatek,mt6795-disp-split
> +          - const: mediatek,mt8173-disp-split

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>   
>     reg:
>       maxItems: 1
