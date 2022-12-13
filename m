Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3256064B2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiLMJrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiLMJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:47:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F7178B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:47:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v7so7850567wmn.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUffeOkZJV6CbBOjXRvBE9aKOOUHPUai9QNqwF2Rw6k=;
        b=s1JH0apqKbSMIxIiwVTiEGvWlt6voHGA0Qg93k6bu0bo94Xy2pc1rgrx+aKZpEtkx6
         tAkY+DS3eAY/MbbRYxforucS9NjS3Y/J+tyLt2y4zma1TERO/0grq5KMq0vq/JPyZFBz
         uuzCElIdsA0WjdkodayUEVOjRvLIQMBQqZyE+ugj5nJLcFiHRq0Adeoz1JxR/vw5valn
         M6ePXoLF+ntrgyqEb+FWCTpZ/Y72s2I7CfUH8aDCBnPG2ygVESeMtHM7BOVqZvMx+DrN
         +34OyPj6HJPDo1O1oBSY+duAkwoi2k2YHG0FzskbkMhvLtYA4PBVWcLfgYnkAWBL9chR
         D2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUffeOkZJV6CbBOjXRvBE9aKOOUHPUai9QNqwF2Rw6k=;
        b=bOu2UdxZfiW44lKSHUw3v8VOHWymbs6mJmlXJGDDfXGVCjNw7tYgghDbpQ8hU5mhzQ
         WfABKxh4Xs5aGqm2sEmzc36TVCqAStLB5azdDQTFv8xG9eABpEZrOZ3y4xJ+irrBMjug
         537phhYSkYWz2YFOR/gorDblxfqaLyJlXhLg6Pf3809sqSnZnqiTPfMdMfxX9Fi+K1AY
         FA/eP0gWnYmJpv3eqYGyR7JR9tJd+gMAmKqJN8y1M7DM7HU/Qci6a7MM8fM03xfdhXZJ
         ZdJr6AkQQySkN6pBe9GUvrwMP/IgxL45WLhBzpY7HcfDn+qU7rZMADgFYJAwDfxvqvzg
         VxuA==
X-Gm-Message-State: ANoB5pk5GQ9j14X6B/TRY787n+jdmFa2X3LwDMobyn/TyiBDXBXuKO+l
        8zPDuNE5oBtzDHkJxoTezg12IA==
X-Google-Smtp-Source: AA0mqf45B8663eyuUa7gYYZoZljx5xDAypBaIEMtrhbpuNigeolIoqaS3rVH+IjTq+i8TltLJF+66w==
X-Received: by 2002:a05:600c:a54:b0:3cf:a41d:844b with SMTP id c20-20020a05600c0a5400b003cfa41d844bmr15253803wmq.5.1670924845957;
        Tue, 13 Dec 2022 01:47:25 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003c6bd91caa5sm12602817wmb.17.2022.12.13.01.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 01:47:25 -0800 (PST)
Message-ID: <2505189d-c682-ed70-442b-798c258d3b68@linaro.org>
Date:   Tue, 13 Dec 2022 10:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 05/14] KVM: selftests: Fix a typo in x86-64's
 kvm_get_cpu_address_width()
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>
References: <20221213001653.3852042-1-seanjc@google.com>
 <20221213001653.3852042-6-seanjc@google.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221213001653.3852042-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 01:16, Sean Christopherson wrote:
> Fix a == vs. = typo in kvm_get_cpu_address_width() that results in
> @pa_bits being left unset if the CPU doesn't support enumerating its
> MAX_PHY_ADDR.  Flagged by clang's unusued-value warning.
> 
> lib/x86_64/processor.c:1034:51: warning: expression result unused [-Wunused-value]
>                  *pa_bits == kvm_cpu_has(X86_FEATURE_PAE) ? 36 : 32;
> 
> Fixes: 3bd396353d18 ("KVM: selftests: Add X86_FEATURE_PAE and use it calc "fallback" MAXPHYADDR")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index c4d368d56cfe..acfa1d01e7df 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1031,7 +1031,7 @@ bool is_amd_cpu(void)
>   void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>   {
>   	if (!kvm_cpu_has_p(X86_PROPERTY_MAX_PHY_ADDR)) {
> -		*pa_bits == kvm_cpu_has(X86_FEATURE_PAE) ? 36 : 32;
> +		*pa_bits = kvm_cpu_has(X86_FEATURE_PAE) ? 36 : 32;

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


