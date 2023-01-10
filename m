Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED46664E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjAJWRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjAJWRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:17:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B525B170
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:17:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o13so10393465pjg.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eubwlTjLbS6LF+xfl33NbO6mIr60CrwQo+9xM2e1vEk=;
        b=EJb7Z2t8LBtTrIg200Hh0oR4ECKefbV35wQRUANpaQ8/omu0woJIaIkvFZui8ud5Ul
         UfPEn21ivY0IreFexZxhYWIjupEiN8TOuRPEEFbaNwSVq2yj2erHV8mcxrFt30Jc96J0
         U5jR6rnd0asP7A3LBBW4oorCqDCiJdBSi3h+/LniYjaZ9jP6c2jlwdjJlnZlAE6F2r1p
         6/2ThDIE5fRzEbg1tIWHBYVob6HSJqOsJlLwSkTAtdAFXUZf3L4J1TgvPGuMSEOS3aJ4
         bVXBz5b6IvlU0EllxfZKD+Few4X2gYt0ppUzgB6E5Sr0r7vYwC89kKbfumM0QaKGGpZJ
         EZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eubwlTjLbS6LF+xfl33NbO6mIr60CrwQo+9xM2e1vEk=;
        b=X4WnWGGcaZnuEt0gv0lfBtUvNTLmCWQEgDn+SVMH9jhRKKw0R0wJmh5069n5HbsenC
         tbe1sbl6EMJRKd/qpYQQ1b/ty4xOZnTK8sqYogqW6MubP0aMlMuY40L70xgeeo/WG8N6
         xH1viOiviBEqWbNZlRf/UbgkhYpmx9FdPb+U/hF00RXO8RizGGJxqLA/puPpiWsGvVHf
         zyrtZ1aY3jpvNNLnoQLMAco99ms5mHg7VtFM//x6pfkgUyuPOQMJig1KOaryu5+u0qiI
         bg6G+bmYS9PJdfZ07u5XFdpFom2/5Lcv4IK1yhKaXC2x7nIA11BujhFHlJIfB+l99FSz
         ysqA==
X-Gm-Message-State: AFqh2koIYhk2pnk+KCuXbr3nKZSa/ekpOmGDUv0bFwaGVZhpoL0aOM28
        t+gTRafwFYNirozCYWYmStFXYA==
X-Google-Smtp-Source: AMrXdXsQ3V3JH7+Exzn6JcXoAWs2LZbt43xeVAwEtFJlR4eMzp1QGQLiCG+YQdNyHdHFTT7HtjNbbA==
X-Received: by 2002:a17:90a:62c1:b0:226:d7e8:e11f with SMTP id k1-20020a17090a62c100b00226d7e8e11fmr19174103pjs.12.1673389020392;
        Tue, 10 Jan 2023 14:17:00 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id k15-20020a17090a3ccf00b002195819d541sm9593528pjd.8.2023.01.10.14.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 14:17:00 -0800 (PST)
Message-ID: <dfffd3ab-d607-9b1f-92a5-24a798807849@rivosinc.com>
Date:   Tue, 10 Jan 2023 14:16:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
 <Y73g/nkDe7Sfp9ps@spud>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <Y73g/nkDe7Sfp9ps@spud>
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


On 1/10/23 14:04, Conor Dooley wrote:
> Hey Vineet,
>
> While you're at it with Jess' concerns, couple nitpicks for you.
> May as well say them now rather than while a v2 comes around.

Thx for quick peek.

> On Tue, Jan 10, 2023 at 12:18:41PM -0800, Vineet Gupta wrote:
>
>> Reported-by: kernel test robot <lkp@intel.com>  # code under CONFIG_COMPAT
> You can drop this, even if it reported against a private branch AFAIU,
> just like its complaints about patches. As Greg would say, LKP didn't
> report a feature!

OK. Personally I tend to add Tested-by (vs. Reported-by for the same 
reasons) to still give them the credit for finding some issue.
I can certainly drop it.

>
>> diff --git a/arch/riscv/kernel/elf-attr.c b/arch/riscv/kernel/elf-attr.c
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023-24 Rivos Inc.
> s/-24//

Fixed.

>
>> +static u64
>> +decode_uleb128(unsigned char **dpp)
> Surely that fits inside 80?

Fixed.

>> +static int rv_parse_elf_attributes(struct file *f, const struct elf_phdr *phdr,
>> +				   struct arch_elf_state *state)
>> +{
>> +	unsigned char buf[RV_ATTR_SEC_SZ];
>> +	unsigned char *p;
>> +	ssize_t n;
>> +	int ret = 0;
>> +	loff_t pos;
>> +
>> +	pr_debug("Section .riscv.attributes found\n");
>> +
>> +	/* Assume a reasonable size for now */
>> +	if (phdr->p_filesz > sizeof(buf))
>> +		return -ENOEXEC;
>> +
>> +	memset(buf, 0, RV_ATTR_SEC_SZ);
>> +	pos = phdr->p_offset;
>> +	n = kernel_read(f, &buf, phdr->p_filesz, &pos);
>> +
>> +	if (n < 0)
>> +		return -EIO;
>> +
>> +	p = buf;
>> +	p++;				/* format-version (1B) */
>> +
>> +	while ((p - buf) < n) {
>> +
> While I'm already passing through, checkpatch isn't the biggest fan of
> your whitespace after open braces:
>
> https://gist.github.com/conor-pwbot/a572e395763916c7716cab9c870df4f3

I swear this patch was checkpatch clean. Fixed now anyways.

>
>> +		unsigned char *vendor_start;
>> +		u32 len;
>> +
>> +		/*
>> +		 * Organized as "vendor" sub-section(s).
>> +		 * Current only 1 specified "riscv"
> Is it worth having a comment like this that may rapidly go out of date?

Rapid may be an overstatement given this is a psABI thing. Besides for a 
new vendor subsection, more code will need to be added to sanity check etc.
But I can drop this from comment and instead mention this in the changelog.

Thx,
-Vineet
