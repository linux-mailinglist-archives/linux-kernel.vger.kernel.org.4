Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0886A6932
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCAIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCAIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:54:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE927D42
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:54:21 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 811471EC0681;
        Wed,  1 Mar 2023 09:54:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677660859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h9OzoO8BwJRWdt8QQxNJzzTsc9R3SK88Pzp09E1lOCI=;
        b=e0h2jbtA1ThBQcIjHR4sOfcO0HQsXLZDydvBdPiH2w+IKHkbIR/ccYeqErH9NgM4WwHfOw
        f1zJsewybeM89b7xOW8VjnuWpcz9cLeS2xxfZ9Lx5n0lUut9IqMlc75JL84Q1pjSEFFPDO
        Ia55om2jfrj5Qh/hxi61PkGeEqij59Q=
Date:   Wed, 1 Mar 2023 09:54:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/8StpL8atNwyzip@zn.tnic>
References: <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com>
 <Y/Xp73KJe3c/1jrn@zn.tnic>
 <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru>
 <Y/5T4ScbM/99DhgT@zn.tnic>
 <3d007f98-a42a-3c0e-8d6a-c86c5d0e25be@ispras.ru>
 <Y/5VIECduoyCJKP5@zn.tnic>
 <4d21fe93-7b77-bf5a-9ba8-645256ab0983@ispras.ru>
 <Y/5qbJgwHhkrMQqr@zn.tnic>
 <7ce3ea01-9758-0a97-e810-2bf38e7d59a7@ispras.ru>
 <2eccf8e2-4aa3-dcda-064d-ca39d2295548@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2eccf8e2-4aa3-dcda-064d-ca39d2295548@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:23:01AM +0000, Andrew Cooper wrote:
> So we need a table for all Zen2 parts of ucode revisions below which we
> force hide XSAVES as the erratum workaround.

Working on it - stay tuned.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
