Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E485FB10C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJKLJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 07:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKLJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 07:09:41 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60591D73;
        Tue, 11 Oct 2022 04:09:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 005F72B066FE;
        Tue, 11 Oct 2022 07:09:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 11 Oct 2022 07:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665486574; x=1665490174; bh=RM6oJ+Wm8I
        //KZ/oFLABpSMFlOHOa+xN+BM+5SLLxTE=; b=aSIYxCtYdt1yek8Ky0J+MBBZGd
        YNsaNQ38C8MlliiHZiynR73WHIEKlaMYrUM/xptOq/d1VGxGKHilri/wt4TPhIFl
        64pWwEtnf3Mm+GBlyIbpVJpQnIu9y4g0d9eCxZLWYdqXFtjPyxTjbNw9ilvakv0s
        kTrl5vahN583XPq/hWNgme/dnMN0//GaRZfS9XwvyoL/O8sPfeDb8mVlY1H3DBz1
        tsPsgCvF/r+aJNF6QQAjG70KR4G0PF6amSQjNEACaEL8rf2MK4osNJnaWCfaBIl3
        xyB1psknJFftHp9vNRmjc1vTmSguTPn70u5jJmIgnouMXY3jQ+mF8YwbruLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665486574; x=1665490174; bh=RM6oJ+Wm8I//KZ/oFLABpSMFlOHO
        a+xN+BM+5SLLxTE=; b=jflLYEknFINqe7qRTsk0daaR0znwMVl7nJ1IGdyv2ncY
        bVqpuAfif81zf9VlFFkyx4IUQoxDrHT8FtR/CGpTze63zrHIVbL1Q+fMroo/Z2dY
        pyd8G7jevH56aCaY4REcLf7jDd/DM4ioJvsToesOIgYmUg/Pp9v0fjWsbM/ULdQU
        1llbnH6kO5bK+hMIMfzpiS1/CL6hZahPp9t3/yDhMt37JQWUfw/SiWQgJwCEJvVY
        PvBWDFObOFEzSiPMWB9n8kguEKV6oVYvvMC84SfDlTANpR8pJEx/QXM66QIjwJv/
        UnKlF1rNoJ6V+kVms7q4RXjJxWsUchfap5IawwCxrQ==
X-ME-Sender: <xms:7k5FY_vwrB21dr5I-_tycqIxrn-vjDge8tsH9Kv-V3NzbDTGvWAYaA>
    <xme:7k5FYwc5fhyKd0kE9p10FFRWBbghqc2bpSz8sAVxmXT-fPPSE19_4I3ahqnTcZyWJ
    Frr_J0OVNjkEC2Muhs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7k5FYyzqziQBZRQ0Hlsh_jpYvdINfcj15npmDLShu1EAKIwtbms89g>
    <xmx:7k5FY-Oo8N9U2caNl5qYk7udqrpZq0DOZs-IaO1W7RR3e_HA2KbNNg>
    <xmx:7k5FY_-eu1g9YafbA0dDkaMf1xZB_23gMIJaN56laXcOXrjUYnx6oA>
    <xmx:7k5FY384T46l2ky4ckvjowwTBWaP2xs0Q-JhSsNpZGfEEsn6w0lE2z_SfE0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2CA43B60086; Tue, 11 Oct 2022 07:09:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <85ca7eb4-3e0c-4ffb-8bac-a435594ca0f7@app.fastmail.com>
In-Reply-To: <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-14-quic_eberman@quicinc.com>
 <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
Date:   Tue, 11 Oct 2022 13:09:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiri Slaby" <jirislaby@kernel.org>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Murali Nalajala" <quic_mnalajal@quicinc.com>,
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
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/13] tty: gunyah: Add tty console driver for RM Console
 Services
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022, at 8:02 AM, Jiri Slaby wrote:
> On 11. 10. 22, 2:08, Elliot Berman wrote:
>> +
>> +	/* below are for printk console.
>> +	 * gh_rm_console_* calls will sleep and console_write can be called from
>> +	 * atomic ctx. Two xmit buffers are used. The active buffer is tracked with
>> +	 * co_xmit_idx. Writes go into the co_xmit_buf[co_xmit_idx] buffer.
>> +	 * A work is scheduled to flush the bytes. The work will swap the active buffer
>> +	 * and write out the other buffer.
>> +	 */
>
> Ugh, why? This is too ugly and unnecessary. What about passing the kfifo 
> to gh_rm_console_write() instead? You do memcpy() there anyway.

Another problem here is that you really want the console output to be
printed from atomic context, otherwise one would never see e.g. the
output of a panic() call. Having a deferred write is probably fine for
normal tty operations, but you probably want a different device for the
console here, e.g. the hvc_dcc driver.

     Arnd
