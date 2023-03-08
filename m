Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C16AFCB1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCHB7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHB7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:59:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE389B985
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:59:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso16142511ybi.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 17:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678240787;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMnkKJBSeJLIJWJ63dxJ2l/pcjlqG3hWFQL9cnDzY4k=;
        b=UYWeE57l4lIGpWifAsQVo5d4uLP7r1X7sI2k/QIXPtpXHWrBkeh86kl8tJubGv0ngo
         IlngOFBEcq4XZCUWvy5J2OFgykjp9rggBEBhpUgmv6JOl5yd6pTfo1gtTF6JcIO8JoJv
         CLm1u+9+ePTKgtLkd2pH2gJEwGFejqBxzpicjaRDp/tmEjgVw/awy4mjGJty879zeb7L
         Ojj+7Fhvf48yYY7IMaM6T3iRDmIVUikq7smmJClANesZrp+iEcUwRwIF7H47IT++LYsF
         Pd9IdtFFH0f502mumYnDSoUVrWT/yXEd8faAYJZ+f8f/WVu42UnADf3swEElAG8nTx50
         SSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678240787;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMnkKJBSeJLIJWJ63dxJ2l/pcjlqG3hWFQL9cnDzY4k=;
        b=EMQRXwPe2l6qhfYL6lnxKcMIuTsoFyw3gPYkq3MZhF9VVihDE2uAMtAOT8tr6gCBUP
         r7rkz/fR2xcO8ocjlgsJsZHpG2DSRg929h4Hl9CkKXObGIG06sWInFEe3FgQQPM8PHZO
         rEvk6yyp3py+0x2Y1/Ojwze0JW4PhMnvDim6XQjbFJfsD8XmBxjKpjnjaximOm/kdaUZ
         7UJC+5Tv7kRizfKXeeHHpmHEd93TJ6eZ6gfWT8S2/D1kMlGjzdMqyWjnOXuw9Xpn10IH
         ycR/OlndAs6mncEDaFz9KQKsU6H99HyqUPTHWMaNN27LVjyl9TdYLKI0YFokmURNDDMk
         YPBw==
X-Gm-Message-State: AO0yUKU0dkimDgDIQfUp8xJSAguoJySTQYzTP1sgrCgUQLd9zttK0C6/
        sOhJeRIqfNc6Rk1JZiISuQ+f10Qv7rq/yGQwdA==
X-Google-Smtp-Source: AK7set/EIDJEOoLPfCQrOfHA40erUROtaCAKW+YJw9riwDSqJtHig8reP7/n1hpcpiTk1c2LVzoimPxr4reSCiEgLQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:524:b0:a4e:4575:f3f0 with
 SMTP id y4-20020a056902052400b00a4e4575f3f0mr7886927ybs.11.1678240787650;
 Tue, 07 Mar 2023 17:59:47 -0800 (PST)
Date:   Wed, 08 Mar 2023 01:59:46 +0000
In-Reply-To: <20230307021809.GA2143916@chaop.bj.intel.com> (message from Chao
 Peng on Tue, 7 Mar 2023 10:18:09 +0800)
Mime-Version: 1.0
Message-ID: <diqz356guhnx.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     vannapurve@google.com, seanjc@google.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, diviness@google.com,
        maz@kernel.org, dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com, bgardon@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao Peng <chao.p.peng@linux.intel.com> writes:

>> [...]

>> Chao, I'll work on

>> + Running conversion tests for non-overlapping GPA ranges of
>>    same/different memslots from multiple vcpus
>> + Deleting memslots with restricted memfd while guests are being
>>    executed
>> + Installing multiple memslots with ranges within the same restricted
>>    mem files

>> this week.

> Thanks Ackerley. Looks good to me.

> BTW, for whom may have interest, below are the testcases I added:
> https://github.com/chao-p/linux/commit/24dd1257d5c93acb8c8cc6c76c51cf6869970f8a
> https://github.com/chao-p/linux/commit/39a872ef09d539ce0c953451152eb05276b87018
> https://github.com/chao-p/linux/commit/ddd2c92b268a2fdc6158f82a6169ad1a57f2a01d

> Chao

Hi Chao,

While I was working on the selftests I noticed that this could perhaps
be improved:

https://github.com/chao-p/linux/blob/ddd2c92b268a2fdc6158f82a6169ad1a57f2a01d/virt/kvm/kvm_main.c#L1035

We should use a temporary variable to hold the result of fget(fd).

As it is now, if the user provides any invalide fd, like -1,
slot->restrictedmem.file would be overwritten and lost.

We cannot update slot->restrictedmem.file until after the
file_is_restrictedmem() check.

For now there isn't a big problem because kvm_restrictedmem_bind() is
only called on a new struct kvm_memory_slot, but I think this should be
changed in case the function is used elsewhere in future.

Ackerley
