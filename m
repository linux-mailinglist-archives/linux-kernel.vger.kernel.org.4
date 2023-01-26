Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4EF67C93F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjAZKzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbjAZKze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:55:34 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3916A335
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:55:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q8so841451wmo.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wf/76NxIimKoU1sQJxc1MSapBNmdJtiBp9OzQaMYNE8=;
        b=B+7PLk1oQOCoTYRYptigCbIqrcGMXplRfzehgon1u5i6YOJUw78FOYXO7ZRBZ9cB+q
         bIMf1glkgXTQFV4UTGr81gpvriFSpDVfuaHPWKuwnAQxmx9IU7nvbLw/L4TKbk4CKxPm
         ZyTbRVjuAgapLGpcL0mdSaK3gNLnuqtzru9Fmua6hZvo2Dt1RI5YadFPZt0pHPl4iBzJ
         T5YvEjwfdgpEle5oUBVOzyF62WGTakVsMOucJ8HlhUFMo/CsfmwR6KeQMKQjzdZdWjmF
         5pOFpGJ+pSEjkAdrgsxYTCwsMcC2M8tvOhRjn6H3gVxAtnyo6AUhD9TMNms+EWigdvJF
         8MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wf/76NxIimKoU1sQJxc1MSapBNmdJtiBp9OzQaMYNE8=;
        b=MqrotevU63OxilBniMwInBjgnSgjbKYFi/E1kYVNK5jXrbCb1KlWcwuZhkfvdO1YSY
         LorDk3oSEs9CagzpuT7372swFDePz0XbmgGE3Wv+i99ppwKiztZ82aQ9pSp1BdRXVMe/
         i0Qs5qO0VvA3tovP8goMAPD7OdpyGJHOUFaIqrMmXKqBfVxOavNEf0ONqPmy/QcgLrfx
         CTacxMq2TfitUZT/wvosvi3vhoFPmIcXzqjrqkZxbkr4MpbaHxNWfup88ZaRlDT4r7d1
         joSSWnfS6/6AdF7dHsuJWNhZlwzb4R8If8mUhP/TF4KyG0hJkIs5qDCvqU/x6Le+cf2A
         hY/Q==
X-Gm-Message-State: AFqh2kqAvstzoeRHE2FnWFY0w0Xoj+ZcWsYEfA6wh8tlJikH2TPHAxaX
        emDp/iXbx5hXWgwO969XKcEXKA==
X-Google-Smtp-Source: AMrXdXuD57Xv7ULcspDYhgFmB5/G3sJZK6qFuB6794rf08xoj3vziiCW2IksBwaptnppWTltByizww==
X-Received: by 2002:a05:600c:601c:b0:3d3:4f56:62e1 with SMTP id az28-20020a05600c601c00b003d34f5662e1mr35052237wmb.27.1674730524334;
        Thu, 26 Jan 2023 02:55:24 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bg6-20020a05600c3c8600b003db06493ee7sm4972513wmb.47.2023.01.26.02.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:55:23 -0800 (PST)
Message-ID: <14d8e9c7-32e1-9cb1-e9f4-1a50abb5df78@linaro.org>
Date:   Thu, 26 Jan 2023 11:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: |PATCH RESEND] clocksource/drivers/timer-microchip-pit64b: Drop
 obsolete dependency on COMPILE_TEST
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230121182911.4e47a5ff@endymion.delvare>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230121182911.4e47a5ff@endymion.delvare>
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

On 21/01/2023 18:29, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

