Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81575BEF93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiITWCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITWCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:02:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5157B74DC0;
        Tue, 20 Sep 2022 15:02:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q17so4719360lji.11;
        Tue, 20 Sep 2022 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KKoSHRBxBw2hqUBrqTTCYRIaI1B095qY9I7hde1tbzI=;
        b=CR2NPIKW1E07gtvBE1ipzhl0IqCpbv7kFPXjgP09xoYDF5n9L9dW/3w8JM9VvvAUh4
         YgOE+ZKZf3qXkIw+A+SuYydvd4WPFyxqUhWG4al07ZhGG7+HZYiL1X5K9LN2wcNaEqz9
         6YsihPHOcG7tajD0t8Ti3+swhCu76446wiP6dHWGtRj0K2RXA9GRtA+zRNCl+GZFJAtv
         vCXiujWKC514x4sHgVLqOwr7BYACBmJvW32IHxAi44c6LqUXi/NWSocAQ5UNOQOxuutB
         LjmGFEAGfDHUye1uyy+biFJ1V9sURSrxvRjd7ErYQqSIR9bTZI7MEOf6rOkjIAlgTXq8
         +yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KKoSHRBxBw2hqUBrqTTCYRIaI1B095qY9I7hde1tbzI=;
        b=aNgz2kOvhC/hXNpdpcN1Glop6VnEC9sCpr2ur5Yg9LBV3c0wZfN88VwaM4Ombaqvdp
         6yIaBulI5Xgy7+kCFcajZoLHgzAJrLAVEw1mdvYl33OJKheXxcHTCBwZn2iR6l+50nZd
         bCT0B4q9l9B+X+mVuZ28kIXH/yF8M6PlAYzB7yM/VtFSJ1961nApvJbrOo6mdIYFdzvY
         EiI3TIePqHiXW0/7k3n9LruMaTotY8I9y+Xlc4Hvrd9K+kKXitAUt/u+vDAL+ucQexGx
         Lnm9ToX4Xu1I90NXbnpUvKmbxcauz/fBbfAa4POgcaEoqg3HC5O5paab58JJp1U1lMAt
         Gpxw==
X-Gm-Message-State: ACrzQf00gk7ZjtUGrv5O6wVWzz5jw4n1Sks+YHAhFasCG8ZiB1HcCnrQ
        0eGILbiFvDIa4iG6POR0dgpRWC9vZdSqJVK1wOI=
X-Google-Smtp-Source: AMsMyM6GSjRrCb2VJkivB1ycysFKNJCKgnWhNMSn1DeMgdoWsRF+SyXcEFTMXjJVCdTbGpt0+SRDnUMtU7+XtkHALcY=
X-Received: by 2002:a05:651c:98d:b0:261:b5c0:121d with SMTP id
 b13-20020a05651c098d00b00261b5c0121dmr7448391ljq.336.1663711365568; Tue, 20
 Sep 2022 15:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <RINjeKS0brZzIa6F-fgBKuiHrrcZB8zfTg_chbQIT3BRLqx-l9SmsxvV3LXx7upuctFCki33uAIhXNsM92YWTub8vbzSQHcJibhPkN5ijB8=@protonmail.com>
In-Reply-To: <RINjeKS0brZzIa6F-fgBKuiHrrcZB8zfTg_chbQIT3BRLqx-l9SmsxvV3LXx7upuctFCki33uAIhXNsM92YWTub8vbzSQHcJibhPkN5ijB8=@protonmail.com>
From:   Daniel Ogorchock <djogorchock@gmail.com>
Date:   Tue, 20 Sep 2022 18:02:33 -0400
Message-ID: <CAEVj2tn8byGn2RHmvYc77rv2BZkApW3yQ5qSDDzNGxhbygO2Ag@mail.gmail.com>
Subject: Re: [PATCH v2] HID: nintendo: check analog user calibration for plausibility
To:     Johnothan King <johnothanking@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:54 PM Johnothan King
<johnothanking@protonmail.com> wrote:
>
> Arne Wendt writes:
>   Cheap clone controllers may (falsely) report as having a user
>   calibration for the analog sticks in place, but return
>   wrong/impossible values for the actual calibration data.
>   In the present case at mine, the controller reports having a
>   user calibration in place and successfully executes the read
>   commands. The reported user calibration however is
>   min = center = max = 0.
>
>   This pull request addresses problems of this kind by checking the
>   provided user calibration-data for plausibility (min < center < max)
>   and falling back to the default values if implausible.
>
> I'll note that I was experiencing a crash because of this bug when using
> the GuliKit KingKong 2 controller. The crash manifests as a divide by
> zero error in the kernel logs:
> kernel: divide error: 0000 [#1] PREEMPT SMP NOPTI
>
> Changes in v2:
>  - Move the plausibility check to joycon_read_stick_calibration() and
>    have that function return -EINVAL if the check fails.
>  - In the plausibility check, change >= to ==. hid_field_extract() never
>    returns a negative value, so a scenario involving min > center or
>    center > max is impossible.
>  - To reduce code duplication, move the code for setting default
>    calibration values into a single function called
>    joycon_use_default_calibration().
>
> Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
> Link: https://github.com/DanielOgorchock/linux/issues/36
> Co-authored-by: Arne Wendt <arne.wendt@tuhh.de>
> Signed-off-by: Johnothan King <johnothanking@protonmail.com>
> ---
>  drivers/hid/hid-nintendo.c | 58 ++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
>

Reviewed-by: Daniel J. Ogorchock <djogorchock@gmail.com>

Thanks for the fix. This seems like a good way around invalid calibration data.

-Daniel
