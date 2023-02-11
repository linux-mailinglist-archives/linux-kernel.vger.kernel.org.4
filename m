Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D376769337B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBKUGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBKUGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:06:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6838D18B18;
        Sat, 11 Feb 2023 12:06:19 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ml19so23502067ejb.0;
        Sat, 11 Feb 2023 12:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HqCtyRejI4LLye8LToLaeilzkCo6PSscuoTSFnoz9AA=;
        b=KWlQuieaEY0T9+WI/Ae3ej9OdlfQLPs87lBnTrDCv4VS+mjwBg76MmJUtIoGx9vQYM
         z4e3nlYktL7uEoX0KS8NjSVA8wV9ZMCuLNlrIwgkaFnEJEp5spWIc3ejag9k+8JDOfYg
         DfMKnQLVnuMXYGgakBwQAzV4jtYT5TFYT93q66YIlzqOm4DvePPOt8F1ZMFVnc66qGzX
         ai5rXXDvHGWemdt49adOuNSjddGoi9eJnIHK5hPKs7/7X6z3dcyuNTae2DikxwIAsl3v
         EYU81ZHGd3gh2euzA0OaLu/Nc0CBRRKHUTbWh8HgWp1qEynKm4Fza9BVhlLQEPNJuPy7
         nk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqCtyRejI4LLye8LToLaeilzkCo6PSscuoTSFnoz9AA=;
        b=2efA5XuVhbebW23JY1mvIMlsD0WG/sjlo0EGF3I+tulNzdRihyyuz25xtW1+Ab97IS
         A5MdESA2g2ZDEtjGwIpsM1WAgMXSDaCffJpgX2gCa2/auNlWB0qK5aB+ukWB0roR5CEU
         8R7nq5A6RJfWmzn6GkCgwGFRagaTOko0Obj0IahRG7HinxAQQNykMQ6i3uqyN4WFZdKL
         OeNQoDZWANhGIAWfyhHuGD8wesZXl8yM4QIO7Y6xcw3IXLqbXu1KOHw57zZ6x5UDANtG
         wf+8FEW5281LB5t76xqdeAXu85AvPqoEt9uHXrKb38HkAtqoTC4t5IqIIt8eJVc1It1k
         jA+g==
X-Gm-Message-State: AO0yUKUqZicU3Y66PVSjSPxTbQsj/fh6XKb/V/GT6cNGG4uHB1XtvwMM
        mhB9J7v1ZjzUJ+Uglx98EGC0On0R9uG7nmOoeGQ=
X-Google-Smtp-Source: AK7set+jUMcBstRu6KjIMkla5m20N/WtKCrZIy0hBuHNgkrs0suDuWtyS0++oPitclH5cc354hte0BFMcD3k+UyfUIE=
X-Received: by 2002:a17:906:4c99:b0:884:ead1:4e58 with SMTP id
 q25-20020a1709064c9900b00884ead14e58mr2627530eju.4.1676145977931; Sat, 11 Feb
 2023 12:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-3-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-3-93b7e50286e7@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:06:07 +0100
Message-ID: <CAFBinCAeN5gUauVpHgj02SUrbDZfEo-MBBE+=KirWnAbsiHsig@mail.gmail.com>
Subject: Re: [PATCH 3/8] arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx:
 remove invalid #gpio-cells in onewire node
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
> Fixes the following bindings check errors:
>  - #gpio-cells: [[1]] is not of type 'object'
>  - 'gpio-controller' is a dependency of '#gpio-cells'
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
