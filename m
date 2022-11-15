Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82436290EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiKODkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiKODkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:40:16 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA8A19D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 19:40:14 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C0A25C020F;
        Mon, 14 Nov 2022 22:40:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 14 Nov 2022 22:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668483611; x=1668570011; bh=9P
        VrHPKYYcYCXrIE3gNrsDWA5311mFLsY2+fOAxWt74=; b=jap4O8bsxOdwVziKSk
        Xg4v+xdttQQvTus3LhaHf4KBHJPF7+5mMW70hfwMXhVrtOGEfC9dgnLhiinBBpYo
        foNAhWxded8jDuyWS5sFVcKxnh6Y9jdhA5qojO9+uuF7+uW4I2L63aaMT0fPJVDm
        rHBKLT4WFm86bTPyIXL5tTWb2eJ3Uiw/w9+SFV8bstGKZ8zUhR+1Nd8+4CacbmBg
        Jy6GLye3dOi3NnKsh9mzR4R8wcdP3U9vVI0I4hKv95ACaZSvp0cIDFZ8D4dEkIKE
        ZGsTwWYIxNcvOa1x5qwtFd/oq2BTtmCWL2gzwDdwuT5Ywz9NwjrTKwdzS+Ov4Nr/
        20hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668483611; x=1668570011; bh=9PVrHPKYYcYCXrIE3gNrsDWA5311
        mFLsY2+fOAxWt74=; b=vK0fJhHpZdINnyoLcZHEemLH59mzDRZvAOhLgiRV+9O5
        OpKDm3ZWFVOQe4EA+eQgj1JVgl3EE3t3GzQrEsK7u/8M7shGFusRU1X6sGbnKsFS
        6IvyE0EF0BZbGehvWsRmSC7aPnZYcfOWiDSxkIEQJfSPQC7YwZkL4shwD5YlhBT1
        GUF9qcu6MnrrG8skIn9ZUooDsyEoDBsJKWvaqfPobSs29VLFuMENKJuEuJj7a2Rs
        UGaYz05VzksrdJNREFzP9TYddjBiIcC0ib1oiSdkwz/D0MFA5vSFUa1dTXUpXF+E
        VaVNWobBo1socU4n23EgjweNBy9UEsgRuO+mSy8LZg==
X-ME-Sender: <xms:GwpzYzwpszokUsCpkUFEBYyDNonlCmltcxsllU8oNI4nq0IWYarByQ>
    <xme:GwpzY7SSmkgxjEbAJYLYhUqXhA6kfzH4nA34BCJInSTe4hiLRfCzv8kFPaeYdzUnm
    RabGDvxUf3GAnLyQrk>
X-ME-Received: <xmr:GwpzY9WG7hZ69EZX2K8jtItx07ZWfwyeHuLsPcjImoYsYcJlT4a1gIs7y5bxrepbJSL5MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeefgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:GwpzY9gy8ldFsBNYM5rPe2VET8mDUMJ6EBefdF2M9jiwnFoClFOEcw>
    <xmx:GwpzY1B6MXdn1b_ehbnqWxR8p_j10Jj3c8G5npBnwlBCbz6eSiTZAQ>
    <xmx:GwpzY2KQm9ZbPs5dhoAy1-zW3RQA8dnKMktugtgIbN9a9RhuoMJ_lg>
    <xmx:GwpzY_AxXpB8NuWUJ84EsTXdB3IRyGjMfk9ge8P1jWV2ULHp9ymy7g>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 22:40:10 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4E503109875; Tue, 15 Nov 2022 06:40:07 +0300 (+03)
Date:   Tue, 15 Nov 2022 06:40:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [tip:x86/mm 5/16] sound/core/hwdep.c:243:24: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <20221115034007.go64rirsoqazpks7@box.shutemov.name>
References: <202211150551.T7mpZomP-lkp@intel.com>
 <fdae3de9-db03-b04d-1992-bc8efd053053@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdae3de9-db03-b04d-1992-bc8efd053053@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 02:55:46PM -0800, Dave Hansen wrote:
> On 11/14/22 13:41, kernel test robot wrote:
> >    sound/core/hwdep.c:243:24: sparse:     expected int [noderef] __user *__ptr_clean
> >    sound/core/hwdep.c:243:24: sparse:     got int *
> >    sound/core/hwdep.c:273:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
> >    sound/core/hwdep.c:273:29: sparse:     expected int [noderef] __user *__ptr_clean
> >    sound/core/hwdep.c:273:29: sparse:     got int *
> >    sound/core/hwdep.c:292:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
> >    sound/core/hwdep.c:292:29: sparse:     expected int [noderef] __user *__ptr_clean
> >    sound/core/hwdep.c:292:29: sparse:     got int *
> 
> I think the sparse ends up throwing away all of its annotations once it
> dereferences a pointer.  So, '*(int __user *)' boils down to a plain
> 'int'.  Confusingly, a '*(int __user *) *' boils down to an 'int *'.
> 
> That's what happened here.  A __user-annotated point got dereferenced
> down to an 'int' and then turned into a pointer again.
> 
> I think the trick in this case is to avoid dereferencing the pointer too
> early by just moving the dereference outside of the casting, like the
> attached patch.  But, it also feels kinda wrong.  I'd love a second
> opinion on this one.
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 0db6f5451854..b8947b623c72 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -39,7 +39,7 @@ static inline bool pagefault_disabled(void);
>  #define untagged_ptr(mm, ptr)	({					\
>  	u64 __ptrval = (__force u64)(ptr);				\
>  	__ptrval = untagged_addr(mm, __ptrval);				\
> -	(__force __typeof__(*(ptr)) *)__ptrval;				\
> +	*(__force __typeof__((ptr)) *)__ptrval;				\

It casts __ptrval to pointer to pointer and then dereferences it, so it
gives a new value on the output. It breaks boot for me.

We can drop all '*' here and get:

	(__force __typeof__(ptr))__ptrval;				\

It helps with sparse and streamlines the code. But it uncovers error in
sg_scsi_ioctl():

	error: cast specifies array type

The line that triggers the error is:

	if (get_user(opcode, sic->data))

'sic->data' is an array. And it breaks get_user() contract:

 * @ptr must have pointer-to-simple-variable type, and the result of
 * dereferencing @ptr must be assignable to @x without a cast.

Array is not pointer-to-simple-variable type. Let's cast it explicitly to
(char __user *). It should match the current behaviour. But double check
would be nice.

With sg_scsi_ioctl() fixed, it builds and boots fine for me.

I also looked again at get_user() and put_user() and I think we can
simplify them. The variable just adds noise.

The change below helps with the sparse complains. I didn't checked all of
them, but what check looks good.

If it looks okay, I will prepare 3 patches: scsi fix, sparse fix,
get/put_user() cleanup.

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1d2c79246681..bd92e1ee1c1a 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -43,7 +43,7 @@ DECLARE_STATIC_KEY_FALSE(tagged_addr_key);
 #define untagged_ptr(mm, ptr)	({					\
 	u64 __ptrval = (__force u64)(ptr);				\
 	__ptrval = untagged_addr(mm, __ptrval);				\
-	(__force __typeof__(*(ptr)) *)__ptrval;				\
+	(__force __typeof__(ptr))__ptrval;				\
 })
 #else
 #define untagged_addr(mm, addr)	(addr)
@@ -158,10 +158,8 @@ extern int __get_user_bad(void);
  */
 #define get_user(x,ptr)							\
 ({									\
-	__typeof__(*(ptr)) __user *__ptr_clean;				\
-	__ptr_clean = untagged_ptr(current->mm, ptr);			\
 	might_fault();							\
-	do_get_user_call(get_user,x,__ptr_clean);			\
+	do_get_user_call(get_user,x,untagged_ptr(current->mm, ptr));	\
 })
 
 /**
@@ -263,10 +261,8 @@ extern void __put_user_nocheck_8(void);
  * Return: zero on success, or -EFAULT on error.
  */
 #define put_user(x, ptr) ({						\
-	__typeof__(*(ptr)) __user *__ptr_clean;				\
-	__ptr_clean = untagged_ptr(current->mm, ptr);			\
 	might_fault();							\
-	do_put_user_call(put_user,x,__ptr_clean);			\
+	do_put_user_call(put_user,x,untagged_ptr(current->mm, ptr));	\
 })
 
 /**
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index 2d20da55fb64..c285502f5993 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -519,7 +519,7 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
 		return -EFAULT;
 	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
 		return -EINVAL;
-	if (get_user(opcode, sic->data))
+	if (get_user(opcode, (char __user *)sic->data))
 		return -EFAULT;
 
 	bytes = max(in_len, out_len);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
