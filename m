Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B26229B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKILJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKILJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:09:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75D412D37
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:09:32 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7e8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7e8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A9E21EC03B9;
        Wed,  9 Nov 2022 12:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667992171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=54ULT7V7UOlPVP4iMSFW5vtQJ2zoe725RdCJprKvfo0=;
        b=oCaxGZnayNrhKhuXERPU8OomfK30qUBlVFLhUNigucPS8bTEOUbU+eK0h1ODr8GgFRoK9W
        uyXt3gX4SW37UtxiIMZWu/+PGDmvg1Oqwk4MuuNfV2tnRpjl0OcpEaRcIELwJu0tfRjZrV
        dULoREYuJTZrrh1QM/fIcgk/nuwh8q0=
Date:   Wed, 9 Nov 2022 12:09:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>
Subject: Re: AMD uncore kmemleak
Message-ID: <Y2uKZ0InNUzsC8oT@zn.tnic>
References: <Y2uGZL1ou+JGu2mh@zn.tnic>
 <80ef6f5d-52b4-38ee-d161-27743211f902@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80ef6f5d-52b4-38ee-d161-27743211f902@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 04:33:59PM +0530, Ravi Bangoria wrote:
> I guess this should fix it:
> https://lore.kernel.org/all/4fa9e5ac6d6e41fa889101e7af7e6ba372cfea52.1662613255.git.sandipan.das@amd.com

Cool, lemme run it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
