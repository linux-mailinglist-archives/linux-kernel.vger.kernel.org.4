Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642037334FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345859AbjFPPhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344514AbjFPPg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:36:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559713C02
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:36:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f762b3227dso1170934e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1686929786; x=1689521786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWmqJjl65njYhhrKH479HBuSmjABYzwyR8l6qq2qxTs=;
        b=eYDuI9hWE+Zy6nAGOdLeTQndLE3C2pTi+xTHo1alGhwknHcUiWzT2VFR6n2x1LwcQw
         x0J44rDbEJV+DhSmEjnMUC5q4Z+JXeWN7AP4fuQObQ8Zq1OYJBzpD0+FvUkM5oTlCOxc
         aLnNSr0PYDWEuN4x9+gmUZPCV+doLONNPUIwRO78ROR7ig/6i2MINEaQDHkx2OQJ9vfF
         xP+J3bJZnpoHVnr/M/Kh4WJgEPzaMIVqzRr0/W/leTebVthObDRU6NM/bU1xdLnJcQ/3
         v9U7h5TYdwOQX2H6HEThzvumPzKWcpY7m7VUnTsMix6UWn3AiSweAFce6tXfinufMjiD
         CqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686929786; x=1689521786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWmqJjl65njYhhrKH479HBuSmjABYzwyR8l6qq2qxTs=;
        b=E7iIZxGJuMcdhKIgOoNj11NwfYgiNWC/NTYIW6IxBUXxIcNddPj4+udPyEtsoO4klc
         FihghlSwMEoUdS4Ko0oA01vhB1ifmwmTtjbhG387u+0zhusMQvGcyjjIR8ZgtQlI8WKI
         mv5G0rrCb0A4SzqieCwLWUpxLbVTx8z5Wp7EYBsW4vibnko+axGNfkvudMxMDYsV+Jsp
         OvWW4QY0K09eyUGQTE6gc4z0ZbiTtkbYVqtrcrP5pWivZ2vhJ5Klc39wzfN/+3aLB8+J
         0JMG3DykFwbbJIADkgOYWHo4ZamYdb45ymLfM1sPg+c6dvatkzDtJMDTNS7B7DneTP63
         NfZw==
X-Gm-Message-State: AC+VfDzc58jmaLJqXBrxxcEzQ2rmbPCWmGrqV3Jo0I2C7DY2i3oH3DJi
        IJVBuiBNRTmpoXmqPoGGpVWV2w==
X-Google-Smtp-Source: ACHHUZ7XebOyQPDBNMEP1xZFXKLnei899WfMU9xpbXZG7W6zeUkueDQyMO999V35Z9ML+8Vkx9mr6g==
X-Received: by 2002:ac2:4c4c:0:b0:4f6:3ef3:13e8 with SMTP id o12-20020ac24c4c000000b004f63ef313e8mr2533516lfk.0.1686929786188;
        Fri, 16 Jun 2023 08:36:26 -0700 (PDT)
Received: from [10.43.1.253] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id u8-20020a2e91c8000000b002a8ec99e0e0sm3717693ljg.70.2023.06.16.08.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:36:25 -0700 (PDT)
Message-ID: <ae75c890-4389-6aac-8c3d-bc9fd1df1f6b@semihalf.com>
Date:   Fri, 16 Jun 2023 17:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, kraxel@redhat.com, dovmurik@linux.ibm.com,
        elena.reshetova@intel.com, dave.hansen@linux.intel.com,
        Dhaval.Giani@amd.com, michael.day@amd.com,
        pavankumar.paluri@amd.com, David.Kaplan@amd.com,
        Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
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
 <2cfa3122-6b54-aab5-8a61-41c08853286b@semihalf.com>
 <ZIxvl4sMH6N8TrAL@google.com>
From:   Dmytro Maluka <dmy@semihalf.com>
In-Reply-To: <ZIxvl4sMH6N8TrAL@google.com>
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

On 6/16/23 16:20, Sean Christopherson wrote:
> On Fri, Jun 16, 2023, Dmytro Maluka wrote:
>> On 6/13/23 19:03, Sean Christopherson wrote:
>>> On Mon, Jun 12, 2023, Carlos Bilbao wrote:
>>>> +well as CoCo technology specific hypercalls, if present. Additionally, the
>>>> +host in a CoCo system typically controls the process of creating a CoCo
>>>> +guest: it has a method to load into a guest the firmware and bootloader
>>>> +images, the kernel image together with the kernel command line. All of this
>>>> +data should also be considered untrusted until its integrity and
>>>> +authenticity is established via attestation.
>>>
>>> Attestation is SNP and TDX specific.  AIUI, none of SEV, SEV-ES, or pKVM (which
>>> doesn't even really exist on x86 yet), have attestation of their own, e.g. the
>>> proposed pKVM support would rely on Secure Boot of the original "full" host kernel.
>>
>> Seems to be a bit of misunderstanding here. Secure Boot verifies the
>> host kernel, which is indeed also important, since the pKVM hypervisor
>> is a part of the host kernel image. But when it comes to verifying the
>> guests, it's a different story: a protected pKVM guest is started by the
>> (untrusted) host at an arbitrary moment in time, not before the early
>> kernel deprivileging when the host is still considered trusted.
>> (Moreover, in practice the guest is started by a userspace VMM, i.e. not
>> exactly the most trusted part of the host stack.) So the host can
>> maliciously or mistakenly load a wrong guest image for running as a
>> protected guest, so we do need attestation for protected guests.
>>
>> This attestation is not implemented in pKVM on x86 yet (you are right
>> that pKVM on x86 is little more than a proposal at this point). But in
>> pKVM on ARM it is afaik already working, it is software based (ensured
>> by pKVM hypervisor + a tiny generic guest bootloader which verifies the
>> guest image before jumping to the guest) and architecture-independent,
>> so it should be possible to adopt it for x86 as is.
> 
> Sorry, instead of "Attestation is SNP and TDX specific", I should have said, "The
> form of attestation described here is SNP and TDX specific".
> 
> pKVM's "attestation", effectively has its root of trust in the pKVM hypervisor,
> which is in turn attested via Secure Boot.  I.e. the guest payload is verified
> *before* it is launched.

Got it, fair point. Yep, I think this understanding is fully correct.
 
> That is different from SNP and TDX where guest code and data is controlled by the
> *untrusted* host.  The initial payload is measured by trusted firmware, but it is
> not verified, and so that measurement must be attested after the guest boots,
> before any sensitive data is provisioned to the guest.
> 
> Specifically, with "untrusted" inserted by me for clarification, my understanding
> is that this doesn't hold true for pKVM when splitting hairs:
> 
>   Additionally, the **untrusted** host in a CoCo system typically controls the
>   process of creating a CoCo guest: it has a method to load into a guest the
>   firmware and bootloader images, the kernel image together with the kernel
>   command line. All of this data should also be considered untrusted until its
>   integrity and authenticity is established via attestation.
> 
> because the guest firmware comes from a trusted entity, not the untrusted host.
