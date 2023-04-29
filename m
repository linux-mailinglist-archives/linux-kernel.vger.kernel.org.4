Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33E26F26FF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjD2Wgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjD2Wgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:36:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B68183
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:36:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A9055C00E4;
        Sat, 29 Apr 2023 18:36:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 29 Apr 2023 18:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1682807806; x=1682894206; bh=HA
        yiyUR/zUDCPBYNGZPvHnuHWV4W2fCgiDxxlkg0pCk=; b=qIreNi0nj/LPd1crU1
        A80YflKA8/aPp5DdIlvGdC4yvHDUlxzpI9aDAA6+Q6BYZCgvNS26IopJ02tJpvIg
        El6DV6oEedYDT/A5wDlri8d2t7A7/YYzHvOXENNI1Z+7D4vikb519F5/EMSWaZre
        Aqvd/r/5gfyQVq/xVEhJ+9QP9DIyvI0EuSCe/me0/denGoPY9AmG+8g+M/UKzdpU
        RwzshAeZIROUC5eDcTTuuOLGrWltygXnzKmd8knpocCd7mANeBtbMWUZYa+6ti8+
        51sXPe0hvyTj6B2UP5ERAycaDmkn7reNVx3iRrtFwHhDk7YYgXQk3Te40PCv5T0t
        knnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682807806; x=1682894206; bh=HAyiyUR/zUDCP
        BYNGZPvHnuHWV4W2fCgiDxxlkg0pCk=; b=H5savcPa8R1F97KMHiIm+J4cyEBWz
        3hygslyvZdiccoHGPW6lhr5JugTxJOjcm6Zb9Cuq989U6hOgX1EwJTdDBt5QB3+a
        gCxKNyKSCHSLXVz0azwGtanWmmYFLh6PxKMmKACu1vBChu5KWLRLZNOCmRYQ3Hwb
        iSo4jZeFS/WqIhJXm6dMkngWdnEBJ6qhPUvz31u4G+nR/iaY5UmKT5abixd6xwxy
        xT5EZnsuim3iAV0/h9a5DIivG1/DLkpdRpMc6x+YPtIAs5IlUKM1JuGUnRn047Hk
        8Uddjk25zz+AlurkAHRy7uhCn0Ycl0erBMeYHmkWNrWL9cqoUr/URiZFg==
X-ME-Sender: <xms:_ZtNZGnBv_pQfxrfxWUwQEcaHmNP9q9mRMZO3pHFVXrmspYN0SAoyQ>
    <xme:_ZtNZN3LK64WxpEqIMWmMde1hNhTXU_nFEF4g_vdiKqEwUGKm-Twryt-MTMPPn4vf
    MJ242dhPK0IIh_y6e4>
X-ME-Received: <xmr:_ZtNZEqz6g7xSXtUxHnBfG6WluB0A4dSUwuzJ1omu29cNDQxzcHGpnl_39yiOhT4JtvC6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffuvfevkfgjfhfogggtsehttd
    ertdertddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghs
    rdguvghvqeenucggtffrrghtthgvrhhnpedvvdegledtheefieejgfevgeefiefhtdevte
    efteduhfevtdefleethfetgeeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:_ZtNZKk-HvBk68GoWCX8PlG60isAM3rjbXQRWzg71rnf382-vxecQg>
    <xmx:_ZtNZE1IPPdKlyEuk9v5X5uiOn10t_mBpDbx3XLksqJjXQbpFX0LOQ>
    <xmx:_ZtNZBuTgluOhwQwMyRkRZsF9H2IdE4rSsWNrAKJeCEbtAWtiTCa6g>
    <xmx:_ptNZFi9-NBDTjmEJnpgwK7MZvWocpQOxXZwDYe-j_Xq5HNXgm1VGw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Apr 2023 18:36:43 -0400 (EDT)
Date:   Sun, 30 Apr 2023 10:36:27 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH] drivers: fix keyboard not working under some laptops
To:     hqp1203hqp@163.com
Cc:     linux-kernel@vger.kernel.org
Message-Id: <RSEWTR.AGD3LFFAJV9D@ljones.dev>
In-Reply-To: <FLEWTR.R6BA7U7SGOH71@ljones.dev>
References: <FLEWTR.R6BA7U7SGOH71@ljones.dev>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Additionally the patch isn't generated correctly.
In your main git of Linux kernel where the last commit is your patch do 
`git format-patch HEAD^`
You should then end up with 
0001-drivers-fix-keyboard-not-working-under-some-laptops.patch

On Sun, Apr 30 2023 at 10:32:03 +1200, Luke Jones <luke@ljones.dev> 
wrote:
> Hi,
> 
> Because this is a quirk sepcific to the FA507NV:
> 
> > + .matches = {
> > + DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > + DMI_MATCH(DMI_BOARD_NAME, "FA507NV"),
> > + },
> 
> perhaps the patch title should be renamed to reflect that?
> 
> I have a user with the same issue, I will confirm it fixes the 
> problem.
> 


