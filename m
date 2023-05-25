Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0171109F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjEYQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjEYQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517E313A;
        Thu, 25 May 2023 09:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD647646FC;
        Thu, 25 May 2023 16:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3001FC433EF;
        Thu, 25 May 2023 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031242;
        bh=ZB5EPQUbKqDpfb9ok4JwrHH51/rqG188wIZzix5/NQ0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XB4c5j8hRx3foYptlaefAIhjOCtnnU1WoNMQdO5TdWDnE52Ie+NLFh7JtYyFRgIf9
         4OOTLgi6tvEQCzIczWVaRl4MTN4u0vGE9euJdpag+gu9x5Cgwe6kjHB+J3Nwpi19KR
         c8/JKsUbo1T0vg/rgbsOek9rIPdICv+of1JJcZkET7uqr200/ZGzYB62StezUoLVk2
         WMbLWCHzweQyxNc1If7kmvx5Sfa9iAGJfPGFlqlKsStOQP/aeeH3OrqdgWaOngYoYB
         on1rpG7yTCxYztLoc+U2HMa8X3VgacRE35n9csTdGtA7jTviy12J7xgloq6UnBMPNb
         s/T1bN6sy2+jQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: rtw89: 8851b: rfk: Fix spelling mistake
 KIP_RESOTRE -> KIP_RESTORE
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230522085924.913649-1-colin.i.king@gmail.com>
References: <20230522085924.913649-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503123937.22756.15706511892404618610.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:14:01 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in a literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless-next.git, thanks.

56fc4d482783 wifi: rtw89: 8851b: rfk: Fix spelling mistake KIP_RESOTRE -> KIP_RESTORE

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230522085924.913649-1-colin.i.king@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

