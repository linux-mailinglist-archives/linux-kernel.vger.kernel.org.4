Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD0708D94
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 04:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjESCAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 22:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjESCAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 22:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B72B1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 19:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FC96539D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E292EC4339E;
        Fri, 19 May 2023 02:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684461619;
        bh=5sOQHQ9Kucc4cxOLrcur6qfX+1wsgfuVZWtUJ50lEPE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EqCpmX7beQRULXUiNGQKrXJiL71Mh8t41y8i6OecWSR1X0rSBtzvHW3SjlNme0v1E
         JWybiszk1ABLgjcSERud7FlYvTSnXRrSqIiwkB0DdBaiby5J0P4xhDQ6bFRfU7UmC4
         3EXHU9BJK9OWlKuEIaKHNyZKdFlVaGEoV37J9E98WdmBv0KJ1eR8dyFd5s4CMlDTNb
         Pv9ZtdinN0bWEGH0lXj5qry/uHfcpHlIZbaNnggWhgD0uVkL/sjKskvYA2OprwDDKd
         0kvoqA3RQzVcyyk/UErJBxjKx4IHjfXTATWQwU0+nuYJpT4ftj80C6QQ3n3hRUQE/D
         GFywBV1e5/nAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7A67E21EE0;
        Fri, 19 May 2023 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: cros_typec_switch: Add Pin D support
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <168446161981.25987.15931742013465277857.git-patchwork-notify@kernel.org>
Date:   Fri, 19 May 2023 02:00:19 +0000
References: <20230508183428.1893357-1-pmalani@chromium.org>
In-Reply-To: <20230508183428.1893357-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, heikki.krogerus@linux.intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Prashant Malani <pmalani@chromium.org>:

On Mon,  8 May 2023 18:34:27 +0000 you wrote:
> The ChromeOS EC's mux interface allows us to specify whether the port
> should be configured for Pin Assignment D in DisplayPort alternate mode
> (i.e 2 lanes USB + 2 lanes DP). Update the function that determines mux
> state to account for Pin Assignment D and return the appropriate mux
> setting.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> 
> [...]

Here is the summary with links:
  - platform/chrome: cros_typec_switch: Add Pin D support
    https://git.kernel.org/chrome-platform/c/c9f9c6c875d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


