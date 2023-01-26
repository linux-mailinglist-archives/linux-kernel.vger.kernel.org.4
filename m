Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31BA67D696
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjAZUl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjAZUlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:41:24 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E304125BA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:41:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c124so1922347pfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fVMuPLhQ7MqOM6GrhILLRb9j0GFeXbyWToL/2X/iFxY=;
        b=KmdNYh+eqvWDeDS4rcLM+u78dmmn4InPH9pxQNtn/u8fa23Q0k8tqcPEm/0hNGOnJq
         HdPFuYgMhKi0x9k8P9va76ZEh5Z8gZuC3b/rdtAm2cB/KU4La9LI6qOjUL7fblXEWEjb
         OljOlfOnZhoXv38yBy9XfHwvr9jgwwD1FgjdMhQp13zJaGG0YEP1M6DL6V+rZysVV8OG
         xLtGVZyokGJreQ3D4iW/5/IKgBRD/UBJODRbrAq6wqTAfcJUm/3meA0t91SbjZd/rBM1
         vDYCTgbI8hB4mszXzffuTPfL40QZCDMFpSNtTTsf5z7Y1GaxkR/gQ1euni/spYg+F7Rl
         s90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVMuPLhQ7MqOM6GrhILLRb9j0GFeXbyWToL/2X/iFxY=;
        b=X/fNxXeKj8bWvWPGGJe2PiWEM8tVVIedGJfgThiY2Ri7S1+BFixnF6P/oBMZ/2EGzD
         /ozyajC3YbyDAt8L+x0IxTsZnuvBMIfRfuRnYHHsgU8Cl+7BWHtpqHzCEBdsPapyE9/X
         goFuBZSTj1SOP4pC8ab2JiKXnDlldxM18wAiI9vBo4HVzn4zsN1f8nPhFwAPbfcJ19+T
         Kkp27obTjk2Vju6BfEWoEa6ppKGtZvOmDWtAMCYI9QWWWrG+MoWsBAkbSn+n+iduRbDo
         Wo+JJG5gLIwGb7QIUjH/LX8ga87R3BaRmkM/Xj3OInH1hSlOnWV8oRaKTD5ZvTwBSDSb
         mH4A==
X-Gm-Message-State: AO0yUKXQvf22QpFwkcdCAI7g33uQlGkm2RRajblrU31jmZ8Gg5YZG1Xm
        K/T0ewywE6PD7ErEz8lZrftZTpvv/+eAFjrlRNYVkbQM3ZSOvmA6
X-Google-Smtp-Source: AK7set/ZzNhQNeQ+aVnimgeueSuhljnNd4gRDZYaaf6YQ618+S6Mw3eaAEGR6G5CssPOncxy1IOl0WWzkMPrvvFLPoE=
X-Received: by 2002:a63:bd52:0:b0:4da:af6:ed with SMTP id d18-20020a63bd52000000b004da0af600edmr851945pgp.30.1674765681704;
 Thu, 26 Jan 2023 12:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20230125213251.2013791-1-zwisler@google.com> <87a6259mll.fsf@meer.lwn.net>
 <20230126153438.5e98da15@gandalf.local.home>
In-Reply-To: <20230126153438.5e98da15@gandalf.local.home>
From:   Ross Zwisler <zwisler@google.com>
Date:   Thu, 26 Jan 2023 13:41:05 -0700
Message-ID: <CAGRrVHwykqUBREOAVB0tYQiVT5VsHKpda4POtR_k6j3oxDUTSQ@mail.gmail.com>
Subject: Re: [PATCH] docs: ftrace: always use canonical ftrace path
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 1:34 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 26 Jan 2023 11:28:38 -0700
> Jonathan Corbet <corbet@lwn.net> wrote:
>
> > Ross Zwisler <zwisler@chromium.org> writes:
> >
> > > The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> > >
> > > But, from Documentation/trace/ftrace.rst:
> > >
> > >   Before 4.1, all ftrace tracing control files were within the debugfs
> > >   file system, which is typically located at /sys/kernel/debug/tracing.
> > >   For backward compatibility, when mounting the debugfs file system,
> > >   the tracefs file system will be automatically mounted at:
> > >
> > >   /sys/kernel/debug/tracing
> > >
> > > Many parts of Documentation still reference this older debugfs path, so
> > > let's update them to avoid confusion.
> > >
> > > Signed-off-by: Ross Zwisler <zwisler@google.com>
> >
> > So this seems like a good cleanup to me.  Unless somebody objects, I'll
> > apply it to the docs tree in the near future.
> >
>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Doing a quick 'git grep 'debug/tracing' there's a lot more that needs to be
> cleaned up, but that's outside the Documentation directory.
>
> Ross, care to follow through with those? ;-)

Yep, I'll send out patches to take care of the rest, just wanted to
send this out since I had it ready.
I'm planning on dividing up the patches by subsystem/maintainer, but
am open to suggestions if that sounds incorrect.

> Thanks Jon and Ross,
>
> -- Steve
