Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5105BDC04
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiITFGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiITFGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEDE46D81
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 22:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E6DC620AB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469D4C433D6;
        Tue, 20 Sep 2022 05:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663650377;
        bh=xJpBWFasHV//GhCiAso/TJ5mgUV87MnaPyMLvDak5tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWmJkEMd2nP0KT/3w0/b2W/pYT9FK31nXFj/aYyGym5PGxOuKSEjUHMIJp9kmwSyi
         PXsxJ9UbLCxUJ8lroIMjswaYx4aUFn9oDQHfsyMeKrm+Lx5ylfU0xHjAJFLvo7Vk2M
         hvwliWEu7XPDrIeMDgiOxP7alwV3pep1nCtZ0wLQbwsTglP8//Xcj9j5W4P9MTsrXq
         hS6qC93wj2onYDr7tm+Yuh3xV+MxszpUGh1cXxkOGKzbSmoH73lgMLrZszHU1cBDxh
         4l85PXhkhVIA/y334HiwSMP7KIFkahnWU7oYDKruK1jk39TCmzUqX1xF29OPhoq2pT
         Cepm/I+shuxjg==
Date:   Tue, 20 Sep 2022 10:36:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] soundwire: cadence: Write to correct address for each
 FIFO chunk
Message-ID: <YylKRtYM5vHrm3i4@matsya>
References: <20220917123517.229153-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917123517.229153-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-09-22, 13:35, Richard Fitzgerald wrote:
> _cdns_xfer_msg() must add the fragment offset to msg->addr to get the
> base target address of each FIFO chunk. Otherwise every chunk will
> be written to the first 32 register addresses.

Applied, thanks

-- 
~Vinod
