Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871576C7D97
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCXMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjCXMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:00:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5BB23DBA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:00:27 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F6B51EC0541;
        Fri, 24 Mar 2023 13:00:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679659226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BlnMF+P08ZIVicLwVP2UU5prUkya6K4FHSB2CoG1zy4=;
        b=KzQDMS+YWNqzKnULW0jYzVEIo4zSB1nuTMhGp2XDUz91J8gpUxe7Mfog4KLkEC1viZ1Yme
        WqOsABFDYVifgpAeAYLJLZ2aYhgUvjG0jN0Jac5DLGpisMXzWoDREsYnuzNMqjJpfgRF2g
        XgyS0bX6e1i1hNyvzJRuBsMcD9JPwWg=
Date:   Fri, 24 Mar 2023 13:00:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: move @microcode_mutex definition near
 usage
Message-ID: <20230324120019.GAZB2Q09ODVq0iYz5l@fat_crate.local>
References: <20230324114720.1756466-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324114720.1756466-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:47:20AM +0000, John Ogness wrote:
> If CONFIG_MICROCODE_LATE_LOADING is not enabled, the compiler warns:
> 
> 'microcode_mutex' defined but not used

How do you trigger this? I haven't seen this until now in my builds and
CONFIG_MICROCODE_LATE_LOADING is not enabled here either in most
cases:

CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
# CONFIG_MICROCODE_LATE_LOADING is not set

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
