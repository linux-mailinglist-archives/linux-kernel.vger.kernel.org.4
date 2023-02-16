Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83544699BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjBPSMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBPSMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:12:39 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CBE505EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:12:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E4A35C010D;
        Thu, 16 Feb 2023 13:12:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 Feb 2023 13:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676571155; x=1676657555; bh=bS
        ftew9gDz0nxHH+J/ZHM8BKvNdoOfwEqV6015Wt6UM=; b=U5UKHZUQDc1987amT/
        6c7+8Je0d8GW+Gf4YZipuK0UHqck2Q4Nw9wZo/0HXhJle83a27m0dKX4gOUipn/Y
        19BNTRmwdflnQ+gJnyZuu3CjUeLIdVBenCyn4qpN8cTIj9X5X4NxUtFVIkKwwvOf
        xU9cF4WdzSgiT2oPJa4pnYANuGCmdhu3uSEqDWw23UsA/rEJ8YkBu8GRdwJBzTSj
        kRk6QOT0rUUGfSird8dvn7MJxpQ/iGRAooiCnVjX+A+EubadC1DBGfgj4muoD/Db
        wPRZyl6vyI5ba3pSTUVPx3/G5m1epxKjDUjxI4ZfvkRvKZKyk80tMo0QAtN5i4n8
        4oMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676571155; x=1676657555; bh=bSftew9gDz0nxHH+J/ZHM8BKvNdo
        OfwEqV6015Wt6UM=; b=Ho955abK3qFL6x04/8LI7suHmH9zzr19Bnf5ALDQsSbv
        MzkIQXKf54e/1yiNW7QbqvcLPJHGZ91Q439eWrkDmK7neRquyWiabXsnF03y3kmW
        hLyQympzdXeJSRKr3/HLT2D1c6s3Anpp5L9IemqBs1bd3SqKOhVQQMJSApmPZ3/9
        Hf+AUrmWWB1nkA2BFBgG9B1ieRL34RoVpBm2+jK1e0v+8p70ZSTlgMuQIL6DcAaL
        9X2pvATHQnBjt90mDLdGmi0Qq++xJrGyDhyf1WDvKK+DPYxnNfrKcoT+rlejt0z+
        rsZ/kfR5XwcrKM+39lAjURnf+0/W3HJ3gYrzo3+S2w==
X-ME-Sender: <xms:EnLuY559I808bVSgLnAVcgGda9J0JuKDqXPqN1UeSKY2msP9CD35dQ>
    <xme:EnLuY26MllRHNLn5nZNAk5YdlLPIKqSacUHL-cEzgTjmez8Z5RfAxXhiaw2LGed1R
    Fl3HilEzkDb94zagb8>
X-ME-Received: <xmr:EnLuYwf3DBc07x7gYwxeTlPgIVbKtKVKU7faZjXO2tfeXVyVOm5p3O4k5zg7AVVs9jW_-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:EnLuYyLkzIfUk2BTS24GveS4bqgd-S6FyXnAYRvK6M4OKHRKLEgF0g>
    <xmx:EnLuY9Jyz-4x5BdbtIT8aRIuFXZmiT2MSe_SK-X1Ypa6hDfXk1uD5g>
    <xmx:EnLuY7wr-4VBeYZ4QVmf1WrR-O86mvd1e8POtbrBdCvgHtE44N1EIQ>
    <xmx:E3LuY0-vE7s97im3M9fHEI1v4JUsa5g3Zuh-Srhg63_CiARFx0AJTw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Feb 2023 13:12:34 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3D2E110968A; Thu, 16 Feb 2023 21:12:30 +0300 (+03)
Date:   Thu, 16 Feb 2023 21:12:30 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Kexec enabling in TDX guest
Message-ID: <20230216181230.3jn5hebv3xkdivbx@box.shutemov.name>
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <65fc95bb-5ad9-b589-d6a4-762289b3f6bc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fc95bb-5ad9-b589-d6a4-762289b3f6bc@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 09:50:32AM -0800, Dave Hansen wrote:
> On 2/13/23 15:48, Kirill A. Shutemov wrote:
> > The patch brings basic enabling of kexec in TDX guests.
> > 
> > By "basic enabling" I mean, kexec in the guests with a single CPU.
> > TDX guests use ACPI MADT MPWK to bring up secondary CPUs. The mechanism
> > doesn't allow to put a CPU back offline if it has woken up.
> > 
> > We are looking into this, but it might take time.
> 
> This is simple enough.  But, nobody will _actually_ use this code as-is,
> right?  What's the point of applying it now?

Why nobody? Single CPU VMs are not that uncommon.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
