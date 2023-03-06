Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A36AD140
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCFWM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCFWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:12:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D56F48E;
        Mon,  6 Mar 2023 14:12:19 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x3so44858605edb.10;
        Mon, 06 Mar 2023 14:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678140738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQg0slzZg+8fAlDz5deuXBW8QY38rTBZok1Fnug76tI=;
        b=oBIMZQXiF4ysixV9IMgHG29ae7wwdzzZreoGcRedvoykXjsLn5p/BQ2jLfY4Y4ikHs
         g7x2GLwBLF0uGQxoz9oQHYyxYnc+Ry71+fSyeboWMsSohDfaiTx0qtj0mDPmXKcpDk0u
         LB6LgpO4FvEg6IkGLIEjK+S/wcOnnhGjv5W8y2YackL3GTtETyX7tBF1WV0EOv7tk8wZ
         /+3FpEMa87r83u5JUEqCy2L3hD3nU/AgS4VGl9z4cZNeHcbuuHT98cr3p9yYXIfsyamW
         NRC1KdegSEMsTEOHtZUn6EU0BN8uq/xB8kwZ+sMs306HzjZnZmyBx9/O11w+6j0Nqr8W
         HByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678140738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQg0slzZg+8fAlDz5deuXBW8QY38rTBZok1Fnug76tI=;
        b=M8vHUGkGCEQrbmBeDqksYfbKu3V6aVb0IT88iQEUB82JcPNAJVSfB0gr6gjO5ZZb8y
         /4o9kZuQwz6PXiU702yflcpuT03fvcbHq7OXQqE2mab/3c0G0XhzrVBKQAw6LFXrelAO
         R31XNBkLFKje2itkzkW/PQ0bzsvWrlSNYkK2eVvgLzeOmAs8g0zCqPTUN+HmBQXRiELs
         vPyretJneLQX82xNGbROXemN4YW3RrlpbP1dTu096ZecM7NwGMhONgDQbaRfMhBZ/ZVl
         FHbgqpasPaTGIkh8G9HIZ09mj++LIRQ+72Zgv8VUMjQ1+/IDTGTJjYFvqdhyaGzOSI2d
         9Mpw==
X-Gm-Message-State: AO0yUKVQUGeWyhBOmOwqKkdUAroSMtJp+YzgdaXrI/k8AwcTHSc0Mgbv
        n/UqUXmuypZpGEbH3N7HU3lcZQ6d5Fwn3zZ0Xtw=
X-Google-Smtp-Source: AK7set/Z6nNofmxV6prGhaxbUj8U/Nwm48ysO8ukEy+mjSgVkQaQKaz6QyPCQf++hothXe4V0bezRPQRroVRwb/ckA8=
X-Received: by 2002:a05:6402:f81:b0:4ad:739c:b38e with SMTP id
 eh1-20020a0564020f8100b004ad739cb38emr8458921edb.1.1678140737963; Mon, 06 Mar
 2023 14:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
 <20230303-topic-amlogic-upstream-bpi-cm4-v2-1-2ecfde76fc4d@linaro.org>
In-Reply-To: <20230303-topic-amlogic-upstream-bpi-cm4-v2-1-2ecfde76fc4d@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Mar 2023 23:12:07 +0100
Message-ID: <CAFBinCBLqEwzgoyN50oksT_ZUEfuPi8GS3=45_OUCb_Dd92MdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: Document the boards
 with the BPI-CM4 connected
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 9:31=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> The BPI-CM4 module with an Amlogic A311D SoC is a module compatible
> with the Raspberry Pi CM4 specifications.
>
> Document the boards using this module, by specifying the BananaPi CM4
> compatible in addition to the baseboard compatible.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
