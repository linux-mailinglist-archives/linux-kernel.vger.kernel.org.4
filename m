Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5118B6AD6C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCGF1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCGF1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:27:33 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927E41B7C;
        Mon,  6 Mar 2023 21:27:32 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z11so7332669pfh.4;
        Mon, 06 Mar 2023 21:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678166852;
        h=in-reply-to:references:message-id:date:content-transfer-encoding:to
         :from:subject:cc:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlK7Hs19AjyIKqP3f0Dwl6HgKXmloRUX9J0NNF4qZqI=;
        b=KiEN0lSrI7WdHvK+rnjlsSC8PfIXOqThM5Yhp6on6h/pS31vZIWhH8yTZ2qjPpe5xx
         UisPU6FWCL9VtMjr0XD0FrVJdu8YtEuykkldNDr+WwhFsP/F2L/Ne7TzEO35zH/95bcJ
         Dp9+DwQeI8qzAXIIGQ1RvRmUNtswyBa3EbimAMf71e18GzxGYULJFWQslySGV8fQ2Uuo
         /+TYis8hkk9bNjVuQ0C47MRsNetBokRMxAA40JwP935fdjdtGoody8r/p6wUjtBo6zfK
         f04A52pp7kPEEgX+t5potcw4pVyMQ6OGAO23JYjSahl4xpQqux4T0WH1z2DpwPPydO8g
         mgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678166852;
        h=in-reply-to:references:message-id:date:content-transfer-encoding:to
         :from:subject:cc:mime-version:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AlK7Hs19AjyIKqP3f0Dwl6HgKXmloRUX9J0NNF4qZqI=;
        b=EpK8gmKG8tQDoUSA7J3nuHT5376ewZQG9ZRcfLzncPQLvpwyk2NXY+rtHhWq7z84Dn
         D+flSu5QkAeGpbQVU7ftWpOW5wBCpJinrnKb3Y4oGDfrBIdsVtC175D4SnmofQAKsAkK
         SHAYTvyADwY9gUjyGaZDhJ5YlJS+2odEadsfmbLOHCRg2CNtyiY1JVik/f42KEIaGm+Z
         pTktY4WR+UhGvmRiH3Ka2wbYB23rvDx1bMdJJw8s+DvrGYVmsB4jcyZo26T+wNePqciT
         SnD4ixKgNzkGvb10evlc3jXS1gAJCHUbqUGFfPNGeCmVY6cwOOvJWr0xL0uwvfKjwxuk
         y+nw==
X-Gm-Message-State: AO0yUKX92pF28O47XCDIKIQMr2pMHinmeL2f0HAhhfaFBkuMCMs+ooGc
        17Nm1BLD9pU/tz1SdefWmRc=
X-Google-Smtp-Source: AK7set+9FsF4BJMmdn0oPnSFIvoRnnZoR2gOxBSb5vcLt0/zI12PgdR5eqnOvR8okCGeDSq2c4ccgw==
X-Received: by 2002:a62:5401:0:b0:5e2:da34:4aaf with SMTP id i1-20020a625401000000b005e2da344aafmr10320547pfb.4.1678166852291;
        Mon, 06 Mar 2023 21:27:32 -0800 (PST)
Received: from localhost ([203.220.77.23])
        by smtp.gmail.com with ESMTPSA id q18-20020a62e112000000b005a8de0f4c64sm7137152pfh.82.2023.03.06.21.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 21:27:31 -0800 (PST)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc:     <ajd@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <cmr@bluescreens.de>
Subject: Re: [RFC PATCH 06/13] powerpc/dexcr: Add prctl implementation
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Benjamin Gray" <bgray@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 07 Mar 2023 15:12:57 +1000
Message-Id: <CQZW6V070YIU.3Q6OJGKRPH3KY@bobo>
X-Mailer: aerc 0.13.0
References: <20221128024458.46121-1-bgray@linux.ibm.com>
 <20221128024458.46121-7-bgray@linux.ibm.com>
In-Reply-To: <20221128024458.46121-7-bgray@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 28, 2022 at 12:44 PM AEST, Benjamin Gray wrote:
> Adds an initial prctl interface implementation. Unprivileged processes
> can query the current prctl setting, including whether an aspect is
> implemented by the hardware or is permitted to be modified by a setter
> prctl. Editable aspects can be changed by a CAP_SYS_ADMIN privileged
> process.
>
> The prctl setting represents what the process itself has requested, and
> does not account for any overrides. Either the kernel or a hypervisor
> may enforce a different setting for an aspect.
>
> Userspace can access a readonly view of the current DEXCR via SPR 812,
> and a readonly view of the aspects enforced by the hypervisor via
> SPR 455. A bitwise OR of these two SPRs will give the effective
> DEXCR aspect state of the process.

You said (offline) that you were looking at the PR_SPEC_* speculation
control APIs but that this was different enough that you needed a
different one.

It would be good to know what some of those issues were in the
changelog, would be nice to have some docs (could we add something
to spec_ctrl.rst maybe?). I assume at least one difference is that
some of our bits are not speculative but architectural (e.g., the
stack hash check).

I also wonder if we could implement some of the PR_SPEC controls
APIs by mapping relevant DEXCR aspects to them instead of (or as well
as) the DEXCR controls? Or would the PR_SPEC users be amenable to
extensions that make our usage fit a bit better?

I'm just thinking if we can reduce reliance on arch specific APIs a
bit would be nice.

>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/processor.h |  13 +++
>  arch/powerpc/kernel/dexcr.c          | 133 ++++++++++++++++++++++++++-
>  arch/powerpc/kernel/process.c        |   6 ++
>  3 files changed, 151 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/=
asm/processor.h
> index 2381217c95dc..4c995258f668 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -265,6 +265,9 @@ struct thread_struct {
>  	unsigned long   sier2;
>  	unsigned long   sier3;
>  	unsigned long	hashkeyr;
> +	unsigned int	dexcr_override;
> +	unsigned int	dexcr_mask;

Hmm, what's the mask doing here? It only gets bits set and never
cleared AFAIKS. What is different between an initial state and a
SET then CLEAR state?

Thanks,
Nick
