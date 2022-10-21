Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6BB606FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJUGLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJUGLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:11:17 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45CD109D64
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:11:16 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id x13so1421337qkg.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TDVEecvJ/SyUgNeYkrUsV7GwIq/acYXERijSp1ev9I=;
        b=af+XHWpH2wFmLESBvoDa53/Ahgt8ffIl6QGSwnrtokuIRg/3jRps7FrEa4rWTzzk6O
         hdg3enDxjfSk0bsJWevvglz+TrZHs4tHrW0cFUDPrr41FAlyt203JnzvIGZ9p2K8KZX8
         AbMZsczY4IsDZHUgoHwvDMC7vMC94CDGQbwcMh4h2XqngsAdWdZ/pa2UzxU5nzJysEkW
         Bw00aouawlA5J5rNTMTFQS9Jl0qc18SR6tgSQwxVaiIdZQ7Axmn0ZygbslzsNpB+EZIE
         lURoYnIoE3c5QrwkN/s+dVQvtNvHjvMGsXfqUR8IAdA8PKNa6G8S0wALt3Sssq+/TDJa
         AjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TDVEecvJ/SyUgNeYkrUsV7GwIq/acYXERijSp1ev9I=;
        b=jSKs683C5kc3wwHPVG+WeGwm4nb9S/c80AOXGtSO9eK9gbcFH6duFXclVLKYDJ6xDi
         6O0EvG+VRBQl6qQkXvzP0FNWJEtLREKubDk8lHh5iGlISkO+ivGD8mIziSawO+HXjCFL
         y1K1G59fiK+PcnGzI+hj/NYtV1uMkvnnC/Jls2d78l81OypVE12NFNFZQH53LsEXZQ1P
         gdP3vgFFM0PT2mfjAqmytFbNq5LzGiWc9t8jQtSxhIbzsGLf7JeDUEAjl1OsJegMKnlt
         j/irJSk/UTmwKgfg0C2OMbqd2s2iJIcP1b0pl4CYmqXSFHBAt5uCLSun1waqBpW/eRkV
         fNHQ==
X-Gm-Message-State: ACrzQf3zIM7j34q00brC+W43U9FygCZ1r7NY5Y5yGHyy/22/yWkXyuPe
        Vf/4dMTmZo57qqp1159ok5kdf2CYZAkDyqnVDsY=
X-Google-Smtp-Source: AMsMyM4KFK7vhngr/End276m/Ke1VLWd6CSQzc7IjKQg45J57OCw0TjBWsZmBaJPhSDIeAUpkVh9FKOvIY97lUZRkSs=
X-Received: by 2002:a05:620a:2699:b0:6cf:3a7f:5fe6 with SMTP id
 c25-20020a05620a269900b006cf3a7f5fe6mr12797372qkp.103.1666332675621; Thu, 20
 Oct 2022 23:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <Y1Eqa7uKB+Wk+Mb+@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <CAOkYk0iU0B98JsH77avky--AS19V=GhQox2f_b4PAG3ZBB+SVQ@mail.gmail.com>
 <CAHJEyKX=yyuyYFajs880CuPdc019dBOm_LCkgXHzjFaA-Jgt2A@mail.gmail.com>
 <Y1E6qYkzkRxlloNp@kroah.com> <Y1Fds7BJjY/OcwU0@mit.edu> <Y1Hby38PE/QVlRhF@Slackware>
In-Reply-To: <Y1Hby38PE/QVlRhF@Slackware>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Fri, 21 Oct 2022 07:11:01 +0100
Message-ID: <CAHJEyKU7dH6HQW4rrd3gq5pnYUxOA0MGRUqtnC_yExt3PBok1g@mail.gmail.com>
Subject: Re: Request for assistance
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tanju Brunostar <tanjubrunostar0@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 12:38 AM Bhaskar Chowdhury
<unixbhaskar@gmail.com> wrote:
>
> On 10:39 Thu 20 Oct 2022, Theodore Ts'o wrote:
> >Tanju, some additional hints.  First of all, please don't send cleanup
> >patches to address checkpatch --file complaints about overly long
> >lines.  It's generally not worth the code churn.
> >
> >Secondly for code that *you* are writing, think about why you have
> >lines which are exceeding the line width in the first place.  Is it
> >because code is being nested too deeply, and perhaps some judicious
> >function refactoring with good function names might make the code
> >clearer?  Would adding some temporary variables that are judiciously
> >named make the code look clearer?
> >
> >The rules about "thou shalt never have lines which exceed 78
> >characters" are rules of thumb.  The high level goal is to make the
> >code more readable and easier to understand, since good code is
> >maintainable code.  And sometimes it's not just about where to split
> >lines of code but whether there is a better way to structure the code
> >so that long lines aren't needed in the first place.
> >
> >Cheers,
> >
> >                                       - Ted
> Righto!! I failed to miss it my replies. That an editor can be trained or
> customized to that way. Especially , vim and emacs.
> --
> Thanks,
> Bhaskar
>
> "Here's looking at you kid"-- Casablanca
> https://about.me/unixbhaskar
I appreciate all your replies. They have been quite helpful. I will
try to apply them as I continue on my journey of contributing to the
kernel
