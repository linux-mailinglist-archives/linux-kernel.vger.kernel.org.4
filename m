Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE96997AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjBPOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBPOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:42:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CCD4486;
        Thu, 16 Feb 2023 06:42:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C45061380;
        Thu, 16 Feb 2023 14:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8C2C433D2;
        Thu, 16 Feb 2023 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676558538;
        bh=1oxCpm4govChwxnrWbBKkeSBKiNpqIg7oKaukmWGuLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qlS183GqNvRSEdrnVvi4dyrVgvNMA7hU4qtQGrxZ5z1lGzoiuixP+tV06pmqZCBsz
         9xTyF8bNNzyfgWlflpnfpc0JPPEpMLdmoFSe0G935zyP4PoZEwvzvbLvNbNfHehdYT
         nTWQXDSaxXz15g52jNMgdPaWgdj5IgE7DWyUUH5CbWYuwlEequhuLMDGgEYot/rjmW
         YKIg6xHmRvStYUsU2JZ7kXHagC7GEKu85G6PXvKeKs9AgxG0yv5Ik8UrExjUuWEHN8
         rCNYgrQ95EYE/yo1Hj6T8Vf/bVd5QDTRITh6L+egUSHiHkdbcaQugnT0fhnj1Fah9w
         N6f4pwrwvjnwg==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5258f66721bso27616597b3.1;
        Thu, 16 Feb 2023 06:42:18 -0800 (PST)
X-Gm-Message-State: AO0yUKUyK/rcPnMl0TRffxjQ4PteIK6ibVO8ojq7MDkohdPhXxqX/UP+
        jb/4gp9ywi4qNhcWuutsu0SIWy43eQnOboK5qzg=
X-Google-Smtp-Source: AK7set/h/QZbnvz10Jpej51w7hGkoQ7yp8WdchZC9bWh8SiCJyYUlbUCOaNWvzjx0rLxqBrWpQIX3QvfASmE4/aBW28=
X-Received: by 2002:a0d:ea05:0:b0:52e:fbcd:e1b4 with SMTP id
 t5-20020a0dea05000000b0052efbcde1b4mr790508ywe.0.1676558537664; Thu, 16 Feb
 2023 06:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20230213085658.96918-1-colin.i.king@gmail.com>
In-Reply-To: <20230213085658.96918-1-colin.i.king@gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 16 Feb 2023 16:41:51 +0200
X-Gmail-Original-Message-ID: <CAFCwf11_+NH1A-1eWUriWFuuh38TiOQCMHLvqFVq_4Uwn1+HUQ@mail.gmail.com>
Message-ID: <CAFCwf11_+NH1A-1eWUriWFuuh38TiOQCMHLvqFVq_4Uwn1+HUQ@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs: Fix spelling mistake "offest" -> "offset"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:57 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a dev_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/accel/habanalabs/common/command_submission.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
> index 6c4d9b1aa5de..74ccafeb38dc 100644
> --- a/drivers/accel/habanalabs/common/command_submission.c
> +++ b/drivers/accel/habanalabs/common/command_submission.c
> @@ -3199,7 +3199,7 @@ static int ts_buff_get_kernel_ts_record(struct hl_mmap_mem_buf *buf,
>                         usleep_range(100, 1000);
>                         if (++iter_counter == MAX_TS_ITER_NUM) {
>                                 dev_err(buf->mmg->dev,
> -                                       "Timestamp offest processing reached timeout of %lld ms\n",
> +                                       "Timestamp offset processing reached timeout of %lld ms\n",
>                                         ktime_ms_delta(ktime_get(), timestamp));
>                                 return -EAGAIN;
>                         }
> --
> 2.30.2
>
Thanks,
but I've already fixed it in my tree in the original patch before
seeing this email, sorry.
Oded
