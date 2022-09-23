Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30325E7751
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiIWJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiIWJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:36:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA68F958
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:36:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j16so18928197lfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xZardqzm0PQ0BwEDikq+bXXk6zHXw5HLd+Zlh682CZg=;
        b=mcu3yMDkzkOqWpb72+eQWf/7D7TbI3EkyYNzG9ZhLxD2RlVGikbCjAXG41pQYzvGW6
         g3p/6Q4L18OpBW3VZmBsmaZ4BHf9hdbfvaRj7yrbo3t9Qh8Lt8Hgedh9hMzLKEgknax4
         KLtz9gxXU3l75IlMDkEydAf/SH6ZC2vmqJuJovbwPRTz2I3Ifc1/9Q6t9aV7j7bFiWNn
         YOl4l5l1GbLrP83PSgY/aAq2KiJFlPmIi0Dx70Md/O015nZOQihRtmaA9uQvZfTnIJWO
         eQ/mxgB12wVVeSh8nZpwfI4XOqWKQGXgiQPP01f+GOujqeoHv/92xmFcLrITbM6xe/dh
         TLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xZardqzm0PQ0BwEDikq+bXXk6zHXw5HLd+Zlh682CZg=;
        b=qdPupL4XbBjljuYkoon9KBJrWJ8wGegmMUd1oNkCYDvK1ZDbMOgoUJwp0BGNvjqaH2
         +b16mY1khiqGiUaTXouxva2M/gif3Z4JV5QLDAGpazVAF7bLpqM1+xy7Mi2NI8WepXJe
         TbVzhr0BuRsb0KkZsdgas91yUiiThOMhlNvoFsjPFc45D0wnu5mm+u44D01nua9GLLtx
         qjpGFrvOKv3IVhSR68vg2rD/uxrRvudlDCNZVOVQFYgwvkbgO3ptybGxTxqqE6vPac5i
         li/1UpLiqbqnmQhwjoLhxt/Yjh1f5cEnOV2w5qJKGJZgyD/Ftzcq9PLzY1fG4hKmosgG
         tDhw==
X-Gm-Message-State: ACrzQf2lgKLlOagQ/0xKctDYN+tuOXRwZpS/SBP9FYJvCuJJi2kh3xMS
        LWyn2F5o1KjY3mxaiXpdVHNWNlEA2uQVcA==
X-Google-Smtp-Source: AMsMyM4grVVkVaVmdwZUlkTdjVCx4Ne2FBaiAhvziX1K9e4iP+nkA6l/z1NWFoG9xk905NGzqnDc9Q==
X-Received: by 2002:a05:6512:3ca2:b0:497:9db7:ec10 with SMTP id h34-20020a0565123ca200b004979db7ec10mr3134937lfv.350.1663925768687;
        Fri, 23 Sep 2022 02:36:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v25-20020a2e9259000000b0026c15d60ad1sm1281456ljg.132.2022.09.23.02.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:36:08 -0700 (PDT)
Message-ID: <69111370-d536-eb67-b528-f61a3b81de82@linaro.org>
Date:   Fri, 23 Sep 2022 11:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: display: mediatek: dsi: Add compatible for
 MediaTek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, rex-bc.chen@mediatek.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1663912657-28883-1-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1663912657-28883-1-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 07:57, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of dpi for MediaTek MT8188 SoC.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

