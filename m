Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F369C2D1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 23:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjBSWMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 17:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjBSWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 17:12:37 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55018146
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:12:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o18so1163278wrw.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S0WA0UCtV1YGr2Z4saHTI+WmdRjphAcW9zwN+Zfitf8=;
        b=LcBH5xzawqDvf0nV/TO0Sq30kGcVrxLQ0AjW1ngV1cech4mSu6tMZ/Kt2hQ3viEwxg
         /rSjOWHzg6X7k/pq0zM6yTrEEVRsTv3BqlUa6iC4RmMwN5VyDfIKhLb86DHe8yV2WTwz
         xEdA1EQC15ylrAvDM20SFKC4eKOL2MjwDPTpETTk4VE2tm76V601iqu4hM0HUWp7UU+T
         QIXe4HhZGk8Bfnnwiu4EGxJ5SRSFGMAM2Y5c00WpH0C8tB4qhez5RVbBk449Kqv8IyLR
         Dm+KaKhSrSM5DU4jp+CpbfZ7CeSxFMvhu5GPz/UYFkfDHjXEvi0+xtk5LX2K7TSkf+ID
         l5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0WA0UCtV1YGr2Z4saHTI+WmdRjphAcW9zwN+Zfitf8=;
        b=jMxzm9SQG0qFCGqA/udCwT6gLiSOx4cbm2qEaNiD+ZcEpStqp3IGd8Dsvv3iMT7j9U
         9pIHOOpt8pdUKxXGJpsnmZWXuOxsZiTAuf6oGEwqi09D5jkH4O/cwyH1UTRb8oMbzk4B
         etbRtca1lZ+9corRvYKzUIqbjqe4FC6ijAYeZs7Tbg2YeDfduHU1hMSGUZE6r30cGKUT
         ug5q1Ad6isXoeNIStG9KPaB4hlmmL+AVfb8MjeWdPXvX19bPr5y7pTRNginf5PXU05NW
         BZ+X35MwTpoi+GLzs3LdxdH9fomsh2m5xrhv/wsuByKxTuiZVWvviIEwb/Idogl8BZa5
         SmnQ==
X-Gm-Message-State: AO0yUKU+tU0MycnDja2hc0LYV+10KdlpVdvOUqLahAxS6l5EaUZghdBh
        ZEz9op+JArZrvUyv3vGMW4yg4Q==
X-Google-Smtp-Source: AK7set9G6ZxoZhX6iSLL78bMWWenq7qXuiX7eWCHgDlJlzJsX3DzMHdpbEgnC8tyC/Z+LG8cEeSZNA==
X-Received: by 2002:adf:ce8c:0:b0:2c5:7eb5:9797 with SMTP id r12-20020adfce8c000000b002c57eb59797mr1134575wrn.8.1676844753196;
        Sun, 19 Feb 2023 14:12:33 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d698b000000b002c5a1bd5280sm967330wru.95.2023.02.19.14.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 14:12:32 -0800 (PST)
Message-ID: <014a5c7c-c9ab-3814-4d87-2f8bb9c08440@linaro.org>
Date:   Sun, 19 Feb 2023 23:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2] MIPS: SMP-CPS: fix build error when HOTPLUG_CPU not
 set
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Dengcheng Zhu <dzhu@wavecomp.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <20230217200749.1001-1-rdunlap@infradead.org>
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230217200749.1001-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/2/23 21:07, Randy Dunlap wrote:
> When MIPS_CPS=y, MIPS_CPS_PM is not set, HOTPLUG_CPU is not set, and
> KEXEC=y, cps_shutdown_this_cpu() attempts to call cps_pm_enter_state(),
> which is not built when MIPS_CPS_PM is not set.
> Conditionally execute the else branch based on CONFIG_HOTPLUG_CPU
> to remove the build error.
> This build failure is from a randconfig file.
> 
> mips-linux-ld: arch/mips/kernel/smp-cps.o: in function `$L162':
> smp-cps.c:(.text.cps_kexec_nonboot_cpu+0x31c): undefined reference to `cps_pm_enter_state'
> 
> Fixes: 1447864bee4c ("MIPS: kexec: CPS systems to halt nonboot CPUs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dengcheng Zhu <dzhu@wavecomp.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> ---
> v2: use IS_ENABLED() instead of #ifdef-ery (Sergei)
> 
>   arch/mips/kernel/smp-cps.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

