Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2667CF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjAZPEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjAZPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:04:32 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA136AF5B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:04:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id br9so3447876lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85g64dsl/DcFY/LlzFQvHEB0mO6DyTsjvCN0CbsFtNw=;
        b=RkiI+vwnnL7VCkolwfyJmz2pmhwyz1uPFgE9WrH3eTnJ0h1OjtfKBo3De8gNoeWD+X
         l3xRPZIq/L9vFJzv6PULtvhXKKJtDa9LLTd2AiHrb4BZ60JZC+IqDP/SwDQlwxNDg3Lu
         9JvSTWA0sLX1/2yvxrUmgT4h1TvymGWt7fVAn2xOTJDbbM8Feyi8EviAkCrynsKOph1z
         JlCZLF6rHye2m3z2r22q6SSNhTHJoseOKvgJklu5p9zXC51NgfsruhZVLFQ0SRjjMd8L
         sQonnT13MfN0mupzXLJTbk49qRIe8hctNAc3jWuKFq37gyG4sRWzTKJCqEAo/+pvSIr+
         DyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85g64dsl/DcFY/LlzFQvHEB0mO6DyTsjvCN0CbsFtNw=;
        b=3um3xrEGEIE5Qmcm1IPcXG00dmpxtaLqp6jZxBqub8xUZ229RYuuhVRCg8StvNjWGp
         sbCYPpscFEYiMLIKLhlKNvYU6Y/ganX/WiK3xIcikd6TqrCqa+Zs0ZnsOp3xwNfCXwEv
         tlhTQ+3SUixcPzZD+p82p6mkiZW4To6q5QFZx1kHjfhNnYg9QboI1uGOmtHjzo8qCkks
         SzQqg7kjOk3+KrokPgHqLrnItbepbu8aER7hby58xW7X0Zg6j9Zww+ntn9RHD0+a/sJL
         ycI3w5b+/ATMB0wPWqzpufCbWTGaWJkcAjO3pGGgVTi8tFzhLgKNaLwutKLkf95FohqE
         O7oA==
X-Gm-Message-State: AFqh2kpNGO9/wSOY8H85vR4KQ5Hf6C/19LmMAfJLfBXn8dOgvdm1AWEn
        k8+NQ43vl70Z8zaegJFjWYlcsQ==
X-Google-Smtp-Source: AMrXdXu6eyBeVwquiscq6dc3oKOQoMKYuh59bv0ZswxZ5ffCDxH44vMaC4VrsM+OBs46fi7tYToQIA==
X-Received: by 2002:ac2:4f0c:0:b0:4ca:f887:fe99 with SMTP id k12-20020ac24f0c000000b004caf887fe99mr9661416lfr.25.1674745468435;
        Thu, 26 Jan 2023 07:04:28 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p8-20020adff208000000b002423edd7e50sm1618824wro.32.2023.01.26.07.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:04:27 -0800 (PST)
Message-ID: <0a47dfbd-d786-c7bd-e4f5-c71e1b649b9f@linaro.org>
Date:   Thu, 26 Jan 2023 16:04:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 7/9] dt-bindings: timer: mediatek,mtk-timer: add MT8365
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
References: <20230125143503.1015424-1-bero@baylibre.com>
 <20230125143503.1015424-8-bero@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230125143503.1015424-8-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 15:35, Bernhard Rosenkränzer wrote:
> Add binding description for mediatek,mt8365-systimer
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

