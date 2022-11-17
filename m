Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB362CF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiKQADv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiKQADn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:03:43 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE206459
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:03:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 65B5632009ED;
        Wed, 16 Nov 2022 19:03:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 16 Nov 2022 19:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668643413; x=1668729813; bh=fA
        1G1agOd4tHqccYBlA7Bq+qNCuLfCAeIRRO5CED94M=; b=IHE7vFF6zvU/JEka24
        FhOIlZlJ+5dsXnFUePG0scfb59SUKZvHrXHQLoMJrew8Bv9yPQkpheeWuKAdqjtz
        w3owWzQIKLTIzz8VWoZvVqb/YvRC5+mfeXNJEqs9w/H3RMA3fst1EKtUwiUCwI0+
        KGt2iZOlI21YG40AIIlVoY+n3LeJLyjq3SNE6CZe52J9eDHwEKerVbfFI6sO8s+i
        mESJLzTrUkfpBLutF7UAezepdmNfvTPJ1cxkYKeWFFmzzgZbdWq8/odYH4GyhhFp
        e5+Dp0uRBlEy1kmTSLN3HhrSfG2MHVP9fMUG2SoOoQigqf2lp6eFFK3bPI8S8a1E
        OITA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668643413; x=1668729813; bh=fA1G1agOd4tHqccYBlA7Bq+qNCuL
        fCAeIRRO5CED94M=; b=apCfJsKWe7QbiFHkpkjdleY5YhwuSTIvDQYK6GcQBRsS
        fpCaDDfi/eEVBAzAk7OQKJzGNM3MZ1lDVbUCK1AyCrmMyiIg0dLMPZhNDRFa7khi
        OJdGQlfFRzf0s/cov01mzV6TttUkV/26QFXCyMnjZwA5ExoUu5ITfM8vVUY6dvfg
        R3hSlveaEeLL3I3P6xeb1MTMqxadTygho9YhcnSLo7hZ1zuPhIRnPxgCmrMNFYtj
        VbSyfiEm4rTalRs5JfS34/FUrxGkszsmdgRx1w5T68PmJZgFCYjKyOTWjgkz7k5W
        B+6OeQzAFslNbco7LWxAsO+UlWU9WSr2RJre/zRSzQ==
X-ME-Sender: <xms:U3p1Y6xZyLnuHfrXSDfrJOtnPnW0-C3HnGy2NmRRssC6rut_wE5l3w>
    <xme:U3p1Y2TSZDWhRZCmeakpILl84SPKLGk2t2paO2AbFdmkkFIX7WmYsTs6s7MW-NE5i
    8OanoJbHUzUdqPnz2w>
X-ME-Received: <xmr:U3p1Y8XEg_QkSyzAT1_WiCpOuNY76XmLB9Zgvb7ujC0Cfucvm5dFCYjsXwTYdGRhv-JYkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfkhhirhhi
    lhhlsehshhhuthgvmhhovhdrnhgrmhgvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvdejhfegffetveevieevhfeuuefhleelteei
    ueffledtteeuveetfeeuheethffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:VHp1YwgyY_93uxFzRkexXe-0NmeHIvIfkr8hQMmgq_pGEke8MK_AoA>
    <xmx:VHp1Y8BB0yf7ruwGylZBM2Jqd4mjUUvxCNl_whfrapb6i8RQbg1iIA>
    <xmx:VHp1YxIb7F9tKJ8FBFXng7uOZ1k-zbqBbkwOYS9b_4zuBR3Krzvt2w>
    <xmx:VXp1Y41o8V3nLiKnXgYrRhNcSwqGHemvtLrP98-P57Po08ZEqt0qag>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Nov 2022 19:03:31 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 15A93109702; Thu, 17 Nov 2022 03:03:30 +0300 (+03)
Date:   Thu, 17 Nov 2022 03:03:30 +0300
From:   "kirill@shutemov.name" <kirill@shutemov.name>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/2] scsi: Fix get_user() in call sg_scsi_ioctl()
Message-ID: <20221117000330.up7qwxjnrtb3u2ll@box.shutemov.name>
References: <20221115155802.p3vjnk7eqqcyskt3@box.shutemov.name>
 <20221116004353.15052-1-kirill.shutemov@linux.intel.com>
 <20221116004353.15052-2-kirill.shutemov@linux.intel.com>
 <9d59ec367e0445028775d304bcf64704@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d59ec367e0445028775d304bcf64704@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:40:09PM +0000, David Laight wrote:
> From: Kirill A. Shutemov
> > Sent: 16 November 2022 00:44
> > 
> > get_user() expects the pointer to be pointer-to-simple-variable type,
> > but sic->data is array of 'unsigned char'. It violates get_user()
> > contracts.
> > 
> > Cast it explicitly to 'unsigned char __user *'. It matches current
> > behaviour.
> > 
> > This is preparation for fixing sparse warnings caused by Linear Address
> > Masking patchset.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> > Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> > ---
> >  drivers/scsi/scsi_ioctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
> > index 2d20da55fb64..72b3ab5137b8 100644
> > --- a/drivers/scsi/scsi_ioctl.c
> > +++ b/drivers/scsi/scsi_ioctl.c
> > @@ -519,7 +519,7 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
> >  		return -EFAULT;
> >  	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
> >  		return -EINVAL;
> > -	if (get_user(opcode, sic->data))
> > +	if (get_user(opcode, (unsigned char __user *)sic->data))
> 
> Using &sic->data[0] should work and is much nicer than the cast.

Okay. Fair enough. Adjusted patch is below.

From 86baed963c9295c067940479ab0f844c3644e1c9 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 16 Nov 2022 03:22:28 +0300
Subject: [PATCHv2 1/2] scsi: Fix get_user() in call sg_scsi_ioctl()

get_user() expects the pointer to be pointer-to-simple-variable type,
but sic->data is array of 'unsigned char'. It violates get_user()
contracts.

Explicitly take pointer to the first element of the array. It matches
current behaviour.

This is preparation for fixing sparse warnings caused by Linear Address
Masking patchset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
---
 drivers/scsi/scsi_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 2d20da55fb64..fdd47565a311 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -519,7 +519,7 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
 		return -EFAULT;
 	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
 		return -EINVAL;
-	if (get_user(opcode, sic->data))
+	if (get_user(opcode, &sic->data[0]))
 		return -EFAULT;
 
 	bytes = max(in_len, out_len);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
