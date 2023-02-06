Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32F68BB17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBFLQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBFLQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:16:26 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B214ED1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:16:25 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-520dad0a7d2so150892607b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XZC91XAGFSD4Jgm836rEJDed9llUVd+tekKed+BLYHY=;
        b=c4rCwoptOb4RPx2NbQSer5RaOsGX6z0nWO+g2UAqEHMgfW2ZCOypnrXNLoiunbqkNQ
         FwQMlncAJSTckq0h6ev2bvIJEs8M7MTAK+Qxhe6lNvkU9ynFy9eBMT6AEohrB7J42zW1
         eMETaw332+79HfYZY5j1hrTCueaMONRcvCWpQSkFFy2KveljdIuptm3QGYgRleRWxDYe
         9T7U/1uTJLQzfA6zStQnVoY6eVhTR56gjaYnlYFDfkzdySKhwXoQNKiRoFq9Yw/ojkzg
         dm0lbd5hg0e6ofjgqn3bqrwEBqvvtEvoWz5hl0q4sQwLAk14Us5jMqtzJROQaxKSgFEI
         gSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZC91XAGFSD4Jgm836rEJDed9llUVd+tekKed+BLYHY=;
        b=uSoeoE94X5UmUQQZNS+PMwu0ppSCDb3EtYcZK6I185waAQNZYAKUVlmHD9kx34q4Yw
         qRIH1PH4WaFiXV51hEAD38TeNkQwAovAFsvxg4fLosdhXvEOZOfMnNDyB3HP2syTnO7k
         9v+3GEdEEXRQptOZIH1DSH7TgHskCe8gwUKE+dvy5aZKBurS9n+IaQNoG0/LtbjhyU1r
         M0Nrq8tKNVZ1jCt+e1KowepMEzOVazFpx1LfD68nSVSLyaKv9xGaoK3jvANm7m+zyPxW
         uiwYO1YnWxR/zvJzCQgjVb0m1c6jknB7YcpE2VzUusWpMl+tqGmW/7A95epPIsBR2kPj
         06kA==
X-Gm-Message-State: AO0yUKXUvBXFSuia6bJCemnFvfOA0VybQ86WmZ5sQoOnIFyWQ9zPoFcc
        e9hNTx+mbpTrQOIglyWoT7vNL7eJQ2ekbWR2EEq4YA==
X-Google-Smtp-Source: AK7set9Oqj9VvQkiilHzqiJ4Luq0FpfpoEheonprr87C40jeFpsD15F4cL3eOi/ZZcW4sDhGb3Zw2WFlYht7iH9JHdk=
X-Received: by 2002:a0d:e846:0:b0:52a:8896:6dc7 with SMTP id
 r67-20020a0de846000000b0052a88966dc7mr46642ywe.130.1675682184947; Mon, 06 Feb
 2023 03:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20230203174645.597053-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203174645.597053-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Feb 2023 12:16:13 +0100
Message-ID: <CACRpkdaKYdDoTqVPogzZc6t1+Ho4-ruj6mWFeZwWcCkM9BKndg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom,sm8550-lpass-lpi-pinctrl:
 add SM8550 LPASS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 6:46 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Add bidings for pin controller in Low Power Audio SubSystem (LPASS).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied.

Yours,
Linus Walleij
