Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB6974CC20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGJFVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGJFVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:21:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A073A87
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:16:16 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E05893F0F7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688966174;
        bh=tnBWz3PKopY+XT6Jb3lHhGQnZfW7IudoUFXB+bkBQeU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uJIvcwSAd5hENh9LLdB3bevdWTB99wCGq18bYtv5AIPCHslpnk9IVhJC01QzeQBk3
         hduTJdk1xEI3LCyEj1jv0nSWI9O/UEByg1WkBvW4kf8GCP5OGfc0d8EUt6Oe5grTFv
         50XTsY3DLCTLTzfF0D0mgMd0pjnEG5E83Tvmw1UkQhllO9QEV2kuLA33+uwIWeOzYp
         aiql5J/5wCNXWt96t+xB0xsXcrMqW3de37lELkMbhTj5juP7uaZoRd7xX9d5lKgURM
         ZBDRKIadjhXonHAeUKuxtPQwkE4/lXDt7ExM4Nh2/XDd1zhQgGRjBe9UHe0/5PQfZ3
         SnqYUvfTZHs1Q==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-263036d4c9dso5276457a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 22:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688966168; x=1691558168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnBWz3PKopY+XT6Jb3lHhGQnZfW7IudoUFXB+bkBQeU=;
        b=iwm2XWpAxzV+bZrCCebOYBtOF4YsJDW57o3WSvfer1ELf8oWQBipPvCiGFnMV7gzqg
         /k3IusWm2xCduHjXSW387bpugdPzzJXIcw5ZAlKZoxmFX0GsDpka50MaPVpW1J3Z//Jc
         jvKFTi+GSSWrUp+JSbZQhUJALKONwhsBc1/zQdTmOv+qqhNLp3MaYo0X2k+R2nLMMhV5
         qkkNc5yss2VTrpZxdEp8m/9QtG6et1bL2QcSUG/jGTpq2ow2q+/RkO6+7e0d2m8jqZGG
         QzUtO7mgah+wDl70+cOB1vQ4nlFniWsxEGkwRid9KLLxMUxhEQ6BZPW1e7Q/Z1X6IkbH
         v9eA==
X-Gm-Message-State: ABy/qLYxdIrKtGwzYpr02VJqvoPUJJ97V+Wub2lO+kaLvYFiNmkMFDKh
        fDG3kvnWvgwIDxedvBmb/8vqflSinlrIwXVAqqmN7uIVQ5lrZxwIpC/jaVA0KRg1unpMYK6iN0s
        aPjv88fye5Jw1lbSHnun6mFT+RRr+xGQ2rAM0r3u2k/12yPQ0iOXxNRrQksFYlGGyv70J
X-Received: by 2002:a17:90a:43a5:b0:262:fe45:85f6 with SMTP id r34-20020a17090a43a500b00262fe4585f6mr9227662pjg.0.1688966168341;
        Sun, 09 Jul 2023 22:16:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGSMLHwotmQ8GE5O1nopccY+DvEwRjbUnvLHA7doxHeLVdJEYqh9Gx3xkpJW3kQM90q3vX5ImT8ci/ACEWrrzk=
X-Received: by 2002:a17:90a:43a5:b0:262:fe45:85f6 with SMTP id
 r34-20020a17090a43a500b00262fe4585f6mr9227656pjg.0.1688966167982; Sun, 09 Jul
 2023 22:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230704081724.2308195-1-kai.heng.feng@canonical.com> <29b68182-cb58-6a3f-0fdf-b919851e5524@amd.com>
In-Reply-To: <29b68182-cb58-6a3f-0fdf-b919851e5524@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 10 Jul 2023 13:15:56 +0800
Message-ID: <CAAd53p7-Cyqt-aGkzDNu2sqWejJQgbLcs8BBQvOZxj-FfHmo2g@mail.gmail.com>
Subject: Re: [PATCH] HID: amd_sfh: Increase bitwidth to avoid shift-out-of-bounds
To:     Basavaraj Natikar <bnatikar@amd.com>
Cc:     basavaraj.natikar@amd.com, mario.limonciello@amd.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Basavaraj,

On Fri, Jul 7, 2023 at 3:36=E2=80=AFPM Basavaraj Natikar <bnatikar@amd.com>=
 wrote:
>
>
> On 7/4/2023 1:47 PM, Kai-Heng Feng wrote:
> > UBSAN complains shift-out-of-bounds on amd_sfh:
> > [    7.593412] input: SYNA3105:00 06CB:CEA3 Mouse as /devices/platform/=
AMDI0010:00/i2c-0/i2c-SYNA3105:00/0018:06CB:CEA3.0001/input/input11
> > [    7.593541] input: SYNA3105:00 06CB:CEA3 Touchpad as /devices/platfo=
rm/AMDI0010:00/i2c-0/i2c-SYNA3105:00/0018:06CB:CEA3.0001/input/input12
> > [    7.593625] hid-multitouch 0018:06CB:CEA3.0001: input,hidraw0: I2C H=
ID v1.00 Mouse [SYNA3105:00 06CB:CEA3] on i2c-SYNA3105:00
> > [    7.664537] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    7.664540] UBSAN: shift-out-of-bounds in drivers/hid/amd-sfh-hid/sf=
h1_1/amd_sfh_desc.c:149:50
> > [    7.664544] shift exponent 103 is too large for 64-bit type 'long un=
signed int'
> > [    7.664547] CPU: 5 PID: 124 Comm: kworker/5:1 Tainted: G        W   =
       6.4.0-next-20230703 #1
> > [    7.664549] Hardware name: HP HP EliteBook 835 13 inch G10 Notebook =
PC/8C10, BIOS V83 Ver. 01.01.09 06/05/2023
> > [    7.664551] Workqueue: events amd_sfh_work_buffer [amd_sfh]
> > [    7.664562] Call Trace:
> > [    7.664564]  <TASK>
> > [    7.664567]  dump_stack_lvl+0x48/0x70
> > [    7.664576]  dump_stack+0x10/0x20
> > [    7.664578]  __ubsan_handle_shift_out_of_bounds+0x156/0x310
> > [    7.664584]  ? sched_clock_noinstr+0x9/0x10
> > [    7.664589]  ? sched_clock_cpu+0x12/0x1d0
> > [    7.664594]  ? raw_spin_rq_lock_nested+0x1e/0xa0
> > [    7.664597]  ? psi_group_change+0x237/0x520
> > [    7.664600]  float_to_int.cold+0x18/0xcf [amd_sfh]
> > [    7.664606]  ? __pfx_get_input_rep+0x10/0x10 [amd_sfh]
> > [    7.664611]  get_input_rep+0x241/0x340 [amd_sfh]
> > [    7.664617]  amd_sfh_work_buffer+0x91/0x190 [amd_sfh]
> > [    7.664622]  process_one_work+0x229/0x450
> > [    7.664627]  worker_thread+0x50/0x3f0
> > [    7.664629]  ? __pfx_worker_thread+0x10/0x10
> > [    7.664632]  kthread+0xf4/0x130
> > [    7.664635]  ? __pfx_kthread+0x10/0x10
> > [    7.664638]  ret_from_fork+0x29/0x50
> > [    7.664644]  </TASK>
> > [    7.664652] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > So increase the variable bitwidth to solve the issue.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hi=
d/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> > index 6f0d332ccf51..550639ef8bfe 100644
> > --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> > +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> > @@ -134,7 +134,8 @@ static void get_common_inputs(struct common_input_p=
roperty *common, int report_i
> >
> >  static int float_to_int(u32 float32)
> >  {
> > -     int fraction, shift, mantissa, sign, exp, zeropre;
> > +     int fraction, shift, sign, exp, zeropre;
> > +     s128 mantissa;
> >
> >       mantissa =3D float32 & GENMASK(22, 0);
> >       sign =3D (float32 & BIT(31)) ? -1 : 1;
>
> Could you please check below patch which covers more scenario's and corne=
r cases
> for UBSAN: shift-out-of-bounds.
> https://lore.kernel.org/all/20230707065722.9036-1-Basavaraj.Natikar@amd.c=
om/T/#m67e0b7aa6a288ea074b3bfa61e7f085f7e036172

Thanks for the patch. Please add my tag:
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
> Thanks,
> --
> Basavaraj
>
