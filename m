Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAA35F9F32
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJJNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJJNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:12:41 -0400
X-Greylist: delayed 69974 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 06:12:39 PDT
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B927205CC;
        Mon, 10 Oct 2022 06:12:39 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A824B1F924;
        Mon, 10 Oct 2022 15:12:35 +0200 (CEST)
Date:   Mon, 10 Oct 2022 15:12:34 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 34/40] arm64: dts: qcom: sm6125: align TLMM pin
 configuration with DT schema
Message-ID: <20221010131234.e4gxdaixs3acgayf@SoMainline.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
 <20220912061746.6311-35-krzysztof.kozlowski@linaro.org>
 <20221009174621.ecamh76faoibuykv@SoMainline.org>
 <d97b7d32-6e27-5a04-336b-0af6bd92c83c@linaro.org>
 <d6765e12-715a-066e-c6c3-63e0962ee3af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6765e12-715a-066e-c6c3-63e0962ee3af@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-10 07:31:31, Krzysztof Kozlowski wrote:
> On 10/10/2022 06:26, Krzysztof Kozlowski wrote:
> > On 09/10/2022 13:46, Marijn Suijten wrote:
> >>> [..]
> >>> -				cmd {
> >>> +				cmd-pins-pins {
> >>
> >> Is this double -pins-pins suffix intended?
> >>
> > 
> > No, thanks for noticing it.
> 
> Wait, you commented on patch which was already merged. Fix is here already:
> https://lore.kernel.org/linux-devicetree/20220930192954.242546-11-krzysztof.kozlowski@linaro.org/

Correct, I came across this while working on another SoC on -next and
wasn't sure if this patch was pulled in through some staging branch, or
if you or I should send up a followup patch.  Seems you've already done
so, thanks!

- Marijn
