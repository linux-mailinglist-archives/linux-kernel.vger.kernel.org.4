Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762F472ABCB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjFJNik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjFJNih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:38:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D630F5;
        Sat, 10 Jun 2023 06:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97FAE61501;
        Sat, 10 Jun 2023 13:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D03EC433D2;
        Sat, 10 Jun 2023 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686404316;
        bh=AwoONQNzWLWoivRPJMx1eaD5Q2g82FrCBTF+KUQq6pU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Y9by2ZsEW6TBZ9IC3MltrDCdzvWq25cpe4AQFc2qfpAWN8c36D8LQgSoIOguI2qR9
         KyXbccgH1GeW4cGej/2a+Gp/CL8PUq1So3ViB+DCR/MLT3wPmNe7m/jshN+g3OKaaw
         wC+JgsKJ5I/Fh9o+JvkIsRurxZH3QcSlY9Cr4THqsLD+8mCsl4qbHwBBZBSLNHNRqK
         mfJC4W6iBhkcmbx7sBtQzV9oCOUhtlZJpB5u6J5X/j9+diliSWIuoo68p12Dwu0u57
         rEBve1sATLCM9A+Ra8Z/KwMZlkOoQIGIidVcRROcUu4k/iKQXX4wsDZJD602dUBmAw
         qVJOpHxzVySkw==
From:   Kalle Valo <kvalo@kernel.org>
To:     xuanzhenggang001@208suo.com
Cc:     pkshih@realtek.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw89: Remove unneeded variable
References: <20230610131734.21134-1-denghuilong@cdjrlc.com>
        <a4bd77fc102a60ebac4e036842015eac@208suo.com>
Date:   Sat, 10 Jun 2023 16:38:30 +0300
In-Reply-To: <a4bd77fc102a60ebac4e036842015eac@208suo.com> (xuanzhenggang's
        message of "Sat, 10 Jun 2023 21:22:20 +0800")
Message-ID: <87zg57fne1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xuanzhenggang001@208suo.com writes:

> Fix the following coccicheck warning:
>
> drivers/net/wireless/realtek/rtw89/pci.c:239:5-8: Unneeded variable: "cnt".
>
> Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>

No HTML emails, please. I recommend using 'git send-email' tool for
submitting patches, more info in the wiki below.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
