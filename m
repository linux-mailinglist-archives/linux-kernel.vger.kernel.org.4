Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D7269501B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBMS7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjBMS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:59:10 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19B88A57
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:58:43 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id x4so15598109ybp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sC5Aqs8Zx9KnYE6mc2FVfCuvY0HxXOcL8kz2uAMityk=;
        b=V46MGcuWl3FG8fgqKMwn7kH1WW09dtFEK1b5alAAvvIeT2dDpmVrGV3IcA7E+xaaUq
         4+FspjDYoTnE7NZmL6aEZRGu/RRjEjNrr7Gmv7AffjgRJgJ+22YWQ8z7n4nGvq8Gj5fl
         wn8TGX17LY6POKXC1aZ1GEuH057SP08eUZaOt/+mIIqej4M7ScfATlPi/N5iyw+KWt98
         dKo7vF6SVbpaxyqnDbnCgATD3DbL0kmwWee5i/JQNg7Birti9h9z47af4VH31h5vKn23
         W1x6mfF3mUu4gnAqQNdg2gstCLiLDwduhOMSPfYeddvqsXzrsqdKKRjodCRnG2t0KKBv
         SpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sC5Aqs8Zx9KnYE6mc2FVfCuvY0HxXOcL8kz2uAMityk=;
        b=XfAhmA34AubYqunOl8OSqA08TmcPKbNnWQ1UMUMj7ZwGJweQ36pZF4a9c0w2XyMzou
         urj9159qrxw/4semqovmtFqd+H9QeTu9quesrVpgBAfWyob1WxWW982lvdckve/WseGN
         zpgIAAPSKQJ1csMhC6XwOChQKhS5pjMje2HOHqpEqJZlwV+TDvvgWHXKw/0bV/rfytK/
         uy+efYDYc8DAqukm26rJydp+eOSX4hrLcC8PH9EFdt0t8aQQ40zYXlYqGXxkqdWgjJhf
         cc9LCCdrQzz/mQJWDTw5qQPhmWmqDBTb+LzSggOMDsUZoETTVEbKABO4R424pTFSuXOB
         dV1Q==
X-Gm-Message-State: AO0yUKV7KaPZQrZUf18+5MeZ3vZzO7biyOQ524hIK4o8SM0J9E7Mddou
        CpT6xBeQHWKs3N/KPWvxbg6F9eJfc8I3e90uUKWL5g==
X-Google-Smtp-Source: AK7set92u7HjWSwWlNONIaamzQpCYwD4/vrcW9EncCbfcJza6KzxR1ziVRIWxtymCs+H2aP/nh+hhePZnAwN8YIHdco=
X-Received: by 2002:a25:1f89:0:b0:80b:5398:3aeb with SMTP id
 f131-20020a251f89000000b0080b53983aebmr2658539ybf.300.1676314713084; Mon, 13
 Feb 2023 10:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20230110185823.1856951-1-mizhang@google.com> <20230110185823.1856951-2-mizhang@google.com>
 <Y+L3HlFDRy+UiUSU@google.com>
In-Reply-To: <Y+L3HlFDRy+UiUSU@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 13 Feb 2023 10:57:56 -0800
Message-ID: <CAL715WL9V8d-jvxkSALKQsMTgwDoyG-zE0g2tKd7FxihUhVGTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: selftests: x86: Fix an error in comment of amx_test
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 5:13 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Jan 10, 2023, Mingwei Zhang wrote:
> > After the execution of __tilerelease(), AMX component will be in INIT
> > state. Therefore, execution of xsavec saving the AMX state into memory will
>
> s/xsavec/XSAVEC
>
> > cause the XSTATE_BV[18] cleared in xheader. However, the XCOMP_BV[18] will
> > remain set. Fix the error in comment.
> >
> > Cc: Jim Mattson <jmattson@google.com>
> > Cc: Venkatesh Srinivas <venkateshs@google.com>
> > Cc: Aaron Lewis <aaronlewis@google.com>
> >
>
> No need for a blank line.

ack.
>
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > ---
> >  tools/testing/selftests/kvm/x86_64/amx_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
> > index bd72c6eb3b67..16533949a189 100644
> > --- a/tools/testing/selftests/kvm/x86_64/amx_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
> > @@ -204,7 +204,7 @@ static void __attribute__((__flatten__)) guest_code(struct tile_config *amx_cfg,
> >       GUEST_SYNC(4);
> >       __tilerelease();
> >       GUEST_SYNC(5);
> > -     /* bit 18 not in the XCOMP_BV after xsavec() */
> > +     /* bit 18 not in the XSTATE_BV after xsavec() */
>
> I would rather overhaul the entire comment, e.g.
>
>         /* Verify XTILEDATA is not set in XSTATE_BV after XSAVEC */
>
> I had to look at the definition of XFEATURE_XTILEDATA to verify that yes, indeed,
> bit 18 is XTILEDATA.
>
> As for xsavec() vs. XSAVE, IIUC the clearing of XCOMP_BV[18] is a side effect of
> XSAVEC the instruction, not something extra done by xsavec() the function.

I see, that's why you asked me to use capital words.
>
> >       set_xstatebv(xsave_data, XFEATURE_MASK_XTILEDATA);
> >       __xsavec(xsave_data, XFEATURE_MASK_XTILEDATA);
> >       GUEST_ASSERT((get_xstatebv(xsave_data) & XFEATURE_MASK_XTILEDATA) == 0);
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
