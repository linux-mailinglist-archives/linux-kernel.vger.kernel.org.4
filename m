Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDCC6DBC09
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDHPzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjDHPzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:55:03 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B8FF0F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:55:02 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-18436e0b673so692698fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680969302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy8lyv752rLSQxtmaTVe33r7tclcAkx2q5NW4/xJORo=;
        b=e6uhBnJsqB06TyLLKmDh7aoOo+UXoCrgiHLDjXiIDmKTxcG2YwF0juYTNF/w/yAy0d
         9BJCq5Joe5K1JKC+JhVf8chBQKU23tfajOqGCLXnn27B9JYV6DWib77rNFORLTELvsEF
         4OODo8tns8pnGKShfhsRdZfV/M5RSx8qRCLUeLSqqafKKooBx4yYl0iZIVFP3GDyIFFL
         Xf/cUYv/6z2oJgpIRvV+UdgvyhbNleexPY0tx9y7vPoZWPxjeWgQnQG4pjbvlf929bEy
         kujZDFbilIauPWjJfMenZ/Fq9EMGbct5h8rAWCeRc/IW3qNkoJnDayX+HOeFhQ/1gXDE
         2K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680969302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy8lyv752rLSQxtmaTVe33r7tclcAkx2q5NW4/xJORo=;
        b=n2fAYXYtRRPx1XnreUepwdjIyA7C4tRxDO3iNajMUHxY5kxE11dfaLK0yblPOJohcg
         +WCJkfwqZ9eQy5PAFdBpiAwofZqKRYn7Zc8OlHpmUiZSJdK/jLQEnnkYZtuBvLXyIT/L
         5Ue/edNCj+x9hl0xtJHX9pJvkMgmP/O/yyUkPL7WuITHxrzCgDBZWvBjLZQ3cYzI6Htq
         Sy8RZbgo+6nGf4l53xarzfsJ1bW9B4YCh4JLWnpyDoI8L7zF5r/4AryV2/fh9fJlz2UI
         VZO4mzaiQo4C6+sFjesdH1a8NEsuw9/Fymrp9pnoFDDe4Z3hYRyHOvlKwIngNlNVWI4K
         gnxw==
X-Gm-Message-State: AAQBX9eKsgbe3hoUV8qAqmDiIqAFg6FqI0j0zM5Njek8Yu4A+f+hlrIW
        aC9EYTfhjj3ovvOLlnEpqZAXwDnhoCQ8L+HO4cE=
X-Google-Smtp-Source: AKy350YeCnGipgLlIYmeOzKhB8PNdMc6GFsIzRyuB71hbGiH93MgujdxhipQHcSXmdMoG3OmdatgSMerS6MLBcsrYIk=
X-Received: by 2002:a05:6870:12cf:b0:17a:b713:63e9 with SMTP id
 15-20020a05687012cf00b0017ab71363e9mr1113212oam.4.1680969301826; Sat, 08 Apr
 2023 08:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5ayFcJsq7P2-mPAt0rvmfjYB9PaL0E2K7mKUxUC=TCTwA@mail.gmail.com>
 <323c1b8d-c778-3175-79a0-5adcc0b470b9@kernel.org>
In-Reply-To: <323c1b8d-c778-3175-79a0-5adcc0b470b9@kernel.org>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Sat, 8 Apr 2023 08:54:51 -0700
Message-ID: <CANX2M5Yfisi9yPps61=RvvyaNNgJFVGeMv1LSP9LpE=-JcHYeg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in n_tty_open
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 10:18=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> =
wrote:
> COuld you explain how this assignment can ever fail? ldata is either
> allocated correctly (non-NULL) and the assignment cannot fail or not
> (NULL) and the assignment cannot fail (as it doesn't happen).

Sorry for the late reply. We just reported our understanding of the
issue here: https://groups.google.com/u/1/g/syzkaller/c/BsxSggrhEMw

--=20
Thanks and Regards,

Dipanjan
