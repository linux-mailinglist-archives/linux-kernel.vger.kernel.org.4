Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E26F3653
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjEASxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjEASxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:53:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0282D47;
        Mon,  1 May 2023 11:52:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94ed7e49541so469855566b.1;
        Mon, 01 May 2023 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682967162; x=1685559162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgDA23im55EDSIa5JWzE1V/HA0U8DNvg6mZYJz1fn50=;
        b=F4fPmZigF3XeUFLuE+3sDNQ25c4xoILFA5P45GqF1EyBfnu+RzjeQUcbhzUYxhXFM0
         MpNH/+WaUe64TqVw3bJRnHKhTr7PImX56TdQb4tPmplrgOTLAARxkrr9JAfUi2B5h4t8
         cgLzaQU1eBKzu65P6j87jZPsCPpfYEaFeiP/3PbCG/j6g0CPZ2CFu1tScMhwRQhHdEwE
         s3hDSAzI3gv+20Dct0YKulbdjv/bd4Tlb6QmLpgMd1JNLTu2j4yNkTNTxvSHdOhoN033
         e5vHsRPnxMCmw4VgZwYr1KyUE7B7tOG4RmpBRbZT7MhFdypRuEtQkLdmw65J9BL4kFNK
         j/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967162; x=1685559162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgDA23im55EDSIa5JWzE1V/HA0U8DNvg6mZYJz1fn50=;
        b=L1vaHU8DyOBCdStmOqRL09flSUSomW0QzA7ATeu+GoB80Z3GPpU6J3fkO4r5PZAujJ
         zwR1kb6fZwemrkTP78xET8y1t/j6hr4EYDPElSrmDZhspmHUVGaslS2puZl4HiSO5GBE
         B3aYwzpxdKHRC8Yu8BIvaTnUF0dVWJ19fb9QoQxhFCrj8mcprPCBQiSlQE0+aCSn781i
         oujjgOwxRC646h/02JxEXVL4fTJRla5PE5bYibmBH7LoRqu2HKI/iSJAZ7EwCYffcrqp
         J0aIy6gZIp6HNVUwb5SampJw8vDyDZOJN24Cyq7rOar9n403qU4E1j4rUi3hJ9Il5xap
         5jqQ==
X-Gm-Message-State: AC+VfDxrLx/U5lwlCBBaQCrS2DoY1bdp94wPdzoDz9Kb9G8s0vVSTOPT
        OEHwQjszgIhwf32ouZwG3NZXbykTVcv21uq5Rj0=
X-Google-Smtp-Source: ACHHUZ6oDPPuL0A65wQP2LLtoEmRC0zmT/D51gM6y5n0OhGbSBcUCwxV1Fy7XqeMdYrBwAO9vmZNPqKwaGswBVxlgqY=
X-Received: by 2002:a17:907:7da9:b0:8af:2a97:91d4 with SMTP id
 oz41-20020a1709077da900b008af2a9791d4mr14989285ejc.14.1682967162079; Mon, 01
 May 2023 11:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru> <20230426095805.15338-4-ddrokosov@sberdevices.ru>
In-Reply-To: <20230426095805.15338-4-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 20:52:31 +0200
Message-ID: <CAFBinCCq5y5PbhKL+9FarxS3jMuM35JDO=O9SVxP0A=nnBUP8g@mail.gmail.com>
Subject: Re: [PATCH v14 3/6] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:58=E2=80=AFAM Dmitry Rokosov
<ddrokosov@sberdevices.ru> wrote:
>
> Add the documentation for Amlogic A1 PLL clock driver, and A1 PLL
> clock controller bindings.
> Also include new A1 clock controller dt bindings to MAINTAINERS.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
