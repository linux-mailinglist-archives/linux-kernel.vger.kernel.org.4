Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4E65A883
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 02:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjAABTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 20:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAABTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 20:19:30 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392E55FFD
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:19:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u12so22191523ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWwh5IwBaUw+OYSvPtv6bOFq6Agw/hMRVs0zczOyOdc=;
        b=BLzuaGCG7eFSJIcNvg7jbGdGrEq0cAYkCu1udOVM3anYj2RYNDxENjKZf9RzYI8K2k
         IianGlkJUhS/x5fH3YLhH4BRK3k7yll28E0iCEt7pokathpO3NnDMTTZDj55i87Dglvk
         TKmOe0NPV/CNu6r4hiigjeKYSyHgGMwBPnaUICHuy0LnfwVRNv7ahphOx8SxTJv5aeXP
         2ZLIyLjZBW7JYKav8Hr54eZ4jI5q9KZ8uxBOXofDWN3C0/l0H2oUqtSPBxwY91qqqCxj
         uVhm9gpy1UX0NXa8R/wXcxPO1/a/Rto5q5lYSYOFR6QoMtHRhvXDk9EG1i1p778mQw3x
         3P+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWwh5IwBaUw+OYSvPtv6bOFq6Agw/hMRVs0zczOyOdc=;
        b=yBI9t10gAf6M4Mcjm5WydHgCYHkKfK2QhXQrVKJwxfALwI8OJkWR6f4iitIs+2bqj2
         PSH1LLnzcZRJMx7Xhca0J9PihF85rhxCWWTZXP0Gh9kJ4upYmjVRwMreKBxEKpr7GPLs
         qVt6yR29GZaZifsqQmUCkOk3KOm+AASLnjXSiseNaJDradx8/Srx6R8tgfN5JdyCGfh0
         UwgbTyAohss0qcsQEnrOy2GYMBK9OESF7AWomktKHP5Hl+FQ7Dya8ijZM2pYdpdevt74
         AaY/s6YpWgxvFxT8C4wWWlCndQ9kylUC9HwwU2PV8rl8+O6GXTs+/DNMqGyh8R8BeAgA
         8gug==
X-Gm-Message-State: AFqh2kp3rUhpqSo/uhn4vthZLHPte7+6F9F3AiF30QQKIgqbhKwGRgSh
        1kVAp9/4kYsYDVNLythC9R8UHB/NVwZTmbt+LRHJYoJIk80M1w==
X-Google-Smtp-Source: AMrXdXsTjPSCIQPNUlO71azT6DjYCfgwbXqf3lG32yFMX67w+72635sLreesZHAFF9WXFRMKD/C4/vqtrynRhMPlw2o=
X-Received: by 2002:a2e:8059:0:b0:27f:c047:62b7 with SMTP id
 p25-20020a2e8059000000b0027fc04762b7mr828370ljg.346.1672535966137; Sat, 31
 Dec 2022 17:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20221231055310.2040648-1-yoochan1026@gmail.com>
 <Y7AHvYfZreO/G/kT@kroah.com> <CALQpDLfMjAE9_VtMO6e_iiPrciFNbksLQT3AB3QTGwZCNf5=sA@mail.gmail.com>
 <Y7AhLWSPE+2hnZ2I@kroah.com> <CALQpDLc4+-0st-U_s+09QCb2nmv=nQizheGXjhyKJLGS45zmZw@mail.gmail.com>
 <Y7A9ssF/WPVDMUKl@kroah.com>
In-Reply-To: <Y7A9ssF/WPVDMUKl@kroah.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Sun, 1 Jan 2023 10:19:14 +0900
Message-ID: <CALQpDLdqW9UYfk_3AKXk-yiCtUize=HXDTM6h-nurH31j9FN8A@mail.gmail.com>
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     matt.hsiao@hpe.com, arnd@arndb.de, linux-kernel@vger.kernel.org
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

> And how can this device actually be removed from the system?  Is that
> possible with this hardware?
HP ILO device is connected by using LAN cable.
Therefore, the detach function is triggered when the attacker
physically detaches the LAN cable connected to the HP ILO device.

> And again, this is not the correct solution as you have way too many
> reference counts happening here.  Please become more familiar with how
> these all work before adding another one and causing more problems like
> this patch did :(
Okay, I'll find a better way to patch this bug.

Sincerely,
Yoochan

2022=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 10:48,=
 Greg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Sat, Dec 31, 2022 at 10:06:19PM +0900, Yoochan Lee wrote:
> > Thanks.
> >
> > Since I don't have a real device, it is difficult to verify the bug dyn=
amically.
> > However, this type of race condition (i.e., b/w remove device and
> > fops) is prevalently founded recently[1-3].
> > Therefore, I think this bug can be triggered if a real device exists.
>
> And how can this device actually be removed from the system?  Is that
> possible with this hardware?
>
> > The main reason for this race condition (i.e., b/w detach and fops) is
> > there is no proper lock mechanism.
> > I think the detach device function is delayed until the other
> > operations (e.g., fops) is finished.
> > To this end, I use kref to wait for the other operations.
>
> And again, this is not the correct solution as you have way too many
> reference counts happening here.  Please become more familiar with how
> these all work before adding another one and causing more problems like
> this patch did :(
>
> > The tool I am making is currently under development, and it can find
> > the race condition between detach function and fops.
>
> Then you MUST document this as it looks like your tool needs work.
> Please read Documentation/process/researcher-guidelines.rst for what you
> MUST do if you use a tool to find "issues" and send out random patches.
>
> good luck!
>
> greg k-h
