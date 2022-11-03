Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E1E617649
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiKCFn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKCFnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:43:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4112D3E;
        Wed,  2 Nov 2022 22:43:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v7so436673wmn.0;
        Wed, 02 Nov 2022 22:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bRjybSvIy7GPC+qmcyN3TQaFUKfG9bdmHWkue9u5H1g=;
        b=Xr/GoIvALAbW+JDjQAKNYFJbtU6j028csgoe6KTKp90HVOqEPPMF2FFvsLY47xKrRz
         CfXam1/gzf3V83o5yiR07/4kTjWKPXGqvU68Q6od8ze3zQmrpvd5axQb9rlm3avaHk+s
         IBy7yUqIA5HQn0LGdkHJRikkj57WYHlBydJSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRjybSvIy7GPC+qmcyN3TQaFUKfG9bdmHWkue9u5H1g=;
        b=NMj93Fy0p6kij0yoWraHl5ZMxEkT4tnr1FxbDOwSSVbcO3VbUKb2BUgnsBF8BJibES
         uw9bF0tckZJ2B+503jS3p9hyO7izEKzR8Qbn1feQSYuGeo0zbK4an2UHLc7jRH3zbR7w
         Cx1pZf1PrOBNZGHnyJK1/T1JklKj1aq/tXVRjRDyHxal36rW3zkDsxGusv5KMWNno9Ub
         3xpVsi2jtjSVxzBwfi6hXIKQThCh7s38OEzELtzGGTi+CpjCK1K3N5VYeL1Q+wU5Ine0
         vNFC3FpqX3P8PpS7kXSv6ixyS538qwkmeRwlqwD4V0U2sOahqONoTRyTtIxXIzPS+WpX
         l86Q==
X-Gm-Message-State: ACrzQf0CvHQKOesOdD/UgPGJhzDjdK+85e/2Dm6M8ZHFMAWll6k5C4QO
        nGfQpZdWKZs85U8vYhUzV5bhAsaqwHZbCHcNI+Xsnc9C
X-Google-Smtp-Source: AMsMyM68EPBtgvWAMcecAd62+fd5k/kYRpgUwfM3Om5gX0Vc0GE3x7xq4qQ6agBbbWT9EG27dikSueujw1asiaO473c=
X-Received: by 2002:a1c:25c1:0:b0:3cf:4dc4:5a97 with SMTP id
 l184-20020a1c25c1000000b003cf4dc45a97mr25885424wml.147.1667454230246; Wed, 02
 Nov 2022 22:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221103163757.1b6219a9@canb.auug.org.au>
In-Reply-To: <20221103163757.1b6219a9@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 3 Nov 2022 05:43:38 +0000
Message-ID: <CACPK8XeEfuPzGY5sORrWwS_sECH395B3cW4x5YMNDw0-205V+A@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the aspeed tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 at 05:38, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   e5bf0d36698a ("soc: nuvoton: Add SoC info driver for WPCM450")
>
> is missing a Signed-off-by from its committer.

Thanks, fixed now.
