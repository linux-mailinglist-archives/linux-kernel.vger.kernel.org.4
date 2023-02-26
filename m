Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BBE6A2F1A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 11:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBZKYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 05:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBZKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 05:24:48 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDECBC65B;
        Sun, 26 Feb 2023 02:24:47 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4645C5C00DB;
        Sun, 26 Feb 2023 05:24:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 26 Feb 2023 05:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677407087; x=1677493487; bh=qvprucDJaZ
        MPGC2xxQDJGF4hnoZoF7bFF2Ldncdq+yE=; b=OI6MSH8tehUg+t61CTC6oBr3tK
        BagtQQc4URzzPmCvMIcefcYHkeoj50796rbyZ9/RJmx/ZIXs+gxZjDTOJSMY/Y6m
        bWk1DYSQlTrWE7FHYfiIZNOk+JZ4q0gXMHCfzwc0+U1/Ozm9ppchzU5nkdsPwOsJ
        L6+iDv5OVXTCqhfho3xTsDaV0LEix46TNePpteDqEBMNP09Fy9Ccv8zGsHIwbVYv
        8gYmj1lUgqo1xrswDJuAv/qawHQL/b5q0XDvIxVNhr7mndeVXhchvyTBpx1xMEXO
        exV1gK14efpV0EZ/uMm/+gZOjMc73fedf0UDQDCkSJ/hLpwnktT6R5WGeZ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677407087; x=1677493487; bh=qvprucDJaZMPGC2xxQDJGF4hnoZo
        F7bFF2Ldncdq+yE=; b=PRmE3mnXSeWF2pOk7TXh5n+ECRx06eFYFNHqGpPffp5t
        OoAn2hroGJuIWdEKxo6bWxbgEk+U0cvvN6j6ODD31EECmoVFaRWf50ig7IConEs0
        yqKuTjFz+d2IFVBLiRpDkKc4K2Kl6MZn7X6I5lLx1hhsUUrXcrecoMMWKGZI4/wQ
        DDwwgh5hPIBFi3xTptf1B4IuZ87Stagr0uVIjSlYzIcSUaMN59BDw6QXaMo96YBn
        XXLKRdFDvqt7IRAzmqY3dDUtGEVC3FGHDJEp2sblJIQKMUvc+atppzvEvmSUJeRz
        NCYnpzqRNBxrvPu+UFcxhXYSHfFH8lwHS1PLCaV0sQ==
X-ME-Sender: <xms:bjP7Y2MLSakTKUF_D3wLDuOkhK_Zfb1VXTOjvisOqRDS45Yf-QfC1A>
    <xme:bjP7Y0_njlW-hqXBmLKntdURqk3V0krBfGvcgY29eTiTVe25fQmxPkeAtadwfL0Ot
    t6SnflKRRq15EJjczo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekjedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bjP7Y9TO3YfKUWSvJRd46fZ_bikekAHZy6_AUw1YksZRemHPP37d0Q>
    <xmx:bjP7Y2v0lul7D46mfmHU3nYMoy5tDuWLqOLM-QxkWZ9a1zLLkRwWYA>
    <xmx:bjP7Y-f3xW2n5UrgPJ45YMwHVIG37vSMEHKwPQxthhuntVSVpN6vhQ>
    <xmx:bzP7YyECEsKessVEl51ERGEMozqFhGHBMSWQkqqdG_6EbbbGZbvsSA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B2B4CB60086; Sun, 26 Feb 2023 05:24:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <29763841-bdaa-4a4b-aa0e-5e1b3935317d@app.fastmail.com>
In-Reply-To: <CAEdQ38Fg=Au5=BbyTHiEO+GaivheCe6hPBjcZhjgALxn4503Mg@mail.gmail.com>
References: <20220224060558.1856804-1-keescook@chromium.org>
 <CAEdQ38Fg=Au5=BbyTHiEO+GaivheCe6hPBjcZhjgALxn4503Mg@mail.gmail.com>
Date:   Sun, 26 Feb 2023 11:24:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Matt Turner" <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] alpha: Implement "current_stack_pointer"
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023, at 03:08, Matt Turner wrote:
>
> Thanks for the patch! This was included in my pull request today and
> is now upstream in Linus' tree.

[trimming Cc list for hijacked thread]

Hi Matt,

I remember that Stephen Rothwell mentioned he dropped a couple of
architecture trees from linux-next due to long inactivity, and I
see that none of your branches are included any more. Should

https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git/log/?h=for-linus

or the (currently empty) alpha-next branch be added back there?

      Arnd
