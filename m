Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C383A713363
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjE0Ia7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjE0Ia5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:30:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F5CDF;
        Sat, 27 May 2023 01:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A2FB6118D;
        Sat, 27 May 2023 08:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C549C433D2;
        Sat, 27 May 2023 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685176255;
        bh=JPWS/TwdOmrDP3bAilXLTKSHhTzY9cMCJkusV8E0+Y4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RIVD0UAN0fIQcBDS3hqZEECqeCQPULxMKN0dS0PPFeuev6RJALAXdbSt1MiLkfODQ
         7MyPXAgCRJDky6cECRkUdCEuODEWOJWkMrh7rJ/iPcWs/CvyDmUbISdUV4yoEPzjqL
         yzZNTfyhmku9xfspfEcJjvoIqsTHLrRuQqKGq0dIclLYC1XpH+Ph6cX+TtrbRR28Mc
         1sfv6+AZlKl9uYmdmfGFtfyjl+G1V4kHaGWHPheDf71feV3w6cn2poiojStcV5X6TC
         T4+PsWxYLmGphIYRCy2woGA3lzpFe3RgA6dr5/GjUYmATMCf9OWM3AppKuF4yhrYgY
         ZTOXQJOOeoNwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: ray_cs: remove one redundant del_timer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230316133236.556198-2-dzm91@hust.edu.cn>
References: <20230316133236.556198-2-dzm91@hust.edu.cn>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168517624975.21544.1147869212838344605.kvalo@kernel.org>
Date:   Sat, 27 May 2023 08:30:53 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> wrote:

> In ray_detach, it and its child function ray_release both call
> del_timer(_sync) on the same timer.
> 
> Fix this by removing the del_timer_sync in the ray_detach, and revising
> the del_timer to del_timer_sync.
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

2 patches applied to wireless-next.git, thanks.

daef020558bc wifi: ray_cs: remove one redundant del_timer
072210c725c4 wifi: ray_cs: add sanity check on local->sram/rmem/amem

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230316133236.556198-2-dzm91@hust.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

