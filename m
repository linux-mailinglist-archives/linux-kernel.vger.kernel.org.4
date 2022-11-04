Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216F6619275
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiKDIKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDIKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:10:33 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F4C21266;
        Fri,  4 Nov 2022 01:10:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E780E5C00BE;
        Fri,  4 Nov 2022 04:10:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 04 Nov 2022 04:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667549430; x=1667635830; bh=4yw24n+H9s
        ew5wjPIN5rwS9Ptmj6epn7kfJOfbtVSMk=; b=Og9ijk2hObYCaVvY79CGJF8wxq
        2lgE7uxsPAZYpI7WuRRSliXmPYja/ts8fKNpSbuarP9zeSTumYtC+NsMD/HhZzou
        xir+G9OdCZH8ETuQlm1LvJRBikMRh9hg7POeIvDhU1+z1GQoHjb43WdY3Qm5eTwD
        M4OKKBe7EBlQ89T3NfKSRkXsLGI+bUAtz4h78b5orou5p2WXTkap3rEssRQBTOtv
        IMfuRYBzhhN32qjJWUMsqLFkTUgdIKzcldnH1WcAcs1/7hyRYXZPY2q8VJ7LMo2F
        sbyq92b+2dv4V7EkbheDFCO8JXoWNG05G20KhX0VYzCm+coX5IvNUDeFX99A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667549430; x=1667635830; bh=4yw24n+H9sew5wjPIN5rwS9Ptmj6
        epn7kfJOfbtVSMk=; b=CS7UG3tY5ElDuWEDog5xPDIJyNxdYWNLQR4N3lowjwLu
        XMol5Ym0sE084PHNE5tp+I/QXMQlS0qxHm/5O4f8lwcFz2yW1F9OmlaxXBJw/X3D
        YCoQj/k9XJEJt05NfLSHL1QTue3zR3ne0O/46eP2m2uenYEHNEQZXXyE5apF67Xg
        Qa0J7L0Jif4wg+DADocKPA9e6jz4h0RiMGNdt8B1E7wWw+vmRgwkLqjgfW6EOVeo
        WmFjfLum5zoCAi4/UDO8mAIE6QBTfrVGYnHP/6haDLk13SheuG9Nk6rbubIvX685
        mDflAvom14aFSse8+K48vwL9ZQE7Ih3J5tbxNze5WQ==
X-ME-Sender: <xms:9shkY6r5nTEm0ai-OvcxDXsjTtzR-y3fA0phAHdWPior-ae0M02V0w>
    <xme:9shkY4olQOufzpK54hZ2E3w0_yIixkAKQVUXeTHsU6G691k9UglAutaJPeaunYFB1
    dtRB9uFRfsPilbNOzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddtgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:9shkY_NPogpgaWVhOBpxaCq98Am3O7kMgUZjGNnCh8_MMPSwFL3CYw>
    <xmx:9shkY57I1w0ZfBpWbSjChg7zmukbrqIKGuJm9DxJAUalIwUZ8nqLpw>
    <xmx:9shkY54jCvXUJE0T8rb23dIbMdseKqwpuI_569IbwzrmMeAfuU8fDw>
    <xmx:9shkY4z1DWqNwc_l0qkEfbxt3YZ-DHzQw5d1FbF3Ym5IGQqbFn74ww>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 914A5B603ED; Fri,  4 Nov 2022 04:10:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <9dd597d9-a3f3-48f2-8416-b5b097a230d5@app.fastmail.com>
In-Reply-To: <96238455-73b6-bead-0fdb-55ca68e5bf0b@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <Y2H8oh7AvYDiMqKs@kroah.com>
 <722b05a1-4bf5-0837-baea-b1d0a9cc1e43@quicinc.com>
 <Y2MKWOihjAPxfl6v@kroah.com>
 <96238455-73b6-bead-0fdb-55ca68e5bf0b@quicinc.com>
Date:   Fri, 04 Nov 2022 09:10:12 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Elliot Berman" <quic_eberman@quicinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Murali Nalajala" <quic_mnalajal@quicinc.com>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        "Prakruthi Deepak Heragu" <quic_pheragu@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
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
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Amol Maheshwari" <amahesh@qti.qualcomm.com>,
        "Kalle Valo" <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
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

On Fri, Nov 4, 2022, at 01:11, Elliot Berman wrote:
> On 11/2/2022 5:24 PM, Greg Kroah-Hartman wrote:
>> On Wed, Nov 02, 2022 at 11:45:12AM -0700, Elliot Berman wrote:
>>
>> Even if you don't support it 1:1, at least for the ones that are the
>> same thing, pick the same numbers as that's a nicer thing to do, right?
>> 
>
> Does same thing == interpretation of arguments is the same? For
> instance, GH_CREATE_VM and KVM_CREATE_VM interpret the arguments
> differently. Same for KVM_SET_USERSPACE_MEMORY. The high level 
> functionality should be similar for most all hypervisors since they will 
> all support creating a VM and probably sharing memory with that VM. The 
> arguments for that will necessarily look similar, but they will probably 
> be subtly different because the hypervisors support different features.

I think in the ideal case, you should make the arguments and the
command codes the same for any command where that is possible. If
you come across a command that is shared with KVM but just needs
another flag, that would involve coordinating with the KVM maintainers
about sharing the definition so the same flag does not get reused
in an incompatible way.

For commands that cannot fit into the existing definition, there
should be a different command code, using your own namespace and
not the 0xAE block that KVM has. It still makes sense to follow
the argument structure roughly here, unless there is a technical
reason for making it different.

> I don't think userspace that supports both KVM and Gunyah will benefit 
> much from re-using the same numbers since those re-used ioctl calls 
> still need to sit within the context of a Gunyah VM.

One immediate benefit is for tools that work on running processes,
such as strace, gdb or qemu-user. If they encounter a known command,
they can correctly display the arguments etc.

Another benefit is for sharing portions of the VMM that live in
outside processes like vhost-user based device emulation that
interacts with irqfd, memfd etc. The more similar the command
interface is, the easier it gets to keep these tools portable.

      Arnd
