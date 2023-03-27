Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E266CA17B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjC0Ka6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjC0KaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:30:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29019A0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:30:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso10699823pjf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679913011;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/xoPcJZPu6j3k1DY8PgIJALXbobd1RS92NXoVMIbKY=;
        b=M9hEb/WN2PzCPCzexKI81eDSMuLORjGhnA59gxeYCHREPVHuAbEM8joynh4Juk0mjk
         J0rcridJvU2K8jVqBPdk1LqtrZcxDed87znweusGuwKKAKnHmCIvUUOPk5uNyeQplYK4
         p+uDfM0EFNPVODIJtgoUVTu8+clgSHKJkkyYkDtZ+O1uBUtTNvrH7ovSFf8bgDqu4lkQ
         k7ZyH0RwoKTKI+LE59ve3KICRQwVszyu38sUP084tyqq6H4/+OCqW+bRpZdAq85PUt7x
         lOhGGOSHx8S/WVdVStHrU2wEkiaGYR6bmdr7UXlM6fDmhq2ErZJ319QoJCzPsoFYRIJ6
         N1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679913011;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o/xoPcJZPu6j3k1DY8PgIJALXbobd1RS92NXoVMIbKY=;
        b=pBGVbLs1jg+fnFTotwBqnA8oHZzjbN8k52oVs/rS/h4ECEPI6ugp9pUkbKsoZz6JBq
         sDjAl8XTH8KBtca53+tM29gUMXArWUmZjADuO+9NCRNOXDNqm5CpyKSUjGbNBKR5VO91
         bs9CPs8HKzj4kbZILxF2BTR4npXzwOAo8imRUUvbumKU79slcR5htXoBSqUmdR1E1rMn
         4dLJZLhoRF53vXLABloS/o7PJYmCAOylqz5ArmdO4TImgz1MxwVbXZyQ6XpsSHtWWfI5
         5oOI0HfBbmNvkdwIq58cizE4pkKnMxb7eVi6H1ZJqjdUEVuOllyZkSt3cd++xq+vq0kj
         1bOQ==
X-Gm-Message-State: AAQBX9fdCHkDlTqs55IPmIV+AeOLIuZ2jgCkkcWl5BokbPT73H0MJhgK
        nFxLeMb6vdHb6GR31h+zwzMqpuSK/4Y=
X-Google-Smtp-Source: AKy350ZePws+Fhfg4r9tvskQcm8V2QJtCXxS82HPo/4mMBhVhgoiqPj1L7mnlHYMcfaVlBVElZV2Bw==
X-Received: by 2002:a17:90a:c8c:b0:23f:7e48:4f20 with SMTP id v12-20020a17090a0c8c00b0023f7e484f20mr11999857pja.41.1679913011524;
        Mon, 27 Mar 2023 03:30:11 -0700 (PDT)
Received: from localhost ([203.221.180.225])
        by smtp.gmail.com with ESMTPSA id z23-20020a1709028f9700b001a043e84bf0sm18790204plo.209.2023.03.27.03.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:30:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 27 Mar 2023 20:30:02 +1000
Message-Id: <CRH3GJDNC4SF.2HBIHLLQSCWSI@bobo>
To:     "Kautuk Consul" <kconsul@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        "Alexey Kardashevskiy" <aik@ozlabs.ru>,
        "Fabiano Rosas" <farosas@linux.ibm.com>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] arch/powerpc/kvm: kvmppc_hv_entry: remove .global
 scope
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.13.0
References: <20230327100411.3342194-1-kconsul@linux.vnet.ibm.com>
In-Reply-To: <20230327100411.3342194-1-kconsul@linux.vnet.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 27, 2023 at 8:04 PM AEST, Kautuk Consul wrote:
> kvmppc_hv_entry isn't called from anywhere other than
> book3s_hv_rmhandlers.S itself. Removing .global scope for
> this function and annotating it with SYM_CODE_START_LOCAL
> and SYM_CODE_END.

Does removing .global introduce the objtool warning, or was it already
present? Just trying to understand if this is two changes or one (not
that it really matters, maybe just for the purpose of the changelog).

Since the patch only touches KVM, subject should follow arch/powerpc/kvm
convention, which is not the same as the rest of arch/powerpc. KVM: PPC:
Book3S HV:

Otherwise seems okay

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

>
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index acf80915f406..0a9781192b86 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -502,8 +502,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>   *                                                                      =
      *
>   ***********************************************************************=
******/
> =20
> -.global kvmppc_hv_entry
> -kvmppc_hv_entry:
> +SYM_CODE_START_LOCAL(kvmppc_hv_entry)
> =20
>  	/* Required state:
>  	 *
> @@ -940,6 +939,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	ld	r4, VCPU_GPR(R4)(r4)
>  	HRFI_TO_GUEST
>  	b	.
> +SYM_CODE_END(kvmppc_hv_entry)
> =20
>  secondary_too_late:
>  	li	r12, 0
> --=20
> 2.39.2

