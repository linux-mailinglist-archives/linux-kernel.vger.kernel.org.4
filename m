Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC034624140
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKJLTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKJLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:19:33 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1801097;
        Thu, 10 Nov 2022 03:19:31 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9D16F320098B;
        Thu, 10 Nov 2022 06:19:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 10 Nov 2022 06:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668079168; x=1668165568; bh=ifZN531fzx
        PIHpouo1jQhbXOb4J2WZNSWkifMSSVh3E=; b=ne56sfpcT3artr2/7NJnzJEjN0
        F5tkTkzDlaKG9724FgTB44TBUDWflpp8g2U6+t9akmZWmoZvP11n8dtdGFDGC+BK
        jspUpHMXJc+CDwYyI1D37pZhQvw7qqrylbEj5fQYA1eDGxIPyudYJcGiC6wpBHCJ
        teNuNk+JnrXlu0Q0yQkkGsAhRkA45VjVp1CvWkHXKAKOoaSzgjjIg6nGhwNz+rWg
        bVedmmdGCb4nXyqHRuqwl6IwkMIb/vaHFZK5DDcg1vv5BuDGgG5CnHff83Gd1st/
        HU9KWhxlUw8X9xiSRLz2lkUMcQ6G8g7JAJbdcE6+M+M1iyQPEDst9xKgeCgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668079168; x=1668165568; bh=ifZN531fzxPIHpouo1jQhbXOb4J2
        WZNSWkifMSSVh3E=; b=H7lRNj/NuqS2C1LPDQC7+8fZBQ5mfW/Lzab9TIbFiFQm
        QshBT2TQikLFLZLp5VpLypf7IKh4stvWY2iCxnQvvSKWS7yBoO6xJfHbHyrQMXAy
        5QBI8NU0Cv9B+r9vAJHB6igjSCRWHeqa+wvFYdDwxoqW4hJGihWq8pP1Fpe48LnU
        ML2BEtWiCm1F5kKV4B//v2/nTrf+npWuclDoH/twG2ACoFOT2gK/rS+Xe0mvX5JB
        NrOWHUmZlPecCijbTp5RuR+/9XlPW5xoYNqtMhJVH3aW7+00c2xasMlCWH+nmEfk
        SyNMUJD6Rlc1GQ07+F9ZbKWEMrO+6+MaHFKpMSYqVg==
X-ME-Sender: <xms:P95sY00hH0O2gdQJun6oM5iLKvBIbC8SheUITxBZi7xUMbi0mWYRfg>
    <xme:P95sY_F3Hk3ggGbBC7p0gSp_0B1f3hG3uL43obHntxofpPIadVKJhP_IFtRBM7Tbx
    iV8xBN5Oo5dfT1HCKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QN5sY87vR70_oaYCYPgr-MC_Y17ufZphvA3nd4Yrw2VhwxOQjYv0Mw>
    <xmx:QN5sY92a3zPY2aXwUKfazgi_vW_oEGuokHF-9fN4UVevnpCFyYe-Vw>
    <xmx:QN5sY3FCV6FSx3U8shiRaBhJa1R6XxemA0mcoKSixNDwBf7osiOB7A>
    <xmx:QN5sY23gSX2bWJKfm51kKplkjDoXgUfDR4fxeYOZoxmELriFdTFbfA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC451B60086; Thu, 10 Nov 2022 06:19:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <f22ea97e-9d76-4c8b-a0c9-698db6e69a9f@app.fastmail.com>
In-Reply-To: <CA+G9fYtaNmXOKnwH_ih9vZyFeaD+Lvzxf3WTbAV50rBtwkPxpQ@mail.gmail.com>
References: <CA+G9fYtaNmXOKnwH_ih9vZyFeaD+Lvzxf3WTbAV50rBtwkPxpQ@mail.gmail.com>
Date:   Thu, 10 Nov 2022 12:19:07 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Linux PM" <linux-pm@vger.kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Stuart Hayes" <stuart.w.hayes@gmail.com>
Subject: Re: x86: clang: acpi-cpufreq.c:970:24: error: variable 'ret' is uninitialized
 when used here [-Werror,-Wuninitialized]
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022, at 12:14, Naresh Kamboju wrote:
> [Please ignore email this if it is already reported]
>
> Kernel build warning noticed on x86_64 with clang toolchain [1].
> Build failures noticed from next-20221108 .. next-20221110.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- HOSTCC=clang
> CC=clang
> drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is
> uninitialized when used here [-Werror,-Wuninitialized]
>         acpi_cpufreq_online = ret;
>                               ^~~
> drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable
> 'ret' to silence this warning
>         int ret;
>                ^
>                 = 0
> 1 error generated.

This is caused by 13fdbc8b8da6 ("cpufreq: ACPI: Defer setting boost MSRs"),
which removes the initialization of this variable.

      Arnd
