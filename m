Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E3E6641FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjAJNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbjAJNez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:34:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC19E7A39C;
        Tue, 10 Jan 2023 05:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CA5D6171A;
        Tue, 10 Jan 2023 13:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67F9C433EF;
        Tue, 10 Jan 2023 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673357685;
        bh=428Utdh+e6F2/hWYnKzDhqLh/AHuuQMV5oFWLJ3BKqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PifxqQiVsu2yVxl+rvItZRxvJQ4ShpBz+CyugsIA5h6Xy6eogwCrR6tFdn76H51+9
         qwBoKfhNOJNlRtFcQ/bMGGgJu4QKQ1zCSwlKDl9DFdRWeQ/7OuSK4Hzt0+nyn6MwOP
         LqUQ7e9EXMAJOHgoyZ7zYMsA2pTYuw+LnTwCQLOXx3ZeEZ5mMZ1ziIMRcfu+vRCPDy
         4+1UlQ99l+q3b/OU3Uvclc+Se2K9gawsEzPhhFNB0o+HDCaGQ1eS6X9FFeFWslUut1
         vEK5uBOSLo4urIQZBEhY5KYGic/0vEo1sVWuCPPhuuKCyWc32c58/++vHWcWbO8jWn
         5/8lVcEXr2T9w==
Received: by mail-yb1-f169.google.com with SMTP id c124so11737562ybb.13;
        Tue, 10 Jan 2023 05:34:45 -0800 (PST)
X-Gm-Message-State: AFqh2krp9A9p2LbrRsjXT4gB8vCKRU3XGqg8aUEuspH98x3bM9+LK/TQ
        770zCGLSrEzw66xrVbDt8bLsvsCWuHP6fZbzPfo=
X-Google-Smtp-Source: AMrXdXsS1IMMV97uhXnmSnvUUs5QH5SQPpbwkG6NWvv7XZpwjDjgZlqLaV0/nOrzgqw5QouMJjwR1058Lhg2O2R76U8=
X-Received: by 2002:a25:bbd1:0:b0:70b:87c6:4fe with SMTP id
 c17-20020a25bbd1000000b0070b87c604femr7421709ybk.550.1673357684837; Tue, 10
 Jan 2023 05:34:44 -0800 (PST)
MIME-Version: 1.0
References: <Y7zB4z5cxpFkPXKV@work> <20230110104609.GA1602079@linux.intel.com>
In-Reply-To: <20230110104609.GA1602079@linux.intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 10 Jan 2023 15:34:18 +0200
X-Gmail-Original-Message-ID: <CAFCwf13yp0Sj9i9Nmq_WOU0gcwfjjWz1vgzMeD5_1YWj0aWO_g@mail.gmail.com>
Message-ID: <CAFCwf13yp0Sj9i9Nmq_WOU0gcwfjjWz1vgzMeD5_1YWj0aWO_g@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs: Replace zero-length arrays with
 flexible-array members
To:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:46 PM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Mon, Jan 09, 2023 at 07:39:47PM -0600, Gustavo A. R. Silva wrote:
> > Zero-length arrays are deprecated[1] and we are moving towards
> > adopting C99 flexible-array members instead. So, replace zero-length
> > arrays in a couple of structures with flex-array members.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [2].
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> > Link: https://github.com/KSPP/linux/issues/78
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Thanks,
applied to -next.
Oded
