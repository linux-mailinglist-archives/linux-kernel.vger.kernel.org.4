Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A09604E02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiJSRAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiJSRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:00:19 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D749B168E43
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:00:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D1375C0121;
        Wed, 19 Oct 2022 13:00:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 19 Oct 2022 13:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666198811; x=1666285211; bh=BkubxaaQP/
        pRE+X3k8IHiuqvh0MP//74GbYUHpjY764=; b=a8OUHYwxVenUgNZQPBYwk5P6Rv
        wPtYathobbuItjWvsLctpusp5vAM9Y5iBh6LYdoV4kNORybI0h91CREvkXg30tS8
        NEMPqB6JRXBxSosw582NWNukwT6OTVSX7DP1CsicMt4sAw7oXV8kS4NNER5fPMCm
        LMeUEF+EvICeQhKu4GcX/knArr0+Z6Lufc3ih0Cy2EYbCACp4ProQN2ymAVwXRAp
        3ehHrTr+F1xt6MHxvsM5ptgeOVzqSs+yQBmAJsO4QTKbOg+HDz7jzZ0JDLXP1TZB
        leWAuxzLMyk6zHPv7W4HT7J4aEOwJgxoufl8Xox71RC80TXHuiPXo6+zAegg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666198811; x=1666285211; bh=BkubxaaQP/pRE+X3k8IHiuqvh0MP
        //74GbYUHpjY764=; b=UwrOURvqm7EuWKouLdRtvuMjj6WPhYW76YuWaCuQkagG
        VLk9OammAfbcRvLcGPaAd/890XM4r1Td8MiIL32SIc8ESEjpUTuKg+PLWJ9enmo5
        RCcGDrtAX3Xj6A+wuyU8GToybNesIQoGhWyEOBZ0SvFU6npUTEWy7hhM3p3jPVj9
        yw82sO19Eyzw900ufB584kYFhTNZ1kId4lR4ztS/pPQLXhlwxw1AB3aDt0W2qRkN
        ID5rwZj/P+J60jymuw7Ke1jHRjw+bFqfMakXWCoqWXmGVwFmmWTBZ6Uc6qZIji0G
        Sal/ShsVd5+SV6xrbM0xSbk37K+fhb0ogmR5Z4ilJg==
X-ME-Sender: <xms:Gi1QY0d6meIGz8ckwvgFMOz8GK5a7fO96hN_NgGzTy7IfxrtNJeU7w>
    <xme:Gi1QY2P2nvJ_FivZK2AXunYIfDzieoyAREW5F5lXWHrmKX2xiVVnIIMVeaFplWv7t
    4UKIyUZSKITWQ>
X-ME-Received: <xmr:Gi1QY1gysBMQ5HxGxwNfQ646BQByl1NJTa1wQBPqQU_Mcn_9vpgfqFcQg-twG00EOh8Ks9ZTPU6Oj013n0Bv7gSjzR8-ifG->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:Gy1QY5_rQ60YherYLRQIKfszv_hfK4F7XVWeouTQB2kqG28WpADWnw>
    <xmx:Gy1QYwvxcyB2ZnBQ-IC5dyfnOZbZHjjKSB3wJ3uYfTTDb6TVk8EfUQ>
    <xmx:Gy1QYwEg-DyJhCA0vc_X0--H4fB-AUlB81-PrYrmUXj7-ipcAarvnw>
    <xmx:Gy1QY-BgsGfSfC5YZE8tBQ3uRF769frbWBwILcylo9UGjsCfCr0D4Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Oct 2022 13:00:10 -0400 (EDT)
Date:   Wed, 19 Oct 2022 19:00:07 +0200
From:   Greg KH <greg@kroah.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: Fix Lines should not end with a '('
Message-ID: <Y1AtF+t5sipqDKuU@kroah.com>
References: <Y1AgMjTsmy3C5qcK@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AgMjTsmy3C5qcK@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:05:06PM +0000, Tanjuate Brunostar wrote:
> Code style warnings reported by checkpatch.
> Improve the layout of a function header:
> Put the first parameter immediately after the '(' and align the other
> parameters underneath it.
> 
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.c | 44 ++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 5bdb5176772c..ff855def0bd5 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -87,33 +87,29 @@ static const unsigned short wFB_Opt1[2][5] = {
>  /*---------------------  Static Functions  --------------------------*/
>  static
>  void
> -s_vFillRTSHead(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	void *pvRTS,
> -	unsigned int	cbFrameLength,
> -	bool bNeedAck,
> -	bool bDisCRC,
> -	struct ieee80211_hdr *hdr,
> -	unsigned short wCurrentRate,
> -	unsigned char byFBOption
> -);
> +s_vFillRTSHead(struct vnt_private *pDevice,
> +		unsigned char byPktType,
> +		void *pvRTS,
> +		unsigned int	cbFrameLength,
> +		bool bNeedAck,
> +		bool bDisCRC,
> +		struct ieee80211_hdr *hdr,
> +		unsigned short wCurrentRate,
> +		unsigned char byFBOption);

Why not also put the "static void" on the same line as the function
name?

>  
>  static
>  void
> -s_vGenerateTxParameter(
> -	struct vnt_private *pDevice,
> -	unsigned char byPktType,
> -	struct vnt_tx_fifo_head *,
> -	void *pvRrvTime,
> -	void *pvRTS,
> -	void *pvCTS,
> -	unsigned int	cbFrameSize,
> -	bool bNeedACK,
> -	unsigned int	uDMAIdx,
> -	void *psEthHeader,
> -	unsigned short wCurrentRate
> -);
> +s_vGenerateTxParameter(struct vnt_private *pDevice,
> +		unsigned char byPktType,
> +		struct vnt_tx_fifo_head *,
> +		void *pvRrvTime,
> +		void *pvRTS,
> +		void *pvCTS,
> +		unsigned int	cbFrameSize,
> +		bool bNeedACK,
> +		unsigned int	uDMAIdx,
> +		void *psEthHeader,
> +		unsigned short wCurrentRate);

I do not understand this indentation at all, how did you choose it?

thanks,

greg k-h
