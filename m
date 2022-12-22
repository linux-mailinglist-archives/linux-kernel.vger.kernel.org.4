Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFFE6540F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiLVMXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiLVMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:23:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D8183A1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:23:28 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so5550907pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdDJgwcsu5IyO/nuycFje+XP9l7MwqwDfx8pJnx7g2s=;
        b=TbbkdmEquZ8ax5xCrAzKcVDlsBIaTTf22DVcmgmUFw8mZd7+B/9Cz1EMXOraEfYMqf
         4B9oSbeoPU9eAEQytGfErllWh4mntzrLqCYI5PyMEfiNqoPSevXWpC3zTJZZjKUOgm1r
         XB3JI6MkHl0Orysi3+Q631izlGY4bFSMlO+YzEjxd4LJw9CtGDrGL7QprDwbSMF4OiCS
         G1JyotmRXYDscPd25UAJY/6kiSQU2Hz5BYpoCwoXNlKDSjtJ+XFwOC38g9PcINnpPLZi
         JemXbGaXgt+fhScPxbd7cTaOkf0FKu+nHxpaVhwob1sFDyUYWG1ggZZHlUeKkrr7qIKl
         070Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdDJgwcsu5IyO/nuycFje+XP9l7MwqwDfx8pJnx7g2s=;
        b=YdUkoCmUcw29tKlqCSrS7sPTWUpMGCVFOq0xoeDBRU0TMa3uNIF2j1PAgI6xWRtQKe
         sIGziizLLAzZtqqk7RIV6V5oXfY6IfhMsQisqZQ62oNbDkxFYyW57fqbDwLxZQ6yehoJ
         HMjLk54PZHW76dGfn+LDn39nuJ+rOEHB5KObhlky13Cm2HtgZxPqOKngLhQG5A92qG1v
         iqGOfdwnon4n/w+R3lKWAAMOET6CSHVcInYqop7XCDoTOXqhWbAz+W5uZxpkx09/gBrg
         1X7nx60Tyd8RnWoccEOds6rlu9tvempyTlV8Dwwj9giowP8axD1CctJpFqQLlqVAaukE
         9l4g==
X-Gm-Message-State: AFqh2kpmai0jQCalhQqefCEFDGS4uSdfJ6XHQb6U8s/L/EW6Cu/D37qQ
        b8ABqWCfIerxFzFEvjuCpx8=
X-Google-Smtp-Source: AMrXdXvUgAJCEXRg2JsQw1FsDW8qth/OvPTUYapUPOTmEwnfbwOlkUP+po2PO2z/JQh09iPbbBMTlg==
X-Received: by 2002:a17:90a:9606:b0:219:f7e5:cb56 with SMTP id v6-20020a17090a960600b00219f7e5cb56mr6329664pjo.20.1671711808368;
        Thu, 22 Dec 2022 04:23:28 -0800 (PST)
Received: from mail.google.com ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id f10-20020a63510a000000b004351358f056sm636149pgb.85.2022.12.22.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 04:23:27 -0800 (PST)
Date:   Thu, 22 Dec 2022 20:23:26 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, changbin.du@intel.com, zong.li@sifive.com,
        rostedt@goodmis.org, boqun.feng@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] riscv: patch: Fixup lockdep warning in stop_machine
Message-ID: <20221222122326.4ephcsa76lmrsfxw@mail.google.com>
References: <20221120101049.2078117-1-guoren@kernel.org>
 <Y3tPEDvM3aVJmVxF@wendy>
 <CAJF2gTS0FDgV3toa9wZxPhK2G+f4vCtrru7q3R4FXnMkxYmu-w@mail.gmail.com>
 <20221222001902.zcbwlvqaitvsfb33@mail.google.com>
 <5CA9DB64-CE90-490A-835B-0FC4550E5D9A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CA9DB64-CE90-490A-835B-0FC4550E5D9A@kernel.org>
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

On Thu, Dec 22, 2022 at 12:29:56AM +0000, Conor Dooley wrote:
> 
> 
> On 22 December 2022 00:19:02 GMT, Changbin Du <changbin.du@gmail.com> wrote:
> >Hello,
> >Does this patch get merged into riscv tree now? This problem has been there for a long
> >time. (I suppose you have received my previous reponse.)
> 
> As far as I can tell, this patch is still missing a sign-off from you.
> There's nothing in response to this thread that I can see which provides one.
> 
Just replied the patch and added my SoB. Thanks!

> >
> >On Mon, Nov 21, 2022 at 07:09:45PM +0800, Guo Ren wrote:
> >> On Mon, Nov 21, 2022 at 6:13 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> >> >
> >> > On Sun, Nov 20, 2022 at 05:10:49AM -0500, guoren@kernel.org wrote:
> >> > > From: Changbin Du <changbin.du@gmail.com>
> >> >
> >> > > Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
> >> > > Cc: Changbin Du <changbin.du@gmail.com>
> >> > > Co-developed-by: Guo Ren <guoren@kernel.org>
> >> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> >> > > Cc: Zong Li <zong.li@sifive.com>
> >> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >> > > ---
> >> >
> >> > Hey Guo Ren,
> >> >
> >> > FYI you're missing a SoB from Chanbin on this patch. They gave one in
> >> > their v1 though so you should be able to re-use that?
> >> I'm waiting for his SoB. I don't think I could directly use his SoB in
> >> v1. I need him to confirm my rewritten commit log for lockdep
> >> analysis.
> >> 
> >> >
> >> > Thanks,
> >> > Conor.
> >> >
> >> > > Changes in v2:
> >> > >  - Rewrite commit log with lockdep explanation [Guo Ren]
> >> > >  - Rebase on v6.1 [Guo Ren]
> >> > >
> >> > > v1:
> >> > > https://lore.kernel.org/linux-riscv/20210417023532.354714-1-changbin.du@gmail.com/
> >> >
> >> 
> >> 
> >> -- 
> >> Best Regards
> >>  Guo Ren
> >

-- 
Cheers,
Changbin Du
