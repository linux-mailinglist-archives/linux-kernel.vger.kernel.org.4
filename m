Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887D1656A71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiL0MF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiL0MFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:05:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316DB48C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 04:04:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54F98B80EBF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 12:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00199C433EF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672142682;
        bh=YRZYZEZqxhYz5HBI5rM384SwiIQ90WVN3HJ7bun9/a0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EVqjUCkfapdmI9fQVM8aeq3aaV98lO3nKYfv5e1o+RB6571DKPWZsgjCSVyAuoXH1
         Ey3OVUuLPu5lKDURZz8cDsGvjuMTVVCnX1ax26FnGERZ1JjJOs2e8mBcc+zPrrlnNe
         sx7f9tSDohEoK0mWuTaTEsgf0JvLaMPzteYFoV9NT6jfZd4qlNQViEJ9EkVNxlNxvl
         XXlAR4uPEQIg2G/xLPBjZK1yH7Xwi3GtgB4gYAXRSgEpk3JWcDqpC1XZOsSBkfp9S/
         7q3EG7niuCqhVGxibmrOcaJbq0EG31/HBbst2lucVC1Q6bUe2AiKFOWggbDYQ8jXq0
         trNs/QNqQU1Ww==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-46198b81e5eso181503767b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 04:04:41 -0800 (PST)
X-Gm-Message-State: AFqh2kpUTNQ95Y5BrjKgLNfpWgapcNLxY/7b7SYkQtD6g62iwGZpPoml
        OfJJWjM27D6Mxtbu54+ynKceVjoQm+G/WQ0Yvqg=
X-Google-Smtp-Source: AMrXdXsnpkpmjYZ98UhnrdMq3SqJVtdECg4PGjHdo8XZNDH1D8kCqh5abl9tfvTR8KA5KCb+RxrWf3WVFwl4sBj1G74=
X-Received: by 2002:a81:1c54:0:b0:45b:1789:fe4c with SMTP id
 c81-20020a811c54000000b0045b1789fe4cmr1854507ywc.182.1672142681055; Tue, 27
 Dec 2022 04:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20221226213227.26953-1-ogabbay@kernel.org> <Y6qeDQY+X6ZRn3bi@kroah.com>
In-Reply-To: <Y6qeDQY+X6ZRn3bi@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 27 Dec 2022 14:04:14 +0200
X-Gmail-Original-Message-ID: <CAFCwf11GO4n-nOhyLDAG9k9MSJ1xfjj6_1nH=X9vKgdbvY62yw@mail.gmail.com>
Message-ID: <CAFCwf11GO4n-nOhyLDAG9k9MSJ1xfjj6_1nH=X9vKgdbvY62yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] habanalabs/uapi: move uapi file to drm
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     airlied@gmail.com, linux-kernel@vger.kernel.org,
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

On Tue, Dec 27, 2022 at 9:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 26, 2022 at 11:32:26PM +0200, Oded Gabbay wrote:
> > Move the habanalabs.h uapi file from include/uapi/misc to
> > include/uapi/drm, and rename it to habanalabs_accel.h.
> >
> > This is required before moving the actual driver to the accel
> > subsystem.
>
> What requires this?  Isn't this going to break userspace code?
Yes, most definitely it will break userspace code. Moreover, the
patches I'll send in 1-2 weeks to change the device char files will
also break it.
Having said that, I'm not worried because I don't believe anyone is
working with the upstream version because there is no NIC support
(yet).

If this is unacceptable, I can offer a couple of alternatives and we
can discuss what's best:

1. Do what AMD did a couple of years ago with radeon and amdgpu. We
keep the habanalabs original driver in misc to support Goya, Gaudi1
and Gaudi2 (only with the current features). Create a new habanalabs
driver in accel that will support only Gaudi2 and beyond. Our NIC
driver (which I will start upstreaming in a few months) anyway will
only support Gaudi2, so it will only work with the new driver. Make
the drivers mutually exclusive in Kconfig.
Gaudi2 as-is will be supported in the current driver, but if users
want to use new features (and NIC), they will need to move to the new
driver.

2. Move the driver to the new accel, but keep a copy of the uapi file
in misc (to prevent breaking include paths). In addition, expose both
new accel device char file (through drm code) and current habanalabs
char file. Users can "acquire" the device through either
/dev/accel/accel0 or /dev/hl0. Add new uapi content only to the uapi
file in include/uapi/drm. This is what I'm going to do in our internal
tree that we release as an out-of-tree driver to customers.

3. Keep the driver in misc. Clone it to accel only for next-gen ASIC,
whenever that may be.

WDYT ?
I'm sure there are additional variations of the three options above,
or a different option entirely.

Thanks,
Oded

>
> thanks,
>
> greg k-h
