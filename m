Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82A742B23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjF2RXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjF2RW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:22:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4D10C9;
        Thu, 29 Jun 2023 10:22:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 42FED320099B;
        Thu, 29 Jun 2023 13:22:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Jun 2023 13:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688059375; x=1688145775; bh=Cw
        E2wcHANU3ek6A8gHn/xl6f0ODbgDTZqECgroPgqbw=; b=KmPDis3AAUdV73TLXo
        3OgDknDtNClg5x81qOb965Qm5cYr8IvBdXhGCvghC6eXv81fiE9fG56quzNDzZst
        /45f3i/zaf2LLN5iCHJQZ/RK3D1QpoqRKUl+8v1fSucJTUF6UJfVar0BDZCQ20Hn
        l+liTEg46Hsd1sng3DdI97pvvFC3kwBWeDW3nwt/uejkcN0J/mk/Y1a8yJDS8bqa
        JMIAxG1Gnlpsr2aM/GkAJzYUPxYnlfZSJ7ZZs6WeYDdcEX6dmVN2SHx0DfUmQX73
        G3/KbHUY0HSz5fHQkbbibFsIsYYtYvP9Y4nJ7mqAHyX83IHBR3X55NcLf7C5gli7
        p6xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688059375; x=1688145775; bh=CwE2wcHANU3ek
        6A8gHn/xl6f0ODbgDTZqECgroPgqbw=; b=P60oOGRwftxmCUZrRzMi4jW32xc8n
        x/eFQb0AcAT1TPGPGifej8BeSyum6UHdShIH8Vel+XbjhTR6dFf6fx7hhL9eYBHC
        8AxQHRCA40a+Q3uWnXXz5wYSAgyTbjqkEjfI8xiy8QVcpXMJy9WWReqY2RA84cCp
        iGz5Lv/Sb8T2zUE0+ISKl2EI4124iK2EICFrWM3mG4XV0hFRnJHrWmi8Ljtg2xhc
        VNaBBAhLyGJZq/4zvRjcmREb60gX9pXeNRgxuGni8h4vTsd/Bfbbkp8fH8aNDhg6
        ubhKsArA6i2l9ey7ciIKEqbX0PU9A/Roz60ygeg9HF4tQ2CLdynNmpM7A==
X-ME-Sender: <xms:7r2dZPDLxq62M1kBStgKsfRuxemXsMrZzXVBnqFElAp05hW8nJmkZA>
    <xme:7r2dZFiRFG8Vyjfyo5GhZZyIwFPE8E0ULnZ1F0bEAKRiKa5s8MlxBpnlzf35RQiKx
    qOf15zr3vC0aA>
X-ME-Received: <xmr:7r2dZKlK1wqTzcXBRUtDDIvakYJooS_zGMyatWd4F6tGlD1OsJtLccEUQulqVE9rJAhJ5BUgmn8kdxg-RZShi0K_UonVJHaFC8H3ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:7r2dZBwMbrF4faEtgoZSd7eeg0wEP9Tyhwjf0jLldB286bmYrr_RrA>
    <xmx:7r2dZEQU0Bhnx465BF7A7M9TFiqIYiSbFYJ6-6EjLteV3BCe3mu5oA>
    <xmx:7r2dZEZVZKrU2X_BeAWA3KAVFrEfgS6uSQJJTwTqYP8MvMsHwG9Wvw>
    <xmx:772dZDCeQFPJcEKuRI0bDql2RgH-aTbX7IKfOHr2q36_TPqSiQbNRA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jun 2023 13:22:53 -0400 (EDT)
Date:   Thu, 29 Jun 2023 19:22:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-ID: <2023062958-thumping-ambulance-7a2f@gregkh>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <c22fcc94-aa41-4ffd-bfe8-f0b9f15a76c0@sirena.org.uk>
 <2023062940-snore-brick-419b@gregkh>
 <9699a960-74b0-4064-b264-6cde06cd16fc@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9699a960-74b0-4064-b264-6cde06cd16fc@sirena.org.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:16:44PM +0100, Mark Brown wrote:
> On Thu, Jun 29, 2023 at 06:06:05PM +0200, Greg KH wrote:
> > On Thu, Jun 29, 2023 at 04:43:57PM +0100, Mark Brown wrote:
> 
> > > Won't this be an ABI change?  That seems like it'd disrupt things in
> > > stable.
> 
> > ABI changes should disrupt things just the same in Linus's tree, why is
> > stable any different?
> 
> This is a numbering resulting from enumeration thing so it gets to be
> like the issues we've had with the order in which block and ethernet
> devices appear, it's on the edge the extent to which people might be
> relying on it.  If it's causing some problem as is and there's a reason
> to do something (see the first half of my reply...) but the case gets
> even harder to make with stable.

It shouldn't matter for stable or not, if the change is acceptable in
Linus's tree, with the userspace visable change, then it should be
acceptable in any active stable branch as well.  There is no difference
here for userspace api/abi rules.

thanks,

greg k-h
