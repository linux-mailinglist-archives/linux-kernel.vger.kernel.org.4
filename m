Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F5723CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjFFJMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjFFJMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:12:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD43197
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:12:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b04706c974so50801285ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686042734; x=1688634734;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33Fi3vxPpajECwlEk7e4drhNdlJkHqysepyRL3vjQ8k=;
        b=IlaMjUX2DEWSf62zBCcuw3sQibn/by5NfD7SCt0RqJD+KB8TcuJ18M+bnqtdWaWu6u
         iK26B/FnL9uq9zIbXeiGrrUp2yUuevhPXiQA2d0mTd0/e8xg+q8W0slYwwwWbu9Vbfij
         jSO85lmr/pYGkyBjW0xBauNQhLNIy63rRVjavAociiYC2p/m3gZRBi4mYpq1C3mLArVp
         kJsK+swdwSRCFQmGc1r7mybeBW2UhyomKrlRCwzIacgde2VHyS6Nhc/VIYHxisRkj454
         GjkSCrovXZ+GsBOnQaT08XHHOL236QhQ3DwHtrLLGAqy/WTNRIhaQQZyV72YNzJ6pPwN
         NxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042734; x=1688634734;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=33Fi3vxPpajECwlEk7e4drhNdlJkHqysepyRL3vjQ8k=;
        b=blOLTyiisZhRRDIoPt+vyYOAKskYt8tgLbQWBcT44frP+GbTyTKd+Y1czyMMZ1bgxH
         s5gEUHdlKLi+ypuMDSyOJRHOGsADVqB4muinpErBm3qQXi1uHc22Hmxjh5EOyy0QJoNJ
         i2JsmNzU0vbr0u3LsR410NCSarn7lN+WMjE9P1fVMxoG3iF/WD9zY88N3hi4l5eyyE8M
         wdKcx9M6YxPZaw5bgtg9Fv94T+SHdeFPey9KZtvlm5lXpIq6iLSZ7k2eQ+Jy1Q2Rqo6X
         SdTQf/4lpPZoLCOMlQy++pio8kLiYV2fTMbQikm8mjHbo8IDEU8HkuzEwmuyHJFDPGvn
         gzgg==
X-Gm-Message-State: AC+VfDy3iOXkASNACFrYQIEiut7V1+l87TRG/B74tnx+03D5DkwHTD8m
        dvSC4ovOEdKaJ32UXiUu2st4iY9X8ITenQ==
X-Google-Smtp-Source: ACHHUZ54UH5/TGSxl0D32cNUSfJOXlgchtr7h6tK2bzJH50CbEBIfIcQ9/fVSaut+FV/AFQi/bLWMA==
X-Received: by 2002:a17:902:e5c4:b0:1ab:7fb:aac1 with SMTP id u4-20020a170902e5c400b001ab07fbaac1mr1848442plf.24.1686042733831;
        Tue, 06 Jun 2023 02:12:13 -0700 (PDT)
Received: from localhost (58-6-230-127.tpgi.com.au. [58.6.230.127])
        by smtp.gmail.com with ESMTPSA id ik4-20020a170902ab0400b001b03a7a40e7sm8107255plb.19.2023.06.06.02.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:12:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 19:12:08 +1000
Message-Id: <CT5G9KKH2R25.3QSRZU8EQXUZU@wheely>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/4] powerpc/kuap: Avoid useless jump_label on empty
 function
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.14.0
References: <1a3c69e38349b687c6c65240d7c09a7817a797d8.1685963081.git.christophe.leroy@csgroup.eu> <c2c9660cc4441dc37c477ce5cf60707c971bd2a1.1685963081.git.christophe.leroy@csgroup.eu>
In-Reply-To: <c2c9660cc4441dc37c477ce5cf60707c971bd2a1.1685963081.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jun 5, 2023 at 9:04 PM AEST, Christophe Leroy wrote:
> Disassembly of interrupt_enter_prepare() shows a pointless nop before the=
 mftb
>
>   c000abf0 <interrupt_enter_prepare>:
>   c000abf0:       81 23 00 84     lwz     r9,132(r3)
>   c000abf4:       71 29 40 00     andi.   r9,r9,16384
>   c000abf8:       41 82 00 28     beq-    c000ac20 <interrupt_enter_prepa=
re+0x30>
>   c000abfc: =3D=3D=3D>  60 00 00 00     nop	<=3D=3D=3D=3D
>   c000ac00:       7d 0c 42 e6     mftb    r8
>   c000ac04:       80 e2 00 08     lwz     r7,8(r2)
>   c000ac08:       81 22 00 28     lwz     r9,40(r2)
>   c000ac0c:       91 02 00 24     stw     r8,36(r2)
>   c000ac10:       7d 29 38 50     subf    r9,r9,r7
>   c000ac14:       7d 29 42 14     add     r9,r9,r8
>   c000ac18:       91 22 00 08     stw     r9,8(r2)
>   c000ac1c:       4e 80 00 20     blr
>   c000ac20:       60 00 00 00     nop
>   c000ac24:       7d 5a c2 a6     mfmd_ap r10
>   c000ac28:       3d 20 de 00     lis     r9,-8704
>   c000ac2c:       91 43 00 b0     stw     r10,176(r3)
>   c000ac30:       7d 3a c3 a6     mtspr   794,r9
>   c000ac34:       4e 80 00 20     blr
>
> That comes from the call to kuap_loc(), allthough __kuap_lock() is an emp=
ty
> function on the 8xx.
>
> To avoid that, only perform kuap_is_disabled() check when there is someth=
ing
> to do with __kuap_lock().
>
> Do the same with __kuap_save_and_lock() and __kuap_get_and_assert_locked(=
).

Too bad static branch nops can't be eliminated.

> diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/incl=
ude/asm/book3s/64/kup.h
> index 54cf46808157..1b0215ff3710 100644
> --- a/arch/powerpc/include/asm/book3s/64/kup.h
> +++ b/arch/powerpc/include/asm/book3s/64/kup.h
> @@ -297,15 +297,7 @@ static inline unsigned long __kuap_get_and_assert_lo=
cked(void)
>  		WARN_ON_ONCE(amr !=3D AMR_KUAP_BLOCKED);
>  	return amr;
>  }
> -
> -/* Do nothing, book3s/64 does that in ASM */
> -static inline void __kuap_lock(void)
> -{
> -}
> -
> -static inline void __kuap_save_and_lock(struct pt_regs *regs)
> -{
> -}
> +#define __kuap_get_and_assert_locked __kuap_get_and_assert_locked

Maybe leave in /* __kuap_lock notrequired, book3s/64 does that in ASM */
? Seems okay though

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
