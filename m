Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56A0619C28
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiKDPwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiKDPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:52:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B89D2D76F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:52:15 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e72b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48A651EC04E2;
        Fri,  4 Nov 2022 16:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667577133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E88KeN+r7eH5e6S++vjQnVsbeMK466eNNQGc81FxLN8=;
        b=eJmtd7Rno1wRB50xi64SefPI8W0lvvpTlxRogc8oIhmkYS97siyFdJjz2xAW0Tj6QcHLV3
        HbIkafC/BfJArgyugSDiKnjDoFuigRGx/qJIw301GqiMFiHlOCQ92veMuEHImN80qb+OUr
        h+TjkOJeGjuG21tscmMaQZQevOopH/M=
Date:   Fri, 4 Nov 2022 16:52:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Message-ID: <Y2U1J2NbGNjYUbjv@zn.tnic>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com>
 <Y2Tw2+LCmZe8XBJn@zn.tnic>
 <DM8PR11MB5719A5BB1C56D442F0E25544923B9@DM8PR11MB5719.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5719A5BB1C56D442F0E25544923B9@DM8PR11MB5719.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:53:22PM +0000, Van De Ven, Arjan wrote:
> so I think by all means, if life is simpler, stop doing complicated
> things for mixed stepping

Ok, that's cool. Lemme put it on my TODO to remove the cache.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
