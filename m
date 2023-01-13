Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD06699B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbjAMOOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbjAMONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:13:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E975E096;
        Fri, 13 Jan 2023 06:11:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93F3861E5D;
        Fri, 13 Jan 2023 14:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCDAC433D2;
        Fri, 13 Jan 2023 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673619078;
        bh=/6SY5e2kNWppkEIR3acALAnQslTESItpdK+KN1H9IXg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=T1gOx8LPBJsOyUYJmRb65xURUnZhWEotYE4Yvx5yXVs74Df+ODWOogKlyWQgJik7C
         jhAvPsMHo4dUkwyQhzUNnrMNB9TJBIbsgcoS5oOAUgQYLn3gHzwcl0r828iLCq0062
         gemUb4fGGZtmjAiLd5/k5jTwfzmkYQF4/hT4q9IhrOOoeerf6aVZZA0RWK2YHuXA3z
         ff/n0K5hh3Hk8e6id/fL85KwPP5+YNnAiA07/CI1XYRIgcFcUpqBoIZ9OfuTS2XLLo
         ididtk00E2oWpK1nkKFqU3lHNlE0Z9pV1hhfS7WQt0qDgp3PEdWgL3Bf/KwS3SQ619
         MtXPTXnmRDwzg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Linux kernel regression tracking \(Thorsten Leemhuis\)" 
        <regressions@leemhuis.info>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        lorenzo@kernel.org, sujuan.chen@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, spasswolf@web.de
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae stopping working wifi mt7921e
References: <252b1fe4-ccc2-4ea8-1da5-9a60f7378fd6@leemhuis.info>
        <BD7074C5-20BE-4D70-824B-0994892C995D@nbd.name>
        <0078a5ff-2bc5-4b14-2735-1641feb46544@leemhuis.info>
Date:   Fri, 13 Jan 2023 16:11:10 +0200
In-Reply-To: <0078a5ff-2bc5-4b14-2735-1641feb46544@leemhuis.info> (Linux
        kernel regression tracking's message of "Tue, 10 Jan 2023 09:41:10
        +0100")
Message-ID: <87358ecyo1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Linux kernel regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> On 10.01.23 09:00, Felix Fietkau wrote:
>
>>> Still no reply. I wonder if I'm holding things wrong. But well, let's
>>> wait one more day before escalating this further.
>> 
>> Johannes told me on IRC that he will review my patch soon. He simply has too many things to do at the moment.
>
> Great, thx. And sorry for prodding so much, but that is part of the job
> when it takes so long to fix regressions -- even in cases where that's
> mainly caused by a holiday season (which I took into account, otherwise
> I likely would have made more noise earlier already).

Thorsten, I value your work A LOT, tracking regressions is important and
makes our work easier. Thank you for that. But when tracking bugs please
be reasonable as well. Most of the people in the community are
volunteers, we have our normal lives/work as well and things don't
always move so fast. For example, I just came from a long vacation this
Monday and have a lot to catch up. That's why the release cycle is so
long as it is.

We are in -rc3 at the moment and I don't see the need to push the panic
button so early in the cycle. If we take fixes in a rush that might
break even more stuff. And anyone using release candidates ("rc") should
understand that things can be broken and it might take some time to get
them fixed, especially on holiday periods.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
