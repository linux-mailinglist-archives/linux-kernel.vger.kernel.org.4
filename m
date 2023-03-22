Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37256C4E80
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCVOvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCVOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:51:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945EF67709
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:49:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p34so6699682wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679496572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgpnOGjVLEuypN3ErDTiOI3NLlX/0j8wRBIzyu6JHTA=;
        b=X4fwNuM+lvoCT0eDdhrh8qu0d3y8CTVo2fmzUHYgTsVwCWryX5ksmhn3yTXvLSCuAr
         ZqLivJqI7xfK3Y/fQajsIQapKLatPD2OZA7WnIOmZqMJuX0vmG5fgBgAZAzfEjtFaqqF
         0ygbTqiK1sWJZIVWPfCzGJ3yY0TtYjm00Tc03VMP5QMq8gsB0HJwcGgCTjAIh2niCs1R
         iYCu7tcRl135CP8hLfhfwt6i3Ux5cCOqF61Soa/Xii7F7h3ql5RG9mPYNgoR6Ffmnvbl
         gp0PojSSjNZQm3RnK3A5o2A4IOJH10vJouXGQlA1ZpTf5dW+cJBApJ0lHl2u1onEQiQz
         YKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgpnOGjVLEuypN3ErDTiOI3NLlX/0j8wRBIzyu6JHTA=;
        b=1+u+GXWxQdF6LL1JeNLeejVX+K/cdf85Njl//Ly0KdFDyBLrJ74FdIXkUiHPM9z6OF
         5XoRxpm7rsNHPGRH94YfLco3fGRqaQLaR4ml1iZO8en3v+5ldbGc0TshEYAuZT5wfrmn
         D/VYBdHiJU+9lHQSG9SdOkRGFWngWgt16ElNaQDnHkzLy8nLkC4ykECW93hL7sHKtmnw
         prsbhbNiQWL1qaRq9bTaEXYLOD6lEoDsrG63rYIs87r3ogpHbQHp+JAwAUR2VrhrIiMV
         BDS8PARBSkY5o0F0ci6A4DSVaRYkdJ27aBflIDnlcpUTwEx0q8Qef/GydMZusjA75emX
         JUyg==
X-Gm-Message-State: AO0yUKWo1GnGHTGMB/m10sI5tpNeUuIeiyTYMeWdkRnvdnB5g8NUycZf
        XEBEV/Qx5ORb+7n6xr5TyJy9hA==
X-Google-Smtp-Source: AK7set+9XZgGgwvM+OLoRVwuVwrg4HkIiNlpgiPve/1U/yoqf+U/sCmAPCSUxB1b4JfefI4G4O7OFQ==
X-Received: by 2002:a7b:c7c4:0:b0:3ea:ed4d:38f6 with SMTP id z4-20020a7bc7c4000000b003eaed4d38f6mr5600772wmk.4.1679496572162;
        Wed, 22 Mar 2023 07:49:32 -0700 (PDT)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id p5-20020adfce05000000b002d64fcb362dsm8733633wrn.111.2023.03.22.07.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 07:49:31 -0700 (PDT)
Message-ID: <d7330917-730b-0219-979f-dd770ff0180f@linaro.org>
Date:   Wed, 22 Mar 2023 15:49:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 01/14] mips: fix comment about pgtable_init()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230321144842.2401182-1-rppt@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230321144842.2401182-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/3/23 15:48, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Comment about fixrange_init() says that its called from pgtable_init()
> while the actual caller is pagetabe_init().
> 
> Update comment to match the code.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   arch/mips/include/asm/fixmap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
> index beea14761cef..b037718d7e8b 100644
> --- a/arch/mips/include/asm/fixmap.h
> +++ b/arch/mips/include/asm/fixmap.h
> @@ -70,7 +70,7 @@ enum fixed_addresses {
>   #include <asm-generic/fixmap.h>
>   
>   /*
> - * Called from pgtable_init()
> + * Called from pagetable_init()

I'm not sure about the usefulness of this comment; I suppose it
predates git-grep. Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>    */
>   extern void fixrange_init(unsigned long start, unsigned long end,
>   	pgd_t *pgd_base);

