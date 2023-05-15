Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB04C7031F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbjEOP4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjEOP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:56:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D1FE52
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:56:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso19086623a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684166189; x=1686758189;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkouFW20JzzuaHMHZlrmNq9tS+5cnYopE+beF+b+m2k=;
        b=HI5BAWj65uI+2FvBMTDnSynAXsAXC989f0371owOdAejsiDnL5JtOJwj/elZfqbtmR
         y6DMy9F3/Wz02eUOtwtEnDMfTysjUM3mdxLQI57acakIekxXmwDuy4wVoWa4phMMO0lv
         hVGaPa6GhFcXOmyJaOZmGsniHxQXdRR1KpL9ArZp8myErUMr2BlF7RgaxQy6L+HVfteB
         Q+4bfeDBJ6xGYTh2WCCqPQwYpPQ2rRO9TQ2GQNtg8ODYXg/MDJ/KQbN64LeZmp+9nPn0
         ie+vysSsG1aJUOUpm0NWho+U/sI3WdksW/bChVn6zbCdwPK9FXcAFUUBR4SGbvj0S9rE
         np/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684166189; x=1686758189;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkouFW20JzzuaHMHZlrmNq9tS+5cnYopE+beF+b+m2k=;
        b=lWSGcwqHK3sumWZhj1919rH9pZOhigwhsKlHOH4FGjFEzPvFZQkA/yw8dbyVbj3Chs
         KUOGaTFlx6kFu1IGLCKZ6m+TP147LE7Ov9NqWUo/r/BgnA4FPD7rt/f5spNph5FMh3aF
         ArcSPxlrEK/0vUSpdL3FKVCHSbHgG7dw4qPnb9/vzjDvIVqiqD+n91FrDlCqN4R1g41B
         ZYrDO1rrtNHvJwJvc7S9Q4iRID+wGPSFgKzMZz/9/hcYMnuoOOUxwGz4BYk1jQQWIKZs
         suXoiBBrYhmWF0jZzYnJb7gPXWPTuz/w3Tltn3SWpl/leDdHNBJlDc+19Wvm542eHNXk
         w9PA==
X-Gm-Message-State: AC+VfDw6yDPM7vAGaL8x6HInmYO7Y5Ap72XfYOk95bX8nBL4q9Tf7XVz
        ddGDBeTlbNexpky/jll6Apm+Xg==
X-Google-Smtp-Source: ACHHUZ6GRbmvc6wpuZVkVxSoPXedQtVnvRI1oEmNM5eXUodXM+9R372TbXhnWl6rp5ztjLiErqN3wA==
X-Received: by 2002:aa7:da08:0:b0:506:8470:c323 with SMTP id r8-20020aa7da08000000b005068470c323mr24080906eds.24.1684166189058;
        Mon, 15 May 2023 08:56:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b004c2158e87e6sm7358044edr.97.2023.05.15.08.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:56:28 -0700 (PDT)
Message-ID: <156eb77e-b586-53d9-7d90-17b5dfce0682@linaro.org>
Date:   Mon, 15 May 2023 17:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 1/2] dt-bindings: omap: Partially convert omap.txt to
 yaml
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tony@atomide.com, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230515074512.66226-1-andreas@kemnade.info>
 <20230515074512.66226-2-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515074512.66226-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 09:45, Andreas Kemnade wrote:
> From: Andrew Davis <afd@ti.com>
> 
> Convert omap.txt to yaml.
> 
> CC: linux-omap@vger.kernel.org
> Signed-off-by: Andrew Davis <afd@ti.com>
> [reduced to only OMAP3/4/5 and AM3, adding Epson Moverio BT-200]
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

