Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1A66328F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbjAIVQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbjAIVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:15:39 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318F83F478;
        Mon,  9 Jan 2023 13:12:43 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 19D69240005;
        Mon,  9 Jan 2023 21:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673298762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N0XPASlGe90fFlRfItezwOEQn/8ZZRtpRJg8H1ZFEkQ=;
        b=PMNXxsHCQQ3tBxLzeGpPZ84qd1osPpfy9tBF340U8UEIOtSt7Zb76wsV/TGKxHSxf+CMcf
        3LWaqLNvIbmUI5JLG9Pw+Lor9kECuswlA1rKDh8YqxaTFvnm9uRbVVmd06pcGmxl/SlN6C
        fr6tgdU8FxR5G9ppUx+2yGdEvbRNvRoEbSaefX2l7T1gH1MH1s4u0Eosn0GB3sTewVkDIH
        zrAsozxN67KHbZH9cTp6z9sIBeOhlGEPeegN4w9nFlv3aFSshrReyg9vv6ZKCJvZTGtN0/
        2W5xELfh6LUiTEbYQO9Ha2cdGgZm7Ef0pg5WtJUEne+/HPCQ8sJFFvPNEgRyIA==
Date:   Mon, 9 Jan 2023 22:12:41 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source'
 property
Message-ID: <167329874507.49370.13680601587637257482.b4-ty@bootlin.com>
References: <20230104095612.6756-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104095612.6756-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Jan 2023 10:56:12 +0100, Johan Hovold wrote:
> The RTC can be used as a wakeup source on at least some platforms so
> allow it to be described as such.
> 
> 

Applied, thanks!

[1/1] dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property
      commit: 51b3802e79606b2326f4a8cac0f2766a2e15338b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
