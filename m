Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D1D68AA4F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 14:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjBDNju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 08:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjBDNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 08:39:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC225B8F;
        Sat,  4 Feb 2023 05:39:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75FACB80907;
        Sat,  4 Feb 2023 13:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7046C433D2;
        Sat,  4 Feb 2023 13:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675517981;
        bh=2/YxDFXcOP+j7yv1RijiZ+Nm1MuthCu73RGSxSCLnWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltqLdhcJ9RfJoADWiPncr8VJhZe9go6XgGGKDuaL5w+lfmTsQDeeCvuNQsKMVDwOc
         SQstBUrwtO2VDPl86mBIH1KEdaMdZd4Dz9zgX7nPWIu6YvfVI/JyxmrcbYQXaxRowo
         NfAcR6XQuVSVWFikCmwjvs4lgNhhrqPKPEuAjNaUNzW37bcPdWEescrrTl8G58nIOV
         9efM1mgCVLRxaCYMUmh9aDvt+duohTJDVMRuwdBymiqOtZ+hzutv5fYXZ9DqfCZXQ2
         uKX3dIvlqQEwGQ3f6dzcRbCbOlmLwLMdF3Q07IhohOqwFVAiEjllRow/LFTuBJcAXE
         XtzjpD1Ueu8Ag==
Date:   Sat, 4 Feb 2023 13:39:21 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] mfd: tps65910: Fix a typo ("regualator")
Message-ID: <Y95gCQT6kFw8LkqI@google.com>
References: <20230129125515.1313991-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129125515.1313991-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023, Jonathan Neuschäfer wrote:

> Spell it as "regulator".
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/mfd/tps65910.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
