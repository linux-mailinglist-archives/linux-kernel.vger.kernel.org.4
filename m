Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B116C11A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCTMPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCTMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:15:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735511FDA;
        Mon, 20 Mar 2023 05:15:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D4CEF5C015B;
        Mon, 20 Mar 2023 08:15:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 Mar 2023 08:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679314511; x=1679400911; bh=AM
        KjngKCGDPM4qU6X+zgz9Yn6n9G/CtVavTksA2xQO4=; b=jiS7Rg+8pmUrPyxxuQ
        gZtugJut/Tc1y0ZhrGaKsS2ngy50j6mvngypc92dwI2MFg3xWQI1pnntlATaXCf4
        jQHMNMx9TA0YNTfhUe8Jdb5v+9mKrhPCpmG8aSHgqJ4hRVQhXnc5Pea0M+pk9kcI
        pBA77DyReT7sHATEIw0rJ5LSC7DMAJgVEw7wGx1+0PrICj8i3Bh1swQ+9QPw0ShY
        SLdEF0zO6XpGr4y7FdWQsWt+GBTvytbgtitSWh9CYL6MreUJ2paV7ve/6BZmfuu3
        BEOwYxJnJASxK0XraV8NAlPOuaSgpZ5LU/BvJ/iW/Rp1MdW0IidEKkDzMkWaVPpD
        PUFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679314511; x=1679400911; bh=AMKjngKCGDPM4
        qU6X+zgz9Yn6n9G/CtVavTksA2xQO4=; b=Qo+m5GPKenmirPQ82U7Iu3cBcM7WZ
        KzLrIFU+wdJhDQc0HJbcX780BfVf7HLNBzWWoMxt3V9ujbbecvDdCtIM7uTQHyGe
        mD0jW/QV5Q98rBAOnhzRD/0eSrFiEiPzLiW0ot8IRBXrTrK46D/X7JeeMpcPQbjz
        9eTq3bqkv9hQ7Go8eeUXerIeI3L+SlIYoHIgSmoi8R3NPruciGXCp4f6aIMJn4ES
        GQyW2zlyyUKzVUDIfwxnlCFqqA9RD7DRyocVkpRes6s1Y/Tcfh1Z/XjLtx+SWMPy
        t1X15XHjBdpXyRosdV7S/I0Wu0ugXlZ+r9Z9FlKof5+O9sIKewkjegcxQ==
X-ME-Sender: <xms:T04YZEES2S2ZfWytOrqUsoeTVqIAyrlnR-2pTKVsCpGJdbaCXcIgnw>
    <xme:T04YZNVHtQWrj48BCjALZDE7XX_Nqjsr6riqbiTIn2IT64WLbmbygrESwqzMCeYtY
    rmsqhbgaAZy6g>
X-ME-Received: <xmr:T04YZOJLdTLQjruVVf6MwsHVZ86XCzjD6swUMApthtbERKWP7Wngnu6bON0oLMW8xGmUrjClbBhw661yuOCIqWdlGcNP8GCDvyJHSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:T04YZGHHWRPxl9s92osqlte0HXBhidH4nxz0ekSV-EmYHb8FbqooNA>
    <xmx:T04YZKXOCg7YMkec-5UitHkczSioRDGBL15a6j3VmSz4qJInj3YerQ>
    <xmx:T04YZJPWRMemsAGA2Xo0QsWIyiW0IeZ8GpG0rPPFRxdMGoAX2ftEhA>
    <xmx:T04YZOrwdhTcO1xPTKP8nzeH8MKu1QVkbQmWgGftKMpLLjYpfHxPXw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:15:10 -0400 (EDT)
Date:   Mon, 20 Mar 2023 13:15:09 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the extcon tree with the driver-core
 tree
Message-ID: <ZBhOTW9v9jzJVY7e@kroah.com>
References: <20230320115839.5e645bb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320115839.5e645bb0@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:58:39AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the extcon tree got a conflict in:
> 
>   drivers/extcon/extcon.c
> 
> between commit:
> 
>   1aaba11da9aa ("driver core: class: remove module * from class_create()")
> 
> from the driver-core tree and commit:
> 
>   6384c02f33a9 ("extcon: Remove redundant null checking for class")
> 
> from the extcon tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/extcon/extcon.c
> index d43ba8e7260d,adcf01132f70..000000000000
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@@ -1012,12 -1012,13 +1012,13 @@@ ATTRIBUTE_GROUPS(extcon)
>   
>   static int create_extcon_class(void)
>   {
> - 	if (!extcon_class) {
> - 		extcon_class = class_create("extcon");
> - 		if (IS_ERR(extcon_class))
> - 			return PTR_ERR(extcon_class);
> - 		extcon_class->dev_groups = extcon_groups;
> - 	}
> + 	if (extcon_class)
> + 		return 0;
> + 
>  -	extcon_class = class_create(THIS_MODULE, "extcon");
> ++	extcon_class = class_create("extcon");
> + 	if (IS_ERR(extcon_class))
> + 		return PTR_ERR(extcon_class);
> + 	extcon_class->dev_groups = extcon_groups;
>   
>   	return 0;
>   }

Thanks, the merge resolution looks good to me.

greg k-h
