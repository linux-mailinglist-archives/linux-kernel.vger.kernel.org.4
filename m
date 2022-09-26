Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620265EAF53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiIZSMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiIZSMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:12:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A191EAFB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:00:01 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e74d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e74d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 349A81EC01CE;
        Mon, 26 Sep 2022 19:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664215195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aaQPbG0xc8cO8CY+sDVDBPoIq1DASoXAvqG8pMdSfu4=;
        b=iNWiwo0aB86gJNicJ8bbb5zo1rLFMMbpHq9XPRP04SBXnroKgkd1G2sC3NBPuFsklzNEKf
        Oh6mu9ITQZGbpkQXB48T0xEO2R8Qy4HnxgoGsPvjRr+66+7XVto7p8AAyV+wP1To+Z0obi
        fc9GmAw6X+XIp0gu/P6ZkY4OxXDyGN0=
Date:   Mon, 26 Sep 2022 19:59:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Li Zetao <lizetao1@huawei.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        brijesh.singh@amd.com, michael.roth@amd.com,
        venu.busireddy@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/sev: Remove unused variable "err" in
 enforce_vmpl0()
Message-ID: <YzHolgTqAl9Cptmp@zn.tnic>
References: <20220923113209.3046960-1-lizetao1@huawei.com>
 <Yy2kU7lZuArVMC5p@zn.tnic>
 <b02f72c5-636d-2d4f-98d7-bf3741e38e5d@huawei.com>
 <YzG72ynMieCUaHVM@zn.tnic>
 <BA9F2C10-DC7F-49F9-B1AE-D58D690A5291@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BA9F2C10-DC7F-49F9-B1AE-D58D690A5291@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:52:08AM -0700, H. Peter Anvin wrote:
> The boot code really needs to be refactored, especially that the
> real-mode BIOS code is built in the root of that tree.

You're going to have to expand on that a bit and give more details as to
what do you mean exactly. I think you mean arch/x86/realmode/ but I'm
not sure...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
