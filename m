Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205C6748568
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGENvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjGENvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:51:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF310F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:51:35 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635decc135eso3427406d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1688565094; x=1691157094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5apOaiMx4aHIZYDygISPCljy09Kxleg9B14ZIbs1TQc=;
        b=DFv69jAa169oZfdZVANCwMoJwKhBzuhXr9LtAQ+/ducYplJpEivdLI15TUVCJJIgCk
         4gMpt5mxVar7H9MIK9MfcWga5voAtXzzxQytb9FoGJcm1GqS1nCRU0x711NJCsFOajbT
         BgiE0hj9Mv1KRRll8RabNAmDNpRdrV4O+Sbzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688565094; x=1691157094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5apOaiMx4aHIZYDygISPCljy09Kxleg9B14ZIbs1TQc=;
        b=S/QJDDrkGzCanUK6EmFPnVubm7dCHomuS9K7nNRhfysMEGf0qEqk1t7CIlau52Ak84
         EWcEbHjEii4Nu2lIwu0Ju+CJB961ZlKaNU/EB/NOJF3FwCCA3PMGZfMka/2jY9oq81r7
         iIhsHVpzOiV9PDEfX6ZbQME76OP/t1ZEcyDqL7yPsh6lnW2j1CqrH87dLdOpYJA5nM/a
         8HvIJROo0K6CfVBl+4iggrTuxZTBSU0zLds3ZilWVj013wH5vO62hDse73vv7xU4jk5w
         UV7m5LNWyZYbr2LvJ/OwfqhEpjaDo1/XubTTEQedPBz6mHfQ+++re6TxSr3kWBuHO6C5
         e9Eg==
X-Gm-Message-State: ABy/qLah3EPdV1Nq4IYa0rhshnmrceFypuD46qD4Uwf/cDnlAfBBN/qE
        NBTWp1OUhdovyt0r4pQ79FZ49Q==
X-Google-Smtp-Source: APBJJlFrKdsk6Z8ftHE3yyBe2+9DSPUpRZhSBsBN9RBGN3Cz04IANS28RNL0R7F8wuJWvLbLm9a9Ug==
X-Received: by 2002:a0c:f4c8:0:b0:616:5755:ca5d with SMTP id o8-20020a0cf4c8000000b006165755ca5dmr2612844qvm.4.1688565094514;
        Wed, 05 Jul 2023 06:51:34 -0700 (PDT)
Received: from nitro.local ([209.226.106.132])
        by smtp.gmail.com with ESMTPSA id eb9-20020ad44e49000000b006263c531f61sm13526728qvb.24.2023.07.05.06.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:51:33 -0700 (PDT)
Date:   Wed, 5 Jul 2023 09:51:22 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Overly aggressive .gitignore file?
Message-ID: <20230705-91-oregon-tribune-77e07e@meerkat>
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <20230704211509.GA21834@1wt.eu>
 <CAHk-=wjH4O6v_EwVB=t_6Haky2jOiejHbCkCTvgNQWo1ghy8-w@mail.gmail.com>
 <20230704213415.GA21872@1wt.eu>
 <CAHk-=wjPEjrB7eCukREhWu-0qfjbFD-K8sk1TYYRgeHzYr1tuQ@mail.gmail.com>
 <20230704215600.GA22271@1wt.eu>
 <CAHk-=whMytacPBHfKKi8GYdgfadNy5LA-1TDHrTtz22eJr2B1Q@mail.gmail.com>
 <20230704222758.GB22271@1wt.eu>
 <20230705004129.GI1178919@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230705004129.GI1178919@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 08:41:29PM -0400, Theodore Ts'o wrote:
> For whatever it's worth, I always run "b4 am -o /tmp/m ...", so all of
> the .mbox files end up in /tmp/m.  Similarly, I'll always run "git ty
> -o /tmp/e ..." so all of the thanks file end up in /tmp/e.  And that
> way I inspect the b4 output files before I run "git am -s /tmp/m/..."
> or "git send-mail /tmp/e/...".

I *have* considered auto-cleanup of stale .mbx/.cover files using the same
logic we use with "b4 ty" to recognize when a series has been already applied.
I can turn this on as an experimental feature in the current master and see if
this is at all useful.

-K
