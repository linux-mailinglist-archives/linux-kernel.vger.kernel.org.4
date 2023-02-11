Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFA693375
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBKUEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBKUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:04:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24E18B1A;
        Sat, 11 Feb 2023 12:04:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id fi26so8274875edb.7;
        Sat, 11 Feb 2023 12:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLRzVQJuho4KRCJYHa+XOexCcN/deBQDupu8wqYPNeU=;
        b=f9xAwBzGmKfJzY1ytfGblS1ZpaOHiYcWLlu+ZfXn5Ac4tc2rAHQLEJ62K7WwNuUpzQ
         wfOSeVi+WkwO2eA2KqapekPYswhm30DhaWBG2uNjMkFmYJ5shFyncpiVa4ZL3J59Ua16
         oZ40Qw5scTSC8NJKYSx+AV7JQ/AUqavgKzHS+U3DMfGRAWJkdAlaKuc7jDJsHfPy9I0H
         VlkCtHrlUwO+OUhU88ZtVMw98SYomNrj9JRigEsUW8JTYEL7UPIFB0pc4DepHS6TQhBx
         oItxC/pLELggJ/RVfME3Fu5xiLST6ZGxLeEeAOeT0cl+CIX48oNTNUF04B5FfzzaK91S
         BIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLRzVQJuho4KRCJYHa+XOexCcN/deBQDupu8wqYPNeU=;
        b=A5abNV0aZZMCo97xMVY4Hi2VvoyJthXMYPUaTj78HZ6gp62L2J1VO4CqFTONgGYz9F
         Hps5QuU6cw0xu/HrDRWgVpBw0G/HFdzsCzMn+5bYmIxWhAR0o7QVlXdZVnOmb7tBMSBb
         Mtcngz8InejtUYHIxDhKEnppNmBnQiFk7Rlhjeiq9Js9Xbo/kvoj869c8LamlpHh4R2J
         Bi2Lf0nEZPVCyUyvN7ftWmGD6HZQgxi55267/eQdVY+95Gh3PNdttTOUTrXTRPgsyj5z
         3qqK8H/TWJJK8NWkvfQlLQlwdEXxv+10svq0saogFjzbnt+mJlFxgDu033cUxE06uLgG
         dkMw==
X-Gm-Message-State: AO0yUKVfE2LFkAlRfXJd5nNXblYFH/UoEhrrOOWxhJR1Tigq9f5HnfxC
        XZ8RUTQv2KY63udLNm7IHzWQ5I0bO+D6c9KDV54=
X-Google-Smtp-Source: AK7set+iuLmPIjCTCCsATcQ+k96fhQjjtBanERgYOBNisbhTPcAGROv3bck5gIb/Q1JMXZMDge77bhWE4X6sEyF8xFk=
X-Received: by 2002:a50:c310:0:b0:4ac:bb37:a501 with SMTP id
 a16-20020a50c310000000b004acbb37a501mr784270edb.1.1676145875605; Sat, 11 Feb
 2023 12:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-6-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-6-93b7e50286e7@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:04:24 +0100
Message-ID: <CAFBinCDD2kF92TWbm3vktnGYF2vi5zJaY4S2Qy32sK9RcDek-Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] arm64: dts: amlogic: meson-s4: fix apb4 bus node name
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
> apb4@fe000000: $nodename:0: 'apb4@fe000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
