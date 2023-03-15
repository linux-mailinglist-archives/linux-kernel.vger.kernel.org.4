Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0677B6BB4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCONeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCONd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:33:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB594F5D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 113BAB81E12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC399C433EF;
        Wed, 15 Mar 2023 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678887172;
        bh=mJTyFmQ7lRhkRno0YrsyWzsjSuYv4KlKhEc2I+D+cOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDwNglApiS/OSnY6eVLeEi+PgkzkwwexumhcikV4F+037vmwMZbBQVmoJtJsxyKvD
         U7bxkQXWuK2A2vKcM1moDTM4LuIYzk7LRoHXrnDlsA8TCikXSgUmUdpbnjkHgMwxCj
         xEa/7jOjiUVRTYAdmUEjfXMZT1OLg+CRiGjcwCT4NLFfrQQMitySiPXeBDho1TIF4c
         Wkxfa2n/xZAFC+AqGGQU2JE/qioj3htYRO0acjXEXYPu03tzFad+aRhR/nMSyKMIrj
         HtPAK1mGIoLmqK2DEYn2/GwDGj8PUewO8RPRewxMvoasB2WuEPzd1fTi8pKnQ8Jy7l
         TQQgkVTSRqxkw==
Date:   Wed, 15 Mar 2023 19:02:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        broonie@kernel.org, peter.ujfalusi@linux.intel.com
Subject: Re: [PATCH] soundwire: dmi-quirks: add remapping for Intel 'Rooks
 County' NUC M15
Message-ID: <ZBHJAH6WI1aWq9kd@matsya>
References: <20230314090618.498716-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314090618.498716-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-23, 17:06, Bard Liao wrote:
> From: Eugene Huang <eugene.huang99@gmail.com>
> 
> Same DSDT problem as the HP Omen 16-k0005TX, except rt1316 amp is on
> link2.
> 
> Link: https://github.com/thesofproject/linux/issues/4088
> Signed-off-by: Eugene Huang <eugene.huang99@gmail.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Applied, thanks

-- 
~Vinod
