Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889B9608A95
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJVJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiJVJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F068869ED9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBEC260B81
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E45C433C1;
        Sat, 22 Oct 2022 08:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666426614;
        bh=SVl9QTL0d/kdPqe3qSjUFuC2B7qpIuWhdsqvq6xVd5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFxHWqrcVgdMv3Z61AERre/TqJ40lTbSPzLOWcSXgNNrwO+tWN830SOrrZsM+pazZ
         o7VNzJuG+opsuONCearIb6CSGC7ibPa8INTF7SmwHd+Bp3QDWMuLRbZrT4t0Y6g4LK
         MfhDbi5Jf8YfX8+Epda+zr3tXdFECnm+LYgntpjg=
Date:   Sat, 22 Oct 2022 10:05:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH v4 00/11] staging: r8188eu: trivial code cleanup patches
Message-ID: <Y1OkUMCNb4lMH6Km@kroah.com>
References: <cover.1666299151.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1666299151.git.drv@mailo.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 02:56:10AM +0530, Deepak R Varma wrote:
> Address different kinds of checkpatch complains for the staging/r8188eu module.
> The patches are required to be applied in sequence.
> 
> Changes in v4:
>    1. Include patch 11 in the set for unused macro clean up. Suggested by julia.lawall@inria.fr
>    2. Update patch 1 per feedback from David.Laight@ACULAB.COM
>    3. Update patch 5 & 6 per feedback from dan.carpenter@oracle.com & julia.lawall@inria.fr
> 
> Changes in v3:
>    1. Patch 4: Extend the __constant_htons to htons change to other files of the driver.
>       This was suggested by philipp.g.hortmann@gmail.com
>    2. Patch 4: Spelling mistake corrected as pointed out by joe@perches.com
>    3. Patch 5 through 10: Included in this version. Additional clean up patches.
> 
> Changes in v2:
>    I incorrectly labeled the first revision as v1 instead of v2. So,
>    following change recorded under v1 is actually changes for v2. Feedback
>    provided by philipp.g.hortmann@gmail.com
>       1. Improve language / grammar for the patch descriptions
>       2. Further improve code reformatting
> 

I've taken these, but note, your email system is not properly being
authenticated.  Here's the results I get when I use the tool 'b4' to
apply the patches:

Grabbing thread from lore.kernel.org/all/cover.1666299151.git.drv%40mailo.com/t.mbox.gz
Analyzing 20 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v4 1/11] staging: r8188eu: use Linux kernel variable naming convention
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 2/11] staging: r8188eu: reformat long computation lines
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 3/11] staging: r8188eu: remove {} for single statement blocks
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 4/11] staging: r8188eu: use htons macro instead of __constant_htons
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 5/11] staging: r8188eu: correct misspelled words in comments
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 6/11] staging: r8188eu: Add space between function & macro parameters
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 7/11] staging: r8188eu: Associate pointer symbol with parameter name
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 8/11] staging: r8188eu: replace leading spaces by tabs
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 9/11] staging: r8188eu: Put '{" on the symbol declaration line
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 10/11] staging: r8188eu: Correct missing or extra space in the statements
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ✗ [PATCH v4 11/11] staging: r8188eu: Remove unused macros
    + Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> (✓ DKIM/gmail.com)
  ---
  ✗ BADSIG: DKIM/mailo.com
---
Total patches: 11


Please look into fixing up your DKIM settings.

thanks,

greg k-h
