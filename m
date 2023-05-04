Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511426F6805
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEDJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjEDJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:10:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0D8AC;
        Thu,  4 May 2023 02:10:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DC470320093C;
        Thu,  4 May 2023 05:10:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 04 May 2023 05:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683191447; x=1683277847; bh=PJ
        +MHi8BKY86SWPKwEBcexmDQBI0jwalX3S/C8DpKjY=; b=OkJR1vdZgMQkDeebk3
        C3Df+sYUG5IKzDgGWDzP54zncGqO5dMLxISsW9MRjxlY5mHfYkUosVFISdiAJC41
        ptg80omXiJjpzbcGf/6DhvjIn1eqC1+wvpu/5OT2tQWg8AYOOvRWmmDVXe5CIyXZ
        oMVx1/RfSd1AItwWlg09Ew7QN1J4tXCFvBSfBWwDfZsZz9HiZEPjApUSpmc67qn5
        VKU3dzluckNiasW3k8s8dB0zCyAzpzG1biELtAfSYiV4fhem/mrTc8/qHqoTsK1/
        WwXwanX5JmQ95ShHqkQ+1+pCiJtTw4ra0fpqregHs8hgGZFfuqpaXbrsJT1ZdiO1
        EpQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683191447; x=1683277847; bh=PJ+MHi8BKY86S
        WPKwEBcexmDQBI0jwalX3S/C8DpKjY=; b=Np0mbT/tXdr6/OFl02CaRMdgq4uO3
        5QiemDuzsd15WsbMN7h8d01YHCLQ7nl+fK/OgrKX1t+/g0YX3WjFOaF3ZXyIR+sC
        JaESqTvBVva9CyxXaNLmmuvCoVHN8icnPWd9T69BpaNEupv4+AsUVLG/mDdspWnz
        iWHSGMWirMO+LxTBASSccT5yHfQ+68t6zOBcHWLBbogN39+gwFUhh+4TnwTrGdzu
        RLKH+hYcf9rZn6rVa8ItUCosIV9b0ZS6I5Gs5g3fwNv2eCn/V3YRgstZXgRft1LF
        NQR4+V+AGasKMB3MI7ALGaHbpAb6xhCKYc1l2akYUSNoRkqhDn3n3JpPg==
X-ME-Sender: <xms:l3ZTZGSUP_KJdhHAs_6tNDXC0UWcI-pbdVarqWMPfoosqu5Y6CVHeg>
    <xme:l3ZTZLwiihBJdksD-LeK8DMNb8ys1KXVGfUzfoBciZIWImHISuO7hJaq5tB2TDkZN
    Iokx335O-hqiA>
X-ME-Received: <xmr:l3ZTZD0KtiqRgn-3SQbRihv1J4hLqYD6f9hv89fGXjzCJyc90Dh16UG1cpZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeftddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:l3ZTZCCW1Fey0fws4YZPSMxhoLjLO-ZnSH_iFlUn-r6kUvedozARLA>
    <xmx:l3ZTZPhvKMa7rzF7B-QHuCHpjwstmj_u3vZOE8h-i7x_eyDQ9qNrqw>
    <xmx:l3ZTZOoYV33YUHrsNzjpUzED5oVAwc3-zB_bwT53Wqo29G1ZTu3-9Q>
    <xmx:l3ZTZOTO56IvJDvwrPaAuGImd1YAWfx9tOaSxfHvn19dftYGZcx0gw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 05:10:46 -0400 (EDT)
Date:   Thu, 4 May 2023 18:10:42 +0900
From:   Greg KH <greg@kroah.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Message-ID: <2023050410-rejoin-vocation-8560@gregkh>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504085506.504474-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 04:55:06PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With the clk names specified in clk_bypassed module parameter, give
> user an option to bypass the clk from managing them by Linux kernel.

As I said on another email, no, please do not add new module parameters
for drivers, this is not the 1990s

Also, another comment below:

> @@ -310,6 +357,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
>  		root = &root_array[i];
> +		if (unlikely(imx_clk_bypass_check(root->name)))
> +			continue;

Only ever use likely/unlikely if you can measure the difference.  Here
on a probe function, you can not, this is not needed at all, the
compiler and CPU will do a better job over time than you can guess at
this.

But as this change isn't needed, this shouldn't be an issue either.

thanks,

greg k-h
