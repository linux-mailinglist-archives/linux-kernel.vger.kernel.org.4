Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944295E5C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiIVHdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVHdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:33:11 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971879A43
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:33:08 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 130so11484784ybz.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vznxy9xqdRmX/+c1xfDYAdYiNLfodMVytirKxQVlqvU=;
        b=19h0p9PeYDDwrzqyam5VPOXf99gXbD0aK5k8BfPEJenh2Jv/WjdzknPH0tUHmgiRHX
         pggTcESbyFCz5wjPpmJSkcd/NQRRrZZiBSfJaMhq7Myfc7diCyDqoIkbuwR+vpE+NSyR
         4tcuq0xXpQnSX0V8U1+heBDJXgld0tSC2LqBM4z3VUSaqRkZ06YHK7IIfBYqUtBTnOpH
         8g3j2HwH0C6U9V4Dw6woPkeBBq7Y38GohOYuh8QKlknbOt7Pa+3U8VR0EHsy5/voiIZb
         V9qFOtQMx6p07AjQGpO7hX3d+YsO1Jyuw006ghhAYb0bZNJ0/92AxLL4Vef3bOqkZOU6
         FV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vznxy9xqdRmX/+c1xfDYAdYiNLfodMVytirKxQVlqvU=;
        b=gh2ei18mRG5OkLcsgE4h/zHfchzx7AfJzwnuv553Vpyx+/cW2owKTyBXzaMzfOZYVz
         eGn4wSs8TOOTU14A7jbpL+90G9v9NKMygTkBe2WJoo3vkgN+Js6YdJ4/xpYETmvx0kAg
         eyShJEhM7XLtmUMiqEt36KHP48agmmFp+U39K32UGwf3PxZ/q6nEGv2H5GmuqzD3FH9k
         avC0ZTHyGunL86CswkO0YSK1Ke33Flhn1NLH3NWrAysVG25Cv1IF7c4P6S/NTu4LzuX0
         cwZAq2XPDEpZ5v22gNznXJrgSvx9D8eyjhXTZjfr6a1UdxAk0kiJtcZbZ3WD0jbxLYTq
         1IgA==
X-Gm-Message-State: ACrzQf33gQ2McwUHDHqdRl7XBPfyWQWyp4dqiLQQgzxddDzqJbMKPD/J
        vDi1mKwAnoTvoR7ikG7C6LjDRnsyudQ3W82mT2hRfw==
X-Google-Smtp-Source: AMsMyM68mBRWPzgSHinmacDlTcXL0xgy38F9UZIPw2GA0HUhSgygjrtVbr+Xf6Xo2IYCzPizO8zkXxrLXkUa8C1413c=
X-Received: by 2002:a05:6902:1146:b0:6ae:72f2:62cb with SMTP id
 p6-20020a056902114600b006ae72f262cbmr2487652ybu.615.1663831987619; Thu, 22
 Sep 2022 00:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220907210649.12447-1-anand@edgeble.ai> <20220919115812.6cc61a8e@kernel.org>
In-Reply-To: <20220919115812.6cc61a8e@kernel.org>
From:   Anand Moon <anand@edgeble.ai>
Date:   Thu, 22 Sep 2022 13:02:58 +0530
Message-ID: <CACF1qnd0Nq7Fzi83emR=-cDscCprt2h4gwquecLRyyrbSNsm5g@mail.gmail.com>
Subject: Re: [v2 1/2] dt-bindings: net: rockchip-dwmac: add rv1126 compatible
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Tue, 20 Sept 2022 at 00:28, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed,  7 Sep 2022 21:06:45 +0000 Anand Moon wrote:
> > Add compatible string for RV1126 gmac, and constrain it to
> > be compatible with Synopsys dwmac 4.20a.
>
> Hi, these patches don't seem to apply cleanly to net-next, a 3-way
> merge is needed. Please rebase and repost. Please put [PATCH net-next
> v3] in the subject as you expect them to be applied to the networking
> trees.

Thanks I have send the patches rebased on net-next,
Please find the link below

[0] https://lore.kernel.org/all/20220920140944.2535-1-anand@edgeble.ai/

Beat Regards

-Anand
