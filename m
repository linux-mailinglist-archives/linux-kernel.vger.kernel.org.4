Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86E7670D26
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjAQXUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAQXSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:18:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E13953E52
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:06:35 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B39901EC064C;
        Tue, 17 Jan 2023 22:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673989593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i4v5pPtoNd3NXTSfSSFgpzQLqhMSEEbN/hBuRXxqxjY=;
        b=apm68FzlQVgWjjXMmt1NBGvMLLO37E7VrJtwka6Sjy/Zkc3Ru0KBjbQZOWnPUT1mc+4fFe
        in9x0vH1Wi9h6en2R3IEsVZAp/i/Kr9djxnU+H3LY9wyq56dVWKlp9RlA7JvwZ/JeZexqo
        M5S3oVLz9b0hXctrWqnILjHFW+NX5cU=
Date:   Tue, 17 Jan 2023 22:06:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8cN1QcAq6bzK09J@zn.tnic>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
 <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
 <Y8brnyIltcgtUvPn@zn.tnic>
 <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 12:40:30PM -0800, Ashok Raj wrote:
> We just agreed to show both failed and success for late-load.

Did you read the part you snipped about getting false/misleading bug reports? I
doubt it, as usual.

If you all Intel folks want to deal with people asking why is there a warning
message about microcode not loading successfully, I don't mind forwarding you
all those messages. I sure ain't going to deal with them.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
