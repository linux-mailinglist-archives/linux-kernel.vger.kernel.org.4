Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69B473A11A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjFVMnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFVMnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:43:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25267DE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:43:02 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 427581EC034D;
        Thu, 22 Jun 2023 14:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687437775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ckL+0W8wwqe6hcLw5YdMaba45+dh8m6sZiMEuqZIYLU=;
        b=gRDNcxNdXvjh6yYaYGTmVMEzJ/Ut54uYeYRYibrpFUoi4E98Nd6ouPyE3Vd7XNvRmWk6Be
        T8iePPn+hQGw3gmj1JmHvmG9q8mroxhD2anQWiWN8TQ9/Kqa3uLJh9D4uCdr3kRKNlM0oF
        XEt6qFLiUB0LCC5dFw/z5zmE1c28F+U=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id obzi4Wo7Boeg; Thu, 22 Jun 2023 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687437771; bh=ckL+0W8wwqe6hcLw5YdMaba45+dh8m6sZiMEuqZIYLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xue+gHR1QPJ2wYg8jr7xR9okfC58hkbn2tvo39jjOyepO6nWT5xkM8C86a7JslksA
         fWrxd1j5BYwfQCq5/ltiyUPwz7wUmOuvwdac+ZBk7Pq/Z7QB5LFgkAJNwhEf46HJot
         GsEuAAimTdl59U1lS2VCiaRpFp8E6Zoa6+LSf2UzUIKhmxZyXvLc2QZAl1XhmvGBzP
         pJ2OZLzXJpVPogfAKdwN5UgEJky41c8Un6/sneDHV2WYsV2m7caZeF56oalkxmGEeV
         0IWCcePJOmsiBOj1E7JP6plqIYp9iUeuItxtxLM93NSfEGIWU98/SLJ3qDEWi0NwqO
         Vfh3hjA5pErizMMxfDFe6cLi7bgxJVVbXXERZGAAlfu5bBH5BkfPVuE1/RW/+za32u
         mHJnJgLXbKsL1A4LHrl+NURkJdiBNzUepDg7xlEeZ0UEemMkXX//76savi+x5wYDBf
         dHrJHhAXN4OGrcyxoaR1wcJGRzX3Uo9t0RfB715mhD5dCxg/p16oXRIvcMrvnCsKWq
         NHiHV2M2OhXcUiW/JQX/Bqx/DDQCONrF3X91uBPi3dMAFMtL7T1SbidQtd8crV3gUZ
         0FKJmzeGfW2AwRabaBIjiNDLtVTqmPri1wx/aMhKOhhbcBiih3o89wnX97HaMcYkUl
         5+8spfUJdRy48jmVfhxnAB1E=
Received: from zn.tnic (p200300eA971dC57f329C23FFfEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c57f:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9ED5B40E0145;
        Thu, 22 Jun 2023 12:42:39 +0000 (UTC)
Date:   Thu, 22 Jun 2023 14:42:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Breno Leitao <leitao@debian.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, leit@fb.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Break down mitigations configurations
Message-ID: <20230622124238.GAZJRBvrJdWloWzy0D@fat_crate.local>
References: <20230616164851.2559415-1-leitao@debian.org>
 <20230621001327.qdyebewnx7r5aiy3@desk>
 <ZJMdKUr98H8zPSAl@gmail.com>
 <20230621173135.wiprtgzslhw5z5or@desk>
 <ZJNDRSUZuZ2L+pwo@gmail.com>
 <20230621194101.bmwesljror2yqjxx@desk>
 <d9bc78ed-1f05-47db-e916-d4d8bc76634e@intel.com>
 <ZJN/SGwvOBZmChJw@gmail.com>
 <0c908258-2b03-ebb3-bc7d-af5ea66479d4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c908258-2b03-ebb3-bc7d-af5ea66479d4@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:58:10PM -0700, Dave Hansen wrote:
> Do you like the direction this is going?  Maybe I'm missing something.

Yeah, see

f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs")

AFAIR, Linus wanted those this way so the only logical next step is to
add the Kconfig knobs for the missing ones...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
