Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4469867367B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjASLOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjASLOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:14:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA4B68420
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:14:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i4so870476wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 03:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWQf2TFUhuWnAtSN5Oiw58HXBV+drD5QeE/qkk75i94=;
        b=bgtbWPjfqqb4T0zb5meTH1JYPl8eLqoBSihVQ5iSIOAKMzopmezZSow2cG5cE4ZgSB
         Ev5XtwXhdtFF9rLE9C3MYQIWjGqf7lsJ4M4is+xTEKi6ixR/nQuJmM5Uw7XxUJY9AU/3
         G6Z+cH5x1dcuPAa/mxyTMYdq4/o49D1sy0XRQ3b4Tngf4FPNyjpbO/95U7i3tOWr9mmh
         bQaPx5b8SepR89e2yMMVBbqn2L9LJ5D/X0VZ0hHeSodPVd5cBMpVRFf0HeX6dR/FIOiS
         2R3hE0lhcYlaAYBLLUw+kg7chc9SdkQ6tifD0ZVC33uZmp3JPi5Keco335II17q7VAs0
         fxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWQf2TFUhuWnAtSN5Oiw58HXBV+drD5QeE/qkk75i94=;
        b=XUWNcgOsvL4xoRgrBOLH7qryNoZI2xzygf7S2Nue7fEvxPFCeLJKHPENDzl8d2l3ER
         T5pgjm811Gf/H9g/PZpjePRGl5C13b8QeMD1/2dKk82ZI1PN3bn3Wihx4GLJSgfEuGyC
         kbodLjB1LN+wPzh44KDk3GhaiasOo3FJaRj/sTsbg12d2i9oIG7Fhp4cY5eJwjmJl8rZ
         cjKYr+SiKaa1C6RfUOOGGhZz58yPN0wA8DtX4duUX9jq8IYT5O3s/tvC67ZPtdj90bj0
         qsxugPCxacaleKSa/3rn7ek+YAa5HtdxvpLMvjFOjQ0b35LkEOgXH9l82oJrTcjp4H1n
         ccdA==
X-Gm-Message-State: AFqh2kpHMcqBlariorGJieLq+eHsn1WiEAnU6II/ejXAXDyPqzXUw8nu
        o4oB3YgJWL3LYLjiGIyL6gutF3jGK10ehL0K
X-Google-Smtp-Source: AMrXdXuxD3W/9db9SL+yOUMNCb+67nqBttWmQ6K8aQb2t9v/o0u90zsQZIAoaID3CgFIaX5A/KgbTg==
X-Received: by 2002:a5d:4e04:0:b0:2bb:31dc:2d62 with SMTP id p4-20020a5d4e04000000b002bb31dc2d62mr8497695wrt.67.1674126846711;
        Thu, 19 Jan 2023 03:14:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m5-20020adfe0c5000000b002bdfe3aca17sm11143937wri.51.2023.01.19.03.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:14:05 -0800 (PST)
Message-ID: <821fc151-260b-f248-8d68-40e85ae5e031@linaro.org>
Date:   Thu, 19 Jan 2023 12:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 1/4] dt-bindings: arm: mediatek: migrate MT8195
 vppsys0/1 to mtk-mmsys driver
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-2-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118031509.29834-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 04:15, Moudy Ho wrote:
> MT8195 VPPSYS 0/1 should be probed from mtk-mmsys driver to
> populate device by platform_device_register_data then start
> its own clock driver.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8195-clock.yaml      | 16 ----------------
>  1 file changed, 16 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

