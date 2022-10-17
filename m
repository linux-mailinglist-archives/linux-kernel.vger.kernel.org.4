Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70AD600942
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJQIwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJQIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:52:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC271F9DF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:51:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ot12so23350240ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UdBvOAm2nsNgIpMmEYH/+M6ZXF4FkwnyWuMBjNXnMf8=;
        b=qZcRb3zYq1BDONT7aPTE83vZnL1k1k7FXZhMcoQQqn6G4B6cjYZVdZWfkKS1Bjf6D3
         /PDJEErlo48CtWZ6xxS+vOEVPj3dWmb0sDfwJ4f9h4SBlDPUmcfN3LYKIHbVLM/Nr7hu
         ksdyontuSVXxtaWqXtYOkOpLIBUFt6jXttYU138H34A/VbmwrRmW3B1dmSNapoNrCWa1
         uRNBixClgeERDAxfvpify1vQmFyWJ6oSKxZQwH26OShtpV9IS9Sk0YC9nptY+W753oH5
         FlTQ2YBJnEdrrVu/+OgSjAeA/QtwBwOy0oFuZwdh0T757uIy/j9Osvn6ki1S7lrL6/9K
         GIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdBvOAm2nsNgIpMmEYH/+M6ZXF4FkwnyWuMBjNXnMf8=;
        b=Wa0tBEj9/t26Urn4v6fQn8RFHkxnDnP4w2SawpDx/t41z9BXPrYk94MQPtO0IS7EXO
         z8AIfzZdzzhyFOeZa6AFJ71fQDtuSId21y9chKmSc+hLiI4Bmj3q3ifJt3fhS9r+KbBT
         5wytDBINnjp6mdnHJksvk/Hgh8Tjaj3N3NnLrkYSMPdGABm5MOu8g0HiXgtZ6qOvlUwU
         PZXQMU9IPxov4TJQoHL7bPBJvOCNbVPrdUKCiOqn49JfR2sZKd/qpOp1Lj4oOfjkdgQI
         zwKwmCilPIyY6kL1mLVDTpNnR+BptDMSOJUgQ3KXVKRFEtOjWm4QVr6vGfOhXV2zYYht
         31zw==
X-Gm-Message-State: ACrzQf3yZe7xbtn2U6iummcKYaFGTB9SNuNYf4Ja7JV6/NIiBe2bmui8
        w2QZNe8/L1j950jEvfKUaZIP8UGC1fonFzsEVastoA==
X-Google-Smtp-Source: AMsMyM7+Bz44CiiDh8+cvNHH4qaWCllQFFP5+GYDxc0K8ozofas9V8hCeukzOjp0NkqSBcF99MmDsYwJXteeCMYOQgo=
X-Received: by 2002:a17:907:16aa:b0:6fe:91d5:18d2 with SMTP id
 hc42-20020a17090716aa00b006fe91d518d2mr4723543ejc.190.1665996700550; Mon, 17
 Oct 2022 01:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221007114647.2723457-1-s.hauer@pengutronix.de> <20221007114647.2723457-3-s.hauer@pengutronix.de>
In-Reply-To: <20221007114647.2723457-3-s.hauer@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 10:51:29 +0200
Message-ID: <CACRpkdYBxh-PZmYaR+Y3gQFeC5WTia8LmM_aX4_o2oS7BRnNLg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: gpio: Add gpio-latch binding document
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        kernel@pengutronix.de, Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 1:47 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> This adds a binding for a GPIO multiplexer driver based on latches
> connected to other GPIOs.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
