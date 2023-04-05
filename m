Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C416D8686
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjDETGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjDETGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:06:48 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158412724
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:06:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A76A5C0117;
        Wed,  5 Apr 2023 15:06:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 15:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680721603; x=
        1680808003; bh=F/RoPbcbjQX3HE6jsn5qyX/YSeXkTrEhyt9jGNKrlOo=; b=f
        YjhjRSdya8q8TE6XuG/6Au+MOYVtSsLEvByXLhVdqV2ME1iwvYVSqTUV8X14Y1ku
        hgbGsuEUP/7AACrbkOGdDes091KhreG2YOVFb+dJeDBXXxAu+jMhezpGObU8Y4MI
        DmKYLBRwMcJ7yFZY1M6/hqK9ngvMe506zu1wPKNr/VUmog41OnhoEsV8UtXsQnUe
        kKS9ojfT1wCgMAMbWcA96o3jDvkU78ybLv43Anem55lM56D5wINAC4mjaKfhsfn7
        VR58ueDQeVzarXJtT9niodVSkxXXndx4SP6kG24sjfnMFk47vDAErqoGdjI2cH94
        w2b0t17tWcbZidaU2FfiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680721603; x=1680808003; bh=F/RoPbcbjQX3H
        E6jsn5qyX/YSeXkTrEhyt9jGNKrlOo=; b=oxmmX1Vh4iQoQIL/uxCZLHo1t3s5H
        KE5jLAAM+Db/e+WthY/Pl2HS/wiNsDeQ+tiIx4DStcIE4Rf+qokn3bjm4CBDTR3m
        UuHV2Inje7IVgBwaF1XewDCQRmADN6nQFcqbGAMdLflBrJVL7q2BX14M1HPdgk2M
        +T+S024gBuecNx9CfJora0JD9bE2Jk6FZqdBsxMgK/r3C19iCq715puqBgSEj4+E
        YZ519xmfp0Vi4WmCVxw8oUH/DiKSjfmDkzwaUmTTLhNfN4TeXSvMSoKl99HtQWEr
        KNzpeWgDl+M0ebgNrLVqtB8oVWUkKfCAcEGOcdQNqoLKLfSY0IFhuCz+A==
X-ME-Sender: <xms:wsYtZPcrpHhVYNUVW8fpvDsbFWhyJuBHD2tuLkxaDBUA_fgwDWQ3Mg>
    <xme:wsYtZFO-EN8-ejSJ5Nkv1tiIDaQUA0l6ABBzuPcpqHC-yIzkXqNoM8PzfAanUhT43
    uN20UJegxt_UfPTgv8>
X-ME-Received: <xmr:wsYtZIjzA2vHHmtnto5X_sVVEgrSaW84gDLYOdOyuxsVBq5ekQU_hl2V72xeJJBVViqabQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:wsYtZA9NvtPJYVbpUbUDxTU8weev6pg3R6uHxkOJQfFO9YkCpgTd6Q>
    <xmx:wsYtZLsNWmlLe15Ay5tZLMuwRg_u9oaSZVYy7eSdPwK86PaSViJRxA>
    <xmx:wsYtZPF2-BbUHLEq8H_72y3JrcFqh2jZl7ABIbK-cOk-_nDCgSHBJw>
    <xmx:w8YtZHSmjxKqGigFa1dbce09Tf9mSfwbDMy3egoHiU_JPKx2zzdrXQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 15:06:41 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 26C7B102846; Wed,  5 Apr 2023 22:06:36 +0300 (+03)
Date:   Wed, 5 Apr 2023 22:06:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Min M. Xu" <min.m.xu@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jiewen Yao <jiewen.yao@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v7 6/6] x86/efi: Safely enable unaccepted memory in UEFI
Message-ID: <20230405190636.4mrq2daz6a23yhvr@box.shutemov.name>
References: <bc9e6d82-c7c1-47dc-e91f-57d9b4e2bb0a@intel.com>
 <20230404180917.4fsgkzcdhqvph6io@box.shutemov.name>
 <CAMj1kXF0XyEOuSUDqgsLSYK8GSkGN1xK3RQ525+BxhG+7+vnCA@mail.gmail.com>
 <20230404202445.6qkl7hz67qgievqz@box.shutemov.name>
 <CAMj1kXFrm74+zNcSpHJ1kw38PTMOFk1cTx_EAoGFHaG1fYzRTQ@mail.gmail.com>
 <20230404210153.tll2mojlglx4rfsa@box.shutemov.name>
 <CAMj1kXGvcg-E84h1T_vPi7qxPWxEXBpyuB79KOL+ON7v5YAgJg@mail.gmail.com>
 <e46777d3-adea-90a2-afc4-35f9d7cef50c@intel.com>
 <CAMj1kXEDYa5YcRj7t9JJmQ21+ierue2q6ADOXUOMjoOGndGRug@mail.gmail.com>
 <969a3d2a-52e7-e60e-5de6-c550c548730d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969a3d2a-52e7-e60e-5de6-c550c548730d@intel.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 09:15:15AM -0700, Dave Hansen wrote:
> On 4/5/23 06:44, Ard Biesheuvel wrote:
> > Given that the intent here is to retain compatibility with
> > unenlightened workloads (i.e., which do not upgrade their kernels), I
> > think it is perfectly reasonable to drop this from mainline at some
> > point.
> 
> OK, so there are three firmware types that matter:
> 
> 1. Today's SEV-SNP deployed firmware.
> 2. Near future SEV-SNP firmware that exposes the new ExitBootServices()
>    protocol that allows guests that speak the protocol to boot faster
>    by participating in the unaccepted memory dance.
> 3. Far future firmware that doesn't have the ExitBootServices() protocol
> 
> There are also three kernel types:
> 1. Old kernels with zero unaccepted memory support: no
>    ExitBootServices() protocol support and no hypercalls to accept pages
> 2. Kernels that can accept pages and twiddle the ExitBootServices() flag
> 3. Future kernels that can accept pages, but have had ExitBootServices()
>    support removed.
> 
> That leads to nine possible mix-and-match firmware/kernel combos.  I'm
> personally assuming that folks are going to *try* to run with all of
> these combos and will send us kernel folks bug reports if they see
> regressions.  Let's just enumerate all of them and their implications
> before we go consult our crystal balls about what folks will actually do
> in the future.
> 
> So, here we go:
> 
>               |                   Kernel                   |
>               |                                            |
>               | Unenlightened | Enlightened | Dropped UEFI |
> Firmware      |     ~5.19??   |    ~6.4??   | protocol     |
>               |---------------+-------------+--------------|
> Deployed      |   Slow boot   |  Slow boot  |  Slow boot   |
> Near future   |   Slow boot   |  Fast boot  |  Slow boot   |
> Far future    |   Crashes??   |  Fast Boot  |  Fast boot   |
> 
> I hope I got that all right.
> 
> The thing that worries me is the "Near future firmware" where someone
> runs a ~6.4 kernel and has a fast boot experience.  They upgrade to a
> newer, "dropped protocol" kernel and their boot gets slower.
> 
> I'm also a little fuzzy about what an ancient enlightened kernel would
> do on a "far future" firmware that requires unaccepted memory support.
> I _think_ those kernels would hit some unaccepted memory, and
> #VC/#VE/#whatever and die.  Is that right, or is there some fallback there?

The far future firmware in this scheme would expose unaccepted memory in
EFI memory map without need of kernel to declare unaccepted memory
support. The unenlightened kernel in this case will not be able to use the
memory and consider it reserved. Only memory accepted by firmware will be
accessible. Depending on how much memory firmware would pre-accept it can
be OOM, but more likely it will boot fine with the fraction of memory
usable.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
