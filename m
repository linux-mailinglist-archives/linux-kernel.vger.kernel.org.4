Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8AD6694A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbjAMKt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241335AbjAMKre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:47:34 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5760E3F10F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:47:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t5so16258621wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nCKq+3CeXspv0d8FXq+drklgU4PqbEbjubXP8s8ISNY=;
        b=zQM1ROKNS0lv0njzO8IlF8kS6u62cYpa9djllCqR8EyFB9jz/YeZGIIzf1YTPzEA3u
         RW9uZMnjVnS/JQL3Eew3HhXn2Zx0cKtFUP9oUkFR0NWErEjkNLq36WuC9R8X1xqjrzgm
         oh9wT/ZZFN2QFWVQtfF5In4t6K66RWlY8Fd7pJtyX0HXnbORsSthKyk0Tap1DxSCRwgV
         Z1EgvJhEqTgB9B+nE+HMKPPisuu9XfHKMYg1qRS8qV1o1SQ59HzLeLwQNC557YoKjjVn
         boei+WiOLV6zYg1b6KaenzPWMUI+MhTEJ0FDH8kSnOz0UTTQWRBr1RFtRPevT0rBS2U5
         DuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCKq+3CeXspv0d8FXq+drklgU4PqbEbjubXP8s8ISNY=;
        b=8QpL3LtXRp+ABCo4uNO3pGhbojnhB9Zo0YW68PwLYRQ39X1o87+zNCPi3XRelo+job
         BCWnbIeH5YaKgdrNcT5FCeFJ0OAFK3ghH/kDfUwABT5zsfyOzQFUNINEL0FucngwCJIu
         aTq55qrArmltnsWpM31EdKnAkeDn9zmllVG7bn7iNE7VThCAvdZj56CdGCcQ503uWtQJ
         DMBCrl+sNw7mwcbHseaNYNyyOzk1NhK1d/L/pXbzYcFpu5eJ1iSRFkkaszBrcWnPtm6+
         +DFXJ+yufwAzhKA25b78KhAomsN4HlKqZ/LYNfAN2DFGGcAWywg8FPAZYAXVsOFZGR5H
         x5uw==
X-Gm-Message-State: AFqh2kpHhiAEGGz+ed3/sXP80gQEd1FdYexPLkbmtcafpVOtxE/jiWeC
        g+6GL3RJrrS2vzKBDipJpBR4FQ==
X-Google-Smtp-Source: AMrXdXulZs7fMY6nmb7bBhCC1eHU5O0QOYBucr/XwAPS1BKnehd+EoVOMBDJsbVYl/P6L2fkBk9RkA==
X-Received: by 2002:adf:fad0:0:b0:2bd:e539:46e0 with SMTP id a16-20020adffad0000000b002bde53946e0mr781170wrs.46.1673606851768;
        Fri, 13 Jan 2023 02:47:31 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d6b8a000000b002425787c5easm18553532wrx.96.2023.01.13.02.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:47:31 -0800 (PST)
Message-ID: <3dc0b861-04fe-317e-9c9a-39c238b71dd2@linaro.org>
Date:   Fri, 13 Jan 2023 11:47:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/6] thermal/drivers/mediatek: Relocate driver to
 mediatek folder
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, bchihi@baylibre.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-2-bchihi@baylibre.com>
 <202301130353.wbXPctIq-lkp@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301130353.wbXPctIq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 21:08, kernel test robot wrote:

[ ... ]

> All warnings (new ones prefixed by >>):
> 
>>> drivers/thermal/mediatek/auxadc_thermal.c:562: warning: expecting prototype for raw_to_mcelsius(). Prototype was for raw_to_mcelsius_v1() instead

That has been fixed by:

https://lore.kernel.org/all/20230113064449.15061-1-rdunlap@infradead.org/

and applied in the thermal/linux-next branch


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

