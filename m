Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE77110A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjEYQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjEYQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2468610B;
        Thu, 25 May 2023 09:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B35C4619F2;
        Thu, 25 May 2023 16:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D113CC433D2;
        Thu, 25 May 2023 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031320;
        bh=UIf24JuFY8GbUnTCn0hrDOQvEAVSb0BLaysT60eUH7M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=c37fb8RlAPr4xe15/Nh5rUt5TM9E8ILE2V5J1uuD06NcB8Fl9E5HsgYqY0BQw/iYa
         swsUZpe12CsJ99kkOOKEIEmVmUx5JbynWKg+NJOXTXIzd3+XZMpycOIA6qm7v6yDRh
         l8BErV8eUBGLXowmkdZ/picEjw+qYZLU5/JMdiPubGsPiYi+McrfwcG9wdOZ8lsufQ
         mK+dhaGE37TZZHtI51plErqwHeR9bu1JmlcnkNnSYjZeh6uCVeYsq6+2a8ocWCTHcZ
         kLf11R/jQZcIpNzQKkdJ96hHYU36kXHdOZT+oe1WJjpc83WWios5t2JyYWWoyJjCXF
         gK5bxL+EwaXAg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless] wifi: orinoco: Fix an error handling path in
 spectrum_cs_probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <c0bc0c21c58ca477fc5521607615bafbf2aef8eb.1684567733.git.christophe.jaillet@wanadoo.fr>
References: <c0bc0c21c58ca477fc5521607615bafbf2aef8eb.1684567733.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503131684.22756.16438673377728729868.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:15:18 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Should spectrum_cs_config() fail, some resources need to be released as
> already done in the remove function.
> 
> While at it, remove a useless and erroneous comment. The probe is
> spectrum_cs_probe(), not spectrum_cs_attach().
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless-next.git, thanks.

925244325159 wifi: orinoco: Fix an error handling path in spectrum_cs_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/c0bc0c21c58ca477fc5521607615bafbf2aef8eb.1684567733.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

