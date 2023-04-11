Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B26DE17B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDKQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDKQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:52:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D10F1B0;
        Tue, 11 Apr 2023 09:52:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g5so11636510wrb.5;
        Tue, 11 Apr 2023 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681231964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yno0rJMndR+enK3b81d20RG38u8liw59TjI488nehac=;
        b=i/3lQnnZ17L+DsEQhfaH4b4jjLyrWRFShN0LLb+du2S60/TprcKYD5XPqaHJI/mgMO
         lbXZNVDt3Uf1Gt6C7NhB18qcPjAgLAL3SMh4Ga2tZwfoRoHij76TJlAy5KvR1cK3rrbl
         iUdzwzRQLU9J826+eXTbquEkZUONP1+9FkB48Mhx3KC35O0RT56D/g539KZs2BxrHzZc
         +OSrq8tbN1NEBxHfN9AEOvU7IiTFU2AmEg/h8HMPag7apEJJiwXjpo/VeDVQ95Wsp8tu
         rayYhMyFjDtxuhMitmpgl4Czbo+Qho/MRTgurCdIJ85mD5BzTy1iLJ9hi16Po9ck2nQl
         6dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yno0rJMndR+enK3b81d20RG38u8liw59TjI488nehac=;
        b=wtn4YtzO7iPcVT2gR0XyjQyPUuyPaPhAWErbwZaVFgAdf4Cu5FRo1tzzKZv9inFZrW
         sXQUZUTyld5EUIypneuouS2uejEXupOIcpARGgDxLy2UJtiKldgH5monMCGkBHysctcU
         E/BeQ3eHCo9+0UnrirNTz3mskwLXfVtTIFMVdnr7BW2UIMb77w20DbB53Twz/nzg1WD4
         StU7Siip7JTpkUjoyGKxuGCwnT8nLrYtoJTY8RaRtZYZc+H6yki1MiWi6/OOimn4nz8d
         A3I26yTT0+2JorMpBaf/AhxEqbIKH9HtHWNVUwGaoZFkN8MFuK6kwowTaUVzL+EmiD/l
         QLeQ==
X-Gm-Message-State: AAQBX9dxBRLOCqF61pQ3Qgm1JlmshX11VIFKftO5LZeQDqLxSMu2Kswy
        kcZFTM6zyp0tDLehA5wy5Ko=
X-Google-Smtp-Source: AKy350Y83in06DHv9Kz3jykTffzwn7ytZ6Pf0mQqj59zypBgAwJTy9x3DX+WfppTYrEImeN7Cb2lFg==
X-Received: by 2002:a05:6000:104c:b0:2ef:930a:cb27 with SMTP id c12-20020a056000104c00b002ef930acb27mr9803947wrx.2.1681231963885;
        Tue, 11 Apr 2023 09:52:43 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b002d45575643esm14888239wro.43.2023.04.11.09.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:52:42 -0700 (PDT)
Message-ID: <731aadc6-eed1-411b-cf4b-f97ffebae83c@gmail.com>
Date:   Tue, 11 Apr 2023 18:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: build failure after merge of the mediatek tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230403175220.5b946b60@canb.auug.org.au>
 <20230411092412.5a9e20e5@canb.auug.org.au>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230411092412.5a9e20e5@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2023 01:24, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 3 Apr 2023 17:52:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the mediatek tree, today's linux-next build (arm64
>> defconfig) failed like this:
>>
>> Error: arch/arm64/boot/dts/mediatek/mt6795.dtsi:647.21-22 syntax error
>> FATAL ERROR: Unable to parse input tree
>>
>> Maybe caused by commit
>>
>>    a7c7f1fe2fde ("arm64: dts: mediatek: mt6795: Add MMSYS node for multimedia clocks")
>>
>> but I don't know how.
>>
>> I have reverted that commit (and the following 2) for today.
> 
> Ping?
> 

I dropped the corresponding commits and resubmitted. Sorry for the delay, I was 
on holidays and without a computer...

Regards,
Matthias
