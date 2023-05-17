Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE3705EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjEQEwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjEQEwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:52:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357630E6;
        Tue, 16 May 2023 21:52:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so558824a12.1;
        Tue, 16 May 2023 21:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684299122; x=1686891122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b36/I3Nvxt3FNBxeDqCvzRRZQkiU3g4TwUhxkdFSQg=;
        b=R1BrJpqiQkawOmNZ2eUhhs5aiZ5nUlvo15AH9j2qbT9j8Jji3gbHGSKO/XVeWn0WI7
         7A/j/ews7kjTxWKosbUvwcvh95heAYYhRAE/PsY/zkY3qZ1mz0YwED5uYSrTXM4UZWQa
         kqH1uBT7lySyT8wypk0ybYaVhRJw6ZsfxPx+jokTmGksad1wI6ldET5cs0AvdqrD/fgS
         OJ4+ODcRq0SEFlJ1mq/LMvStmBnHoGVDOa3+POzUQ/mLynmYYbELVGv5svV8Op/cyVLo
         vyW7fWuxUJl3/DKfWJ6slDK8by11R9Gk7LJUpHVKrjlD3Uelp4XV4PUOimEYgP2D6Yvf
         IPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684299122; x=1686891122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b36/I3Nvxt3FNBxeDqCvzRRZQkiU3g4TwUhxkdFSQg=;
        b=jSrskFz3P925NoluVO8L8sU8GFTPObUbE5nNx5GvlmNrCGUCyChAD2IrjOP9KR86dP
         y0bCkbhZm37bKxM9ex5721F8EZpcuSevlg4r6rS/ufiyWOQnKSCRD6i/XyDmc8kr1FrX
         1X/wI2qGBv4o3jNAbRs4Wjarynp7D+bpqqlA8WtjT+cWsYUfQbUpZaMefufcEaNBV5vu
         0qZOKXujTdVMnCtRAgVNbbS3wvJtr7RZLZ3o9brm0Hnr+9CBN2Hk9AJOseKuYE7BWEQa
         SUNonFM5lgcxqSNa7LNO/R2/ySXWWDzlK2vI/hUdvpge8PNS6NaRxD0HBg35xuxOQo14
         fz7Q==
X-Gm-Message-State: AC+VfDyuidGbQ/e2Od9Hr4vpN6E9+UqT8X0CXaDwtZpHS7ahaho85wFL
        hO6ukwVnPcqWSwCj6jcKiQFS3GsVLpo/wgw9nTU=
X-Google-Smtp-Source: ACHHUZ7D+qbISKJO49ArIXkB3GqjJizoUnpsT6EzQe2Ml7LGi01etblSWEuPusR0eE7oY9uRaDlKRHwjCknPU//Wadg=
X-Received: by 2002:aa7:d94b:0:b0:506:bce0:48d6 with SMTP id
 l11-20020aa7d94b000000b00506bce048d6mr1186236eds.5.1684299121564; Tue, 16 May
 2023 21:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230516071830.8190-1-zegao@tencent.com> <20230516071830.8190-3-zegao@tencent.com>
 <20230516091820.GB2587705@hirez.programming.kicks-ass.net>
 <CAD8CoPDFp2_+D6nykj6mu_Pr57iN+8jO-kgA_FRrcxD8C7YU+Q@mail.gmail.com>
 <20230517010311.f46db3f78b11cf9d92193527@kernel.org> <CAD8CoPAw_nKsm4vUJ_=aSwzLc5zo8D5pY6A7-grXENxpMYz9og@mail.gmail.com>
 <20230517115432.94a65364e53cbd5b40c54e82@kernel.org> <CAD8CoPC0BXB2ER_Oaixm5XgMk8TTqKVVF7Po0t4gBPOLhw_xwQ@mail.gmail.com>
 <20230516232545.4f6c7805@rorschach.local.home>
In-Reply-To: <20230516232545.4f6c7805@rorschach.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Wed, 17 May 2023 12:51:50 +0800
Message-ID: <CAD8CoPBcP_T_-pR=szL7Vk0vtK3tzTsM6pPmqFcddcTa_ajrNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Yonghong Song <yhs@fb.com>, Ze Gao <zegao@tencent.com>,
        Steven Rostedt <rostedt@goodmis.org>
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

Hi Jiri,
This is the latest version against 6.4-rc1, and you can apply without troub=
le.
     https://lore.kernel.org/linux-trace-kernel/20230517034510.15639-1-zega=
o@tencent.com/T/#t

Regards,
Ze

On Wed, May 17, 2023 at 11:25=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 17 May 2023 11:10:21 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Got it! :)
> >
> > I will improve the commit message and send v3 ASAP.
> >
> > BTW, which tree should I rebase those patches onto? Is that the
> > for-next branch of
> > git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git. I saw
> > Jiri had troubles
> > applying those since these works are based on v6.4.0.
> >
>
> You can submit against 6.4-rc1. We haven't updated the for-next branch
> yet. Which will be rebased off of one of the 6.4 rc's.
>
> -- Steve
