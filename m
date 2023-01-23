Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C245677E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjAWOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjAWOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:40:52 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F5121A23;
        Mon, 23 Jan 2023 06:40:51 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7D2D83200951;
        Mon, 23 Jan 2023 09:40:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 23 Jan 2023 09:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674484850; x=1674571250; bh=6VndgLUI/2
        FXbGAj3Yjg+cWN952dUGLBzMGrQHoYjm0=; b=b3UOVvQL8YvF1JQRIoDi1ynU0y
        hVI102C39G4F4uslUqohgdtd5efGnnWzeaXOdzsl9/JqUImceq/cG8Npu+kcRAiI
        zfXBoIihRvtF61C9xaMWa0sQYOnUW+LQB86IBvD1lKfXCvAG2gHTKbHVAa+ds3Ze
        l2d8xv2MxQ6cn+FZF1NO5MROYfogwnyJyiTcTQbQjatVHT85ju6/JA2BxTjKYhot
        NHlzqn6n5rFLmt5PT9svJL59rw5LO7UADbAXgq46mN4mbrvmmj26LIBkjn2rQx2U
        SlCMTMgpdFU0U1XGMgyoxQ6rGOau5cFwKg7eZhnf7YDqqON1rCZMfpdK4T/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674484850; x=1674571250; bh=6VndgLUI/2FXbGAj3Yjg+cWN952d
        UGLBzMGrQHoYjm0=; b=lDyNhcRGw2lV3dpbglv6boPNe1m0yTs65B/L8WwPDA65
        ZsGj/kp0sBEmr+wb05rUIxWr2ndk6VuFZU5ncE/Xej86p/iYg/r9CoJQ/hoxyjUt
        ie0VNGjEfPwXC0SkR/OIQJ6zn7c/F4YikH6AKkOajdNXPNkcEv291p5ja9MRuS3Y
        jIuFb1RhI05uAektN/YW0i/n2529vtHRuQq8S+lyTPvPnWla3OntpYXIkHPmVVD2
        QtXWr48tjeVIU8Z38x9cQngJwkNm4TriWfwNkvREqv4wVAd8ax5Z5jtRbd/xuV5f
        ys9XkM7dR5cb34KmFZ59ENjPs/nNUsuJcZgwqypf0A==
X-ME-Sender: <xms:cZzOYz9C4kGiFgraxRtgNUKk6C_5Tufl6K_lWNNTuNfHk9VQu0zG2Q>
    <xme:cZzOY_vq5FAnUAavzm_iwrJCKQvuQ5U2hRq0TiRefmpBSmhzJVLxvczveDYEV8B9K
    AiXMM4x_UTfMg>
X-ME-Received: <xmr:cZzOYxDnWV3iCcURvKkMdRTD2YhOASdSu9j-iGerYoqxUmVb7e-yycHIVQ3YvtCkqrb3xH-C2dIl0eGGRyKEo0LrrhL5u4z2oTI85g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:cZzOY_ctg6x7C8dKdtlMhau_A4QTXojNg-FxFLmiO8QICsgSb6Y0Gg>
    <xmx:cZzOY4NAHh0FsUesq_GgWQvSTVPm8safTGU1nT-POJ-jDYEOe-iSQQ>
    <xmx:cZzOYxnGgSe6YkvjtkwtGLtQQX3nLRdMcZkxc1rInTRkPMBnlWQX1Q>
    <xmx:cpzOY0nBJchcEhyz5ZNseB2ziAS_6YkT9WmABxC1zKMsn8FKGcw50w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jan 2023 09:40:48 -0500 (EST)
Date:   Mon, 23 Jan 2023 15:40:46 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jack Pham <quic_jackp@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Rajaram Regupathy <rajaram.regupathy@intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <Y86cbr7PqSq/Xhhw@kroah.com>
References: <20230118115624.72e7e756@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118115624.72e7e756@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:56:24AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   drivers/usb/typec/ucsi/ucsi.c
> 
> between commit:
> 
>   fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are flushed")
> 
> from the usb.current tree and commit:
> 
>   b04e1747fbcc ("usb: typec: ucsi: Register USB Power Delivery Capabilities")
> 
> from the usb tree.
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
> diff --cc drivers/usb/typec/ucsi/ucsi.c
> index 1292241d581a,d04809476f71..000000000000
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@@ -1426,20 -1551,14 +1557,26 @@@ void ucsi_unregister(struct ucsi *ucsi
>   		ucsi_unregister_altmodes(&ucsi->connector[i],
>   					 UCSI_RECIPIENT_CON);
>   		ucsi_unregister_port_psy(&ucsi->connector[i]);
>  -		if (ucsi->connector[i].wq)
>  +
>  +		if (ucsi->connector[i].wq) {
>  +			struct ucsi_work *uwork;
>  +
>  +			mutex_lock(&ucsi->connector[i].lock);
>  +			/*
>  +			 * queue delayed items immediately so they can execute
>  +			 * and free themselves before the wq is destroyed
>  +			 */
>  +			list_for_each_entry(uwork, &ucsi->connector[i].partner_tasks, node)
>  +				mod_delayed_work(ucsi->connector[i].wq, &uwork->work, 0);
>  +			mutex_unlock(&ucsi->connector[i].lock);
>   			destroy_workqueue(ucsi->connector[i].wq);
>  +		}
> + 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
> + 		ucsi->connector[i].port_sink_caps = NULL;
> + 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
> + 		ucsi->connector[i].port_source_caps = NULL;
> + 		usb_power_delivery_unregister(ucsi->connector[i].pd);
> + 		ucsi->connector[i].pd = NULL;
>   		typec_unregister_port(ucsi->connector[i].port);
>   	}
>   

This looks good and should be resolved in my tree now, thanks!

greg k-h

