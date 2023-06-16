Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1369732A28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjFPIr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343576AbjFPIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:47:24 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F6F2D77
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:47:23 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-5161e17f374so2159325a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686905242; x=1689497242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKEKESc4AkV9rAsszbWOey8fmNPkT7FXplfrJZXxX+U=;
        b=IlK980kWCNICjfKrrTBqfNBOy2ngNzKlBH5J8ZNjzAlxzSZ70V5egpF9l/28oI4ihn
         rHIpVYKfGbx+goAV1yFDIhXvhXiDi+q+kiWpT0A70A+7sts7NUSrSm3CXRBmqbWIhg2O
         p3bsdpRMEhqAwrg1OaAPVmb/ob0ogxR1eJf3Jw35PIWLoHZNh/TrJSkTlhmDOCLeulNd
         dhPpfXzEawLi1lRByDz1oo3ixu14ngesajRFQY9lOkY5YYzH/xAdUQS9B2tjqcTnE6Ln
         LilpYOaSFNP49H7VWslhbt8+dSzupEGzi/K7esSAMW3MHq5ao0JUQQlb6HBhy8sYWlLt
         RnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686905242; x=1689497242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKEKESc4AkV9rAsszbWOey8fmNPkT7FXplfrJZXxX+U=;
        b=hLWzSl6QCrv9kptcf7c1z47VaSK/EYI3QIkr6elqEl6KLXgFhFD2zgVm71+pT/UUmI
         8HCDWpZBENw9lX9pQGp9Y8EGKGGkLArh+vTq/7HJVrzocXyV5/sh63ZTmfuzzYFxPQWs
         fiLosJ7yWC2pUABcvGFFq8ea/rFVObY0sCOQCA7AObaChzvNT3wlTBTQk+1t3/VPPkwq
         GXUAHxcVVkr4nj2jjgTXNF43CV+HcTe/6eCRdJcmNxbf+87b0g6RvOxlAykbRxQWFy4P
         aj06th5pJJHUq/UGTkIqQHRe6qzQCc/w3Q6Av0HWixhR5Li9gtcuSp18Qa74dcnlj0RM
         jJzw==
X-Gm-Message-State: AC+VfDxBVx5ND9IQEna6HmsGI4pZg2rC4m3T7hedrbPJFyLofBd3qwVq
        E+JXelpmcwszP+jTxCfaHx/vDvFXsc4=
X-Google-Smtp-Source: ACHHUZ71wc6xWaoy16jUQQ0QE7u0n5tVk0bHOfEkPepBiDCFO23lce+NodeJTR1g4yI9uyG350M0J3i0FZM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2ca9:7c8d:9bb2:b0c4])
 (user=glider job=sendgmr) by 2002:a50:9f2c:0:b0:518:71e4:bf0b with SMTP id
 b41-20020a509f2c000000b0051871e4bf0bmr224527edf.3.1686905242133; Fri, 16 Jun
 2023 01:47:22 -0700 (PDT)
Date:   Fri, 16 Jun 2023 10:47:15 +0200
In-Reply-To: <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
Mime-Version: 1.0
References: <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230616084715.2140984-1-glider@google.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
From:   Alexander Potapenko <glider@google.com>
To:     torvalds@linux-foundation.org
Cc:     dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

>  static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
> -			       struct pt_regs *regs, int trapnr)
> +			       struct pt_regs *regs, int trapnr,
> +			       unsigned long fault_address)
>  {
> -	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
> +	WARN_ONCE(trapnr == X86_TRAP_GP && !gp_fault_address_ok(fault_address),
> +		"General protection fault in user access. Non-canonical address?");
>  	return ex_handler_default(fixup, regs);
>  }

Shouldn't ex_handler_copy() be fixed in the same way?
Looks like it's still possible for a tagged userspace address to be passed to it and trigger a warning.

Alex
