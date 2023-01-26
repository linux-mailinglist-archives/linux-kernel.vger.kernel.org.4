Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1449667D691
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjAZUiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjAZUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:37:58 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879971116B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:37:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E992832007E8;
        Thu, 26 Jan 2023 15:37:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 15:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674765469; x=1674851869; bh=PMRahnb2Ak
        WjbHaXnveaTHzGxVSBrfYNS4b8vo+obi0=; b=imGPK7aNybQBJmap5UxzEIhID0
        8QfKpJLpADlZ92HHyyIExVfvUsUDgN7WJt2HM7RbcLXGKS2V6LpD5b4S9/BRKe58
        w9aHLPIy7pye8Ao3kf5K9/QpOGfqBE8JlA9+R2sbk0PoulOgH3NMA9+9IZRV8K95
        x7tQmE+TYHfWl2gv+xKZl6rluC6PY52klLtBs1A1aJyvBR1E7QfGDZkoCL7p/Qyb
        4QZHHC2fRe96CPyeA9AP1px0o2TpX/i6Qdatv3qbzc80NmKfRz42HhTra56cp2fs
        87Yi09zEIawX+7+wSEB0zw6WcZqoMbvCzjkfe1HguhQzyFpQ4ROZRNhJ6gzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674765469; x=1674851869; bh=PMRahnb2AkWjbHaXnveaTHzGxVSB
        rfYNS4b8vo+obi0=; b=NUyD36npwB6t0VBzIV9Dtwk7yDh7d9sba6qVz2n90LId
        s7ooiveSZL3wHIbdVeJOye3zNRe5Rn6Fn9cOVCTH4Bb1VAgwl7Pm2Ip/BAMjFwxg
        vaYNMaC08kLIs0UrbHvzPO1/Gll8KJW0tn3mjLl034HBHOTfLq5CtD/5KXaAXTXg
        tY87rtvgKpVNwQJ/f9RXRVTf7EgwDd1sdxIGCKJfQ3ivOcRmZ8qUz6zbF2InLlLy
        bMR4dASys2Y4aOZYkV29BAODR7FI1n+l06Z56d/Lz30pfBeNnNhr34XMhp2FFTzi
        EwKNYpFEDmdeyuo/DDbdopGzuju+QM4phY10PxFrKg==
X-ME-Sender: <xms:nOTSY3Io4aVCPmGra_sSKINg1NEdBFGofiZcuSYRdUfS_L8t6LrJag>
    <xme:nOTSY7LAQlhDKVI6_tYJRKKq0DSTFPj4c5rNqz9JJLbACkpb-oHdEemL5Q5-wfbyG
    BL7jBbyc4mMQ7oI-Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:nOTSY_tPBIUTxnShS-Q5rEoRO11I8aLzADMUbqiy-RiAtcN6Y_07fw>
    <xmx:nOTSYwb8-Cy1i_-3E3urRJNaEqfQqJL0VQ0o29LiciAYFeJCBBisEQ>
    <xmx:nOTSY-Z2PJ6mA_5Bs0AmvTeM0n5CNODWILJv5_p7IrCbnbWL8SWCDg>
    <xmx:neTSY0MtI2RJuWyQ23mYUTrHbsWNmF_kkEeFJ8Lw1q6xdnzLJW-uOg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D5E03B60086; Thu, 26 Jan 2023 15:37:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <cd4f23d7-cdd7-49e1-8eff-9ec04dcb36c8@app.fastmail.com>
In-Reply-To: <7ec6bd88-7f18-7eca-fa92-cfea9a25a395@arm.com>
References: <20230126163530.3495413-1-arnd@kernel.org>
 <7ec6bd88-7f18-7eca-fa92-cfea9a25a395@arm.com>
Date:   Thu, 26 Jan 2023 21:37:29 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>,
        "Mao Jinlong" <quic_jinlmao@quicinc.com>
Cc:     "Mike Leach" <mike.leach@linaro.org>,
        "Leo Yan" <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coresight: tpda/tpdm: remove incorrect __exit annotation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023, at 19:02, Suzuki K Poulose wrote:
> On 26/01/2023 16:35, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
> Thanks for the fix, I will queue this. Btw, I did try to
> reproduce it locally, but couldn't trigger the warnings,
> even with
>
> CONFIG_WERROR=y
>
> and all CORESIGHT configs builtin. I see other drivers doing the
> same outside coresight too. Just curious to know why is this
> any different. Is it specific to "bus" driver (e.g. AMBA) ?

The warning comes from postprocessing the object file, it's got
nothing to do with the bus type, only with a symbol in .data
referencing a symbol in .init.text. Maybe there are some
config options that keep the section from getting discarded?
Or possibly you only built the files in this directory, but did
not get to the final link?

      Arnd
