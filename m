Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E78715436
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjE3DiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE3DiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:38:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12D9B7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 20:38:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3b5881734so4423734e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 20:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685417898; x=1688009898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/OlmmbHcxYFVgmvOlMYJkZC2hqJ8imodwgfHQRiJM0=;
        b=k/E1ibjctutW3L3kwgpLE+/VEH93Kk+t2+9pnpwL3rBNiH8yWRkSEB4m0nlSqD+lea
         ajRnbZcWyNjX0QRi21NzlJCuoYKwvf7lxJtx8ckgiP6ymk5jBEbsGTvRhO3VFOtgaDqZ
         dIuyL7j+Z+zzBKNva3UBw892YROd6/cIIrA4Eq6ntTN0I2TOkt5vrqa3oZyF8hTlm63f
         Ur9xiNwlr1mAw964JmeEAA2HLpSa7atcqhy1z3jv9jGpO1Fwtoox0j0mC98dmm49TUOJ
         Bb27XalZzx/189i9Nzxb614vIGFBDNZcEsq+B1vda3cCY+eASFZPn3Rrd7JnD4Em0PP0
         +hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685417898; x=1688009898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/OlmmbHcxYFVgmvOlMYJkZC2hqJ8imodwgfHQRiJM0=;
        b=YI971olknvD2uhZjHMd2mndA3qIGwmGwkcLbLUe1l9uS3R8tNCRVdTrG847xBfa6xY
         pOkU0Kk+K3k1ztz6WtNycaexk8AD05JjsB+DbVQv8C5LI6Wkt0RWJnmilW6tXXxfmUMJ
         wds5xwyVE+GVa088XH1gULRM4HIBMHmNy9dlo+OHVDeM7vLG1TUg8C0aoUVbGl1EC86q
         IYhozbY3ghEAA55yyY3uXRylwhp9F/TlbcymR4X+b7/eC9OLKdHiK1CxfcmeQjTExITn
         4GYIeI5QUWc4c3B8gQtohoyLqfE7X8aECqnySCnZZEj6+mt6kD/Us2LR9E3f1IxzU1bg
         UdSw==
X-Gm-Message-State: AC+VfDzR+ApXh5QGO9FRgye9H5aG54n5n3uIkfFk4qyVHyhYH+yS7fT0
        Hif37/uHTPMtNI8J6IUGkjtrMTcw5ZBJVs49InF5pDUzf48=
X-Google-Smtp-Source: ACHHUZ7Flsj6SiQW7O2x0ZIuunz1m+uSZGRPiDpcV7GAzgvPPFMtAxSKVXWVhWXmmhwmr4F130Qr6Ij19TGrKqBJxc8=
X-Received: by 2002:ac2:4570:0:b0:4f4:b771:3a5a with SMTP id
 k16-20020ac24570000000b004f4b7713a5amr174701lfm.61.1685417897528; Mon, 29 May
 2023 20:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <CAHk-=wjpb_j4xJoKLivHFkrruR2TRcicEUkNVfXkY3xV5ybRSA@mail.gmail.com>
In-Reply-To: <CAHk-=wjpb_j4xJoKLivHFkrruR2TRcicEUkNVfXkY3xV5ybRSA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 30 May 2023 05:37:40 +0200
Message-ID: <CA+icZUUxiS0hqaVQP-f2gJPOO5QJx=6nfA8QFUMVuHM=KThDSQ@mail.gmail.com>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 7:33=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, May 29, 2023 at 12:18=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.c=
om> wrote:
> >
> > Building from scratch with latest Linus Git including:
> >
> > Revert "module: error out early on concurrent load of the same module f=
ile"
> > https://git.kernel.org/linus/ac2263b588dffd3a1efd7ed0b156ea6c5aea200d
>
> So just to confirm: both plain 6.4 _and_ with that revert hangs?
>
> The revert is pure "go back to old state", so the revert really
> shouldn't cause any problems what-so-ever.
>
> So if rc4 doesn't boot for you, and the revert also didn't fix it for
> you, then there is something else going on.
>
> There have been other module changes during the merge window, and
> obviously it might be entirely unrelated to modules too. Can you try
> to narrow down when it started failing?
>

I was able to boot into my system again with the reverted commit.
Note: Ext4-FS was built as module.

-Sedat-
