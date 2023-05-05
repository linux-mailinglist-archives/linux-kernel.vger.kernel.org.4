Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB526F80FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjEEKmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjEEKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:42:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4D12087;
        Fri,  5 May 2023 03:42:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CB9D5C030C;
        Fri,  5 May 2023 06:42:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 06:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683283371; x=1683369771; bh=RC
        TWVk0KOAVQ/MkChme+8/6o8h9CkRTO4hkaOFGb8H8=; b=Bz7cz1oUuN9Ila0jCg
        gsP4cAo3R88v0BuIlQw1Iuc/Jj6Cj7ZXE9Fshdcm/j3oLmC4sr5jhqeNzc9p244X
        W0eLkFo/G1Z/ZC1YyMBGKM2xwor/lJ6H8k9vcz6KMSOTVXZLOjR00Wknyf7QcCl4
        t5gzw0uAid9TThPkEfNxHiS7M76D6UYONrLWramwxBm68cGMXuUfPCtxj4lFJo0t
        KbQ0QmzgnPxYW8n/mHyNyGdoCl/aruEtt4cKDmlmmmHtaJ1cjCqlraTijs710Tqr
        Sgje05/RuvhRmmMjF4kqoX5QtwiucfxcpnBsylSWqUQ0CQtGD11Pp9I/aNTFn8sM
        l4EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683283371; x=1683369771; bh=RCTWVk0KOAVQ/
        MkChme+8/6o8h9CkRTO4hkaOFGb8H8=; b=RqXJnCqZQliMjqwLuDeWV6/a8f/8w
        Ex08I0VVzwluGBAFMlMOsi04uS+XzUJB8SVqq4e1sNrsKX7sDjPKNHn2EQG1Eq9w
        Es9fyZgT+upuxBCRw/feo+jcDAgeeSEZGJik2zalGiOKJTG2OIvVedodQl0F2hyX
        yMGoHCwfnfFK3d6G5FZRWMTCD8PKSjz4vN69ycV6YrkDkEmiAIPJXsIlVIZZ78t/
        D2nIYuUANhFurxcvLdV3MMts9Jz3LDeaIXkg2oLIFObfoPY2IjlU0m74402AUcPR
        Fz2LeYE8LsBr6BJeQyAQP+H6H15fWfe/AVu0IM2T7gpL5nxc44wmnX7Gg==
X-ME-Sender: <xms:q91UZEtqwzQfHlBVK8mMUtYYGXFHothsncvoO6cgnAUdoole3iQJTA>
    <xme:q91UZBfAzVecWUB6Rspa9NELo2WaOtSeOhB5qNbzwcivY0AUXwfBfwWrtPrVtAoeg
    Zbm_5Oe4BxegA>
X-ME-Received: <xmr:q91UZPzLwzvzEplPrtZlnBrpRDOJLLVFBJQ7pMqO9iSW1VMWy76AOfOKqHpS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:q91UZHOu1TTFc2_K8TvRiOMUtur5kvxN65ASjKvMFVXWiKq57x26Nw>
    <xmx:q91UZE9d_kEYgYuEIa7CD_-TKyzu6wMDuBp6W-Nl0sczL7KMf1edgw>
    <xmx:q91UZPVQ3ai0cckISVAcXEuDgeCcTwI4Hqo5bsVXEkqSVA_ETw6-fA>
    <xmx:q91UZAuGKvyPNXUwWWOc0qPH82LmGpPhyNoID6R9ibALztDQ9XNsVQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 06:42:49 -0400 (EDT)
Date:   Fri, 5 May 2023 19:42:44 +0900
From:   Greg KH <greg@kroah.com>
To:     yixuanjiang <yixuanjiang@google.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-pcm: Fix and cleanup DPCM locking
Message-ID: <2023050534-errant-crusher-0379@gregkh>
References: <20230504092142.4190069-1-yixuanjiang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504092142.4190069-1-yixuanjiang@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 05:21:42PM +0800, yixuanjiang wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> The existing locking for DPCM has several issues
> a) a confusing mix of card->mutex and card->pcm_mutex.
> b) a dpcm_lock spinlock added inconsistently and on paths that could
> be recursively taken. The use of irqsave/irqrestore was also overkill.
> 
> The suggested model is:
> 
> 1) The pcm_mutex is the top-most protection of BE links in the FE. The
> pcm_mutex is applied always on either the top PCM callbacks or the
> external call from DAPM, not taken in the internal functions.
> 
> 2) the FE stream lock is taken in higher levels before invoking
> dpcm_be_dai_trigger()
> 
> 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> lock are taken.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [clarification of commit message by plbossart]
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossart@linux.intel.com
> Cc: stable@vger.kernel.org # 5.15.x
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/sound/soc.h  |   2 -
>  sound/soc/soc-core.c |   1 -
>  sound/soc/soc-pcm.c  | 229 ++++++++++++++++++++++++++++---------------
>  3 files changed, 152 insertions(+), 80 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
