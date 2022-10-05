Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5561C5F4FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJEGzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJEGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:55:06 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B58F6C743;
        Tue,  4 Oct 2022 23:55:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id D46F0320076F;
        Wed,  5 Oct 2022 02:54:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Oct 2022 02:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664952897; x=1665039297; bh=jWTbZEvbtDtUpxhiaZ06jnKvT3cn
        t7nqR4YpnsdkpzA=; b=SN/B0rG//lwD0KUvExQeYgJmksgAuQTF3wbAMmkGYXw3
        tZDKhTSS0NxHUE/2Ljh3UjN1jVph4YVJNCa9EyI/k+wCFbArqwmSL7zuVXxEQvVi
        6BPctFK77GjmQwtk7oq5brX7C5oEDNKcjOhZ9omGjQffozknm0uLJGdA4Fpdc7+O
        td/p/33vN73l6G+g+1yZFfNlltEjDxBu5iRaz3KGHmhuUr8DVu9+eCj+6q9Y6g0N
        bDThAyvejofXn+tgNSPzqEjKpJejXW+D3uwo7Vp/M0MzzbGCxv99heIGcWEy5h2e
        glwIRnUzWyrOrshKeBlmMc/oubA/jYjr3y0mYPtyBw==
X-ME-Sender: <xms:Pyo9Y-Z4elN1Fe-Y2a5I_7wiI1rJYJUeIV3kNVkTTPhKeH1M5-vPwA>
    <xme:Pyo9YxY6wsMwCvFZLEPMRTXWojebDd1jhl7SQ-HfGakBHmmHIsBNCAM-QrjpNjlJS
    n9MLkASF-3dEhhAaTM>
X-ME-Received: <xmr:Pyo9Y4_XinFLEkKFqDfQkTqCnLPHtdInd6PX18SGuRvpMOawyGQ2i1yV8sHJ5MZSR1n_u-QBPC6BRl6VXUlKQWb6Xi9zpoLZ0dI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeivddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhn
    ucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedv
    ueehueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:Pyo9YwqufxSZDLDkbx2_7_1aZI-PfVYfpBiX7qPsQYDRbF_Jstl4cg>
    <xmx:Pyo9Y5raNcqnWsqJdZpmQ_zJHhy3BoEiCgTYwzJt6WITb3rLAO3Alg>
    <xmx:Pyo9Y-QLMw58FfnDEeWlso5eW8V76Z0BdIwklzwU6U93vzJi8AlyUw>
    <xmx:QSo9Y_gAkX9CqBZ8zI3KIJAa8a0fZKASrx12ssz77auJ4vxMMkXv0Q>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 02:54:53 -0400 (EDT)
Date:   Wed, 5 Oct 2022 17:54:48 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
cc:     geert@linux-m68k.org, linux-block@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        linux-mtd@lists.infradead.org, axboe@kernel.dk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, efremov@linux.com,
        josef@toxicpanda.com, tim@cyberelk.net, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com, mcgrof@kernel.org, hare@suse.de,
        damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        bvanassche@acm.org, ming.lei@redhat.com, vincent.fu@samsung.com,
        shinichiro.kawasaki@wdc.com
Subject: Re: [RFC PATCH 15/18] swim: use init disk helper
In-Reply-To: <20221005050027.39591-16-kch@nvidia.com>
Message-ID: <78eb3d46-de71-a20c-ed5a-efc6ce71f571@linux-m68k.org>
References: <20221005050027.39591-1-kch@nvidia.com> <20221005050027.39591-16-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2022, Chaitanya Kulkarni wrote:

> Add and use the helper to initialize the common fields of struct gendisk
> such as major, first_minor, minors, disk_name, private_data, and ops.
> This initialization is spread all over the block drivers. This avoids
> code repetation of inialization code of gendisk in current block drivers
> and any future ones.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/swim.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/swim.c b/drivers/block/swim.c
> index 42b4b6828690..7fa4b2766367 100644
> --- a/drivers/block/swim.c
> +++ b/drivers/block/swim.c
> @@ -835,15 +835,12 @@ static int swim_floppy_init(struct swim_priv *swd)
>  
>  	for (drive = 0; drive < swd->floppy_count; drive++) {
>  		swd->unit[drive].disk->flags = GENHD_FL_REMOVABLE;
> -		swd->unit[drive].disk->major = FLOPPY_MAJOR;
> -		swd->unit[drive].disk->first_minor = drive;
> -		swd->unit[drive].disk->minors = 1;
>  		sprintf(swd->unit[drive].disk->disk_name, "fd%d", drive);
> -		swd->unit[drive].disk->fops = &floppy_fops;
>  		swd->unit[drive].disk->flags |= GENHD_FL_NO_PART;
>  		swd->unit[drive].disk->events = DISK_EVENT_MEDIA_CHANGE;
>  		swd->unit[drive].disk->private_data = &swd->unit[drive];
> -		set_capacity(swd->unit[drive].disk, 2880);
> +		init_disk(swd->unit[drive].disk, FLOPPY_MAJOR, drive, 1, 2880,
> +				&swd->unit[drive], &floopy_dops);
>  		err = add_disk(swd->unit[drive].disk);
>  		if (err)
>  			goto exit_put_disks;
> 

You typo'd the ops struct. By inspection, I'd say your patches 11/18 and 
16/18 will not compile either.
