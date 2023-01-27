Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0329D67E053
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjA0JeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjA0JeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:34:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559755245;
        Fri, 27 Jan 2023 01:33:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F6C61A6A;
        Fri, 27 Jan 2023 09:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F55C433D2;
        Fri, 27 Jan 2023 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674812002;
        bh=1EV/RnP8DvYM6uELbc/15GzbHO8VKuA4S3baHHRG40U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOZb8DRMofXEX3LTMx1Z/bCNmCZpXvvEbOXequu28TbLkz+Ju+Xaq14Otw/AWl7xD
         n0qvYziPKCgV3cdcf74MgnqDyQvRWfAZAibsj5Y7XXY6zMxt6pgQj2sNg8kR+qZYQs
         RMucdmT92zIs15W6AR5J5/R3zcReoK33VB3Z8T3vupRMLOqXotOfJamf9HFMSyqbnN
         bUTkPlthf6/YcabTnJlUoxheXrYSqB9oq0TtJVmJWpZCr+rC6+RkWkTDu3rsT/cbdt
         VV1BgbRjrThAZfsvpYYVRZ3P9SMwKZlMSx68aNRPA4mYxYcM8QJuXMW2Kj3BNV8Jcs
         H8EXmGedmCv0A==
Date:   Fri, 27 Jan 2023 09:33:18 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mfd tree
Message-ID: <Y9OaXnD71r8EBazv@google.com>
References: <20230127160913.7deebd22@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127160913.7deebd22@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023, Stephen Rothwell wrote:

> Hi all,
> 
> The following commit is also in the arm-soc tree as a different commit
> (but the same patch):
> 
>   dd77f5fa97d3 ("mfd: Remove toshiba tmio drivers")
> 
> This is commit
> 
>   e9b016cfd62d ("mfd: remove toshiba tmio drivers")
> 
> in the arm-soc tree.

This one too please.

-- 
Lee Jones [李琼斯]
