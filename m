Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3106D1005
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjC3UaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjC3UaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:30:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D04E38B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:30:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id er13so40418125edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1680208212;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQbNA9BMfHodQthXeq3HDEwp23ZLhRyoPcVaPU/z5mQ=;
        b=fMxfHQ88wruFvMt1R7FsWa71D3sKGpDj6ZkJHN/lVBZAcq6+sSafv/mjELilxf/jUN
         V2aP2NzkdvjivYdeJtK/kjqial4My6A/yByZwanW/oe5LlGLjjD3OfkivWOyx34Qlt+n
         5CFrpNNyh2BE4VvK2eoPDOeVtAj3nLxah/Q52n+20QM3Aib9MpX9VaSuqU9d8+6kUpzQ
         xPwIDoL8wOKYAidxKwR1R5NS2bR1giSCMfJ7+FUXFS9+MknUGXa89CE1HCXpVMQ79iyt
         yYHiBNlEE42qDlViPrkE+DjQ7fta0QRwavlaHaqa+XgIigPz5QQi5q4Vxn3Ix7Bpt7rc
         u6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208212;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQbNA9BMfHodQthXeq3HDEwp23ZLhRyoPcVaPU/z5mQ=;
        b=uGAPOi7pVuKI7Y+MVEDySavRdm9HqQaxZawm//DlY2/Ani7+O4p6Vg40IlAE4lJiXZ
         KAN+KtKKdyVqp4xVR9CDJujexA8+RAIxK+gCovitzsAmr9CBibuyyfZjb1XubzMsk+7W
         +psbVEPZnOSUgCwtH1L0MzQ0B1v4rEmoeAV37YycRJumHkjHVotFwRsJZ7H914oGZ8iZ
         utbL6Qdps1wkLqZIyuMGXB1O2xyCe18uily3knGuMGHIGqWpr2fSJVq3lTlnKT0VnaF6
         L53eNhJURyX5tVObLmFohk8OoEm4wPyOts7ww1MvFnTPY4QcnOTRZRfV2rGHKanRxzyW
         qg0g==
X-Gm-Message-State: AAQBX9d/Nj2eaimCa7nOzL0n953zvKQCMIlwWqmOIXkRsr9TE0o/9zNN
        GrknYEOXu/gBqJAvho+jqTmFIsVmA2mK1vR0i3c=
X-Google-Smtp-Source: AKy350aNgGxGtY0KlVwno8fc6Itwr8L4ySQJIhidIAISBKojRE8XqPogV2MFeFiQ6JEY4EJvesrSgg==
X-Received: by 2002:a17:906:fcc:b0:879:d438:4d1c with SMTP id c12-20020a1709060fcc00b00879d4384d1cmr27490892ejk.21.1680208211933;
        Thu, 30 Mar 2023 13:30:11 -0700 (PDT)
Received: from ?IPV6:2003:f6:af13:8b00:c684:f698:a009:dbf2? ([2003:f6:af13:8b00:c684:f698:a009:dbf2])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709061be200b00932b3e2c015sm191860ejg.51.2023.03.30.13.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 13:30:11 -0700 (PDT)
Message-ID: <4c5f4f61-a8d1-a707-8100-e095d3b18398@grsecurity.net>
Date:   Thu, 30 Mar 2023 22:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 6/6] KVM: VMX: Make CR0.WP a guest owned bit
Content-Language: en-US, de-DE
From:   Mathias Krause <minipli@grsecurity.net>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20230322013731.102955-1-minipli@grsecurity.net>
 <20230322013731.102955-7-minipli@grsecurity.net>
 <677169b4-051f-fcae-756b-9a3e1bb9f8fe@grsecurity.net>
 <ZCXDAiUOnsL3fRBj@google.com>
 <ea3a8fbc-2bf8-7442-e498-3e5818384c83@grsecurity.net>
In-Reply-To: <ea3a8fbc-2bf8-7442-e498-3e5818384c83@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 22:15, Mathias Krause wrote:
> [...]
> Maybe it's not a stale CR0 value but the page table walker not taking
> the guest's CR0.WP into account? Maybe a missing role update?

Indeed, it is. This does the trick for me:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 31be188aa842..6a9e90725c84 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8372,6 +8372,9 @@ static void init_emulate_ctxt(struct kvm_vcpu *vcpu)

        init_decode_cache(ctxt);
        vcpu->arch.emulate_regs_need_sync_from_vcpu = false;
+       /* Ensure we're doing page table walks with an up2date MMU role */
+       if ((vcpu->arch.cr0 ^ kvm_read_cr0(vcpu)) == X86_CR0_WP)
+               kvm_init_mmu(vcpu);
 }

 void kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip)

Very heavy weight and misplaced, but a start :)

It should (1) be limited to VMX as that's the only one that would make
CR0.WP a guest owned bit and (2) limited to emulated instructions that
actually do write operations, as read are harmless, obviously.

Mathias
