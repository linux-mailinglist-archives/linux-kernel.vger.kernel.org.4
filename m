Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F8C725017
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbjFFWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbjFFWpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:45:52 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9111A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:45:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2A3FB3200999;
        Tue,  6 Jun 2023 18:45:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 18:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1686091547; x=
        1686177947; bh=hSS0JdktrhCdp8+MPFMBImmGxdk+d02HM+d8vXxlhEo=; b=S
        gCU68vnMrvV/FktbEABGRwkdhc+K22LZ62NuJfb0yaYdXZC8mbgsiPGFtM1o6wWe
        sikN62H1vD1EHnOqyh601z93TzED895lAtkM01chCLihO+/ov4iQ0F6dnZ+FS71d
        RALXYm6uyKvWxtyV/M3f4xb/Y4beuYaE+WNdUJaTYutmTUIAXCxP3BFyQlVrAjBc
        MqVGaeSAc8lATYvmy9qKQmRJLIK8HHCTL3qJyPmyv05x8K1Td0rWlRokL5T4SBu7
        myJR68Y7WgSya/P7QuzN5XI087X5RXZ4F1L7bnOHtQieShKzidaTJTdxV+u4G2XE
        gjXVHSx1nSY+ycE0anHdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686091547; x=1686177947; bh=hSS0JdktrhCdp
        8+MPFMBImmGxdk+d02HM+d8vXxlhEo=; b=GarzA6WL88bJIjRe2HI33IfkGitIG
        oKqDvgPW6We9j6fwf5CH2o6wwNBCy+PdfxZuoYwdN+FyGLZ1SC597tXCYEnROGCN
        84mozrjLD52MIwd7qbkXe0WGLBVd66Nx8wY9M5OSvca10cK16Y5vF77040foOOO+
        pY3moTVfbiNQVky2WF7jNbGvxqsLnIe3wuBcRop2dAhqP/5s1OnOdnXGcZBwttNn
        ZVORf7XgySQC5buls7XuCQ1zsPS9QX+J50ye0t0/tVoB9Kp0xgFlFh7UqYF/XWNU
        LFlW+zq8g3ByxQsxG638yICnfqvUMMnToM9ZEyQ1m4Z+AMXUD7yh/pMaQ==
X-ME-Sender: <xms:G7d_ZP1yEjH6oe4muUD0DHLZOC1OJJ3GIWeHYUiQvZrGXyQQuDb2fQ>
    <xme:G7d_ZOFfXCfJWMUBJ5IwpdFBqyBtXK-XtFTlVxF_rUAdnW3OQ9zyrrlnrp4T69-Z9
    X0iyi0DnEhWS-4DT4w>
X-ME-Received: <xmr:G7d_ZP5QRTl2z275bnljb5uhmk7XZ81b7CwRrkTHZhQcltnI-VdMZ6rM0x39VYgsaH6U3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeelgffhfeetlefhveffleevfffgtefffeelfedu
    udfhjeduteeggfeiheefteehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:G7d_ZE0cU9waJJXsLAk3SHmrXBEF9w0ZV_KMDL2hvQfD_SKcdieGbA>
    <xmx:G7d_ZCH_D5TEBQZigZQJb7zFnKCClGyP7RBmNBvNUw7FcqSW7ogCnQ>
    <xmx:G7d_ZF_jWbvhy0ISh8m2BRD84mXfitBmtHRRgRym3vXnvLhUf03hPw>
    <xmx:G7d_ZPNrVrXS9dy8B1cHGzCcUSK8U8msiDHHsucAqW6e01oQCafJqA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 18:45:46 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DAF4710F0D2; Wed,  7 Jun 2023 01:45:43 +0300 (+03)
Date:   Wed, 7 Jun 2023 01:45:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/tdx: Explicitly include <linux/errno.h> in
 <asm/tdx.h>
Message-ID: <20230606224543.a4jex2dmn43dvze4@box.shutemov.name>
References: <20230606034000.380270-1-kai.huang@intel.com>
 <c84707e6-4f74-dc89-6243-63a72e86c62b@linux.intel.com>
 <df89f1c66059e717e9a66e314da24f939cc3eabc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df89f1c66059e717e9a66e314da24f939cc3eabc.camel@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:17:53PM +0000, Huang, Kai wrote:
> On Tue, 2023-06-06 at 06:10 -0700, Sathyanarayanan Kuppuswamy wrote:
> > 
> > On 6/5/23 8:40 PM, Kai Huang wrote:
> > > Currently, in <asm/tdx.h> tdx_kvm_hypercall() simply returns -ENODEV
> > > when TDX guest isn't enabled in the Kconfig w/o having <linux/errno.h>
> > 
> > Maybe you can explicitly say "CONFIG_INTEL_TDX_GUEST is not enabled"
> 
> It also can be disabled by !CONFIG_KVM_GUEST.

Borislav has already fixed it during unaccepted memory patchset
application. He used <asm/errno.h>, not <linux/errno.h>.

See [1] and [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=75d090fd167acab4d7eda7e2b65729e877c0fd64
[2] https://lore.kernel.org/all/20230606161606.GDZH9bxhrGnFkaLl2A@fat_crate.local

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
