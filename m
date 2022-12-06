Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB37644B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiLFSWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiLFSU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D73FB91;
        Tue,  6 Dec 2022 10:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F17261847;
        Tue,  6 Dec 2022 18:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB8CC433D6;
        Tue,  6 Dec 2022 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350809;
        bh=NUnCXBA5tmAt67OQMSbJVz2MMAaif1ZMSY00dzogGhA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XjwxXHPBh5CS1W9BPSpSTa8NPyUxmz25A1zZRAOK/SjFT/ITk8zhLpugxNVgti1b5
         ZbfHBNW2oOPk4yZM/xhZS/ogZrOcS05LYEHS0HOjYseYSdSB99o1osp+YI9KApigtR
         WuvkRyIl6BAlIJaak4vrlBVVKgmeT/4v7VacbNjndjIFoSUBZ+9lMYxQQx4qc2w/ab
         g5Gc+542X0yobLbLU53yIaiK4Tiv9/X3n6bkVKfdG9KiFzuxIB9ucdtTgOGa1qyOc0
         ftRQlqHZ5lrT2hBgcyL9ViyyAcb//1QbC7m1Y9wUSrYfRORww6AH3yXs5u5sktbUhX
         EqIIXH333cchA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
Date:   Tue,  6 Dec 2022 12:19:15 -0600
Message-Id: <167035076359.3155086.292698735801299718.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
References: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 13:13:07 +0100, Krzysztof Kozlowski wrote:
> The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
> changed to take sid argument:
> 
>   Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error
> 
> 

Applied, thanks!

[1/1] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
      commit: 51f7be212ae6c9c09e77d17468fe26485f79836d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
