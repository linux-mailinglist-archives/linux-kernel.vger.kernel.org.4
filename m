Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6F64F232
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiLPUN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiLPUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:13:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253775FBA8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:13:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8E1BB81D0A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 20:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67368C433D2;
        Fri, 16 Dec 2022 20:13:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FEzTZh0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1671221598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfhwJ6//z17DhbqPjt4GStlAmZRA8zNf6DoXoNXFZJ8=;
        b=FEzTZh0OtZxJwBg1Y0K0ePQES8bJscXR10V8Hg2sM+QywGXmtchc7T1kqRKrSwumB3QVYd
        zE9rTMMbessnj2bW/1V8xHHf5/sNtWUzGGWznJIPGADtOYYdfHMYr82hiysBNTxHzMCCHL
        /Do26QHCokSZlm/0aa6d7rdLkIPkQWk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5bc2dd0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 16 Dec 2022 20:13:17 +0000 (UTC)
Date:   Fri, 16 Dec 2022 13:13:02 -0700
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: lib: Separate instruction decoder MMIO type from
 MMIO trace
Message-ID: <Y5zRTqDmjeJzjeFf@zx2c4.com>
References: <Y5oy0vwZQAwzkDkr@zx2c4.com>
 <20221214203454.337299-1-Jason@zx2c4.com>
 <20221214213015.GA16072@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221214213015.GA16072@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 01:30:15PM -0800, Ricardo Neri wrote:
> On Wed, Dec 14, 2022 at 01:34:54PM -0700, Jason A. Donenfeld wrote:
> > Both mmiotrace.h and insn-eval.h define various MMIO_ enum constants.
> > Rename the insn ones to have a INSN_ prefix, so that the headers can be
> > used from the same source file.
> > 
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> FWIW: Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks. Any chance this can get in for 6.2?

Jason
