Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416026C886C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjCXWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjCXWeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:34:09 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DC91F5C2;
        Fri, 24 Mar 2023 15:33:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A6E563200906;
        Fri, 24 Mar 2023 18:32:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 24 Mar 2023 18:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679697147; x=1679783547; bh=cE
        vcJtvr4tb8xwrTcwABPpyCDNqZmGE4/8VmCSqSR9g=; b=GaAd+rWiieqSjuWlJc
        roXXFOsXg7PE3LnYYdMoXYTAkc7iO30DZsBFZFPzxMDRzej0AvJAOO1BfSwmarBW
        C+Cb6FSfRbwguXDHaJ1nh4qJeEQtviIhB0EZa6CpbBLnbeIAfAvPIQTb2OAHwfVU
        Rf8ONvLYfYXKs86Db6fRnVY9jzLLEa/ex9AO6DoYxdrJaW8Vfhkz4e+R9izUsPQr
        w9dMebtYiKm1siYZIvCTsyIKvKkPWjii+rDWC7zHEyqzGM91PoonKsH6QyW3A8W4
        N4FECquoKNGXXa7hjMlU9pDb8Nbd0OXh5UlMQJkQEd5aM77FV4D6zNYOM6YyrGcD
        Cq2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679697147; x=1679783547; bh=cEvcJtvr4tb8x
        wrTcwABPpyCDNqZmGE4/8VmCSqSR9g=; b=ItoDkNnLsGBgMBjnsdc9CJVSJvYO8
        vWGluMzpgTe6atAutB8Dl8Y06eojckCVv7p8wX+SELThmCFOoXK9+HOQU/6YETDf
        QiL8ZrW0TvKIi32d7AJSnfHAfQICwNYSrxfyxKUM7e+gfgW2vdCWRyJlrL1VB+7/
        q7liQgl+WfCAuP6CQL7SHm5SRT3zkVmacPGN+fBwgSxUCFrOTywX1oDSn9suGkP/
        sXJyyfpxWP82xW0P70RXA27xQQtMsRgxBh6EzjXs8FT4inlmrCH12lhkMQtkeRyf
        5evioDElg/Pn2USvRDH7lRxdCTeMdAvZSUtpM2YJgDal8rOLswwedMVww==
X-ME-Sender: <xms:-iQeZKw0Txgz7TXB4GqZrl9Yrpgu-QyBFAcNJkVbBdcxqG0YcnFeuA>
    <xme:-iQeZGQRkoF6ggpx7TGclOHTZtlm4QiSsBT0E0HzX2GesyGVuK7spd3Lg7L9KvetE
    t2O1zbLphGYrqRjNOY>
X-ME-Received: <xmr:-iQeZMWXYR5N_ACfgbr25WyLkwVamOM_GokiGWEYbHg4Qaor8m--hvp10wt2zMh3Vm8I7zlib5947vXb3uYorwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhihl
    vghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvhedvtddthfefhfdtgfelheefgefgudejueevkeduveekvdegjedttdefgfel
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtoh
    guvgesthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:-iQeZAgJaKKtUhb6k1uB6Dt5SxqzgmZk0Jx55D3Ea8CM_BODyTvVlg>
    <xmx:-iQeZMDMDB5b-hPGuNwVsAt1HbpX013BZoY-hoNliTh_EhYGvSGLwg>
    <xmx:-iQeZBJKTg3rXnYjPlt2O6Aqs945oy5ybhFwjXjAtUYM3ScVZMQ8Aw>
    <xmx:-yQeZPOxXGc4UVnJhFx8vY_LmyDXKkCDOruoXhnhXSg61zrFA-j5Vg>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 18:32:25 -0400 (EDT)
Date:   Fri, 24 Mar 2023 17:32:11 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Zipeng Zhang <zhangzipeng0@foxmail.com>
Cc:     herbert@gondor.apana.org.au, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ecryptfs: comment typo fix
Message-ID: <ZB4k66w8/IJ6hf5C@sequoia>
References: <tencent_3EF4F3D0717E80F131BF00B982698C34DF07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_3EF4F3D0717E80F131BF00B982698C34DF07@qq.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-20 10:04:28, Zipeng Zhang wrote:
> Comment typo fix "vitual" -> "virtual".
> 
> Signed-off-by: Zipeng Zhang <zhangzipeng0@foxmail.com>

Thanks. I've pushed this to the eCryptfs next branch.

Tyler

> ---
>  fs/ecryptfs/crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index c16f0d660cb7..faa901cde636 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -1289,7 +1289,7 @@ static int ecryptfs_read_headers_virt(char *page_virt,
>  
>  /**
>   * ecryptfs_read_xattr_region
> - * @page_virt: The vitual address into which to read the xattr data
> + * @page_virt: The virtual address into which to read the xattr data
>   * @ecryptfs_inode: The eCryptfs inode
>   *
>   * Attempts to read the crypto metadata from the extended attribute
> -- 
> 2.39.2
> 
> 
