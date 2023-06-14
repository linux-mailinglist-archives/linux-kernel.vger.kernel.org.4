Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519D07307FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 21:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjFNTTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 15:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFNTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 15:18:50 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D541BFD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:18:49 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-652e21cc2c4so4225794b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686770329; x=1689362329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPKanxiBz67MTOGZ6C1wWD1MIN8AmxZs6PIsNaJPo/k=;
        b=2b35H2EI2Uhr3oCVSA3dfT76JSHV79e/rRpmzBVn/NveTxgY+oQ4Z3cHntI5SMdIr+
         H+0W3RoWD/hOHvZI6pwMDswguSTQZj9PdgfpEoY7McRYIXmG00VVYvHg2dRDA7FA1NSn
         YonbFXUt3+Bzz6ghemncbH3Xk3PbgdMLqozOIjxaoNPcUB0IRKEVK82LgYTIW+nO/4Zj
         D7YXN8bHLXoBKpamshrVaBYffhGY7JaOOxVuqCCkNjeQ6WhgabHlVmyeV129UISR/1Jt
         Z6wc3AUEzSpMifiPQnLlyTxIJbeCdeK7miJ6dv0WFaeEHBiadnFKjaLoFbf0VjVVOMmw
         4jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770329; x=1689362329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPKanxiBz67MTOGZ6C1wWD1MIN8AmxZs6PIsNaJPo/k=;
        b=SX+dcAGmEm6olRJrqz8AWiaYkRcbzwiFEyr0ECOaG1WBrZjdmAb9hohgCO9AgEEyox
         PoB9G3iFQ4BSMIV5gNADo1CFsj42IDo+S/vpNDmZsBKB3bDpINl5BZcFMUyCWoFbEj+O
         Ka9vjio4mL4+rGrHpyJDon8TOdtdgBtwHyTBvucrc0OyVn6BfRhkEpS10MUzXYt+Vat4
         7kqyIEBIz8eCyadBrSeE1k1OpaB2PglpY8dZik/Z1bcmi6DxiL3B6uD+20YzNamy5YlA
         4kFgABvyyad1oomxJ5NlS+ERMZzYSol/CWW/a4UvFjWNxfc1GIsGbYpsB55pc7HPJKOO
         hz+w==
X-Gm-Message-State: AC+VfDxV8dABiGyZA45qX19msCa7NW6vVg5v42N9FzUWjOJVGU1T+1Rd
        nXn5CL3X8kkMBCj+vuvZW8QNWv45Iow=
X-Google-Smtp-Source: ACHHUZ7a0S3m57gSNG6MEVz2ngzegpGCQysuvTAMrpYS0GNy9uEmx3S5R4tyubdf4e8mNn+n8ZHyIaClQ8c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a0b:b0:651:cea6:f786 with SMTP id
 g11-20020a056a001a0b00b00651cea6f786mr878790pfv.6.1686770329209; Wed, 14 Jun
 2023 12:18:49 -0700 (PDT)
Date:   Wed, 14 Jun 2023 12:18:46 -0700
In-Reply-To: <a2510fb15553a294236646321cf1b3a4@208suo.com>
Mime-Version: 1.0
References: <20230614032736.13264-1-luojianhong@cdjrlc.com> <a2510fb15553a294236646321cf1b3a4@208suo.com>
Message-ID: <ZIoSlrXifl/ikSBC@google.com>
Subject: Re: Fwd: [PATCH] KVM: x86: remove unneeded variable
From:   Sean Christopherson <seanjc@google.com>
To:     baomingtong001@208suo.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Dave, -Ave

scripts/get_maintainers.pl is your friend.  It avoids typos (well, if you wrap
it with scripts instead of copy+pasting), and makes sures patches get routed to
the right folks (KVM x86 patches are routed through the KVM tree, not the tip tree).

On Wed, Jun 14, 2023, baomingtong001@208suo.com wrote:
> fix the following coccicheck warning:
> 
> arch/x86/kvm/emulate.c:1315:5-7: Unneeded variable: "rc".Return
> "X86EMUL_CONTINUE".
> arch/x86/kvm/emulate.c:4559:5-7: Unneeded variable: "rc".Return
> "X86EMUL_CONTINUE".
> arch/x86/kvm/emulate.c:1180:5-7: Unneeded variable: "rc".Return
> "X86EMUL_CONTINUE".
> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>  arch/x86/kvm/emulate.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 936a397a08cd..7a7e29e4e203 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -1177,7 +1177,6 @@ static int decode_modrm(struct x86_emulate_ctxt *ctxt,
>  {
>      u8 sib;
>      int index_reg, base_reg, scale;
> -    int rc = X86EMUL_CONTINUE;
>      ulong modrm_ea = 0;
> 
>      ctxt->modrm_reg = ((ctxt->rex_prefix << 1) & 8); /* REX.R */
> @@ -1199,16 +1198,16 @@ static int decode_modrm(struct x86_emulate_ctxt
> *ctxt,

Please resend, unless mine eyes deceive, this is whitespace damaged.
