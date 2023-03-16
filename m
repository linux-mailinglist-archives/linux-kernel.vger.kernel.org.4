Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9406BD309
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCPPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCPPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3E0DDF11;
        Thu, 16 Mar 2023 08:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4969A62063;
        Thu, 16 Mar 2023 15:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F06C433D2;
        Thu, 16 Mar 2023 15:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678979568;
        bh=OrXVMhigiA8rB2VaU/pmDE7ukTbjkGPjqGSgtdDGjOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/VAWowgAK5qxIHUpxhtvTz0MshWDU8MvpmYBW46rThvd2ixV6HMPVbPfeWfSglpr
         2aBCAHgXL3RBvLkFl7e3wZKkexzwqIYQjJqo5eaH8nz7CT1AgSZ1ug77z0dALH+VuY
         B+GHAv/gwhITyHvbSUcGuTMDmW34u6tsdYErAY0FiKDz6k07E7gGCsUIQePdqvB919
         Bdqyu+RcN/oty+Xw+iF7wn6k9bPk0R2+R72Jw7lzdwN8ZUZ4f+DXPMVBbk4JR6dZfX
         aMU8YO9E9Z4GmhRk1FXmscUa6oMh4LadVXrX9PZn2KBKysmv8WIPlivoxhhzc/hVF/
         sZcKzJrImJzWQ==
Date:   Thu, 16 Mar 2023 15:12:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: s5m: Drop S5M8763 support
Message-ID: <20230316151243.GG9667@google.com>
References: <20230131183008.4451-1-virag.david003@gmail.com>
 <20230131183008.4451-3-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131183008.4451-3-virag.david003@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023, David Virag wrote:

> The S5M8763 MFD has no device tree compatible, and since board file
> support for it was removed, there's no way to use this MFD. After
> removing the remaining code for it from the MFD driver, also remove
> support for it in the s5m RTC driver, and all remaining references to
> it.
>
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
>  drivers/rtc/rtc-s5m.c            | 82 ++------------------------------
>  include/linux/mfd/samsung/core.h |  1 -
>  include/linux/mfd/samsung/irq.h  | 50 -------------------
>  3 files changed, 3 insertions(+), 130 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
