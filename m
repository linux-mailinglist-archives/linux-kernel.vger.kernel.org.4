Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495C172860B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjFHRNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjFHRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DBB2719;
        Thu,  8 Jun 2023 10:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6842964EB9;
        Thu,  8 Jun 2023 17:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A402C4339B;
        Thu,  8 Jun 2023 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686244392;
        bh=6+JRZqiU7AewFw7RNLWggb98WSNCC6TPNiR7/Ri3VSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUhU2SEf33TrikSZq9vuyNczD7e5d4ZVVFLPnodMSLlHB6wvCLf56LV0lv+DLgw1d
         UmjaEzYHEozhnCKAftUiKahxOKWmMxivbeGYhY7W/lZGIyisLOtPhQ4mlycbwiTTjd
         ZqLkmFCK8HRgKn+2bVdQJnR/b/FtfSTQ2ajH2ODJxjtR66RhN2Biq81BKQ8j2VAM6a
         LxejJZhJ0AEhrSaRCYgJPOFZd+Imh0vWZH0rlYWqi5EZxpL369tWbC4ujaxzRhFra3
         099H1iO4oZ4AKWVhSdKbFp8YOpfqaeXQYJM6wwBq0/aCIkV1LBZiByJKEMh+R7Quqr
         SoNDKfEc3rbew==
Date:   Thu, 8 Jun 2023 18:13:08 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] leds: flash: leds-qcom-flash: Fix an unsigned comparison
 which can never be negative
Message-ID: <20230608171308.GE3572061@google.com>
References: <20230531053559.5702-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531053559.5702-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023, Jiapeng Chong wrote:

> The variable 'count' is defined as unsigned type, so the following if
> statement is invalid, we can modify the type of count to int.
> if (count <= 0) {
> 	dev_err(dev, "No led-sources specified\n");
> 	return -ENODEV;
> }
> 
> ./drivers/leds/flash/leds-qcom-flash.c:546:5-10: WARNING: Unsigned expression compared with zero: count <= 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5344
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/leds/flash/leds-qcom-flash.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
