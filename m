Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5564263B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLEJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLEJ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:58:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9440DECF;
        Mon,  5 Dec 2022 01:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670234329; x=1701770329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=upaZo6fjhhnh+UlqOySD7G2L3bnZ7lNoi+82BMImAOo=;
  b=dSJeMiAGkGorsrAERzEFqSLlzQUYuCuSOScynW0cx7VA+odqBmgUYdLJ
   FbQjN4VIEHhGUkJ+CYw4iY5I3U2sEXZASXWlwRFsI7thpbL1xE5JzVtUk
   ZJ3BWksm5KsKuywHrL8A6WlDOZiZkvdDXfk1bQntEWn54o5ZnItIpyREH
   RHvI7Jl3oknoGXU60SGDbqjSdBO5vLM0oT6JzVMrQZ6K7FwvlLQ4facQZ
   upo5yO+0sNxBRwEcq8a4dQT8pazGCa5WA5+ugHXg/zd4doacvByb0b9cU
   3mP1xc5apgIrPtmm9QVhkpAuc9quFHt9Zzev9Upl1NSkbH56jF4bedQBZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="296009088"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="296009088"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 01:58:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="820137760"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="820137760"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 01:58:47 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 13E962033F;
        Mon,  5 Dec 2022 11:58:45 +0200 (EET)
Date:   Mon, 5 Dec 2022 09:58:45 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pali Rohar <pali@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: ad5820: Fix error path
Message-ID: <Y43A1WbaLSa042EJ@paasikivi.fi.intel.com>
References: <20220921-ad5820-v2-0-3e5cabb04786@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921-ad5820-v2-0-3e5cabb04786@chromium.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Fri, Dec 02, 2022 at 05:35:59PM +0100, Ricardo Ribalda wrote:
> Error path seems to be swaped. Fix the order and provide some meaningful
> names.
> 
> Fixes: bee3d5115611 ("[media] ad5820: Add driver for auto-focus coil")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I'm afraid v1 has already been merged. But I understand patch content
wasn't really different so that should be fine.

-- 
Kind regards,

Sakari Ailus
