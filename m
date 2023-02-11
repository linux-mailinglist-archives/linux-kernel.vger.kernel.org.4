Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F392E69335D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjBKTr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBKTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:47:25 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3ADCEB54;
        Sat, 11 Feb 2023 11:47:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qw12so23329364ejc.2;
        Sat, 11 Feb 2023 11:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vt58wxl/vfRdmQWqW6l46iKB45NYcQ6smTWDkh/oDOU=;
        b=NLIc72SU+vIVYdboVnsBBD3vBlXVZENUk2eaFzn8BWi5K6X/5U6rfMd3c8IHhvSdgQ
         VawWtejPFAra0xaOK3cYkFyoWShCdqs0yHEduYZwLhnJJfCO8LlKjZ6JgdM1+DlQcPXh
         JknfPhwzVNM+vX1HzSawZ6hRyZJUZ0wWUmtfSxsVhH62CyJrUulZfDIyT7CttFTcEK28
         kyxGRzuRr2ihLDClhf6UhhWgaa/13SruTIZNX5tcw64x1l2vp+35KG8qHGs/epSCLCae
         j4KdwDRaewPQtVlpG3qurebAiwGQK6ZLbkpAmgTHbweM95ZWR9KCpy+2aUUHYsHQLRon
         xYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vt58wxl/vfRdmQWqW6l46iKB45NYcQ6smTWDkh/oDOU=;
        b=1esWPwvaayae9UdkTYkcfVI+gYawWTQVY1moM6aRWa9gwGRoSX5KyXa9sd7S5ezQti
         qqS0XViVFWUUQbPr3AmBgnsX/Y885xS/u4NtLLoMBsTv0g5n2pZj+qsfDvFhUq/IrqzZ
         IU31syJ+eQgXPoDbq+NBUMdT79RCTWLHB6C2MnrRakSovct3IyRXGIvW+P3w6N19vu3g
         v8uMU9xtFpmKWa4cV1NvP216LldVn/tdz1xA2yNUc6II0IT6XEIqVELB9IUCYoHgkhw7
         zL/1UKuTvUulrd7cTX9SSpktzULIKzVARzBnZW6d4/v8f4cQjn9JsOfQvOCFnV8Ta7si
         KkVw==
X-Gm-Message-State: AO0yUKXTAhZNj+h0+u3l7bL2y9XV/lT3e4N1yk6f9gZPreIpzsal0xU7
        MIAfbaBXFBnmBtCZ1cOXLQa+r/jJpx46SypUDCg=
X-Google-Smtp-Source: AK7set8TuD+bcbyQ9zbkjELm2cwtzJgDzXWbzgJ17AMPvZMnyzWcMxqOZJAXTwXtATaSt6Bk4olnC2/42tmOo+kSAwg=
X-Received: by 2002:a17:906:4c99:b0:884:ead1:4e58 with SMTP id
 q25-20020a1709064c9900b00884ead14e58mr2614702eju.4.1676144843428; Sat, 11 Feb
 2023 11:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-2-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-2-93b7e50286e7@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 20:47:12 +0100
Message-ID: <CAFBinCDm=5oFLLC6Y+wctWaenM0nmpjKuNjkkWPzVoo1Vg2grA@mail.gmail.com>
Subject: Re: [PATCH 2/8] arm64: dts: amlogic: meson-gxm-s912-libretech-pc: add
 simple connector node in fusb302 node
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Feb 7, 2023 at 4:08 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Fixes the following bindings check error:
> fusb302@22: 'connector' is a required property
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
