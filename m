Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB6674B38
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjATEuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjATEtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:49:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72567D0DAC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:43:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB80EB826A5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390CAC43392;
        Thu, 19 Jan 2023 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674161868;
        bh=agbUGJOpRM48rXjHCnwA0EWMxXQAmOrokiPjNj8tXRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMDM8X+JGhZrv40FDVi+Xbq0y1BMxv0941edpqsV0rEmE8eYs967IORb/ws2qfW4Z
         R2CJ6PdhcTa+CGHxTmu1NiN1T/RaNwsR3jl3JN/YmBU4ZKt62JCrkBlq06/rQ2lMSa
         xBABvLhST286HTqtB+a8aKvyWWCIq3TPXLujncdDNm2znEu4+DTR3MQVRLOBcMGB2a
         SHSwYaM+UzGZGSuy3Tv1GKI8FRQLyKdZwfEJlXpe7szWlyoWOO5YwyD4CQVmfWvALG
         cHY1Ha6TSSNbao3gOMj86Sw2GD8IbfhoiL0LpD1A4FrNLpyStGlmy5zRiN8dwQs9Jy
         iANi6PDomCr9w==
Date:   Thu, 19 Jan 2023 20:57:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: arizona: Use pm_runtime_resume_and_get() to
 prevent refcnt leak
Message-ID: <Y8mux1YJib7gQ8ue@google.com>
References: <20230105061055.1509261-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105061055.1509261-1-windhl@126.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Liang He wrote:

> In arizona_clk32k_enable(), we should use pm_runtime_resume_and_get()
> as pm_runtime_get_sync() will increase the refcnt even when it
> returns an error.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  changelog:
>  v1: add missing pm_runtime_put_sync()
>  v2: use pm_runtime_resume_and_get()
> 
>  drivers/mfd/arizona-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
