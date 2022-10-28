Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A170F6108A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiJ1DSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiJ1DSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:18:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C2A4BBB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72E286243B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7734C433C1;
        Fri, 28 Oct 2022 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666927075;
        bh=teGpqU5l4BnV+gF1DyvYpL8pu0uLFu7cp/ZG4zNC254=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMDmcYSOokwWI/EfdMSjR8nSmgl3TkoZO0HlBLMX8Siv2lMfhQP4tyQn4Wcl0yd6X
         YJuYh9uUvFLtyG368SG/bzz1CTq79jZQLJB/pkXGDqmvaNiyOC+7d9to2QoTCSnD9S
         BZpiV4oF8A+eWXzkT5e5vRQasWe+amVnm74VJll9CEMQlUdkpJ1oD/LTkRvmkjy/K7
         GCRO1Ti/Vw7NqvR1qUNauW7WtImmTapqa0Xi3W6vatVWxj6coQ+Nt2wrE0b+sjWkUL
         BeXybtRcwchkRmnvjXemLaRx/NXVR8j3PJvgGJOqfB6BDfcddAByBMtaVS/yGJzx39
         YNVET2MPpgvMg==
Date:   Thu, 27 Oct 2022 20:17:54 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error when
 errors=remount-ro
Message-ID: <Y1tJ4uKBa0ItHCBw@google.com>
References: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
 <20221028023303.28020-1-frank.li@vivo.com>
 <85b6be9b-5c5b-ace0-8084-4bd52ef64996@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b6be9b-5c5b-ace0-8084-4bd52ef64996@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28, Chao Yu wrote:
> On 2022/10/28 10:33, Yangtao Li wrote:
> > > It won't pollute global namespace since it's a static function just be used in f2fs/super.c...
> > 
> > emm, I think it would be nice to see the f2fs_record_error_work symbol
> > in the stack, it can be explicitly a function of f2fs. personal opinion for reference only.
> 
> Oh, yes, let me update in original patch as well.

Chao,

It seems there're multiple bugs. Please apply this as well.

https://lore.kernel.org/linux-f2fs-devel/20221027180416.3786792-1-jaegeuk@kernel.org/T/#u

> 
> > 
> > > Do you mind letting me merge these two patches into original patch?
> > > since original patch is still in dev branch, rather than mainline.
> > 
> > Glad to see, if resend.
> 
> Thanks, :)
> 
> > 
> > > I guess it needs to stop ckpt thread as well...
> > 
> > agree, :)
> > 
> > Thanks,
