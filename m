Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6106966E679
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAQSzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjAQSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:52:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC0C53B2D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:16:22 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96B1F1EC0646;
        Tue, 17 Jan 2023 19:16:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673979381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LW6ukD3ubgFh26Xl88XtRXuKZEgXnZcA4f8GxTyITek=;
        b=DW74aSfLE1RDzT5FzqyHcyzkbEFPnjuDLVSQoM/gtHvgS0By/CdAf6Dh245vVdpCzadIL0
        Ounp8YWP6/uNn+CIbb0Q9VxJn9eTIQrwLnJHPkL6Q7DcXCqH9sVEPztzPfcWzSi3S1OVid
        02+jRbS5cgdCef6qS+B2LtpjUXfRrpk=
Date:   Tue, 17 Jan 2023 19:16:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, alison.schofield@intel.com,
        reinette.chatre@intel.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 4/6] x86/microcode/intel: Use a plain revision
 argument for print_ucode_rev()
Message-ID: <Y8bl8KVqo/yUG5Dj@zn.tnic>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-5-ashok.raj@intel.com>
 <Y8RWZu/SGYV7Eqst@zn.tnic>
 <Y8bHUpkHknqcq6ti@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8bHUpkHknqcq6ti@a4bf019067fa.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 08:05:38AM -0800, Ashok Raj wrote:
> I updated my build to have CONFIG_WERROR, i had that accidently turned off
> in one of my configs.

You need to build every patch for bisection purposes, obviously. In addition
CONFIG_ERROR.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
