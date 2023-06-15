Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B6731901
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjFOMdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFOMdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:33:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA271FD4;
        Thu, 15 Jun 2023 05:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD29618EB;
        Thu, 15 Jun 2023 12:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573D9C433C8;
        Thu, 15 Jun 2023 12:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686832380;
        bh=7SJSooLHw1XqH2UYNvRcPE3YydGNfm0xAFxd/c7vKJo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e9DQHLZiLiYiczEKwCFXENboEz+vMXQomeNyJgQhiOS6DV2nBjiexJ3MOToPtBfS1
         pPwRD735PQTbUQQNhPbSwamMRH9gjnmQI+71KBuz0Wk5kOMqBUCmb6YqM0IR2NOZa7
         iec3qB+xHUVB6wtdkeaNQaEudyxzUtsnjj+xwZUluYWBxOlNmrPZGtXVyqfT9a0Bi1
         8T4twX0pgNKlaYYJf/zXkzeOp1vnl3EFSy+IvaBS+XScfiRasUb6mo7Tjxxma2rBco
         GNBuVNzZslNh8Gbk2IBJdFIgm94rnlylbeEYmS1TF3f0zshwQm4/tDQVDoRXo/24YP
         yhtIIFO4BZc+w==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D1851BBEC2D; Thu, 15 Jun 2023 14:32:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Closing down the wireless trees for a summer break?
In-Reply-To: <20230614122153.640292b9@kernel.org>
References: <87y1kncuh4.fsf@kernel.org> <871qifxm9b.fsf@toke.dk>
 <20230613112834.7df36e95@kernel.org>
 <ba933d6e3d360298e400196371e37735aef3b1eb.camel@sipsolutions.net>
 <20230613195136.6815df9b@kernel.org>
 <c7c9418bcd5ac1035a007d336004eff48994dde7.camel@sipsolutions.net>
 <87a5x2ccao.fsf@kernel.org> <20230614122153.640292b9@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Jun 2023 14:32:56 +0200
Message-ID: <87sfasgb2f.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 14 Jun 2023 18:07:43 +0300 Kalle Valo wrote:
>> But do note that above is _only_ for -next patches. For patches going to
>> -rc releases we apply the patches directly to wireless, no other trees
>> are involved. My proposal was that net maintainers would take only fixes
>> for -rc releases, my guess from history is that it would be maximum of
>> 10-15 patches. And once me and Johannes are back we would sort out -next
>> patches before the merge window. But of course you guys can do whatever
>> you think is best :)
>
> Ah, good note, I would have guessed that fixes go via special trees,
> too. In that case it should indeed be easy. We'll just look out for
> maintainer acks on the list and ping people if in doubt.

SGTM! :)

-Toke
