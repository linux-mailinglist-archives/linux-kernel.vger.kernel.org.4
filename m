Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8B7406DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjF0XgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjF0XgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:36:18 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9B1BE6;
        Tue, 27 Jun 2023 16:36:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 352B13200914;
        Tue, 27 Jun 2023 19:36:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 27 Jun 2023 19:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1687908972; x=
        1687995372; bh=FAAyEM8Ly5PWnExbNv7ubvTfVH0QtKdzbHqCX13GAzg=; b=l
        IlERPxvSpe39YUYHZnaOyWLv1s1k8zsvCBIJF5U+QY9ypB1nulA4rrRQznySXi9F
        qdfWJsAvTgN6t0BvaYOzWOPPbmOWInG6rQvjz488L0nnC2x9zmtU2NQavD4tEi2i
        Rb3uIGfNd9kGO5CtI//igdkti4n8ZIHZbtXi2z0oaQuRIkHYBb5eGoX9HgC/dZ8Y
        QpnY8+I2yTJifPxmw5d/SbUMMaOQmV8lFKvjbsnyVKTFl74QsP5wxBbq62i+Ur/v
        4wAngpX7Nd1j6bGiyNQIR7fij1u6yIwZXEjKvwBrTUgEOLRGwY4UolhxhEVS43Ph
        D2ZEFbnX0IZFnM8mRZlXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687908972; x=1687995372; bh=FAAyEM8Ly5PWn
        ExbNv7ubvTfVH0QtKdzbHqCX13GAzg=; b=K+Nxy0YOe7J0ueBKr1pqqeW2UurQ0
        PN5DErctn5r4iiJoC+crmjrkbSPxmy5Tvi3f1W34dfOqKGhrMFqmxaT0z5FYZKoJ
        lv/yqnPkn2C1KoSnqzTHfMF0LdEeGwdPy5kTZ1lnfe0Fn6iV9WOTKaMzABuYhv5k
        pVWkoHZbzUwpSZVU57bLiqh9lwEMcBBGT9hxGf4HKX/cfRyYOFwi675NjoSh11J/
        0ciYiwS4TO5tlCw4nOhSFm++NK/ITSoDOJ1m7am3/UR0f4bna6Bilp3o9PcWelfz
        R6oY61zRJ4lcg+bdGBU81UZI266qAo71CM5Tm9R5+yc+PD3WSEeQlcc+Q==
X-ME-Sender: <xms:bHKbZFL80QjAugbZ5EXFs64HpbxZ8FWkYBOpHeirjvWJxdrsZI3U3A>
    <xme:bHKbZBI3qGle7beVPqY9-zmFwpnFOEhpKbBRxQqGr-otcPMkxyO6lkVIuoMmAUDJO
    yGHqFFrOB29QKCMYlI>
X-ME-Received: <xmr:bHKbZNv2EXYyk_-3ER_W5GFYTFLqS_PtpA0q5amYEg0yPlMzMyW36S_-_8I447f7j9QolvfzjmElHN1CHp7YF0i30QLByTwUSZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddugddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieei
    tedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:bHKbZGZJNiqFsXFwYPdeo91acXo6ieaA_nfP6S_l3gCi5vnkaPMBWw>
    <xmx:bHKbZMaoWhl6zy0G8GQa_1yECBsCFh0-0glVW375saVkrlgCcHQkuQ>
    <xmx:bHKbZKBcqgqSvureY-vlQ4CjXN8FPgb15p7YnissYGbkOl4EhxGR8w>
    <xmx:bHKbZLxd7odaSe15pixMn6AKZDz_pdu-QhKYxrfGavYkQfKLHgw8oA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jun 2023 19:36:09 -0400 (EDT)
Date:   Wed, 28 Jun 2023 08:36:04 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: oxfw: make read-only const array models
 static
Message-ID: <20230627233604.GA278863@workstation.local>
Mail-Followup-To: Colin Ian King <colin.i.king@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230627113253.700065-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627113253.700065-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 27, 2023 at 12:32:53PM +0100, Colin Ian King wrote:
> Don't populate the const array on the stack, instead make it static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  sound/firewire/oxfw/oxfw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
> index 9523479fa94a..63d40f1a914f 100644
> --- a/sound/firewire/oxfw/oxfw.c
> +++ b/sound/firewire/oxfw/oxfw.c
> @@ -44,7 +44,7 @@ struct compat_info {
>  
>  static bool detect_loud_models(struct fw_unit *unit)
>  {
> -	const char *const models[] = {
> +	static const char *const models[] = {
>  		"Onyxi",
>  		"Onyx-i",
>  		"Onyx 1640i",
> -- 
> 2.39.2
 
Indeed. It is preferable.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I found that ALSA fireface driver includes the similar issue. I'll send a
patch to fix it later.


Thanks

Takashi Sakamoto
