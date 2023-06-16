Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151D373311F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbjFPMY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244204AbjFPMY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:24:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735130DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:24:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so836019e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1686918263; x=1689510263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHHJMVvxjSG31pi51Gp1mclD2e/YsepxsxxTfRtM4/c=;
        b=ivk7Nc1OroL2Qci6OBq3Aw2cw3ZttBg0XLtayXM7An0TEOOlI3d4owkvW3mNXwkkPx
         D68XfDyeKGe1l6kzwZiqiRx3nKZ532HzE4dBISy+J6Lqn/BbPmjp+CMyH9KZQQj4m61B
         zvAMCYjNaQ0MWTpwtEl82xDTe/PPFtHSL83MX3fLLX3vW90tnyAGCJTdQ6OtC1sEeNcK
         VjP3d7zT5HBaQ4PKUOXkJqGzh+U9OIEMaGO03vcYNR2KlO0iDaQCnl4ESWCgYCBb1fL8
         lMFZkPlAfrFy+867JzEBTJIKTAu9iDrLVAyNNwDi+pKF1saEQ5UZ3z16RFVURCxebh8N
         hQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686918263; x=1689510263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHHJMVvxjSG31pi51Gp1mclD2e/YsepxsxxTfRtM4/c=;
        b=h04cPnFZMBsM3HZD7yhyBCTFyRe4Y++Sse8EiOXzpCjy1e9Okf4XuwbzC96QFzmeT+
         gvBHA5cWiqXyW8XUJ2++H8umw+O6WU+cXSDNBkxwEYH45HhoxWxTGE+FmYjTTtv98MGe
         7NEoA41HGH9yne9sC21n9Lhs19SnkhKWAe8V45aGlepZGt7NgmtagDOh3CYjnVTY/1hZ
         xJ4ZxhGGcydg9HKdFEGGGDDf6DxQIdchcWMu9nTtmecg1zR70+vsRrOdSaONtYG6Qu8J
         Bfi8SXF/R4L0ahNzTEgNCazWFTjdDwfF7bEehoCMBglZRTsCDAZOZoE9KR5xHyrojD8U
         mVXw==
X-Gm-Message-State: AC+VfDz0AMldcl7Ns+i09QkiCu8Fy5vChvmG5UrfJU0U/uU2JO6TK3hs
        svu+9Yj0wssBizvpky2dgh7k/A==
X-Google-Smtp-Source: ACHHUZ6AzPXkjReYZoZNAHq+wtr6OCDbf9GVO9EGhvCijYda0xoVofjwFvUuRrFO9TVV5esgh89UxQ==
X-Received: by 2002:a19:6601:0:b0:4f3:8196:80cb with SMTP id a1-20020a196601000000b004f3819680cbmr1253347lfc.41.1686918262709;
        Fri, 16 Jun 2023 05:24:22 -0700 (PDT)
Received: from [10.43.1.253] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id j20-20020a19f514000000b004eae73a0530sm2994177lfb.39.2023.06.16.05.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 05:24:22 -0700 (PDT)
Message-ID: <2cfa3122-6b54-aab5-8a61-41c08853286b@semihalf.com>
Date:   Fri, 16 Jun 2023 14:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
To:     Sean Christopherson <seanjc@google.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com,
        gregkh@linuxfoundation.org, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>, android-kvm@google.com,
        Dmitry Torokhov <dtor@google.com>,
        Allen Webb <allenwebb@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Patryk Duda <pdk@semihalf.com>
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com>
Content-Language: en-US
From:   Dmytro Maluka <dmy@semihalf.com>
In-Reply-To: <ZIihRqZljMaMRGcK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 19:03, Sean Christopherson wrote:
> On Mon, Jun 12, 2023, Carlos Bilbao wrote:
>> +well as CoCo technology specific hypercalls, if present. Additionally, the
>> +host in a CoCo system typically controls the process of creating a CoCo
>> +guest: it has a method to load into a guest the firmware and bootloader
>> +images, the kernel image together with the kernel command line. All of this
>> +data should also be considered untrusted until its integrity and
>> +authenticity is established via attestation.
> 
> Attestation is SNP and TDX specific.  AIUI, none of SEV, SEV-ES, or pKVM (which
> doesn't even really exist on x86 yet), have attestation of their own, e.g. the
> proposed pKVM support would rely on Secure Boot of the original "full" host kernel.

Seems to be a bit of misunderstanding here. Secure Boot verifies the
host kernel, which is indeed also important, since the pKVM hypervisor
is a part of the host kernel image. But when it comes to verifying the
guests, it's a different story: a protected pKVM guest is started by the
(untrusted) host at an arbitrary moment in time, not before the early
kernel deprivileging when the host is still considered trusted.
(Moreover, in practice the guest is started by a userspace VMM, i.e. not
exactly the most trusted part of the host stack.) So the host can
maliciously or mistakenly load a wrong guest image for running as a
protected guest, so we do need attestation for protected guests.

This attestation is not implemented in pKVM on x86 yet (you are right
that pKVM on x86 is little more than a proposal at this point). But in
pKVM on ARM it is afaik already working, it is software based (ensured
by pKVM hypervisor + a tiny generic guest bootloader which verifies the
guest image before jumping to the guest) and architecture-independent,
so it should be possible to adopt it for x86 as is.

Furthermore, since for pKVM on x86 use cases we also need assigning
physical secure hardware devices to the protected guest, we need
attestation not just for the guest image itself but also for the secure
devices assigned to it by the host.
