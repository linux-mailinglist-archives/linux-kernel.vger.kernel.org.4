Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474CC6BC5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjCPGC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPGCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:02:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA54AFD9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26323B81F9E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF3FC433EF;
        Thu, 16 Mar 2023 06:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678946571;
        bh=1H1HS9Ry+ELdH7NWYIXpQ9Kk85X7UC33y9TSVoiLvvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaxElmRd9DbiXFuxEc7CPG5z8DTtJ9jwtTZPmuI/lPBsROxRiC7fX3OoNt27ZghEv
         Rv7zpktxvPSMKGW9xVkxwpNT+9N+9E1fXRJFLHu4jOk6vlrA0RUC+EypbdsE3UsTPZ
         0/9lTAQEEuyLhJwfSXCcY18hBbWa62M3Df+ii8zivP6uPb6go/gugPRuBUn2tVLfy4
         hqeiKj1uzMN2SxQ8rZe0QNpSfMuAhGdDLkzWhCwMqy/xZYe8w3srIE0SlliSqPmm5m
         cyZ02Fla3LWHg5EcMMU6yda/Qvb569MdlqEtldviUWPrN/9ADXHHqh5A+EhWkF69IW
         0RW2CbaC/pWIQ==
Date:   Thu, 16 Mar 2023 11:32:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2] soundwire: bandwidth allocation: Use hweight32() to
 calculate set bits
Message-ID: <ZBKxB+4uTPDcibmj@matsya>
References: <20230315145051.2299822-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315145051.2299822-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-23, 14:50, Richard Fitzgerald wrote:
> Replace the call to sdw_ch_mask_to_ch() with a call to hweight32().
> 
> sdw_ch_mask_to_ch() is counting the number of set bits. The hweight()
> family of functions already do this, and they have an advantage of
> using a bit-counting instruction if it is available on the target CPU.
> This also fixes a potential infinite loop bug in the implementation of
> sdw_ch_mask_to_ch().

Applied, thanks

-- 
~Vinod
