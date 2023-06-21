Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB07382FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjFULOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjFULN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:13:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370B186
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:13:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B11B91EC0645;
        Wed, 21 Jun 2023 13:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687346033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oEdjW/BEuqJA1WSGzokko57xz6LD2lJ+RtmrN8Ryq9k=;
        b=lKezUUCTjixcfl506APBTIrfu49K5em68tkZeoiok2l1SzRqppVq19fy8ehNAbfTcD1tQ1
        SeJIfH9iCyfRDva+M2AS8DbMkPYGEuZiKI6Ww9ZTWNwGzTIMD0mbvIIOkwNCHGcOUsBopk
        VcPwXNj1NJupETBUZZNw43FsG9Xk2B4=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zN72J6PS8SE0; Wed, 21 Jun 2023 11:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687346031; bh=oEdjW/BEuqJA1WSGzokko57xz6LD2lJ+RtmrN8Ryq9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZhnL2l+gKQFq8SwdzBRrCS7HJkG1u7xtNGh5ss0NaF4Gjp5toi7pJm9ljh06xP+1
         Ax1ChLFYFB8MibH9yx8rs3eHlGHbrftnicoXGKrBc1xImaSe5kZ1iYEZBPcDZ2eIhi
         WDMccEdi8S2D1tPoZUKPOrn8G6zaYB6EXW+waggrDzU59ZEXNBKkrSolaLmr43bHpV
         cqlp3gkeoAv2F4OxoNaPnEF6+0j0FMvQAWMQ0MRUwc3u7qST+r38lN48/ZdhUuEZHd
         86Nf5wfUvf4OTZw06zoxM8N4JvFSY5XRVRE9lRkI6FyzZeqDOPcoUgv+QRsJ8ozAhO
         TPCqFq7mpAwjFExy5c2EpOA6roM41j/aswmQ3vh5RDmOPRu5yGv5oi89wNjjBGdSgV
         fCDUuj8w9Or16A2PCpLMbevWTpB+BzTynkN/vMJY/rH1zctlQtRS8gqnJCNl5C8+TU
         qcYDwx34cp+6b3Xw2sMr8/bCt0ezVZA5+BweRNQAi1jFXokSW06pWIF/WXI7zFtYgV
         VxMcPZs2jG2bNIze4I7I0pNhHZIGJx0LgfB9Z2XVzk85xO2gWdReusvkTTStc78N3u
         qRyyO+kNJPY2ihXmd2DJs9gsHP/FsXovn725ZPTDze/A97aQdNe01M8chb4vX4u0aW
         DtNoNbM2TcVJg+Y+73GscxNA=
Received: from zn.tnic (p200300ea971Dc592329c23FffEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c592:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3508540E01DE;
        Wed, 21 Jun 2023 11:13:47 +0000 (UTC)
Date:   Wed, 21 Jun 2023 13:13:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: A question about prefetchw detection in "x86/asm: Cleanup
 prefetch primitives"
Message-ID: <20230621111346.GFZJLbavDw1JiLi34n@fat_crate.local>
References: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b663d8f6802e8dbf443397718234bcb6d0811c8.camel@xry111.site>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 06:57:40PM +0800, Xi Ruoyao wrote:
> I intend to implement the same logic for Glibc.  I can understand "3DNow
> implies PREFETCHW", but is there a bibliographical reference about "LM
> implies PREFETCHW" so I can convince the Glibc maintainers for the
> change?

https://www.amd.com/system/files/TechDocs/24594.pdf

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
