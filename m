Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851B063A434
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiK1JHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiK1JGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:06:55 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1FE18390;
        Mon, 28 Nov 2022 01:06:51 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 742935C00D8;
        Mon, 28 Nov 2022 04:06:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 28 Nov 2022 04:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1669626409; x=1669712809; bh=kr
        fSa4bc8ipNX+QkbBzdZ+8Y7nQovRdn0CO1SuGs+Js=; b=a8Ikv9fjtE2DqYh8ZO
        h+3wxnxoz0UrNDUFsxR/b3JKpel/sw+APTOynRYfQ5R2aDwOrr1f2Q7/3wUo2FPn
        YMTCaPb66rtMUmlhxtjalPevX743b+E9HM/KQ5i2FhAZ7yrTd7OA9BNS95ibZxOU
        cq8OEkUjbILFb3M+FX0Bs9XPu2nTdaMY4WGiCsdzne4EwGMbPS9tAB/7MNBzPCMR
        Z5i/uJW9wqZNjzmqmca2qRyAeJmMt7bKzVSX3ZGr9WMguwswx4XFcsj9baxkQAq8
        PGu3T2Vk6Zv9nNAr5lu81LBVEWQTqw7xe+Xs5rVi/rK1kvm1tCYGMdTdu1HcC9m2
        9msw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669626409; x=1669712809; bh=krfSa4bc8ipNX+QkbBzdZ+8Y7nQo
        vRdn0CO1SuGs+Js=; b=Xl5FzoAh7L7W7ZMQD528ZtTI8aEIZ3nPom2mGj0ij0kz
        kF2MB/oJIpixJ2OVApUGMfF9C5V1J8gtYw4IYHbpD5L2K0xZMNnSQltaVuzDHuS1
        +Z/Xq1mUm26LJ8NSD0dxh8PT1i5+o8wof9B6TDM8Z5ouMxiZPx1bs6dMQgIUYUu0
        E1vZWuqL9qr+i8mzl1kkoKmv3FyupcqiF4c9z7S0EaExGf6cbOffzblyC2ntLKs1
        65JwJdxbYeVbXBvoYizlrWIHJmwaZ3QX6HctbqXtkHYd6atQJaDxCfrDXnNFOgYJ
        0VBs4dlX0qrYG+1NDOvRCJnTTDjAz24Y0gIQZpnNzA==
X-ME-Sender: <xms:KXqEY53zFzDHoFazKCchq7gUQGnUHYLHsAJSYk88gY6OlWMGWGcQ9A>
    <xme:KXqEYwHkwwFrN4pnRqJFPte7zBTGR7TA8edRG3P0HG5F9XFApsouuPDeh7SGDqO2U
    xLOsqgRRC0LuK2Xns0>
X-ME-Received: <xmr:KXqEY55SjcW2lyfLpIF8pYZVll0dussFecC9TpVrM89uL0NgZw07hmiPdidgT4gG4xr_fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedugdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    dttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehk
    ihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhephfeige
    fhtdefhedtfedthefghedutddvueehtedttdehjeeukeejgeeuiedvkedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshh
    huthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:KXqEY22N8YeqVT3-KhleHcZ0VSl5tYTlZmlbg6u_rVeCUTDbQDy37Q>
    <xmx:KXqEY8HpqAnf01i_CKQCe85RhVUf9Hkmt40CgzAjqQkFeyTZpzYZMQ>
    <xmx:KXqEY3-JwTvbt5DT3a7-HJgrxqTo9-5232AU-I4ATaXfH8MLsENdBQ>
    <xmx:KXqEYx56jVSAjj9fJow1HiiTXkBuSHJ4k-kmaMBHfDwXKtchJR8GAg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 04:06:48 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 52A45109780; Mon, 28 Nov 2022 12:06:45 +0300 (+03)
Date:   Mon, 28 Nov 2022 12:06:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, dave.hansen@linux.intel.com,
        David.Laight@ACULAB.COM, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCHv2] scsi: Fix get_user() in call sg_scsi_ioctl()
Message-ID: <20221128090645.i2a526vp47ymqnfi@box.shutemov.name>
References: <20221117232304.1544-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117232304.1544-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:23:04AM +0300, Kirill A. Shutemov wrote:
> get_user() expects the pointer to be pointer-to-simple-variable type,
> but sic->data is array of 'unsigned char'. It violates get_user()
> contracts.
> 
> Explicitly take pointer to the first element of the array. It matches
> current behaviour.
> 
> This is preparation for fixing sparse warnings caused by Linear Address
> Masking patchset.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>

James, Martin, ping?

It prevents a fix for sparse warnings from applying.

> ---
>  drivers/scsi/scsi_ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
> index 2d20da55fb64..fdd47565a311 100644
> --- a/drivers/scsi/scsi_ioctl.c
> +++ b/drivers/scsi/scsi_ioctl.c
> @@ -519,7 +519,7 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
>  		return -EFAULT;
>  	if (in_len > PAGE_SIZE || out_len > PAGE_SIZE)
>  		return -EINVAL;
> -	if (get_user(opcode, sic->data))
> +	if (get_user(opcode, &sic->data[0]))
>  		return -EFAULT;
>  
>  	bytes = max(in_len, out_len);
> -- 
> 2.38.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
