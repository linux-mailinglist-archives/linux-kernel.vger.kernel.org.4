Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E112167E542
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjA0McR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjA0McN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:32:13 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B957D88
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:32:10 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-50660e2d2ffso65259297b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v0if3bG0az4VVrqjrBAgqmkkRSjBuWgCJhmn0kYqVUo=;
        b=FgWZXTUPi5P9XiCuBQQ7Mban5muT1PCuAYN+0cWoieKvqtgyl0BETa13RIeZruTQcI
         RMlnL/epMaeKzOQBweNCUpVbgYQafunJr0MAQW3/TvrzRwOexZQDDdWIlMiYv3B3TxCw
         JAaM3ihmcnwnT6voKtG6v0nmzCa5/Vs1uAlqRdqztT9iXBELBGQOHR+CyaOD+rjUb+pS
         r6JdwodKRM5lkPtF//UxlDd0AKiRSqjF37It476HLdauFoJe3GYrjo7GgUvsup2sPglI
         VwPK9Df8V36vQ6HzWHzRR1pRwIpcHi394E26eYHS02OgJpMJMT+PAQhk4Dh9ODBTHfHg
         y5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0if3bG0az4VVrqjrBAgqmkkRSjBuWgCJhmn0kYqVUo=;
        b=BPCjGim8BFZePNLr73X7rUwqwuhFKB1DLse05HaE0ioombutoYmGu1AjmMN4hqYXVc
         m3A1yGBazaAbD3/sn0k7lICuW9uW8BZotdC3q6evfHQOhLB2CQ3QgUXckyKvVzjYEooI
         lu6MFwGUEwr7O0Zo+Mwbxd1gooCzMxlzHUa+V1ylU+LCAPsIQyA3a/vyBO+0BgI/SdFc
         VJpLcsT7/p9UiE7MzcCgDomr10EWnlovToLGbKU5QzTtCF6Z1DkX6BosCI9VRtcD3cF0
         yFdH5Nv38PTJszL5PjFkE+wfY+mUGsMm6r67T4LQc7Xkc48L9+8dEJrFPvOd58Eu2469
         Yxvg==
X-Gm-Message-State: AFqh2kpJ2qGBvmKxmvLUj1bMnxAK6XVmLlNpcQaXSYEUEP9E1CaB0Bqn
        i+CYymDeduO8M0fWy1IhyHNEF+5scV7qAZSaS8CzhQ==
X-Google-Smtp-Source: AMrXdXuW9ov/7XYT2FJRuxqTfJG/eiPAHPczrgtkY00TYBLkmPlms6WH7OhqK/K+U7X67YZnbPfgRMOD/fB39Awpptc=
X-Received: by 2002:a05:690c:39b:b0:4f3:8d0e:edce with SMTP id
 bh27-20020a05690c039b00b004f38d0eedcemr3524525ywb.185.1674822729729; Fri, 27
 Jan 2023 04:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20230120020536.3229300-1-robh@kernel.org>
In-Reply-To: <20230120020536.3229300-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 13:31:58 +0100
Message-ID: <CACRpkdYRmTiwdtghDjLpCwuQFzDEYhJiWStkwuphUUsAiOEwcw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: mediatek: Fix child node name patterns
To:     Rob Herring <robh@kernel.org>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Fri, Jan 20, 2023 at 3:05 AM Rob Herring <robh@kernel.org> wrote:

> The child node name patterns in Mediatek pinctrl bindings don't match
> reality. I don't know where '-[0-9]+$' came from, but I don't see any nodes
> with a matching pattern. Also, patterns such as 'pins' or 'mux' are
> ambiguous because any prefix or suffix is allowed. If that's desired, it
> should be explicit.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij
