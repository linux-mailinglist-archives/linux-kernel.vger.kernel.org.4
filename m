Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616E66A1612
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBXE6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBXE6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:58:23 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B58A67
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677214687; bh=JAJzofC9wOv/QpvghhlHNaQdA1UixHf67eHVZUnpoCE=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=n/jzz3tMkrVbSw3FZ7RfoCGSORt8tCEn084trn2QzeZrP5vrnRfahRjsfymZU0UpR
         F0vep+P3PqXZ6Lturv/z9aCafSxA0WFbxFDa5ruWt4K2SUpeFGgBgE3Wcx0d7dsK5g
         0Qz8yKVR6LbAVXGi7EvkTiMcp5+CXsp6UH+qMG/4=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 24 Feb 2023 05:58:07 +0100 (CET)
X-EA-Auth: OF1wvy0huYU4UdbYeqLOfs2XyglQfG9VCLdD5rtUyF+1jOTK76n4Nm/gTRs+Z274X0UTiGa/qBV8n+F9RIqwRRFy4jVmUF7f
Date:   Fri, 24 Feb 2023 10:27:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Leonid Pershin <leonid.pershin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Rebecca Mckeever <remckee0@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: remove split in user-visible string
Message-ID: <Y/hD10Ir9g/On6ME@ubun2204.myguest.virtualbox.org>
References: <20230223193559.157880-1-leonid.pershin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223193559.157880-1-leonid.pershin@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:35:57PM +0300, Leonid Pershin wrote:
> According to coding style, user-visible strings in printk()
> function calls cannot be split across multiple lines.
> Issue found with checkpatch.pl.
> 
> Signed-off-by: Leonid Pershin <leonid.pershin@gmail.com>
> ---
> Changes in v2:
>   - Replace printk(KERN_DEBUG...) with pr_debug()

Hello Leonid,
I was not able to trace the v1 of this patch. Did that have a different subject?

Thank you,
Deepak.

> 
>  drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)


