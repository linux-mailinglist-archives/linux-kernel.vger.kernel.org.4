Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D62728606
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjFHRLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFHRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D62697;
        Thu,  8 Jun 2023 10:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC5264EB8;
        Thu,  8 Jun 2023 17:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4FAC433D2;
        Thu,  8 Jun 2023 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686244303;
        bh=2Z1ulSCU1towb2T5WfCRfHMRMrVfzyLDz4GwAAm7OkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wev38J85S9cOrKcpVsJpXMDnRp+sOPTXFZ7OjLP+VGgyYd67glHPIWKvBWBhjX3lg
         +KMTC4D6GfT+Icm4cIHsGbsGe3X1yy2Dr5kaLpNybuQJ6PWiYZwhoJhMaiH1RBuTWs
         45iJjhFG9pD56BtLXIeK76GG/UPpAMDbYu9+JTKJoAeEZ4+rnb5DzHCjpVQWNFox+f
         hgO+oxi2Gmo1jJFr0VG5CzGk3FxpDjpts/hYG0YkeZKz1PcvlQgSDbskekRvgaeZVJ
         +r+SvYdu6HM0wGzeYeiEuxofaMAUj4TnRlOL+ZRAQozvdX+Etd1usMpmXI8r6dMnsh
         6/CjBvo0s8VCA==
Date:   Thu, 8 Jun 2023 18:11:38 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     pavel@ucw.cz, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] leds: cht-wcove: remove unneeded semicolon
Message-ID: <20230608171138.GD3572061@google.com>
References: <20230531024020.106641-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531024020.106641-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023, Jiapeng Chong wrote:

> No functional modification involved.
> 
> ./drivers/leds/leds-cht-wcove.c:193:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5343
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/leds/leds-cht-wcove.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
