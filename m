Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9939F61FDDE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiKGSrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiKGSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:47:43 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158D726AEC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:47:42 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 879CC1EC059D;
        Mon,  7 Nov 2022 19:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667846861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hvy8p5RGi1HhUXtrGDGy2TmEz7qeOKmwH2yxv/k8pu8=;
        b=pYrgSOEHT+61S3B4CG1vRVdTMldWIIIJBlKvM0z1iMjSQVnzI7TFKGJAb4O2Iw8DgM+DBg
        2UV49E13lKE1cvTyTiDSe/JSVr12cNVy4zLU1xaBiN/7bOie9xKKjY21TumNZBYA6XCnSB
        nej87gY+f3Iu5+8mjNnZJFH0p12iMIs=
Date:   Mon, 7 Nov 2022 19:47:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Message-ID: <Y2lSyX+YS51dxAnr@zn.tnic>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com>
 <Y2e4PgwAEXuFzoMd@zn.tnic>
 <Y2kuixb0RU9BxKls@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2kuixb0RU9BxKls@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:12:59PM +0000, Ashok Raj wrote:
> Only missing is the ucode date, not a big deal missing it.

Yes, it isn't. One can find it out another way:

$ iucode-tool -l /lib/firmware/intel-ucode/06-9c-00
microcode bundle 1: /lib/firmware/intel-ucode/06-9c-00
selected microcodes:
  001/001: sig 0x000906c0, pf_mask 0x01, 2022-02-19, rev 0x24000023, size 20480
  					 ^^^^^^^^^^
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
