Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985086CA07F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjC0Jvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjC0Jvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:51:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68701272C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:51:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k2so7872231pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679910700;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwVHUErF6NBSyCtvSa/omuwEN4SL1/DY9fX2CVuT0Nw=;
        b=oDfAm4pEY67NP4M9cZcT/HBEDRoggyD4pTTB3OdeogAR0MYqUItOgSVqA4qry+p7Y2
         Maw3WkuU29O27qg1MA8hjBP4FLx5rqIuKahSFa2cSYCFAlDskSGh30XQx+2NjzY26Ejz
         +q3cQB0tuifvO0meeaa6Pp+r2YiQRUKKwcfOnJV0Zm0hTi53g+CvAPhapNv92uoAn1ZS
         P1mezE7aYTmlvbYW6CoR92vozjaVvVL/bCDN0v78zCBRYg9x1KChJtKVSb6XZJnqp/Rv
         syVZ7ddN/UAw9ZjNExJWsphfo/FvBZB7nv8ZITfvW5wNuqbM7A8msW/94ZIkVb15xzgb
         4EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679910700;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwVHUErF6NBSyCtvSa/omuwEN4SL1/DY9fX2CVuT0Nw=;
        b=UObzbNpsSKXpaaZ4zDFC9jNZBxrUYYTlG8esZdW4DhUWYt584/UoWMR2aOLsu52BkD
         EC0JZULib9/nJ1IjHEVUBgF9RKIMFWPwGZZhmKoie4ExyG0IC8rt86mjHY4SNPrEFZ0I
         nRm0BmrXMAidFbkFlrn1GYYFHJUusxF5ZbM3t6e2aUemLTb0NEWhvnZfK600LI/f2Wq+
         kOLe6orujEaslwkVzV1ebDkLu0BG7xqYck34wfpef2KMQorH99dC26KUPQwhzCwGxumm
         FXKw1shyTl8wAG4WZLH1hFhsOLK3wlusout8FIyT52wFyHEvfK1vC2d8Mu+KN51fsAzt
         5mAw==
X-Gm-Message-State: AAQBX9fslI45yZ552UiRqm7qJYK0+bpLYyU0x7RxXEDRzimnG0YP33PE
        XGAkkdvwstYiDztx/OjdYJA=
X-Google-Smtp-Source: AKy350YXGIXyJID7gUD4IjW8G4q44qArdiHnyamBHZ+Gownt1/tzz2XxWktxSWtByoVC6jx/s+2kXA==
X-Received: by 2002:a17:903:1c7:b0:19d:323:e68 with SMTP id e7-20020a17090301c700b0019d03230e68mr13783654plh.1.1679910699879;
        Mon, 27 Mar 2023 02:51:39 -0700 (PDT)
Received: from localhost ([203.221.180.225])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902a5c700b001a207906418sm7470582plq.23.2023.03.27.02.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 02:51:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 27 Mar 2023 19:51:34 +1000
Message-Id: <CRH2N2UNMLQW.1W51OVV9ZES7L@bobo>
To:     "Kautuk Consul" <kconsul@linux.vnet.ibm.com>
Cc:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Fabiano Rosas" <farosas@linux.ibm.com>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        "Alexey Kardashevskiy" <aik@ozlabs.ru>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] arch/powerpc/kvm: kvmppc_hv_entry: remove
 .global scope
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.13.0
References: <20230316051025.1424093-1-kconsul@linux.vnet.ibm.com>
 <20230316051025.1424093-2-kconsul@linux.vnet.ibm.com>
 <CRH1YM72SK4L.QU56WGVQQ2GE@bobo>
 <ZCFhnNPrMr3D5+rZ@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZCFjJ1sMuLMUkBWc@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
In-Reply-To: <ZCFjJ1sMuLMUkBWc@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 27, 2023 at 7:34 PM AEST, Kautuk Consul wrote:
> On 2023-03-27 14:58:03, Kautuk Consul wrote:
> > On 2023-03-27 19:19:37, Nicholas Piggin wrote:
> > > On Thu Mar 16, 2023 at 3:10 PM AEST, Kautuk Consul wrote:
> > > > kvmppc_hv_entry isn't called from anywhere other than
> > > > book3s_hv_rmhandlers.S itself. Removing .global scope for
> > > > this function and annotating it with SYM_INNER_LABEL.
> > > >
> > > > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > > > ---
> > > >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc=
/kvm/book3s_hv_rmhandlers.S
> > > > index acf80915f406..b81ba4ee0521 100644
> > > > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > > @@ -502,8 +502,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> > > >   *                                                                =
            *
> > > >   *****************************************************************=
************/
> > > > =20
> > > > -.global kvmppc_hv_entry
> > >=20
> > > I think this is okay.
> > >=20
> > > > -kvmppc_hv_entry:
> > > > +SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> > >=20
> > > The documentation for SYM_INNER_LABEL says it for labels inside a SYM
> > > function block, is that a problem? This is a function but doesn't hav=
e
> > > C calling convention, so asm annotation docs say that it should use
> > > SYM_CODE_START_LOCAL?
> > That is correct. Will create a v4 patch for this and send it.
> But using SYM_CODE_START_LOCAL again causes a warning in the build
> (which we were trying to avoid):
> arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0x48: un=
annotated intra-function call

Are you using SYM_FUNC_END as well? Looks like you need that to
annotate the type properly. It should be the same as SYM_INNER_LABEL
in the end AFAIKS.

> > >=20
> > > BTW. why don't our _GLOBAL() macros use these SYM annotations? I have=
n't
> > > really looked into them.
> > Not sure. Was mostly just concentrating on the kvmppc_hv_entry code.

Looks like it's because we have a .type @function annotation in those
already. Not sure if we should end up converting all that over to use
the SYM annotations or if it's okay to leave it as is.

Thanks,
Nick
