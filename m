Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66976D6AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjDDRpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjDDRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:45:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0C6E5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:45:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 204353200A04;
        Tue,  4 Apr 2023 13:45:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Apr 2023 13:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680630310; x=
        1680716710; bh=2+mKOd/D+OGq/iB3bIRF165wax6xoNQdOA3L1ENc7Vg=; b=G
        R5SQwiLhvoMF/3kzl4ZZfUdv4+NGH5D+c510pmAmxn3aMNsavOjGAb0d4iGhhAya
        vQm3HPqYw+g6WlVxQU7nVfzah7eNs7p7YtCM2SwsV35n1x0ajX2rjSYyjCIFHTNh
        34sC6vr+8THvQvsaSmHAi4KbPFCcADy4wcY9rtYpdrct7M1ehJzgbi1WPLDRYZJG
        ecpjjkpwv2A7gW8RucjWEDSP3Sds/FlbN68p/L1qbdaaY/PRKGTRj2l8FfpbCqiY
        +HIhfW18mcpEHfloY0XDkM490r3XCmuoa2jchdD1KQHHdhtbCXpg3vdtN68vpuaN
        SIWuYW5RgzSBhYRdnnHmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680630310; x=1680716710; bh=2+mKOd/D+OGq/
        iB3bIRF165wax6xoNQdOA3L1ENc7Vg=; b=oSA9VAWYV7eDP4vevZajABFjzprAf
        FbhiJaqOxTFIOwmX8RhcHbPfS85x8xmASoe0969MwKHN2ctH5mJGtfPCdFji5ltP
        Jgv2tUJqzRKVquqGncYU8W7sMXsw6YwZ8PSS2TuBtLB1scEZEs67qfRu66Bz0E+q
        Uh/BXIBXFouEv/AD3pQ2rdiyIjdYU9kA+b5YFYvPAiPHBh00LVtyepWpKeajP6T8
        gOq7+yXOxCwqVQAoBAmDubXR5Gw/Z7qxPyFgG2yUb4/S0AIGPlIpARajMLFCzeMr
        WHH/x+8UforfBvugkFOu1930LlQpcZzjzSSk0vKZFEic6mAFbUCquXCKA==
X-ME-Sender: <xms:JWIsZO-ahClJfl2orCydWEhh-9A5iE72V7oackIg8Tm6gsVvm19-dg>
    <xme:JWIsZOvN8i45LK3UTMDa_lX-OxW0SXhGTZ1WPCTpyVcnuc-oGZ0CUc9c4hVp3oOXu
    0v-9kI5-latGTYiNXA>
X-ME-Received: <xmr:JWIsZEAnZ7jfLf-i6GXxaZxezWPUXT_Ujmx7EpJJgBxpjgVH-nqkg2gdJGqzrezNYthvpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:JWIsZGeiEiU-5J7ZOuLO6syVCFpx4C8HHhA3JS8fGJwRMY0sTg4TqQ>
    <xmx:JWIsZDN0D8z6hEaPSlHk3UWy5G74eKdxHxW2aFhApr0bp7T47eYfYQ>
    <xmx:JWIsZAno5J6FGsrkJUnvQs-LW5-sR6oguPt4HTzEiGZr8NkU4m0xkg>
    <xmx:JmIsZOHxv6vBCHuHGcpOywDuODbGc7aZ6FXu1yMPgdewkt3nENkwBA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 13:45:09 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 7330C10C775; Tue,  4 Apr 2023 20:45:06 +0300 (+03)
Date:   Tue, 4 Apr 2023 20:45:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biescheuvel <ardb@kernel.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230404174506.pjdikxvk2fsyy4au@box.shutemov.name>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <cover.1680628986.git.thomas.lendacky@amd.com>
 <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d38d28c2731075d66ac65b56b813a138900f638.1680628986.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:23:06PM -0500, Tom Lendacky wrote:
> From: Dionna Glaze <dionnaglaze@google.com>
> 
> The UEFI v2.9 specification includes a new memory type to be used in
> environments where the OS must accept memory that is provided from its
> host. Before the introduction of this memory type, all memory was
> accepted eagerly in the firmware. In order for the firmware to safely
> stop accepting memory on the OS's behalf, the OS must affirmatively
> indicate support to the firmware. This is only a problem for AMD
> SEV-SNP, since Linux has had support for it since 5.19. The other
> technology that can make use of unaccepted memory, Intel TDX, does not
> yet have Linux support, so it can strictly require unaccepted memory
> support as a dependency of CONFIG_TDX and not require communication with
> the firmware.
> 
> Enabling unaccepted memory requires calling a 0-argument enablement
> protocol before ExitBootServices. This call is only made if the kernel
> is compiled with UNACCEPTED_MEMORY=y
> 
> This protocol will be removed after the end of life of the first LTS
> that includes it, in order to give firmware implementations an
> expiration date for it. When the protocol is removed, firmware will
> strictly infer that a SEV-SNP VM is running an OS that supports the
> unaccepted memory type. At the earliest convenience, when unaccepted
> memory support is added to Linux, SEV-SNP may take strict dependence in
> it. After the firmware removes support for the protocol, this patch
> should be reverted.
> 
>   [tl: address some checkscript warnings]
> 
> Cc: Ard Biescheuvel <ardb@kernel.org>
> Cc: "Min M. Xu" <min.m.xu@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Jiewen Yao <jiewen.yao@intel.com>
> Cc: Erdem Aktas <erdemaktas@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

I still think it is a bad idea.

As I asked before, please include my

Nacked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

into the patch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
