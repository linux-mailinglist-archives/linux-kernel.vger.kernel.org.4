Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A014D6A5571
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjB1JT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjB1JTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:19:22 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282F1B577;
        Tue, 28 Feb 2023 01:19:21 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 56EE65C0162;
        Tue, 28 Feb 2023 04:19:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 28 Feb 2023 04:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677575961; x=1677662361; bh=RTh3XCd3TT
        INGEA8952iJSbnCnKSTHDULwmXmX3RyCY=; b=apt/iV+JxeXYnDOobPFP8Wyby+
        rw7OCEUJ5AG8lL5nle1MCjNaC8WjJZl3SMl42N7A7P1P0DecIQjccDUgbFT5wjs3
        tqjYgkjT+ONmwejV4/0VWd8GMKLX8BZYSvPcG9xhxcMhA/lFJhoo97QY3tdMsy33
        kjRQcvxjU5f1eCYRs/QyewBsAf1tEnz7g0Hh4YxYBUblcQIDj2ZJXEI2r9DGKIn6
        Jse17yCjxpGHtJ9pykChnl0U7COxHENCxPrcU+NHeyYQytHf228yiZt9kJV+LIHr
        ZaRKr5COYEIUpniIA3MLk0gQpEfVzWGXpyK6SHA9jmx+QVpjmdffwoAdBmdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677575961; x=1677662361; bh=RTh3XCd3TTINGEA8952iJSbnCnKS
        THDULwmXmX3RyCY=; b=C2Z18Z0B7Y4zUsQZHT3fNir62IoIwXtBeBwuZceDO/gS
        2+oHSRHY/+JifnXRpiXuChpEcLsz5oky1n9Lmug+v/4X+0yH/qjmKTBj9Cwfe5sS
        B/5YNPw7pLWLuMoFQCEAeTOdk4YSqEeU79CXE25Fp7dDjb8BVOWVrX095uTuQb4O
        iqhDZBOdL+RJbGxoSZuDIz0FYvH5o/5WR1oYfVzRmCq3xsqlmrnWxi/PdB3xnfJC
        n1BtBBlmhXSGywVsPwvWlqvqZSdoDFZ6CFN1DWh9OeDFrdE1PoOU0BWpmyNiC9BF
        RzDzs51zgIA9ggqGuY3JQ7UAnJjcsW9ErnBJYb9NkQ==
X-ME-Sender: <xms:Gcf9YwOaAb-8PooJr6JFqyQD-fBpzw1CtjishQ63uUwrwrW-HX9LvA>
    <xme:Gcf9Y29hx6BZKL3SOpciqHiKuk6ZgrL0JMxTjDlbYtceUb850fITrz5Lna5K92P1X
    _SHFAypawqU64UJyMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Gcf9Y3SOIqIt6Rtam2bjR2U_f4mC-JCrX62vw19ioVxgEC8ilUo67A>
    <xmx:Gcf9Y4tLhkT19H9SWtUWuoJ1evYLTzbl6VFGCM_Wx2kFqgUUtmHFqg>
    <xmx:Gcf9Y4fQdD8p9k5xWwi-dqKgp-0WjCjYKNny3Q_kf6tr0v3RrxfDTw>
    <xmx:Gcf9Y8G_xYXOHo3MxFfeU6phhCWxtqbim4iFQa-dEbaqSsjjDiKpOg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0A6DAB60086; Tue, 28 Feb 2023 04:19:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <90bc1f6c-95c5-43a5-a39c-6a72bdf4a4f5@app.fastmail.com>
In-Reply-To: <fcd61f55-f445-9721-3490-ed70b7b30293@linaro.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212356.3313181-1-quic_eberman@quicinc.com>
 <dbcfa4e9-a1ad-0f24-77bf-05934ca26bb2@linaro.org>
 <05c4aab8-2d26-b944-adb6-624d67e4a11d@quicinc.com>
 <52d944b1-3ea6-26b7-766a-2fed05dccf3a@linaro.org>
 <c5ff1523-7a62-3d3f-6fa9-792ce4d222e8@quicinc.com>
 <a50fa44d-fbc3-9ce2-175b-85c8cd7a9f7f@linaro.org>
 <15aa881f-5cf1-446e-a71e-f62d24e87500@app.fastmail.com>
 <6efceacf-93d3-787a-a121-bee16f1531f2@quicinc.com>
 <fcd61f55-f445-9721-3490-ed70b7b30293@linaro.org>
Date:   Tue, 28 Feb 2023 10:19:00 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alex Elder" <alex.elder@linaro.org>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
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

On Tue, Feb 28, 2023, at 02:06, Alex Elder wrote:
> On 2/24/23 4:48 PM, Elliot Berman wrote:
>> I'd be open to making GH_CREATE_VM take a struct argument today, but I 
>> really don't know what size or what needs to be in that struct. My hope 
>> is that we can get away with just an integer for future needs. If 
>> integer doesn't suit, then new ioctl would need to be created. I think 
>> there's same problem if I pick some struct today (the struct may not 
>> suit tomorrow and we need to create new ioctl for the new struct).
>
> I'd like someone to back me up (or tell me I'm wrong), but...
>
> I think you can still pass a void in/out pointer, which can
> be interpreted in an IOCTL-specific way, as long as it can
> be unambiguously processed.
>
> So if you passed a non-null pointer, what it referred to
> could contain a key that defines the way to interpret it.
>
> You can't take away a behavior you've once supported, but I
> *think* you can add a new behavior (with a new structure
> that identifies itself).
>
> So if that is correct, you can extend a single IOCTL.  But
> sadly I can't tell you I'm sure this is correct.

In general you are correct that the behavior of an ioctl
command can be changed by reusing a combination of inputs that
was previously prohibited. I can't think of a case where that
would be a good idea though, as this just adds more complexity
than defining a new ioctl command code.

Interface versions and multiplexed ioctl commands are
all discouraged for the same reason.

      Arnd
