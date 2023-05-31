Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AB717AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjEaJAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjEaI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:59:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588E31AD
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:59:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f623adec61so57550535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685523556; x=1688115556;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBIQNd5CwMWOY24/Rr6Brie38sdaCVNySMcl3oJt0UY=;
        b=lb1p6EnVRX+DTjwmsGXajDKG097RX6a3FHYa0py4zf7vRIItzJlmEJJdNvfPewp1gX
         7+k3hzQmjLmlqSIBIWtywOM5/foA2so1Rkf24FhxAQ2SZPq2xkvjJBkvloKLrU76sV1s
         dmqDXil/sJFyz5W1VVg/YzivVAyc/kjb0em6GtvR+MJJqkLdAr0qT9Biw3UTQan2RzQp
         jhXAv9bq6EgjYcVoQCOHm+JSueQmuqUzf8qFZPEbjV1xLhMfVkHvDEgJVaGGQO4o0/D8
         Znfjd3hvUgLCwL8rGGAevU8PxNxJ54jevizz+6yexbSHPwCZWh7EzmlMKXbDt3ReENQG
         3/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523556; x=1688115556;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBIQNd5CwMWOY24/Rr6Brie38sdaCVNySMcl3oJt0UY=;
        b=MZDbJnyKvTKLceJixXru/fK+8jTTcP+SzEg6/K12PVJ55XOdmvAOYGSwruVCQnY0Xr
         xnk82tRDvLcU5qrkrN5pitvRwI39w8ujCY4QSH+u2nclN+lpy2YfRQyMKtm2z7mWQs9X
         DDmSCO6D3aI9MTt/RJzC+XfWopXtLahJ6Ol8/E/cDwT7FTSKtMjh9Xr6rKnTJYO7wJC1
         BICpBEjzoMMrk191VXD5S+Nz+MQog782DvJbMkKzZPfTBjqxrgXn6Eag9ROQOJIDcino
         PdGQghbB7Ulym2HezA2JQhqtl2KtZ+K5n6N7d7k6VlWcQhYMAS6P/PcVRuW//mWD54gq
         UBgg==
X-Gm-Message-State: AC+VfDxtfF85hbWciK8Cccx5fx/KWMXcpPtJ1rwttc4ZZAAxuaeLb7vp
        9LBm9FNJEXPJ9gb38lbAm6RRNQ==
X-Google-Smtp-Source: ACHHUZ4CNyYShz0ULzlda84VWuoupYNh91jdzgJrDhnk3SyJ0FhBR4Gm/AqQagB0heDaO1DIzvnK1Q==
X-Received: by 2002:a1c:f30e:0:b0:3f6:e42:8f85 with SMTP id q14-20020a1cf30e000000b003f60e428f85mr3669312wmq.37.1685523555830;
        Wed, 31 May 2023 01:59:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5c28:3ad5:fcda:7779? ([2a01:e0a:982:cbb0:5c28:3ad5:fcda:7779])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f1958eeadcsm23417092wml.17.2023.05.31.01.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:59:15 -0700 (PDT)
Message-ID: <9158d9ca-fe00-760c-4c95-f2ee045038ee@linaro.org>
Date:   Wed, 31 May 2023 10:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] firmware: meson_sm: Fix memcpy vs iomem type warnings
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
References: <20221012185234.never.936-kees@kernel.org>
 <166602031304.3572695.12870664862275915316.b4-ty@linaro.org>
 <202305171124.4EB0D65@keescook>
Organization: Linaro Developer Services
In-Reply-To: <202305171124.4EB0D65@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 20:25, Kees Cook wrote:
> *thread necromancy*
> 
> On Mon, Oct 17, 2022 at 05:25:13PM +0200, Neil Armstrong wrote:
>> Hi,
>>
>> On Wed, 12 Oct 2022 11:53:16 -0700, Kees Cook wrote:
>>> Use memcpy_{toio,fromio}() instead of memcpy(). Silences warnings from
>>> Sparse:
>>>
>>> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 1 (different address spaces)
>>> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
>>> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
>>> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 2 (different address spaces)
>>> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
>>> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
>>> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
>>> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
>>> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
>>> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
>>> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
>>> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
>>> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
>>> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
>>> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
>>> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
>>> drivers/firmware/meson/meson_sm.c:206:9:    expected void *
>>> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
>>>
>>> [...]
>>
>> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/drivers)
>>
>> [1/1] firmware: meson_sm: Fix memcpy vs iomem type warnings
>>        https://git.kernel.org/amlogic/c/7dc69c7d073e6004a281db8f7f15cf6ebf702ea0
>>
>> These changes has been applied on the intermediate git tree [1].
>>
>> The v6.2/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
>> for inclusion in their intermediate git branches in order to be sent to Linus during
>> the next merge window, or sooner if it's a set of fixes.
>>
>> In the cases of fixes, those will be merged in the current release candidate
>> kernel and as soon they appear on the Linux master branch they will be
>> backported to the previous Stable and Long-Stable kernels [2].
>>
>> The intermediate git branches are merged daily in the linux-next tree [3],
>> people are encouraged testing these pre-release kernels and report issues on the
>> relevant mailing-lists.
>>
>> If problems are discovered on those changes, please submit a signed-off-by revert
>> patch followed by a corrective changeset.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> Hi! This change seems to have never been mainlined and seems to have
> disappeared from linux-next.
> 
Hi,

Indeed it was rejected by Arnd, but I failed to find time to investigate how to fix it

https://lore.kernel.org/all/4a6b34ef-f5d2-4e56-a7f6-6a7c9cdda416@app.fastmail.com/

Neil
