Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9697693BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 02:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjBMBj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 20:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMBjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 20:39:24 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD30BDCA;
        Sun, 12 Feb 2023 17:39:23 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id s203so7613367ybc.11;
        Sun, 12 Feb 2023 17:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPZk2zCrVPmYTZkYOvzJCIeVJJCKq6+j1pxvOWvVxbg=;
        b=VPlOIKihz/PKsRVt1WTcr9X8Q80y/qgwwtjU8fp3nzIyPvCC5wF53UYHWMZ6abxjzK
         q0THmi691IsWpFq1NmC/dKkRbWdRuq6iAO9DgiRVHw3ff1GsfQ/VrBpQIu4cz4TWuJ2V
         H+/AydP0Iix0Z+juzKMkglbuQaO+WqqqVD35apHaLqxUDzQ+07Mi4EaRc3MMhILDsf7R
         w8am13ZBpwzD2CQjl3kRTynt+Ou2KPXQK8SW8VT155UYIQCFmJC5u6A968St/fR3BIOW
         0jmGGaYnwEb0zt7KTfrMaSYIgqbr6PbwQoygxi794V2XMmqkuoBQHSBPPpaw2pT2Lb+H
         IfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPZk2zCrVPmYTZkYOvzJCIeVJJCKq6+j1pxvOWvVxbg=;
        b=sNOkJJQLSiy/7HYnHlTYFnj3tumiXP6E24JL+JCBFiSyCiahOvejHH5jFHfaYDBMna
         T1lC7d+hxvyhZD7GJAhyXEPIQklqrqDTsTZ4PYTwACOUujBzWID4U7OQnKWbCGfDqmJH
         xkzth3L812tInRdwrbt1NcdsilLeJW2DStCUoqc1mi1Ja/VkZDzY1qZY3JeCh63bf9BW
         4JVi3Tk2HV3zAau+/PnAVA3GtmP194XnwvgNWdKRLZyl2+Y7IcC7I8b9abeSK8Ryg3j8
         /z/wvbU5u1QhsgErGe+Nx/3KogSV1Wb9UrttvRkqjG0IjKkAabOo4hD1bVpFzGGBQSoq
         f2KA==
X-Gm-Message-State: AO0yUKWy0wKQ4DnKqfErpbztB1jNC7KXnxhJ42nMb0HS/IfFcQ0mQPNt
        LF/UQLx54kXt60U7pSH59lhPKEcCKeuk9c1ZM2E=
X-Google-Smtp-Source: AK7set/5Pze7wlBiSVJR3P/PqfM16NzhwqaLs1O2wEOMdzwBOeILv2xyKF5pvm8VZIHnHhlTj8Kd50/G2LSrnEny+J8=
X-Received: by 2002:a25:9d0a:0:b0:8d7:814e:4e53 with SMTP id
 i10-20020a259d0a000000b008d7814e4e53mr1077946ybp.564.1676252363158; Sun, 12
 Feb 2023 17:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
 <CAMZc-bzmACcpSePKxuuA=ug2+yik+Zo3-mfqr2OyZ-n_nT=OnQ@mail.gmail.com> <20230210161827.ze2dtrfugydlbw2p@ubuntu>
In-Reply-To: <20230210161827.ze2dtrfugydlbw2p@ubuntu>
From:   Hongtao Liu <crazylht@gmail.com>
Date:   Mon, 13 Feb 2023 09:39:12 +0800
Message-ID: <CAMZc-byL=O1cTPo7SKXJZ8K3nNskXwa3T+RXx-_6-dEQke-HQw@mail.gmail.com>
Subject: Re: [RFC/RFT 0/3] Add compiler support for Control Flow Integrity
To:     Dan Li <ashimida.1990@gmail.com>
Cc:     gcc-patches@gcc.gnu.org,
        Richard Sandiford <richard.sandiford@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 12:18 AM Dan Li <ashimida.1990@gmail.com> wrote:
>
> On 02/09, Hongtao Liu wrote:
> > On Mon, Dec 19, 2022 at 3:59 PM Dan Li via Gcc-patches
> > <gcc-patches@gcc.gnu.org> wrote:
> > >
> > > This series of patches is mainly used to support the control flow
> > > integrity protection of the linux kernel [1], which is similar to
> > > -fsanitize=kcfi in clang 16.0 [2,3].
> > >
> > > I hope that this feature will also support user-mode CFI in the
> > > future (at least for developers who can recompile the runtime),
> > > so I use -fsanitize=cfi as a compilation option here.
> > >
> > > Any suggestion please let me know :).
> > Do you have this series as a branch somewhere that we could also try for x86?
>
> Hi Hongtao,
>
> I haven't tried this feature on the x86 platform, if possible, I will try it in
> the next version.
Thanks.
>
> Thanks,
> Dan.
>
> > --
> > BR,
> > Hongtao



--
BR,
Hongtao
