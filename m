Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401C1738D72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjFURnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFURmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A576E1726;
        Wed, 21 Jun 2023 10:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF13A61642;
        Wed, 21 Jun 2023 17:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7D4C433C8;
        Wed, 21 Jun 2023 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369313;
        bh=pod9vxsJ9/lJVWWTJCewna80E9noVqemDffNCQX/HMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vf9aRTT9xfDyEXdW3zs9vwc0uhfEnZRLveJuFaGow22Ny7mAWZcgcjbuNyBE/tKk0
         qEmhd2+XoS0RBhZio26hqeK5AyR9f+7MMYkyAVv2/eN/UX3FmbPntgxq8LOqNvMBwY
         4TZXrp3ApHX6imRSn9O6+PIEWY4OuQKdHqcCGIAnegzztIS12j+dvdxMlC9UNvNwox
         hNySBbaY50Q6lQRSSUH5FC8JknwxZN8Crjh4ZCoCrl84nP3FqbkDM+rjdmzRf3C3oq
         uZk5rdbEtD2Y5HSWArWqdCHvGUGJcRH+wIoZ88spD328gvwldikEVL7JprO7drVqRK
         0VpXVJ8TRbTcA==
Date:   Wed, 21 Jun 2023 10:41:51 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2] x86/unwind/orc: add ELF section with ORC version
 identifier
Message-ID: <20230621174151.e5vucxl2hlsp3o3b@treble>
References: <aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com>
 <20230614091751.GE1639749@hirez.programming.kicks-ass.net>
 <ZJHYuH/DD6tqJ+bu@telecaster>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJHYuH/DD6tqJ+bu@telecaster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 09:50:00AM -0700, Omar Sandoval wrote:
> > So we're fairly late in the cycle and it would need justification to go
> > into objtool/urgent -- preferably only fixes at this point.
> > 
> > But given we 'broke' the ORC layout this cycle, we can mark this with
> > Fixes: for the two mentioned commits.
> > 
> > Josh?
> 
> Ping, Josh, any chance of getting this in to 6.4? Sorry to be cutting it
> so close.

Sorry, I had acked this privately and Peter queued it last week but it
may have slipped through the cracks.  He may still try to get into 6.4.

-- 
Josh
