Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7261A213
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiKDUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:21:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0524B9A6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:21:52 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e72b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B90511EC01D2;
        Fri,  4 Nov 2022 21:21:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667593310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PLBrkhUU/4M973QoFp5Vn+YXc1FnvZBpjagiJw9OaGE=;
        b=KSAin9RaJOHxlb4o4cuSjtpUvR0LXLfV42Os7QTQ8uh8C6wORD7pF1PI8tBCR98cTkUI9m
        ZgyQ6bXi4m+WLAYCKT2U9v0pDEvJaw0N1RaKqoeOPOqhu8qYcpAS+xaJFr8Nvqkl7cu08I
        M78Yk22C8pgJSZ5VI1DCX4FhgyvBAcU=
Date:   Fri, 4 Nov 2022 21:21:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
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
Message-ID: <Y2V0XkHcWHMQVTL7@zn.tnic>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com>
 <Y2Tw2+LCmZe8XBJn@zn.tnic>
 <DM8PR11MB5719A5BB1C56D442F0E25544923B9@DM8PR11MB5719.namprd11.prod.outlook.com>
 <Y2U1J2NbGNjYUbjv@zn.tnic>
 <Y2VZ1OSJkwJPnRa8@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2VZ1OSJkwJPnRa8@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:28:36AM -0700, Ashok Raj wrote:
> Wanted to add a check every AP that if its different fms+pf warn 
> and bork late-load.

We don't need that check as we don't/won't support mixed steppings. It
is as simple as that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
