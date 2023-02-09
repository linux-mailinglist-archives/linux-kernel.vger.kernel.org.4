Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F167F690D1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBIPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjBIPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:36:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDED63134
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:36:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso4152967wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5iTn5qHICfiqsqpN93+glR9L8WT+oZVNTGa3s9jneQ=;
        b=V6pxhFNcWiY6mQbH5NekoKlp+dqbovfjIGFV8l+kROcxRDUZaJsEDDWIcdAC7W9/kk
         sZ21StiNutAsgGazHGsI662OnXW/i7wj2Alb8WjipjIeOjNgDCYCa79z0C/IAc4aRe0U
         hUR5MDdDm3C4mZXs37j6dYBlffdXCrsEImUsHZpAD5rqYyl6XoiylpDLMZpmvN/sRWlZ
         Wy1bajfh/Af0leXOvVpEscESFtM4l3UybtwS9woafTliRr2Zd/bwbs0j0wY8B9ksZNlE
         RV9sx0u4O1Ozxox6akiFHhLPYQxwN1/x66PNG45NRygf8Ah4b3RjxcwoCCWpGYf0MAFY
         fM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5iTn5qHICfiqsqpN93+glR9L8WT+oZVNTGa3s9jneQ=;
        b=ZUW0Xm+K7nzYA2EF4sWZtql904RyMVNfmSUJIQgXhEKTaRIvs3F4mf4IhG8zlNzpYB
         GcsgdF2HnvMU5oPj9apND+gmnNJDN/vo5QUP/8LOV3jIlDIwz9cw1SMSLW/mFEYwrNnX
         OB3nJAZGo3noHJISd86WoYKJvgGuO9+WGkCDRm+kY/zmZbvYazNmDxT9Pv4NlLDU/B/S
         SgKVkRf26RST01QHf6Ea5QhzWGoGI+2ggnlndpKJYtTBqr6oM+3UskBnFlHnL0ShKUil
         rILGsQdt8aN/N/aZ9Ml2KA8u7M7InyF9xIzbOxrp1Euh9bLYHk4xUGl9May7MZj8hW3d
         cPFg==
X-Gm-Message-State: AO0yUKX9+40cXPtQOns7O+5JxYkyfA6CmWv5fOZYI6oXdh8NADwsUVwJ
        BB9CQkV6CPm7H8qlNnu/aNUgeQ==
X-Google-Smtp-Source: AK7set+j3J7QEIYeKrfO0e2DuDvHdVBcKUSH+28YT1lZlaJ4hA645APpgWyq/dludToICms8VZ1ndQ==
X-Received: by 2002:a05:600c:4a9a:b0:3dc:46f6:e607 with SMTP id b26-20020a05600c4a9a00b003dc46f6e607mr10495670wmp.3.1675956980059;
        Thu, 09 Feb 2023 07:36:20 -0800 (PST)
Received: from [172.17.49.168] (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.googlemail.com with ESMTPSA id o19-20020a05600c379300b003b47b80cec3sm5162406wmr.42.2023.02.09.07.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 07:36:19 -0800 (PST)
Message-ID: <fdcea75c-1ddf-c4f4-5d46-f32a6619b66d@linaro.org>
Date:   Thu, 9 Feb 2023 16:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/3] Support timer drivers as loadable modules
Content-Language: en-US
To:     walter.chang@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230208094813.20874-1-walter.chang@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230208094813.20874-1-walter.chang@mediatek.com>
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

On 08/02/2023 10:48, walter.chang@mediatek.com wrote:
> From: Walter Chang <walter.chang@mediatek.com>
> 
> This patch exports functions in kernel so that timer drivers,
> such as timer-mediatek.c can become loadable modules in GKI.

What for ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

