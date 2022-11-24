Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3134637ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiKXSJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKXSJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:09:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878474ABB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:09:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i12so3589121wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4j/3qr/essTH4o+9bQoOm2X2iPpGf3asbr9aUA3N9IA=;
        b=QRjBan++vhp4SIL4Vu+DzdCCNXao+23zxmn9FfigQr+hfk1vazzX0CUFW+cwMyzbjT
         0sptCE81q9kgZdoC19YsCqOVTco2Ba2k5+CmZhhmbj+wubJfeCv+jpDyVbV91692YMku
         7Er8+XIiOrC1tfyeWB/WMTL/Tnq4jIOUh6MsikRo/nwwcKrWtblU0YRTvQt0/bbonQRy
         teP6PqXz6mznnL8jv/wM9xMvA7D27PC4uAEHsWF1GKJBa2BSSc2WvzkvO0t/sd1Un9uG
         b8BpxR/Al/oO2Tl8fHhQvBaZCoFejko0ceT/JYWth8vFdUKA/PfHoaLl/YttgiwHKiHM
         0MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j/3qr/essTH4o+9bQoOm2X2iPpGf3asbr9aUA3N9IA=;
        b=HfFdiTpwykyIbilcS/wFcRLT4KOPfDMH9ZG5l0GnJp5AGg94qxFJz23JwZUirLrFJF
         9svyXr8MLQGB2TJByn1pyd/QNXvJXOuMz0w7O5DMnd4DdBJ3Befmp4lUvyTxgsguQV2h
         MlqDtL/IeL2G18kQhjb1W00AHkN/x8z/8mMs4YEpnTGwItUBThwJ6ae0aDMdjWa4QXee
         M6HbkcaEfcOSRYO3YM+WDsaHKvxdioFbvDB/RaCOQG5mlgeUZWG18xEvhHyoRkBqKp9G
         m/tunzetSvRYNXI/ousCVpvMMizTMJwEdqrqY9C9Fu95pNbfmUuLc6CxAowXuoHtNQmX
         IxNQ==
X-Gm-Message-State: ANoB5pnaI8E+9akh+JqOKtB59nTyxYb0vi5qucPXAmEEXZE5+8gM4fTS
        dQ47KKX3Shn40/DPaWMoBM9mKw==
X-Google-Smtp-Source: AA0mqf4/0p/5wvPl1pNIqdjxSDbULR/ahbLRoS+EluN0du0FTfqfVlr96Lp8CIcSt3mTXhHtC5hkLQ==
X-Received: by 2002:a5d:6389:0:b0:241:c5fe:f78a with SMTP id p9-20020a5d6389000000b00241c5fef78amr17181945wru.144.1669313383437;
        Thu, 24 Nov 2022 10:09:43 -0800 (PST)
Received: from vermeer ([145.224.92.100])
        by smtp.gmail.com with ESMTPSA id fn27-20020a05600c689b00b003cf75213bb9sm6771615wmb.8.2022.11.24.10.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:09:43 -0800 (PST)
Date:   Thu, 24 Nov 2022 19:09:39 +0100
From:   Samuel Ortiz <sameo@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     "Hongren (Zenithal) Zheng" <i@zenithal.me>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <Y3+zY8zU9I08eVVS@vermeer>
References: <YqYz+xDsXr/tNaNu@Sun>
 <YqY0i22SdbHjB/MX@Sun>
 <Y385rS/5zDaDJ3Os@vermeer>
 <Y39AXYPFzSiBngwI@wendy>
 <Y39Lwp4rQc3Qkl0i@vermeer>
 <Y39blUaC/jHiOYCk@wendy>
 <Y3+mBAV8oxphjHcJ@vermeer>
 <c9ae9644-5cd0-29c2-a25c-bb497dfcb1c8@kernel.org>
 <Y3+rE6j/CzTpINi+@vermeer>
 <27d0de3e-1006-dd3a-0e91-ae8025ef8426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d0de3e-1006-dd3a-0e91-ae8025ef8426@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:54:00PM +0000, Conor Dooley wrote:
> On 24/11/2022 17:34, Samuel Ortiz wrote:
> > On Thu, Nov 24, 2022 at 05:20:37PM +0000, Conor Dooley wrote:
> >> On 24/11/2022 17:12, Samuel Ortiz wrote:
> >>> [You don't often get email from sameo@rivosinc.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On Thu, Nov 24, 2022 at 11:55:01AM +0000, Conor Dooley wrote:
> >>>> On Thu, Nov 24, 2022 at 11:47:30AM +0100, Samuel Ortiz wrote:
> >>>>
> >>>>> Patch #1 is definitely needed regardless of which interface we pick for
> >>>>> exposing the ISA strings to userspace.
> >>>>
> >>>> I took another look at #1, and I feel more confused about what
> >>>> constitutes canonical order than I did before! If you know better than
> >>>> I, and you probably do since you're interested in these 6 month old
> >>>> patches, some insight would be appreciated!
> >>>
> >>> Assuming we don't go with hwcap, I dont think the order of the
> >>> riscv_isa_ext_id enum matters that much?
> >>
> >> The chief put it in canonical order so that's good enough for me!
> >>
> >>>
> >>> iiuc we're building the cpuinfo string from the riscv_isa_ext_data
> >>> array, and I think the current code is incorrect:
> >>>
> >>> static struct riscv_isa_ext_data isa_ext_arr[] = {
> >>>     __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >>>     __RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> >>>     __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> >>>     __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> >>>     __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> >>>     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >>>     __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >>> };
> >>>
> >>> zicbom and zihintpause should come before supervisor level extensions.
> >>> I'm going to send a patch for that.
> >>
> >> idk, Palmer explicitly re-ordered this:
> >> https://lore.kernel.org/linux-riscv/20220920204518.10988-1-palmer@rivosinc.com/
> >>
> >> By my reading of the isa manual, what Palmer did is correct as
> >> those are not "Additional Standard Extensions". /shrug
> > 
> > Hmm, by their name (Z[a-b]+) they are Additional Standard Extensions.
> > What am I missing?
> 
> Right, and this is where I get confused. Zam and Ztso *are* Additional
> Standard Extensions, I think we can agree on that one? For those
> extensions:
> \chapter{``Ztso'' Standard Extension for Total Store Ordering, v0.1}
> \chapter{``Zam'' Standard Extension for Misaligned Atomics, v0.1}
> 
> They're also called out specifically in the table:
> https://github.com/riscv/riscv-isa-manual/blob/master/src/naming.tex#L147
> 
> For Zihintpause however:
> \chapter{``Zihintpause'' Pause Hint, Version 2.0}
> 
> See what I mean? I looked at the specs for the bitmanip stuff and for
> crypto, which both never mention being standard.

I *think* this is because Zihintpause, bitmap and crypto are ratified
but not yet part of an official spec (non-draft) release?


> That table has the caption:
> > The table also defines the canonical order in which extension names
> > must appear in the name string, with top-to-bottom in table
> > indicating first-to-last in the name string. 
> 
> It only calls out Zicsr, Zifencei, Zam and Ztso are being permitted
> before Sdef, but as I said I am not a specs person, so perhaps some
> of the extensions in question are intended to go there but have not
> yet been merged into the isa manual doc. Zihintpause *is* in the
> isa manual though but not specifically called out.
> 
> Anyways, hopefully that at least helps with my line of thinking!
It does, thanks. It's a little confusing, I agree.

Cheers,
Samuel.
