Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB068DD4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjBGPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjBGPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:47:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448F7EF9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:47:39 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 311211EC03D6;
        Tue,  7 Feb 2023 16:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675784858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YsE5HwQMUDrzJ76Vw3Lqw6bgPowWoKGwItHq+J3fGf8=;
        b=m6/mbO12myHd77TmFuTEimv638+JLuKdFV5YD9WZ2/9pRBiUy+tcHtcwXUFmN0OqaGwT31
        +nCVkU8eWYGTo+Kp+P7N4kbN//14jNyenxn2wpg7Nbee7Eq06LOMup4mzE9tI6Aw75rupM
        fLsw7ZDd8L8ye6a5Jv/KvMp48tEkT+c=
Date:   Tue, 7 Feb 2023 16:47:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, x86@kernel.org
Subject: Re: [PATCH 2/3] tools/x86/kcpuid: Update AMD leaf Fn80000001
Message-ID: <Y+JylWCLMA6mK7G0@zn.tnic>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
 <20230206141832.4162264-3-terry.bowman@amd.com>
 <Y+HKRLN//GnP0c5r@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+HKRLN//GnP0c5r@feng-clx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 11:49:24AM +0800, Feng Tang wrote:
> I'm not good at naming :) and you may find better names.

He's using the official PPR doc names so they'll remain like this so
that they can be found in the respective doc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
