Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA306A5F89
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjB1TUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjB1TUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:20:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F5722A3B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:20:08 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF1B71EC04DA;
        Tue, 28 Feb 2023 20:20:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677612006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=neQF+eWVE8BPA56holB8mYEJRUeH5AJhb8IFz5+zpAc=;
        b=pfWyXHuTLAvhWvJr74UYSV7LRYlk2OxtG/PT/SItQ2oHsiH/VLnOowfGHBoPgDKk4RgUT0
        EKRlReOjhZxhax0xN3z03NvIh8hd585ZTVhadJfHc37C+qGYlIlaRKh7Ohjd4ertIr8Yxe
        qQMvKx8YVbXGAbqLBGZ3CjawLJQZAnU=
Date:   Tue, 28 Feb 2023 20:20:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/5T4ScbM/99DhgT@zn.tnic>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic>
 <Y/Xc+yMzI83WZ4V1@zn.tnic>
 <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com>
 <Y/Xp73KJe3c/1jrn@zn.tnic>
 <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 09:47:22PM +0300, Alexander Monakov wrote:
> I've seen microcode version increase after a BIOS update,

Are you saying there's no BIOS update for your board?

Are you running the latest BIOS?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
