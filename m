Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF2604632
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJSNA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJSM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:59:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449AF192B8A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 252D0B8226D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22831C433C1;
        Wed, 19 Oct 2022 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666183370;
        bh=i/Cu5U/Xet7ebdYmSbaNMXByAHvT+YncsFj32GG7S0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcSAoZfEAnWrToJtuxk86IaCV4JTCOO8uK1I5tTS2niwriB7OkSorEfsS8mZsLndK
         fyJi5YpNTkCGwkR7fyUcbXmo1s3LNaQcySZQJUKX4cCIGKlXr5G74oXnoA8COPrQSl
         xp3GG5D4DnysPdWs0qsul6IF3EPtDyrgYE5f/KZa3hTA2DJPmN2Qtrclh0eP+fAx0i
         cCic0Hw0fEMLrlBO2q0ko/nkk/i43DexpD5e//2GVBFAAiqfnMMyZmslXZU82Y2boJ
         WgrS6suN1jEa+/vPJGBW3LYx2xAo6pKZ1KhlyGjGjMfOjNtDksmEwb8JrDOv/LsGnV
         PZF3RcnL0Im3w==
Date:   Wed, 19 Oct 2022 18:12:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: dmi-quirks: add quirk variant for LAPBC710
 NUC15
Message-ID: <Y0/wxvySyEn6LyyF@matsya>
References: <20221018012500.1592994-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018012500.1592994-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-22, 09:25, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Some NUC15 LAPBC710 devices don't expose the same DMI information as
> the Intel reference, add additional entry in the match table.

Applied, thanks

-- 
~Vinod
