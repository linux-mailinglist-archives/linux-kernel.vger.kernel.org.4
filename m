Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94195E7AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiIWMZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiIWMYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:24:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A15140AB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:19:41 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3CAB1EC0662;
        Fri, 23 Sep 2022 14:19:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663935575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5WxiEVsdSnBKX75aGLfGHyVaPvzL4y03SbUL80DEg/Q=;
        b=Oy6jw/q35/CLrIyjCoPHYLdpnIFDIhIu+VeZxXXctD9q3kJnsTCZj7VolWnElExYLA2lO1
        nSpkcWz6gjAOALwv4n/qqk84sbPKMmZhVFf7YjZPlAY17kobQNuGbd2yxFE0n6mO+bnbRS
        IFnhpGcvzv7FZnr0nbCxa7Z2Q5iZhps=
Date:   Fri, 23 Sep 2022 14:19:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, brijesh.singh@amd.com,
        michael.roth@amd.com, venu.busireddy@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/sev: Remove unused variable "err" in
 enforce_vmpl0()
Message-ID: <Yy2kU7lZuArVMC5p@zn.tnic>
References: <20220923113209.3046960-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923113209.3046960-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 11:32:09AM +0000, Li Zetao wrote:
> Gcc report warning as follows:
> 
> arch/x86/boot/compressed/sev.c: In function ‘enforce_vmpl0’:
> arch/x86/boot/compressed/sev.c:256:13: error: unused variable ‘err’
>  [-Werror=unused-variable]

How do you trigger this? Compiler version and .config?

I haven't seen this one in any of my builds until now...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
