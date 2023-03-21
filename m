Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7FE6C2910
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCUEQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCUEPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:15:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4089949F9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:15:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id cu12so3003078pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679372121;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ2j5JN955TIVQ6alJF8oihXVZDZ3XjiZxc6zY7G6i8=;
        b=C5TlzmipNRBOvhfXbntHYNIh7BINmX3doog1Kh/Nt8x0Dzeroj4cWnGwbYiAMag6vT
         3teLzldwQ8d/0arRPh90I2m5w6NtiS67ZdZIZN5aMqhTDdxkDyjocN2l16hdJm4wSe3n
         MrFhtH8LsCkPPEKjeGmnI1zfKMKbGKpFjK30ZiatpDrn3hksUlVeVZF3Cy1/qAyGispK
         mP5Q2gR0ASOAoYtjBWgrQqMGH3FWgB3FQX5KxdwBb8xUfKlfPvYp/g7Am48E1ZUeqp1F
         3WdRQNm/htm105jJwB2cMyXbUpoJoiPIGFDqE8Pyp+JCRFrQT4PsKHuf+BcJqVgjqVma
         fLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679372121;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sJ2j5JN955TIVQ6alJF8oihXVZDZ3XjiZxc6zY7G6i8=;
        b=gBUhA/gmVShX2qAdN2nWFrGjckj11XzwSkYqRvU0vALqsL9+3C2IZQ4rYD+2vdH1iX
         s6DPI+oqKQkJFowe370CpCvpEc6PLtJDuPDyw3in/vIl8VuxB7n8WIOI6VBWorHFuIJa
         lXEupbhdTvftvlyS/fWCGQ7q3PdyL7qUsB+eOO0vZFraTRzL/ItLiwlETwJ/Gvv1sap4
         gnnyASGdU2JCx8gwsuhgW4FLYUGZUSz+6bhu1+p2plm4Drl8Vid+F3UwAiJFmCi97Qfv
         kfXDTXTgyXULOyQMjSo7uU+uiOLcNXbkXFvIviBLKpLtwrnO/6TwjgLjpuVRESG20p7+
         /uQg==
X-Gm-Message-State: AO0yUKXoYBls85eIhHw9ISswQMRqwlCZef9SQT3i8uVTvmlL2hqZP19s
        /5mTnEcmcgF/ls+s0W8fBbMVye61jIE=
X-Google-Smtp-Source: AK7set8dpMbVHUo4z+qEAApeMhTR1ArVggBkpk5n/HqWDsBBjRCHMET+H6oD4qp9S/na9AarcUi1ZA==
X-Received: by 2002:aa7:9dc1:0:b0:5a8:4861:af7d with SMTP id g1-20020aa79dc1000000b005a84861af7dmr1259596pfq.20.1679372120677;
        Mon, 20 Mar 2023 21:15:20 -0700 (PDT)
Received: from localhost (121-44-69-75.tpgi.com.au. [121.44.69.75])
        by smtp.gmail.com with ESMTPSA id j26-20020aa78d1a000000b005dfc8a35793sm7113513pfe.38.2023.03.20.21.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 21:15:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 21 Mar 2023 14:15:14 +1000
Message-Id: <CRBRQAXJRZZW.28LH58EV3T8AL@bobo>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arch/powerpc/kvm: kvmppc_hv_entry: remove r4
 argument
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Kautuk Consul" <kconsul@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Fabiano Rosas" <farosas@linux.ibm.com>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        "Alexey Kardashevskiy" <aik@ozlabs.ru>
X-Mailer: aerc 0.13.0
References: <20230316051025.1424093-1-kconsul@linux.vnet.ibm.com>
 <20230316051025.1424093-3-kconsul@linux.vnet.ibm.com>
In-Reply-To: <20230316051025.1424093-3-kconsul@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 16, 2023 at 3:10 PM AEST, Kautuk Consul wrote:
> kvmppc_hv_entry is called from only 2 locations within
> book3s_hv_rmhandlers.S. Both of those locations set r4
> as HSTATE_KVM_VCPU(r13) before calling kvmppc_hv_entry.
> So, shift the r4 load instruction to kvmppc_hv_entry and
> thus modify the calling convention of this function.

Is r4 there only used for CONFIG_KVM_BOOK3S_HV_P8_TIMING? Could put it
under there. Although you then lose the barrier if it's disabled, that
is okay if you're sure that's the only memory operation being ordered.

I'm not sure how much new work we want to put into changing this asm
code, since it's POWER7/8 only. I would love to move this (and the
other) KVM implementations to C like we did with P9. It's a pretty big
job though.

Thanks,
Nick

>
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index b81ba4ee0521..b61f0b2c677b 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -85,7 +85,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
>  	RFI_TO_KERNEL
> =20
>  kvmppc_call_hv_entry:
> -	ld	r4, HSTATE_KVM_VCPU(r13)
> +	/* Enter guest. */
>  	bl	kvmppc_hv_entry
> =20
>  	/* Back from guest - restore host state and return to caller */
> @@ -352,9 +352,7 @@ kvm_secondary_got_guest:
>  	mtspr	SPRN_LDBAR, r0
>  	isync
>  63:
> -	/* Order load of vcpu after load of vcore */
> -	lwsync
> -	ld	r4, HSTATE_KVM_VCPU(r13)
> +	/* Enter guest. */
>  	bl	kvmppc_hv_entry
> =20
>  	/* Back from the guest, go back to nap */
> @@ -506,7 +504,6 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> =20
>  	/* Required state:
>  	 *
> -	 * R4 =3D vcpu pointer (or NULL)
>  	 * MSR =3D ~IR|DR
>  	 * R13 =3D PACA
>  	 * R1 =3D host R1
> @@ -524,6 +521,10 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
>  	li	r6, KVM_GUEST_MODE_HOST_HV
>  	stb	r6, HSTATE_IN_GUEST(r13)
> =20
> +	/* Order load of vcpu after load of vcore */
> +	lwsync
> +	ld	r4, HSTATE_KVM_VCPU(r13)
> +
>  #ifdef CONFIG_KVM_BOOK3S_HV_P8_TIMING
>  	/* Store initial timestamp */
>  	cmpdi	r4, 0
> --=20
> 2.39.2

