Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8EB6FFD44
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbjEKX3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjEKX3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA305FD2;
        Thu, 11 May 2023 16:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C7861998;
        Thu, 11 May 2023 23:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B171C433D2;
        Thu, 11 May 2023 23:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683847746;
        bh=4myvbo3QGjQDsBcH7VGxTcyJ2CbmgkXUJtpS7N+W5EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myYLVNuyqT8Y6ak5xWT6BxWh1ositIfEggGf2sMSrhLYk0Z7KVkWfbRDZeQ2ywYBU
         fCFbOJhPVH/FCqT1vJ1Epq83J8r66d9/b2ZJTahXTVDdaKSBQfIEN1Il0hX/XehXt9
         2xtrzjbolKgoAETqe3tiOxPjylOmLSbDf6dL9flR/ACZafL4EbBkR1uQ6qE4jukAWT
         mExai6eRnN5oumHApi7rFqBwS3EKKhMh/Fs7iz9UHQZnn82YOjkFLt5+DIGPsWD0Jo
         bAsyXsurBkS1qFp3Lkj17u1jOlwJJYsrg9vnkVSVY6cjyDjpBJfHHAFEdjSIY37/XL
         04oe8jYVeIo8w==
Date:   Thu, 11 May 2023 19:29:05 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     yixuanjiang <yixuanjiang@google.com>
Cc:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
Message-ID: <ZF16QZzmDfu+MQjz@sashalap>
References: <20230511120841.2096524-1-yixuanjiang@google.com>
 <20230511120841.2096524-2-yixuanjiang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230511120841.2096524-2-yixuanjiang@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:08:36PM +0800, yixuanjiang wrote:
>From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
>[ Upstream commit d8a9c6e1f6766a16cf02b4e99a629f3c5512c183 ]

Queued up, thanks!

-- 
Thanks,
Sasha
