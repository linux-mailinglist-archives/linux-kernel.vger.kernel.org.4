Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFB7613250
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJaJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:14:16 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97773D2E8;
        Mon, 31 Oct 2022 02:14:14 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y72so12953643yby.13;
        Mon, 31 Oct 2022 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S1R1fMBOKcYb7njx4Wi3wo1Rwy9OFYqjtLT3SEE+pGI=;
        b=aFj+RELCQt0CoycGBHDtevOGPrZKfVd5l1RMxIsqbMkZFPpffzEfVFtV/yTqF44TTH
         VyAoU0CHyX+jl674PPdWHUHD41DOwAe+ismLAZreSYyUyM2ewL5wp855Ip+NHL7j3aC9
         uD5zBBHezXL4oXIgBh8tOJsPl3GHygDx4t1rvIuh7kTWEPYjyo+8stNbOTg5rp6vQdyO
         8gUONfr79u/pIIMqCLBirliq/Acx1jMpp5QJuGHQK0LNDjg7qDecsqYt5Dv6yGNVcp0z
         MoVlmqxdzZxvAKBuzmvXS49oKmG8nNHdGVpkVKZDwl28Jate5vvwccdSe2V0RLHSz0vf
         /eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1R1fMBOKcYb7njx4Wi3wo1Rwy9OFYqjtLT3SEE+pGI=;
        b=kAT7GFTecs1iF2/6eaRB5o34ov82PiMCVi1urSaYGb9pPBIjJe58bTslpWVRm+xTF/
         fTX1Y7I4lhVGreIe0zQ77jpYUDAV9sFfMhHoUDdOeUKhUbPIclK5unRY+0Bze4IXoTEA
         BlN2a+aJVALgWof0/a91/Mbok/78gQKKKotSpxmUG4GyqeUGfjXRdJPwF+jG0ryOg61t
         gNk7FMbqJyxhmGRYSn08ZYqiEuPRcZbmsONHCikLJT/Hlk8cBLG5VXYbQb8sG5D9fqr2
         7h+ioVPDinO9VOHEG7rrI0pNC9vTy1mp8VcRrC5z7b0CsS+MRcMAIyFiSgJRV4bp4UzL
         55Rw==
X-Gm-Message-State: ACrzQf3uZmD2WxHXgndtp/9y/L5uke6f8EoRVuYgS5x8Bcf+mRD+dU/B
        38+juoquuD+lvTQpGmzKO3BI1apVsB/pQz6SMKoCkcI25+0=
X-Google-Smtp-Source: AMsMyM7Ytg5fltw1gCmSbQTde0UToP+AHorUjvASB8eOk31HZcwZ619y/AWTaGtZJ9cSBduqwDEmKjJPqnZ9TqasDMg=
X-Received: by 2002:a25:3407:0:b0:6ca:88e8:6f63 with SMTP id
 b7-20020a253407000000b006ca88e86f63mr11827883yba.175.1667207653726; Mon, 31
 Oct 2022 02:14:13 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 31 Oct 2022 10:14:03 +0100
Message-ID: <CAKXUXMx3cgTA66h_ezNTqyVo_Oa-Q0H=FeBM64zntZ4E0YCT6g@mail.gmail.com>
Subject: Reference to non-existing CONFIG_X86_FEATURE_CALL_DEPTH
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas, dear Peter,

in your work on call depth tracking mitigation, commit 5d8213864ade
("x86/retbleed: Add SKL return thunk") on linux-next references the
configuration symbol CONFIG_X86_FEATURE_CALL_DEPTH, which is not
introduced in any Kconfig file.

Is this just some left-over from some previous iteration of this
feature or is there still a patch to come that will introduce that
configuration symbol in some Kconfig file?

This issue was identified with ./scripts/checkkconfigsymbols.py.


Best regards,

Lukas
