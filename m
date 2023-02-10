Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29E69150B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjBJACG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBJACC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:02:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D893711658
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:01:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o15so225906wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6L/XB8P8oVvWkbHdCIAnUfdPJAkV2ylf7wRLS26dMw=;
        b=lDFibBy5RuKO75ZS8Maam7O79apzaGbz5xYVvAbOLHtXEdLDCNOSBtrfiBIRC5xnFs
         Mf8CTmwGMJ89LiU4cmF2M4uZK3YHRkbMAW6aWJfN7KZbYTvBhL6K+rmxpj1ct9SbimPw
         dKyroB30uJ2qBjC+66pkevKfcysT4999F38dpewan/60V3nSOeX69QYio1ht1GLrTAh4
         QYm26dIrumwtFeSbDFYIYcVItEhb8nohNNnyYA6NbJj3cI+WyNXulNB8pX2GMXiPHqrl
         kZ5WxJ5BH7ApyhYHtXrNF7KAYUlDuz4L0xJFuigF2Z9B6J0BXQE0gsjjfXXVf0esgEnM
         +/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6L/XB8P8oVvWkbHdCIAnUfdPJAkV2ylf7wRLS26dMw=;
        b=4E4oCczCcmudJichppilPWfF+Y7FqmU3QCEqE4ODQr5d0Kof9ioVAZcwPsZPVupWS4
         xS2URYZPhucUzyfcG2Ua+1Uuqk/3JU5TQ7yadhUHFA77FS+w6xuKvJ3IgKzL75viNp9n
         uddc1HEYAaIerLzWmvP1WpeXrNPXKJ8e1zwqVxoGE9AuHL9IBXbFFShb5lgjYJwdkTBu
         5hqXe3PkA0w0JFfreWNrglVPCfE02bFOayJrDem3bbREx8p+Qo63n/cf/JMgQfq9/LWv
         gsdCUIQuPE/iz0IY3wgfvaen64qEw3vGTWvvyZSsb9qiJI06oSd/j6tMfMr7plIVg1c4
         dBWA==
X-Gm-Message-State: AO0yUKVAy6UCyz03edwaL/lfZUuHASICfbeKd79qwKAJeweetXNlA6QX
        4rfFfyt7RMmdbsyOfG1ip6rdHBVcNhVm/2hR
X-Google-Smtp-Source: AK7set88rbTO/HLoV2uD0zXHZ8hjk6h0hjwwjKvJWFt8gikwiaJ9PR1DUPl4BD2PcFGarUvr7+vtjg==
X-Received: by 2002:adf:df07:0:b0:2c4:b150:9279 with SMTP id y7-20020adfdf07000000b002c4b1509279mr4045997wrl.40.1675987318154;
        Thu, 09 Feb 2023 16:01:58 -0800 (PST)
Received: from [192.168.86.94] ([77.137.71.15])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002c3d814cc63sm2258658wrx.76.2023.02.09.16.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 16:01:57 -0800 (PST)
Message-ID: <b79052ee-07d2-a6b9-03cb-b33f61985fe2@gmail.com>
Date:   Fri, 10 Feb 2023 02:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.0
Subject: Re: [PATCH -tip] kprobes/x86: Remove unneeded casting from immediate
 value
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <167595699689.1303232.13460109151246012198.stgit@mhiramat.roam.corp.google.com>
Content-Language: en-US
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <167595699689.1303232.13460109151246012198.stgit@mhiramat.roam.corp.google.com>
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


On 2/9/23 5:36 PM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Remove unneeded casting from immediate value assignments for relative
> jump offset. Since the immediate values in the 'insn' data structure are
> assigned from immediate bytes as a signed value to insn.immediate.value
> by insn_field_set(). Thus, if we need to access that value as a signed
> value (in this kprobe's case), we don't need to cast it.
> This is a kind of clean up (should not change behavior) follows Nadav's
> bugfix.
>
> Link: https://lore.kernel.org/all/20230208071708.4048-1-namit@vmware.com/
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   arch/x86/kernel/kprobes/core.c |   16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 695873c0f50b..2440e736d0e4 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -607,19 +607,19 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
>   	case 0xe8:	/* near call relative */
>   		p->ainsn.emulate_op = kprobe_emulate_call;
>   		if (insn->immediate.nbytes == 2)
> -			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
> +			p->ainsn.rel32 = insn->immediate.value;
>   		else
> -			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
> +			p->ainsn.rel32 = insn->immediate.value;

Hmm.. I don't get it. What the purpose of keeping the duplicated code 
(after your change)?

