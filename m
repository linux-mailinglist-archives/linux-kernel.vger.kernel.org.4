Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26826E13F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDMSQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:16:42 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAB65A0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:16:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id e9so11044162qvv.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681409800; x=1684001800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GYMDQOb1x0dIsbzSAlF31zfY++oLxxlPsvgamNONII=;
        b=hOaboTLK8oaecw/QyM7xV4rddNTUGip0SbsZyrWEwrQVSlWKNCEz2mamIe2V6vckJJ
         10NdhQcOBjX3fsGv4gsfqRTImz8vHL3fglEaN8Ug6uIZ43qaYfx27NdMGGeBGssYA+UP
         m4mOYdi5KK25/fWQOMHr0AX7mcFAAoC7vSQS7FTVG3zpRLhUQUQzMDJM+IbZEhIY6TWd
         I/CoD9JiXKmD2XlI0JZxiYojc106iFtoQxruxoF/pXobypOPe0gePtt/ZHhhgItDvw1n
         7htu0nlm29wL5SFzrnwHd/woWnIkD+y0WR6bsv7H2iLPwGvvEWrKYlBVzi1V6HCGKk4N
         q0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681409800; x=1684001800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GYMDQOb1x0dIsbzSAlF31zfY++oLxxlPsvgamNONII=;
        b=OkOZ1BNdL7BE26Dkz8fx8I77td+XFZ9QA2dmW12EP62YCwHqbwyc9hct03x7sy8VbK
         399dacL3ZiOtHH9115Oyk1aI8CFTgihYOLspTNkMKAsjESFxLqo9mi3kWQZXhoXlmGMM
         /PeHjac7SMc9pqJ65Hsq01kPU5PLl4vA0YWsJ5sR6cFNdgZK5dhYYRw5anbAyoV1OR2e
         mxpjo398n4byHEqVzkAA5z3MrEo4y902SBOR5UVCoqci2ebHzc5wLfX0AWMobyuBWwzn
         iNPGJPKHMcUNicvddJnERAuOenRa+NtbxllyZfaYETCUzi+ZxWCjpoBnW4Ud7mD7tPjt
         R91g==
X-Gm-Message-State: AAQBX9dXRZ2sOykI2sHqr5RV/6rdvYYg0cHzuFxRXPLrFlAN4WuTJlbj
        Xm+teI/pwRvxxeuOUghZHS8=
X-Google-Smtp-Source: AKy350ZjhuU2zRJd/TDM/VP+QwDLzFCHy/t8HD0U2aBiysfs0d6qQpG+vb2arQ+2LmtaE/o+1u4ipw==
X-Received: by 2002:ad4:576f:0:b0:5df:4d3e:b8da with SMTP id r15-20020ad4576f000000b005df4d3eb8damr4855444qvx.10.1681409800248;
        Thu, 13 Apr 2023 11:16:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id er5-20020a056214190500b005e7648f9b78sm581143qvb.109.2023.04.13.11.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 11:16:39 -0700 (PDT)
Message-ID: <4da53918-839b-4d28-0634-66fd7f38c8bd@gmail.com>
Date:   Thu, 13 Apr 2023 11:16:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/4] cacheinfo: Check cache properties are present in
 DT
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-3-pierre.gondois@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230413091436.230134-3-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 02:14, Pierre Gondois wrote:
> If a Device Tree (DT) is used, the presence of cache properties is
> assumed. Not finding any is not considered. For arm64 platforms,
> cache information can be fetched from the clidr_el1 register.
> Checking whether cache information is available in the DT
> allows to switch to using clidr_el1.
> 
> init_of_cache_level()
> \-of_count_cache_leaves()
> will assume there a 2 cache leaves (L1 data/instruction caches), which
> can be different from clidr_el1 information.
> 
> cache_setup_of_node() tries to read cache properties in the DT.
> If there are none, this is considered a success. Knowing no
> information was available would allow to switch to using clidr_el1.
> 
> Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
> Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Humm, it would appear that the cache levels and topology is still 
provided, despite the lack of cache properties in the Device Tree which 
is intended by this patch set however we lost the size/ways/sets 
information, could we not complement the missing properties here?

If this is out of the scope of what you are doing:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Before:

# lscpu -C
NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL SETS PHY-LINE COHERENCY-SIZE
L1d       32K     128K    4 Data            1  128                      64
L1i       32K     128K    2 Instruction     1  256                      64
L2       512K     512K   16 Unified         2  512                      64

After:

# lscpu -C
NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL SETS PHY-LINE COHERENCY-SIZE
L1d                         Data            1
L1i                         Instruction     1
L2                          Unified         2


-- 
Florian

