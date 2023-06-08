Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7141727EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjFHLjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbjFHLjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:39:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD9726BA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6C0464C97
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F88FC433D2;
        Thu,  8 Jun 2023 11:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686224369;
        bh=nM9Mt74z4YYunGYFvPmP6gQm7sj/Lc0clDW3pL7yI7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juCXJMO0YrEKCe2l2oPBwOwKjJrQB+PqFZ3b3C5H+wZFzCK4TidM/Se6OQY2JtuQL
         n/heOtHYaNTyK1S899ZoXjvPU5llDF3IQrObcgB9qAUIXhYUt8MBg7w7nCyAKJiAeS
         Hv+bm3Lw8d3QPSD9Dvm42Skj+PqsPft8nsL3soZyUuPwR+quvzsqADiGL4zHtZ42TX
         VMsu37ErYvXICKLezJkp43j3S2WfPK3dleF1F8FQgb/mVLCJSITWXUlwPVLZfXJVe4
         eAFJhU6w+yHkAL5TWXa+8zEux+5BRRIZQZUMzyNtUaP8gS8AqINUESF+bq6TI9qu3U
         hd6uqgUyIArJw==
Date:   Thu, 8 Jun 2023 17:09:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/5] soundwire: stream: Add missing clear of
 alloc_slave_rt
Message-ID: <ZIG97E/9fWmWHhVq@matsya>
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-06-23, 11:11, Charles Keepax wrote:
> The current path that skips allocating the slave runtime does not clear
> the alloc_slave_rt flag, this is clearly incorrect. Add the missing
> clear, so the runtime won't be erroneously cleaned up.

Applied all, thanks

-- 
~Vinod
