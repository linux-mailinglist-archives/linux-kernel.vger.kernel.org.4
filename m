Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B8632E87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiKUVMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUVMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:12:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F61C6BC6;
        Mon, 21 Nov 2022 13:12:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F2A961460;
        Mon, 21 Nov 2022 21:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86F4C433D6;
        Mon, 21 Nov 2022 21:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669065140;
        bh=nmHwTBfz9HEKEVrdiVd0LFXO9AZHdMs3tAKcRRLdUsc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jKHBwzpxmQ5FiiNuMm8BVyYSu3oKFsWkh70TNQvQ0XH7jXQOshAjKEtZPQqgQE9yK
         JYdFTwRlIjFFM13MMNPD13eFrMyC1sffarJLNovyELS6IaiJ19kXGktDQed20S6JZe
         FJzkHWmX2VhYm2cMSV0FGyQibklpIEG3h6azgLIEgxs9XIXVGm8z/OyOkj+Mg5aXLf
         iA3d7eYtPgtfw0ubDQQ9xFUgodsSrqf6FRdMUAU37FiBqdDeokSLxfX0WC5Wwnj6JK
         SmAoPPrHCKLVUP7JW8uvkAV0TQBjFTCAYjdAINZgf375hV7GJcfKSu+pfjR1wiGrrC
         MeJjO52z4x1Hg==
Date:   Mon, 21 Nov 2022 22:12:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] samples/hid: Fix spelling mistake "wihout" ->
 "without"
In-Reply-To: <20221116093943.597572-1-colin.i.king@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211212212100.6045@cbobk.fhfr.pm>
References: <20221116093943.597572-1-colin.i.king@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022, Colin Ian King wrote:

> There is a spelling mistake in a comment and a usage message. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  samples/hid/hid_surface_dial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/hid/hid_surface_dial.c b/samples/hid/hid_surface_dial.c
> index bceea53d39b0..4bc97373a708 100644
> --- a/samples/hid/hid_surface_dial.c
> +++ b/samples/hid/hid_surface_dial.c
> @@ -4,7 +4,7 @@
>   * This program will morph the Microsoft Surface Dial into a mouse,
>   * and depending on the chosen resolution enable or not the haptic feedback:
>   * - a resolution (-r) of 3600 will report 3600 "ticks" in one full rotation
> - *   wihout haptic feedback
> + *   without haptic feedback
>   * - any other resolution will report N "ticks" in a full rotation with haptic
>   *   feedback
>   *
> @@ -57,7 +57,7 @@ static void usage(const char *prog)
>  		"This program will morph the Microsoft Surface Dial into a mouse,\n"
>  		"and depending on the chosen resolution enable or not the haptic feedback:\n"
>  		"- a resolution (-r) of 3600 will report 3600 'ticks' in one full rotation\n"
> -		"  wihout haptic feedback\n"
> +		"  without haptic feedback\n"
>  		"- any other resolution will report N 'ticks' in a full rotation with haptic\n"
>  		"  feedback\n"

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

