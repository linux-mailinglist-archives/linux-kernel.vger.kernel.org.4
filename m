Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306946CA153
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjC0KZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjC0KZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:25:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809BC6189
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:24:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso8255597pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679912684;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQVXJx3PyYWBi/P3y1vObfoSrmCSvqy4APPy90F69bM=;
        b=BEOXB9KgVKR9+WTXfuh64EpofGAl20t83MBvlxlGdrsptsYY3qdByFrocgWmzIOUxk
         xR2Rc8G99uL22ONFYMlxuLIa0Aw1yQ70VnlRg7U7hhWaRiTga7PQ0cw2y+uNan6Bf0js
         V6epnh1luW+lto76bVF3VQL70ZVNke/kf2+GgqCe+8qTy9qLtT2Oks67MNzVshvnT6VU
         8N08Gp5YzldinAIRF65G7MIdSLGxaqVHt3SwWmst1LPGHr+3cHGdEgvjY3uiHt1fbwXB
         cJr9sbgNVDNwyuVvgXbW9j5fTvhYYmH6jRGauRpBNKipEECbzO1K9vMvXfBWuXD15xft
         0kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912684;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bQVXJx3PyYWBi/P3y1vObfoSrmCSvqy4APPy90F69bM=;
        b=pFCzNi7TP44tAVJU4dhb+5CKTA0qC3wcf5qaMEOyVdYT+w86EdUDsi5k5yb2fB9wXz
         jeBuD7DcJiF2RTe0RStoaZRlrBggMKtfxwTuLNNROrvhkMsxBM7SSx3pLr+8TAWSqYEt
         t071F79MdMROUG4GY/t7oDa41KYnHHsdVjlUxacxI7DImX+JqTLmdrw8+tkHv3aCEYwY
         N0pUgW2nrXtV/EFca2ziFAP8QD2BwwI066jd2ebstq/vLQIdYVaFmxUy7kG3vm3U/rCq
         J5x/xZZ4iYjMWE4GRKoMgl+UJASKIg+t/US+TAu2yLf2ohmqrnc/jwQHkPZQBSx64X1Z
         M3IA==
X-Gm-Message-State: AO0yUKUPrzis74fwv2i9THs5Nn/8qtnkBhUCBlhSV5WhJUJ84PWMiNg+
        dw5LBPgPktM7wGBlx2YlZGA=
X-Google-Smtp-Source: AK7set/InsBOTZdgeW1VdGqTXnJZ9qDODaWMEWJEszaqYZO5YnJ9fjNkTaHYk/TcjcpIlmLELwCr5A==
X-Received: by 2002:a05:6a20:2a22:b0:dc:925f:62f1 with SMTP id e34-20020a056a202a2200b000dc925f62f1mr11386322pzh.6.1679912684625;
        Mon, 27 Mar 2023 03:24:44 -0700 (PDT)
Received: from localhost ([203.221.180.225])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b005a8db4e3ecesm18757312pfa.69.2023.03.27.03.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:24:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 27 Mar 2023 20:24:38 +1000
Message-Id: <CRH3CENOOS9G.2EZ66CM1VSMUD@bobo>
Cc:     "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Fabiano Rosas" <farosas@linux.ibm.com>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        "Alexey Kardashevskiy" <aik@ozlabs.ru>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] arch/powerpc/kvm: kvmppc_hv_entry: remove
 .global scope
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Kautuk Consul" <kconsul@linux.vnet.ibm.com>
X-Mailer: aerc 0.13.0
References: <20230316051025.1424093-1-kconsul@linux.vnet.ibm.com>
 <20230316051025.1424093-2-kconsul@linux.vnet.ibm.com>
 <CRH1YM72SK4L.QU56WGVQQ2GE@bobo>
 <ZCFhnNPrMr3D5+rZ@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZCFjJ1sMuLMUkBWc@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <CRH2N2UNMLQW.1W51OVV9ZES7L@bobo>
 <ZCFoBqReJekPd7GI@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
In-Reply-To: <ZCFoBqReJekPd7GI@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 27, 2023 at 7:55 PM AEST, Kautuk Consul wrote:
> On 2023-03-27 19:51:34, Nicholas Piggin wrote:
> > On Mon Mar 27, 2023 at 7:34 PM AEST, Kautuk Consul wrote:
> > > On 2023-03-27 14:58:03, Kautuk Consul wrote:
> > > > On 2023-03-27 19:19:37, Nicholas Piggin wrote:
> > > > > On Thu Mar 16, 2023 at 3:10 PM AEST, Kautuk Consul wrote:
> > > > > > kvmppc_hv_entry isn't called from anywhere other than
> > > > > > book3s_hv_rmhandlers.S itself. Removing .global scope for
> > > > > > this function and annotating it with SYM_INNER_LABEL.
> > > > > >
> > > > > > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > > > > > ---
> > > > > >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +--
> > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/pow=
erpc/kvm/book3s_hv_rmhandlers.S
> > > > > > index acf80915f406..b81ba4ee0521 100644
> > > > > > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > > > > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > > > > @@ -502,8 +502,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> > > > > >   *                                                            =
                *
> > > > > >   *************************************************************=
****************/
> > > > > > =20
> > > > > > -.global kvmppc_hv_entry
> > > > >=20
> > > > > I think this is okay.
> > > > >=20
> > > > > > -kvmppc_hv_entry:
> > > > > > +SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> > > > >=20
> > > > > The documentation for SYM_INNER_LABEL says it for labels inside a=
 SYM
> > > > > function block, is that a problem? This is a function but doesn't=
 have
> > > > > C calling convention, so asm annotation docs say that it should u=
se
> > > > > SYM_CODE_START_LOCAL?
> > > > That is correct. Will create a v4 patch for this and send it.
> > > But using SYM_CODE_START_LOCAL again causes a warning in the build
> > > (which we were trying to avoid):
> > > arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0x48=
: unannotated intra-function call
> >=20
> > Are you using SYM_FUNC_END as well? Looks like you need that to
> > annotate the type properly. It should be the same as SYM_INNER_LABEL
> > in the end AFAIKS.
>
> What about SYM_CODE_START_LOCAL and SYM_CODE_END ?
> This seems to work fine for me without any build warnings from objtool.

That's what I meant. So you were just missing SYM_CODE_END?

Thanks,
Nick
