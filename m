Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195F15EAF27
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiIZSGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIZSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A277FE53;
        Mon, 26 Sep 2022 10:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8870D61162;
        Mon, 26 Sep 2022 17:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC1EC433D6;
        Mon, 26 Sep 2022 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664214625;
        bh=B2HfxUsvQPTF4de1VzimfLaQVnRd1JOGn/hbPGC3o54=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PV5hY0dkTxheD4nTjEEVb1ZHATwHABoMoV8+gSblyid9ymgQU7Eoem1pgMEAmmmpL
         xWVHOdzoN8b7c2usMP2PdhURD7NZ/4D2zjeeX80zMy1rWN4P8RqgDmVOOt4X341OPv
         iWTimGiRSrnh4OKYANbRum+JRazDpmpN7+/wDCN0doWpCjtp6Q845BLqmmy6hrNxyX
         5PmY6va+9vZZftfQlPix7ehszwtdGC7K1pE/VJRSlt4rm46EMgqzz6efvhSDiH94nl
         +WTfRFIvW4MEBgQnEn09HqRqh4HbxDp3UurrP+msYfGui4Fb+OEycc3U3QdXsYZ0So
         +Mf2FOcCpquDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9338D5C05B1; Mon, 26 Sep 2022 10:50:24 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:50:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>, Akhil Raj <lf32.dev@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the jc_docs tree
Message-ID: <20220926175024.GR4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220923134834.299646cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923134834.299646cd@canb.auug.org.au>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 01:48:34PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   Documentation/RCU/checklist.rst
> 
> between commit:
> 
>   712e1dea2e4f ("Delete duplicate words from kernel docs")
> 
> from the jc_docs tree and commit:
> 
>   1f0e704eea04 ("doc: Update checklist.txt")
> 
> from the rcu tree.
> 
> I fixed it up (I just used the latter since it removed the words removed
> by the former) and can carry the fix as necessary. This is now fixed as
> far as linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

I have it down, thank you!

							Thanx, Paul
