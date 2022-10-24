Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E038D60BB73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiJXVA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiJXU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB1ACF52
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666638361; x=1698174361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zDjGl7ymv3qQPwr0vW7QFIfXYM4lah0BRXAEoA8v2TQ=;
  b=gguspVrpkU6Dxu5jh8Wou1t2wzkk+pP8GTAscB/XE8AFeqkoAo5Iyo/Q
   wPLav+Zs3P/qJ6xNwIqXTJDvwxbJ+hMCe8flkMTQ3+haIkrAmW1piZcwC
   8o0P8YoLL9Umv8gWeBkKplj71ZmQfpzP4JVcG2S7TEVToKpERRCjtSCNW
   3+LJa49g5QhBGugrgQgSBZPB43F5GhNknOnnzLNZCfisicnld988nMejZ
   bxxd9rbGv0dmR2S7eW8DAZK7PgU1pQN1cqhCgiIE34spVfqEQ8G3cBxTR
   +VWk/iTXFxvpyp1VQkfPURl7l49US4qYCqXxWq3zb8oKmRSroL9zC6W1w
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287219303"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="287219303"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 12:04:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876533709"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="876533709"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 12:04:16 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id CF612201D5;
        Mon, 24 Oct 2022 22:04:13 +0300 (EEST)
Date:   Mon, 24 Oct 2022 19:04:13 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] container_of: remove container_of_safe()
Message-ID: <Y1bhrYSr9iRqhcJk@paasikivi.fi.intel.com>
References: <20221024123933.3331116-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024123933.3331116-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 02:39:33PM +0200, Greg Kroah-Hartman wrote:
> It came in from a staging driver that has been long removed from the
> tree, and there are no in-kernel users of the macro, and it's very
> dubious if anyone should ever use this thing, so just remove it
> entirely.
> 
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
