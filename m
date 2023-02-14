Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4432695966
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjBNGqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjBNGqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:46:43 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616F3C33;
        Mon, 13 Feb 2023 22:46:29 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A36EA5C009B;
        Tue, 14 Feb 2023 01:46:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 14 Feb 2023 01:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676357186; x=1676443586; bh=G47oN00g1d
        0/6Bukx9sKnshfed37QJgITudDOuHXPd8=; b=w1xPkeBrIztjyU7CYZ0DxRCrE8
        08TkmvFoRbhaqExiZMbAFYEHiZGkGsd/ZUeesWMhVIqf81+ZNRnjr/R3scqHzcxe
        5P+Qu4FC35omz0GDautbAhnJRiulSPKmRJ7IdPreHuGeO2MOjsaAeGoO2NAG/DLw
        bo660G08rg0o7bzlYgMAG8n59pcuwmgEOEDGMwbwLfVL9/CHCXyUAq6/oyIFEVtj
        6fIiSz6mSspJeZBIFcm2ewuNiRzT4L466SaM2xdghngF2ZcTfMlVCOEFJajJFFEG
        qGenCjPh+TBxDZAUb+ivWLxky9/tFdECkEyv2E028xUM9txM6CSgDjU08hvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676357186; x=1676443586; bh=G47oN00g1d0/6Bukx9sKnshfed37
        QJgITudDOuHXPd8=; b=a6eDQaN7CTyOBeHiCyjLy5sjF6plZ7uBAUn0jcUhK8II
        Lp4tacfUX1A6bcAKwtSw8kXpqS2vr3Rnne3R9w7Ui9VYNaysL/2iiIIhAVK4ZrRC
        PKI1lL+cBPSITMLZ5xD5V+4pi8qkgn2AmjRT8wNjmA5t262EJUgaeQEnf6eWjQG4
        Bvy9CxnX+LwchE05hFPIgRh/OGn/8vLYoyjPP37BYYdUpDXqqIm0+Ik13fLx46bq
        VuKFZfxxAeueJxW6NU1CW4X2UVgH5gdv+woewwenIBGx2kWp53rf0+mqdfD1Pjhz
        NgdFXshy2kizJyuskn9VfCGuhB+HkhnOyYc5ym0ieg==
X-ME-Sender: <xms:Qi7rYxZZD-vRjtWAxnIMPckD-ma6v5OYA_53GPFY9ZpIXYYBmPtLoQ>
    <xme:Qi7rY4bO0FuHHKWkmLsjHQ-nyEPpr3Fol5lP08U6gO3_hTIBnjnCI42JrcKOczWBK
    sjNebWcTKan5A>
X-ME-Received: <xmr:Qi7rYz-rXEDx5B8Tb9SX7_l0UaCIfxJURqwEJ5DcpFT-X_Z-COmj1jZATGFg1q3okwMe9TWC7znpVg9RE13FQ0ckSMH-ynXsBh7Xfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeivddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:Qi7rY_rvRm7D7TnpO9Rip1nWsqVtmiWfZtWJ3JvIU_Uqc1hkvnz4Uw>
    <xmx:Qi7rY8qNivL9PmTejqoCus0m-ytdt_CffNKQFA-dSDLGNHR_WKgUzw>
    <xmx:Qi7rY1R3gCPwkEkQbthlMXs2PYPLy2yWJeoD4TztNW1Mpq8sn3m7Tg>
    <xmx:Qi7rYyh_UGbsICN-4pzwFQiFDaAeDq3LHWb1SRU6rj9E_-Zs2sOPUA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Feb 2023 01:46:25 -0500 (EST)
Date:   Tue, 14 Feb 2023 07:46:18 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the qcom tree
Message-ID: <Y+suOl05ZLc49lcu@kroah.com>
References: <20230214124001.5f5341b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214124001.5f5341b4@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:40:01PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the usb tree got a conflict in:
> 
>   arch/arm64/configs/defconfig
> 
> between commit:
> 
>   85d81e15862a ("arm64: defconfig: Enable DisplayPort on SC8280XP laptops")
> 
> from the qcom tree and commit:
> 
>   1f6d59f7f82d ("arm64: defconfig: Enable UCSI support")
> 
> from the usb tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Merge looks good, thanks!

greg k-h
