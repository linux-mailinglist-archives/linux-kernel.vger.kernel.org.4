Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E7072B24E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjFKObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjFKObm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:31:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2189510A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A3961037
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82045C433D2;
        Sun, 11 Jun 2023 14:31:39 +0000 (UTC)
Date:   Sun, 11 Jun 2023 15:31:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        horms@kernel.org, thunder.leizhen@huawei.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/2] arm64: kdump: simplify the reservation behaviour
 of crashkernel=,high
Message-ID: <ZIXayAr6r1tnFQ5i@arm.com>
References: <20230515060259.830662-1-bhe@redhat.com>
 <168633894002.3180904.11323833556978641615.b4-ty@arm.com>
 <ZIW6y9IK+pqMSfoc@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIW6y9IK+pqMSfoc@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 08:15:07PM +0800, Baoquan He wrote:
> On 06/09/23 at 08:30pm, Catalin Marinas wrote:
> > On Mon, 15 May 2023 14:02:57 +0800, Baoquan He wrote:
> > > In v5 patch, Catalin helped review and acked the patch. However, an
> > > uninitialized local varilable is warned out by static checker when Will
> > > tried to merge the patch. And Will complained the code flow in
> > > reserve_crashkernel() is hard to follow, required to refactor. While
> > > when I tried to do the refactory, I feel it's not easy, the existing
> > > several cases causes that.
> > > 
> > > [...]
> > 
> > Applied to arm64 (for-next/kdump).
> > 
> > I reworte some of the paragraphs in the documentation patch, removed
> > some sentences to make it easier to read (some details were pretty
> > obvious). Please have a look, if you think I missed something important,
> > just send a patch on top. Thanks.
> > 
> > [1/2] arm64: kdump: simplify the reservation behaviour of crashkernel=,high
> >       https://git.kernel.org/arm64/c/6c4dcaddbd36
> > [2/2] Documentation: add kdump.rst to present crashkernel reservation on arm64
> >       https://git.kernel.org/arm64/c/03dc0e05407f
> 
> Could you help add below code change into the document patch commit? I
> forgot adding it and got warning report from lkp test robot.
> 
> https://lore.kernel.org/oe-kbuild-all/202306110549.ynH2Juok-lkp@intel.com/
> 
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index ae21f8118830..dcfebddb6088 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -25,6 +25,7 @@ ARM64 Architecture
>      sve
>      tagged-address-abi
>      tagged-pointers
> +    kdump

I've seen the warning as well. Please send a patch fixing this as I try
to avoid rebasing. Also we keep this part in alphabetical order.

Thanks.

-- 
Catalin
