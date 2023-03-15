Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4746BB53E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjCONy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjCONyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:54:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B398A4B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7006B81DFD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B2C433EF;
        Wed, 15 Mar 2023 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678888457;
        bh=yGS0GCC0GsTeb+jtCVuIDSjV+3hiMFhFbaDICAwfixs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qr0dllfQS6siP2cK1jtNU4TyIqm5Zyo/KZbSvK02zdvSlhmFGh+YgnR/iDyeiQhKn
         eyG9B8zBv1sZl5oL4GHsaxgnXElVOKXjBz9nTPLCZfzglsaLVbYdzd4ULWy7PH8Ayi
         g1MT2MlAw6jvDNg+Iq6IdLOQdpNFIE0bdjzhpDO5l50zDNd1+bxy5BTeFa8VmWhtmq
         lTPKBXicQVXdEtJgP6NbULuksMUn8Xi+bkVEIKdIp9r6IdH60pPX0M8cMyLWXQ5g9d
         2QqM6AJzCwFNjz/3mdA9MIo/XodkyQKPr2jmZDiouf4/ijjRmWJNnVtC/zCC8RCySD
         Y9KcjIguDgABQ==
Date:   Wed, 15 Mar 2023 19:24:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 00/16] soundwire: updates before LunarLake introduction
Message-ID: <ZBHOBM2P1kTgdmer@matsya>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-23, 09:53, Bard Liao wrote:
> This series provides a set of cleanups and new abstractions needed for the
> introduction of LunarLake support.
> 
> For now this is an iso-functionality change, with changes on the Intel and
> Cadence sides. The low-level support for LunarLake will be introduced in a
> follow-up series that depends on HDaudio multi-link extensions.

Applied, thanks

-- 
~Vinod
