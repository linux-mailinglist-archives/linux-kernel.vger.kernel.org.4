Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6117A657690
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiL1Mj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiL1MjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:39:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F0C10FE9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:39:23 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5597E1EC0513;
        Wed, 28 Dec 2022 13:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672231161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mTWvnWcirTG+NM2iKSdJUllkFJ8BMZc8IXGYPsrmL6M=;
        b=dGEo52gvVAXDFt7SGqhlHrrLHoUyaaUCE3L+KNIbgl/cyR8o5k/bdD/4XE8hpJtTsDsRT+
        Q7V6iaUaBqhJJMgWY/PiFcoATeJ3xSKMcZnC0PfG84or2esl6LoOVsh3SDmyXFcChMvdIJ
        eBctH8eeQDnpDO82rgJHmuVz8jFJxYA=
Date:   Wed, 28 Dec 2022 13:39:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
Message-ID: <Y6w49Y1d3lpv3KFn@zn.tnic>
References: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 08:31:32PM +0800, Miaohe Lin wrote:
> When I compile the mainline kernel v6.2-rc1, the below link error occurs:

Pls send .config.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
