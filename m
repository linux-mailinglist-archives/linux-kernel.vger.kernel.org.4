Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEB2617A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKCJjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:39:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1F10B5;
        Thu,  3 Nov 2022 02:39:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 507F15C01E2;
        Thu,  3 Nov 2022 05:39:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 03 Nov 2022 05:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667468380; x=1667554780; bh=pq/dGHH7V9
        vQT6il3oQy+WRKjBkAdF1iwzEfdpBBAcM=; b=h82CMvLjI4pEqGK5Z6rVCRoZv7
        7pTlIaSBYqIjWxZcUYFbuy/gcy++JmAv2r//H+GrR/WODosjTa7ncunOlqFP7Wk4
        F6K1HsiHvMCG642I52eDomwVEipur5kW2pnUy8N/TCaw3DuNznhO6sMjm0ptnVrh
        43VvSyaxdlFzSuuc5tduOaOKTeIoZF8tGALTVMM/JkCRp4PzowPbECTkm61Sv+Jh
        nVdNN3d1S2Cu2+asamQT5FW/wHLG42t5vtelBX3VibkNWYYUR4jnfGjKu5SyKjWu
        NmZVjAZPO1hNJ5vrAXKufLHSnTrne3qv5EnIbsJqkP1DIUEiojM1fNkPifqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667468380; x=1667554780; bh=pq/dGHH7V9vQT6il3oQy+WRKjBkA
        dF1iwzEfdpBBAcM=; b=i3hyaQtYrvJeFd2m2ROzmrJaw9BZCshfWCyJni/Ta6PV
        L4BeHtGKU9JlDUvhDYeLCjF2gPsEB3nWEEmVptJt14efkDCLtWlP+vg47IjycGjo
        Bj7oJjB7A5KMKOGSxFTATfXAFrnOFLw3/bjjg0EpJlzS/7AaugtUR3QWokxUepbI
        TrCns3kpX6Hl+oXUkOHWeFWeuuvWD1MAaWXo9kTaRwpsmoqHx5TJdgdsMXl1iepq
        F5dST8hYuIuQcA/2LuYXOAMc8LmCUSW7BU2A6LgZ2MDwwsFxO57EHO5XQW9UCdOf
        2mAlZiy/aSqS+s7OlUg/7tJp6npfqXTvtgxatHT9hw==
X-ME-Sender: <xms:XIxjY4ooMqCM_Uq-CY8kkAWyGJrgMg1RRICbXa6Mgeen5EVGrhQBpg>
    <xme:XIxjY-pa9ZhzWp4Pz3td-4SWGPVUuFD9u21ZcBl_m1mHsaS73wb3yXlrjdl5MQrbp
    YbV3DBua0QHZWalmrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XIxjY9NJPkNLNumhOinsc7eegHv3sJ2jDeoL5CypcX9kbCSfedwZVg>
    <xmx:XIxjY_5sQOVcPRqD5OR1DslPYclFMom0GWqE1VWYtAO94PNPpSRT6w>
    <xmx:XIxjY35gxnh3Jo0bBKZpckUqbt8g8OkvqSRYEwKDAwtaJGo6uZr2Vw>
    <xmx:XIxjY-xJgA8bgFZ4arLsUqXS3-TX9GnqsMK66mWxx6I8o-D5HgJSyQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0B0CEB603ED; Thu,  3 Nov 2022 05:39:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <a3754259-9989-495e-a6bd-5501daff06a2@app.fastmail.com>
In-Reply-To: <7c59a115-36c5-c954-5610-ef5ef1dbb83e@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <c1f86c53-1d9f-4faf-9313-de86d33e3739@app.fastmail.com>
 <7c59a115-36c5-c954-5610-ef5ef1dbb83e@quicinc.com>
Date:   Thu, 03 Nov 2022 10:39:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Elliot Berman" <quic_eberman@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc:     "Murali Nalajala" <quic_mnalajal@quicinc.com>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        "Prakruthi Deepak Heragu" <quic_pheragu@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Amol Maheshwari" <amahesh@qti.qualcomm.com>,
        "Kalle Valo" <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022, at 19:44, Elliot Berman wrote:
> On 11/2/2022 12:31 AM, Arnd Bergmann wrote:
>>> +static long gh_dev_ioctl_create_vm(unsigned long arg)
>>> +{
>>> +	struct gunyah_vm *ghvm;
>>> +	struct file *file;
>>> +	int fd, err;
>>> +
>>> +	/* arg reserved for future use. */
>>> +	if (arg)
>>> +		return -EINVAL;
>> 
>> Do you have something specific in mind here? If 'create'
>> is the only command you support, and it has no arguments,
>> it would be easier to do it implicitly during open() and
>> have each fd opened from /dev/gunyah represent a new VM.
>> 
>
> I'd like the argument here to support different types of virtual 
> machines. I want to leave open what "different types" can be in case 
> something new comes up in the future, but immediately "different type" 
> would correspond to a few different authentication mechanisms for 
> virtual machines that Gunyah supports.
>
> In this series, I'm only supporting unauthenticated virtual machines 
> because they are the simplest to get up and running from a Linux 
> userspace. When I introduce the other authentication mechanisms, I'll 
> expand much more on how they work, but I'll give quick overview here. 
> Other authentication mechanisms that are currently supported by Gunyah 
> are "protected VM" and, on Qualcomm platforms, "PIL/carveout VMs". 
> Protected VMs are *loosely* similar to the protected firmware design for 
> KVM and intended to support Android virtualization use cases. 
> PIL/carevout VMs are special virtual machines that can run on Qualcomm 
> firmware which authenticate in a way similar to remoteproc firmware (MDT 
> loader).

Ok, thanks for the background. Having different types of virtual
machines does mean that you may need some complexity, but I would
still lean towards using the simpler context management of opening
the /dev/gunyah device node to get a new context, and then using
ioctls on each fd to manage that context, instead of going through
the extra indirection of having a secondary 'open context' command
that always requires opening two file descriptors.

>> I'm correct, you can just turn the entire bus/device/driver
>> structure within your code into simple function calls, where
>> the main code calls vm_mgr_probe() as an exported function
>> instead of creating a device.
>
> Ack. I can do this, although I am nervous about this snowballing into a 
> situation where I have a mega-module.
>
>  > Please stop beating everything in a single module.
>
> https://lore.kernel.org/all/250945d2-3940-9830-63e5-beec5f44010b@linaro.org/

I see you concern, but I wasn't suggesting having everything
in one module either. There are three common ways of splitting
things into separate modules:

- I suggested having the vm_mgr module as a library block that
  exports a few symbols which get used by the core module. The
  module doesn't do anything on its own, but loading the core
  module forces loading the vm_mgr.

- Alternatively one can do the opposite, and have symbols
  exported by the core module, with the vm_mgr module using
  it. This would make sense if you commonly have the core
  module loaded on virtual machines that do not need to manage
  other VMs.

- The method you have is to have a lower "bus" level that
  abstracts device providers from consumers, with both sides
  hooking into the bus. This makes sense for physical buses
  like PCI or USB where both the host driver and the function
  driver are unaware of implementation details of the other,
  but in your case it does not seem like a good fit.

        Arnd
