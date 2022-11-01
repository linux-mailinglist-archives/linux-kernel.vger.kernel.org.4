Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13143614762
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiKAKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiKAKDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:03:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EBE193DC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:03:05 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7f5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7f5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFD651EC063A;
        Tue,  1 Nov 2022 11:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667296983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5k44Xi1lhvoXFZWuJ77geE7RpIC/sY84LOFeQpra6ag=;
        b=GOjKx306L15AuDaGxFU7SlrFwAp/GWl71Gy43EsErnqxEmwG+50j/5mQhBBP9TVTTVwvAa
        ozWO3Z+H+NmFcQd2r8Xyz5JNdszPJ2Bq0/FyvMC6tPyb9ViW29URUTlofOqEEDdb+HlXBA
        3wNYQAFtuz8cTYuZEORIPpO9eRyL3R4=
Date:   Tue, 1 Nov 2022 11:02:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 16/16] x86/mtrr: simplify mtrr_ops initialization
Message-ID: <Y2Du0udSWan1VLxe@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-17-jgross@suse.com>
 <Y15o4o8j6zbQuaQJ@zn.tnic>
 <dbd5861a-aa12-ea4f-c076-974613fba51c@suse.com>
 <Y16osqK3kbCz8Sf3@zn.tnic>
 <ee303ab9-90b2-5679-30c0-fd1982cbaad6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee303ab9-90b2-5679-30c0-fd1982cbaad6@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:48:10AM +0100, Juergen Gross wrote:
> Hmm, with the cpu_feature_enabled() implementation it should be quite
> obvious that this is all dead code.

Yes it is. I ran ~100 randconfigs with both gcc and clang and not a
single one failed the build so I guess you can say in the commit message
that it is ok for this symbol to be not present on 64-bit as it will be
eliminated anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
