Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95141697898
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjBOJE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjBOJEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:04:25 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA00301A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:04:23 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5258f66721bso252517387b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oY1nkRMg5xIYxJkEJudISp1SsePMPZsPbFvRS2TeTYY=;
        b=rbaWe+oRzVt/2SLnetpU2Uetj0VRu5i96tclNSePLjUiG/eeF6v2jHAVV+KonBcNDb
         v27l30iursquX/OPnVQ8FueErDRIpLPGc8LDk5Y61NP+6j9YsBMGDjsZyj0GPrH8XVBt
         IKckUdR/bYdLNTBpDUhxP3Hprta9kEe8Xs0qP7tYlxlDQfRle3Jx7ePaqkyWg6Ns4Hwr
         GOP9VKetqUZ1xbptXVWOX13bFKj5ySVw3ieN+CjuzghA/sjQ01x+On3gKCTryVkx2mTB
         tK8uX1jAzi/T5jUCnwW3W3GjVJ7NLJRDOffeYSjLzrW/EyAIUV6BASdvTs4Rn7y9I9uB
         /82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY1nkRMg5xIYxJkEJudISp1SsePMPZsPbFvRS2TeTYY=;
        b=dAo2FbK97rpIO3GHJ/xqFKFgpUFb+LMPIQMEz17WF/PGCHI+NKffyzbzDJ+uI4f51K
         hxJPgnYAV3ROBJDhjkCxCBCGJtHcVgsCMQxsD57J+kZjlSMT1o+bXfNtWR90p34IE5fS
         AVKWbSCw5XsvJO1k99yvPK673FvSKQsNqZIwh9WvbsMv6y6rNXoEBroe0PImSkS/co30
         Fw6edM4WlKqxpEL93Q32PmQWGu2y87P5AmvW9VTf3bj9s3JoMmAsbt/Ux3pVf/vXWDjd
         9qnKW/HQT0YKxbK/V4lDM0BGLaOVxQpYmveEpTfM5gupJtyXWxCHKMRNxcBI2WrAEmcm
         KVFw==
X-Gm-Message-State: AO0yUKVOpAOrhZh+qbfNPGGxij0ELOROJ5xx4IYgO9itC8VfJdOXXVd4
        Y1iBefYPJ1Xc/AbYQNAcqjsWzHmNKTiAgYTFPo6Ufg==
X-Google-Smtp-Source: AK7set/fL3py9MtVnDFb7krzubxSrlxFlH3/cnycfcvpNmIE0uFAsbEzQ91Z9mMtjkDuqLB9Qeto8GMaBNULqAVkmrs=
X-Received: by 2002:a81:a008:0:b0:52a:9161:f533 with SMTP id
 x8-20020a81a008000000b0052a9161f533mr238975ywg.64.1676451863017; Wed, 15 Feb
 2023 01:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20230214092838.17869-1-marcan@marcan.st>
In-Reply-To: <20230214092838.17869-1-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Feb 2023 10:04:11 +0100
Message-ID: <CACRpkdaQ6L399pgPAiyOtXkAYhfaOdPWqvVjXacDt0+-Oa7N_Q@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: pcie: Add BCM4378B3 support
To:     Hector Martin <marcan@marcan.st>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        asahi@lists.linux.dev, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:29 AM Hector Martin <marcan@marcan.st> wrote:

> BCM4378B3 is a new silicon revision of BCM4378 present on the Apple M2
> 13" MacBook Pro "kyushu". Its PCI revision number is 5.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
