Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30D05E7476
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiIWG7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIWG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:59:14 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6F11DFFF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:59:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 756E7580AAE;
        Fri, 23 Sep 2022 02:59:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 23 Sep 2022 02:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663916349; x=1663919949; bh=H3fOWVl1nr
        ig8yAtZx8mZuIdwLAEktoa3iURSPLFlcg=; b=igscA/O5rNCv1EWzl6YZVFYWCR
        Z/8wvTN0PbFRnUMFifQah81ScsX1HNVehK7auPpEd4QzzfsbpuanXPUUEtZAPYy6
        63TiKgQALoogMroK4HEaYwkSTNwY+vQ54z1hBaqiGrivJvPZcOolHNPVLj66GKzf
        xIAjVdgZuyBxILlCx2quUwHlBDLLT4Lc4UW3L+hfwMMFt/hbv6qOCmQ/XUtDBsmG
        61ARK31dQF/IgCETRhzK6Yr6LWzGhw4jI2IQX+vTIHbeFzQGjlNnfP+0jDzvkqoy
        L2XPiQNmmNsX9kg20u38lyatYaF3wonDNqssiRZ8v7dJtgOdatagixuvIh0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663916349; x=1663919949; bh=H3fOWVl1nrig8yAtZx8mZuIdwLAE
        ktoa3iURSPLFlcg=; b=ue1+Nh7OsCQGWIfSgWTo102eKge/+gYTvvZkSzUhJGCy
        NTJ8YGCL2olpRVlrxRJfIyl47vYdiPHngv48n2F6XLfTZr0PlQkyRCGsC/fECPZR
        SM+naeFr+mrSR3JjHrupuCihtSvMLvDVCcRZO+eWqgz4lmjCJbZNcrUvJfv4p/gt
        Pzo4NlrCltAfuHc81mKU9fXrGkt1SGulDE3vH8neqJTOYy+cHC2IFOtjZMnXpOJP
        on6IZ8nLFoguyi8fPvwfGizHtp2jEVGZtphj6LYxxkvjEe66e3RI3PkRQPeRdOtR
        iLS3TtO3EJ3MyJUS0jhLcyDaqpzNOgTVDAJGfpMmxQ==
X-ME-Sender: <xms:PFktY3dlY5dH_HEWnmJvqJIFIStXjt-qaEbqLfLhcl2iXxgafEjljg>
    <xme:PFktY9M5JcaNHi6PT0fw0UBU6jM-VD0mFCnf2GtwKpdHgE7t3fAy2C_KFXgzPdc_K
    NdDLqvrXd06Tq6ym2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefhedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:PFktYwiJsQ9xKYhvDrufxE4Ij44oKpOEH_0gaE_FmlTk8tyLU0mctA>
    <xmx:PFktY4_097ePiM3q2eWqQsISupR-QZu86GRV9W05cey-D_w-rlUO3w>
    <xmx:PFktYztfY8zRSv5QZFm4RmGVxgS76t16SyRMlhrxe_fZdglx8BZbrw>
    <xmx:PVktY874RjaqKcvQAWfPTBIJKuovUXPvpXwf1HtmCRFMZiqOr5kg8A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F02A2B60086; Fri, 23 Sep 2022 02:59:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <ae8041cd-0f20-47e9-a4be-92159785e8a8@www.fastmail.com>
In-Reply-To: <YyxzrjA7hW6gdV5e@owl.dominikbrodowski.net>
References: <20220725012955.4928-1-jrdr.linux@gmail.com>
 <YyxzrjA7hW6gdV5e@owl.dominikbrodowski.net>
Date:   Fri, 23 Sep 2022 08:58:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Souptick Joarder" <jrdr.linux@gmail.com>
Cc:     "Tony Lindgren" <tony@atomide.com>, linux-kernel@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH] pcmcia: Removed unused variable control.
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, at 4:39 PM, Dominik Brodowski wrote:
> Am Mon, Jul 25, 2022 at 06:59:55AM +0530 schrieb Souptick Joarder:
>> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>> 
>> Kernel test robot throws below warning ->
>> drivers/pcmcia/omap_cf.c:127:7: warning: variable 'control'
>> set but not used [-Wunused-but-set-variable]
>> 
>> Removed unused variable control.
>
> From a code-generation standpoint, this is obiously correct, and probably
> the compiler removes that omap_readw() already.

omap_readw() is an 'extern' function, so it does not get removed.

Even if it was inline, it's still "and volatile" read that gets
left in because it may (and probably does) have side-effects.

> But, to be honest, I'm not
> perfectly sure on what the device expects -- and whether it's required to
> write back the control register (or parts of it). Does anyone still have the
> hardware (or specs)? If not, I'm tempted to apply this patch on the basis
> that the compiler might remove that omap_readw() anyway.

I think assigning to an unused variable was at some point needed to
avoid a compiler warning because otherwise omap_readw() was just a
pointer dereference. The safe way to transform the code should be to
drop the variable but leave the function call.

Note that the driver is only used on the 'osk' reference board,
not on any devices that were in mass-production.

     Arnd
