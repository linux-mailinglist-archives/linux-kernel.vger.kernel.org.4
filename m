Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B354D69338C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBKUK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBKUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:10:24 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5393F8;
        Sat, 11 Feb 2023 12:10:23 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lu11so23386224ejb.3;
        Sat, 11 Feb 2023 12:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aqvtYFdR0CJM/IKruwD6L9LivhuvudH2/deM4TDKO8U=;
        b=VaGQ+DB+jTkrMi1vkI0YiEnDC+RGJ7VSVTUDGD8WTUI7roAGNy6pbABULsdeKia4fo
         XfNsawqq8ZlXbRbZjM7rquszBkSfaTGZLsgO1IczIFREpZUZhKBSwawQyK9xSAYyqome
         UbTMgEr932yELRVLPmTypXwOZjKZHknWVXy6iaLqwZ7vFN5GMcTuR6LKYMmLw8Cbgs+0
         SgKzB6pUYglNZ/BIML/rD7KmG7heEFNntTKNdM/3hhOQDxTQalLP1jrUycFBewgT0Zti
         ZAO+Cl0Hu2nRbZc5wK+1/2uxujb1mPuh1IQXOXsGM5+iWX34JIvOoB7fB2f4vmE1mln4
         YXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqvtYFdR0CJM/IKruwD6L9LivhuvudH2/deM4TDKO8U=;
        b=z4QHDeRL7HuTcz9iW4TxlB+qRBUEPzRIdmH/mmN5e1lnVW4fvFPT+NnieZrLDaruYq
         ye4tyfvlhebMHN5N8lyuXYNHXtdXwihJjOoSf7rmVFKIDkyPZsdMIOMapwjCm5NwZ1FZ
         8r6G9MaQyc4c7/rIBTG8TdjiMFl3v5rT32IqKcNN9Fzez/DJF6mUiWA+su5wO/HAu39K
         32D7E2W71vOEmxKEnKNyhNZSIZaxZMIYt8KlhLjOHkmoTcgbop72zhbnt0b0fVppUC1s
         e1MqZoM3IqWQwpEwQ+kNMpn5FwumtJZDSN9QFnCRqBRuc942xVkJVuQZg5rIFa+p7Iko
         2q+g==
X-Gm-Message-State: AO0yUKWnpZVpioIBeY/TMRDVjoZQpA35+hoWEM1FxmctUu9fxBBqCtcU
        8rZdddA+AHhDwYsDx+HgQ/y9769lsWuN1MYUqt4=
X-Google-Smtp-Source: AK7set9+5nzM0kGkpoawYhuBJ1IxkbkuleIU6WdPltyPi0WLRcRSqsIRC6icJ8P/TCMEyzHPC97cBkWZ0ueEvmnIapE=
X-Received: by 2002:a17:906:149b:b0:88a:5bed:62f2 with SMTP id
 x27-20020a170906149b00b0088a5bed62f2mr2641855ejc.4.1676146221795; Sat, 11 Feb
 2023 12:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-1-c4fe9049def9@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-1-c4fe9049def9@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:10:10 +0100
Message-ID: <CAFBinCDBwh0KWVXHV4eT=SijHvHUQ-KtwhcV1X9o_f5wHVOTWQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: rtc: convert rtc-meson-vrtc.txt to dt-schema
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
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

On Thu, Feb 9, 2023 at 2:41 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Convert the Amlogic Virtual RTC bindings to dt-schema.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
