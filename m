Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2C6BFAC0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCROWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCROWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:22:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B43D32CE3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:22:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h17so6702891wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679149359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkmwpvH9sgPVQtlzvbDDavt+3mGPIiqy12zSddkmIqk=;
        b=EvuVqEeNdmsExAcKsIECfZDPx7X1EeANvP/Nn6StcDA4dLDkMgIps62snjPCwQyeXa
         aDGRMhs5h2P91E4EIrwUijYIA5PYCKnyKie2SriqcEdJs4qQO246M93QVbgTCs35kfiB
         ykaYUbHmt43QKKtFKfTwL+QXlVEOwbR6QqMPR5CktbLbY2M3KeBl87mh9HVUVK9EJWN2
         z9KC6gmWavTds4RFDWZkFSbO5aazyG9Wc/OPljT0LnnzdwfPbZ8t53O/fza0MjCC0L57
         8SHImX4KteuyRpkz3qjA5mtXyPkeAV5YoZBmWNJlXKHZ/lKuFW5CyCGaCnupWpAdQl/v
         eFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679149359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkmwpvH9sgPVQtlzvbDDavt+3mGPIiqy12zSddkmIqk=;
        b=74sYECPMALPdEVHg7UrFJOshZfJ3dlbC7WC6DAQfV2Bxx/u0BRK+qbWkpE199X5Uki
         wviPVwAcyMJEVKziy2y7SCb+Ve1RWkneqmF/ajGeZbQBKPcXhuIiRvidHF9CyS2LVl9/
         wh1xIpyQwnXnOJBxtrkOv8scL8kiu8cdjEruJK6hSreeS2hWumtJwhfM9prTzR7fyJ6U
         Chvir3odeX5hWkDFZ7/UU0buy82IHog5Uh+WoDoSjjaGudWYpMtK7kxrDC+ss7YR2GpW
         Nrbl2IXLmEb2qM7wQVYvgcRNnKm6zHhgrU3RVjMwZIpki6cR/MqwO+etuA6nkYWsctcE
         EJjg==
X-Gm-Message-State: AO0yUKXBeMobshfnFF+Whqgu8TCgJRJ+3L0Y/blYo+h+2jKSaIRW/Z6d
        x4qCoRsfXiRxb6zdxRRujfxO86rNqsE=
X-Google-Smtp-Source: AK7set96I+f1RiZ6VzzeJJiw6TgJMv6fYtwvIdEEzyOihGdPog32kXCkLDJTfSButzQ2zohLA+h/YQ==
X-Received: by 2002:a5d:6944:0:b0:2c5:4c9d:2dab with SMTP id r4-20020a5d6944000000b002c54c9d2dabmr5525774wrw.10.1679149359470;
        Sat, 18 Mar 2023 07:22:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b002c8ed82c56csm4439375wrx.116.2023.03.18.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 07:22:39 -0700 (PDT)
Date:   Sat, 18 Mar 2023 17:22:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kloudifold <cloudifold.3125@gmail.com>
Cc:     outreachy@lists.linux.dev, teddy.wang@siliconmotion.com,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        alison.schofield@intel.com
Subject: Re: [PATCH v3] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <dd1e1fcc-2a4e-438f-ad61-ef7640b8e423@kili.mountain>
References: <ZBW+NX4SLaCyEnJd@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBW+NX4SLaCyEnJd@CloudiRingWorld>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 09:35:49PM +0800, Kloudifold wrote:
> sm750 driver has sm750_hw_cursor_* functions, which are named in
> camelcase. Rename them to snake case to follow the function naming
> convention.
> 
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> 
Delete this blank line before the ---.

> ---
> Changes in v3:
> - Add this changelog (Philipp)
> - Move lkp tags and link to the correct location in commit log (Alison)
> - Update the commit msg (Philip)
> - Update the commit log (Bagas, Julia)
> 
> Changes in v2:
> - Use new function names in call sites (LKP)
> 
> This v2 patch was prompted by an error reported by the Linux test
> robot, which detected the compile error.
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
> ---
> ---

Delete these two --- lines.

>  drivers/staging/sm750fb/sm750.c        | 22 +++++++++++-----------
>  drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
>  drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
>  3 files changed, 24 insertions(+), 24 deletions(-)

I would have ignored the issues above but when I went to apply the patch
git complained about whitespace problems.  So then I ran checkpatch on
the patch and it complains a lot.

ERROR: code indent should use tabs where possible
#61: FILE: drivers/staging/sm750fb/sm750.c:130:
+^I^I^I^I       ^Ifbcursor->image.dx - info->var.xoffset,$

WARNING: please, no space before tabs
#61: FILE: drivers/staging/sm750fb/sm750.c:130:
+^I^I^I^I       ^Ifbcursor->image.dx - info->var.xoffset,$

CHECK: Alignment should match open parenthesis
#61: FILE: drivers/staging/sm750fb/sm750.c:130:
+               sm750_hw_cursor_set_pos(cursor,
+                                       fbcursor->image.dx - info->var.xoffset,

ERROR: code indent should use tabs where possible
#62: FILE: drivers/staging/sm750fb/sm750.c:131:
+^I^I^I^I       ^Ifbcursor->image.dy - info->var.yoffset);$

WARNING: please, no space before tabs
#62: FILE: drivers/staging/sm750fb/sm750.c:131:
+^I^I^I^I       ^Ifbcursor->image.dy - info->var.yoffset);$

total: 2 errors, 2 warnings, 1 checks, 99 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

"[PATCH v3] staging: sm750: Rename sm750_hw_cursor_* functions to" has style problems, please review.

regards,
dan carpenter
