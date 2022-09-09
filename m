Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3538D5B3C51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiIIPpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiIIPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:45:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F4D9EB0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:45:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y127so2027867pfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:from
         :to:cc:subject:date;
        bh=19pT6mSAXVcVHpyyWc7CNF/SuAeFS3YlMdIwKH0tki8=;
        b=hWAGFj2k+XvyuRO6GXPx7k7QJ/4EsCz5P6s6krGgrnTcDbG3OR5Po58L6Hcc8yWinr
         iIjYkuss4tVo4VMhyDPR5mR/qiCfU8EjMCTmpf7gBb+c0tyNpHe9GooniPfXKTyeHy2O
         ncTGloCFD+JBMTgMd7iDpB31Myv657EWzeKQ4lWIWDVEbzyMLivM4ahYTyzWYCklySY1
         I+u2Sqoo2F7wVHKDLjqm5cc8VdFqVQnYbjczLZAFM5+tB5e7hN/HL9EjbEVgolVEpzxj
         5nVa6SGXzlhuWMJRYiC5btUuiGnWaNMGYu9+4p9Wss1WbyNB6y4Zw2WxFevbWohvtj1e
         KGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=19pT6mSAXVcVHpyyWc7CNF/SuAeFS3YlMdIwKH0tki8=;
        b=vf16AguJxX3r12+QsTAtWM4kvgApUeiiTAe2wsnqEcqsKWzQnRMJC8N51dbo90I1va
         1/PA7ruEFiN2vIYcIp64mBh3QIkbrNlkPdZq2lfBKrxIlxXHn3Z1q8BDdXYh6uBc0/P8
         VsmeMkb0RLqbJBZaG0S2PDXzjxEl5ENcnHa5pW5y4wPCwaCUx9hb0OzQRQrZ5uwGare6
         6+AzsVXvnibYSf8/JrXNHFpThEoKTZOpQJhqE7CsCTLB3rFUdz9XliuWChKMlowWRy64
         d3fBpBFlI7iJnxk4qtYBQx+bpUHiUzZ7fN/Ez+Crf8OgEkmGtqx/JQ7u9woGkKNc5/UH
         F7IQ==
X-Gm-Message-State: ACgBeo0Mrk4deVyyqJ/RodIIkC+0V+LUP4/jdiciYtwM7sEnLuY8iUtr
        p/84qMvmrHUR9y0aCrixnME=
X-Google-Smtp-Source: AA6agR6hrnElk2+x6ewuzRgQNm161XHy8SwV6bA2DomG9D4bKogKNui0z0qrv9U6flX7QPabs7V3Zg==
X-Received: by 2002:a65:6b89:0:b0:41a:69b1:8674 with SMTP id d9-20020a656b89000000b0041a69b18674mr12548548pgw.417.1662738339763;
        Fri, 09 Sep 2022 08:45:39 -0700 (PDT)
Received: from [127.0.0.1] ([38.94.111.114])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b0015e8d4eb26esm634799plg.184.2022.09.09.08.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 08:45:39 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <3e2b9452-f010-3113-9da8-99ef658c3aab@gmail.com>
Date:   Fri, 9 Sep 2022 23:45:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220908170133.1159747-1-abrestic@rivosinc.com>
 <20220908185006.1212126-1-abrestic@rivosinc.com>
 <2f5059f6-b024-1ee8-b961-5aa0b4e4c116@gmail.com>
 <dfd6cfd9-5985-030f-4c77-f9037dcebe90@gmail.com>
 <CALE4mHoDbh2Aq7eotzKAeqy80n29LWkuP+gjv8ADH7pTJAYQhQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Make mmap() with PROT_WRITE imply PROT_READ
In-Reply-To: <CALE4mHoDbh2Aq7eotzKAeqy80n29LWkuP+gjv8ADH7pTJAYQhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/9 23:16, Andrew Bresticker wrote> 
> I think leaving the PROT_WRITE-implies-PROT_READ as being specified as
> architecture-dependent is reasonable, but of course portable programs
> shouldn't rely on this behavior. There are CPUs out there that support
> write-only mappings -- MIPS with RI/XI comes to mind and indeed
> mmap(PROT_WRITE) on such CPUs results in write-only mappings.
> 
> -Andrew
> 

Ok, I have no question now. This patch looks good to me.

This feature shouldn't be relied upon indeed, as it depends on the specific
hardware implementation.

Thanks for your explanation!

Yours,
Celeste Liu
