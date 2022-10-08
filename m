Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DB5F853B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJHMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJHMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 08:40:19 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2572F01C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 05:40:18 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1364357a691so1728475fac.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CQeqKM4cX5wLbNYTV5WzNxWIUu9O9xoqEIDAJBgyPUE=;
        b=Yzc+yyCT6AvcVQzVoHfV0l6juxjzxajCTMpICrIyvm/dHrYKZc0EvOuO5xqecvAIZZ
         jENBxCxZNYjdITjOBomGwBnaFdh4/dRqNvXJNd8imkInxBvX0143Ehquoae/qIs7oDNP
         Esv2ri9qqhdYtCYBez+IWzll5XZXXS15IH87jhE+CbkbsNALbf+j3Q32PizSMC3Ppg0K
         aZ8HahOx08Goyb6DoKMzuq5v9IsZ/TIB3laAl8VZZwBzwQSM9xJq6WykZiPxd3/3g2hU
         M9i9Z/Kp+pzf9bAJITB+YLkX0STL0BSomTJGWCob9QmStA8ztO0Ut1sbrvMMnAxxJjps
         66cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQeqKM4cX5wLbNYTV5WzNxWIUu9O9xoqEIDAJBgyPUE=;
        b=3sGmpIFCWpdBlVOqTTsCTm0LZ8A9L/Wi4kwjOE/YChzj23MlMJdsbqs/d2erkkeFig
         VxsTXq5jqJzpqMWJXfr+YE4yr/2ROVVAkpNNOwxGMfv4fjWU6dKWLw57eH3eyCTin8ix
         dU24b1rUgHLXwieFZBGvQ/2mERXTjwnBZ/M9gniW+G7MgagNDX/r5+E4B3PDykZdXAgg
         ERxHJkwaM5mVMqH5i0+sP6f4hbRtT+EsyvCS5TjZr43i4Ponj+3wKVM1wSCkfGu4PBzs
         hBQkTLZSkmJR76ny8+OSb5lZu1xLkebVZnoSQh+Qt8JqahMZOfwhZGs8Q9mkTFEhXqlQ
         pqjQ==
X-Gm-Message-State: ACrzQf2jxBy60KvXeNezH7KuzM7FKwr/l9yW6+U4QVSeKkxLhoVo6lcE
        SbKlKy8YXRNZPdWonB7/+M5Ds6F1rCL0gqgaBXpynQY=
X-Google-Smtp-Source: AMsMyM59OuzkqJ/nSUeVo1rOcTKX41wf2XovXFwTSF76SPBK3r8RAS/ksuxndMr4f9G8E4d5mcHwLsN9PS65EIBgVI8=
X-Received: by 2002:a05:6870:8a09:b0:132:554d:2f3d with SMTP id
 p9-20020a0568708a0900b00132554d2f3dmr10623536oaq.194.1665232818117; Sat, 08
 Oct 2022 05:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-7-xin3.li@intel.com>
 <CAMzpN2iccL5kNa2UaBXppiLnoNWrpwJd74+uBrB_63N0F5F5Xg@mail.gmail.com> <BN6PR1101MB2161E1191DF1BD0135DC3947A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR1101MB2161E1191DF1BD0135DC3947A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 8 Oct 2022 08:40:06 -0400
Message-ID: <CAMzpN2i52orTgPqRARoCkuA=c2GEyWXLscrFRgDkb0LoFV01Rw@mail.gmail.com>
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for load_gs_index()
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
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

On Sat, Oct 8, 2022 at 1:40 AM Li, Xin3 <xin3.li@intel.com> wrote:
>
> > > +       alternative_io("1: call asm_load_gs_index\n"
> > > +                      ".pushsection \".fixup\",\"ax\"\n"
> > > +                      "2:      xorl %k[sel], %k[sel]\n"
> > > +                      "        jmp 1b\n"
> > > +                      ".popsection\n"
> > > +                      _ASM_EXTABLE(1b, 2b),
> > > +                      _ASM_BYTES(0x3e) LKGS_DI,
> > > +                      X86_FEATURE_LKGS,
> > > +                      ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
> > > +                      ASM_NO_INPUT_CLOBBER(_ASM_AX));
> > >  }
> > >
> > >  #endif /* CONFIG_X86_64 */
> > > --
> > > 2.34.1
> >
> > There are not that many call sites, so using something like this (incorporating
> > Peter Z's suggestion for the exception handler) would be better from a code
> > readability perspective vs. a tiny increase in code size.
>
> The existing approach patches the binary code thus we don't need to check it at runtime.

static_cpu_has() uses alternatives to patch the branch, so there is no
runtime check after early boot.

--
Brian Gerst
