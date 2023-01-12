Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26156678B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbjALPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbjALPLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:11:44 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE32602
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:00:32 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DCD1F320097F;
        Thu, 12 Jan 2023 10:00:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 12 Jan 2023 10:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1673535630; x=
        1673622030; bh=LqqpGtID4VjpEU89F09GHBCJBYnLV9JhpECNMhPFXFA=; b=m
        +TDaGzov1ZchoEywUVxJFNAhORAvI6eldmtzYwBEHQtovXtkkVuR6xLhD9R4UiA4
        9FMkd6HRY6p93+Vqye/Fi2sk0fwwzBLY+kBtUSOJXiXzAv6BbbR9yae6ujHbZIua
        8UIMkq7hJ0srFd3eQ5futPISn70HQYRSJKQBXs71OYYPe78J/WbYNpwNnPQiIYlX
        o7jDd9JfdqM3xLm2deppnQDFwdntxayQ3r/oGVDWbC8cJ5ZY1dYjA4zhR762bXUy
        fcL8Ar4INeDilQNhvsVafUUo0ZBXeKl8Z2UnzV4PoTzK6jtQSn0g8f5h7wISLLPE
        UulhwyoUSI4KNkmJLf//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673535630; x=
        1673622030; bh=LqqpGtID4VjpEU89F09GHBCJBYnLV9JhpECNMhPFXFA=; b=e
        P/+X8+ClVAytJpkbDu8AyrTRsofXFaLtPRRE4e3Y4nHHKWoj3ifcZUsKXbKaakz4
        LOMzPpaa9L6/rzXXPGu9YmDbMK/hf8cLWdhOu4dH/EprKJGUgY8ibn23gO5dmkpG
        44c0RKW6l2GZwz1fiGTLuSm6cw2RSIe90Eg/v4gZdi8rQMe8j1Sbdj4QvqGDQiSl
        Xn5WCS1vAvz4xMkcAO7lFxB0MGqSFjV3bi52FuFPSCAnXkNnKDNPtW+Dg5tPQIak
        8aDndJdBNdB7d9l7VE+sVf5tgNhHPcyJ8jZjqe65hnzyD4t4jVHXYYGCcHvsJ/Ak
        daGC0Fep5V2Nl0dL7ozmw==
X-ME-Sender: <xms:jiDAY3ZpMiRE-5aQv85DH9qGyv9tRyGqXMrspRBZIU0aDJEp7I4UsA>
    <xme:jiDAY2YH9Yi-tSwTkSsIfVun1vnP30yFDkiBp53E_qt7zqygHUboEbuvw7wYCVN3w
    CW7GEP1IUkUo8KW5tQ>
X-ME-Received: <xmr:jiDAY58iYrK4vY_-D-gfbLrfm3STVtg3sqSlOMGXa3JNmxCBQHKPf1KDwjev2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepffetvdekudetgeffueeivdeggeehhefhgeeuleffiedujefhgfdugfeu
    vdeivdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:jiDAY9oDWzDZ1prkdMo-OxDu2exdit2XnL4tI-Gwd7-EsAnPZpvVxw>
    <xmx:jiDAYypEcjFFJNXEHzJBnFdA2UdvC5FkvFNdYefRaJ6Ql8ExH4Qx2A>
    <xmx:jiDAYzReg3oZpOC3KPImJEpifc7niYyHExgsC5aF3n_ggLfqWlJw6w>
    <xmx:jiDAY_RlPZAf065ZWprwLKY_CPOW6qF8_ZP24H1Nvy5XwuJTnU8ygA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jan 2023 10:00:27 -0500 (EST)
Date:   Thu, 12 Jan 2023 08:00:25 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Andrei Vagin <avagin@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 4/5] seccomp: add the synchronous mode for seccomp_unotify
Message-ID: <Y8AgiZqYSjozXbhP@tycho.pizza>
References: <20230110213010.2683185-1-avagin@google.com>
 <20230110213010.2683185-5-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110213010.2683185-5-avagin@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:30:09PM -0800, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> seccomp_unotify allows more privileged processes do actions on behalf
> of less privileged processes.
> 
> In many cases, the workflow is fully synchronous. It means a target
> process triggers a system call and passes controls to a supervisor
> process that handles the system call and returns controls to the target
> process. In this context, "synchronous" means that only one process is
> running and another one is waiting.
> 
> There is the WF_CURRENT_CPU flag that is used to advise the scheduler to
> move the wakee to the current CPU. For such synchronous workflows, it
> makes context switches a few times faster.
> 
> Right now, each interaction takes 12µs. With this patch, it takes about
> 3µs.
> 
> This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
> it used to enable the sync mode.

What about just not having a flag and using the new primitives all the
time? Is there any reason not to?

Tycho
