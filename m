Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD5A5BFFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIUOYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiIUOYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:24:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B3E08D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 32B4ECE1D8B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 14:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AC1C433D6;
        Wed, 21 Sep 2022 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663770272;
        bh=904mMagjz0knoTeIn0MvkREEHrwQxEW/vfJtRi7pIOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPkjR03hcyx+vZE8nmZuztnig9GIokSwKJ0cLMRzFoQSy2QzN4u+nMqIZIE2FBx2h
         SmneR9kiTDdFr/cSYf8/KwwyeEfPC1W+xus0l/Cxx37nDXzCagkF1QIr1NgSdndF55
         r/WEOKX/wa3XdW7nV/0bA3sSRFtzrEmzzMrq5iPQ=
Date:   Wed, 21 Sep 2022 16:18:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, leo.yan@linaro.org
Subject: Re: [GIT PULL] Coresight changes for v6.1
Message-ID: <YysdLd2Pfmjx3N7D@kroah.com>
References: <20220920092238.3798762-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920092238.3798762-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:22:38AM +0100, Suzuki K Poulose wrote:
> Hi Greg,
> 
> Please find the coresight self hosted trace subsystem updates for
> v6.1. Kindly consider pulling.
> 
> Thanks
> Suzuki
> 
> 
> The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:
> 
>   Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v6.1

Pulled and pushed out, thanks.

greg k-h
