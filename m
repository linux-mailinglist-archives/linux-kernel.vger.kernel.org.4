Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6212E6C9F37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjC0JTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjC0JTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:19:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4977210D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:19:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ix20so7815431plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679908783;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MolT2QPdAbhjDzQm/bW+5V6BH1+c0GF0g3SrhCKOHKA=;
        b=boRoJxiiePoGdvCdmLREQ2NLCH36s3EUqVN2C4z3pHpi2IMY1rNwF3xF9j5nRnX7f5
         X48jP+jdwaaqDx2cfgHf2l4uqfdiyS9Lkde22dpHeo4YrW1tJZ/UbEEeKO0wtx2KHOxp
         DJgAmRZopRrJipcFLG+Fm4XzFOKm3OaxoGsbQ+JCkZOgyYFm5+4aEn2wD9Z1NWS0j95V
         b79qk+KIyXC/3wUAb4mU66z7+ITZSbGtUUZjYAr9zYHqSb1/xCseFLUN2ENHQbS/q2uV
         UnKOtdbaKzt7byVriYPnFaUQ12Xr8w+szmnTtx7Tomp+Z4J6m3CW/kMotsmVikxkv7kH
         MD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679908783;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MolT2QPdAbhjDzQm/bW+5V6BH1+c0GF0g3SrhCKOHKA=;
        b=iAg3GCt0yaEf+/kk8Ms+JE59MzBHX50MXj5JDLqhcBjsPTyGlw0M0GLY8F4Z7GckAu
         EBGIEDuwg0A6E9vvRYqZI+Y/zZ7RSm7T3mXm3WRUFvwx2ko3bHvRol4Q09kqH9136i6i
         A0AZZQ+i2Ki+JSTbSz+xirC/S8AoVTxoduWeeJIRgy8BuLxQm4kY3m3b6kEvBxovT/u/
         FFBtd3lhiNp/qj+mG2OX4xpcEdgKLdpHeJSV7vlj8u6aCKJhg8KxYY1dzwf63/z0/h8u
         41H3chZRybcQbLjW/myp8eUXGxFmYxm+ImtIrErjFL9KvWZJot5W1GGirEmz4nLm4FsM
         7YVw==
X-Gm-Message-State: AAQBX9e749gb+eIX6QjowMm7K0E4LaGnMXU0OJ+9H3jIIIm4OKKfW7lx
        aPcd8kI0qgE+6tJCri6DQHw=
X-Google-Smtp-Source: AKy350bpkiTIiYJBIh+3Ol7ZsDC9NV9ZozK01FgEoyh5sLZVnBmFIhW1jprtAsU+csyCO4WtXMytFQ==
X-Received: by 2002:a17:903:41c8:b0:1a0:57df:864f with SMTP id u8-20020a17090341c800b001a057df864fmr12018706ple.16.1679908783211;
        Mon, 27 Mar 2023 02:19:43 -0700 (PDT)
Received: from localhost ([203.221.180.225])
        by smtp.gmail.com with ESMTPSA id jm18-20020a17090304d200b001888cadf8f6sm18629720plb.49.2023.03.27.02.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 02:19:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 27 Mar 2023 19:19:37 +1000
Message-Id: <CRH1YM72SK4L.QU56WGVQQ2GE@bobo>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] arch/powerpc/kvm: kvmppc_hv_entry: remove
 .global scope
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Kautuk Consul" <kconsul@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Fabiano Rosas" <farosas@linux.ibm.com>,
        "Sathvika Vasireddy" <sv@linux.ibm.com>,
        "Alexey Kardashevskiy" <aik@ozlabs.ru>
X-Mailer: aerc 0.13.0
References: <20230316051025.1424093-1-kconsul@linux.vnet.ibm.com>
 <20230316051025.1424093-2-kconsul@linux.vnet.ibm.com>
In-Reply-To: <20230316051025.1424093-2-kconsul@linux.vnet.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 16, 2023 at 3:10 PM AEST, Kautuk Consul wrote:
> kvmppc_hv_entry isn't called from anywhere other than
> book3s_hv_rmhandlers.S itself. Removing .global scope for
> this function and annotating it with SYM_INNER_LABEL.
>
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index acf80915f406..b81ba4ee0521 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -502,8 +502,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>   *                                                                      =
      *
>   ***********************************************************************=
******/
> =20
> -.global kvmppc_hv_entry

I think this is okay.

> -kvmppc_hv_entry:
> +SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)

The documentation for SYM_INNER_LABEL says it for labels inside a SYM
function block, is that a problem? This is a function but doesn't have
C calling convention, so asm annotation docs say that it should use
SYM_CODE_START_LOCAL?

BTW. why don't our _GLOBAL() macros use these SYM annotations? I haven't
really looked into them.

Thanks,
Nick
