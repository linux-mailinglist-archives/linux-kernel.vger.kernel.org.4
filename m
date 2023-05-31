Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32A0717DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjEaLKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjEaLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F53C123;
        Wed, 31 May 2023 04:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 131C7639BF;
        Wed, 31 May 2023 11:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E640C433AA;
        Wed, 31 May 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685531421;
        bh=VxuY/fz45/1OPprJtBqqQvLX1YX5laMRp+5DrTcdACQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BE11DllLNI9e0jidWZPmC8GwYt4PYrmVI3Bx0oPMxpoh0nbWSOjXfEnVPfCfbCET2
         2EN+M81Y4muvpD39kMSTuzFxXKoTo6U2RZBVqHlbW8hkais6TeNdyJgHtSq2hoYIPi
         qY63nReaA/dWpbPmDDMM3rAMqCEKVybTMhbcfrX0KcpsMTRbSH8XutBqHRZGd+9xGb
         SemGsABjXPvoixj5UzWdWZXlHCMFYEhQHMsnkjXk4Ph3Q9HDwOU0BpHwPb7dS0oNKC
         andSZ9xAntGQEAog/NfN7HolOLstAXyHOZvfGp0mz1lbKo+XIDKMgFHYBtSddnrn3I
         qTYiyqqzcpWfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37E97E4D002;
        Wed, 31 May 2023 11:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Replace all non-returning strlcpy with strscpy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168553142122.8778.8422261276573581725.git-patchwork-notify@kernel.org>
Date:   Wed, 31 May 2023 11:10:21 +0000
References: <20230530155659.309657-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230530155659.309657-1-azeemshaikh38@gmail.com>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        linux-hardening@vger.kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, iii@linux.ibm.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

On Tue, 30 May 2023 15:56:59 +0000 you wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Here is the summary with links:
  - bpf: Replace all non-returning strlcpy with strscpy
    https://git.kernel.org/bpf/bpf-next/c/ffadc372529e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


