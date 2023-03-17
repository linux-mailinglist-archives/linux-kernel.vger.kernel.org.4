Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63B66BE256
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCQH5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCQH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:57:44 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DA8A9DCF;
        Fri, 17 Mar 2023 00:57:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 63C163200094;
        Fri, 17 Mar 2023 03:57:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Mar 2023 03:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679039829; x=1679126229; bh=HH
        5mSoKeCDFL5MPPTYOG3eK7UTiiQQAH4drXFEK0xeY=; b=TtJREXn47myAL1DyQJ
        PfEToOoKmVQqdPsScQhfuB966xL3U1NyexBp1buTXyfzSkE7zU5settyBSAuWoAi
        XIum3aMvD9JsOcCNeZF1RJi5RXhl86uHUWIm/OKGR0a4aKdyC63Or/2h/86Qkgbp
        9SGeKE9nss8bO/w8ZJ3/3yckY+2k7q8A/bZc6VxoSzcNWDml2kBWSlScIPbEt+lw
        brDKE5HRuuyReaIKruTqbM0YepJmYNyLsB60eyKsjrmZiLAGCINbShEWodcFsrOK
        Ou3ImfKtnVq8708SfEY2hi548hjnuEoEireiRKGo8U+BMGBxS9tEC40U/gqFYWwW
        TOrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679039829; x=1679126229; bh=HH5mSoKeCDFL5
        MPPTYOG3eK7UTiiQQAH4drXFEK0xeY=; b=Iki4b9XJppVXoSefSosAdN8ZjUMHq
        mUss1rpMxe/mUKEyNsvbZFY1Yun/R8hiaIMAUbc668s3c424egCgXL010P7KXSmD
        EfYoax7Q3OS9c67SgsFsfZnzskcsVQc/PmLmegJvNa2UxQD2Vr31kl+C2wuIXjKz
        9TuWqDMPsVBtZL7JSZOlFfx9YuV4YUOLzf2H2G83eY2irFo6CBB8E1Vhck9WrYtC
        QXWHq841RXzPnFbAc5OzOXCZT/LFHBbKsHkhkvgPLU+Nri3OdGHAO3BAUGpAdU+I
        UJqoaiquHzklR1+Nk388fqydDO+/xoCPBlkGLtkkw7SR8+u8+73wPd2dA==
X-ME-Sender: <xms:VB0UZFIdA1Nulf-SZznbpCuyLIPc9R1xwgEyHxKT7LHAtksUtD4L9w>
    <xme:VB0UZBJEOZCFirhpMMPxifF9gcHeVmX-7qsl64Bhpebb6wSA-ydD-EeXofQbuj1R-
    iIDpg5NhB7qk_W4xMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VB0UZNt_gi_a7RFFvG0nmoJieqjmo6TqqCnkJFk4-GL26ohc5G3xMA>
    <xmx:VB0UZGaeNobtyE8Pj3HCvoS_byjKUirqmZdpM3IV_PEWtt6gLDIEcQ>
    <xmx:VB0UZMbZ3O1VUSuVnz-phT3M7b_yYs_2unYyzLrDzFbEZPJxE4Ij3Q>
    <xmx:VR0UZEEzmeyPhgwCBN6iI-tiPKg5PPuvOjU03UTLkFP9MUUWx4nrbw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BCFCDB60086; Fri, 17 Mar 2023 03:57:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <01b8aa89-2de5-4f98-8b93-659022c7e8e1@app.fastmail.com>
In-Reply-To: <20230317071538.29366-1-lukas.bulwahn@gmail.com>
References: <20230317071538.29366-1-lukas.bulwahn@gmail.com>
Date:   Fri, 17 Mar 2023 08:56:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: remove obsolete config SERIAL_SAMSUNG_UARTS_4
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023, at 08:15, Lukas Bulwahn wrote:
> Commit 1ea35b355722 ("ARM: s3c: remove s3c24xx specific hacks"), allows
> simplifying the whole config logic for SERIAL_SAMSUNG_UARTS, and did this
> config simplification. However, it misses that SERIAL_SAMSUNG_UARTS_4's
> effect was just to control SERIAL_SAMSUNG_UARTS, and with the commit's
> change, the config SERIAL_SAMSUNG_UARTS_4 has no remaining effect and can
> be deleted.
>
> Remove this obsolete config SERIAL_SAMSUNG_UARTS_4.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Nice find!

I tried to carefully check that all Kconfig options that were
no longer selectable got removed recursively, along with the code
that they control, but I missed this one as I did not search
the other way.

Acked-by: Arnd Bergmann <arnd@arndb.de>
