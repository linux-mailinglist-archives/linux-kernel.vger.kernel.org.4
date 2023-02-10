Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414E692320
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBJQSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjBJQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:18:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D00B6A7D;
        Fri, 10 Feb 2023 08:18:39 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id r9-20020a17090a2e8900b00233ba727724so680512pjd.1;
        Fri, 10 Feb 2023 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxXdZQxEy9ORSki1sFbClnXS6XD9R5tAV6m7018Aoxg=;
        b=RLLvPVwEe37bC3gIxP2Bv5EbvbxNVa3e9DSJanGQhPNO0KGbiSFyKCQ7dU+E9Ud6dW
         lIs4g+WD8OhzR0WDnPRqrT540emzHx41b2q3WvX/nfsB/EHmW7PhLz4ywQhN4EfAYRuV
         f42OEecWXAMLbOCvgXanc9orcfCRZTm91zG/sGRAIiVbXozInbRILnOr1fnnYLVwW/ES
         rzWtdnF78Chord9FKMSKBmRKsatVzaLls5eh/0nKU1maiIzrpV8MpYD0FD15T5HuReDV
         dGuM3kcGExCcdKn+JWv33YQA+SFbhAioyZUitqsq2h/DiWcj8Y78JDbHXx7Al2bLNfW8
         MpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxXdZQxEy9ORSki1sFbClnXS6XD9R5tAV6m7018Aoxg=;
        b=4GBloVG1XGcY2vWK8dIj9OJXy/mymhLKYDVt4pBxc/NQFoEv1xOH7duYYtyqlQmfuO
         GaARoAZ7zs037tWJ3Z4BOflUNRAIAQZhIT6bmTbhE7lBQFxBmWj37lOZ2Bm8bh0wkSVE
         CsbCCt0BL3K6hdOwohRo/ZFlPZ4gvBxfYEwwYZfuVh0vEWhtDjV57el6ZcE43MaDz9dQ
         RFoKxqP6o3iea7In+p39YkvytLxcCmRABfPHR2ljjKaA45R2lvendVlISACEOHmu8Ofj
         MHnbWVMqzlIvKdY4KzX1TIqsvWN9xsxygi3dsZP03yAhmSWwE+g4LpMU5h3C5ziJDN8w
         mRqw==
X-Gm-Message-State: AO0yUKVwxsF2Evy9Ufuvm4BdNF7TInL8Lj2yfpYgo/NDBXirk4FXVG7C
        NY/wqIOYh/EcXBbQhDh8xt0=
X-Google-Smtp-Source: AK7set8aF8P+ZlNIMzRzl1T1H/DSMSa4lsmTbGM6NWsjEMzuyTqi2Jrn0/eW0THES6OU8oRuG4QGGQ==
X-Received: by 2002:a17:903:2303:b0:195:f06f:84fc with SMTP id d3-20020a170903230300b00195f06f84fcmr17146571plh.40.1676045918601;
        Fri, 10 Feb 2023 08:18:38 -0800 (PST)
Received: from localhost ([124.248.219.206])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902dc8300b00198fe021f93sm2335425pld.77.2023.02.10.08.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Feb 2023 08:18:38 -0800 (PST)
Date:   Fri, 10 Feb 2023 08:18:27 -0800
From:   Dan Li <ashimida.1990@gmail.com>
To:     Hongtao Liu <crazylht@gmail.com>
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
Subject: Re: [RFC/RFT 0/3] Add compiler support for Control Flow Integrity
Message-ID: <20230210161827.ze2dtrfugydlbw2p@ubuntu>
References: <20221219055431.22596-1-ashimida.1990@gmail.com>
 <CAMZc-bzmACcpSePKxuuA=ug2+yik+Zo3-mfqr2OyZ-n_nT=OnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZc-bzmACcpSePKxuuA=ug2+yik+Zo3-mfqr2OyZ-n_nT=OnQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09, Hongtao Liu wrote:
> On Mon, Dec 19, 2022 at 3:59 PM Dan Li via Gcc-patches
> <gcc-patches@gcc.gnu.org> wrote:
> >
> > This series of patches is mainly used to support the control flow
> > integrity protection of the linux kernel [1], which is similar to
> > -fsanitize=kcfi in clang 16.0 [2,3].
> >
> > I hope that this feature will also support user-mode CFI in the
> > future (at least for developers who can recompile the runtime),
> > so I use -fsanitize=cfi as a compilation option here.
> >
> > Any suggestion please let me know :).
> Do you have this series as a branch somewhere that we could also try for x86?

Hi Hongtao,

I haven't tried this feature on the x86 platform, if possible, I will try it in
the next version.

Thanks,
Dan.

> --
> BR,
> Hongtao
