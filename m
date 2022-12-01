Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2974563FA74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiLAWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiLAWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:22:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A9A2B0;
        Thu,  1 Dec 2022 14:22:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id b2so7577634eja.7;
        Thu, 01 Dec 2022 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpsoa/KZ/MFtUhwUhKUu1uaTU5EwKaD3apFYo6l+v4w=;
        b=CnnpZIk4Y5TQrtxWgX1G+3oXoG69fbybTzsf//lOAmIrFK/jyEXVPu/4+Gw22ZNFXU
         zt4lbyCPhrzTj2Qsf+Rn5UehrL4JjKSP89dH/oOh+LRsY5/CxYAB0xgjRj6eo28e5OWW
         NNHnNGTtV7qDJuis057LrDxobjDSqeY66N4frx7OMLnQYB28ibtsEudU+kTybMIRn0pR
         bkz6o6WQFCuYLJzKGchFxMyOhrPWKAgTjOVIg4iWXRW5j3swi/pbVo1SU/MegnbFC4Jd
         eKGBs3Hdneit2vqlhPHGOyhZkC3tXROhp2bFVLtwcUjNQSnjnKaABP0pt7mk+dR73OF3
         CUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpsoa/KZ/MFtUhwUhKUu1uaTU5EwKaD3apFYo6l+v4w=;
        b=Wb2bgw+PES+JY+7tVim8Xk+3sO0raXTbH6ENJ9JoPxzD63fqwhWVP7ZFZBNRFOxnr4
         dk9X1PZh8yeKRkcQ/6ZXy1F9NYM28zBmyDZNItKxAjoJJq2XnmNST0Vr5gixYmyyXz39
         7ywRHE7C/R2x84SucsJ/T+JQ9/yE6H7XYLkxw7C4TDpNRxivn0svlX0Mz8zSZXP46qxE
         2QBb9pwEb4Yvk67WjQclfTIv+KMBpaGqu1icni+MlUeGeL0uM/+S4mIddx0+vcyzVn/o
         Dpdn7vLTbHuuWBoSRkC8UGTAG40x2WTHGgkr8cSQ/sI3d+h+E+WejKqRIqx2rOTSLG47
         pzEw==
X-Gm-Message-State: ANoB5pne+qFk/K+CR+Jpglpc89R8nu/CsEvU3VHMMXOg++HQjLqHSG1Y
        wKLn5gMgu/5NikceJhobadeheZD0AEkRif3sal8=
X-Google-Smtp-Source: AA0mqf6GcQ8iC1fMivhTvpOEGYH+gexlEFingeJG62JfHI0uueUEWtk/lXrNQ5+LowZXli5oVJYxwI7PNFBSPckA9XU=
X-Received: by 2002:a17:906:6bd8:b0:78b:a8d:e76a with SMTP id
 t24-20020a1709066bd800b0078b0a8de76amr2701167ejs.725.1669933352347; Thu, 01
 Dec 2022 14:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com> <20221201103026.53234-2-tomeu.vizoso@collabora.com>
In-Reply-To: <20221201103026.53234-2-tomeu.vizoso@collabora.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 1 Dec 2022 23:22:21 +0100
Message-ID: <CAFBinCDqL2sHBV=6C78VFPFopJrK-fSoq+2yDGKK3EpwDHufCQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: reset: meson-g12a: Add missing NNA reset
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 11:30 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> Doesn't appear in the TRM I have, but it is used by the downstream
> galcore driver.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
