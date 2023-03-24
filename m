Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A806C780F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCXGib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXGi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:38:28 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B81E9E9;
        Thu, 23 Mar 2023 23:38:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C11D05C00F9;
        Fri, 24 Mar 2023 02:38:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 Mar 2023 02:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679639903; x=1679726303; bh=qD
        uX7tgJEEHFooeQE4cGowA4Kil5yWr+9P48BA+SXjw=; b=qdwkQa5EMBJknuCVKg
        BloNlrhJynQgNlNrzHrQZ/ChqDkmmdcOy88jN+vULJ3qELqbqepvLAxVguVXp3ct
        TNJRbTEr7zTGSGpp+Iu4d/rMjeyHTz0iW9KkRgC1Ywl7n9m1J5c3uzn9ENiy7tS2
        p82cvYx1Z3/kGyUZzpEgHNrHHgnzgzaD13x6F4osYZEcXyMMq9/vR0/xae2dyHjC
        C0yVdL1ebse5fvnya3B/X8ZIZGVImk4arRvbX3aLet1WKOhQbdhjEBbPD5UO3gt2
        0dZ54CBeehrBCE3cHADmHrqSh94oKFcr0gAX8jm1BDGWtYOgVj1a/+rLq72dtLXZ
        koRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679639903; x=1679726303; bh=qDuX7tgJEEHFo
        oeQE4cGowA4Kil5yWr+9P48BA+SXjw=; b=EkVHiJHoCGGBAkgLPCTpV5iTU2U+I
        JkUBwImsUKTVVmmYVOCat63ctaKjBpK9c7RAPTUUZDUZAGCmakyCqPHuEAzid7u3
        UQbckS/6h1KpZkIzDvYn4Bzxzi+8RhEXYZ57xxDKV45r5tCBdIXIE3+nB4fldTsj
        NuUUBTJgAGCjvrEgNGWwm5QnECuM11N4vmBV9PNHro9N7SCjcWJwT3PMEx4L34jB
        lstRVAG9pGB/2WrTixRDJ19CKFA60LxPldkvmAJTzPbhGHKuk+ZMIQB/sKlA4Hpz
        13uvg83udF67hhNKstxDSYvguMXLpEUh0Ndg+uaFqo7jHSVttwkEXEaIg==
X-ME-Sender: <xms:X0UdZHhy6quUSjKJpuGHY2DNmY-ZeHwqvdeMjCOVOrVHkecwygtfGA>
    <xme:X0UdZECpQLRn9hd_AIdhovbIOi3fc_ru02zHLkS534wVQY7dt5mUE1rJ48qnQQexq
    R6OCD1ybDfMvA>
X-ME-Received: <xmr:X0UdZHHo91UXBvOniRRenlhFpNMHpPLD1ZppvDdQtZhDw8YydTp2IGrUGAGZRltTU1nPAwdxeav2NeI-gtTsh2NiRN43bfl2r8x64g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeghedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:X0UdZETqcuCOMOzmDEmawlF6c5_soEJ3KxPxgMbU-kRQEM3p53sKEw>
    <xmx:X0UdZEybWvqS41xMTylfO4xZbxumgucbBOAjgFkedYoPMLDZUlPGuA>
    <xmx:X0UdZK4DEZMTa-2OmPVp1dXgy-V-Fpgum0CEu4iPODpBNIyyUqHZoA>
    <xmx:X0UdZJqYDrW1Rz77SAbD5aK14YHIbEoRBGYSZz5zZ8R0eR31S5GgJw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 02:38:22 -0400 (EDT)
Date:   Fri, 24 Mar 2023 07:38:21 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: linux-next: manual merge of the jc_docs tree with the
 driver-core.current tree
Message-ID: <ZB1FXXvBfzl0S1n6@kroah.com>
References: <20230324114609.018ad2a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324114609.018ad2a7@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:46:09AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the jc_docs tree got a conflict in:
> 
>   Documentation/admin-guide/index.rst
> 
> between commit:
> 
>   44ac5abac86b ("Documentation/security-bugs: move from admin-guide/ to process/")
> 
> from the driver-core.current tree and commit:
> 
>   efe920466f51 ("docs: describe how to quickly build a trimmed kernel")
> 
> from the jc_docs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/admin-guide/index.rst
> index 09a563bbe3e7,7840fdbab585..000000000000
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@@ -36,6 -36,8 +36,7 @@@ problems and bugs in particular
>   
>      reporting-issues
>      reporting-regressions
>  -   security-bugs
> +    quickly-build-trimmed-linux
>      bug-hunting
>      bug-bisect
>      tainted-kernels

Looks good to me, thanks!
