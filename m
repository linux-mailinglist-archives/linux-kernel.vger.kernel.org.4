Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F065723369
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjFEW5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjFEW5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:57:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89A7DC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 15:56:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 302335C06DD;
        Mon,  5 Jun 2023 18:56:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Jun 2023 18:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686005819; x=1686092219; bh=j2
        rOiLTkAGr2XEigSY9BTteaFVuwIDk0LFOAYVeml4E=; b=X/ZB7uUcooiHky0lza
        KVWH4o4S4qMyi6/qQyFdg+bNSvxNWA6b9dbhkQtqwPL54cnxKcQLNI4klpAsQZWS
        oJI9zeXunIweCn4sRZneRFjR/O/QLTuFZmELAp3oj/zPnUDRMqAf/u7UO3ErLHF1
        YfGHm5KzASTN6oQufEmo+drVQrGJWUg4MpZLg/1zZ0veKaQGZIG7lOQStWo7uo6c
        fvm4Pqfj2qw/GZnmBoomQ5DOQgoBRX+qKa9CUqKeMUgUqkW91BDyjark+oHsR47h
        pSsQnfWjLwWtzMscbQoHhucM5GU7y3lsjdYdz1ppgXVh4Z4vTL9s5w8N6++snqo7
        qgzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686005819; x=1686092219; bh=j2rOiLTkAGr2X
        EigSY9BTteaFVuwIDk0LFOAYVeml4E=; b=KQ/jf5jEU7pnPjg7EEnRMxkEXiyTj
        bnnBLhH812RqaOjnrDovO6V3xkwt6TGGpMRd2frsfQEb2DF6/gPl5VfAsS/i8lu4
        KAMdmfCrdJBvo7/ZSuJeOKHDh/XPeXYakh3m0DkLGWSchyEn79iP4Lkt7xivjRwT
        fAS3XVdcjQ60WqT8q7/PRWErpiOBN8j/RpALhh+q5PcvT8gOa9vYQI69Mw7Y1UUW
        SALWT2rAypOu75SHo+i8Gt4WTYKPWHRWQrQVw1bS3ZZuslWXOo9jQtgHa5+ZTYNr
        oS+pa5aSfSXPgDNsWCzb2Rs/bUkGH7uPfxt8PdaWQhjKXAOpP1P3uC+GQ==
X-ME-Sender: <xms:O2h-ZGesdtYurqroN9jkec1KuOYpgUkWBS8O0LSfsTprIe5dRCmF9A>
    <xme:O2h-ZAMOVniAInQRugDRs3z1jsBk3FejJPnXmq5-pmf3w_l04wuOcIKfJUxFq98Ga
    kqclZvTqjSxb7kijGE>
X-ME-Received: <xmr:O2h-ZHgBXwkfAkdAin5FzIdaMF0ynLDuQQX1jl5NaZMHAMWAwzJf5jC1rQ3kgfrC9ThNUQZuGBnbc9A0b3PVsocg8tANz5no>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnheplefhueegvd
    ejgfejgfdukeefudetvddtuddtueeivedttdegteejkedvfeegfefhnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:O2h-ZD_cSAjmWlo02_hqanJYtya-2B7LCLym_myOfec1Wpr-zqg4wg>
    <xmx:O2h-ZCslPuUFB10_HnNg1BkymqLSpakHp6_FkMEC_y9ybiFtSYxckQ>
    <xmx:O2h-ZKERZX-grjMkM_ckEP7R9Ggs4nkSpn7D6_PJfpAbmf0wKVzk3g>
    <xmx:O2h-ZI3VzR0RQx2R08IqpPJ05Mk4V8iYkB-O0Xtas716JUV2Iy9HUg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 18:56:58 -0400 (EDT)
Date:   Tue, 6 Jun 2023 07:56:55 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: obsolete usage of GFP_ATOMIC at building
 node tree
Message-ID: <20230605225655.GC178739@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230604070255.172700-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604070255.172700-1-o-takashi@sakamocchi.jp>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 04:02:55PM +0900, Takashi Sakamoto wrote:
> The flag of GFP_ATOMIC is given to the call of kmalloc when building node
> tree, but the call is not atomic context. The call of
> fw_core_handle_bus_reset() and fw_core_remove_card() builds the tree,
> while they are done in specific workqueue or pci remove callback.
> 
> This commit obsolete the usage of GFP_ATOMIC.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-device.c   | 2 +-
>  drivers/firewire/core-topology.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto
