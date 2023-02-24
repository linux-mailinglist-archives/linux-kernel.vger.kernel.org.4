Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4EC6A1CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjBXNVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXNVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:21:05 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFAC66970;
        Fri, 24 Feb 2023 05:21:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C8BE55C00FD;
        Fri, 24 Feb 2023 08:20:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 24 Feb 2023 08:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677244857; x=1677331257; bh=Xle0yeUGBO
        ksma2Gc9p3BVXHO1tPXh7Uos0haf9MEdw=; b=CSaI77jmGYFEpkHo8SbSMJFSNt
        s+7t+i35rlx+02Rkc5GAegdPGWQwqYVeBJpwrcevDxWbkkFilW4xy+gcUGK/YhKt
        W3Ir7ftEGg6agi3OWEjE439seloBmVLd0aa0RdMdoZhGTxrvS7fen4k6BRHmwTXu
        MEmO1qInbkqbvbC81tUMIG05+VQQ6lsiuxvkQsZOey+917S/b6e7fxDL4wSD7ZNE
        3X6w2UZa8k/kpE/M5P0UtPwg8dsJl144hrrCX/4vIqsE2Reez1vELeNPXCt+BqSk
        1Ve7MAgrcfDNDWB7QgPkMwjwbTvPYqtIAcGUJbug5lQek62VSMxT6+0IV1yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677244857; x=1677331257; bh=Xle0yeUGBOksma2Gc9p3BVXHO1tP
        Xh7Uos0haf9MEdw=; b=mkUCCb+7KZ0i6c+OmFU3nSQZO0DzLhBKzaVQdyl5hj7E
        B6La8P7s76VzF19FLer7kfJcr4Z3QO8ycIY8IVCzXqmp2o6+CYcjJbVfmNi/9uwX
        XpvKmbtloNnJ6Y7cMLaq8VXRSPgiN4OBNMLJmuGkTXXdgJL1Tp5h5KsD//Wd9GzZ
        1FcwsLxE/53TAJHnzFB1lmPrQG7i/LpXS+CdgRuwWxLFR/0SHcx+Y9gIaH3K7dzs
        zOvWrGuT9w+pGZ9Rs3aPZN/oeA94Y6zQdAXbVd9aL4ZWVcBDKQMEZpMjEq5gfQDL
        IUuyD4BbKtiS3S20aPC2bc58cv/DPoQAXMA/HDeeWg==
X-ME-Sender: <xms:ubn4YwjAurfwTsVL7ndr1bAB6gidcqZijE86FhNUmGeJniTuL60i5g>
    <xme:ubn4Y5APYULTM1iq2cJDTTfy32rZ2TM3D0wYrrWDNFyU_ud0E5-DUPI77_UkBMJAv
    dD-EnG9CvOJl_DlEIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekfedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ubn4Y4FYb6e9VA8-bXVQxC6VBZOnLCKl1hVxEIMQOdpJjxtA7yBbeA>
    <xmx:ubn4YxQBvA1VhTF9vQTgsEScgcMpnAep5-eP9iB02UhbhiT6MX6GoA>
    <xmx:ubn4Y9wxuFRfRM0GGGVjpUYIeOPPEHV_nMYNt9wR3u0QikPh3fwRnQ>
    <xmx:ubn4YyxFUZ_-OwngXtf0cXoRFAOD81hhN_bdOYgOooL8MiEwQxFZRw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5D0F7B60086; Fri, 24 Feb 2023 08:20:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <15aa881f-5cf1-446e-a71e-f62d24e87500@app.fastmail.com>
In-Reply-To: <a50fa44d-fbc3-9ce2-175b-85c8cd7a9f7f@linaro.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212356.3313181-1-quic_eberman@quicinc.com>
 <dbcfa4e9-a1ad-0f24-77bf-05934ca26bb2@linaro.org>
 <05c4aab8-2d26-b944-adb6-624d67e4a11d@quicinc.com>
 <52d944b1-3ea6-26b7-766a-2fed05dccf3a@linaro.org>
 <c5ff1523-7a62-3d3f-6fa9-792ce4d222e8@quicinc.com>
 <a50fa44d-fbc3-9ce2-175b-85c8cd7a9f7f@linaro.org>
Date:   Fri, 24 Feb 2023 14:20:40 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        "Alex Elder" <elder@linaro.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Prakruthi Deepak Heragu" <quic_pheragu@quicinc.com>
Cc:     "Murali Nalajala" <quic_mnalajal@quicinc.com>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 10/26] gunyah: vm_mgr: Introduce basic VM Manager
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023, at 11:29, Srinivas Kandagatla wrote:
> On 23/02/2023 22:40, Elliot Berman wrote:

>>>> Does this means adding #define GH_VM_DEFAULT_ARG 0 ? I am not sure 
>>>> yet what arguments to add here.
>>>>
>>>> The ABI can add new "long" values to GH_CREATE_VM and that wouldn't 
>>>
>>> Sorry, that is exactly what we want to avoid, we can not change the 
>>> UAPI its going to break the userspace.
>>>
>>>> break compatibility with old kernels; old kernels reject it as -EINVAL.
>>>
>>> If you have userspace built with older kernel headers then that will 
>>> break. Am not sure about old-kernels.
>>>
>>> What exactly is the argument that you want to add to GH_CREATE_VM?
>>>
>>> If you want to keep GH_CREATE_VM with no arguments that is fine but 
>>> remove the conflicting comments in the code and document so that its 
>>> not misleading readers/reviewers that the UAPI is going to be modified 
>>> in near future.
>>>
>>>
>> 
>> The convention followed here comes from KVM_CREATE_VM. Is this ioctl 
>> considered bad example?
>> 
>
> It is recommended to only use _IO for commands without arguments, and 
> use pointers for passing data. Even though _IO can indicate either 
> commands with no argument or passing an integer value instead of a 
> pointer. Am really not sure how this works in compat case.
>
> Am sure there are tricks that can be done with just using _IO() macro 
> (ex vfio), but this does not mean that we should not use _IOW to be more 
> explicit on the type and size of argument that we are expecting.
>
> On the other hand If its really not possible to change this IOCTL to 
> _IOW and argument that you are referring would be with in integer range, 
> then what you have with _IO macro should work.

Passing an 'unsigned long' value instead of a pointer is fine for compat
mode, as a 32-bit compat_ulong_t always fits inside of the 64-bit
unsigned long. The downside is that portable code cannot have a
single ioctl handler function that takes both commands with pointers
and other commands with integer arguments, as some architectures
(i.e. s390, possibly arm64+morello in the future) need to mangle
pointer arguments using compat_ptr() but must not do that on integer
arguments.

     Arnd
