Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2586C23C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCTVfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjCTVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:35:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C47113D54
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:35:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t15so11795399wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679348089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oor1vzSTyizg8aBXX22RBj8zX1I0yC0LRLEIz7uLBsk=;
        b=v1E0SqeiGdgKMPAvqLAroPtn0RLHfkTe2djuIFU6Rzhgsj1efC/TgfS9TG+Bp+03Bz
         HbdFPW1Cetz6+2UuG8Ub+GPRq4cGfsfcbEdNtHnSb09hFnHJh/4nlpbtNuL7E2Xw0oD4
         j+GiojUQgXACseZaPs/DUHJyKeM+pKNx+VruuXik46VI4obD6VlWRYNonsEBr3EGKxKH
         lJel1KMH63f+jqGdFo+nGu34yaH1JHuYQ01H1OGhaFC+5H02pZ5EqSktuhu8FbPLBy1d
         SQcnhshhjNSlurSuEctw9wdoa9EViaX8cUsfpKy5o1On6GU6dQ4eZLmyer3sD667p4IQ
         Kz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679348089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oor1vzSTyizg8aBXX22RBj8zX1I0yC0LRLEIz7uLBsk=;
        b=YrCSQKLGZdN8uQ0doxPCvh7TPcMhw6FJaQqM1mLADgSyFsGZjvnOaxD98aRPlD0QYS
         tsSfh6njbSytdwTHZJA8ySYFeD6l6/ACrmJnWS3HakLcC3JxECiIkbogCr0Jo8Z6QvKz
         7HjQNWAqtxhYtgmmgt25E+IEOd2Bug3x8fBlUZazZfIm96znV0oY/ZJRMYPRn18kI/KB
         mpp82O0TCe9StSKX9vTm72GdY445afmfOyLgoc+WH3q9/rtJPLVnzOEVXFo1E8wGwap+
         eNkidTz0mTLjHjK5pGq5Bur26fYeO90nNp1lalWgxJywDHDaSrEwGC8MEurhbIn3ULvL
         YjCw==
X-Gm-Message-State: AO0yUKWfR/b4cTp1MFcmvMgNq3jA5kUNTwB4JkUxEBahtAPTxW2PpJEi
        t6RbqtPK2A8RSIE2li2YIMdrjw==
X-Google-Smtp-Source: AK7set+TZzZybYcteWhuUR3pyGrbfz//+0HA4ZdWmFB0SVDP6THOSdJjHXEjyKA/TIAti5hr01YJag==
X-Received: by 2002:adf:ef8c:0:b0:2cf:ef5d:4ee7 with SMTP id d12-20020adfef8c000000b002cfef5d4ee7mr510623wro.69.1679348089290;
        Mon, 20 Mar 2023 14:34:49 -0700 (PDT)
Received: from ?IPV6:2003:f6:af11:1000:ea7:9b12:7b30:c669? (p200300f6af1110000ea79b127b30c669.dip0.t-ipconnect.de. [2003:f6:af11:1000:ea7:9b12:7b30:c669])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b002c5a790e959sm9799630wri.19.2023.03.20.14.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 14:34:48 -0700 (PDT)
Message-ID: <7b428c85-5f20-a077-70b6-f361d2e7ffe7@grsecurity.net>
Date:   Mon, 20 Mar 2023 22:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/6] KVM: x86: Make use of kvm_read_cr*_bits() when
 testing bits
Content-Language: en-US, de-DE
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230201194604.11135-1-minipli@grsecurity.net>
 <20230201194604.11135-5-minipli@grsecurity.net> <ZBJEGfmv42MA6bKh@google.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <ZBJEGfmv42MA6bKh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.23 23:18, Sean Christopherson wrote:
> On Wed, Feb 01, 2023, Mathias Krause wrote:
>> Make use of the kvm_read_cr{0,4}_bits() helper functions when we only
>> want to know the state of certain bits instead of the whole register.
>>
>> This not only makes the intend cleaner, it also avoids a VMREAD in case
>> the tested bits aren't guest owned.
>>
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>> ---
>>  arch/x86/kvm/pmu.c     | 4 ++--
>>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index d939d3b84e6f..d9922277df67 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -439,9 +439,9 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>>  	if (!pmc)
>>  		return 1;
>>  
>> -	if (!(kvm_read_cr4(vcpu) & X86_CR4_PCE) &&
>> +	if (!(kvm_read_cr4_bits(vcpu, X86_CR4_PCE)) &&
> 
> Purely as an FYI, I proposed adding helpers to query single CR0/CR4 bits in a
> separate thread[*].  No need to do anything on your end, I'll plan on applying
> this patch first and will handle whatever conflicts arise.
> 
> [*] https://lore.kernel.org/all/ZAuRec2NkC3+4jvD@google.com

Unfortunately, not all users of kvm_read_cr*_bits() only want to read a
single bit. There are a very few that read bit masks -- but you're
probably fully aware of this.

Thanks,
Mathias
