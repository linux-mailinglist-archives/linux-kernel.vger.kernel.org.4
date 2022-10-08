Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7665F8594
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJHOWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJHOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:22:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8244B0E0
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 07:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A949B80AEF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AE2C433D6;
        Sat,  8 Oct 2022 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665238955;
        bh=WpsbLV1k1LdGsZAYRrhpFF8H3l4G3h3csAgFDHOsZ6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/QWLg1pXgy+b9YTsneB36RDyrMzeAFl49eD/oGSSHc8QaWH3TU11YSn84PhzXi/2
         Zh9NBLdkZujgSAt7uTjp9hKeAuIbZeQcJsXH/pULokJJPTKVs7tLAimsF+oKyRkhyl
         NjSNgpIoo+0W9RP1vQXNjlukbnj9gvKQCzsn1ocj/NhtePKlcA1ZUix/F0aC7FxJgy
         GRADGWjBWQaNnpx0mg3qUr3Zl+AIxeJWFvMGrvc1gd4uZXsAtbysWSqxVduzNYtTyT
         cmZqKnYla+g66mLo9IemI+/0fqoSqVUDADijtyL+Qta9n8bPUsr8TsO/3NoxcVHVAC
         obuyyz7n3eubw==
Date:   Sat, 8 Oct 2022 15:22:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Conor.Dooley@microchip.com, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org,
        ajones@ventanamicro.com, ardb@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, samuel@sholland.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] riscv: jump_label: mark arguments as const to satisfy
 asm constraints
Message-ID: <Y0GHpJMQwEeLEq2Y@spud>
References: <20221006064028.548-1-jszhang@kernel.org>
 <20221006124144.abaz74g7nxrb5hxj@kamzik>
 <4c8fa16a-8463-ee32-7307-0383fa94403c@microchip.com>
 <Y0GBO77e2Lu/khkI@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0GBO77e2Lu/khkI@xhacker>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 08, 2022 at 09:55:07PM +0800, Jisheng Zhang wrote:
> On Thu, Oct 06, 2022 at 12:44:32PM +0000, Conor.Dooley@microchip.com wrote:
> > Also could you please add the reported-by from samuel & a fixes tag?
> 
> I will add Reported-by tag, but I'm not sure whether fixes tag
> is suitable, and which commit I could use? commit 8eb060e1018
> ("arch/riscv: add Zihintpause support")?

That is the commit that Samuel blamed for the issue & is the one that
added the static branch - so I guess so!

Thanks,
Conor.
