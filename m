Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BA75ECF4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiI0V21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiI0V2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:28:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688BA1E76B7;
        Tue, 27 Sep 2022 14:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B5DAB81D56;
        Tue, 27 Sep 2022 21:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABCDC433D6;
        Tue, 27 Sep 2022 21:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664314101;
        bh=d0UanoNnAmTntsMEuZV5ezz6v34yl/2kzaNX7qZacZc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KrgUZUxnx8wgUKCqb/Ygr8YlM/Y+drVwBc+0TJwWPghXDKrpsNSauZlhP/+OQaO6z
         kkQMAa3+xymynDgnp87RpTLdmGBavANgJZwG6OjhjzB/TbtiKTL2qOK7KK7AY7cH74
         RSV8pl8PPyVRIjKI7EmCZlaOFxbLsmWfdKItErS68U5OtM2yCj7aKmjVx6lvg+b0Ey
         0SK3J8VKJL00Iu0WDJ/mzv2FBztWB/fPHApA+WS3zzWF/nlmR9oLJ5h2+F7AmeZDSi
         2FKxnC/tegFtvOM1v241lHJwZSZT4QsQmjxiTgX03vkak815xyJ5fTl22bNzd0yuZ6
         EGLJs3r4/y3AQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 742BE5C0AC7; Tue, 27 Sep 2022 14:28:21 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:28:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Subject: Re: linux-next: Tree for Sep 27 (uml 64-bit or 32-bit: tinyconfig)
Message-ID: <20220927212821.GX4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220927201053.518736-1-broonie@kernel.org>
 <f1b22431-074d-32f1-b67a-34c51e4d072a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1b22431-074d-32f1-b67a-34c51e4d072a@infradead.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:13:29PM -0700, Randy Dunlap wrote:
> 
> 
> On 9/27/22 13:10, broonie@kernel.org wrote:
> > Hi all,
> > 
> > Changes since 20220923:
> > 
> 
> In file included from ../include/linux/notifier.h:16,
>                  from ../include/linux/memory_hotplug.h:7,
>                  from ../include/linux/mmzone.h:1244,
>                  from ../include/linux/gfp.h:7,
>                  from ../include/linux/slab.h:15,
>                  from ../include/linux/crypto.h:20,
>                  from ../arch/x86/um/shared/sysdep/kernel-offsets.h:5,
>                  from ../arch/um/kernel/asm-offsets.c:1:
> ../include/linux/srcu.h: In function ‘srcu_read_lock_nmisafe’:
> ../include/linux/srcu.h:181:26: error: implicit declaration of function ‘__srcu_read_lock_nmisafe’; did you mean ‘srcu_read_lock_nmisafe’? [-Werror=implicit-function-declaration]
>   181 |                 retval = __srcu_read_lock_nmisafe(ssp, true);
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~
>       |                          srcu_read_lock_nmisafe
> ../include/linux/srcu.h: In function ‘srcu_read_unlock_nmisafe’:
> ../include/linux/srcu.h:226:17: error: implicit declaration of function ‘__srcu_read_unlock_nmisafe’; did you mean ‘srcu_read_unlock_nmisafe’? [-Werror=implicit-function-declaration]
>   226 |                 __srcu_read_unlock_nmisafe(ssp, idx, true);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                 srcu_read_unlock_nmisafe

Could you please send your .config or tell me how you generated it?

							Thanx, Paul
