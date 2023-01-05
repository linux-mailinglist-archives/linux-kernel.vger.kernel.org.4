Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C465EF9A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjAEPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjAEPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:02:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD35BA03
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:02:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 496D6B81ABD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2C0C433D2;
        Thu,  5 Jan 2023 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672930948;
        bh=Tb6BAjATpEVzWQOpY1xW7sWivUuODjEg5I5sW/3Zn6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhOV1pecV6WUNfCJNEzM2VTeYsDcU33gTNJjZKSFslmeNCTGJSMEehmOyxVZBbAvQ
         9Jo3T0qOF6jy5xfzlt69n9cNPFPWUsasxFSOY6eAxrOFRfF2BQ5kFnIA5NgGbIg6dN
         HwpK3aAr+tSk+9cFH0JaFO9oKQzFzxX3AFPvBckss7g5cYR5BnvP0bGfqzz/mWvrbo
         EJgblO+bu4x83VIdDYUwa6KGlvJZqtT5Dwfj2G336jCRS+RjqNyM1BAayCebMbEVBg
         71147s++FwvCIa8HMlFSai+g4RrI6jsFGtCyBiODb6BO9bVYYIrgxh2nx/LzkA7U3a
         HNjB+D7DAzi+A==
Date:   Thu, 5 Jan 2023 15:02:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mfd: max8925: Remove the unused function irq_to_max8925()
Message-ID: <Y7bmgGMWlbFL2pJL@google.com>
References: <20221227081805.54185-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221227081805.54185-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022, Jiapeng Chong wrote:

> The function irq_to_max8925() is defined in the max8925-core.c
> file, but not called elsewhere, so remove this unused function.
> 
> drivers/mfd/max8925-core.c:472:40: warning: unused function 'irq_to_max8925'.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3561
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/mfd/max8925-core.c | 6 ------
>  1 file changed, 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
