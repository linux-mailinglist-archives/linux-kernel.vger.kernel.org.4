Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81E3671624
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjARI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjARIZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:25:59 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8005E47EDC;
        Tue, 17 Jan 2023 23:51:42 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CC9433200437;
        Wed, 18 Jan 2023 02:51:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 18 Jan 2023 02:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674028300; x=1674114700; bh=RGuR+VxWYL
        rsT+sIyy6iY6TbdhUSEvwC7Aaq91qar/0=; b=oHFrnBrGVabUGxohEkxAigY0An
        P4RkYuB2Mua/5CF4hz3xmvxViEvpps7TCExjZX7FPHLLzt5lLrQ9WVgD1gWFcscn
        yn/aJ0WIxbpJdSF08hDGPkOIDNTurliPtUt6hJY+cWWSCnfMjX17kD1yrL3/tvNN
        Yc0ZPFWwzeN0LWwpXXXCzTNnmbsP2hvhGtc1Ogkv4PLlBzfUtopGiYddWGg864IT
        mezS6WBoijD2Pb7xOK39ITYUlCkbrfyqtKEcCSSvyJsc2TqCk9bBKI9vwpqDlovV
        IpYjUZV+BODtZyc8QsZVgz6lElUO5F0f7YuAw+QfabJM1JLteCqcoHw0yavQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674028300; x=1674114700; bh=RGuR+VxWYLrsT+sIyy6iY6TbdhUS
        EvwC7Aaq91qar/0=; b=fJ+7TcEq890D95kMoIZ9mpbYhkz5muUCOZfK+RSLCK7P
        R1kr9Sol39GVm+e7Wki6TGlY+TMsGU7odd80F2GknATy7a2lLYfu2f359h6mksou
        P5HLvdymfyWalIJOsswTWnj8fhL7kTbXSgiy3ytomNw1gqDk0DPDbBk4Ycr9nVQA
        v7jMuM+tsYcu8lxVXcr7O4qvC/83sSnfkicG+HtC2m/MGKtoEd6n6/uYJEqYKiC5
        2bfRGkG0oKn/SJ26C2N/muXTs2OMV0IwM6sPiRCqOERvdQGkGJ7YPY5IGESjpNJH
        ZUVsbU3TBewM0q5kvmsyD7/KKTT1cn6pqFekRS0rqw==
X-ME-Sender: <xms:C6XHY4OJXrZzkvGrUmMK0daroG-OpcGvQx9Y-tpoPvvAYgefrCr70A>
    <xme:C6XHY-9ahjx1K_9-aicGromwcXoRp_lx-YdkHgYRClWrAzRwh8k71TQTfBlCs0mUO
    _uWjzhD-b6RJw>
X-ME-Received: <xmr:C6XHY_TJm4hbmafQ-BhYJR85Bb9HSwaUzOLPebrDdenMirqo0p0aSZXT7GIm5IeDnAfRt85QwFTGgJXkrRhg28rksP8X-47V5ssQ-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:C6XHYwuhmSukiA_o6KfdkA3xUHBxdKy-0CJFoAob9LYl0xrlO65v8A>
    <xmx:C6XHYwc4gdMkHqE7zz2_dL7VYo_qHGIpu8agq_0V6Rcg0d4kQo2pLg>
    <xmx:C6XHY03BtV-YfnegsZf_cQhujIGascCLHYJSzqWUJBDE9t1PRiVTlg>
    <xmx:DKXHY23_PQA-7bZ6A6xKx61sPCY9mhjdDULja4r-ncSlaJENZq2vzA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jan 2023 02:51:39 -0500 (EST)
Date:   Wed, 18 Jan 2023 08:48:20 +0100
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
Message-ID: <Y8ekRLJlpyBLEJfN@kroah.com>
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



Thanks, this looks correct.  I'll apply it when these get merged locally
in a week or so.

greg k-h
