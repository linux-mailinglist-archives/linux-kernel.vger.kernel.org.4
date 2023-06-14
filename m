Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205D37302D6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbjFNPGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343511AbjFNPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:06:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DE3189
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:06:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1BE63C32
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CD0C433C0;
        Wed, 14 Jun 2023 15:06:42 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:06:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     hexingwei001@208suo.com, pmladek@suse.com,
        senozhatsky@chromium.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib/test_printf.c: space required after that ','
Message-ID: <20230614110640.57817123@gandalf.local.home>
In-Reply-To: <ZImzXhc7ZRbSvz7/@smile.fi.intel.com>
References: <20230614082523.63191-1-panzhiai@cdjrlc.com>
        <f2d8eb955890bc1db1b307db713d4a4a@208suo.com>
        <ZImzXhc7ZRbSvz7/@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 15:32:30 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jun 14, 2023 at 04:30:55PM +0800, hexingwei001@208suo.com wrote:
> > Add missing spaces to clear checkpatch errors:
> > 
> > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
> > lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).  
> 
> Doesn't make any difference to the code, so let do this (unneeded) churn
> to calm checkpatch down.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

checkpatch is for patches (new code) and should not be run on existing code.

-- Steve
