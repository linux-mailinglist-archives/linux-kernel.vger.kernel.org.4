Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E476645CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLGOyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLGOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:54:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30454E6AB;
        Wed,  7 Dec 2022 06:54:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 556FEB81E6F;
        Wed,  7 Dec 2022 14:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35015C433D6;
        Wed,  7 Dec 2022 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670424878;
        bh=mtEarKHCsxRpEvBu4Wfxw0tEXAYjUKCgGEcgBv28W94=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dfHya90T74mUPQAbcMZ9qyxCYFJM3wGN+GhKK5MKDc1SUkfXtxhDI+SedftI/pnK5
         RsTRZUkNtAieJ+rkV/W6MzyWPOtgY26kdjl6PLNGMNf/sPOmQkOAz3VfOr/ejxseMj
         5O7Pd2FQFvY+u2Y07dq8rbrm4Jb67Qz9914h8qXT9MDc0KltsI4kvPM/oa+Qo/vBl+
         HoJTJrA6A5mmA2YSPTSMMcFXTQV3czwQmzECvo2oR5MaxzpqZQf9P2A0NBhngMtmTL
         FmzoKQ6lGAHNKZWWOFNy6Qb0TRFLdehps2YPlKlRUusJccakPdMMAgVhNXiLqw2R4k
         3I0uWDzXQnhaw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.1-rc8
References: <CAHk-=wgyXu4D44b8wQU9dpTYUft6WhZ0wr3nV1fziy6k0GwCCw@mail.gmail.com>
        <20221206085158.349363-1-geert@linux-m68k.org>
        <alpine.DEB.2.22.394.2212060957480.648028@ramsan.of.borg>
Date:   Wed, 07 Dec 2022 16:54:31 +0200
In-Reply-To: <alpine.DEB.2.22.394.2212060957480.648028@ramsan.of.borg> (Geert
        Uytterhoeven's message of "Tue, 6 Dec 2022 09:59:43 +0100 (CET)")
Message-ID: <87cz8vmfh4.fsf@kernel.org>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Tue, 6 Dec 2022, Geert Uytterhoeven wrote:
>> JFYI, when comparing v6.1-rc8[1] to v6.1-rc7[3], the summaries are:
>>  - build errors: +1/-3
>
>   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6152:45
>
> sh4-gcc11/sh-allmodconfig
>
> Looks like a real issue, albeit not new (but never seen before?).

Weird, I can't find any recent change which would affect this function.
So you have seen this warning only on v6.1-rc8?

Anyway, could someone send a patch to fix this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
