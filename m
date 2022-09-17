Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264AB5BB729
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 10:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIQIQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 04:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQIQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 04:16:28 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0C1FCFE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 01:16:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 45F6C580204;
        Sat, 17 Sep 2022 04:16:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sat, 17 Sep 2022 04:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663402584; x=1663406184; bh=1xxytf0620
        E/n/S5Ojr6dGHzA3niIQtDL9CbjqVZnY0=; b=eamGSbKh9KybyMHY3JSmdoiuAj
        fOyOw7ZP6T38xrkPtxRe+PUcWg9gUXKFnI1VSdEyU2yfd+ok3t7EkVAOwXpP/FPn
        b8tj5tF/cbqeb0+ul00X/p2UPFJlYKUdwp4JuZUpn3wJRkRwQF+A3MXscrGXPVLE
        C8qrRBBchg/+ujVzUzevgDtBfoA70YhKZSmwA6kqzB0tSicK4D8uNFXy/F+foip9
        K9DxVWACyAK8dOhdXCBh2Tq6+diX7Bugz+HCurbKuPlxvRgLUT9B5YiT81dvqS7S
        B1NYLNtHUbRSHRaiIBGDwkcwwhk/e2QcyfnTujAuM6dS+d8jwQFc31uX01dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663402584; x=1663406184; bh=1xxytf0620E/n/S5Ojr6dGHzA3ni
        IQtDL9CbjqVZnY0=; b=e7jhdtAQJ/5eJYFmJ2mkXAtSYFzYGbf1SdXqfD0OBwlI
        AtaSO/BWOGgoHByKHh7gsNG3vUn2j/GiY97r3B8A8ywRSVErCFC9c1qLedZkL0QD
        Kuqik4rn/9/sSc0jK5iocypfukoHH5DvvKHv3LMaqrcLbiuzDHgnmmp/GNzTxeMG
        NjlSbut2ktoVuDBQfjMRApYn9SwIeRrhlshkZYJYGJXaGweOSMMTcl5r8QVL6uJE
        MNQLsRnn2hYHzWmgX6hR/HXPMzc23UKjFHU5E9hov3Mafj7mphTnEmLaSbGHP097
        glkOyoI14kVFuAutb/C6xsUU7jHw9D/YcK3LzDo8KA==
X-ME-Sender: <xms:V4IlY1ILz7R7lME3Ivs7QgGiAmdxYyxIqGKMKGpBT1CSW9OLkS7oVQ>
    <xme:V4IlYxKa4dNGeBFScLslfy0NJ2WMmMlW9NETUvZsSiGiBIyh2zAyD3A8QYJQmd9Y9
    aJTiZ0rrKRW_PQGTWY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjedugffhgeevlefhledvjedvffetueelteduvdejhffglefgveegfeduieeu
    hfehnecuffhomhgrihhnpehrvghmrghinhhsrdhnvghtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:V4IlY9sdc4PAkAtCU36CdpMxFaetRhBA4xCGN2wEVoTGZ5fRL5CO3w>
    <xmx:V4IlY2bknRl5C0nXWKVq5Nr5nV59-eFYGswZ_6ddbBTtk-vTcwyYig>
    <xmx:V4IlY8anuQGr6lLpYq6ta3E7JLUszyawt40jRrNqZIp7ZVQ1A4nl_A>
    <xmx:WIIlY7mni37dl_MQyhLX1OiAQpZ0JQNVsVqSOy-fRQR8leXIptLYNA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 85750B60086; Sat, 17 Sep 2022 04:16:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <536e1ed3-5d6b-401e-b8b4-888b49aba6df@www.fastmail.com>
In-Reply-To: <202209171512.qcgXdSrG-lkp@intel.com>
References: <202209171512.qcgXdSrG-lkp@intel.com>
Date:   Sat, 17 Sep 2022 10:16:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Karsten Graul" <kgraul@linux.ibm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: net/smc/smc_llc.c:26:2: warning: field  within 'struct smc_llc_hdr' is
 less aligned than 'union smc_llc_hdr::(anonymous at net/smc/smc_llc.c:26:2)'
 and is usually due to 'struct smc_llc_hdr' being packed, which can lead to
 unaligned accesses
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022, at 10:09 AM, kernel test robot wrote:
> Hi Karsten,
>
> FYI, the error/warning still remains.
>

>
>>> net/smc/smc_llc.c:26:2: warning: field  within 'struct smc_llc_hdr' is less aligned than 'union smc_llc_hdr::(anonymous at net/smc/smc_llc.c:26:2)' and is usually due to 'struct smc_llc_hdr' being packed, which can lead to unaligned accesses [-Wunaligned-access]
>            union {
>            ^
>    1 warning generated.
>
>
> vim +26 net/smc/smc_llc.c
>
>     23	
>     24	struct smc_llc_hdr {
>     25		struct smc_wr_rx_hdr common;
>   > 26		union {
>     27			struct {
>     28				u8 length;	/* 44 */
>     29		#if defined(__BIG_ENDIAN_BITFIELD)
>     30				u8 reserved:4,
>     31				   add_link_rej_rsn:4;
>     32	#elif defined(__LITTLE_ENDIAN_BITFIELD)
>     33				u8 add_link_rej_rsn:4,
>     34				   reserved:4;
>     35	#endif
>     36			};
>     37			u16 length_v2;	/* 44 - 8192*/
>     38		};
>     39		u8 flags;
>     40	} __packed;		/* format defined in
>     41				 * IBM Shared Memory Communications Version 2

I think the __packed annotation should be moved to the
length_v2 field instead of the outer struct to resolve that.

    Arnd
