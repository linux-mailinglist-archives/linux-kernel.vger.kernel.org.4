Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A6721674
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjFDLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjFDLxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:53:04 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942BCDA;
        Sun,  4 Jun 2023 04:53:02 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5584f8ec30cso2932695eaf.0;
        Sun, 04 Jun 2023 04:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685879581; x=1688471581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAxQCeI6h0I53x47uaZFC8WhX7hLCllFyhAD+lcGDv4=;
        b=rySf5fpaWLJzjT0P1c/kJgwKFwZ9Tt8wrU7hLpeUR6dwkKo8g9Nj7ERLiz3bU7hFZu
         411tykjibLrgcINJRpJcEILqV/iQT6Od2/lC8MknMBlRV1M03AREELTeBUkCu2KRrEv7
         gxKMGLpLHpGue0hlZ3ri/5C1ZYOU1kfakjwKzo+tMQNBpsXITJ5Xh6CYZL4Qmhr6OvKb
         9zd3BQMPmbiVk3zZXOjcW5F+O4tGMu5K/TL3C3fn7BDXrg7qYaSW5ebdDkuvy/LmbvOa
         vtteyVhO3Y4nxD8HmJ0M3GzlwMqqjtIBUnXrjDvIZz89p58ILfhC2YDqys0m1xMLxEEQ
         kxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685879581; x=1688471581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAxQCeI6h0I53x47uaZFC8WhX7hLCllFyhAD+lcGDv4=;
        b=BAv1UFukcW5YgFtCRLUE1Mj7vOg0VNpVjzRefTtzYiZPya3ZP/7JdI/o6AB7PxVC4g
         V1Qsq8DhartDWz45m09r+cJMSmXRFa4akxhvGqCTxqrR+OhZumDF/mVI/qrUBfOfn6W1
         QtiLmJu9AE0myUZxM6IMomf4enIeCxeapvemDw58dqSIzRuPUvlKBNP+pF+foMw/5BnM
         5NUYakdsgZn7d1EWAXnJFqSvtcQuUYCU0nEj6KshmCyH3Zzuo1OtvGInuicC+SwgtHfp
         T/67ByhJ0/Ewq6O0J9EDskc+W2B0pvqI6oFsaVXy7cJRa5rRpfijYwTIOr3ie/JuoVO6
         yYcw==
X-Gm-Message-State: AC+VfDyykeIu6uUgPxwJbJQ6rqRE7tlOYOSZt8ybschI9xGRkq0HQpSM
        XLLebxWLQEpho0H5Ri7DoTl7ABdW8cnFWnDx2Kg=
X-Google-Smtp-Source: ACHHUZ6FSK3g/x041TZw2kYx/GgOwTf9dC+wP/2FjR2+habIF8B3zERsL9TKuFMAATvtITwlSLVC++4q5tqefnjW4QI=
X-Received: by 2002:a4a:97ed:0:b0:555:2ba8:a75b with SMTP id
 x42-20020a4a97ed000000b005552ba8a75bmr10953200ooi.1.1685879581254; Sun, 04
 Jun 2023 04:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XOacq3hscbXevPQP7sXRoYFz34ZdKPYjmd6k5sZuhGFDw@mail.gmail.com>
 <ZHxydoL06XHR1bOx@casper.infradead.org>
In-Reply-To: <ZHxydoL06XHR1bOx@casper.infradead.org>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Sun, 4 Jun 2023 19:52:50 +0800
Message-ID: <CAFcO6XOLYskwg4GtH1X94rTjbGRvNy5jgau28UfYG3T6azkVLQ@mail.gmail.com>
Subject: Re: A null-ptr-deref bug in reiserfs_breada in fs/reiserfs/journal.c
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, akpm@linux-foundation.org,
        yi.zhang@huawei.com, trix@redhat.com, song@kernel.org,
        bvanassche@acm.org, reiserfs-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
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

Yes, it works! I have tested the patch.

Regards,
 butt3rflyh4ck.


On Sun, Jun 4, 2023 at 7:16=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sun, Jun 04, 2023 at 04:12:56PM +0800, butt3rflyh4ck wrote:
> > Hi, there is a null-ptr-deref  bug in reiserfs_breada in
> > fs/reiserfs/journal.c, I reproduce it in the latest kernel too.
>
> does this fix the problem?
>
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 4d11d60f493c..dd58e0dca5e5 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -2326,7 +2326,7 @@ static struct buffer_head *reiserfs_breada(struct b=
lock_device *dev,
>         int i, j;
>
>         bh =3D __getblk(dev, block, bufsize);
> -       if (buffer_uptodate(bh))
> +       if (!bh || buffer_uptodate(bh))
>                 return (bh);
>
>         if (block + BUFNR > max_block) {
> @@ -2336,6 +2336,8 @@ static struct buffer_head *reiserfs_breada(struct b=
lock_device *dev,
>         j =3D 1;
>         for (i =3D 1; i < blocks; i++) {
>                 bh =3D __getblk(dev, block + i, bufsize);
> +               if (!bh)
> +                       break;
>                 if (buffer_uptodate(bh)) {
>                         brelse(bh);
>                         break;



--=20
Active Defense Lab of Venustech
