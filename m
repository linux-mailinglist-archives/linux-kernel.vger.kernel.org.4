Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEEC655B58
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiLXVgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiLXVgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:36:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0E4B84E;
        Sat, 24 Dec 2022 13:36:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BD8FB80185;
        Sat, 24 Dec 2022 21:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2334C433EF;
        Sat, 24 Dec 2022 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671917808;
        bh=VQb7MWoNP9XDTkn0OWRtjf3EugByIlCRVMC/M3almsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZsPP1nFOp7YzD+5De0+81DKldhptG7WatoTqh1zff33rJ1f1TAULH8TXbotcIzR7
         lOnDF9nnL39sd5CpKhAZ58pgPnyw/QZ8DJBFdsg2GyB3wO+Fa8lwydOT/lTtDE0fHV
         q5mpZmYgy+WFUjCo4NvR6EPIoRddwNAVHH2PeukCASz5CC5Vg2eU00XfteMy6FjgzY
         koJO5bE2oHZkJuUZqWokeKwAihguUCAl57xX7Ij5b4tKrGFFogSa4eO5qynJBFK2RB
         xK7O8SG9/QyWbBuHcmob+/z9yox7BGLKE9jg15kqBZeOte9/0Y183xuYnqn2Wn0zcY
         V+aBsbdsfqY3w==
Received: by pali.im (Postfix)
        id 2F4C1720; Sat, 24 Dec 2022 22:36:46 +0100 (CET)
Date:   Sat, 24 Dec 2022 22:36:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <20221224213646.zyosaq7hnlsaje4b@pali>
References: <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali>
 <Y6cXRbGUsarzoJEw@zn.tnic>
 <20221224154842.o4ngrwmskduowttm@pali>
 <Y6chm9khdG4pmNhN@zn.tnic>
 <20221224160055.ln3dbhx7dnut7dwi@pali>
 <Y6cma26FKzBQD8AN@zn.tnic>
 <20221224163602.6bqr32tkf2ulx6po@pali>
 <Y6dsWVspi9tGNid5@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6dsWVspi9tGNid5@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2022 14:17:13 Keith Busch wrote:
> As a matter of procedure, could patches deprecating modules perhaps add
> a loud kernel warning message somewhere in the module's execution path
> as a means to mitigate any surprises for people using it?

Sounds like a good idea. But it is needed to find a place for "somewhere".
And message should contain what does that deprecation means. Because for
more software products it means that software is being replaced by
another one. So it could be confusing that it is just needed to switch
from module A to module B and that is all. But for this case there is no
replacement.

And based on my experience, users (including me) are using distributions
LTS kernels in production. So do not forget that it takes lot of time
until some distributions switch from one LTS version to another LTS
version and so it would take lot of time until deprecation warning is
visible to user. (Maybe deprecation information could be "backported" to
LTS kernels?)

In any case I would prefer some documented webpage with all deprecation
information. Like there is releases webpage which says exact day when
particular LTS version is EOL: https://kernel.org/category/releases.html
