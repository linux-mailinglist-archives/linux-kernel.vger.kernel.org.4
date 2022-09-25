Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C8C5E94BE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiIYRRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiIYRRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:17:07 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2211E2AE03;
        Sun, 25 Sep 2022 10:17:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 88357580360;
        Sun, 25 Sep 2022 13:17:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 25 Sep 2022 13:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664126225; x=1664126825; bh=IE3oCIBiHG
        2Qi6929a+kKIC1oWXus27kYIqfoxnLVzA=; b=KFu/Zvcwv0eiWweeKGiNrMcUU3
        NJ0uff8tZRRCpyEnCDfBReW1BvnipVEQVoQALtlhieNnoiY9ZWAO2X0FHg2g4XUv
        idMGb5VJ2teKGiGvj1BR9Z2lLnsLPF9qdtNPd1OF5sR+mOjnSjEio1suxaTkkhLY
        WGwnoeN/Dn3sqHVRLAs91s1cXT0JAAQRgXVHR/x7QF2783K7DMxh2UkrhBaVgjFF
        tsfo5aY32T5BGphLLAAoCg4N9rAdrO85b5Io5gaf/DPgO9iDrNdH3/W2j47HEafw
        Zm6uThmg/oLA0d0JxABS8fzzTfqlfIXn4L6dXkLWuOF992xolKMNylpd1S1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i78e14604.fm2; t=1664126225; x=1664126825; bh=IE3oCIBiHG2Qi6929a
        +kKIC1oWXus27kYIqfoxnLVzA=; b=yDkX6tOWGJAIqBJg3zfg/1R53VFsglQuRr
        fB25ggKTv1mYqyvyKfbfiQ5xo+JXOXZ42KOqpObuAusG9zKWy4XiEHnzq+SMvw/h
        IOXncfoUZWeE8O5u4hUo8zOiaXVPXnCNOXOWnQzF7kXHbTHJ2nNyjPinKr9ab89C
        4fgmGai2S8ntublLbNrvHdXWAugfOEIbcSsUmnZol5F4kQTR5wBN9bEs9q52wW3l
        ySi3QCCjPvhzpQhrrWr1p32zK4p9BGuP7u13XoHE2BXhyAxkOpZUjGSUmS6VUADn
        FOhKblpVYsfNMuW2sJ56+Z2x6RPq5LnSJPEFGrnkM6LZqcG3Gi9Q==
X-ME-Sender: <xms:EY0wY_LkHmLGlQ-eYnbcn2TI13PA2i5Q7UPMLdj8BQWtzVkzRo6iTw>
    <xme:EY0wYzID57uJpdgGkvW04GRdH0ZacNU1Z6Sr1OML6uNAoMiNtB74qVwQcBVuUPAeq
    Yg6SY6rwxfy-ZGGfpU>
X-ME-Received: <xmr:EY0wY3ugs9MIgY-wrXcayV7EA98RTXxSZcnZ0YnS7EZhur70plluil9JVhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegtddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhihl
    vghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtth
    gvrhhnpefggeekieffteehgfetffduhfefjeehvdejhfejkeduleffudelhfefkeeiledu
    jeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehthihhihgtkhhsrdgtohhm
X-ME-Proxy: <xmx:EY0wY4ZC8WXsJsi87l-7HtD6fGTPyoFqLYoljpSGdIpPQNY8blpL1Q>
    <xmx:EY0wY2Z7Se0H0otYvtEMNL4vcPn24NGG-y_qWaI-YB5WYSuD73Zx1Q>
    <xmx:EY0wY8DKFcR20w0cv83xpaZp7pjZLl0URU23uby8QfIVr_e6rypgYw>
    <xmx:EY0wY5zYH--daurq_fJ4-p6z35UbpqhAqfvbcWigZtMPruj-8P54y6Kfqww>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Sep 2022 13:17:04 -0400 (EDT)
Date:   Sun, 25 Sep 2022 12:17:03 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org
Subject: Re: [PATCH] fs/ecryptfs: Fix repeated word in comments
Message-ID: <20220925171703.GC59018@sequoia>
References: <20220826100052.22945-9-jmaselbas@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826100052.22945-9-jmaselbas@kalray.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-26 12:00:37, Jules Maselbas wrote:
> Remove redundant word `the`.
> 
> CC: ecryptfs@vger.kernel.org
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
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
> 2.17.1
> 
