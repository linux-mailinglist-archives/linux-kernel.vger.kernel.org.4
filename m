Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7274362B6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiKPJiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiKPJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:38:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCA3D13B;
        Wed, 16 Nov 2022 01:38:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B1661B3C;
        Wed, 16 Nov 2022 09:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC770C433C1;
        Wed, 16 Nov 2022 09:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668591482;
        bh=jq4Sq7lYxlLmxmVfQimbqudfPqziyGm+FvZJ7JxXJPk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KqHMfkzskEESogcbsk1/87DM90Ae/VvO7LsB/sjJ5f6xpLRdgYoJ/QB+OyNJux2MM
         4imwQBOLj817FtgWEVMyPoFyiFINfdFP7DrUr6txzphU40ZFPjhVW/IZ6V7lGP7vd4
         25mFE40bst9zU6OSj42i59jIYXGa01an9G5aKDsEOie6pqbHKA/+koRnFU3NQR/bpT
         lAWqYBRHoXtrn1Demz8FVK9YI/02trDns7hcEJPb/zHv1tSLovnCoxwfElri6jUpSS
         jCq7V/W8hjmRIAFw/byd+m0REIJ/0FYatzlLLhASWvQO1BARoChKfXt/9eioL/hEkt
         Z0dOtfi/u7MMg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] ARM: OMAP2+: pdata-quirks: stop including wl12xx.h
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221109224250.2885119-1-dmitry.torokhov@gmail.com>
References: <20221109224250.2885119-1-dmitry.torokhov@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166859147683.17701.10193347639724464036.kvalo@kernel.org>
Date:   Wed, 16 Nov 2022 09:38:01 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> As of commit 2398c41d6432 ("omap: pdata-quirks: remove openpandora
> quirks for mmc3 and wl1251") the code no longer creates an instance of
> wl1251_platform_data, so there is no need for including this header.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

3 patches applied to wireless-next.git, thanks.

e14e4c933e00 ARM: OMAP2+: pdata-quirks: stop including wl12xx.h
06463f6e98df wifi: wl1251: drop support for platform data
a1d0b9535cd8 wifi: wl1251: switch to using gpiod API

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221109224250.2885119-1-dmitry.torokhov@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

