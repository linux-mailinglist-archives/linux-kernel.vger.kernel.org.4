Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238415E94BB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiIYRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiIYRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:16:52 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C02A434;
        Sun, 25 Sep 2022 10:16:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id DD7D2580360;
        Sun, 25 Sep 2022 13:16:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 25 Sep 2022 13:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664126210; x=1664126810; bh=qanhb95INh
        +5sj0hxzi6loB6kl9dfK19cUoZgHCEovE=; b=DuCdpCRkPZDSPjtVgS/z6s0gU7
        OK54Es9f+6u0jLakWPuEzRApYPCpwSc2HlntB7AHF7jG7zyzcVCOP08fuAM9xib/
        QxiL31U0KcButuHqJJILoNrs26xm8vgrgXXMRdU4UUgGfOur/d7mIv2CaM1CTB8q
        CVfDFZchPGIzmNBiqLikiNaDXQXE8lvgsuj1Fl66vZGYFbxZkEfUFgNtWO+5bN5X
        b+53xAc3QILku5LEIY86bL3wV383b61KLj0hdBNzPyBa6vbA5sHsl63SM5oYKF27
        DOmUPOUkASYKDu9v8Ds733fNtB2khQdhtUd+gmJ7DXCl8S42SFN0oux+HAwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i78e14604.fm2; t=1664126210; x=1664126810; bh=qanhb95INh+5sj0hxz
        i6loB6kl9dfK19cUoZgHCEovE=; b=oEf0ts5WUxTx6VO3F7EZF+iuVn8o/ay1jS
        p0bBip2kAjUINj/tRVkGnTV5NsZCD5LLF3XqclVOKud5JHPb8UKbqE26xnDc1Qks
        8VmfZs2uh6M3sC76UGLzQ5ppndAdIrqd/l5IaZl9JvoHZ+mWf/qyAd8g3zfOf4qb
        e3zo3OSwosPJrLQYQERt99+g/EIlT3Adj5FgS6vYG+I7kNT+8DTJmBEknhjZi5zp
        TPeY1Mifz3/oiBS7Yddql+aCdx/fBodsuaksVEu6V94/RjJJCKGgHGFOecJraapQ
        UtAU/PwD7MKquqaJRPBi63p4jn8FX52696OZUPRLMVC7QozDTTjQ==
X-ME-Sender: <xms:Ao0wYzIK5yrB29_Bh3xodsUyTn3mhw7lAJerAFDoZXN4TVZ9VygOUw>
    <xme:Ao0wY3JfluEgey2Qlvgea6UB7vh5-Zm7e1YvnsanKJZhSj8gT-JRn7_kRxqT6LlRE
    KSVeQs_ysRDr0h3I6o>
X-ME-Received: <xmr:Ao0wY7tnP_efbLmW7NTD0Z65AJABDb81dUn5R_C6sSvHf0_SSfcjYYpO5o4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegtddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhihl
    vghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtth
    gvrhhnpefggeekieffteehgfetffduhfefjeehvdejhfejkeduleffudelhfefkeeiledu
    jeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:Ao0wY8aYeEwfmh6Y3RP336ZdGYx09pnAcSqSTzphSrYSDNzItAskOQ>
    <xmx:Ao0wY6a0Zq_fwVR8Fe5HiuOJv74n0Sl1FUludSVHEBnALIfMTSFhmQ>
    <xmx:Ao0wYwCr9vJtD24ST5rvUDCVAnBRRIAjtWVDwAF1HB_wL5RDJC1F7Q>
    <xmx:Ao0wY9y2Y-w41sDV-ZNXjT6R3E3jbdTZLarVpmoHwo9TlTxRX-an6CHPX4w>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Sep 2022 13:16:50 -0400 (EDT)
Date:   Sun, 25 Sep 2022 12:16:48 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: Fix comment typo
Message-ID: <20220925171648.GB59018@sequoia>
References: <20220725043853.7441-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725043853.7441-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-25 12:38:53, Jason Wang wrote:
> The double `the' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---

Thanks for the patch but I applied this one that was sent a little
earlier:

 https://lore.kernel.org/lkml/20220722100212.79490-1-slark_xiao@163.com/

Tyler

>  fs/ecryptfs/keystore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
> index 3fe41964c0d8..2452d6fd7062 100644
> --- a/fs/ecryptfs/keystore.c
> +++ b/fs/ecryptfs/keystore.c
> @@ -878,7 +878,7 @@ struct ecryptfs_parse_tag_70_packet_silly_stack {
>   * @filename: This function kmalloc's the memory for the filename
>   * @filename_size: This function sets this to the amount of memory
>   *                 kmalloc'd for the filename
> - * @packet_size: This function sets this to the the number of octets
> + * @packet_size: This function sets this to the number of octets
>   *               in the packet parsed
>   * @mount_crypt_stat: The mount-wide cryptographic context
>   * @data: The memory location containing the start of the tag 70
> -- 
> 2.35.1
> 
