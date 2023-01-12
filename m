Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20AF666909
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjALCqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjALCqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:46:32 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B36430;
        Wed, 11 Jan 2023 18:46:31 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-14455716674so17609108fac.7;
        Wed, 11 Jan 2023 18:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RYpkCxdikbGwIjWZhsWn9ddRmi7+gdPMayCS87Hq0s=;
        b=Rqs47a2SG3ieOtY4KHtrrVwDVhAzPKELErx6dil0p1ZVGqC3eVNYPazvmRf+r7ND/g
         oJ8QVvqbiqWaiba0wA6d74Urnjpv1Xv/HXtbk0+E8XOTt/BCVcRQV0MCZzUQOkNDwi/3
         6ChZtVcqc5KzL5Z3wXfNQk00gho3sy8nRla9MYi5ZkfR41PNxdPmCBNhJpRraTK5ng96
         hfeHmkZDorQV85pjNeupJNANQDJNTkkMwiCjsUaq6dbhVBaMaP8uxc2Z0xXWkcqPdB7b
         4k0E0y3oliO/cMGsexp7E4b7XnbKYMchbGcSH7kjP+miZxw3mRzWaQ+JdBU1dMFkJn+P
         Tfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RYpkCxdikbGwIjWZhsWn9ddRmi7+gdPMayCS87Hq0s=;
        b=uijLWegfoYKSS2jeR19tFA04zMvMcn0XV0emBYrPJa7olvdZhD611Ez0WDLG7CrnS9
         Y6g5OlGgyMQy6HO8ud3XO8a4wnuKIAHk5MdHGBYCG7G+e1bXiluEppjtzK5cVxwu1ZR5
         ibhvnEA6MBWVFw0pqAUdOrfJpj2JLzhvCmns6N+7zE3HdAhHUOHpABehu4e06KAEH76l
         QFuBsfb4DSMtZIPZOp6JK8EC0cSxm/5OkK8ie6V7GI9s2c/vprIqq18IWAJQy4zTArKk
         lw/YinUu8VSLcih7JsQmyziW/iTEA+GZ5wWfiyy4m7g4LaQ0kp+SH00wjTZsDMK4rAGZ
         lb3g==
X-Gm-Message-State: AFqh2krccf60R+Cm0IUinvPgFiTRpgJndzxU1S4PZVlMAYl3KAkz4Yj/
        5EKcCyTYNWlEw0Bz+gzLgPpbQ3/ZnWxabNUKGUE=
X-Google-Smtp-Source: AMrXdXuDUPZC0qvjqWoYlojdffK4WV9uJaE2Bb3GOU69NVCn22uJjzYZLpG4uxbrRdkM1/tUweEmyf8fw5aj9uypO6I=
X-Received: by 2002:a05:6870:c8b:b0:150:d562:4a8e with SMTP id
 mn11-20020a0568700c8b00b00150d5624a8emr3275623oab.77.1673491590353; Wed, 11
 Jan 2023 18:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20230109123216.4974-1-fengqi706@gmail.com> <CACOZ=ZW5vpaPpFsQ64nSE3kinUhGDBeDey7odvnGeZFEKys32g@mail.gmail.com>
In-Reply-To: <CACOZ=ZW5vpaPpFsQ64nSE3kinUhGDBeDey7odvnGeZFEKys32g@mail.gmail.com>
From:   qi feng <fengqi706@gmail.com>
Date:   Thu, 12 Jan 2023 10:46:20 +0800
Message-ID: <CACOZ=ZU9mOj5Yr7_MJGjOH4wq2uRfXJt=QLZpD0SUQr9R4Vr=g@mail.gmail.com>
Subject: Re: [PATCH] HID: add KEY_CAMERA_FOCUS event in HID
To:     jikos@kernel.org
Cc:     rydberg@bitmath.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>, lixiaojie5@xiaomi.com
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

please help me review this code

thanks a lot

qi feng <fengqi706@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8810=E6=97=A5=
=E5=91=A8=E4=BA=8C 17:53=E5=86=99=E9=81=93=EF=BC=9A
>
> loop more
>
>
> Qi Feng <fengqi706@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=80 20:32=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: fengqi <fengqi@xiaomi.com>
> >
> > Our HID device need KEY_CAMERA_FOCUS event to control camera, but this
> > event is non-existent in current HID driver.
> > So we add this event in hid-input.c
> >
> > Signed-off-by: fengqi <fengqi@xiaomi.com>
> > ---
> >  drivers/hid/hid-input.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 9b59e436df0a..22cca3406b5c 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -1105,6 +1105,7 @@ static void hidinput_configure_usage(struct hid_i=
nput *hidinput, struct hid_fiel
> >                 case 0x0e5: map_key_clear(KEY_BASSBOOST);       break;
> >                 case 0x0e9: map_key_clear(KEY_VOLUMEUP);        break;
> >                 case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);      break;
> > +               case 0x0ee: map_key_clear(KEY_CAMERA_FOCUS);    break;
> >                 case 0x0f5: map_key_clear(KEY_SLOW);            break;
> >
> >                 case 0x181: map_key_clear(KEY_BUTTONCONFIG);    break;
> > --
> > 2.39.0
> >
