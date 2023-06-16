Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED65E73272D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjFPGNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjFPGNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:13:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB90F2D61;
        Thu, 15 Jun 2023 23:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D05D62508;
        Fri, 16 Jun 2023 06:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5238C433C0;
        Fri, 16 Jun 2023 06:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686895980;
        bh=pKKs+ikvQgBhv6OujYCF/JO0CWWZMx7/sLxq/+FmgdQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=vNRjrKr9yva3IsiQbnaBccQwUvpLA1Mgw8uGTj52RWGNiBcMHo5TPqwe/0GfYuVU7
         sODW+rKfd7imcYUfgnAmV7X5fokV9FGT4idRwxYuzezDCjETiZ8vsNjZD/2CNM7yIi
         XAp2tdoLzYlzESCvh81lxdN1g+UnXKZFD4JwZU8e7hKVrDE+7IUzcjhD7r1kp0wbJz
         C0IPCSJHRRzCg4znmH0DERGNv0MJyfbSoI8zMvtsVA6hgDTINYsPXtftO8MKe2fO5v
         zLRW8KfW067zj84LG93/RGiLAuEn/fVYKCjvjv/AdtJA3GE0UYAL36WIDNNRBWXIH1
         ZPNlsSGJGLJkA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Toke =?utf-8?Q?H=C3=B8ilan?= =?utf-8?Q?d-J=C3=B8rgensen?= 
        <toke@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: Closing down the wireless trees for a summer break?
References: <87y1kncuh4.fsf@kernel.org> <871qifxm9b.fsf@toke.dk>
        <20230613112834.7df36e95@kernel.org>
        <ba933d6e3d360298e400196371e37735aef3b1eb.camel@sipsolutions.net>
        <20230613195136.6815df9b@kernel.org>
        <c7c9418bcd5ac1035a007d336004eff48994dde7.camel@sipsolutions.net>
        <87a5x2ccao.fsf@kernel.org> <20230614122153.640292b9@kernel.org>
Date:   Fri, 16 Jun 2023 09:12:55 +0300
In-Reply-To: <20230614122153.640292b9@kernel.org> (Jakub Kicinski's message of
        "Wed, 14 Jun 2023 12:21:53 -0700")
Message-ID: <87h6r8aqag.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Sounds good. And do note that not all drivers have active maintainers,
so you might have to take some patches without acks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
