Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A760E9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiJZUKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiJZUKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:10:14 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E14D828
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:10:11 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g7so31055505lfv.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XJjcndvRpwMDf6AkdEDDg9MyqKlufLFvNcnuKzT4wXQ=;
        b=YkE2nlGxKoF7Fz7xt0BiASpuvf5oUxZNFZPqKciZULbwk7qTHH4GpsWcsD4kHm5pZE
         Cc7NkAA+hZCpQmyPgToqSDJpgYgL7DRT/jcs8Ln6AXYn4i1skfQJmjPISawZzwG6kqMo
         0Vx97SqcfMjzXTJNgoGI9WRhVHv55OSHKKOfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:user-agent:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJjcndvRpwMDf6AkdEDDg9MyqKlufLFvNcnuKzT4wXQ=;
        b=sa0icPVmoBxViTEP5EqoRoh4NmILSCYJ/6NbAVBA6ea9aRsPksFLQ/hsLYI5lEY73Z
         uhMRDWYMwWjbSCV6GvSEkIz1MJZ+Me26Goauhy28EmHRLtqaok4nIIlpIE1rQRSLEbHR
         s7bswFdLBXtOTM4m1Q0Tb5XxalGTtopiTX5d01Np0gRIpKpMZOehiJo8sVJM499SiA6d
         Ip1xwIR0vEiW425ryHajnNbUSPHRjq3snmvz53+ZPvuyiK12j1HT4OhIaAlUG4eLAB2a
         pcR4pk0TP33xS+NlMG9ew79G/XaHF7Sh5W4BQXFbtjQZEaZeACiPBK/GAa3BBW0mzekg
         kGnA==
X-Gm-Message-State: ACrzQf3In02mhewAZrUVzasxjxzMC0yUHL93ZH+YJzULR78AJwzz3Q3+
        v01lkLB8IrZZyVU3Cc3qPDIzrqcLOtO7wSmVUIZ7sQ==
X-Google-Smtp-Source: AMsMyM5Whqc0j93tR8G9mhApkdvNZBGz9Z/7r+uv6RFuidhSpMYKB2VsrL/uBST9y29M9E6QuY2PyVI5Q8tXcT3rQXc=
X-Received: by 2002:ac2:54b9:0:b0:4a2:9c69:ab51 with SMTP id
 w25-20020ac254b9000000b004a29c69ab51mr18705189lfk.297.1666815009749; Wed, 26
 Oct 2022 13:10:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Oct 2022 16:10:09 -0400
MIME-Version: 1.0
In-Reply-To: <20221020225135.31750-4-krzysztof.kozlowski@linaro.org>
References: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org> <20221020225135.31750-4-krzysztof.kozlowski@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 26 Oct 2022 16:10:09 -0400
Message-ID: <CAE-0n518P17N3vN-XStYyMZLofRZSnYh6XmVN3ZztxirZ0M7Ag@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sc7180: align TLMM pin
 configuration with DT schema
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-10-20 15:51:35)
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
>
> Merge subnodes named 'pinconf' and 'pinmux' into one entry, add function
> where missing (required by bindings for GPIOs) and reorganize overriding
> pins by boards.
>
> Split the SPI and UART configuration into separate nodes
> 1. SPI (MOSI, MISO, SCLK), SPI chip-select, SPI chip-select via GPIO,
> 2. UART per each pin: TX, RX and optional CTS/RTS.
>
> This allows each board to customize them easily without adding any new
> nodes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
