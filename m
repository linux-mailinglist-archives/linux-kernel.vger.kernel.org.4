Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612F0628794
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiKNRzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiKNRza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:55:30 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942C319C21;
        Mon, 14 Nov 2022 09:55:27 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 155DE1C0005;
        Mon, 14 Nov 2022 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668448526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvgdbptEBFaoI+KNbWE1FHlBiXtddFaf4Y6qrWDfLWA=;
        b=YnaRIgVZg3e4CdZwTwSrRI21mpeIftV3ebF3Bix542KIoJIIDonadeI8sZwQ/ZzeVaImU5
        LwnA21psi51oFbwranIha8Njy6CxpNN1Q1rtQ4fBTkciT2kG6+YUheSD4ADoaK/2jyt4Qe
        yq3PpB/o2H5gmszR29aVtaENgEwdrejcJJ27IUG66/r+CCzSpLBZfWNYdbSZsuBoqpNEed
        55Wf7vzl5uEA4YtRx+bIXu/Kw1kLR9rXSjpAXtaOJVJATPttl75NjmxJnXl4wMPe/SZMml
        AtuUgtgGsgMjPhydi3eWdDNSREL/jgVejhKiXEHbZeQ5cOr8h3EUTYR7E6oJsg==
Date:   Mon, 14 Nov 2022 18:55:24 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] arm: qcom: mdm9615: first round of bindings and
 DT fixes
Message-ID: <166844849467.2094007.7044257062869034432.b4-ty@bootlin.com>
References: <20220928-mdm9615-dt-schema-fixes-v5-0-bbb120c6766a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v5-0-bbb120c6766a@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022 13:02:52 +0100, Neil Armstrong wrote:
> This is a first round of trivial bindings & DT fixes for the MDM9615 platform.
> 
> This first round focuses on trivial changes, the remaining work will
> mainly be .txt to .yaml transition of old qcom pmic & co device bindings.
> 
> 

Applied, thanks!

[1/2] dt-bindings: rtc: qcom-pm8xxx: document qcom,pm8921-rtc as fallback of qcom,pm8018-rtc
      commit: 44b4bf1c7d8ffc398c69bbbb86e058d57f515563
[2/2] rtc: pm8xxx: drop unused pm8018 compatible
      commit: 56da3826fd9fcafc79b83d03922924fc2118a49c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
