Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1868B6899A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjBCN06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:26:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9661BF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:26:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so6015519wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+bqZHKGeSyZnwtYzsUjw3TAGVwq8cCNwMRSJXvoS5M=;
        b=uevaAYoGK5tmdXifeeatyETVhvhOCTtG6kVXihjsVY7GFdCyxArPkGDp60Tgfits8k
         46GTkje4uUq+6asH2gVORLTFKiXLQ2WMJqQVQ+wVoh2i/5fgRVTU808xdU+fW8QVvwPY
         Md0/pvz3OQq/HQIRHtPeKUrcqwkuUz/sRGL9v7/6pGVFd5x2ol2P71W+e7ruIMa33a5P
         HW0fE6wg0foukL8NUEwE/iagNdK2+TyQWvbYXD6T93SgLInJilWy3aP8b4+On+6QzasA
         o2/PvtkjyNSF38KgroaR9cKHSd/6bu2pWFM+cyeHivQH/P3VweofauIOJzH00YWG3XUJ
         iRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+bqZHKGeSyZnwtYzsUjw3TAGVwq8cCNwMRSJXvoS5M=;
        b=ZIE3z5EZQbPFwspmFOab3AebXylxyK+cIqrOP8DYxGfy3AcSgQvW44OF/iA3dSR7A8
         ACp0y51QnD1vHYbkBoJr3ULzy4nkHcMhPzz0/ynnjVEnCweln68o2XSlMDgpw1UIggtO
         ol72liyZUbqRQW0egITBbfBG7JGOH4vS1EsL94klSXlgjPbu01gYzehOzv9Ch+f4srrp
         v3f2jnzjKCUUD/xCN0B1YHUGI2KqlbWpd2LrzBr4eK+0zagRQxKRbeA50Oi1VPGLLZ8N
         VvAmvQ3yYm6Nj/QK6uz08jv1aYRIPNeSwuq8zWpIIQZZc5cgJyjdeANWnwaUcVagxmJo
         9CFw==
X-Gm-Message-State: AO0yUKUGO/cA/dgaVqIxCIZ455UGcAK5rgxgzMYczVFfSv8QX7S1TMtb
        QCOm65cN1Toj8G5W/qXdeZ/9m4sOyq8XJU/w
X-Google-Smtp-Source: AK7set9Dh5vMDdxr94Zy4vNoeGXwVI+d+8z+c+cKKI4B0bWkGT0muy0Tole4lsNrpWbKArb61HQiFA==
X-Received: by 2002:a05:600c:3795:b0:3dc:561a:79e7 with SMTP id o21-20020a05600c379500b003dc561a79e7mr9333729wmr.2.1675430814894;
        Fri, 03 Feb 2023 05:26:54 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k19-20020a05600c1c9300b003dc43a10fa5sm2956047wms.13.2023.02.03.05.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 05:26:54 -0800 (PST)
Message-ID: <bc26ef25-6fb4-ae9b-c2bb-4e89fb8c2e1f@linaro.org>
Date:   Fri, 3 Feb 2023 14:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] clocksource/drivers/timer-microchip-pit64b: add
 delay timer support
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
References: <20230203130537.1921608-1-claudiu.beznea@microchip.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230203130537.1921608-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 14:05, Claudiu Beznea wrote:
> Hi,
> 
> This series adds delay timer support for Microchip PIT64B driver.
> 
> Thank you,
> Claudiu Beznea
> 
> Changed in v2:
> - rebase on top of [1] and as a consequence get rid of patch 1/1 from v1

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

