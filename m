Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836A66737DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjASMGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjASMGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:06:07 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75289114;
        Thu, 19 Jan 2023 04:06:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B4905C0068;
        Thu, 19 Jan 2023 07:06:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 19 Jan 2023 07:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674129960; x=1674216360; bh=G79ZgDoEhs
        aOdA4/jWWEPcYdJ3ASPN551GkohQhqETg=; b=K6fp0wD67afq94tpgRf7r9QtIE
        fI1DUx3wp2BTV3VMX7xef6Aw3WnurOIIE2J328FJKtUlvwrjN2577w24H4aJnAN8
        DLWRAgw3mV1U58Ef/cKRGCRLsKCKcDXVfmzlSyaEQqmVS8MDr3qg1F5SfTuvEWPN
        3vejKIMBdurXagnEs0fJqo8l/KUXoYNUnrNSMpgcK5ACSKelWhSk/8nLe4k9SjaC
        ljgUcTVdVabquwiCxeT9H5DshjgWA/eH9ShkeQyncG/3AKFx/9x19q3lIa0I6QVg
        I2rbequH2W1jETykerCrhXz3c6L0WzgkI2O0Hnd1ZAXU2o0rrS0S60i/axMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674129960; x=1674216360; bh=G79ZgDoEhsaOdA4/jWWEPcYdJ3AS
        PN551GkohQhqETg=; b=qzFebiLY8baHfXBBGyi/W+qdSc6RbLYRCS0W0oIWmGNz
        mIkUtLiks1XL3OZtHgnORGz+okgt6hZYFLcYrnXqF9noT4T/yKshkHBCkJY7l+x5
        gaHmCHPGp6bd3N/9qpPwoBch+TkAIPVQH+5nIum0C+kDSyGBR9sAaYIBN1Z8XUtr
        XIMFzUPUmDuSblp91UKiGw3ifDgan7szNK6sQLJaZCT5pwqO94/y9nFIpsigoTJX
        Zumk8KRaLP/aLkZQuXikQkfaEv5cWF1PLbJHvz+teLM1pAtB4zoxc/h7dYC91Peb
        r3EBVCpSUx4Pn06QbwNSXlfE8xkU2awNdaT8DAqkIQ==
X-ME-Sender: <xms:JzLJY2ogricfNebkRTtk3SrsGqTGh3YGx1NeC9N3QFVINbCJDz3BRQ>
    <xme:JzLJY0ol8WtIEWdMBGLndheRyyDENMKW1Wb9WvNtGUuaMi-rYh-k7OKFLf_0reIYm
    QxTVu028PZv2Q>
X-ME-Received: <xmr:JzLJY7O0xSBMDGmTYa1tLDEx7h0unDMEm-ZGmDB1nqFRZ4g-S31nFBnjYMh9NoXkrgxubR-OryCpFd8WmTTTD3l2QXL62o5FJh1JMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:JzLJY14ubqi5eDqP-41-BnSS1m9GjRYLDdSxAJUW15rDMfrnX_mqVg>
    <xmx:JzLJY172fTOk0qF1b6fbVdBJtWHIQF2V__V2uGnCF12L4e5npS6Siw>
    <xmx:JzLJY1j2iDv7M2efLAwF5uZy56PGe1ra0FC0JPSh4dNBsHfxddWAFw>
    <xmx:KDLJY0SWy3EfmlMmjGmTjo-OFhLDKJr_HJnhR2AsJPSmqNOGteBsJg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jan 2023 07:05:58 -0500 (EST)
Date:   Thu, 19 Jan 2023 13:05:57 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the usb tree
Message-ID: <Y8kyJcSYW0IOMuzU@kroah.com>
References: <20230119152605.03588e9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119152605.03588e9b@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:26:05PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the tegra tree as a different commit
> (but the same patch):
> 
>   2648f68bd0ac ("dt-bindings: usb: Add NVIDIA Tegra234 XUSB host controller binding")
> 
> this is commit
> 
>   20cdc1607ea0 ("dt-bindings: usb: Add NVIDIA Tegra234 XUSB host controller binding")
> 
> in the tegra tree.

Is that going to be a problem?  Git should handle merging that just
fine, right?

thanks,

greg k-h
