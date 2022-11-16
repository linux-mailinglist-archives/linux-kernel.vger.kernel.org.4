Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96A62C95D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiKPUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:01:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F265E3EF;
        Wed, 16 Nov 2022 12:01:13 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p8so31286824lfu.11;
        Wed, 16 Nov 2022 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfGLZdKXBdAk8RMv1wRt7dXoc+6iSCMoIXic69seXLY=;
        b=ojh5S7Te/VBk5dxmXCFxXPj7xDKC6G/i6aVDc9qVLAcB829KAcjehaTq43EGbhexsA
         KXWc3+WTUOAWlb6H9O7+Ujt/mL/DazPQWvV8wmcCdWKL7nwKHKcL0S4vRMJVaJjVBApr
         6UScZwZIBUtqqC9gwV9kW3Eg1NNIElH1caTFs3IyGbiaIFyKFjHP/+skXJjfKTn9Z/xd
         EOuxi3ew/Sx1TiQkm9xZ4CLAN7l92DfR1Yn/i2tTsfUT3iANr40skUAlW9g+lejTEg08
         WeMt6LCDGZhm0wP7FQ5QTDn+shhnTI5r7DR4Pbb3YeqnATQeph36aGDxgIQy2tuGSr2k
         P+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfGLZdKXBdAk8RMv1wRt7dXoc+6iSCMoIXic69seXLY=;
        b=oE2RdwBybbuOB1UL4Ll8K1j/ov1mzvD6ETvovRW1MUTti4Xa8ctbfVb+VZxm6MlI5b
         dNdme0M9ZxauKGS1qCGE/buRmti4+QvJb0uacHbvF/JlTrIKu2NitzB8/BY6yCe0NWeJ
         MgubLYzY1CaYe16ZxEotlsl+mxl5HHjS5fmMRhhcdRR804xEAl/nCzFrt0o2I+XwihKQ
         OI81HP9uHY9n2ugpCUFl4z1pqGhhehz3bLrqx4bpsG8LlA9baI1oaQtiaVi4JG0BGKCe
         1iCaWMqDnNiOLJR+SVnI5W/gzUOB/a+NTxR2ZW7Il5xB7bzkhSQdAA1iybnQzqglHp4I
         HhWg==
X-Gm-Message-State: ANoB5pn/aGIIGEkb/fqf8Ki1Glmyr5QGg+aDjmSx5+TjyrS6tFEpMnnq
        mpeZQLvNNyUjwKURhPdV3zRzNgsONfTxgWujamE=
X-Google-Smtp-Source: AA0mqf78EvhFvcuMKT35lCRgvg2mKlqiET77zOhkC03NxE9HCmEQb/TA55qVIxjjopPNreksJErXBTSSVslSeqHJXj4=
X-Received: by 2002:a05:6512:759:b0:4b0:65c6:11fc with SMTP id
 c25-20020a056512075900b004b065c611fcmr8937919lfs.193.1668628871560; Wed, 16
 Nov 2022 12:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20221115161627.4169428-1-kristen@linux.intel.com>
 <CAPj211ugzBFJHgDNtSgR2zB7ZcGa_EqOAQGhFSu938718u+yMQ@mail.gmail.com>
 <87cz9nqff2.ffs@tglx> <CAPj211shRbJQcnhEpjs461nEMQw2x53f+2G46CXWJg6_Rc-x-g@mail.gmail.com>
 <Y3UcLudVzuS55Bp5@iweiny-mobl>
In-Reply-To: <Y3UcLudVzuS55Bp5@iweiny-mobl>
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Date:   Wed, 16 Nov 2022 21:00:55 +0100
Message-ID: <CAPj211tkReuuqyi8w2dFvrz3MFgmVFgnheDJbJ25_gCBvZX7VA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=C3=AC 16 novembre 2022 18:21:50 CET Ira Weiny wrote:
> On Wed, Nov 16, 2022 at 03:01:56PM +0100, Fabio M. De Francesco wrote:
> > On mercoled=C3=AC 16 novembre 2022 12:58:41 CET Thomas Gleixner wrote:
> > > On Wed, Nov 16 2022 at 11:16, Fabio M. De Francesco wrote:
> > > > On marted=C3=AC 15 novembre 2022 17:16:26 CET Kristen Carlson Accar=
di
wrote:
> > > >> The use of kmap_atomic() in the SGX code was not an explicit desig=
n
> > > >> choice to disable page faults or preemption, and there is no
compelling
> > > >> design reason to using kmap_atomic() vs. kmap_local_page().
> > > >
> > > > This is at the core of the reasons why you are converting, that is =
to
> >
> > avoid
> >
> > > > the potential overhead (in 32 bit architectures) of switching in
atomic
> > > > context where it is not required.
> > >
> > > No. The point is that kmap_atomic() is an historical artifact of 32bi=
t
> > > HIGHMEM support.
> >
> > I just saw that the last part of my email is missing. In fact it's enou=
gh
> > clear that what I was saying was still incomplete and that no signature
was
> > visible.
> >
> > I meant that, before we had kmap_local_page(), the choice was between
kmap()
> > and kmap_atomic().
> >
> > Despite I suppose that nobody should rely on those kmap_atomic() side
> > effects, I have been observing that a large part of the users of the
> > Highmem API used to call kmap_atomic() for its implicit
> > pagefault_disable()
> > and preempt_disable() side effects.
>
> Fabio I think you missed the point here.  Just because we have found _som=
e_
> places where the side effect was required does not mean that "a large par=
t
> of the users..." do.

You are right. Numbers don't support that "a large part of the users..." bu=
t
that it happened and will happen again. Let's delete "large". However this =
is
not the point. The real point is below...

> While I value your review of these conversions I think Kristen did her ho=
me
> work here.

I agree with you: she did her homework and the patch is good.

I don't know why I have not been able to convey that I appreciated her
homework. I especially appreciated that she cared of checking that the
code between mappings / un-mappings does not rely on any of the disabling s=
ide
effects of kmap_atomic so she could simply replace it with kmap_local_page(=
).

I'm not sure why the message that this patch is good didn't pass. I suspect
that I stressed too much what I was considering minor inaccuracies.

In the while I missed to talk about what matters for real, i.e. that the
changes are good and that they will work properly.

> She checked with Jarkko (the original author of the code) and
> verified that the side effects are not necessary here.  That is all that =
needs
> to be mentioned in the commit message.

I should avoid that kind of excessive focus on less relevant things.
Instead the overall end product is what matters the most.

[snip]

> > This is the core: Kristen knows that the code between mapping / unmappi=
ng
> > does not need preemption and page faults disabling. Therefore
> > kmap_local_page() will work with no need to run in atomic. We all agree=
 to
> > the necessity to convert but sometimes we are not sure about how to
> > convert.
>
> But we are sure about this conversion.
>

Yes we are. Did you note that I wrote it above?

I supposed that that was enough to see that I'm aware that Kristen knows wh=
at
she did and that she did it correctly. My objections were only about
minor details
in the commit message. I didn't ask for another version, but I admit
that several
parts of my message were ambiguous.

[snip]

> > Ira confirmed that system protection keys aren't affected.
>
> I'm not sure what you mean here.  This work started because of system
> protection keys.  But since they have yet to have a good use case they ar=
e
not
> yet upstream.  Therefore some _specific_ conversions have used
page_address()
> directly because those drivers know _exactly_ where and how the pages wer=
e
> mapped.  That is a very specific use case which is different from what
Thomas
> is talking about.  General code which gets a page may still need to have
> additional operations performed prior to using a kernel map.

I was referring to an email from you to Jonathan Corbet.[1]
Did I misunderstand it?

> > I'm not sure about
> > what you are referring to when talking about "other things".
>
> There are a number of other ideas where memory may not be in the direct m=
ap.

OK, I'm not yet aware of them.

[snip]

> I think the issue is you are trying to get way too much detail for patche=
s
> which don't require it.  If you review a patch like this and you find
> kmap_atomic() was being used for the side effects note that and NAK the
patch.
> If you feel there is some evidence but you are unsure a quick email askin=
g
is
> fine.  But if there is no evidence the patch is fine lets tag it with a
> review and move on.
>
> In this case people are getting frustrated with the 'bikesheding'[1].  We
are
> never going to complete all these conversions if we spend this much time =
on
> the easy ones.
>
> Ira
>
> [1] https://en.wiktionary.org/wiki/bikeshedding
>

You are right. I'm sorry especially because we recently talked about
this topic.
But I fell again into the same trap :-(

Thanks,

Fabio

[1] https://lore.kernel.org/lkml/Ytny132kWjXvu1Ql@iweiny-desk3/
