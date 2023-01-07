Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0F660BAA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjAGBzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGBzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:55:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988EB87932;
        Fri,  6 Jan 2023 17:55:17 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g20so2356372pfb.3;
        Fri, 06 Jan 2023 17:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WiE9aq7CtTSo+zZrwgXjM5Sx1ReRFTbH7Mc82mkzs20=;
        b=mMEQ/pwviizJe18JUOm1/S2YKaL2JKZpjNiKiXEPxmqsg9fc27mMD9PB9u3KdYhx13
         AkN1vj2CT+tUm0wy31frMUr09Ouw8zxRxXal2ARX2gBrSCSajsquJNgxrRob9vc6qEp+
         Bt7yJDfpUT646dmlh77nDspeWAMhwk6AU3W0Z5wLyYJFV08YcSorA/CeL5G3sQlg8IQF
         dF7FyUxqwDIIzrTfRAc2/wfBOuYrX6ezsj3rLxKs/1MontPjS5Lmrm0daTo8SAUHhppx
         eVqfBFe5o7iFsxRaRUDRz9hU+TgDyluC5xgR4BU0hdAcTc7yb861DjanivtyZQSRooXR
         q8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiE9aq7CtTSo+zZrwgXjM5Sx1ReRFTbH7Mc82mkzs20=;
        b=4gSOLJSG7P8mcwY74HL0XwUF/3ZQtlMAMwCSiwrpYnmeG8C98FQAO+4SMiUfEGH/kI
         6ZtiYGxjNSlwAyQWLMAcGFlf4og4YxZRpLu1Ux9NZJiVqKVbSeladEy3ciz14Om3QOpv
         QM5Y1QKKJeEsAXDv+nJBML2sPqVS1Hmp0ihp1oTZIUZhlchEgVn/C5PVqwahJ52Xa+5+
         KbOEfRm7rofcCkiGkMZpNXA6Rw+W7yj2mB4NAR/mUicM3UXIt+XnrN1ajYwGsSS86Al/
         sK3zIXS97+3eTMnQbkPZ0OhTLPc+ithp4REc/4DGlhtUFrb752vQAvoiZOo7Nzqb/rH4
         VZhA==
X-Gm-Message-State: AFqh2kozCTSyUZrnkCfnDjBoXvdRTSnNNnF//EMke9D8vWCrJtUNHdlq
        JsDGYPK5EydFNmO40rk2e4l/sYQUpKM=
X-Google-Smtp-Source: AMrXdXvXYRXodb/IUBqtghKjdnhIX/k2TeWhcXrSVP7Ygcs6auTKhP5F05034vpm/4riXTuOl93R5A==
X-Received: by 2002:a62:1d96:0:b0:575:e8c5:eb14 with SMTP id d144-20020a621d96000000b00575e8c5eb14mr56028702pfd.18.1673056516596;
        Fri, 06 Jan 2023 17:55:16 -0800 (PST)
Received: from ?IPV6:2602:47:d48c:8101:9d81:5b04:51d7:acae? ([2602:47:d48c:8101:9d81:5b04:51d7:acae])
        by smtp.googlemail.com with ESMTPSA id z67-20020a626546000000b005833f0e58b7sm1687716pfb.130.2023.01.06.17.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 17:55:16 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
Message-ID: <84c0d4ea-09e2-4907-d03d-939d40fa3c96@twiddle.net>
Date:   Fri, 6 Jan 2023 17:55:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] alpha: fix FEN fault handling
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <Y7jD8XDZGnQkTvMI@ZenIV>
Content-Language: en-US
From:   Richard Henderson <rth@twiddle.net>
In-Reply-To: <Y7jD8XDZGnQkTvMI@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/23 16:59, Al Viro wrote:
> Type 3 instruction fault (FPU insn with FPU disabled) is handled
> by quietly enabling FPU and returning.  Which is fine, except that
> we need to do that both for fault in userland and in the kernel;
> the latter *can* legitimately happen - all it takes is this:
> 
> .global _start
> _start:
> 	call_pal 0xae
> 	lda $0, 0
> 	ldq $0, 0($0)
> 
> - call_pal CLRFEN to clear "FPU enabled" flag and arrange for
> a signal delivery (SIGSEGV in this case).
> 
> Fixed by moving the handling of type 3 into the common part of
> do_entIF(), before we check for kernel vs. user mode.
> 
> Incidentally, check for kernel mode is unidiomatic; the normal
> way to do that is !user_mode(regs).  The difference is that
> the open-coded variant treats any of bits 63..3 of regs->ps being
> set as "it's user mode" while the normal approach is to check just
> the bit 3.  PS is a 4-bit register and regs->ps always will have
> bits 63..4 clear, so the open-code variant here is actually equivalent
> to !user_mode(regs).  Harder to follow, though...
> 
> Reproducer above will crash any box where CLRFEN is not ignored by
> PAL (== any actual hardware, AFAICS; PAL used in qemu doesn't
> bother implementing that crap).

I didn't realize I'd forgotten this in qemu.  Anyway,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
