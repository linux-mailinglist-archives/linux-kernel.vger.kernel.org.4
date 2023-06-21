Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E975F738FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjFUTIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjFUTIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:08:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E31710;
        Wed, 21 Jun 2023 12:08:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 11AEA5C0187;
        Wed, 21 Jun 2023 15:08:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Jun 2023 15:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687374489; x=1687460889; bh=ch
        mOE6vBFL8CMY1hzXv0AGJnH+8VUeMDekwIg7ee+4U=; b=Gd7fpONP332eqV0Njl
        TiefCPaXR48QellkpmpZRGT7KyKg49m7/18IRHl+6m6JbfihB0nuOTu29fpVVY1c
        5jUZ/F6/TEKuGbZKZU2B3ASYhEH0Q8Fhc3or16uYde+FE7eqyXEQXYyoWEm/TYv5
        gSdnzUTp0+ozolzjQuvAEJQBx7eHgYkcU09ALbsCtfaDOTZoAjl8/pw9OTHNqFuh
        wF1FtGWG/N5Jj6DDk1Bo/oPmKggIquTmGcj6lY07bnoKMbl8cwxXgPKOThX92Cb5
        Jq7pQ3m8z2/LChX5e8/R+22v7bVBgHvyVXQ2Dl7S3EQ9ZqE9AavunekAHjEDB44P
        FmjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687374489; x=1687460889; bh=chmOE6vBFL8CM
        Y1hzXv0AGJnH+8VUeMDekwIg7ee+4U=; b=RhreD2aAjdWrjkVtD1JiMdGXQjMgl
        ZdCIMMzW9BCb0tI29MenrttrXU9v6ASflt5hLJomtzGzl9P4+Ny5HvEPyaa02mvA
        V3rfg0tcSrUeKWrBMbcv7VDayT/PCFm3wlNlMPgBelemmcJmoWJW0ZgpUgAeCYQU
        kYnM8wET3W1UUWqva7M6jXt/MSJ8uI0gJYMii6peLMdp33KBuep40keAgYCmiWGq
        IuIUdlpfY8HIzySgYXbTxqSsm5a8uq4W3nmD6aaNuoBYGxiDQunkFpO89doqaoTa
        DkYN0m8qFGfxdz99m9y6imOKe+x00HMkJZBKEguQhqzaRbyEU77vhhVfQ==
X-ME-Sender: <xms:mEqTZC850_50SJS-KkjrUYqmTReEuTGbIpbUruKSpzo1prQJJKAE3w>
    <xme:mEqTZCuvmQbDYiKraxatlJjTXDIeoQAnYy4ZT5gOUF0No3f2pRQSCz91dGGXhv9pN
    1sdsCQn27LdFA>
X-ME-Received: <xmr:mEqTZICP1J9KjunV89RxU_KWLDgYtMHLo00lFiURUd_s41gXkx-72V6pwlpXO0rk2dJ6ZPIS3wJCtuRByTfw4rDaylwd8Huk_PtVXfN9z54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:mEqTZKeFUZWiTbmheX32UNcYZ5PIu_N8ASF6-dpTM_7JmIXC6GDDnQ>
    <xmx:mEqTZHO2ARa3i3ponMhBxeKxQBUEHotaPP5dLmjbg3ETyjkcL7nquw>
    <xmx:mEqTZEmdkFX70u3fgvedHBiWB1k1KjHb1nEnNcD_FZ_xAJuvXXjDBw>
    <xmx:mUqTZDBIzY68YL-Y6mIHMinCXba692yvEFekhUd8WE4trrmyx2O-5A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 15:08:08 -0400 (EDT)
Date:   Wed, 21 Jun 2023 21:08:06 +0200
From:   Greg KH <greg@kroah.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] usb: ulpi: Make container_of() no-op in
 to_ulpi_dev()
Message-ID: <2023062144-impose-wrecking-2315@gregkh>
References: <20230621163122.5693-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621163122.5693-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 07:31:22PM +0300, Andy Shevchenko wrote:
> Move embedded struct device member to make container_of() noop
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/ulpi/driver.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ulpi/driver.h b/include/linux/ulpi/driver.h
> index c7a1810373e3..a8cb617a3028 100644
> --- a/include/linux/ulpi/driver.h
> +++ b/include/linux/ulpi/driver.h
> @@ -15,9 +15,9 @@ struct ulpi_ops;
>   * @dev: device interface
>   */
>  struct ulpi {
> +	struct device dev;
>  	struct ulpi_device_id id;
>  	const struct ulpi_ops *ops;
> -	struct device dev;

CPUs don't like doing pointer math anymore?  :)

I'll go queue this up, thanks for the micro-optimization.

greg k-h
