Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91E67DE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjA0HDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjA0HDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:03:03 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0C5279AC;
        Thu, 26 Jan 2023 23:02:57 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9587F3200917;
        Fri, 27 Jan 2023 02:02:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Jan 2023 02:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674802973; x=1674889373; bh=W/jkW9u0WB
        5SFsXC/R5d1e2tDBzid48tPP/Q1cQjf9k=; b=G152YWx970G3IBAq1Ci1dNb8wI
        BvnaCy+ZczprTeaX+ojbTBTBrgGejn8v46HorxFilBNQLovCQ4e8srbm2agfvetm
        g2pwqmG4o6bKSCcs726Vv1BXeBJrP15n5797pYRTQGP6ZgBQ0pxnA/o2fQKs5CtO
        Nglg5yTuWJ4gQooywVFW8qNCm6TNSc0KK6FNqLleObups3MC6B/YXgXG/uFg01lU
        17nlGfFHCKJoePVvkmjJmJSpQFE8/sSwreWj85CPdh5Db6BGps7vgRDoQFTk5KH3
        C65+rBtqyEtmuxgFvXo9gR3WDjC3LP1PB3GgPZXNk7jH6HJMTu6HgLmcrBtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674802973; x=1674889373; bh=W/jkW9u0WB5SFsXC/R5d1e2tDBzi
        d48tPP/Q1cQjf9k=; b=nlEDtlFBOEUWzp+LVIyBqpVHU8mMfBboPgvn0GFRxKao
        LiBvtyeXGKI0c5IeP8hoqtriY74wrZo/H+m4e+un+0kiRcMwZ3cfVoKeLH3tsck0
        vbv185cLjpIVrs/E5PMxtwQD+Z02VQsih/cqBI2xEeF/DR4ymGYtxnmkN9feLKYi
        YdO35j4qNtCC8PPvbhEUJU/OgIzB6PioXdShDYQmFxJn9GAgSzxLKWI+lfHfpiOT
        LNm4KiBhQbuvHJHqRu7w00wAoM9+d05KgX0QsKcgn3ZRSKCczv0ydCUzIHnnixIC
        wsHY5zZRieitv3j+umnQAMGpw/a5GhGt9HQefUl4JQ==
X-ME-Sender: <xms:HHfTY6wpCkYu90hqT4bvKE_BFjGRg1yYWO_Pip9OtU6tsHOs_pOZzg>
    <xme:HHfTY2RiSs6tFkRb2h-67cyRP1bIec6ekh9nZassjxFbUA2gXQ9Gy8XTOdfPiEbBp
    6WYcQv0YGekYA>
X-ME-Received: <xmr:HHfTY8UUog3Cz9KVOSavjcx1tQjHnar0s0jBYYhXBXug5FDtQuYcI9hr5RyLHXCmeSJGPZCpHIszZF3g4RHkj06YtLutZh8LwNms3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvhedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:HXfTYwhCK62pSDMxNMvS--W3hgJCNMFVej8J116z_QKLTtLgWHW0uw>
    <xmx:HXfTY8ARYqRCVr37cTXFf0eCSewaHhPvKX_6los_6n--Pzy38Uvt9g>
    <xmx:HXfTYxKrmneAYc-LRtOsDs59CY8hOY2o_jMN9QAJWAasulrazpSAxQ>
    <xmx:HXfTY424QzscFRcMvhucm7KD132-Mvc57_dPTRbGP-ySjtI09KH_JQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jan 2023 02:02:52 -0500 (EST)
Date:   Fri, 27 Jan 2023 08:02:48 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kspp tree with the tty tree
Message-ID: <Y9N3GNBKzOKuSOMJ@kroah.com>
References: <20230127155753.1f9b9517@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127155753.1f9b9517@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:57:53PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kspp tree got a conflict in:
> 
>   drivers/tty/vt/vt.c
> 
> between commit:
> 
>   feb36abbedea ("tty: vt: remove struct uni_screen")
> 
> from the tty tree and commit:
> 
>   19c30ead3938 ("vt: Replace 0-length array with flexible array")
> 
> from the kspp tree.

Kees, I was waiting for a new version of your 0-length patch before
applying it as I thought there were review comments on it.  So you
should probably drop it from your tree or resend it so I can merge it
into the tty tree if it's acceptable.

thanks,

greg k-h
