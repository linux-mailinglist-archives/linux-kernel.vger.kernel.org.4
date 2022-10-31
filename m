Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3499612F74
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 05:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJaEND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 00:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJaENC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 00:13:02 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8320E766B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:13:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2969232002E8;
        Mon, 31 Oct 2022 00:12:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 31 Oct 2022 00:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667189576; x=1667275976; bh=Wb
        6JvakTobU0IToKDpm7eHKTZYBSLOu94yzyyjdx7E0=; b=Pirm+uJvHQ6vV7JdAP
        q+gBq/nkrWjhPvN7d8bqjuTZwoEkPZ0kwV0rvHiluMaPxpSgCvYqKWM/LVcW0Dxo
        cVmWO03e5CZzSe5gTvrcYffPPa9PnGYaFtEI4cscRhNbAIWAWdzAh+9+2pYi9jo7
        HPpLVGqh0mJDYpMCiwVDGhDH/0F7xVtuzivYNXnZWy6M5oj79ObxtC0FBvqsoR9X
        VZGlxylgA1iq1wuu7l95RnunCkwoHFDfvy2w0ZPKKZhDgFafP1KsgLoiM+cVixp3
        agquzvIW3yx0UDouQ3ZSLrGm4Pgmfa1FOJmcWmq8td/TdqfUX5VFFm4DDMre6QA+
        IEUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667189576; x=1667275976; bh=Wb6JvakTobU0IToKDpm7eHKTZYBS
        LOu94yzyyjdx7E0=; b=a5OiLouFX3ylKx5tbp2PMGKP9ztB9Yh72UeWfERcvnZE
        3ozmNphgyTgIc5JvqFORWrdIeKODJJ9GND4tLFPR3qbf8mCNov4dwHNKvlwaQrPD
        va6bHpePS9o3unpRpgu4NSB31Qw7ecs3x4zR16Fqbseh3/SrwRd9S1x5C1HRSXX+
        Dnjrr6HygrPJIaFzHu8ePTZo8HuWyuSPxWIm2gVRbK1jhsO1q31aHOgmbZ+j6dVj
        Cy8tvu12kH94QowsKJtT+k8c/3ML+FL58tKbLG/e87d8iv3BkT+IK2Gbvylmz8y+
        HUokmQBbDX20DlVL5aVoyjRfIRDtLRvvK0PxLB2n1w==
X-ME-Sender: <xms:R0tfYwjkTuismYLqzMKAtRbWDm6JfowRr2h_F8FmxXLXWZu8VWUtHA>
    <xme:R0tfY5BjzDmtWVUFNizWVNZCrLKcJGZ_dxCq6IehZ9sQe4XOR0XFdsKnnHwFzlpiy
    fzB_LrLqIGLO6BTIb4>
X-ME-Received: <xmr:R0tfY4Ecmt3ty2aE-AlCqV0sxI0eGQ3cLE5G1dQDIbYc7Iu78jne6qWBw4LvakzHKegxGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedruddugdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnheplefghfefteelhfevffelveffgfetffefleefuddu
    hfejudetgefgieehfeetheejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhes
    shhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:R0tfYxR1CTpEHVtOGhuWJRZw0bE93DhIleKtDNcA-x8R-QWk7Zl93w>
    <xmx:R0tfY9yV6rcRl8uFkqJdcnvtMX4cafWML3PB7E6M3lk1HA-KvRgQHg>
    <xmx:R0tfY_4SPIG8I5VENEWoawGLFfQJw13zk57e12ysj2ee5XK0689kyQ>
    <xmx:SEtfY1Drmw8jc6vuUVuQdFWXB239euQ64XCuV_nb2EM0yyFwiDT0LA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Oct 2022 00:12:55 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B0213109579; Mon, 31 Oct 2022 07:12:52 +0300 (+03)
Date:   Mon, 31 Oct 2022 07:12:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Message-ID: <20221031041252.mdcjocqn6k4k4gvy@box.shutemov.name>
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
 <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
 <20221028235951.p2vdu7drbbf3ccg7@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028235951.p2vdu7drbbf3ccg7@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 02:59:51AM +0300, Kirill A. Shutemov wrote:
> > Can you please take a look through this and make sure I didn't botch
> > anything:
> > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=tdxbadve
> > 
> > The end result is about 50 lines less than what was there before.  Most
> > of it is comment removal but the code is simpler too.
> > 
> > Acks and Tested-by's would be appreciated.

One thing that I must bring up is that it seems that there's no way to get
the panic message to user. I tried to convinced myself that it is qemu
misconfiguration on my part or some race, but no: it is just too early for
earlyprintk.

We only get earlyprintk working after parse_early_options() which happens
well after tdx_early_init().

Moving panic() after earlyprintk working is not good idea as it exposes
kernel more: by the time we already have full #VE handler.

We can move it earlier into decompresser which has different earlyprintk
implementation. Not sure if it worth this. What do you think?

"tdx: Guest detected" printed from the same tdx_early_init() is visible if
boot goes far enough to initialize console (early or not) as printk adds
the message to the buffer, but no so luck for panic().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
