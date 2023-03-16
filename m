Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A383D6BCFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCPMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCPMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:49:58 -0400
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 05:49:55 PDT
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61ED21950;
        Thu, 16 Mar 2023 05:49:55 -0700 (PDT)
Received: from SoMainline.org (D57D4C6E.static.ziggozakelijk.nl [213.125.76.110])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 62ABA40287;
        Thu, 16 Mar 2023 13:43:09 +0100 (CET)
Date:   Thu, 16 Mar 2023 13:43:07 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: qcom-spmi-adc-tm5: Use
 generic ADC node name
Message-ID: <20230316124307.pzuvbacsmjdootfx@SoMainline.org>
References: <20230201204447.542385-1-marijn.suijten@somainline.org>
 <20230201204447.542385-3-marijn.suijten@somainline.org>
 <20230203212501.GA908601-robh@kernel.org>
 <20230205150645.549ff062@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205150645.549ff062@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-05 15:06:45, Jonathan Cameron wrote:
> On Fri, 3 Feb 2023 15:25:01 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Wed, Feb 01, 2023 at 09:44:46PM +0100, Marijn Suijten wrote:
> > > Update the example to reflect a future requirement for the generic
> > > adc-chan node name on ADC channel nodes, while conveying the board name
> > > of the channel in a label instead.  
> > 
> > I don't think we've defined 'adc-chan' as THE generic name. Looks like 
> > we have:
> > 
> > adc-chan
> > adc-channel
> > channel
> > 
> > 'channel' is the most common (except for QCom).
> Good spot.
> 
> We also have that defined as the channel name in 
> bindings/iio/adc.yaml

Good point, let's match adc.yaml and use 'channel' instead.  I'll
respin this series with thas, as well as rebasing on -next to solve
conflicts with 8013295662f5 ("arm64: dts: qcom: sc8280xp: Add label
property to vadc channel nodes"): supposedly that DT originally relied
on the `@XX` suffix bug :)

> Now this particular binding doesn't use anything from that
> generic binding (other than trivial use of reg) but better to be
> consistent with it than not!

Should it inherit the common binding, or was it omitted for a reason?

- Marijn
