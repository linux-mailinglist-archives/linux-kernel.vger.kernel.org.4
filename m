Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E235F4C50
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJDW7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJDW7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:59:23 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED1D6F559;
        Tue,  4 Oct 2022 15:59:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4D06632001FC;
        Tue,  4 Oct 2022 18:59:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Oct 2022 18:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1664924348; x=1665010748; bh=CC96qaOa/nsq7X964xKP19I/KvoTkXtU5it
        mYL0RO6Y=; b=OOEZBo3ft4jv+W/Kms9V5KAin0giNQxC14PK8kFN+4kJCH7cAdj
        7vAGRbgLl/Vq8yrGPfLpnx+9JlZsuSVo2afKZFp5XVLz/OyuByljGbQn/h4sQeNX
        tYX8ZCRcdzFTeRcXWjSDzkSCbpRrnDQofjRGzPwztr9g7MPNmZPceuSfrC+/VrCD
        RLpAYglJ+kABku/QXJOmrEOofymUKx2h6FXTiY6SJkIHSTUwXAgAOTYriBYpb01d
        VaZP+e/Dt9QKr94OZo0eEohtXrm4rzyp6vg6Mxkw99bgafTOrkhcvEVbEZSXjUSP
        0Nkmi0FrRNQ91oPmSfwQd396tWClncgdIpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664924348; x=1665010748; bh=CC96qaOa/nsq7
        X964xKP19I/KvoTkXtU5itmYL0RO6Y=; b=eZ8Fb/6tbbGKWZEAbVQAC1xBI9/42
        YFF7G6Q7rEzzHmqBldWyC7r+x/H8V0gl/XkX1yrL9Xr2y+V7mITFZ/fFUwcmx8Td
        riAStLrYtZuxOwSjqcA3uyoZRwKV6Rq3q1Foto129j7OOhJVOBeBCTTYXYvPLcXF
        Fb9w+ajKZjvSVcWZ5R/HH0FL8/9J8dQiXkGYsENLRZnS+aL/732HvNuMDD0FOs9y
        ceJcT4rKqdP5WMPaJpcLt3PPP2AJGjByKjN1Z0XbTEBhPi5X2y8NfVFUdNz1kX7h
        ZE5qaj/CYQaZ8BUIUlGJZKWx0k/kWW+0xFlZSHFab12c9rd6VQ4nwHOKA==
X-ME-Sender: <xms:vLo8Y7376UwO-hxZs-_Subch-O2doIjrXtv0kBVSC_mVyc6dk8iKXQ>
    <xme:vLo8Y6EZ_jeu_ZR7LaL9nD5KYuW4Uao2IUuN9s0pt5mTcOGGBWLLu7I53SQOC37l3
    J7zVbnB2aXWbzM>
X-ME-Received: <xmr:vLo8Y77nA1ioiw2-0kLM0q8CbtXNksrdwgbit2wHe50p8Um8Ad-9UIcLGV2XQlHbCVKDcaZ3Evl94yADDN_tzo8z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeivddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvffhvefutgfgsehtkeertddtfeejnecuhfhrohhmpeeuohhrhihs
    uceosghorhihshhpsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfegvdeigfekvdegveeiudeliedtgfejgefflefgvdevleefieek
    gfeljeefkedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghorhihshhpsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:vLo8Yw3M6afQdWzxsUlP-g3eesrGlIgrKaT0Co-GxS_uV5DOoULRxg>
    <xmx:vLo8Y-FTHyodNUW-G26My-OzUKvp-0zd-F2aE4Kk-ZvLDaRDdgLoLw>
    <xmx:vLo8Yx95BQe-2DRMKm9iKvhYpJAbnNYoxO0d7TIvh-GkuyJmMQLnWw>
    <xmx:vLo8Y8Y7lNpccqabuIesjuFr4_Z5ZTOrbARMGuxnpGqbmpnECyifpQ>
Feedback-ID: i21414460:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Oct 2022 18:59:06 -0400 (EDT)
Message-ID: <0d91ac79-6d84-abed-5821-4dbe59fa1a38@invisiblethingslab.com>
Date:   Wed, 5 Oct 2022 00:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Borys <borysp@invisiblethingslab.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?Q?Micha=c5=82_Kowalczyk?= <mkow@invisiblethingslab.com>
Subject: [PATCH] x86/sgx: Add overflow check in sgx_validate_offset_length()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sgx_validate_offset_length() function verifies "offset" and "length"
arguments provided by userspace, but was missing an overflow check on
their addition.
This code was originally introduced in commit c6d26d370767 ("x86/sgx:
Add SGX_IOC_ENCLAVE_ADD_PAGES") and later refactored in commit
dda03e2c331b ("x86/sgx: Create utility to validate user provided offset
and length").

Fixes: c6d26d370767 ("x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES")
Signed-off-by: Borys Popławski <borysp@invisiblethingslab.com>
---
 Applies on top of tip/x86/sgx ee56a283988d739c25d2d00ffb22707cb487ab47

 arch/x86/kernel/cpu/sgx/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index ebe79d60619f..da8b8ea6b063 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -356,6 +356,9 @@ static int sgx_validate_offset_length(struct sgx_encl *encl,
 	if (!length || !IS_ALIGNED(length, PAGE_SIZE))
 		return -EINVAL;
 
+	if (offset + length < offset)
+		return -EINVAL;
+
 	if (offset + length - PAGE_SIZE >= encl->size)
 		return -EINVAL;
 
-- 
2.37.3

