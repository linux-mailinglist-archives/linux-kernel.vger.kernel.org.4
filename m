Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66914609B56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJXHbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXHbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:31:31 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D14DB42;
        Mon, 24 Oct 2022 00:31:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7075332002F9;
        Mon, 24 Oct 2022 03:31:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 03:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666596666; x=
        1666683066; bh=Jjbu9JpIyS5CWKze1H/WOBDw+6BrnxDllrzE32pyM2A=; b=V
        8buIz1jixNkr35PMRGseRhW44dRYrPEwOxEYO9BX2M4O9X8EBWP80wZUAPdzIhTS
        6Z3ODm20WXMWoVDbbat6zBwSjdwOLag4fCoeoqUOwHrVvmTOvlhmftovFpDwWa+A
        p1ci8MsyqQWs56tfrQ9xIIha5co9nOr1kVqjf0dXBdBN5x+Xu2a8d9g7tOo07FYP
        U1gZfm7MosCZW2BNe6bYdeIF0rbH81NsOIfL7ihwlZDGr+hO3wt9DGtCDPv8h2BX
        yzy9GfT6wfXHoWrdMGd6rXu8vxwT5qsS50pChylVtk0EiAtnwZX3jHJQnXP4as92
        5Gppmo9kBmr2n53teijcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666596666; x=
        1666683066; bh=Jjbu9JpIyS5CWKze1H/WOBDw+6BrnxDllrzE32pyM2A=; b=e
        xqIxGFS54BYZ0dII9pSZBFttWOx9RNcCB63ydbcRqXmKBv2TM6zy0bbyAnhH1CUO
        g3cSFmuAWmCQ0Q0iBDKvWA+6xdZp15Rv5aSf5jVL/BEVRYKxNtH/n17dPaQ1rL/0
        9frOxLW8vGAUqbKRX4eTl5ggIOGXF8xty+9B6kvTC4+pi5dA8svuZslfQrgcUV43
        d6od4y5GdaHsJCTeYdjqJIWCxkBNOX7PcA4IXNQHzOEsDXOzTjfXiAOa2bzFsIV9
        zzgsbs4RRO9EsFKWOnfYa+F70U4kk3U127wFzYxoZUFv1oFMl06q8uudBhdpFjdl
        VcE6Y1q3tOc1DeS9g3fjA==
X-ME-Sender: <xms:OT9WY7p9AJwVQEmqn5ZXnIPgt-smgsXb5avN3HyEEYeyIyIu_if8WA>
    <xme:OT9WY1rAmFitzlJIvgew2I13Lacg-JkZ0IqEsB5nUc_7cI1wvJo9jP6AC7XYFIspV
    Bxw-9zc38VI4JlZLEw>
X-ME-Received: <xmr:OT9WY4MaM0xUrkmVVKz43JUcFssysOEz7n5RSPxhNAFuATdcQMtf7STAfur48bK4fel-6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepmhgr
    gihimhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpeetfeehfefgueejud
    fhueegffelteeuuedvhfelhfefjeetjefhtdfftdfgvdejleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrth
    gvtghh
X-ME-Proxy: <xmx:OT9WY-5nO6tFm5SivglfFrYHBt0iUdGKW9Sf0SKgBPf4PbnkacQ_pg>
    <xmx:OT9WY67YVrfPNNn-QH2hxcmL4ZV5qVkOS-8ebT7z0ZchPKNb22TTnw>
    <xmx:OT9WY2gy9TuqChiVkvAWP3QL0Aq3Sa3kvL5KUD7sVz_6jvgkrA1_ZA>
    <xmx:Oj9WY5TBSuMD22MflRmdFav_7arvBkIZ8u8G3268iypECFgAQjEj-g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Oct 2022 03:31:05 -0400 (EDT)
From:   maxime@cerno.tech
To:     Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Colin Ian King <colin.i.king@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20221021084035.65367-1-colin.i.king@gmail.com>
References: <20221021084035.65367-1-colin.i.king@gmail.com>
Subject: Re: (subset) [PATCH] drm/vc4: Fix spelling mistake "mmaping" -> "mmapping"
Message-Id: <166659662709.12501.1270368575435453931.b4-ty@cerno.tech>
Date:   Mon, 24 Oct 2022 09:30:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 09:40:35 +0100, Colin Ian King wrote:
> There are a couple of spelling mistakes in DRM_DEBUG messages. Fix them.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
