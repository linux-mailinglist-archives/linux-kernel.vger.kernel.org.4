Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A91696214
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjBNLLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjBNLLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:11:08 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D72821B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:10:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso13407561wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0tK8b6mQQeMxLM0HPC9yVJwlrK4JU80immO6e4TSKM=;
        b=cOj7tHcDZ073S4fkddbNrOUQt95Wvqh6a2SUtjxlPua+Bo/UaDxdpLoU1hqht+Rdql
         hAWsQ3W9AZM6mB0xYxBvQ9dcPD2W6Tr/zh7Lod3c3e5nA7iNJBv2qvov7SJL9gZgBp/g
         GTn94Lk4hUbjlG1HhjPHTByjrAnNDsi3juQQwp/aRP8SN+tXN91DjcbLWcnphDcxNlXN
         Sil8BM2riLQD0GettR3WWtFT5uaX8FGHd9HNdRrT91L+VE9exeOk5ZHUeDIO1tmhgMqq
         b+2qVfrzyUh0G/xwcWYApKuafCTQxquInKZwVVU5t829IzBRFGiiZqAeUnflWgB9vR8h
         SFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0tK8b6mQQeMxLM0HPC9yVJwlrK4JU80immO6e4TSKM=;
        b=XXB7L0bHPbjHd4rRUeaXgtPNftwoxk1/PJCY+evydnspdpIEfTk9ENMqilRdZLWkqb
         BEqmGhx2BZfMGW5zQXBQFzFHRBTybYH6jcEkHAj4dRmCK1CKkHTzAV0X91EziWAEcp4d
         vQBm6z0smDLm3VSWXkc/1EPohjzLrOwSfL2Vq+stxG0KDWuv7YqF5Ec0nuiOLik9Dm1K
         Eo7hr2ry0/sElg6dmrhAyIMhJR6tmjc0U20dNjM6IdagC5G6I1xEtF85RSzBj4PwC4zs
         7k6D5OUG/fEHbSVSYF6OEyd5f4pE0uN/FBu/7HaTkb+/+vMBNExpc0bEo4IC8iZy3gfH
         UUMw==
X-Gm-Message-State: AO0yUKWqfdkCUDIu2bpxdNAUNJwQ6TQKqoB7Bdbd7xhO0yfCX96IVEYp
        bC+AotzgGvnG2/gFCdIEKGmqhg==
X-Google-Smtp-Source: AK7set9fE4uMwJAMdUW9xC/kaDOhmn8FFi+Toa/sVKWO7UfzQUJEQeLcrh/mEWJXu9QG1lH2xfXCnw==
X-Received: by 2002:a05:600c:a295:b0:3db:15b1:fb28 with SMTP id hu21-20020a05600ca29500b003db15b1fb28mr2237483wmb.19.1676372988915;
        Tue, 14 Feb 2023 03:09:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s21-20020a1cf215000000b003e001119927sm19434237wmc.24.2023.02.14.03.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:09:48 -0800 (PST)
Message-ID: <1726f1d2-7411-2b49-79cd-f5aecff2d19e@linaro.org>
Date:   Tue, 14 Feb 2023 12:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
Content-Language: en-US
To:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230214105412.5856-1-walter.chang@mediatek.com>
 <20230214105412.5856-5-walter.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214105412.5856-5-walter.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 11:53, walter.chang@mediatek.com wrote:
> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> 
> Make the timer-mediatek driver which can register
> an always-on timer as tick_broadcast_device on
> MediaTek SoCs become loadable module in GKI.

Other questions are unanswered. Please do not ignore feedback and
respond to it.

Best regards,
Krzysztof

