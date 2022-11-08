Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F5E621A44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiKHRRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiKHRRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:17:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D22B1AD83
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:17:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p12so9257706plq.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faqnCSL7HtyExxkwlZiQblYpyhKpkDzYxHj7SFADNmE=;
        b=r93tzqUTD6QegA8Sqq3MvpuD3M2V50gnRv+w2ZBvlzNgiXOJGCsj2ir+vL3HPBjBap
         g5Cd4DWVNuDRmNhzx1lBVOtcDSCEis2gxrlor8V5R2tjiXoSkL8KX4d8f907JoJe+a30
         J8QGR+UsI+OHlBXiU/SfzS0pOpmUc/PAtOQdhj+nbdlmswZmFi/E9ywekg8IhmNJoENk
         x+PzfwsmtmqV+A1oF+dZ+7m8yxdfVTk9bd2xMojgOkAsV2r3UfLusiPR7AXbnTI4yuFy
         TYBO/B1osOeGikkYdfLxmMljbblhaINeZ6kJZH3dzL4cbbde3jHn8assJtVgfZ7D5Hpq
         xTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faqnCSL7HtyExxkwlZiQblYpyhKpkDzYxHj7SFADNmE=;
        b=dfiwi1XblR1CextM0VzF8VwVT2q+02HNkvVJctVos9R9PwKazjCgd/725yLuSlemVs
         rJ2y2/BXl8obdXTt74xoAZq8v0XoRl7h4wbG5f+E97ACTM0YX5po9FiFZf9RZA9Mjelx
         VhkeFGQX0O/mSlNAqwZJur9PSVubB1F60eQq2yfiuk2RpHe3ZKjUC0MdgihP3mg8pniD
         JrFOoT0Bd3Uuv3/YYVOrOe0a0+p5OMhcLTC8TCDO0Oa+Yi0JLSWOFSEkyxMBchWlmk6i
         1l5tkpkPkileKXIl49T+axcuGYlYgV2HBoYO0nxwdGJalx3G2StN7GEP1W+0ApT21LM0
         ix3A==
X-Gm-Message-State: ACrzQf0+OXBPeYIIEGq4qZxcE2E0L6bnWT44STmsS/EAyPBBoQRf3GFp
        8IIXJTxgDE1Dci0Rbo0Kts0Sfg==
X-Google-Smtp-Source: AMsMyM4c/DBQxQpQgIAVHsslVllRdo4vADEiV9Z3e/ZdWjfhqtgbZfts7JiUrCexCDfVIxMt6xf0cQ==
X-Received: by 2002:a17:902:e801:b0:187:3a52:d24f with SMTP id u1-20020a170902e80100b001873a52d24fmr40394044plg.127.1667927848872;
        Tue, 08 Nov 2022 09:17:28 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090adb4200b00214247989dfsm6409981pjx.13.2022.11.08.09.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 09:17:28 -0800 (PST)
Message-ID: <95287691-752f-5920-2dbc-b9a5b144d0ac@rivosinc.com>
Date:   Tue, 8 Nov 2022 09:17:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v12 04/17] riscv: Add vector feature to compile
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Vineet Gupta <vineetg@rivosinc.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Chris Stillson <stillson@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Chiu <andy.chiu@sifive.com>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-4-stillson@rivosinc.com>
 <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
 <f4887649-3933-0a65-7ed5-1bf6bd842a46@rivosinc.com> <Y2oLkQSdCBJPvZW/@wendy>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <Y2oLkQSdCBJPvZW/@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 23:56, Conor Dooley wrote:
> On Mon, Nov 07, 2022 at 04:04:28PM -0800, Vineet Gupta wrote:
>> +CC Andy, Conor
>>
>> On 11/7/22 09:21, Björn Töpel wrote:
>>>> +config VECTOR
>>>> +	bool "VECTOR support"
>>>> +	depends on GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
>>>> +	default n
>>>> +	help
>>>> +	  Say N here if you want to disable all vector related procedure
>>>> +	  in the kernel.
>>>> +
>>>> +	  If you don't know what to do here, say Y.
>>>> +
>>>> +endmenu
>>> "VECTOR" is not really consistent to how the other configs are named;
>>> RISCV_ISA_V, RISCV_ISA_VECTOR, RISCV_VECTOR?
>>
>> Good point, I've changed it to RISCV_ISA_V to keep it consistent with
>> existing RISCV_ISA_C.
> 
> Hey Vineet, kinda randomly replying here but the wording makes it look
> like you're going to take this patchset on?
> If so, please check out v10 (think it was from April) as there are some
> comments on that version that IIRC remain un-resolved.

Sure thing. Although I only see a few from Christoph and kernel build bot.

-Vineet
