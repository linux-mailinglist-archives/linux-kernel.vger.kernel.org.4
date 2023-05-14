Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20D8701F8D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjENUku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjENUko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:40:44 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B41170C;
        Sun, 14 May 2023 13:40:43 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-77d46c7dd10so55157863241.0;
        Sun, 14 May 2023 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684096843; x=1686688843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jTLrV1t79VLaE1SDZkVCg5CZRdC8GYzApnYPaUee360=;
        b=VeKFNu0SlE8bemNa4W77yFCM58pPpmOyusQXhEtzIrdPMZaaNekjj3ImZnBcpBRfh+
         D+Vl4urEyIHG7LNrtKn2fSu5HlQrPw+Avxh+f8aK2rI5WnBn+3RF0wOR/DAgntTAJjnd
         /2GfKh+7823LrzeFvh0AyDlcSngzHjYyOkCUSMrC9XVtcnjuLPJLimPrkDmS1nnRMTJL
         6V8eGMDH0gkAYxhMSkA/bMODoxeRqgypT3anK9SvaLdJyf0R4fzMJXe0zBMF3r3o+WsL
         bc8qPx4zXERl93imXnMSTlJTiEorxgocgY1rjcPyoUizkojFojwh57dUzjxUSL0m1Rc5
         zA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684096843; x=1686688843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTLrV1t79VLaE1SDZkVCg5CZRdC8GYzApnYPaUee360=;
        b=QWUrt5CzS0K8GGXUIN1kpN3P2DyQvGtyu+LeQBVgpPgnHZgWHldjHGUNF2zVZMO6L+
         snGatnW6cCfQsL9NpUNvDaAXwZDTlPvhjWZU4ljgcOHLGsrutaMtnPFdloXo9m/DH6qt
         64TmkouCSxOrfu8A1IZW3tclTm+bpyqWrYeZCcxMTPwV4yrypn926nX4TXsrBdJRSiFG
         hv6CxZuJKuO9KL56fovUWOpVUjOpekG8Ys1aKGhfGZh0DppNrgKAcNQfMHaLYEH1UsKC
         TKRuR2NpNFQyPU18HSyvFiwe6EBumAmug1MzgEvy2RZIEAfI5IcLqTakpboQEfD+yjj5
         3eqQ==
X-Gm-Message-State: AC+VfDyL3mPZ/YTNZAm1lofGIvodm5uwgVFjs4cqnDjYIG6cYyN8KmqI
        57dW01o8hscTvYPfuO2gAv4/kZpQYDhHDoyjvGA=
X-Google-Smtp-Source: ACHHUZ6y9YZXHaWxdqjouELzQkYkQAWKzaf6k2ZYKEXCzGFnBNKALy+88XVob9KC7ZCLTOsZDQM27nfQZmdgVGhY5GQ=
X-Received: by 2002:a05:6102:913:b0:434:847e:e57b with SMTP id
 x19-20020a056102091300b00434847ee57bmr8747614vsh.10.1684096842784; Sun, 14
 May 2023 13:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230412-increase_ipvs_conn_tab_bits-v1-1-60a4f9f4c8f2@gmail.com>
 <d2519ce3-e49b-a544-b79d-42905f4a2a9a@ssi.bg> <CACXxYfxLU0jWmq0W7YxX=44XFCGvgMX2HwTFUUHCUMjO28g5BA@mail.gmail.com>
 <2bc64d6d-6aa7-1477-0cd-8a41e68fcc5@ssi.bg>
In-Reply-To: <2bc64d6d-6aa7-1477-0cd-8a41e68fcc5@ssi.bg>
From:   Abhijeet Rastogi <abhijeet.1989@gmail.com>
Date:   Sun, 14 May 2023 13:40:05 -0700
Message-ID: <CACXxYfxfkuo_EOa3TgBC7+iBXFckV3_csvUvLMN3VdfYPCkFQg@mail.gmail.com>
Subject: Re: [PATCH] ipvs: change ip_vs_conn_tab_bits range to [8,31]
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>         One way to solve the problem is to use in Kconfig:
>
> range 8 20 if !64BIT
> range 8 27 if 64BIT

Thanks @Julian Anastasov. I appreciate the detailed response around
why these limits exist. Personally, I won't be able to own the task of
making these checks more intelligent, but for now, I wonder if it
would be okay to accept the range increase to 27.

I am sending a v2 patch to set a higher limit to 27.

Thanks,
Abhijeet
