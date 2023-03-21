Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E97B6C2B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCUHkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCUHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:40:06 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76943392BA;
        Tue, 21 Mar 2023 00:40:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 84F125C0153;
        Tue, 21 Mar 2023 03:40:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 Mar 2023 03:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679384402; x=1679470802; bh=ap
        6PqJ0HtkNsQKkphclV0LiDDXZfW276JdJ32/KWT4I=; b=mmFZYUQ9ipq2r/Bqju
        DJao1ihDj5PXrWhiAgop1QJnYY9LrUz4+r99cPkacC9c40RYfr+WOqdwxxKP/apc
        1+XXg9an9RWo7RZ44BwlTTFp95fgOChdeRqfLIwVnZa/i8Xu20aiTUxmiUbYNNai
        TXCfJNiHjvrMmfhL5brLL6rigGN4RSgia2733F/SkT3iK0ZY4RpQxrhrVpGkwdKR
        7AmrN6h+q77G/ndtVAZSpJDLQCcjFl2vJv1qlNiY12If8y6sK0EN+65eFqDcq0M/
        QOVNzAuLqw4b38xsBkNvN2Ns0mTcM/Jg2TyDuBuXr8BxkMUT+kTHEVmsa9hZDkCn
        VUMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679384402; x=1679470802; bh=ap6PqJ0HtkNsQ
        KkphclV0LiDDXZfW276JdJ32/KWT4I=; b=d3my7ZHDoiQ+85yiTSmYTfHtqImFd
        OEKaOw9ZJUjLo7HS2jhqE/bfYtIzw8W0xy+VAlO+UGq4f4BZ2daw3318pqA2LIB7
        KTPJaKyP1ws1AGGN7amUJFl9MlME+W0unpEc1fyza2CrMHZ3nVqlnGxBmv36qegY
        NuBfto/93uocmNx2xl4zRTzJGJ+15GP0VBo8cQkM8Iij/26DHC3VQ/ccrfWLGfJx
        aUCkyt8ii8g7TZ8ug9CuJaTA+cGNJwwnGj+xd/h9bvsBoEugkM8u6bpc2hYe1VWO
        t4r/wKX1yTjRfLEFu0QJ/QkB83/QSoeEbaWzBFQZp9NDXkxj7ZeEu8SVQ==
X-ME-Sender: <xms:Ul8ZZNzCDuiOGCgskBOboyg7NI_xFJsR3-GbaKqs50yihZmC-tG4Xw>
    <xme:Ul8ZZNS7IMSHX8BZBlzzdDD7W-nK30LPaIoHvQd5k7UGq3rMt8POiJLGCQ7PUekrG
    SQ8WGRN7k0b7w>
X-ME-Received: <xmr:Ul8ZZHXJgOGL3NrHDhdfidWU7UiuHkV-ud2Rnc9vv-XfADTuwVtTk4jATxAo0W_1CWCZ8Jdqn2itoAN6X7QFGyT5u-6pbF8CWE9QRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:Ul8ZZPhQlCsD6feBopuVDIp7iItHl0itzXc8KVNT_70lkQv9UcwGXA>
    <xmx:Ul8ZZPANyb9DWkf-Hc0dCtqZAw2T_bKoVRABoLQ3hlIxZMnYDs6U7Q>
    <xmx:Ul8ZZIIrR8WnnkP50C5mONnrmkO0KlfDqVmWrw-bQBoVE5nKBtDsmw>
    <xmx:Ul8ZZD6cRo1D7QrC8BPcgf7bUijkrlNBvR7l94S2WYwYNGiENckUdg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Mar 2023 03:40:01 -0400 (EDT)
Date:   Tue, 21 Mar 2023 08:39:59 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: linux-next: manual merge of the driver-core tree with the s390
 tree
Message-ID: <ZBlfT3mb5Kmuyh4I@kroah.com>
References: <20230321123428.5c6956f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321123428.5c6956f8@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:34:28PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   arch/s390/kernel/topology.c
> 
> between commit:
> 
>   0599331c3da6 ("s390: simplify one-level sysctl registration for topology_ctl_table")
> 
> from the s390 tree and commit:
> 
>   9493ed19fbc3 ("s390/topology: move to use bus_get_dev_root()")
> 
> from the driver-core tree.
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
> diff --cc arch/s390/kernel/topology.c
> index e5d6a1c25d13,72af753d1bba..000000000000
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@@ -637,14 -637,33 +637,23 @@@ static struct ctl_table topology_ctl_ta
>   	{ },
>   };
>   
>  -static struct ctl_table topology_dir_table[] = {
>  -	{
>  -		.procname	= "s390",
>  -		.maxlen		= 0,
>  -		.mode		= 0555,
>  -		.child		= topology_ctl_table,
>  -	},
>  -	{ },
>  -};
>  -
>   static int __init topology_init(void)
>   {
> + 	struct device *dev_root;
> + 	int rc = 0;
> + 
>   	timer_setup(&topology_timer, topology_timer_fn, TIMER_DEFERRABLE);
>   	if (MACHINE_HAS_TOPOLOGY)
>   		set_topology_timer();
>   	else
>   		topology_update_polarization_simple();
>  -	register_sysctl_table(topology_dir_table);
>  +	register_sysctl("s390", topology_ctl_table);
> - 	return device_create_file(cpu_subsys.dev_root, &dev_attr_dispatching);
> + 
> + 	dev_root = bus_get_dev_root(&cpu_subsys);
> + 	if (dev_root) {
> + 		rc = device_create_file(dev_root, &dev_attr_dispatching);
> + 		put_device(dev_root);
> + 	}
> + 	return rc;
>   }
>   device_initcall(topology_init);

Looks correct to me, thanks!

greg k-h



