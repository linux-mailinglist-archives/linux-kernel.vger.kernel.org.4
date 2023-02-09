Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2286C690FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBISB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjBISBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:01:55 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A811EC6E;
        Thu,  9 Feb 2023 10:01:54 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id y13-20020a4ae7cd000000b0051a750e2ebdso284667oov.5;
        Thu, 09 Feb 2023 10:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uXKMw3CnWvd07yk4D0CawzeJ8k3+epYck/BaWq0jMo=;
        b=t3l5jlpXLw0PNpO/TiJdWZfGvE/xgoQeJupYgwn/GFbo/evUO5wAJqll7uBddZVhOg
         kwIqhoQgs25+YwdjQD1JzoAvm6VuduFkpJSn5NnawBXopMKk2kta4BbD8IbpmWlAy5aL
         4H16uGQ/7rzS//7jXTQwEGFzAPKBGcO6o9crbJ7HJ/eNQ5cHMQCc4dSIBA2FUFsR7jeD
         6KcOO3GWu+7zu6rYXbIY+WTNs2HuPz1nJnsK7Vh2u6EwV+X93haRhBFVmwtTfcAgIREm
         3P5/ZxQuKw0hIWYl3Bp+bpXOEF45CE2HZGEdQeX1YTyCTUQeMZ3mFeUoN03UNegoYkIe
         6bRw==
X-Gm-Message-State: AO0yUKXQvGRO9HFTdp608+PQMC9EhVcYHD307ajRcc3J8wWpPrSmz6Fn
        RfefnqD/NmK3W3YwcNncqs8nWQ5xoQ==
X-Google-Smtp-Source: AK7set8BHwi2Mg/9TH0yoo5yqFdLv/jANs3r1F3Qlzjkw/AlCETiMUXTWqQEJnXYt1OoX4R1eVAhqg==
X-Received: by 2002:a4a:87:0:b0:517:5a19:a10b with SMTP id 129-20020a4a0087000000b005175a19a10bmr5773110ooh.5.1675965713390;
        Thu, 09 Feb 2023 10:01:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y19-20020a4a9c13000000b0051763d6497fsm978523ooj.38.2023.02.09.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:01:52 -0800 (PST)
Received: (nullmailer pid 573389 invoked by uid 1000);
        Thu, 09 Feb 2023 18:01:52 -0000
Date:   Thu, 9 Feb 2023 12:01:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: mailbox: qcom,apcs-kpss-global: drop
 mbox-names from example
Message-ID: <167596571155.573340.6167349963011822791.robh@kernel.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
 <20230208101545.45711-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208101545.45711-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 11:15:42 +0100, Krzysztof Kozlowski wrote:
> Qualcomm G-Link RPM edge bindings do not allow and do not use mbox-names
> property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. None.
> 2. Previously was sent as separate patch.
> 
> There are no strict dependencies. This can go anytime. The next patch
> (glink-rpm-edge) should be applied in the same or later cycle (could be
> via different trees).
> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

