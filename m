Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4876177A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKCHZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKCHZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:25:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257A103B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:25:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l14so1345075wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDXCjZngZdqFd0T8UNtaJgIVNUXtxy5kh+IvZcYgc3o=;
        b=KBb4CRffvbqT8vCYmIjrzMCnn1vGDH3hTE8kztkuirWCWDx5vmnnhlY12+76G8HB+D
         zNMscqf1aWjU1jn9Q/+2qznV1nyjnfJgJejU0eBLDst+wEJ5JP32F9KCikAYwccYRz/4
         CEoS+rbiQf+EK76mQ+O07yD4/kZHVOkQQ4sHVGI67dP7iLfCkYZsRk0ZykZuinHxGqnw
         VBepbg5NHi4yk+ONf1CC+WSt8MwwyKu83Az0OvU8HlQtsrRUhgNXczuxh+p9v62b1ye5
         0/LNF3gKJJGGBQ4GVZwf3fHBWg9tW8pDxWcOYgxGkG6PYQEim2NR9gsO5CmPy3fAtv6n
         sc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDXCjZngZdqFd0T8UNtaJgIVNUXtxy5kh+IvZcYgc3o=;
        b=RbOXtWQc+hrKfB1/VfeFxirtk/lmrdcOOZHyP7NthD5B66mrJykLa8nTtlR5ZFs7FK
         MWfs06mDMsuyQGxtbfuGy2ow1a0MTDUGWct3620z7iTSBGziT1mXDfcACYIy/wIoXKor
         Eb1gS8VCRoeePjPNGGp+CvWubh4P4TyzD/0sJh49r/RqL2OkjFsosl4go0xrBI7IG7ii
         zjuUtZhLv24CqJxP7jVQRbUagtWbZDmRGaftX5fWH5GwUC0kdH2GVgz11sLaJLFgnA9J
         f4+anxKVjqx/w8Oilo9jCKueUzcUTO5KV9veCj1On7LHWWX5xPbnoUQPxT74Zqg0Kld+
         /U+g==
X-Gm-Message-State: ACrzQf2slcVh++pHDAQUQKQaKbjw38n3r4CToZ3719+G1zMwpuaCqC09
        YTOn1UTjWSAMBnTfBe6yBVYyoA==
X-Google-Smtp-Source: AMsMyM74HX/NoI0zgj7ni+fuzXHxAnM/kiJpMAz2sP8bktGhOQR4suw74I3bBM5aFs9fFpQjlVL3zA==
X-Received: by 2002:a5d:50ca:0:b0:236:776c:3075 with SMTP id f10-20020a5d50ca000000b00236776c3075mr17956880wrt.656.1667460341889;
        Thu, 03 Nov 2022 00:25:41 -0700 (PDT)
Received: from [192.168.11.175] (216.red-88-29-181.dynamicip.rima-tde.net. [88.29.181.216])
        by smtp.gmail.com with ESMTPSA id i10-20020a1c540a000000b003a3442f1229sm4408723wmb.29.2022.11.03.00.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 00:25:40 -0700 (PDT)
Message-ID: <dd59d579-4a4e-6db2-eac4-6c5c3ab71fd3@linaro.org>
Date:   Thu, 3 Nov 2022 08:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 17/44] KVM: arm64: Do arm/arch initialiation without
 bouncing through kvm_init()
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-18-seanjc@google.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221102231911.3107438-18-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On 3/11/22 00:18, Sean Christopherson wrote:
> Move arm/arch specific initialization directly in arm's module_init(),
> now called kvm_arm_init(), instead of bouncing through kvm_init() to
> reach kvm_arch_init().  Invoking kvm_arch_init() is the very first action
> performed by kvm_init(), i.e. this is a glorified nop.
> 
> Making kvm_arch_init() a nop will allow dropping it entirely once all
> other architectures follow suit.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/arm64/kvm/arm.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)

>   /* NOP: Compiling as a module not supported */
>   void kvm_arch_exit(void)
>   {
> -	kvm_unregister_perf_callbacks();

Doesn't this belong to the previous patch?

> +
>   }

