Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34373A7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFVRuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjFVRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F21988;
        Thu, 22 Jun 2023 10:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 698D8618CD;
        Thu, 22 Jun 2023 17:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADB74C433CA;
        Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687456220;
        bh=uXMcv50YZrV44lRrzHLNryicbcL5bw4mfure0TXWuqY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=I0CVtA/XuRYmSK7sLzMNzNclJZ6yqst1BdrfKV9DkFtK5M1GaORHjksHECFnm+YcM
         gEiIkhJfL6uXFEhUey5sl4OnNtQ/4G30eyNTbANO9+lr60QWZpsnn+IuC8Dtz13vKj
         qMPNJ5VQuIujHFJ0ia6Y5a9Q5XWNInoG2J8tfcfdEoHncesfMP8vtU5K0XsRgY1Ft/
         6nYjB2dj5f/tgH2Ngxm3iq7FhIeQyY/iku4b6NzyPBsREsipfvEPgyapI2fxlOo/Un
         Iiz2eB1Xl0vsFhxUkw8wprUe80mHOvcmTY1oTjwULTlO0EAkcSMepxDMV+VhfzQ4bf
         eFQ34zTYZdZSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8AE78C395FF;
        Thu, 22 Jun 2023 17:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 docs: document existing macros instead of deprecated
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168745622056.7216.13092598536929315129.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 17:50:20 +0000
References: <20230622095424.1024244-1-aspsk@isovalent.com>
In-Reply-To: <20230622095424.1024244-1-aspsk@isovalent.com>
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, void@manifault.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, corbet@lwn.net
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

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 22 Jun 2023 09:54:24 +0000 you wrote:
> The BTF_TYPE_SAFE_NESTED macro was replaced by the BTF_TYPE_SAFE_TRUSTED,
> BTF_TYPE_SAFE_RCU, and BTF_TYPE_SAFE_RCU_OR_NULL macros. Fix the docs
> correspondingly.
> 
> Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, docs: document existing macros instead of deprecated
    https://git.kernel.org/bpf/bpf-next/c/fbc5669de62a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


