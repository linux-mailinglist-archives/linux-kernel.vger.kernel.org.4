Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381E6BA365
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCNXK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FF136699;
        Tue, 14 Mar 2023 16:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BDC861A4D;
        Tue, 14 Mar 2023 23:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01411C433D2;
        Tue, 14 Mar 2023 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678835421;
        bh=3RW1LjUe9QdV4fvcdKvel7HMcg0PrtNvXvNC9faqtN0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sxwn7HxWl4vX6OH3+nN5MSfK6/+P4tAOoduG9Wvfd3hLm4xLRedTKHluOsuXEzsbF
         c2/jXdVcO5ZgZSm8mlika/PL6x4jPgIk9ZbbyTuqdaz28QwF+vL5/j9ieb3VhLc7j+
         IiSL6e4OuMLFaLKHRx62KT1qLzapVh3jUARRyoz9WnPKaeOd8hJsXF2EHCqSyuuHTp
         bHLxNsXLiIU28cDa3y1dfuFyTChQ4UzoBZ7NEkxLWQ4Ddn6aLdy9CxaKCFIwHhAqOz
         m98WN2IRSIc8H/RgFgmQs76GW2jTUflApV+YCgbbnVOPS8QZOfXTutfJ/RFcTFVy3d
         KvdYpWVWT+ZlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D785BE50D65;
        Tue, 14 Mar 2023 23:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] Bluetooth: hci_ll: drop of_match_ptr for ID table
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167883542087.4543.16572103480151689650.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 23:10:20 +0000
References: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 Mar 2023 12:13:51 +0100 you wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
> 
>   drivers/bluetooth/hci_ll.c:769:34: error: ‘hci_ti_of_match’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: hci_ll: drop of_match_ptr for ID table
    https://git.kernel.org/bluetooth/bluetooth-next/c/7bbc48103072
  - [2/4] Bluetooth: btmrvl_sdio: mark OF related data as maybe unused
    https://git.kernel.org/bluetooth/bluetooth-next/c/ab0fc9bd67ba
  - [3/4] Bluetooth: hci_qca: mark OF related data as maybe unused
    https://git.kernel.org/bluetooth/bluetooth-next/c/e93d2fbf47e2
  - [4/4] Bluetooth: btmtkuart: mark OF related data as maybe unused
    https://git.kernel.org/bluetooth/bluetooth-next/c/f19083c1bdff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


