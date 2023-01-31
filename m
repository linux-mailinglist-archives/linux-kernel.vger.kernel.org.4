Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36CF683856
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjAaVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjAaVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:08:34 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B924EF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:08:32 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e15so19802281ybn.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bDq7d/n4hRdxw/uuHY1zsy7WUcXmIawJLMPKVEj5Oqk=;
        b=U/HrMYPECFRkq9PkPWwApR3OeNslyly/bOGovMVkhgn5x/4H3rBa+5Q1e8lajkmDFg
         hdXiowPRj5EJYmQVq9v0e3GI9JRDz5DDKyxwYMJnQQUDMLSyXobCMDk8u5db/owOJJ5L
         GAAyUx478W7Dj8GmbfulidXOwwUIp82QUFfTe8W4/EE7jRoOVHESeFqMZbWCROEzxlFp
         XbZxSml7D6XvIfI3uiwDZBOWarlwFsYgBHo7/hJ9rwt2ieOpQlFlDGL8xtXyb8xPzMAL
         BNBZNshG24V4cs4Sz8MVzFEx3BFPEwCUj7E3bhs6Ek5WwtzRyXCLhX5E2tjmXkI8dGzU
         Dzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDq7d/n4hRdxw/uuHY1zsy7WUcXmIawJLMPKVEj5Oqk=;
        b=NzqE1TI9XiwWzyieQOCVkx1VF5qjKAntm3Qcaw/7w9RpfqF7jkZsKZ1T3rmNSqWWDP
         VVtRbzOVJKMVoznRpuMuqFZX5qHq2qiSeMLRrbAMIbNkFqmtZccS4yZd6b4rnayBe/gW
         JmLaomQ2S+Tk0RZJ97NQEzXKaFyINYEkPoKTnxuBZ/hr4sQ1iPlJ36i/WBUoMkggi44+
         G177IvmuNpOZhdNgSysRyqlNOv6DniHqkGnj840SC/I3VXmffftVQQjoZq3Ke3fbklKD
         cN5IhCxOcu+w+Kl+q/9qP/zUAVJ9FeTcN/uFCMD/Ox1cHJQeLMlSm8xMDXqTqbEjXLRp
         emtw==
X-Gm-Message-State: AO0yUKX4nEZyffcikv5j/Z2OhT2QOHTA8+by/PCBUPLWXx2W77symKPh
        0ZCbGYIYXWg2UKN1qLrCgilDyyv9CrYywmHCv14duw==
X-Google-Smtp-Source: AK7set8TN+vhTCk6n+wEoQB3UO9IaaO8ylUfxNJA77IxdpDEU7vhpknIio3f4DVrz3qNcZAJLnR7+kYgR98f6snoq4A=
X-Received: by 2002:a25:a088:0:b0:80b:6fd3:84d3 with SMTP id
 y8-20020a25a088000000b0080b6fd384d3mr46494ybh.316.1675199311005; Tue, 31 Jan
 2023 13:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com> <20230126193752.297968-5-surenb@google.com>
 <Y9jSFFeHYZE1/yFg@hyeyoo> <CAJuCfpEzaVkgQt=C-33jAh1vLVJAjoyM8X5AD9CzyDUJnPDCkw@mail.gmail.com>
 <20230131125355.f07f42af56b23bfa28b2a58c@linux-foundation.org>
In-Reply-To: <20230131125355.f07f42af56b23bfa28b2a58c@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 31 Jan 2023 13:08:19 -0800
Message-ID: <CAJuCfpHmtkzrKx45SQQ0gXLoybtgHxHmTP5J4L74ChTqSfFA-g@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
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

On Tue, Jan 31, 2023 at 12:54 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 31 Jan 2023 10:54:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > > > -             vma->vm_flags &= ~VM_MAYWRITE;
> > > > +             vm_flags_clear(vma, VM_MAYSHARE);
> > > >       }
> > >
> > > I think it should be:
> > >         s/VM_MAYSHARE/VM_MAYWRITE/
> >
>
> I added the fixup.  Much better than resending a seven patch series for a
> single line change.  Unless you have substantial other changes pending.

Thanks! That sounds reasonable.

I'll also need to introduce vm_flags_reset_once() to use in
replacement of WRITE_ONCE(vma->vm_flags, newflags) case. Should I send
a separate short patch for that?

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
