Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED668CC98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjBGCfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBGCfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:35:19 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F7144BD;
        Mon,  6 Feb 2023 18:35:18 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-16346330067so17503608fac.3;
        Mon, 06 Feb 2023 18:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om88f+OVUdI8AxAASvMDoFpD3xDJBwGXSjFt6nynZvA=;
        b=Wcrt5NNlQohG+oQHYg01oVX8+5GAs1o0JrPbQ1QjERomfXWoOVXpebEzZQ4N4e6Eg4
         2zkP2ZWjfcUAa2CsRDcr2VIKd2MVXVTjQEDV3S8iR7XLK8U4DFi+9GpGTW/TzbqZuGHY
         wyMKarCtuyBVwb8lMyOxqBLHaTpjtdmFtLkY5Cs/yqdESjJGfx8Lc6m+wRCyZ+Zv3s6p
         pdIqDVDbeRSTj3csxlXvGdxh+92qGGxwIk078Ql2CAtPTwSoYq44gwnIN/XRR6kd4qzS
         HNznZmqyArRxNp2P01AZNIajBeeHn7koSVlUw/m1vOrKuGLZtOjh8iiE4NYDpfjqTCyh
         TsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om88f+OVUdI8AxAASvMDoFpD3xDJBwGXSjFt6nynZvA=;
        b=dPiBCfa6W2+Isbh0gF6KM4ZR0PrraTqymoBSg80BtMEIRYrd6ZXAn/piosTIgPQyID
         7T15j3jPcz8fi834DUb4A98netcn34vBx2sOJOQk5dIkhKYGE2KL0syEGqwetKtDI4//
         +9p8p56EAGOuqlP56dUwP0mVo7UNIhvT/Ib8LK9iylqDvCeto/q0t0lvkMlZepRUk52G
         VIzd2SLK3Rk7Ypr97qZBPq7NUNde3pw6MoLVZDnsAbn5/0HPH5znk/UBeAIgGVUJQ1VO
         g8DNXXQ4x7tOjgbks6wps1bbDezPCwroKTOQKvxzVBj6idivvmpzYjFsjvypTHQJYqzG
         t+cQ==
X-Gm-Message-State: AO0yUKUSsdTVcOxgvSUVBuIY6Opvtp7HGMRA+NyFvirrhlDxPFQaPFg6
        HatGJOFElPEhw4XK+cpm4Gff4xHoiZBDUk4Bjl4=
X-Google-Smtp-Source: AK7set/8ppfbmmdWbos6q6dyFPrP6L6Sp2eHfIVn+2iFgXeAmRuhxqTv4PtHI91h9y9LBnarGrV3zmcInZF8KC2b5k4=
X-Received: by 2002:a05:6870:4289:b0:163:82ad:dbe0 with SMTP id
 y9-20020a056870428900b0016382addbe0mr2473567oah.77.1675737318320; Mon, 06 Feb
 2023 18:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20230131114632.14078-1-fengqi706@gmail.com>
In-Reply-To: <20230131114632.14078-1-fengqi706@gmail.com>
From:   qi feng <fengqi706@gmail.com>
Date:   Tue, 7 Feb 2023 10:35:07 +0800
Message-ID: <CACOZ=ZU0zgRmoRu8X5bMUzUrXA9x-qoDJqrQroUs=+qKR58MQA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: add KEY_CAMERA_FOCUS event in HID
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=EF=BC=8C

Please help to review this  v2 code

thanks a lot

Qi Feng <fengqi706@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8831=E6=97=A5=
=E5=91=A8=E4=BA=8C 19:46=E5=86=99=E9=81=93=EF=BC=9A
>
> From: fengqi <fengqi@xiaomi.com>
>
> Our HID device need KEY_CAMERA_FOCUS event to control camera, but this
> event is non-existent in current HID driver.we add this event in hid-inpu=
t.c
> We committed this v2 version following your previous suggestion
>
> Signed-off-by: fengqi <fengqi@xiaomi.com>
> ---
>  drivers/hid/hid-input.c | 7 +++++++
>  include/linux/hid.h     | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 9b59e436df0a..05fa3e191574 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1221,6 +1221,13 @@ static void hidinput_configure_usage(struct hid_in=
put *hidinput, struct hid_fiel
>                         return;
>                 }
>                 goto unknown;
> +       case HID_UP_CAMERA:
> +               switch (usage->hid & HID_USAGE){
> +               case 0x020: map_key_clear(KEY_CAMERA_FOCUS);    break;
> +               case 0x021: map_key_clear(KEY_CAMERA);          break;
> +               default:        goto ignore;
> +               }
> +               break;
>
>         case HID_UP_HPVENDOR:   /* Reported on a Dutch layout HP5308 */
>                 set_bit(EV_REP, input->evbit);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 8677ae38599e..e3daf2c7739c 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -155,6 +155,7 @@ struct hid_item {
>  #define HID_UP_DIGITIZER       0x000d0000
>  #define HID_UP_PID             0x000f0000
>  #define HID_UP_BATTERY         0x00850000
> +#define HID_UP_CAMERA          0x00900000
>  #define HID_UP_HPVENDOR         0xff7f0000
>  #define HID_UP_HPVENDOR2        0xff010000
>  #define HID_UP_MSVENDOR                0xff000000
> --
> 2.39.0
>
