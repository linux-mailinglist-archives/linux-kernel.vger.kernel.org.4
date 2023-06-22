Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608EE739829
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFVHd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFVHd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:33:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DC41BE2;
        Thu, 22 Jun 2023 00:33:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 794A35C0107;
        Thu, 22 Jun 2023 03:33:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 22 Jun 2023 03:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687419202; x=1687505602; bh=WU
        F2UhU/KYpd5ixgintGJLSlQSYHQH6noEbn0rcOCAo=; b=BWH1CR43qIrEMs94NM
        hR3c+rrpKoLb0CNWHWUWqammPY6EyrZGHJH7gm/eav4fZ8ZN6SP32S0jo7RhDCii
        M1vns51Sp/cAIGNzv+NLNCRsPigdrKxWU617JfvSrRmD2/fwiL+uWTjXY2XwKdjL
        JPdZTQJpyqQ3oroXV5h3t9pt2ddsZeB7udFMxpKoxc4HMElYy1eJ0Y3Y3yw3nOUa
        RhHLvy5B4KeUw5DhepnHnDubg52VHqnfhOk8mS1QC7PazYVMCIWT6JiFGiTP6rdy
        Oz1YHjM0RteuvBlpxi8F488tp8V/cW7hZP45qk4rguQXdpMuOgpdFK7ic9wCtgJb
        bbNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687419202; x=1687505602; bh=WUF2UhU/KYpd5
        ixgintGJLSlQSYHQH6noEbn0rcOCAo=; b=JPlV0SzDfpET0SkJeEChm1+j++VvA
        rA3j/5bMjCPw65c4a+lVv+2GENORZi878NkS7M8AytJ+Wfls7HYnK5d+ZVxRpefb
        zafJsTXVmDXk3QOPjnk+lFmj23/fThqeIOVT+qUoRGMiapNTyY3w02sDEkhy5zo0
        qosTWuvWMcWfzLiBCCHR2rj5i+2h0Y5o9DJ/+UrjnIuQp/ZwJas6v+ZLhdpT9zLj
        AHzN1ZFE1DaYppgSflYrYPhjgjxcb0Lupx01mP4JD1RemAKJ3YQ/8g/G1JZf6nso
        AWgRpGp5BxU0WidIE6P5B6bntjkk9DV6hpgyZrKq1Ic2XwXHnLkmztXXg==
X-ME-Sender: <xms:QvmTZEkQStOU5RT2YsGYOZBlUZK6MVT0gHi4sKboDlrVQZGFVy-E-Q>
    <xme:QvmTZD2hbBpR7fQ3IdQf_y4_OerkLYi9xI5fAY3MHP6B2QiB22pK1ZDL7DwPZFbRH
    WVUNCTusUc-7w>
X-ME-Received: <xmr:QvmTZCrNuVpgJQkRnkb1CfuUWINeA1s7DIGme3oN-fW-ndvSoAOKuGgQ600QtQH57asVT3rvknHeIfNYA31yQ9TKLq5Xmo2YAKMA6J3o-eM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegtddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:QvmTZAmDC2Nz_eo5X0Ej2vid4ZvSRNgSKwEH6cRrA_cS_dQBYj6wVw>
    <xmx:QvmTZC2lMFrw5jjOZqRw5jlvcT3Kdp9g3pl_1dZk64vb7Ljlk4c4GA>
    <xmx:QvmTZHtef-cUdgagJYFA82TRAG04uf-nlg5U3sCE9yP8TgvBMZFBjw>
    <xmx:QvmTZFTUdD3kNwh3ea-kwpjDRdDylbc6ShetnBml7SpeElM4enhNCg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 03:33:21 -0400 (EDT)
Date:   Thu, 22 Jun 2023 09:33:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Ronald Warsow <rwarsow@gmx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
Message-ID: <2023062218-glisten-estimate-66bf@gregkh>
References: <c5ee96f9-1f93-3eca-6560-b8367cd8d124@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ee96f9-1f93-3eca-6560-b8367cd8d124@gmx.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 05:03:28PM +0200, Ronald Warsow wrote:
> Hi Greg
> 
> 6.3.9-rc1
> 
> compiles, boots and runs here on x86_64
> (Intel Rocket Lake, i5-11400)
> 
> Thanks
> 
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
> 

Thanks for testing and letting me know,

greg k-h
