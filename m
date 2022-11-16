Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4787A62B047
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiKPAzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKPAzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:55:37 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80DB31FBC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:55:36 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 46D8D5C012B;
        Tue, 15 Nov 2022 19:55:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 15 Nov 2022 19:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668560133; x=1668646533; bh=Qh
        DC3vubTMLLJXtQAaerSanqb3r7hzP34nANkvJxyO8=; b=FUqjYAcF66Mu1MA/dA
        cvyflZirZ0isF1CzwptnLVJ+iMIZF+SHD8UhG4CjjIJ7XAOLCW+w3nUjbim2TgLW
        tNVUD50WdBe5jkUrVVWx8BHsSWJw7eb5+cEtIYhfO3Qg7642T7V1watQA3VmfQIR
        Za7MKkZFigM125Ig0wjjLQkGOf3m0BYZWeSgyK3NnjzatbojKXn9+h6bYETo5FIE
        25Y+vnz8k2wsBjejCvd0R8/LcW4GBYfFk2kbYZtFiDu/tSUUUNRNO+IDc61g+hWU
        jGbLoh/ufJ2OxJknBy81YPet1cY3Vp2GGopGiTk4OIOOa4luVR1toCnMQSvM32RE
        dnRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668560133; x=1668646533; bh=QhDC3vubTMLLJXtQAaerSanqb3r7
        hzP34nANkvJxyO8=; b=fKq9O/nFkGoDOaCdZJ/yb6ft57hQ1g7/cqKzmqeG/Fc9
        vIyeUMhjoNrcYrgkxUs8vO2fPPs6BdPS2YdNTFW/Ndy4r/pWh8CJFnao89pS1fzc
        2b5Eo4VUN/A9bwJ8+P5rdt35ezn8jVGWc/HyNUiDjCurXiajXiL2B5o94T6SmuBv
        gko3ulSTgF1bkI+mjepzAdj5qa9sqh6erk8yiyr6vgdKPC2BvAZmDsAgYWabYPEY
        +OopqN8Dujsxfb1NgEi9L+ULwrGR5BANeSSDe8BiXBzdwRK0W/uVRnU/ScInfqAi
        QCJMVknn1hkPr/KohEbht6x6j+rxBodVNJpNUyfK4w==
X-ME-Sender: <xms:BDV0Y28ExTVW02DpaBqeHqhX4wxhzkQ7MlLL8Y1zWEVIIq1GRV3zyw>
    <xme:BDV0Y2u5KId5DfB4wfrvncZF1OpT3OqDNCkvipSqahgfKL317My-SxXdSSXuMSrh2
    JCXVzT3VpBtqJJbv4Y>
X-ME-Received: <xmr:BDV0Y8Bs8dJN6b1hQvhEBzgbIKf87GUtrFxOgdJYmKQ7bqF-BLMJYWxEEOYM1UR6Zb7BnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpehkihhrihhl
    lhesshhhuhhtvghmohhvrdhnrghmvgenucggtffrrghtthgvrhhnpeehleevveejudejke
    evueevteevfffhkeejgfehleethefhueejvdehieejgffhhfenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmoh
    hvrdhnrghmvg
X-ME-Proxy: <xmx:BTV0Y-c5Y77TYtg98kVi0O4rXlkdRRg43iNZAt_QR3nf1Cm2Y3YQIQ>
    <xmx:BTV0Y7P1fCUQk2E1-sflwDoQAJNB7z-gERYIyth3eMlUo54GUZ15ng>
    <xmx:BTV0Y4kL3najpUR2Lrr1H5pegHjs4SmtKhlDF1yMu4f05MDDCZv-Fw>
    <xmx:BTV0Y2d0r7mdICZ7U_CLHwrDw-5YgUwdKtBZ1Dm4-fLJv9_eL-C4Iw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 19:55:32 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 10F0A10446E; Wed, 16 Nov 2022 03:55:29 +0300 (+03)
Date:   Wed, 16 Nov 2022 03:55:29 +0300
From:   kirill@shutemov.name
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        dave.hansen@linux.intel.com, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        martin.petersen@oracle.com, oe-kbuild-all@lists.linux.dev,
        x86@kernel.org
Subject: Re: [PATCH 1/2] scsi: Fix get_user() in call sg_scsi_ioctl()
Message-ID: <20221116005529.uh4uol2qgcfnkfma@box.shutemov.name>
References: <20221115155802.p3vjnk7eqqcyskt3@box.shutemov.name>
 <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
 <20221116004353.15052-2-kirill.shutemov@linux.intel.com>
 <9c96f82e-000b-88f8-fa37-753ed6723119@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c96f82e-000b-88f8-fa37-753ed6723119@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 04:48:40PM -0800, Dave Hansen wrote:
> On 11/15/22 16:43, Kirill A. Shutemov wrote:
> > get_user() expects the pointer to be pointer-to-simple-variable type,
> > but sic->data is array of 'unsigned char'. It violates get_user()
> > contracts.
> > 
> > Cast it explicitly to 'unsigned char __user *'. It matches current
> > behaviour.
> > 
> > This is preparation for fixing sparse warnings caused by Linear Address
> > Masking patchset.
> 
> What's the side-effect if this isn't applied?  Is it worse than sparse
> warnings?

Build will fail if 2/2 applied without this one:

arch/x86/include/asm/uaccess.h:46:9: error: cast specifies array type

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
