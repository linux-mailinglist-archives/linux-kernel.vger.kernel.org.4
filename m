Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9006362D9FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbiKQL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiKQL4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:56:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4098BC15;
        Thu, 17 Nov 2022 03:56:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0F5EB8202A;
        Thu, 17 Nov 2022 11:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803E1C433D7;
        Thu, 17 Nov 2022 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668686164;
        bh=9Fkhxq4OVC8lI+gbq2Q+peNCgyo1mLExv7tuyLyzo6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3AEB9Q+Mk9s7FrPOPAT6vFDwzYtMPJjFx8pfI7ryuN00HjT4ITbAZzEjiuhbGmzp
         NyHj1P5/jBAUlQQL7ZSIWzBxEwjRdQ9WTxkJvzH4c88r7prmhM1zLAl9OoArll3M6x
         ZM1YwDiOZpK93F9OkdhIjPGR9Z1bXrFsJnE7RH05oRwIRr4qAbaaEA9sMXYZ1Kf3sH
         kiDASmrrkeEdzktw6gkaf3ZCmSGHVEUOADmR+JCemKw6BnlmrmT7Ga4fhnnHfMHa4x
         vmeuZhDbAefiXuF4wBcjQpdM5gf8+aKk7oweDVsvE0ifOYWvuoxJ7zcQ+YshY44OwA
         zN3CyXpmI79jA==
Date:   Thu, 17 Nov 2022 11:56:00 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] mfd: palmas: Use device_get_match_data() to
 simplify the code
Message-ID: <Y3YhULhpCy2lIptO@google.com>
References: <202211171952240424511@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202211171952240424511@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, ye.xingchen@zte.com.cn wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Directly get the match data with device_get_match_data().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/mfd/palmas.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
