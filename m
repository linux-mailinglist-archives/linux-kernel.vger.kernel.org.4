Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2035E6F3D33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjEBGFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBGFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:05:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD312D63;
        Mon,  1 May 2023 23:05:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6864C32009E5;
        Tue,  2 May 2023 02:05:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 May 2023 02:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683007539; x=1683093939; bh=ba
        9RAZXvdpWufyFprLLb/WROhkE667HyPHaNEAwBidY=; b=KwZoHc703NTc7c4P7h
        jYw0SQGJ97yeFQb+PPK9RL6CpaWsIXvfqACmFqYcHLLmKLvFNAMrhhc3ZsLbQNRc
        R8EQqDkApomkfyrJoHcaOlzD+0fMoLd8A/fxniE1pxQmdO7MxitgIGHUMLNIz523
        k7lFWgzX6ZCUUCA+2NJ46jlFu5G2hBf7uO4t47WkpUILNFr/lg91Xs4EsGx2qDt8
        /Ir4IviFDfrkYRatTSHru6kSVPlXR/CXr4uASPbYDEgMP6mbRL2TVONZ272zSLQK
        hhsXVcqCKo341SQC/ZBauX/sTT6puaMoV130uY+s6hEqQ8aPpoZRIgNqMn/cHTD1
        D6og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683007539; x=1683093939; bh=ba9RAZXvdpWuf
        yFprLLb/WROhkE667HyPHaNEAwBidY=; b=Z2tzdSGWvQd+rd7pSZIsSVlqWZDpF
        2HxVXeblldW9jI46ZXNsjXL7SddAJbvfPyOcIRi8q/g9jF2pPxyio36WjEOCtOFJ
        9shepKPPcf+vsZiVNyX8z/Zyqkz8crTqQpzKbYy58hhuAz2WYGS6zOsquURFJfSs
        bZFx2pummEDd6bCSu95XHz9lbvJilyWPMDdLt/d65gzucVkkPn/jd8lZiHa/3eqy
        Siq9Qs2rwsOLpCXhYEtAz9kqoMucwtMp74LJlDTky3L51cTVjju3tcdDUiHyeTCy
        lqpNqbRQfM58r1BA0kaA8hFTpbFhNGpdhL36a4FNx2iKZgIH6gq9rgY7A==
X-ME-Sender: <xms:MqhQZIX5XzV4IwT8IjyODw8iyufE2aL8nau0kcsdNsm9yXpsCglSAg>
    <xme:MqhQZMnXnJh6BpJiWeDUF6VMKrWGmQ1PHLS3dZET30265Prq56FLXGfekcoHDB9EG
    iJnzOvUgPJkVWX1tAA>
X-ME-Received: <xmr:MqhQZMbOUhcTtQ-MVDbgtcykLFPofBrBExCiVYBOtGrsD1GCrlVGf3klo5J04SKK_6kNLphbN94VtY8xJjaevr5il91KytGlikac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvhedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrvght
    vghrucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnh
    gvtheqnecuggftrfgrthhtvghrnhepkedvkeegheefjefgvddufffhveehjeffvefgiefg
    kefhudeifedugfetudfgtefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvght
X-ME-Proxy: <xmx:MqhQZHVac-vvxLlSEFRXQda_mk-2U_2FXOEwSfBBkBYwfnELTHPZMg>
    <xmx:MqhQZClmgvmaTE-Gqpd5fnRXdKTlQ-uGrQzLFhsZxoa7sjfn5nv1tA>
    <xmx:MqhQZMfxAKG89mpQB1VecrPcP_gvUxh5_esk11128wcKKsvbeFFO7A>
    <xmx:M6hQZHyv-h5Ok33klD78JHBkdQF3tujrKDlYgrzvHJhlLk5babYHhQ>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 02:05:37 -0400 (EDT)
Date:   Tue, 2 May 2023 16:05:31 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Teng Qi <starmiku1207184332@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: avoid calling input_set_abs_val() in the event
 handling core
Message-ID: <20230502060531.GA857155@quokka>
References: <ZFBg379uuHjf+YEM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFBg379uuHjf+YEM@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 06:01:19PM -0700, Dmitry Torokhov wrote:
> input_abs_set_val() can nominally call input_alloc_absinfo() which may
> allocate memory with GFP_KERNEL flag. This does not happen when
> input_abs_set_val() is called by the input core to set current MT slot when
> handling a new input event, but it trips certain static analyzers.
> 
> Rearrange the code to access the relevant structures directly.
> 
> Reported-by: Teng Qi <starmiku1207184332@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

If git grep is to be believed, this is the only use of
input_abs_set_val. Maybe removing that function is an option?

Are there external drivers that rely on this (instead of sending an
event)?

Cheers,
  Peter

> ---
>  drivers/input/input.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 37e876d45eb9..f791d14ecf23 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -190,6 +190,7 @@ static int input_handle_abs_event(struct input_dev *dev,
>  				  unsigned int code, int *pval)
>  {
>  	struct input_mt *mt = dev->mt;
> +	bool is_new_slot = false;
>  	bool is_mt_event;
>  	int *pold;
>  
> @@ -210,6 +211,7 @@ static int input_handle_abs_event(struct input_dev *dev,
>  		pold = &dev->absinfo[code].value;
>  	} else if (mt) {
>  		pold = &mt->slots[mt->slot].abs[code - ABS_MT_FIRST];
> +		is_new_slot = mt->slot != dev->absinfo[ABS_MT_SLOT].value;
>  	} else {
>  		/*
>  		 * Bypass filtering for multi-touch events when
> @@ -228,8 +230,8 @@ static int input_handle_abs_event(struct input_dev *dev,
>  	}
>  
>  	/* Flush pending "slot" event */
> -	if (is_mt_event && mt && mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
> -		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);
> +	if (is_new_slot) {
> +		dev->absinfo[ABS_MT_SLOT].value = mt->slot;
>  		return INPUT_PASS_TO_HANDLERS | INPUT_SLOT;
>  	}
>  
> -- 
> 2.40.1.495.gc816e09b53d-goog
> 
> 
> -- 
> Dmitry
