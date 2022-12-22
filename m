Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC6653A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 01:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiLVATI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 19:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVATG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 19:19:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5181A19035
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:19:05 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 4so494940plj.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 16:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Io3Afroc8zFyKk/Hx34XQjyWndPNIt1uCFFePpDepyQ=;
        b=QbJfSkr09ebQmiSkPnF/l33Y6wWP4j4yd0ugpActN28xedWMn/qZFa7t8sAMUfNKVz
         6FtXWZqHYDZBUh2ieHI4Nm2iU4+ZuYfy5L6zi/6lvd6tZDOCfiVABqAlC6DiGPQ+KR8P
         lxDu71JRB8n3EaZVeU5OV6pAdpcbQECpK9l5l54anYWj/BdX/P2dXSK41RLzxvvD+fNl
         lBfTivpLdq9g5Rm5v4KACJVsR+7QQOPW1ZT9SKMv7Ihl7YC+r/N1weZ6PMSj/IOZILPS
         tEYAD3bhhUrSM88s8cIQ5YUApn3Xn6Rz1UJy6UmtOXut2VF+N5OqoytkSLlOvZ7kX4Zs
         MXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io3Afroc8zFyKk/Hx34XQjyWndPNIt1uCFFePpDepyQ=;
        b=SdyA8lwlYxQ6/tojnRSLDeoQcjzxx/j2nHZJ04TGkanHBYKjhKisuTrRyEv1lfFMQo
         5FJPT3kiqTJw3TUnUsqSvqdjexO2QJNVsfjEKEtBVM2G+AZ1eThMqm3w0g0fBgJpMfxx
         GqZ3iks6U+qW+TKJIpCngX8Cou70eJRyELqMnaAYVF8C91Mof1SkkB78AW2c7zwuoGKk
         h0HQ4Em/R8EOlVXdnwTj8yhi1QJkdg1KzRQzAvKndDo8Oj7WEqXLPkZyovmdvIT7a1ri
         16lFmo/1QiNF2SKm03op71X81+7LjIRsCdjIjYxCNb+Nf2tF9/XtWj0LHN6nWdOz/ggF
         BImA==
X-Gm-Message-State: AFqh2krmt02uWVa3jx6pQ+48k8uKdocXp2lP5XaiKkGsjlaz9gwKaVRm
        yCYnifqjGZlg3luHy8pmIOQ=
X-Google-Smtp-Source: AMrXdXu/Qf48X8wXM9YBLEIbtcufrjby5XmXviCcNy7cB0FlXvOu/AUQd1BAFkEbGV+6T2TjH1FXhA==
X-Received: by 2002:a17:90a:dc12:b0:20d:bd62:97b0 with SMTP id i18-20020a17090adc1200b0020dbd6297b0mr4098101pjv.45.1671668344789;
        Wed, 21 Dec 2022 16:19:04 -0800 (PST)
Received: from mail.google.com ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090ad38200b00223ea04b3fdsm1934563pju.45.2022.12.21.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 16:19:03 -0800 (PST)
Date:   Thu, 22 Dec 2022 08:19:02 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, changbin.du@intel.com, zong.li@sifive.com,
        rostedt@goodmis.org, boqun.feng@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH V2] riscv: patch: Fixup lockdep warning in stop_machine
Message-ID: <20221222001902.zcbwlvqaitvsfb33@mail.google.com>
References: <20221120101049.2078117-1-guoren@kernel.org>
 <Y3tPEDvM3aVJmVxF@wendy>
 <CAJF2gTS0FDgV3toa9wZxPhK2G+f4vCtrru7q3R4FXnMkxYmu-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTS0FDgV3toa9wZxPhK2G+f4vCtrru7q3R4FXnMkxYmu-w@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Does this patch get merged into riscv tree now? This problem has been there for a long
time. (I suppose you have received my previous reponse.)

On Mon, Nov 21, 2022 at 07:09:45PM +0800, Guo Ren wrote:
> On Mon, Nov 21, 2022 at 6:13 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > On Sun, Nov 20, 2022 at 05:10:49AM -0500, guoren@kernel.org wrote:
> > > From: Changbin Du <changbin.du@gmail.com>
> >
> > > Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
> > > Cc: Changbin Du <changbin.du@gmail.com>
> > > Co-developed-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Cc: Zong Li <zong.li@sifive.com>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > ---
> >
> > Hey Guo Ren,
> >
> > FYI you're missing a SoB from Chanbin on this patch. They gave one in
> > their v1 though so you should be able to re-use that?
> I'm waiting for his SoB. I don't think I could directly use his SoB in
> v1. I need him to confirm my rewritten commit log for lockdep
> analysis.
> 
> >
> > Thanks,
> > Conor.
> >
> > > Changes in v2:
> > >  - Rewrite commit log with lockdep explanation [Guo Ren]
> > >  - Rebase on v6.1 [Guo Ren]
> > >
> > > v1:
> > > https://lore.kernel.org/linux-riscv/20210417023532.354714-1-changbin.du@gmail.com/
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren

-- 
Cheers,
Changbin Du
