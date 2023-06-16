Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB88173315B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbjFPMgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjFPMgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:36:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B3AC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:36:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f764e9295dso844800e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1686919001; x=1689511001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGOfdzs+A9lP2dR/JNkIwPkC68/3Vu2CqB4daNG5pwA=;
        b=RSONdy/aWWf3Ur7h0nHkjZlPyEQ5dtlEtQbJzqtE0kE0zoZk3l/KxiCh0wAVCV2FMt
         tUQmzFivhfbl7XpeU6YtyVpAc3xfsOEGC7jx3T0PwMUfZogyLy23EViZxL1QoIdUH+RF
         VjVuK4nssJVah45tKqBZCEGUrCNZBwp9cvxXHQ0Qz1zTUr6yyG3pnufMSGwOw3MH6PGo
         ktaa+mhX8G1JRhSdpXl/EMZWRT8D6q11B/ARHNxJC7gtgAuqKIJSIF3n3Y3sDm0VsMLW
         4+aKB8LZeIfJQv+HkxLxa9/6/WEQpFxSa43gwGsT716d+EjoXtFg/tQX210XqR8nkr6j
         TSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686919001; x=1689511001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGOfdzs+A9lP2dR/JNkIwPkC68/3Vu2CqB4daNG5pwA=;
        b=KMAqc5ZlnQ4a5NQEGr5u9+H8JZwBTqk3b55at/KbtZXuLxa7Yye0gFi3RdlhC6Q/4w
         XvYvIBT9BGH25y+544b2K3OnkrySxqvPDNGkPFLDFZYFvrQGo3HENnCP5rUNQ7Z0RWoE
         oFXjD4oM753xMnTVIZBST9ysn8hy5BbU881io+van6B3KqwdwTsKx4jCvyvSLgmc9g5k
         jH6ae2AQf33w/mFsYCMnA560yZ7AiMfbXA0FuzcgdtCCSaCz+rKiVqAywqwsKW53Xs+x
         lYg88ZO1I56Cp3mPl6JbGTzUxBsaxAbuLJ8m5D0yrrYza+IBKFVOM3dx+IyRGBjm8YBx
         R5Qw==
X-Gm-Message-State: AC+VfDzVKOIsQ2Zz4tIMrjMOEc09NYe5F9R1PojXpylbRcp4djo1iS+u
        EijiM5b61jntwc3AhRQYzB28zQ==
X-Google-Smtp-Source: ACHHUZ4QjwKxl7vt9iFPySkHd1yALSaM/Z4FHfEyj3OrRTFl17s49Q7/27TY/h26lz6RYBEKa53/6w==
X-Received: by 2002:ac2:4647:0:b0:4f0:af5:5560 with SMTP id s7-20020ac24647000000b004f00af55560mr1090291lfo.19.1686919000977;
        Fri, 16 Jun 2023 05:36:40 -0700 (PDT)
Received: from [10.43.1.253] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id r17-20020ac25a51000000b004f7618c67a7sm1238978lfn.76.2023.06.16.05.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 05:36:40 -0700 (PDT)
Message-ID: <001aa2ed-2f78-4361-451d-e31a4d4abaa0@semihalf.com>
Date:   Fri, 16 Jun 2023 14:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Jason CJ Chen <jason.cj.chen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Larry Dewey <larry.dewey@amd.com>, android-kvm@google.com,
        Dmitry Torokhov <dtor@google.com>,
        Allen Webb <allenwebb@google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Patryk Duda <pdk@semihalf.com>
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com>
 <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
 <ZInLlkXsgnej9ZpT@google.com>
From:   Dmytro Maluka <dmy@semihalf.com>
In-Reply-To: <ZInLlkXsgnej9ZpT@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 16:15, Sean Christopherson wrote:
> On Wed, Jun 14, 2023, Elena Reshetova wrote:
>>>> +The specific details of the CoCo security manager vastly diverge between
>>>> +technologies. For example, in some cases, it will be implemented in HW
>>>> +while in others it may be pure SW. In some cases, such as for the
>>>> +`Protected kernel-based virtual machine (pKVM) <https://github.com/intel-
>>> staging/pKVM-IA>`,
>>>> +the CoCo security manager is a small, isolated and highly privileged
>>>> +(compared to the rest of SW running on the host) part of a traditional
>>>> +VMM.
>>>
>>> I say that "virtualized environments" isn't a good description because
>>> while pKVM does utilize hardware virtualization, my understanding is that
>>> the primary use cases for pKVM don't have the same threat model as SNP/TDX,
>>> e.g. IIUC many (most?  all?) pKVM guests don't require network access.
>>
>> Not having a network access requirement doesn’t implicitly invalidate the 
>> separation guarantees between the host and guest, it just makes it easier
>> since you have one interface less between the host and guest.
> 
> My point is that if the protected guest doesn't need any I/O beyond the hardware
> device that it accesses, then the threat model is different because many of the
> new/novel attack surfaces that come with the TDX/SNP threat model don't exist.
> E.g. the hardening that people want to do for VirtIO drivers may not be at all
> relevant to pKVM.

Strictly speaking, the protected pKVM guest does need some I/O beyond
that, e.g. for some (limited and specialized) communication between the
host and the guest, e.g. vsock-based. For example, in the fingerprint
use case, the guest receives requests from the host to capture
fingerprint data from the sensor, sends encrypted fingerprint templates
to the host, and so on.

Additionally, speaking of the hardware device, the guest does not
entirely own it. It has direct exclusive access to the data
communication with the device (ensured by its exclusive access to MMIO
and DMA buffers), but e.g. the device interrupts are forwarded to the
guest by the host, and the PCI config space is virtualized by the host.

But I think I get what you mean: there is no data transfer whereby the
host is not an endpoint but an intermediary between the guest and some
device. In simple words, things like virtio-net or virtio-blk are out of
scope. Yes, I think that's correct for pKVM-on-x86 use cases (and I
suppose it is correct for pKVM-on-ARM use cases as well). I guess it
means that "guest data attacks" may not be relevant to pKVM, and perhaps
this makes its threat model substantially different from cloud use
cases.

However, other kinds of threats described in the doc do seem to be
relevant to pKVM. "Malformed/malicious runtime input" is relevant since
communication channels between the host and the guest do exist, the host
may arbitrarily inject interrupts into the guest, etc. "Guest malicious
configuration" is relevant too, and guest attestation is required, as I
wrote in [1].

Cc'ing android-kvm and some ChromeOS folks to correct me if needed.

> And I don't see any need to formally document pKVM's threat model right *now*.
> pKVM on x86 is little more than a proposal at this point, and while I would love
> to see documentation for pKVM on ARM's threat model, that obviously doesn't belong
> in a doc that's x86 specific.

Agree, and I don't think it makes sense to mention pKVM-on-x86 without
mentioning pKVM-on-ARM, as if pKVM-on-x86 had more in common with cloud
use cases than with pKVM-on-ARM, while quite the opposite is true.

It seems there is no reason why pKVM-on-x86 threat model should be
different from pKVM-on-ARM. The use cases on ARM (for Android) and on
x86 (for ChromeOS) are somewhat different at this moment (in that in
ChromeOS use cases the protected guest's sensitive data includes also
data coming directly from a physical device), but IIUC they are
converging now, i.e. Android is getting interested in use cases with
physical devices too.

>>>> +potentially misbehaving host (which can also include some part of a
>>>> +traditional VMM or all of it), which is typically placed outside of the
>>>> +CoCo VM TCB due to its large SW attack surface. It is important to note
>>>> +that this doesn’t imply that the host or VMM are intentionally
>>>> +malicious, but that there exists a security value in having a small CoCo
>>>> +VM TCB. This new type of adversary may be viewed as a more powerful type
>>>> +of external attacker, as it resides locally on the same physical machine
>>>> +-in contrast to a remote network attacker- and has control over the guest
>>>> +kernel communication with most of the HW::
>>>
>>> IIUC, this last statement doesn't hold true for the pKVM on x86 use case, which
>>> specifically aims to give a "guest" exclusive access to hardware resources.
>>
>> Does it hold for *all* HW resources? If yes, indeed this would make pKVM on
>> x86 considerably different.
> 
> Heh, the original says "most", so it doesn't have to hold for all hardware resources,
> just a simple majority.

Again, pedantic mode on, I find it difficult to agree with the wording
that the guest owns "most of" the HW resources it uses. It controls the
data communication with its hardware device, but other resources (e.g.
CPU time, interrupts, timers, PCI config space, ACPI) are owned by the
host and virtualized by it for the guest.

[1] https://lore.kernel.org/all/2cfa3122-6b54-aab5-8a61-41c08853286b@semihalf.com/
