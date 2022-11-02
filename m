Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2A0616549
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKBOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKBOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AA327FED;
        Wed,  2 Nov 2022 07:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4503619EE;
        Wed,  2 Nov 2022 14:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D3C433C1;
        Wed,  2 Nov 2022 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667400054;
        bh=yJDAKfXR0rwQeQPAXHxlSW65agHfJFahHKs7PZ3/gcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibXiXpsd8n+LNZcXyPpfMfdut8rv145tA8uQnZbUuwp9AKz6autOxtqmAFhorZDiS
         CaopqvNdobuWUhXNSRlgoBfSdvPvDeZS09unQOHqsq3Qycx8R6/rp1XqR9WWiYfCpr
         spLQIbfYrNA7SjWPi5vBoHchcjIMIbB/DLsOAMYS8xou3N0JU7umON393v+qIb5lhD
         aDSk9cF3fBl4TZp0yBHlN9jBTpwvNdfyQwnKn63l+A1KNzjrLavFu8kNhzwKgr4n23
         Kmjwa29OwRlEVUF5ymldFNs0gKzvvYW9uMY1OmbgdP/9YOLjp5sgPe/ZY5A1THlpgX
         EVw58bSxOBOKQ==
Date:   Wed, 2 Nov 2022 14:40:47 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] mfd: qcom-pm8xxx: drop unused PM8018 compatible
Message-ID: <Y2KBbzFsMucTA5EF@google.com>
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v4-8-dac2dfaac703@linaro.org>
 <Y1/qnCyav/S35mRo@google.com>
 <69d57d4e-8a43-f8f5-f491-916197f6f4a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69d57d4e-8a43-f8f5-f491-916197f6f4a8@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Nov 2022, Krzysztof Kozlowski wrote:

> On 31/10/2022 11:32, Lee Jones wrote:
> > On Fri, 21 Oct 2022, Neil Armstrong wrote:
> > 
> >> The PM8018 compatible is always used with PM8921 fallback, so PM8018
> >> compatible can be safely removed from device ID table
> >>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > 
> > Tags should appear chronologically.
> > 
> 
> I would assume that as well, but `b4 trailers` disagrees. It documents
> even this behavior (the chain of custody) here:
> https://b4.docs.kernel.org/en/latest/config.html
> 
> So while I agree with you, I also prefer the tools to make the decision
> instead of humans (to follow the process, assuming the tool implements
> the process). Either the tool should be fixed or the tool's decision is
> correct.

Take a look further down the thread, since this has already been
heavily debated.  Not sure if there has been a clear winner or any
kind of agreement yet (if there ever will be), but until there is or I
until I am convinced otherwise, I'm going to continue on with the
chronological method.

Also, as far as I'm aware, tools like `b4` and the-like haven't been
mandated (yet?), so using its rules to dictate our actions probably
isn't the correct approach.

-- 
Lee Jones [李琼斯]
