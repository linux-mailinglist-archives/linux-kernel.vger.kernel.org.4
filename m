Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EABC66117B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjAGUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGUIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:08:42 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173301A202;
        Sat,  7 Jan 2023 12:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673122117; bh=VAaUG2sNmg4eTc3hAgqv7Z82T4siOLFOZ3Lh0pVjc+A=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=HTCvgwSKRzTqmGi15ZZxRzEnHCI6p4X3RbU1FJKIsWPxxpXdHj10XZtG+oWIUNccy
         9Q2KQHbSRa3U3wa/G3fQh5Ds6iMDF2qUFcOhOCQxHUyiij1uIpMyYeWZRcjKSDtVTP
         x4fwkGNMT7WUqfoW60AzpJAnaYjiz5PnnT7kqulA=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  7 Jan 2023 21:08:37 +0100 (CET)
X-EA-Auth: OWnwjebdAmZgi2zP8CDZCSZBLnGWzc4OMAeTxRIYyel698h3QXTZhRETrrZ861mtJeEdqq1r0Yv2moT/q3c0Hz34FCpo5ph5
Date:   Sun, 8 Jan 2023 01:38:28 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] soc/tegra: cbb: Remove redundant error logging
Message-ID: <Y7nRPAeONTYpI4bb@ubun2204.myguest.virtualbox.org>
References: <Y6R2fNJXxUi4Y00Z@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6R2fNJXxUi4Y00Z@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 08:54:45PM +0530, Deepak R Varma wrote:
> A call to platform_get_irq() already prints an error on failure within
> its own implementation. So printing another error based on its return
> value in the caller is redundant and should be removed. The clean up
> also makes if condition block braces unnecessary. Remove that as well.
>
> Issue identified using platform_get_irq.cocci coccinelle semantic patch.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
Requesting a review and feedback on this patch proposal?

Thank you,
./drv



