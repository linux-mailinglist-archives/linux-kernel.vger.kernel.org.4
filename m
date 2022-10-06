Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B175F5FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJFECd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJFEBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:01:53 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF265D0C8;
        Wed,  5 Oct 2022 21:01:06 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 81so861468ybf.7;
        Wed, 05 Oct 2022 21:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6FEpZzUIIALxm83vgroqHlFFNxBtMqaBbY9R+OwYZw0=;
        b=P23d4LxuVnaS//MJL9yh8wKfh16MGZz0bhrACN61FjWCZwgIb1nbwHRACJ+s9i3L/c
         uEzV4sJ8n9TUd15aeERrPcTjuwNfQdhuM7Ix3uOJuUGNwj86pyrS/xIIBZT7iVgXDr3U
         HB4iAJZS3zxwtDVwkXD0SWitmuo3pGMRb3CAobNZMDOrz0l/MLBkdoCfkpk3aCIKRs8M
         eJOkUSy017X5lYpkteH+yPe9ofFEXvBBMrAF13xs26M/EeFokr9SgaJKd84B8iccsS5r
         CFRcSs0sVraSJAV3AyB0ZqIFdDDvc6w1vV9zLxbwN53n13Wv2EowRgNKLt6UO1ycvcEp
         QfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FEpZzUIIALxm83vgroqHlFFNxBtMqaBbY9R+OwYZw0=;
        b=SmS5RoX9mo4VRnnIi847l21/VYqNT1KpKwSpeRL3zOaaSYI5GolXnk/c1u8e/JeGhq
         0E5U2WD0BpG6KpW7buIKZmVR9RHOvLfcrLwL4QxH2JFPduhBBZ71g5dnJxQ1vfVNFs5a
         5pE4p5TtcD3EL9n0Q17UQ6y2H4ajsWBBID3dipPvCIv0+iaP9585TMwloU4G4ODivcOn
         2xi2Tb62iBvuxqkNkeyNcz3MPOH92faLBzrrcDPMDyA1jNMtaUsXbFJvD+cu2TlAunuw
         XwpRMn3kPLNi50Djlhruj1LqBInQF10NRtxloPzTxChJImMo6BFQIWWlW62sRDFh88Dp
         xjdA==
X-Gm-Message-State: ACrzQf2jNLtBovckorCMPIiRomuWiyXZgCz37JNe0teiH1qtG8XPwRKm
        sWI7kOGePkxcaineuaI4kq3dtRppKGVF7eb59CA=
X-Google-Smtp-Source: AMsMyM5f8rH03ULqqlSvZcbPdaSPeQgUkRge/mXTDjFnrkRANVOoUy8OifHqCpqJJVhPOQbcnVtDXrD+gIhpGu6LyLI=
X-Received: by 2002:a25:3ac1:0:b0:6bc:d21:a35 with SMTP id h184-20020a253ac1000000b006bc0d210a35mr2871610yba.526.1665028865936;
 Wed, 05 Oct 2022 21:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221002220301.18921-1-hcvcastro@gmail.com>
In-Reply-To: <20221002220301.18921-1-hcvcastro@gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Wed, 5 Oct 2022 21:00:54 -0700
Message-ID: <CAEc3jaDLE1_+cCdL0nwUq-TPzBhoPmukGs527TokNN=iwqO5Hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: hid: adjust gyro calibration data
To:     Henry Castro <hcvcastro@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hm, I'm not the biggest fan. Is this an official DS4 or a clone
device? It sounds like it is some type of clone (some look real).

On Sun, Oct 2, 2022 at 3:03 PM Henry Castro <hcvcastro@gmail.com> wrote:
>
> For some reason my DualShock 4 get the calibration
> data values equal:
>
>         gyro_pitch_plus == gyro_pitch_minus
>
> Probably due to some defect in the DS4 hardware, and cause
> a CPU division exception to crash the linux kernel.
>
> At least with the patch, I can continue play Retroarch
> without using the Gyroscope :)
>
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
>  drivers/hid/hid-sony.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 87b538656f64..656caa07b25f 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1823,6 +1823,15 @@ static int dualshock4_get_calibration_data(struct sony_sc *sc)
>         acc_z_plus       = get_unaligned_le16(&buf[31]);
>         acc_z_minus      = get_unaligned_le16(&buf[33]);
>
> +       if (gyro_pitch_plus == gyro_pitch_minus)
> +               gyro_pitch_minus *= -1;
> +
> +       if (gyro_yaw_plus == gyro_yaw_minus)
> +               gyro_yaw_minus *= -1;
> +
> +       if (gyro_roll_plus == gyro_roll_minus)
> +               gyro_roll_minus *= -1;
> +
>         /* Set gyroscope calibration and normalization parameters.
>          * Data values will be normalized to 1/DS4_GYRO_RES_PER_DEG_S degree/s.
>          */
> --
> 2.20.1
>
