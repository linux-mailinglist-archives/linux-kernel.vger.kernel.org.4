Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D127334DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbjFPPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345735AbjFPPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:32:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C312720
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:31:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f849a0e371so1185057e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1686929517; x=1689521517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZnuFE3O/PR9u8GmiBs6AD4GgdDBkrTpJv3wePBd8wA=;
        b=VSkQ5tJPI6E4tGxRLdR8gFnV55P8c2MLC/+onvswHPjdHgWldO+uWQNJC8nqhrCDi2
         yaNYfwVSXGRPiLZrUO88wL3eWPfDbn+G7qfOv0/zrbvlaKajpsblxmcowKwfnN9NAVWw
         y4qyJ4F4a8Xot4ZrHufrrQziknzKBVdCZ9MA7nS3NWxszA152DDApvPfiWraN0TH4QM9
         1y8MhIOd/c2dyTDPsf4CzUbdKXv3Uyu4AbPG+VHK1EiRdwNBeWw1ujXUDTFLN1OD8gHs
         UYjOyCNA5/oIy0O+eB+oUagAPxa6O0heDpEtpmnaxRgExRrNi4w6KC7WYc2+WKACbDjs
         TL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686929517; x=1689521517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZnuFE3O/PR9u8GmiBs6AD4GgdDBkrTpJv3wePBd8wA=;
        b=RByt0rlPbzSwDfgN9kwkbCOrYYi69aO9OBXbao7+DZkBahOoCUfqvyi4w1LUB9iHhr
         Ls7T3Hu+EVZ6nE3/W5feJlmmUM7ywZd+yCqWKcVHV/9s4jDLQnZaJcrR1ppOKWjMWGWq
         apPja3MX82p/TB9kqqCcAgeeSEW03YK0k2X+opaQ8ep23Ydj+eRvxWfWdu+bxyliUq5K
         pw9oHOCHEN0mpJfzN5wF5piHYXsKvPU9jen5kbCIWVspU4Xz2weCQOx58+cdR+9JH5qe
         Nc5oelAsieM5Ancypchv1+a7/So7TbspsLsJ78P/kTk9EtVXU7eHGxjCH2Sdq4nwpQXZ
         czbg==
X-Gm-Message-State: AC+VfDy+eiW7VjihZUZ2X+9b1cv5fSjq7uPiBeDHtcE8t/yiuUp60MxL
        /XMVs9j6NbSMdTqEwWwDIKWWYw==
X-Google-Smtp-Source: ACHHUZ6Iadh6HCSoqmaPiaDI3CRolWd8FmANxEdcYqK2LUarmjsm8rHuCfXY3dEJaKs3QTYDoCrVOg==
X-Received: by 2002:a19:9114:0:b0:4f3:96ac:6dd3 with SMTP id t20-20020a199114000000b004f396ac6dd3mr1497698lfd.15.1686929517447;
        Fri, 16 Jun 2023 08:31:57 -0700 (PDT)
Received: from [10.43.1.253] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id 7-20020ac24847000000b004f4cabba7desm3056281lfy.74.2023.06.16.08.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:31:56 -0700 (PDT)
Message-ID: <22438996-cea6-fcdc-530b-bf3f2477a81c@semihalf.com>
Date:   Fri, 16 Jun 2023 17:31:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
To:     Sean Christopherson <seanjc@google.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
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
 <001aa2ed-2f78-4361-451d-e31a4d4abaa0@semihalf.com>
 <ZIxqAXhy1tCVpzz7@google.com>
Content-Language: en-US
From:   Dmytro Maluka <dmy@semihalf.com>
In-Reply-To: <ZIxqAXhy1tCVpzz7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 15:56, Sean Christopherson wrote:
> On Fri, Jun 16, 2023, Dmytro Maluka wrote:
>> On 6/14/23 16:15, Sean Christopherson wrote:
>>> On Wed, Jun 14, 2023, Elena Reshetova wrote:
>>>>>> +This new type of adversary may be viewed as a more powerful type
>>>>>> +of external attacker, as it resides locally on the same physical machine
>>>>>> +-in contrast to a remote network attacker- and has control over the guest
>>>>>> +kernel communication with most of the HW::
>>>>>
>>>>> IIUC, this last statement doesn't hold true for the pKVM on x86 use case, which
>>>>> specifically aims to give a "guest" exclusive access to hardware resources.
>>>>
>>>> Does it hold for *all* HW resources? If yes, indeed this would make pKVM on
>>>> x86 considerably different.
>>>
>>> Heh, the original says "most", so it doesn't have to hold for all hardware resources,
>>> just a simple majority.
>>
>> Again, pedantic mode on, I find it difficult to agree with the wording
>> that the guest owns "most of" the HW resources it uses. It controls the
>> data communication with its hardware device, but other resources (e.g.
>> CPU time, interrupts, timers, PCI config space, ACPI) are owned by the
>> host and virtualized by it for the guest.
> 
> I wasn't saying that the guest owns most resources, I was saying that the *untrusted*
> host does *not* own most resources that are exposed to the guest.  My understanding
> is that everything in your list is owned by the trusted hypervisor in the pKVM model.

Heh, no. Most of these resources are owned by the untrusted host, that's
the point.

Basically for two reasons: 1. we want to keep the trusted hypervisor as
simple as possible. 2. we don't need availability guarantees.

The trusted hypervisor owns only: 2nd-stage MMU, IOMMU, VMCS (or its
counterparts on non-Intel), physical PCI config space (merely for
controlling a few critical registers like BARs and MSI address
registers), perhaps a few more things that don't come to my mind now.

The untrusted host schedules its guests on physical CPUs (i.e. the
host's L1 vCPUs are 1:1 mapped onto pCPUs), while the trusted hypervisor
has no scheduling, it only handles vmexits from the host and guests. The
untrusted host fully controls the physical interrupt controllers (I
think we realize that is not perfectly fine, but here we are), etc.
 
> What I was pointing out is related to the above discussion about the guest needing
> access to hardware that is effectively owned by the untrusted host, e.g. network
> access.
