Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4485B9BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiIONUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIONU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:20:26 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEA07F091;
        Thu, 15 Sep 2022 06:20:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 90FBC580746;
        Thu, 15 Sep 2022 09:20:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 15 Sep 2022 09:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663248018; x=1663251618; bh=xNZO8Qd7cg
        pPkf8PCEJfzLRPTqkkIBdXmgwHoAWKT4A=; b=a2xJhjmzELPuUYfPbItYy4aOcO
        Y07OJ1Oap76mVHpiWU5QXbe7Ma56vPyqdGBugwY4nNJLcma3aHq2HW0ZaLE6LkFJ
        VhBq1ItbSUahnmt5X7CDF8W5cGBiUQa5YWlVvC5T7cTmOmwdIxeIdA7W2wt3MqW7
        SdQuR7xrEcisxypsjFAKK6MgTx4uiuajVfVTMHjM3EJrxUF40PtaKmCyuIN1xHnO
        1Hf7IsM1gmsBFF2+/C6ehKkvXlacwEprK1vD8jT8D84LqtiHKp/WiEhjl8Wn2Vx2
        mm4Y/l01xWVL+SI3bqaP7akl7joDtP4nKTDLulgrTJiME/Iv6bd4HpFnl03Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663248018; x=1663251618; bh=xNZO8Qd7cgpPkf8PCEJfzLRPTqkk
        IBdXmgwHoAWKT4A=; b=AC+eqk5j1hCMlAhv/CbSd2vX7v0n/1oWUl3zgydiilXh
        pQJfLN+hxyBPbYTFVBw3iraZ5wR2HP2Bpn94gdnb2pY6fBFredejsfhS9501Ev5i
        dvzP6JSRsRsMv7YnYsk2w686/HiqfDe09ONU3TCxA90eQIHyf4BWJa0qeA+u957F
        J5gejJ92r5ztanSYoxx/Vci/mesp5wQiIX98C3gaRxOZ/KYCVLQeLNg8H4yT+5tY
        sOVW5eZQ6HP6HWJrVIoeD/eo5qxrD+iBeyhfBkTVfZwdWLqiPGtuPZLXkCTgfeAC
        Q2xMAkBdVqmOmT81DtWyB0Nl7A2OArGzIvkAoS4ioQ==
X-ME-Sender: <xms:kSYjY_lFyaC_26S5k1rP0yuDPZRsfVyRP33z-_6-dK6bdJfwbaOT2Q>
    <xme:kSYjYy2dEgJulF0ZUhlZQS6PutbACfM1NChAFgpMCMjn6wlCcH_1a2OSQagG3Vwtb
    UV9z90KDl_IBp9w7_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kSYjY1qy_31JJmykt3aa1wW7ndq6gn61m-XvgXuxeI23MNaGDcEu1g>
    <xmx:kSYjY3k49xvf17FkDoNncvHrrPlMdoZeRXHn5x4rhbQk3uSWIKfRWw>
    <xmx:kSYjY92Fzz65jCZ2YrLlCnfaboWBMn_c878YlpR_nNon5NzL2tyWZg>
    <xmx:kiYjY2wxgbXkMfDzyifaNnC2CFw-yGmwRBgOvQRaKN7ylinRfKh9tw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D1532B60089; Thu, 15 Sep 2022 09:20:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <ac63bc50-3375-4877-a4f3-aa998cb148f9@www.fastmail.com>
In-Reply-To: <CA+G9fYsUEmhHT_YsZSvLBiUStuTPJ_DW4Gp0=p7umvfpngSABA@mail.gmail.com>
References: <CA+G9fYsaxK30=z0vBcNW-NRVHHkWxaoSNDt1bE-mfXQquMONKQ@mail.gmail.com>
 <97b5728e-e8ed-44a6-a777-a7f56370761a@www.fastmail.com>
 <CA+G9fYsUEmhHT_YsZSvLBiUStuTPJ_DW4Gp0=p7umvfpngSABA@mail.gmail.com>
Date:   Thu, 15 Sep 2022 15:19:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc:     "Tony Lindgren" <tony@atomide.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: x15: kernel crash: LR is at sysc_enable_opt_clocks
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

On Thu, Sep 15, 2022, at 1:55 PM, Naresh Kamboju wrote:
> On Wed, 14 Sept 2022 at 19:19, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> What is the easiest way to find out how long this job
>> has been failing, and what the last successful build
>> was?
>
> It is not reproducible easily and I have checked when it got
> started but failed to find it. Because on v6.0-rc3 kernel the x15
> did not boot pass.

To clarify my question: how to I look up on the website what the
previous results for this boot were? Surely it must have passed
at some point, and I would like to know e.g. whether this test
setup booted 5.19, but I don't know how I see that.

     Arnd
