Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71956F9F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjEHFe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEHFe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:34:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF6218DC8
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:34:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4edc63e066fso23471e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 22:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683524033; x=1686116033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jC08OjOC1DWla5nQSfzR7s/KkTqWo5bIIZj9+W6g+KM=;
        b=OicGTxtjW2mt75iwX6QB6dwfsblhe+yEiK7bjD6KZmI57VudTyUd37y3lH5jPPFXlc
         Ul8ke53k+V1idOTPGuYuVNSj/yAxV5Dsjx3CYJ4NL5nCzuaM4RmLWdgrZDsKC+AS2WeK
         8jgCPM5vdlFztC/2PI+AnJ3QJ3WM47b5y5GqqP+CNCyqHnF698/cy6xG99GD5T6QbsCv
         q3DxeKUaeTcXu60YydDRPN0ZKZNSE1QyKv6yIrqgVfFH4W2YJCUB6H4EYuaStxZ79O3Q
         zA91I4SPA+Zw5pFBgfaKdUnbKnIPQ6YEY/Bj6IBvaaW8VTo2wUMPfOsInpD26KYwgTz5
         JyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683524033; x=1686116033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jC08OjOC1DWla5nQSfzR7s/KkTqWo5bIIZj9+W6g+KM=;
        b=Lmh6UIqRFDjUdNwPOMJq1MlXk5q0B9gzEWbfET2xi3U6hUav9HyitX08zL4bw0SF0P
         5Hq3Buyv8s4rbe5LUvLetjqUwK6iWxVUOyWPfqhNK/zET/caxVlCKgC2g5aEM6QWG1o3
         B5oXuppZueuycHYvM5h05g4dQXKoFKnARkw0OrVTaE1Q5q0kohrkgqgk1ofbJmhQ9Plj
         0uDhC/7I9MPrzJ6sB9NzYnFqEX41J9PD/OCOy8d94zL15ddTRdUOvU12LphZ/5x0ktkz
         IDQ+/4VQkTqAocpZgbDRjpZ/7w+M0sndZKXJyihze3QIDiPMD2u9Mr1MuFuPp9hjH+jo
         qcqA==
X-Gm-Message-State: AC+VfDyy5i3/xYcuJMB1+0pbd+fUW2ymYL6ShQMQtNsgmmivLT7DysLK
        3Q5/0dIQO3/HIFNrg8jkb3n7P/plfLP94HJfEnLjtg==
X-Google-Smtp-Source: ACHHUZ70yY23FoiSN0JOq82xMRMplT9bQTO3uCO7ZPXUhJ+AJ8lJR3Rz6I9Et1VV1JKsC+03PTRi7WIv7UYKNDzKNSM=
X-Received: by 2002:ac2:4eda:0:b0:4ef:ef1d:a97b with SMTP id
 p26-20020ac24eda000000b004efef1da97bmr177755lfr.0.1683524033064; Sun, 07 May
 2023 22:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000050327205f9d993b2@google.com> <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
 <ZFI9bHr1o2Cvdebp@gondor.apana.org.au> <ede92183-bef3-78a7-abae-335c6c5cca1e@linaro.org>
 <ZFMsvxW+pEZA2EZ7@gondor.apana.org.au> <41ddc20d-8675-d8bc-18c6-2a26f0d6b104@linaro.org>
 <20230505040134.GA883142@mit.edu>
In-Reply-To: <20230505040134.GA883142@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 May 2023 07:33:39 +0200
Message-ID: <CACT4Y+ZnTRf5BocMZZCkUva+VddOMXYGu13iWo6+3sopZzh5hQ@mail.gmail.com>
Subject: Re: [PATCH] hwrng: virtio - Fix race on data_avail and actual data
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Aleksandr Nogikh <nogikh@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 at 06:01, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, May 04, 2023 at 09:10:43AM +0100, Tudor Ambarus wrote:
> > > The syzbot ID is already present in the in the Reported-by tag.
> > > There is no reason to clutter up the commit message with redundant
> > > information.
> >
> > As you prefer. Theodore Ts'o encourages to add a dashboard link, here's
> > his reasoning:
> > https://github.com/google/syzkaller/issues/3393#issuecomment-1347476434
>
> The reason why I've requested having both the Link and Reported-by is
> because you don't know the secret incantation:
>
> s;Reported-by: syzbot\+\([0-9a-z]+\)@syzkaller.appspotmail.com;https://syzkaller.appspotmail.com/extid?=\1;
>
> ... you can't easily get from a "Reported-by:" e-mail address to a URL
> link that will actually get you to the syzkaller page.  What I used to
> do was to go to https://groups.google.com/g/syzkaller-bugs and then
> enter into the Google Groups searech box:
>
>    Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
>
> which is a ***super*** clunky way to get to the syzkaller page.  What
> would be nice is if there was an easy way that didn't rely on kernel
> developers knowing the internal URL structure of Syzbot to be able to
> enter the Reported-by link on some convenient web page, perhaps in a
> search box found in the front page of https://syzkaller.appspot.com,
> and be able to find the syzbot report web page that way.
>
> Since that doesn't exist today, I include both the Reported-by: and
> Link: in my commit descriptions, out of consideration to the reviewer
> who might want to be able to find the Syzbot page and don't know the
> secret trick to calculate the URL from the Reported-by: e-mail
> address.
>
>
> Another gotcha with Syzbot is that there are two id's, the "extid" and
> the "id" which makes thing ***super*** confusing.  For example, both
> of these URL's go the same Syzbot report:
>
> https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb
> https://syzkaller.appspot.com/bug?id=eec08eb3763c9ec749fd565e70cfe6e485af7ed7
>
> The Reported-by e-mail address uses the extid.  So for example, this
> case, it would be syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com.
>
> However, all of the links in the Syzbot web pages use the id form of
> the URL.  So if you were browsing the syzbot reports assigned to the
> crypto subsystem via https://syzkaller.appspot.com/upstream/s/crypto,
> you would find the id-style link, and then the commit fixing the bug
> might have something like this:
>
> Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=eec08eb3763c9ec749fd565e70cfe6e485af7ed7
>
> In that case, there is no (obvious) relationship between the hex
> string found in the Reported-by line and the Link line.
>
>
> One additional unfortunate fallout from syzbot having an "extid" and
> "id", is that depending on how the syzbot entry initially found by the
> contributor sending in a patch to address a syzbot report, either URL
> can be found in mailing list archives.  So if you search for
> "extid=726dc8c62c3536431ceb" you won't find references to
> "id=eec08eb3763c9ec749fd565e70cfe6e485af7ed7" even though they are
> both referring to same Syzbot report.
>
> <<< sigh >>>>   As they say, the hardest problem to solve in the
> C.S. world is naming, and syzbot has two names for every single syzbot
> report, and both are exposed to the poor user.   :-(

A link like this may work for syzbot instead of the Reported-by tag
(may work out of the box, but need to double check if we start to use
this):

Link: https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb

Or similarly this may work:

Reported-by: https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb
I think the parsing code mostly looks for the hash.

This was proposed, but people said that they need links to lore and
don't want links to syzkaller dashboard. So this was rejected at the
time.
