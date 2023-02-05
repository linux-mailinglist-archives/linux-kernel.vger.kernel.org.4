Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2214F68B062
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBEOwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjBEOwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:52:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB6A4EEC;
        Sun,  5 Feb 2023 06:52:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CC50B80B51;
        Sun,  5 Feb 2023 14:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44A7C4339B;
        Sun,  5 Feb 2023 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675608767;
        bh=PhFwMfKmlT94SSccqVeyCs3OQPNSHIjJtZZRpjAbREQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S40unBvphTT2CS0N2ts1IOXCPst1Yf5PmuVdcKhHTOK1G1IyuxryPWJcG3zaAM8Pq
         Tt7/eWfFn+1hZNeG+E39s7moRRV458dapG3pNBfTkTugtbAKHVcdVXrxIbEw6XsCnH
         kfaZl9WMiCjGrwgtS4zfSQSw12U6ttXeY8eAo/bujgGzzQhWhzOo0+uuKQu1iRBV4M
         IWPYcyE1o4w6NsIZU3SKl04RQmPAYE+t63r8XY9bBFMLzSnqC8kv8et52G+lkP9KWE
         NppbwgUJH1EZ7MiPZLmSiwylRU96u4jYroKLwTiqGldcXayGbVQdbQd2U6fX9Co2Iv
         ilVIiTCcMk25Q==
Date:   Sun, 5 Feb 2023 15:06:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
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
Message-ID: <20230205150645.549ff062@jic23-huawei>
In-Reply-To: <20230203212501.GA908601-robh@kernel.org>
References: <20230201204447.542385-1-marijn.suijten@somainline.org>
        <20230201204447.542385-3-marijn.suijten@somainline.org>
        <20230203212501.GA908601-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 15:25:01 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Feb 01, 2023 at 09:44:46PM +0100, Marijn Suijten wrote:
> > Update the example to reflect a future requirement for the generic
> > adc-chan node name on ADC channel nodes, while conveying the board name
> > of the channel in a label instead.  
> 
> I don't think we've defined 'adc-chan' as THE generic name. Looks like 
> we have:
> 
> adc-chan
> adc-channel
> channel
> 
> 'channel' is the most common (except for QCom).
Good spot.

We also have that defined as the channel name in 
bindings/iio/adc.yaml

Now this particular binding doesn't use anything from that
generic binding (other than trivial use of reg) but better to be
consistent with it than not!

Thanks,

Jonathan


> 
> Rob

