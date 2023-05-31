Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4667189FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEaTSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjEaTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:18:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF6B13E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:17:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so105095b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685560671; x=1688152671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRXn+Cy0RvW1WV+5bzVi+rN/pdYikDqitAksVBeXVYc=;
        b=EuO9WmuuKtJgo4lBRnyvIyxTOy9aVaVtH958FX5rYCAK9ebeGpuNWy4LCDCJ7tgtwE
         v8KWz8C1BRfePhrrRgtWbGB/097dG/fm/w8lJUKxMFBI0FG/EeQYidzpE8r2odFV7Hm8
         0w5CGfMRo2DeXeSG7DC2/jdfyrDpf4lNY13c4wSENrakuCSZqraYIPMnDs8SGyQI8DeS
         4YUjE1eduWUpgvu9OgQZ5D7hzQfPt6n+0xgp/TakD7BBPTVK/3AdWNF/fkis0b1E0uyj
         f5FUSFjESXltyW69Nt/q0vdDbC2e7qiO3CaUnCTtbyPD5hy/37AsaFH8WHmP36rL3luz
         wrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560671; x=1688152671;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRXn+Cy0RvW1WV+5bzVi+rN/pdYikDqitAksVBeXVYc=;
        b=OYi/D0YgB86HQc9HysSDgDuyzgDqu5jwFPPWFLtBR1TBiOssQewnPk6exZ7VNh1Dji
         TwWxm0Fa5GBHCii7JSuEXQbixXbvtjcaKS093xt8NJHsW00JIgWVykW+Ku9+zz6olrae
         4gz7M3zyQyII/Ey6uQRSDXkhGUzR/SH8Kr9r6AVGUKpjj5zdBjrACcpaumiXebCS79Ye
         I/fBuvrHeKu3xBNs2U5hmlODmTeGZTfHBRL+B4v87OW8dPcf7kjgeEt0/fGNsCXpzV0B
         kkEoj+bzT+EQYBUAQIxLxrp4DHex4FAofftHTEiIjBU36fUd8TMIyTo3VzwUXd69m/4f
         ceLQ==
X-Gm-Message-State: AC+VfDycRViJPerf4Rp6MSdSmMOF23ezhYFZLBTjTi8BID2KM7yEbfLE
        uJgM23AJJf+dZrLS3KB2Uv8ZVJwZ69w=
X-Google-Smtp-Source: ACHHUZ6JEfEzcQ63O6e6hUpl79Dub3S1WceBl5T0WyKTt8XrQMOJrY9Wd7ylaeB21wY4TWeCqdYChw==
X-Received: by 2002:a05:6a00:1592:b0:64d:3fb3:9ed9 with SMTP id u18-20020a056a00159200b0064d3fb39ed9mr6519475pfk.23.1685560671394;
        Wed, 31 May 2023 12:17:51 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:e888:4048:539d:b33c? ([2001:df0:0:200c:e888:4048:539d:b33c])
        by smtp.gmail.com with ESMTPSA id z16-20020aa785d0000000b0063b806b111csm3627068pfn.169.2023.05.31.12.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:17:50 -0700 (PDT)
Message-ID: <1806cc8f-f119-a1e6-230d-03b45e182efa@gmail.com>
Date:   Thu, 1 Jun 2023 07:17:45 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: Exclude m68k-only drivers from powerpc entry
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org, Finn Thain <fthain@linux-m68k.org>
References: <20230531125023.1121060-1-mpe@ellerman.id.au>
 <CAMuHMdUbVmjcYyXmparBm6pQwu3q7HpTKsKfi_aAHGOSX97MUw@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdUbVmjcYyXmparBm6pQwu3q7HpTKsKfi_aAHGOSX97MUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 1/06/23 00:59, Geert Uytterhoeven wrote:
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -11916,6 +11916,8 @@ L:      linuxppc-dev@lists.ozlabs.org
>>   S:     Odd Fixes
>>   F:     arch/powerpc/platforms/powermac/
>>   F:     drivers/macintosh/
>> +X:     drivers/macintosh/adb-iop.c
>> +X:     drivers/macintosh/via-macii.c
>>
>>   LINUX FOR POWERPC (32-BIT AND 64-BIT)
>>   M:     Michael Ellerman <mpe@ellerman.id.au>
> LGTM, as there are already entries for these two files under
> "M68K ON APPLE MACINTOSH".
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Which leads us to a related topic: Is Joshua still around?  Should Finn
> be added or replace Joshua in the "M68K ON APPLE MACINTOSH" entry?

Add Finn, at the very least (if he's agreed). Haven't seen mail from 
Joshua in the past 13 years myself.

Cheers,

     Michael

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
