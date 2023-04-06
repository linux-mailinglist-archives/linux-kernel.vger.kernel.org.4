Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D56D8C63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjDFBEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDFBES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:04:18 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B31BF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:03:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 517F05C00C8;
        Wed,  5 Apr 2023 21:03:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 21:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680743024; x=1680829424; bh=G+VpNFtuncxUDEgoI/atZKVndZKoswPwPSI
        ZKHYrtho=; b=egKZWJ9CCJTrGBRVKjd31TqfSpazQS2GZhb3mjz01o4SiY2CFII
        7IvpcoGviX9PYqxx1zDwq8zonCeVyXoRDrYtm1NF2qAETvpYlLnhnQEV9bjCqUb1
        TR3cLdDX/ZPgkgs3Ie3XSis5bdwhOUhJJ03AMiFPREW9d3Z7iHilhUqRXOSPjp0S
        QOLM2qA3CN+DSG3oT1Aib21/3M7PdedD5WGsf0wKlPHe8zbIZ4Zh/ZWGLA0AVEOv
        gQ/NPjI5UyTNO8LVp5uxgv5RJBcskiHqM3kpXddru68uIJNN239zhg8eqoFoLXq5
        TFnC1QtUGSQalvKef5V2nN1hiYVyqcmLu2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680743024; x=1680829424; bh=G+VpNFtuncxUD
        EgoI/atZKVndZKoswPwPSIZKHYrtho=; b=uqr1UZyDy4/RIKh/cOxVyM83btRw9
        95mgRTRZoYHx7lY9TcUZh3nj1BAkMcy71Dcz6jaaPydKBiuhrakByYjOTAjWN025
        P2cNqz3aUrzyMlV+1MyQEMKrmg5ao2/kNuxaXnfxedQJOtzb0xTv+KGIgALauskm
        RJGtAxkECGkSSJHydw1tcaQZ6aSyI+AtNzEBQdxetMP+tZBCdWXzxGNzzY5X0E+O
        MKtwkS/o/Uz7MV984La50rBaCMwlOm2JzAvOuH/xniDeQyuJl1qTToHbnUzAMR8m
        qDhWwixNqofESeSbavEafH8FZR3hWv+DltoHSBnS0+5JmTm7uS0hF+W2w==
X-ME-Sender: <xms:bxouZEJrjpUXcp0OpCKRhqy-2n73dFs3DgjWzvF7SW4vVM5-YrSt-w>
    <xme:bxouZEITzwaqb0FDow_mQ0J_DjWhtElYl-qVs4ujYO-3r8yf34jcvYJcsUQ_H6UuR
    aJNboiVa_CYJOT0cBQ>
X-ME-Received: <xmr:bxouZEvXsOX6aEf0qpl__4Ai2YvEYmSlhgk5aczKsDVcUKk4SElCTlnaflz7bR-kyLU6kHy1JgKx4hhBEJBz3qbcsOBPyLU-NWZN3tc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejvddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduieegheeijeeuvdetudefvedtjeefgeeufefghfekgfelfeet
    teelvddtffetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:bxouZBZ5wHXuh4AE2uL12uqejM3BsLMoZnSoL_kpgFsLjx2dPJwMvg>
    <xmx:bxouZLYWSQB8C9dX9u5euX1QdqkCyXHtfnOg9Cu95j8eL3zZlILYcA>
    <xmx:bxouZNDLNA7jaF7ZP8A1iUBz81yvgL7QUrfagahA9dXtlW-RrJsvDA>
    <xmx:cBouZP7xC8Wh0v9VJ925Nbx25Ht1VSOOl1JXnJFVJ5NS4trOWnGi4A>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 21:03:39 -0400 (EDT)
Date:   Thu, 6 Apr 2023 10:03:37 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sysinfo: Saturate 16-bit procs rather than wrapping
Message-ID: <ZC4aac9cO3PrvNrL@localhost>
References: <e32ea9a03d0797ce2b8e7a82ed59c0dad9431f2b.1680407255.git.josh@joshtriplett.org>
 <87mt3m7ynz.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt3m7ynz.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 05:27:12PM -0500, Eric W. Biederman wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > struct sysinfo has a 16-bit field for the number of processes. Current
> > systems can easily exceed this. Rather than wrapping around, saturate
> > the value at U16_MAX. This is still incorrect, but more likely to
> > help the user know what's going on; a caller can then (for instance)
> > parse the full value out of /proc/loadavg.
> >
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > ---
> >
> > Not sure what tree changes to kernel/sys.c should flow through. Andrew,
> > could you take this through your tree (assuming you agree with it), or
> > suggest what tree it should go through instead?
> 
> 
> Mind if I ask what the motivation for this is?
[...]
> I looked because just saturating the 16bit field feels like a hack
> that will continue to encourage buggy programs to stay buggy.

On the contrary, it seemed to me like the best way to make issues more
obvious. Wrapping around and showing (say) 12 processes because the
results are mod 65536 won't necessarily immediately stand out in stats,
the way that saturating at 65535 does.

That said, I like the idea of doing 0 even more:

> If there is real value in sysinfo returning a this information someone
> could go through the work and update the kernel to return the high
> bits of the process count in info->pad that is immediately after
> info->procs, and then update the apps or libc to find those high bits.

I'd love to do that; I just thought that'd be less likely to be
accepted. But yes, I think that'd be even better.

That said, I think we need to return *all* the bits in the later
padding, rather than just the high bits, so that we can reliably detect
if the bits were provided. We can return 0 in the existing field, and
then return the process count in the padding, and if the padding is 0
then it wasn't provided.

(If we returned the high bits in the later padding, it'd be hard to tell
if low=42 and high=0 was 42 processes or 42-mod-65536 processes on an
old kernel. If we return the full bits in the later padding, we can
reliably tell the difference between those.)

- Josh Triplett
