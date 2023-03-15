Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56D6BB840
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjCOPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjCOPnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:43:45 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E547C3DF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RamjROs+sUVfYNzroeeQOrxygIhaTlWlwCCu0K2PnS8=;
  b=FKf5jfSzgO53FtuCQCUjdqjGwF/spoq9QegdaugJkHQUj9tgOluk7xpQ
   130YtQW/2plkrhIR+BvxZG0e+PuAnE/475Ev10b0JAXzQGWH46nTn3ZV+
   qB9AxzSn9nQQ5S2vGU/7ecATxhvnIOzWnTkHL+BCv0D3kbjoC+afVD823
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,262,1673910000"; 
   d="scan'208";a="50285566"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:43:21 +0100
Date:   Wed, 15 Mar 2023 16:43:20 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Kloudifold <cloudifold.3125@gmail.com>
cc:     Alison Schofield <alison.schofield@intel.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
In-Reply-To: <ZBHlycBoZ0JRwHZm@CloudiRingWorld>
Message-ID: <d231df94-c8db-aa3e-98c9-3d56f758675b@inria.fr>
References: <ZBHlycBoZ0JRwHZm@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Mar 2023, Kloudifold wrote:

> Hi Alison,
>
> Thanks a lot for your help, so if I send my v3 patch, should it be like
> below? (Philipp said "please make the Subject more unique", but the
> Subject could be only a few permutations of very few words, I can't see
> how it could be any more unique.)
>
> Subject: [PATCH v2] staging: sm750: Rename functions from CamelCase to snake case
>
> sm750 driver has sm750_hw_cursor_* functions, which are named in
> camelcase. Rename them to snake case to follow the function naming
> convention.
>
> Changes in v3:
> - Add this changelog (Philipp)
> - Move lkp tags and link to the correct location in commit log (Alison)
> - Update the commit msg (Philip)
> - Update the commit log (Bagas, Julia)
>
> Changes in v2:
> - Use new function names in call sites (LKP)

All these changes should go below the --- line, not above it like this.
The history of changes is for people who are following along in the email
discussion.  Once the patch is accepted, they won't be meaningful.  So
they should be the in the part that disappears, which is the part below
the ---.

julia

>
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> ---
> git diff message
> ---
>
>
