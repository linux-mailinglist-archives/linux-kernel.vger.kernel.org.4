Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF1616CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKBSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiKBSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:46:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738132F67B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:46:07 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e741329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e741:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1BEAE1EC0430;
        Wed,  2 Nov 2022 19:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667414766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KkoCLWnsSoPWTtKO3vxPQlJQqmqw5XkZwhUzVRjwIOg=;
        b=SfbG6UhD6NUrNA/ohf77cq0ITEL/ksYBXfVpqXIOEhPslwcWNJa04QBhTjFm5YcOabO7w5
        mfwDqFhKhfNsCq1h3SWO+bDLZk5Dx62Oa3RaaDzPbYCVKCp6lQdT6/WFZeNMt1CcC5kumw
        wNBIbc3dKFtPS8oQLQPbsVBWvlk5vAc=
Date:   Wed, 2 Nov 2022 19:46:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Peter Gonda <pgonda@google.com>, dionnaglaze@google.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, jroedel@suse.de,
        luto@kernel.org, mingo@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v5 1/4] ccp: Name -1 return value as SEV_RET_NO_FW_CALL
Message-ID: <Y2K67cJXr2cLk/RE@zn.tnic>
References: <20221102151836.1310509-1-dionnaglaze@google.com>
 <20221102151836.1310509-2-dionnaglaze@google.com>
 <55c2794b-a8fc-790d-1529-424ae804185e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55c2794b-a8fc-790d-1529-424ae804185e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:30:17PM -0500, Tom Lendacky wrote:
> It's always good to do a git log on the file(s) you're updating to get an
> idea of the appropriate prefix to use.

You mean:

git show <commit id> | ./scripts/get_maintainer.pl 
Brijesh Singh <brijesh.singh@amd.com> (supporter:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE...)
Tom Lendacky <thomas.lendacky@amd.com> (supporter:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE...)
John Allen <john.allen@amd.com> (supporter:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER)
Herbert Xu <herbert@gondor.apana.org.au> (maintainer:CRYPTO API)
"David S. Miller" <davem@davemloft.net> (maintainer:CRYPTO API)
linux-crypto@vger.kernel.org (open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE...)
linux-kernel@vger.kernel.org (open list)

Btw, I think we need to remove Brijesh...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
