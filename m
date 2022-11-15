Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE33862A082
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKORjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiKORi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:38:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE252EF7B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:38:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l6so13975765pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FSiCY31V/QWXzTLZ2fNFJ5cidEqBZ+gXLW64Grk/N8=;
        b=DPE1B8LqqefUlBMXUOYA+VF9kIfGrHy7/L3SQnJRrX2ybhBDfbcTGqkPhGo+gYCAs/
         Nn1Sg8kApxzjxsQH+axtSrCcxEQU7Vkkr1b1X0xdthhgCMPQk/VwWIq2aE2sPtdyyjHt
         6Myk+7VCSn/8lE3sCnmg8BmJihCruZFjZGE4FQqBWbb16fP7UpG0Cfp8nx83AoFqQg8F
         FQwS765cfWB6Xclp24Vt9JB9bFax8lINlh5y07Hq2y8iFTvFJwrRFWwDniYUnxKxt96P
         vPRGVboImVmexj4XPvnMzf+/WguNXTWloUmT4L2cCj3jVAVZbM0P612WChqMv10s7iU0
         KZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FSiCY31V/QWXzTLZ2fNFJ5cidEqBZ+gXLW64Grk/N8=;
        b=OrcfwqqCZXZMDYQnCDPD1bC5YwoN/cVd5jHcR61HdaUY3SBa3avr1CX5iB68sp5dsg
         xMz2HYoYy+qad1nY8eUTcqkD46WdXfZOJ6V5XH7kaBoXKLNr/NgSEAZaefzd1l1RmqAs
         q9ckE1amMFfNfwjlrVo3hw7QFVhXsVdgYGuZ9v+mvEN7KBf2gI5C0qJK0JPhg79yH5y4
         8+TYOBX2QVha6pMXmg/qpjbvjXg9TT6H9V4DQmIadQ0USm+FARK2UMkL2TNrFWGxmYAq
         u/nMHc33SAPzzuxbWpgu6p5qynW2/PfcWkyrOb7u9QdRLs+4JYnm767EeI5vHHa8JBW3
         T0fg==
X-Gm-Message-State: ANoB5plKbwfNvFFJIkIXyyUWVJiHhw1glYYfPxMuG7pN3c7yX13c+Pkh
        7RvR21HifYu1mik8pvu/wFG2HA==
X-Google-Smtp-Source: AA0mqf5hh2iafIsUZMWj4n4YK+7qwjikOKqTkk/QL5u4A6DJNJx4WchfkyMbIECRudOzaIoiT9C/AQ==
X-Received: by 2002:a17:90b:2389:b0:213:971d:902e with SMTP id mr9-20020a17090b238900b00213971d902emr3335198pjb.123.1668533935247;
        Tue, 15 Nov 2022 09:38:55 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b00172fad607b3sm10272327plh.207.2022.11.15.09.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:38:54 -0800 (PST)
Message-ID: <9cda597c-1d31-4b8b-99ba-deab58975976@rivosinc.com>
Date:   Tue, 15 Nov 2022 09:38:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v12 04/17] riscv: Add vector feature to compile
Content-Language: en-US
To:     Conor.Dooley@microchip.com, bjorn@kernel.org, stillson@rivosinc.com
Cc:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-4-stillson@rivosinc.com>
 <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
 <98343aa8-b04d-fe58-8af8-4eeca03106d1@microchip.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <98343aa8-b04d-fe58-8af8-4eeca03106d1@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/22 08:16, Conor.Dooley@microchip.com wrote:
>>> +config VECTOR
>>> +     bool "VECTOR support"
>>> +     depends on GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
>>> +     default n
>>> +     help
>>> +       Say N here if you want to disable all vector related procedure
>>> +       in the kernel.
>>> +
>>> +       If you don't know what to do here, say Y.
>>> +
>>> +endmenu
>> "VECTOR" is not really consistent to how the other configs are named;
>> RISCV_ISA_V, RISCV_ISA_VECTOR, RISCV_VECTOR?
> It'd be RISCV_ISA_V to match the others single letter extentions, right?

Yep.

> The toolchain dependency check here also seems rather naive.

Indeed. I can build the code just fine with gcc-11 (and gcc-12), 
although my reworked patcheset doesn't include all the orig patches 
including the in-kernel xor stuff.

-Vineet



