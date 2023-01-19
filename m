Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC676745D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjASWWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjASWVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:21:23 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C98B9EC2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:05:50 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r18so2683918pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sVai79VyKVjTclfs4QkNn2Z6tiaBVxHfLb2mb+hHHw=;
        b=P7C5Qc5yNlZSvjJ1A93VaunDMlySpnLK9MDNegAHLhpZr7qseEyn+4yRb2P7PKiSqm
         lJ8knp3FEqe2SL6lgd37Arp1mZA2kk2/ea8W4cxljSfoREDVhLSJLtKTs5DaGzmz19T7
         3sL9BdY+GWwB8miGP/TLr89W2Oa+bbOM04hHJoHAw+YfgvAw+KvxoFayyIRc3Gu9swDv
         cfqM0sqwkGE54ukEXzAo+KhsKkvBzzAPsOD9K6jgH2KVHtVpDKCFe/ZdEVQHb9MI3Ukb
         +dMfKjLdUud8S0JAVV2RIrzv8Fm7FKuYVd7qgmgX9x2hQYN8nlbWjKZyq24U4huG8eMq
         EoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+sVai79VyKVjTclfs4QkNn2Z6tiaBVxHfLb2mb+hHHw=;
        b=O+hPxC0MMrmcQBXRhoad96U9fZVxQm+dlMVXJ0xlbxW5aaSbPHYQOFea7TmPFHX6eP
         qFoRdsvSRnw34rYryvbQ2u6SHC7M7hPgi9V94rVQtrKV3qTLiA5fnr2DzX6UvW1OSSAF
         ClH6uzMS8aUKAcqCfSmJECJ/JnMpqsQKn4yeuMZ3eXPIr8uA68ZKaybvo2g2D4fySsjo
         71ErHp9IPdKrKAf4UYRYEFHaeD1nFpvxw216boz9cZ1k7KJPXfKnM+7HqHlmwBI+jyyZ
         qIssr1P7IUTtj8CIaOHculXtuulY6kT1C4JjlIORKus/QjYlPWh3lKq/Ml84dOTUZpzV
         yocw==
X-Gm-Message-State: AFqh2koMWGBtQmjltycNnjsvPe+6ruGk9mmBn6nVF+b1VjSvftOgGHMm
        RMe+qgd46ZJ1484uJPyHnykMDg==
X-Google-Smtp-Source: AMrXdXskzOKBgZDhvVuOqyiEkPETrZSj1IAtdFhfCUtpTmunicD6BpXIfkxMquF9ieQHpi0aqRDjRw==
X-Received: by 2002:a62:5341:0:b0:57f:c170:dc6 with SMTP id h62-20020a625341000000b0057fc1700dc6mr11163092pfb.14.1674165949869;
        Thu, 19 Jan 2023 14:05:49 -0800 (PST)
Received: from [10.0.17.151] ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a19-20020aa79713000000b0058e0bad6705sm872274pfg.67.2023.01.19.14.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 14:05:49 -0800 (PST)
Message-ID: <67c50e8d-ae78-076d-cf25-b7781f2209d7@rivosinc.com>
Date:   Thu, 19 Jan 2023 14:05:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] riscv: elf: add .riscv.attributes parsing
Content-Language: en-US
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com
References: <c2177e4e-e97d-448a-73e7-c50622fdc4bb@rivosinc.com>
 <20230119174357.3550008-1-vineetg@rivosinc.com>
 <EB6B06BB-C65F-41C2-8D9F-F916F3A706FA@jrtc27.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <EB6B06BB-C65F-41C2-8D9F-F916F3A706FA@jrtc27.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 12:33, Jessica Clarke wrote:
>> +
>> +/*
>> + * Parse a single elf attribute.
>> + */
>> +static int rv_parse_elf_attr_safe(unsigned char **dpp, unsigned char *p_end)
>> +{
>> +	unsigned char *p = *dpp;
>> +	unsigned char *str;
>> +	u64 tag, val;
>> +	u32 s_len;
>> +
>> +	if (decode_uleb128_safe(&p, &tag, p_end))
>> +		goto bad_attr;
>> +
>> +	switch (tag) {
>> +	case RV_ATTR_TAG_stack_align:
>> +		if (decode_uleb128_safe(&p, &val, p_end))
>> +			goto bad_attr;
>> +		if (!ELF_ATTR_TAG_EVEN(tag))
>> +			goto bad_attr;
> Huh? You just checked it against a constant so you know exactly what it
> is. This is just Static_assert(RV_ATTR_TAG_stack_align % 2 == 0) but at
> run time. And you know that’s going to be the case, because the spec is
> self-consistent by design (wouldn’t be a worthwhile spec otherwise).

Makes sense.

>> +		rv_elf_attr_int(tag, val);
>> +		break;
>> +
>> +	case RV_ATTR_TAG_unaligned_access:
>> +		if (decode_uleb128_safe(&p, &val, p_end))
>> +			goto bad_attr;
>> +		if (!ELF_ATTR_TAG_EVEN(tag))
>> +			goto bad_attr;
>> +		rv_elf_attr_int(tag, val);
>> +		break;
>> +
>> +	case RV_ATTR_TAG_arch:
>> +		if (ELF_ATTR_TAG_EVEN(tag))
>> +			goto bad_attr;
>> +		str = p;
>> +		s_len = strnlen(p, p_end - p) + 1;
>> +		if ((p + s_len) > p_end)
>> +			goto bad_attr;
>> +		p += s_len;
>> +		rv_elf_attr_str(tag, str);
>> +		break;
>> +
>> +	default:
> The whole point of the even/odd split is so that when you *don’t* know
> what the tag means you can still decode its value and thus know how to
> skip past it. That is, *here* is where you need to be checking
> even/odd, and deciding whether to treat it as a string or a ULEB128,

I see the point. We can ignore the specific tags and just treat odd and 
even tags as string and int respectively.
And keep a loose check of the known tags vs. unknown.

> which is why I annotated *here* not one of the other case labels before.

OK. I really need to pay attention to what and where to your comments :-)


>
>> +	memset(buf, 0, RV_ATTR_SEC_SZ);
>> +	pos = phdr->p_offset;
>> +	n = kernel_read(f, &buf, phdr->p_filesz, &pos);
>> +
>> +	if (n <= 0)
>> +		return -EIO;
> 0 should be ENOEXEC not EIO? And surely in the < 0 case you want to be
> forwarding on the exact error from kernel_read, not squashing it into
> EIO?

Right.

>
>> +/*
>> + * Hook invoked by generic elf loader to parse riscv specific elf segments.
>> + */
>> +int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
>> +		     bool is_interp, struct arch_elf_state *state)
>> +{
>> +	struct elf_phdr *phdr = _phdr;
>> +	int ret = 0;
>> +
>> +	if (phdr->p_type == PT_RISCV_ATTRIBUTES && !is_interp)
> Both the executable and its interpreter matter.

OK.

Thx,
-Vineet
