Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5F6FF3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjEKOQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbjEKOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734542D46;
        Thu, 11 May 2023 07:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45C7264E17;
        Thu, 11 May 2023 14:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACF39C4339E;
        Thu, 11 May 2023 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683814440;
        bh=bYyc3JPBiuHWS2S6nruVuuoElQU0GWCkiV5Nt0LfaIs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k/WodU5XiVdEgCxxECxk+U87jkyGW7ltKiUgYwEOsySjP6DZayrSN4MiyF36hbD6Y
         yUgBHOP4GCp2nybLq7Ml3vGHeaTKQwl0WJGXdwqnirYSsnNl1Rxe7S5q8o4DYGajpW
         kx96qa/qkcFHCOBDJVdJctKAPz65c8qwB5aAWWr703mFdTBtGBOzT56FaXlfCGWV8X
         N+gIN0Kpzfw5ZNANLNB5VXRI2DlFaAukDUAciT+Kkm1ERtNYleAyUsYbp5NgzxXumV
         mW8NVTWcjWJ5WUAw/ef7KDlLhOPAU5ENKfC0hxpZeFfDq14eNJR6exs4vJ35o0Bjqv
         Vq9kP9hZxefzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 922A4E26D4C;
        Thu, 11 May 2023 14:14:00 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v6.4, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230511105006.176979-1-krzysztof.kozlowski@linaro.org>
References: <20230511105006.176979-1-krzysztof.kozlowski@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230511105006.176979-1-krzysztof.kozlowski@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-fixes-6.4
X-PR-Tracked-Commit-Id: 8bbec86ce6d66fb33530c679f7bb3a123fc9e7da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 105131df9c3b27673392a6b7ff356360188dc869
Message-Id: <168381444059.1327.12521589062049370697.pr-tracker-bot@kernel.org>
Date:   Thu, 11 May 2023 14:14:00 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 May 2023 12:50:06 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-fixes-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/105131df9c3b27673392a6b7ff356360188dc869

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
