Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61FA65981A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiL3MU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiL3MUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:20:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA2DE07
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 04:20:24 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 172501EC0646;
        Fri, 30 Dec 2022 13:20:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672402823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XbjhtCzmBuKClpJ12KpNl7yxa4Nb3qmuGtg987L0dbM=;
        b=QQcNSCfJaF6nByZk/BthumzUe8G1r96tmQMFC1B9tTStdfWCoap+wqERvCjQ+K7ZsAy7cL
        c4nS44EL7FOCmuHLrkezJhvak4+ZEhZcdAu1+Ha96SrtbAOAxpWH3LrjbtY0Xm1u6wVAcu
        7ylC395/7iDZhLVuAos2C4Hh0E8GYI0=
Date:   Fri, 30 Dec 2022 13:20:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
Message-ID: <Y67XhpYQLfmnWAkN@zn.tnic>
References: <50aa72a7-043d-8091-78de-458cbcc6c356@huawei.com>
 <Y6w49Y1d3lpv3KFn@zn.tnic>
 <23e2907c-5188-5ac6-3db8-1c5a12120bf2@huawei.com>
 <Y62vbjBzHF4rmh1V@zn.tnic>
 <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e041533c-4005-b9bc-3985-02224985aa28@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 09:49:50AM +0800, Miaohe Lin wrote:
> Many thanks for doing this. :) But it seems it's not the matter of gcc version. Somewhat confused...

Yah, it works fine with gcc 7.4 here. (7.3 has trouble building due to
some ustat.h changes they did).

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
