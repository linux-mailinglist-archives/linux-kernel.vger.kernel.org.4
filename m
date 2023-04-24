Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6016D8605
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDESb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDESbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:31:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DED268B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:31:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-501d3943f8eso770092a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1680719512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D09SiNz8EY5of0RZSstwD4wzGlOaSY6p10qkdeMqURE=;
        b=AMBAzG0QgqCb9iX9PLCffb23CmT4TJoNWb874LZlB3sAmSDRZUC0NWAWQXtO0OgVcB
         11liVShStMKFI8j9WcoUWP3fvgWBz8I8+uJU4Z7v6lSWIJ6TvWajA589bDt8NtnIH+71
         fJTQse113+euLE9CX1j98ByGAdEkK20MNX9dnEBv9HX/yynW2wgxb2Ab7lwIVE70l0IO
         aIqbAIrH3BrH4ltYrEymyS3A9mOdpxmjGLzGWcl0+DXnl/jcKfvTjcmUFKdm26bsdpAI
         R472xnO+IGBZegMc4dgdeVo3PNuczu8OYvRKyW3NiE+sUCgh0fFRTgU2dP1v1wBERoKg
         30rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680719512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D09SiNz8EY5of0RZSstwD4wzGlOaSY6p10qkdeMqURE=;
        b=yfaZJ52roPoguxgJl2E5mIiMpfBkksXHKA+uUb7wQBhyC3Dxxjiaffr7FW4Lh8B6Tq
         JvXL2TUOwAhxVm7r5W90wq5AxVp/sswTzw6wfjzwmdBne8GVOnbbz4oSqQ6M9VW99GsJ
         QFP/tAnhl3VH64wsITe1Zwp/4eViw8Wjusraw0T+Ux8P98hRhz0vqvaI8qRbYIpVoEBM
         XqQUHR+bD+74VuBBbiIiYxYm3gdeCbIR2nknmwriY10Lsyb1xRGbSU9tTluEUwqE7DAt
         jnXvaMaQiMOnOMWDQ7MF8J62rkI9vNKiMKtqKy54ViQRHXHbMnF+Au88Lgm/woE+9t9f
         JSfg==
X-Gm-Message-State: AAQBX9egsKxkL0pm6PoW/i8c+rXdukDnmw0DtmWK6Fi5AN/XroV8ffGQ
        AHDSEp6F6U25tb9Gi19Q45y9gA==
X-Google-Smtp-Source: AKy350Y87Q/T/8FTq6Q/YZJVQXOGhfScnau62UvUJMsxpNVZIXVucIvS9gXGm9YlhupQXzkP29T9tA==
X-Received: by 2002:aa7:d851:0:b0:4fb:999:e052 with SMTP id f17-20020aa7d851000000b004fb0999e052mr2633884eds.33.1680719512559;
        Wed, 05 Apr 2023 11:31:52 -0700 (PDT)
Received: from ?IPV6:2003:f6:af39:8900:5941:dee7:da1a:b514? (p200300f6af3989005941dee7da1ab514.dip0.t-ipconnect.de. [2003:f6:af39:8900:5941:dee7:da1a:b514])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b005023dc49bdasm7606189edd.83.2023.04.05.11.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 11:31:52 -0700 (PDT)
Message-ID: <58a9410a-62f2-5a35-2ce3-f5203912465e@grsecurity.net>
Date:   Wed, 5 Apr 2023 20:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] KVM: x86/mmu: Refresh CR0.WP prior to checking for
 emulated permission faults
Content-Language: en-US, de-DE
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405002608.418442-1-seanjc@google.com>
 <a1ed2308-b521-14c0-a118-19c1afffd1d6@grsecurity.net>
 <ZC2HfNLa7sLewJtl@google.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <ZC2HfNLa7sLewJtl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.04.23 16:36, Sean Christopherson wrote:
> On Wed, Apr 05, 2023, Mathias Krause wrote:
>> On 05.04.23 02:26, Sean Christopherson wrote:
>>> +void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
>>> +					struct kvm_mmu *mmu)
>>> +{
>>> +	const bool cr0_wp = kvm_is_cr0_bit_set(vcpu, X86_CR0_WP);
>>> +
>>> +	BUILD_BUG_ON((KVM_MMU_CR0_ROLE_BITS & KVM_POSSIBLE_CR0_GUEST_BITS) != X86_CR0_WP);
>>
>>> +	BUILD_BUG_ON((KVM_MMU_CR4_ROLE_BITS & KVM_POSSIBLE_CR4_GUEST_BITS));
>>
>> Just curious, this should assert that we don't run into similar issues
>> if we make more bits of CR4 guest owned?
> 
> Yes?  I'm not sure what you're asking.  BUILD_BUG_ON() is a just more flexible
> version of stiatic_assert(); it only requires that the inputs be compile-time
> constants, not purely "static>
> he above throws an error at compile-time if there is new overlap between the
> CR{0,4} MMU role bits and the possible guest-owned bits.  E.g. adding SMEP to the
> possible guest-owned CR4 bits yields:

Yes, I was just asking about the reasoning behind it as it, obviously,
isn't a problem with the current code. But I ran into it while doing
backports, so thanks for adding it :D

> 
> [...]
