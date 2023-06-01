Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A071F5D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjFAWOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFAWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:14:11 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2CB1B4;
        Thu,  1 Jun 2023 15:13:44 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-561d1c4846cso328887b3.1;
        Thu, 01 Jun 2023 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685657608; x=1688249608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgSe4yPKC4Ie6mfk+f6dt8MfVPoiPfF24WwsiP2m7pk=;
        b=JgiWv+DBFw3orHyGwm/A7Uj0Gs+A/6iLpp2/S9llhZLFWJMa15tbHWSk1y3lxd7h82
         8RAPPWHHwbu3MUu4vQA/COZM00+v+t7UCp7cpz5cv0BBHc0C8xjM4gCK5Xj8HiF2FmeG
         jMm3+dKcEjlsemIMyw92zoiqg7CG1qzxJCxbqHuZkikIG39ZIAHNWz+Hooo/qGxSnR4D
         5mXmfMwj4FJsNx5oYSvSd5G50gVb6XVr2wyKDe+68oq3Nqi/StZqAImiIzW9ja8g7bQ+
         Kb3MLgjMCVuZK1iDbmCpD05cV+ErJyilmWbmWPho0ChMxZa5tLEtKtNGRTVyE26QbN09
         bWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685657608; x=1688249608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgSe4yPKC4Ie6mfk+f6dt8MfVPoiPfF24WwsiP2m7pk=;
        b=Vwn2NDKRieZkeYq/cYbTRn16wfRCq1K/ttBAfk6NmsXrTudUASD36Gfdkxdkru+p2I
         EOX3kf/RT8LFxsbQrThQazDQ4AKgeVg9gkwZiab3hr33n5qMoJN5MfM2w0kjuaXsUUUH
         yMkjDSwKGo41uVi3peCH+FfqheZJebLPsivosb1+TSxmuoxmhDLn31/LRT0Sp7H6QlB4
         icXrWTPZGgB4m61hDs6llzf4Dyamr95QL41QABjx0FXQJcaIkMtQ6ZMQQ9JH3DRKIZMt
         nH8xv8TlOhWvYc6ES+azbFSkN0pj3xzmmIBRve9kHrf241bfy1Pfj7E0UJNA3Gxizlzo
         3hwA==
X-Gm-Message-State: AC+VfDyOEURppr2UbtEXlLCjZDYiDCntnC4N11Ea4NWCP0SGH05BAizN
        aaWuZzADbpePDpkETcmqBtG1DIcgiZ8qhC/sJ0o=
X-Google-Smtp-Source: ACHHUZ7FdK1COpLoHURlQ5kwJbzc1UrbXE+KoasqlIFy7FrHIBtaKwzHqkHZ7GjiaEbsOFUcXfnJ9clIDEHuKMWLkSY=
X-Received: by 2002:a81:70cd:0:b0:561:eb6d:c0db with SMTP id
 l196-20020a8170cd000000b00561eb6dc0dbmr8043695ywc.2.1685657607097; Thu, 01
 Jun 2023 15:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <ZHZq7AV9Q2WG1xRB@work> <fe0739cbe279cf9db2ebff1146e7ae540cc1ad6c.camel@linux.ibm.com>
 <202305301529.1EEA11B@keescook> <25ef15e7601e1b4510cbbd40c6d1ab7c64213863.camel@linux.ibm.com>
 <202306010931.92796DC@keescook>
In-Reply-To: <202306010931.92796DC@keescook>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Thu, 1 Jun 2023 15:13:16 -0700
Message-ID: <CABPRKS8zyzrbsWt4B5fp7kMowAZFiMLKg5kW26uELpg1cDKY3A@mail.gmail.com>
Subject: Re: [PATCH][next] scsi: lpfc: Avoid -Wstringop-overflow warning
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I understand the desire to satisfy a compiler warning, but for what
it=E2=80=99s worth I don=E2=80=99t think "size" could ever be negative here=
.

size =3D LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsize;

phba->cfg_ras_fwlog_buffsize could never be larger than 4 because it
is restricted via lpfc_ras_fwlog_buffsize_set and LPFC_ATTR=E2=80=99s call =
to
lpfc_rangecheck(val, 0, 4).

And, #define LPFC_RAS_MIN_BUFF_POST_SIZE (256 * 1024).

So, 256 * 1024 * 4 =3D 1,048,576 =3D 0x00100000 is the max =E2=80=9Csize=E2=
=80=9D could ever be.

On Thu, Jun 1, 2023 at 9:49=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Wed, May 31, 2023 at 10:56:50AM -0400, James Bottomley wrote:
> > On Tue, 2023-05-30 at 15:44 -0700, Kees Cook wrote:
> > > On Tue, May 30, 2023 at 05:36:06PM -0400, James Bottomley wrote:
> > > > On Tue, 2023-05-30 at 15:30 -0600, Gustavo A. R. Silva wrote:
> > > > > Avoid confusing the compiler about possible negative sizes.
> > > > > Use size_t instead of int for variables size and copied.
> > > > >
> > > > > Address the following warning found with GCC-13:
> > > > > In function =E2=80=98lpfc_debugfs_ras_log_data=E2=80=99,
> > > > >     inlined from =E2=80=98lpfc_debugfs_ras_log_open=E2=80=99 at
> > > > > drivers/scsi/lpfc/lpfc_debugfs.c:2271:15:
> > > > > drivers/scsi/lpfc/lpfc_debugfs.c:2210:25: warning: =E2=80=98memcp=
y=E2=80=99
> > > > > specified
> > > > > bound between 18446744071562067968 and 18446744073709551615
> > > > > exceeds
> > > > > maximum object size 9223372036854775807 [-Wstringop-overflow=3D]
> > > > >  2210 |                         memcpy(buffer + copied, dmabuf-
> > > > > >virt,
> > > > >       |
> > > > > ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >  2211 |                                size - copied - 1);
> > > > >       |                                ~~~~~~~~~~~~~~~~~~
> > > > >
> > > >
> > > > This looks like a compiler bug to me and your workaround would have
> > > > us using unsigned types everywhere for sizes, which seems wrong.
> > > > There are calls which return size or error for which we have
> > > > ssize_t and that type has to be usable in things like memcpy, so
> > > > the compiler must be fixed or the warning disabled.
> > >
> > > The compiler is (correctly) noticing that the calculation involving
> > > "size" (from which "copied" is set) could go negative.
> >
> > It can?  But if it can, then changing size and copied to unsigned
> > doesn't fix it, does it?
>
> Yes:
>
>         (int)   (const expression 256 * 1024)           (u32)
>         size =3D LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsi=
ze;
>
> this can wrap to negative if cfg_ras_fwlog_buffsize is large enough. If
> "size" is size_t, it can't wrap, and is therefore never negative.
>
> > So your claim is the compiler only gets it wrong in this one case and
> > if we just change this one case it will never get it wrong again?
>
> What? No, I'm saying this is a legitimate diagnostic, and the wrong type
> was chosen for "size": it never needs to carry a negative value, and it
> potentially needs to handle values greater than u32.
>
> But you're right -- there is still a potential for runtime confusion in
> that the return from lpfc_debugfs_ras_log_data() must be signed. So
> perhaps the best option is to check for overflow directly.
>
> Gustavo, does this fix it?
>
>
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_de=
bugfs.c
> index bdf34af4ef36..7f9b221e7c34 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.c
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.c
> @@ -2259,11 +2259,15 @@ lpfc_debugfs_ras_log_open(struct inode *inode, st=
ruct file *file)
>                 goto out;
>         }
>         spin_unlock_irq(&phba->hbalock);
> -       debug =3D kmalloc(sizeof(*debug), GFP_KERNEL);
> +
> +       if (check_mul_overflow(LPFC_RAS_MIN_BUFF_POST_SIZE,
> +                              phba->cfg_ras_fwlog_buffsize, &size))
> +               goto out;
> +
> +       debug =3D kzalloc(sizeof(*debug), GFP_KERNEL);
>         if (!debug)
>                 goto out;
>
> -       size =3D LPFC_RAS_MIN_BUFF_POST_SIZE * phba->cfg_ras_fwlog_buffsi=
ze;
>         debug->buffer =3D vmalloc(size);
>         if (!debug->buffer)
>                 goto free_debug;
>
>
> -Kees
>
> --
> Kees Cook
