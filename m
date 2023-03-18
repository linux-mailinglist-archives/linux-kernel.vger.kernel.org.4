Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2D06BFB8F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCRQaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCRQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C552799D;
        Sat, 18 Mar 2023 09:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A8D560ECD;
        Sat, 18 Mar 2023 16:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD7AC433D2;
        Sat, 18 Mar 2023 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679156998;
        bh=AtbWDM1b1XIpGRo7m2NM4jhZhIEsMXFc9F32RHnTV28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iMB8iIJTtSXQ+NdBrNljqloJ2P9Y/xMgrznOuh2ymmwV7/7wKl19c8ypEt35+Oe2l
         NiqChXqnHyTjfYmvYJzZ6WdL2Rl1hUOFWve2BALpBW6jkHBuC2oFHC5yEjOrpn1wS3
         y86QbOiIuktLoGuhofx4MgOf6PpK69yNQLyUVUtGSYPv/ERgC7kmK3jQKWegjK54r1
         3Ap9rx3UbUlY9q25igt5BgxiMVjgTPiEJfyv0S7Wa8/KRrvZUddv6EPm4KYrMSdq2h
         aejq/a5Hkf2ioi8iRu0ZaclhlU1WWmKkffgFUUjxxyOqGIvcB3fVMzbT6yABfS0n0N
         E/AnHJLEciYCQ==
Date:   Sat, 18 Mar 2023 16:44:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, phone-devel@vger.kernel.org,
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
Message-ID: <20230318164449.1df8d0be@jic23-huawei>
In-Reply-To: <20230316224450.onx2bldlisfwwp23@SoMainline.org>
References: <20230201204447.542385-1-marijn.suijten@somainline.org>
        <20230201204447.542385-3-marijn.suijten@somainline.org>
        <20230203212501.GA908601-robh@kernel.org>
        <20230205150645.549ff062@jic23-huawei>
        <20230316124307.pzuvbacsmjdootfx@SoMainline.org>
        <20230316174428.00003c4c@Huawei.com>
        <20230316224450.onx2bldlisfwwp23@SoMainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Thu, 16 Mar 2023 23:44:50 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> On 2023-03-16 17:44:28, Jonathan Cameron wrote:
> <snip>
> > > Should it inherit the common binding, or was it omitted for a reason?  
> > 
> > Harmless but little point as far as I can see given we don't happen
> > to have any of the generic elements defined in the generic channel
> > binding.  
> 
> Supposedly the reg property, and now also the node name.  Up to you to
> say whether I should inherit this (and strip out the common bits) or
> just focus on renaming the node name in the existing binding to channel.
> 
> - Marijn

Just rename the node name.

Jonathan
