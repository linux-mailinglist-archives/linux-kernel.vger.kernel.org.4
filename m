Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14191744CB6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 10:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGBI0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBI0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 04:26:42 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B932E60
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 01:26:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4CA973200971;
        Sun,  2 Jul 2023 04:26:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 02 Jul 2023 04:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688286396; x=1688372796; bh=n1
        OAwnbouJPcmFjXmnwM28XOGx38UWuTFQPscs6uCCQ=; b=GXzA+4H2ZMijL+2oCC
        8YU5cRAGGY1Emj0IwNGVM24HkbWCYrdJwTl1w5xJ/o3jiz6rHE77IGzy+uM30isj
        y+pVEzWZ95N9J+H5NAWRcgw/qG0zDsSVNmELeVyjtG8chKEf4Eqsl69mHstI/OYZ
        A4RIlP4lXzSMs3/haHYx8GyZUKW16k5CefgBs718oIaEu7CHvfRyeDHHhSBNDaSx
        Ik6cqv/M4Ni5+gQWP/7z6sckDiEZtYWHNyzlcMYe0VYdIiDrfEiNCSyUNdVEpe1b
        F5d1JDHWReTFcWJBXMF7e0pk9jdNnvEPpoRlLZJCXJNwjI8Y+7l/fzm6N0dyNt3v
        IyMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688286396; x=1688372796; bh=n1OAwnbouJPcm
        FjXmnwM28XOGx38UWuTFQPscs6uCCQ=; b=fNweE2//QCkB0xkOKsCpLE0kL1F2Z
        q7U/tdlttFwc95osmFnoIoBbx8z2eAgv7Tl8ktzAw6uJQIhVUBLvlGxNksHcAEwK
        7VeLKuWlFrhT0kIOXRY4kb7iM+wfTwg4Ni8qTBEPQuXIGZHRFkJnb9lUApa3UdgA
        7AZTR65Dx7xgBbVhrSC/j0aPa+iyVjLMWPCvRUl42oJf27I8WjqCnVgljaBIuM2p
        IHUfbk4TSo3lvcp8UTyGKmraWA6J6uOMoKlHdMreaFQahlnAXlVCAqbcHh9VbZXA
        E7bVR7vLDqLyGswRSjgh2jCjQqN9/uaZ4ThoSliWsK1/iet9GPhOTdt4w==
X-ME-Sender: <xms:vDShZMez6tner3VDtDcWXdINOjGnc1lV44EHAeCVaXV7utCZRlr6-w>
    <xme:vDShZONx3TvZNZDWR1mrwYGsnuGsKo3Q4WG15is2nxfGwYs6jvPGUYxoWJlOrQJAC
    CjS7lBkijtWbEWAU6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdelhfettdetvdetvdeuueegvdeuleeuudevhfeuhfeugfdvtdevvedvfffh
    udenucffohhmrghinheplhhinhgrrhhordhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vDShZNjHP0CGhSURlPR64SfyqXTLcj8q9K-IMlENKbGnIUxH6XVXqg>
    <xmx:vDShZB-Tt3hIaUqT4zwfEKHO9l-6yRPc-Rv9Zkdmtg4Y2WCdulpXxg>
    <xmx:vDShZItCLxPbrfFZxQB1F4L6-vXG5gVaTuuOOerlwX6ngMXZ6qDSTA>
    <xmx:vDShZCXKCzPagZxtQofNJWmheRjZ4BFGaEV6AZ5r9krCOhCiftc8gw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5D94BB60086; Sun,  2 Jul 2023 04:26:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <d41a6d08-981b-481b-9108-fe91afaa0f82@app.fastmail.com>
In-Reply-To: <CA+G9fYsuc8D98BtW9rX0ahS9Rfqyn-5CALYWTy6fr_ypJqEErA@mail.gmail.com>
References: <CA+G9fYsuc8D98BtW9rX0ahS9Rfqyn-5CALYWTy6fr_ypJqEErA@mail.gmail.com>
Date:   Sun, 02 Jul 2023 10:26:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     "Frederic Weisbecker" <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>
Subject: Re: qemu-arm64: Unexpected kernel BRK exception at EL1 - WARNING: CPU: 3 PID:
 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023, at 10:42, Naresh Kamboju wrote:

> Links:
>  - 
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8686-ge55e5df193d2/testrun/17999853/suite/log-parser-test/tests/
>  - 
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.4-8686-ge55e5df193d2/testrun/17999906/suite/log-parser-test/tests/

I can't see which build artifacts correspond to the logs. Can you link to the
vmlinux file?

       Arnd
