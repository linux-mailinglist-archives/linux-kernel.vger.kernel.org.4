Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D729666FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjALKkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjALKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:39:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305996586
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:34:16 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 824171EC04A9;
        Thu, 12 Jan 2023 11:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673519654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CJ1uL2ZqSBbV653T/Ui6KWFShGRfcaqwoq4TgOsz5Q0=;
        b=PciC4Qa5czY4g5t8Yzc7JIAhA6koQP0Ox6MVVEXSKlsBLa8JSZmEb/nmDHtJpIZSynNnfR
        TxGIJuX14Rz6hmdaXwSy9qWrKlCVjGbSsY9bWR0N18MdQddWRJtPvXclfvh7dPkz3Oa8JB
        D9qiK40XVjjAhDtmWAbkS7t9AvtbAk8=
Date:   Thu, 12 Jan 2023 11:34:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        jpoimboe@kernel.org, peterz@infradead.org, x86@kernel.org,
        cascardo@canonical.com, leit@meta.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y7/iIKl/F8MOrVdD@zn.tnic>
References: <20221128153148.1129350-1-leitao@debian.org>
 <Y76wtwWN1+XPbnQx@zn.tnic>
 <20230112070037.q6cg23tn57onmxfi@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230112070037.q6cg23tn57onmxfi@desk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 11:00:37PM -0800, Pawan Gupta wrote:
> > SPEC_CTRL_RRSBA_DIS_S is a disable bit and I presume it needs to stay enabled.
> 
> The mitigation is enabled when this bit is set. When set, it prevents RET
> target to be predicted from alternate predictors (BTB). This should stay
> 0, unless enabled by a mitigation mode.
> 
> > Only when spec_ctrl_disable_kernel_rrsba() runs. And I'd say perf-wise it
> > doesn't cost that much...
> 
> I guess this doesn't matter now, because this patch is resetting it by
> default that keeps the mitigation disabled with no perf impact.

Ok, lemme queue it then.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
