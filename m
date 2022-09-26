Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648175E99AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiIZGjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiIZGj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:39:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44BE04
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 957C5B818C0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24AFC433D6;
        Mon, 26 Sep 2022 06:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664174364;
        bh=cKMMFnbyhEosKlllHDUTiZHd5jYIbX/bl+rcn0ZPkrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxRTYTBna/vBMmlTnRG4VgVF/5fOK3EgUjDHcUjA44hC5r7fm57gOO8k6LKEFzj2L
         r7pV+eBUMfPH5l7yq3QzttFAlXeUS0Kg/T5IGT9rLbsFXKnpbkWOiOqQDVqqigxUVz
         8Ai/ILxCk5L2QIa4nVAQiH0/YcHs7CQQjxgnEHTs=
Date:   Mon, 26 Sep 2022 08:39:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: Re: [GIT PULL] extcon next for 6.1
Message-ID: <YzFJE+ILnXea/KL8@kroah.com>
References: <8ce72b70-d1f0-8ff0-e44f-fea41daf40a8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce72b70-d1f0-8ff0-e44f-fea41daf40a8@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 04:54:13AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v6.1. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:
> 
>   Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.1

Pulled and pushed out, thanks.

greg k-h
