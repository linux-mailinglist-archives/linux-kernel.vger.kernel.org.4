Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFC6A346A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBZWJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZWJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:09:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C374C666
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:09:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j3so3133475wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9F6Q4qv0aGwZl4/0HKoqtVCSHTUgp/9NrmhTdo3rp0c=;
        b=ZZNpYletnTDZobGUMqji31l5JllfTvVe+sA2PthTMflmb79aKK5eEI5uLDgrHzkOlt
         srStBbXFTaFKwE87beVZlTiWPKcI7C15qltQovAuslKWPyWqsLkZnazAMKeNeaahFtm+
         8Fbo5OoTYDqM+6RuC/VQBjTpEnrzQn2L95zRqJrHb0W5VMNuCvqTKla2nATW7EhKUkDY
         1Fgch06nglZD6l5axlzZpqHCbqBzTaBHoP5DiEl41IhGe0w6g/n26KSjaoe3JwqqwXa4
         2QC/pIXl2sIyPBSBqTXUx5MkTPg+T/mA0MCxC6oaVYjag0ayV+4kQIxkxh5lixaQ4dQQ
         TArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9F6Q4qv0aGwZl4/0HKoqtVCSHTUgp/9NrmhTdo3rp0c=;
        b=quC+0QDNPXci2Q+8v7TwjopYJLDqi7qzlNupaLVc5tFmmUb7CocPecNXU+ahnHCX0O
         HIchMiyNE6NwRMh7HOfr+TUinp9zG5J4E9YLZkQkdS0tTP+6napiZxmi76zsulMXY9K8
         19L6LydWpJFogkWeQqlVHW2jNrq92mQWYzfG5JIPQ6uqOl3uyYFbFzaK32SoQo3TsCRD
         TG89KiamDGXw4nRdR8ss6Rwi/0rhcsCSRrmwN9Sinb9Y0rmJmCWvBdyT2wpD9GcnnFlj
         09dYPNAyF6LSmEQ6EO90Tf+GSPDDNFyPYR4RVcZX/3hiKAGxUSmobW+g8gQKXFIGEqgH
         6NoA==
X-Gm-Message-State: AO0yUKUoIMmvPH9AtbiH5drHp2R+Y1pe8WJP1+u6v6E3UL124XOk7Z+W
        norIRLKRkeyy0v/08VS6p0RlKw==
X-Google-Smtp-Source: AK7set9JMtwxprxeg42jpe0jd+BgkbKcizuYpRssru9YxEFMP/olBGkczJqBJdd/Tn2DyUYtG5IQxw==
X-Received: by 2002:a05:600c:a694:b0:3da:1f6a:7b36 with SMTP id ip20-20020a05600ca69400b003da1f6a7b36mr19420725wmb.0.1677449382002;
        Sun, 26 Feb 2023 14:09:42 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b003eb2e685c7dsm8015131wmq.9.2023.02.26.14.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 14:09:41 -0800 (PST)
Message-ID: <8529a744-721e-218d-7a4c-cbb523a1fc1d@linaro.org>
Date:   Sun, 26 Feb 2023 23:09:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] MIPS: ebpf jit: Implement R4000 workarounds
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        bpf@vger.kernel.org
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
 <20230222161222.11879-3-jiaxun.yang@flygoat.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230222161222.11879-3-jiaxun.yang@flygoat.com>
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

On 22/2/23 17:12, Jiaxun Yang wrote:
> For R4000 erratas around multiplication and division instructions,
> as our use of those instructions are always followed by mflo/mfhi
> instructions, the only issue we need care is
> 
> "MIPS R4000PC/SC Errata, Processor Revision 2.2 and 3.0" Errata 28:
> "A double-word or a variable shift may give an incorrect result if
> executed while an integer multiplication is in progress."
> 
> We just emit a mfhi $0 to ensure the operation is completed after
> every multiplication instruction accorading to workaround suggestion

Typo "according"

> in the document.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/Kconfig              | 4 +---
>   arch/mips/net/bpf_jit_comp32.c | 4 ++++
>   arch/mips/net/bpf_jit_comp64.c | 3 +++
>   3 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

