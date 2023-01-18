Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23696672C66
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjARXTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjARXTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:19:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258762D0D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:19:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so664561plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 15:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K9Yw1dDzEg29HUd/WuRUgZJfGX/RT7S/Bo0mzAWnWJk=;
        b=L7EtwNkm3GfK9KDmZM8iiBTqkFnroNqU94ipZ2ey4z1AG1xCIoByIo+zZYwiOlYy0I
         W4hWkl1QLRJ/wScc4f0i2hTxJdtutWLvhlAbvbHnoG41WV1MfQFRTeTTJXDFOIeahbms
         U47qiDdKAhdtxPdoxQjquES5R3C+32jvdBS2C1Y4t/hZlud4eSfy9CCqS/pvD2Ey074x
         mYFRSam7uP8kFjtNaMCTbOjeYW8b2Mj8LFf88UfDN+5A6xcymYXLC8tX3Qe5ttX1iPAJ
         Y/nSw0pd2dFQhi+ee/ZUVb2xfSih8231dAR/+igj7ONbWjyfnyUIdiVC108MEEyAtn/E
         9xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9Yw1dDzEg29HUd/WuRUgZJfGX/RT7S/Bo0mzAWnWJk=;
        b=32TdqoyK8qBqkdiOcnP3rviakU6xG276vtbf+qoyYPSztqemXlnoUea/mC7Tc0zi75
         M36e5W8aRkcyBXUFE8wtG9UkMX+oaMLmeZtmMPWAXbyv5TKV545AKhzjtDDZuR8XysLw
         joN5TsdzSj55saDSfxDngIsA0JZ+Dgr/4KPwmdlhW6GGoF1CWNHlvt8qzSoRPDQgIV+8
         saSGMz1cxpQ8/XG0X6kcAop273SYPTwKhSPrPlZorT/vVxCXad5T9/qfej8J4KSxSVEX
         /1ld0ax6qpefXVe0EdrFCR/xyFFYpxuBlWVhc0LjVLh2dwxl2840FkuM/s2OwDN7j/jZ
         rX6w==
X-Gm-Message-State: AFqh2ko8mUE1+V2zhva69ok8gKYSQxBHcoIm0NSNWC18PWmWllNrfVjx
        iiqsl6rXZm9+Hfx7JuxDGQZSFw==
X-Google-Smtp-Source: AMrXdXscmrxsowA8TyEJv6Vz36cEASQ3Q8G6D5/38r+WuVk+32LVTVik+YABa3AC0m4fctwdjB4nYw==
X-Received: by 2002:a05:6a20:2a93:b0:af:8e92:411c with SMTP id v19-20020a056a202a9300b000af8e92411cmr39271142pzh.44.1674083957664;
        Wed, 18 Jan 2023 15:19:17 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090a3d0f00b00226d4009505sm1852430pjc.3.2023.01.18.15.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 15:19:17 -0800 (PST)
Message-ID: <c2177e4e-e97d-448a-73e7-c50622fdc4bb@rivosinc.com>
Date:   Wed, 18 Jan 2023 15:19:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Vineet Gupta <vineetg@rivosinc.com>
Subject: Re: [PATCH v2] riscv: elf: add .riscv.attributes parsing
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com
References: <20230112210622.2337254-1-vineetg@rivosinc.com>
 <D6A37757-DB22-44C6-A906-D68A0B8BD7A6@jrtc27.com>
Content-Language: en-US
In-Reply-To: <D6A37757-DB22-44C6-A906-D68A0B8BD7A6@jrtc27.com>
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



On 1/12/23 14:38, Jessica Clarke wrote:
> On 12 Jan 2023, at 21:06, Vineet Gupta<vineetg@rivosinc.com>  wrote:

>> +static int
>> +decode_uleb128_safe(unsigned char **dpp, u32 *val, const unsigned char *p_end)
>> +{
>> +	unsigned char *bp = *dpp;
>> +	unsigned char byte;
>> +	unsigned int shift = 0;
>> +	u32 result = 0;

Ved commented off-list about u32 being wide enough. So I'll be making 
@val u64 everywhere.

>> +	int ok = 0;
>> +
>> +	while (bp < p_end) {
>> +		byte = *bp++;
>> +		result |= (byte & 0x7f) << shift;
>> +		if ((byte & 0x80) == 0) {
>> +			ok = 1;
>> +			break;
> Why not just do the return here?

I guess  I could.

>> +
>> +	case RV_ATTR_TAG_arch:
>> +		str = p;
>> +		s_len = strnlen(p, p_end - p) + 1;
>> +		p += s_len;
>> +		if (p > p_end)
> Constructing such a p is UB, check s_len before instead.

OK.


>> +			goto bad_attr;
>> +		rv_elf_attr_str(tag, str);
>> +		break;
>> +
>> +	default:
>> +		if (decode_uleb128_safe(&p, &val, p_end))
>  From the ratified spec:
>
>    "RISC-V attributes have a string value if the tag number is odd and an integer value if the tag number is even."

OK, added sanity checks.


>
>> +
>> +	memset(buf, 0, RV_ATTR_SEC_SZ);
> This will hide bugs from sanitisers...

And if kernel_read() fills it partially, leave the rest uninitialized ?
I'll keep the memset.

>> +	pos = phdr->p_offset;
>> +	n = kernel_read(f, &buf, phdr->p_filesz, &pos);
>> +
>> +	if (n < 0)
>> +		return -EIO;
>> +
>> +	p = buf;
>> +	p_end = p + n;
>> +
>> +	/* sanity check format-version */
>> +	if (*p++ != 'A')
> What if n is 0?

I can check for n <= 0 above.

>> +		goto bad_elf;
>> +
>> +	/*
>> +	 * elf attribute section organized as Vendor sub-sections(s)
>> +	 *   {sub-section length, vendor name, vendor data}
>> +	 * Vendor data organized as sub-subsection(s)
>> +	 *   {tag, sub-subsection length, attributes contents}
>> +	 * Attribute contents organized as
>> +	 *   {tag, value} pair(s).
>> +	 */
>> +	while ((p_end - p) >= 4) {
>> +		int sub_len, vname_len;
> u32?

OK.

>> +
>> +		sub_len = get_unaligned_le32(p);
>> +		if (sub_len <= 4 || sub_len > n)
> n is the total amount read in, not the remaining amount.

Fixed to sub_len > (p_end - p)

>
>> +
>> +		/* Vendor data: sub-subsections(s) */
>> +		while (sub_len > 0) {
>> +			u32 tag, content_len;
>> +			unsigned char *sub_end, *sub_start = p;
> Confusing naming for sub-subsection variables.

Fair enough: p_ss_start, p_ss_end, ss_len

Thx.
-Vineet
