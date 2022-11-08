Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AB621BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKHS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKHS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:26:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5191A205;
        Tue,  8 Nov 2022 10:26:45 -0800 (PST)
Received: from zn.tnic (p200300ea9733e764329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e764:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2D4C1EC0430;
        Tue,  8 Nov 2022 19:26:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667932003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xV9kq2V65qP92kMAdBg5DoabymWiR9bvJmtPCmwsYeI=;
        b=NkPof5Wp3WHExxtTrgqt1pljeIyQG5JQEZo4/zi7nQZaglZZD2OADr3b6c/iYI0mIkgf3p
        doZKsX70aytdrC6Os4V5dLm9s9f6eiWb7CMkRtrTnexI38DvTSH3Ggvpb5kZW9dGERWh05
        ES931iCOkl2/iMlJB9FqrEKdq8awd6I=
Date:   Tue, 8 Nov 2022 19:26:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 0/3] Check enumeration before MSR save/restore
Message-ID: <Y2qfY81OphcVRbUk@zn.tnic>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <aa8f5b80-b94e-b685-ed65-8b9c8f453832@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa8f5b80-b94e-b685-ed65-8b9c8f453832@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 07:16:00PM +0100, Hans de Goede wrote:
> What is the status of this series ?

Lost in the avalanche of patches. ;-\

Will take a look tomorrow.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
