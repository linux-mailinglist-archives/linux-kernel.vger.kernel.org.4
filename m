Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802F65BB114
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIPQ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIPQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:28:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4E4A59B8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 09:28:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w20so9855105ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Yuo6+cdkzpbtvDqxmCi4dS+f4ldcDL0jhsTFqbGT6Zg=;
        b=AZnn0bm7v9VrAGIqi0cZog9gB1fZPBmiBz5bgTsc4qpivvqHwktAJJZLu8kunxu+Tt
         TtlXzw9bNgd92FQEoutvuMOqvC2fi84q5x0DmzM32sKMm/6Qb14t8z6gQ+071EyA6aBX
         p4eeYERfTUjhUJ/MIBSqwiQpCoUdHqYWMxzfNMtXW/k2rIxES+TtiFR2W5i2q4P9EM4h
         lmcP18faVMsoB8f3dTXfzd6+BlcvJrPikwz/3zo4VQsEq/9lsT9uUTtsqKUl0ZA++Hop
         ixrVwkJ3WBEvPyf4OARJS+7XxUXsl1nuD+M+LMRRkVeszrV4nQu2fRCjmzEN6L9AWKeb
         7PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Yuo6+cdkzpbtvDqxmCi4dS+f4ldcDL0jhsTFqbGT6Zg=;
        b=31M/9Wx/xKZcG9MSmRFC0iz9Jl+NUh7L56yOG30szKW8g09MFpM/FfmcfUNzTmBNFr
         EvgwtR48YCdN/ApjI4nulY7HlnHmRf+65nArtCA7CNod102uModynh7bjT5zH+7uQq4y
         3jC2yeeY007Ksxy5gh3Cj6GwxLPhKkbJcl2zIl7fOyiFJtfLWuTY94M92bUjqnyTJTME
         mVwBZfxo4/ceyb6gAJjs33XIc32RHB5mLryFle5fAxnO5U59n5WUpLIR9R2/i6MtmW4o
         VMdGgxrVzoVpi81+YrA9a3o9ze7oI8jaoz8fedumPUNnRlh6YH2heVAOz8U4z7SNNyNK
         BT+A==
X-Gm-Message-State: ACrzQf1Sqvn4gBnMMd+QR7Llg1abmbBMMBUUKxzjCvB5ae88dGCmswPl
        fYQzn7y7rVr9/J0RTpUDF2eqLw==
X-Google-Smtp-Source: AMsMyM72ED8ZzC6JbgRFl+31ZVja5BhZrsH/70T4xMBkWdMiLzJ5TL9IGhGG5lH6skvbJG2SNM4Xhw==
X-Received: by 2002:a17:902:ea11:b0:176:b283:9596 with SMTP id s17-20020a170902ea1100b00176b2839596mr604676plg.69.1663345723538;
        Fri, 16 Sep 2022 09:28:43 -0700 (PDT)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090adb9000b001f5513f6fb9sm1740742pjv.14.2022.09.16.09.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 09:28:43 -0700 (PDT)
Message-ID: <adf840d4-b5f1-4b1f-faac-d735465028e9@rivosinc.com>
Date:   Fri, 16 Sep 2022 09:28:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
Content-Language: en-US
To:     Conor.Dooley@microchip.com, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        cmuellner@ventanamicro.com, linux@rivosinc.com
References: <20220916030552.1396820-1-vineetg@rivosinc.com>
 <20220916042331.1398823-1-vineetg@rivosinc.com>
 <67a3aba3-68bb-5e8b-4e4e-869c8e99e879@microchip.com>
 <9b9ff287-75e5-3ee5-e6c5-1daca6c562dc@microchip.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <9b9ff287-75e5-3ee5-e6c5-1daca6c562dc@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/22 23:58, Conor.Dooley@microchip.com wrote:
> Also, since this is not marked as a fix, why would we not just apply the
> patchset from Palmer that looks like a more complete version of this
> patch:
> https://lore.kernel.org/linux-riscv/20220902034352.8825-1-palmer@rivosinc.com/
>
> Maybe you could offer an R-b or some comments on that patch instead?

Sure I didn't know about that patch and my idea was just to get the ball 
rolling so tooling at least can start having tso bits as last time 
around that was the blocker to getting stuff in binutils and gcc etc.

-Vineet
