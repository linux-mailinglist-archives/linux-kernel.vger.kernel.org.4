Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11E76743DC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjASVAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjASU6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:58:40 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC469FDE7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:57:13 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id j10-20020a17090a7e8a00b00229f4c02a49so940216pjl.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bH13mQhRUU7b8EB6xov/auoX/BjFue416NjgtMgR1wo=;
        b=hHQRoWMQf7qVGttNm21+m0vpXxahusZ33qOJQf7eyh496BhiN00fNvXpdowqTe/Cjj
         i1mIKKjvIyKDyvKX3TWETFE6mMF4VeyNlUtIya8Rdvm1KQHlygU+wyJPQ1v5Px+BLptb
         hLIoq93ERlDdsShqm6Md2dOCsTWEEfUFcT0hGJW8u4a4igVo1rCuuMA5EUVsOeDsWEH6
         9kyVc1xUtwg8TPIT6ryJsHN3LOICneqAZ0Xr61sZZPM6I2PYYQprTtuSx2CMLVQJiCQc
         FO1CqXMhIxymQ34Mp5tKQ0aVYzCm4OL6OS0IanwOYctkE/jaKwmCekHR+5om1A9BZP8J
         q4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bH13mQhRUU7b8EB6xov/auoX/BjFue416NjgtMgR1wo=;
        b=sdBP4ClzwGHUSU+nWalOAEYiXDBDmKgl5hGp4fgnlohAwOE2ztztpi+POvMu65M/kI
         Yn7UnW4EdX1HD+licmVOzr4T0yJG25OtVmEL0HlKopdcTVUZ4zwWcZ+J1X08/kywp3/V
         Nzhi61iS+rJvAN6+J9aVBLWnut72NfUZ3Z8/zLHvqXEN2RfoC+FFaPG5yMyMo4yORlbc
         1KV7Z6gb3Wf3RxAmTtbYJQGGiKyfFSKNb9EHbU60jBQSHlWoqHah5fvfyNC8UrLEPWgv
         Lzo7S6Y+wJguWgsmBbl4ZTcvk+QqgDzqPTHPB7Fo1OJ4nfn/dxsZ1JGaRKUaGi+vPsuN
         D+vw==
X-Gm-Message-State: AFqh2koFMP2AKYco7ZExwZwX/jmMyzNeP4XI3HIGUbsaFdTpQw7lxmkg
        IK/QSIvXqacLkMD+xUQE1pQ/dZ/zoY0=
X-Google-Smtp-Source: AMrXdXsNcBRRH5SpMRRSQ+uzFtmcWKLZZTqJoUDlgp+y+n+qXW9t/DNW60KeRO1WV4TuJOym80ql7bdcJd0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:cc:b0:58d:bb5c:5050 with SMTP id
 e12-20020a056a0000cc00b0058dbb5c5050mr1157304pfj.44.1674161832598; Thu, 19
 Jan 2023 12:57:12 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:54:08 +0000
In-Reply-To: <20221128214709.224710-1-wei.liu@kernel.org>
Mime-Version: 1.0
References: <20221128214709.224710-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167408866924.2366047.9012916781914614502.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: fix an incorrect comment in kvm_mmu_new_pgd()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 21:47:09 +0000, Wei Liu wrote:
> There is no function named kvm_mmu_ensure_valid_pgd().
> 
> Fix the comment and remove the pair of braces to conform to Linux kernel
> coding style.
> 
> 

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/mmu: fix an incorrect comment in kvm_mmu_new_pgd()
      https://github.com/kvm-x86/linux/commit/03e5fdfd708e

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
