Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080686030D5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJRQfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:35:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20032D57ED;
        Tue, 18 Oct 2022 09:35:35 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c1329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c1:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A82B71EC058A;
        Tue, 18 Oct 2022 18:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666110929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MK7s91/Zyno/A7R7+trDZq+um5qPirik4WDLX1E0kRY=;
        b=eKBvdFf9FeT/+yzL0Tbt13jNhATTz8GL1W+tAi1q2pgdeEDTA9CfJV3kQVL0udWGidM5yC
        295shfvHE/i5h3UPyqQlzwNNTtYoQF1iB9pMi8MTCB4q322FWy2hPSbh5oljD/qXkiKFmj
        oTOrgZSGUNgoa4f/sGG9TJ9UZvGR/jY=
Date:   Tue, 18 Oct 2022 18:35:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, fenghua.yu@intel.com,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 0/2] x86/resctrl: Fix min_cbm_bits for AMD and code
 cleanup
Message-ID: <Y07VzWTRpSnpbuc2@zn.tnic>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
 <703e6dfd-68d6-6def-183d-fb99b39692b3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <703e6dfd-68d6-6def-183d-fb99b39692b3@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:26:41AM -0700, Reinette Chatre wrote:
> Hi X86 Maintainers,
> 
> Could you please consider this fix and cleanup for inclusion?

Sure.

From the looks of it, the first one needs to go to stable, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
