Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C71F626303
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiKKUiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKKUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:37:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191367101;
        Fri, 11 Nov 2022 12:37:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BCDA620DB;
        Fri, 11 Nov 2022 20:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D981C433D6;
        Fri, 11 Nov 2022 20:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668199075;
        bh=ovvQiAHLa7aYPPn/sZ8ILqgW47wsNSwgsjKrsWdiy9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzWptt9K7taHqpHapImn3V02c6ZLEhotXpwfxjTFCAJmtStFUAvrtVOI6V1r3MEQV
         bCKCxxLCBCVQ3HDks9k2V04vwxqneDVY5HdnzZbx7hcUKkyzkU1E6pqpWiR79quk6l
         F9J6rrHcGPlKEEkJo5P4uRuYYruE9w3FepUPLKTBQfmsOs/Rjg7EycAjXTwwpvNvjy
         zVtcCqPCpngdrzdWMj7KJUAg5eM5xyQ6S0J3tf3PU7kY1m8GPunv10dZoMDhm9bdVP
         Yy81BfQZNI3hDz7Be4GWin/VL51FdF1HQ+/2CVhNOCbu7Bjm2E0h+0Z/MrFA/KnJYG
         4qfQ+Qe3DQrcg==
Date:   Fri, 11 Nov 2022 14:37:52 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, patches@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add a device tree for PMK8350 on
 SID6
Message-ID: <20221111203752.ilo2ligpaa2fgya7@builder.lan>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
 <20221109111236.46003-4-konrad.dybcio@linaro.org>
 <CAA8EJprNszfyyN9HLYoRK2Y-yUU-NuGd0QacqJ3UhkDjpvokdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprNszfyyN9HLYoRK2Y-yUU-NuGd0QacqJ3UhkDjpvokdg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 12:12:19PM +0300, Dmitry Baryshkov wrote:
> On Wed, 9 Nov 2022 at 14:12, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> > PMK8350 is shipped on SID6 with some SoCs, for example with SM6375.
> > Add a DT with the SID changed to allow it to work.
> >
> > Unfortunately, the entire DT needs to be copied even if the diff is
> > very little, as the node names are not unique. Including pm6125 and
> > pmk8350 together for example, would make pmk8350 overwrite the pm6125
> > node, as both are defined as 'pmic@0'.
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi | 73 ++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi
> 
> Just to throw my 2c. If I was doing this myself, I'd allow pmk8350 to
> receive external SID using the cpp #define (And to default to 0 if one
> didn't use it).
> 

I attempted this, for my four PM8150s in the SA8295P ADP.

Unfortunately it became quite messy due to the multiple SIDs, the fact
that all interrupts specifiers contains the SID, that the labels became
unreadable and the fact that there are label-based references within
each pmic.

But I like the idea!

Regards,
Bjorn
