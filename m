Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264556C8F84
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjCYQnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjCYQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:43:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076CA1B8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 09:43:13 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF7F41EC018C;
        Sat, 25 Mar 2023 17:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679762591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Km7Uf9I1amhFm4e5ULmshh8t10f1X4Cdt5efipAaeSM=;
        b=IvhYQ3Y88Quj6oEqAAzps072Kbq3me85kc2MiRdVpj96wo1lGLwF0/U/g7GUvoGA26ivJY
        G6XgDD5UfVYa+o96N/kYg9rVYKZrZEKqGkgChTlM3YXkggtYWJKG0ropKqcvnyrC5/bE45
        V6JsMwBS9J/H6QHVPhTPO55VKnKUpGs=
Date:   Sat, 25 Mar 2023 17:43:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] x86/cpu: Add model number for Intel Arrow Lake processor
Message-ID: <20230325164307.GAZB8kmwm6NqA+ROWi@fat_crate.local>
References: <20230324195932.241441-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230324195932.241441-1-tony.luck@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:59:32PM -0700, Tony Luck wrote:
> https://www.intel.com/content/www/us/en/newsroom/news/intel-technology-roadmaps-milestones.html

This URL will become stale sooner or later.

> says this will be built on Intel 20A tiles and launch in 2024.

I don't think you need a source - you are a source enough. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
