Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC825BDCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiITGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiITGBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:01:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA415731;
        Mon, 19 Sep 2022 23:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57C52B8228A;
        Tue, 20 Sep 2022 06:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C40C433C1;
        Tue, 20 Sep 2022 06:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663653699;
        bh=WvR7It9VMuJcNob8/cw0k0P1gSUb9sVtuIxJNxL30tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=je6NryNtkc/4bS3ORgiVNilAkLMKrVyDbeRpORrgwKlVwj9oP1PKIDqlaOvGNG3HQ
         Da3T6h1AvCv80hCUQjKFx+hgo+l6ttud3BqCQ9Cu/+t5gVSJhsDOSzNt1dKZiYf7um
         ReRmVdXb2c8FrLjw9+kkqFWNCuO+mUN7WqYB0pRRDLurMO9xfM+KQIYprEmZRXj8k7
         61dBecW9PNtuP+v0LH/Sws+KTdzMEwchurvua8va1ONvD0whBGfcf1gPC8M2iM9Jv2
         0yOul6pTNNgT1V+y1xA0J7QH1bkvbgViWc9IxALfFRNRIftYq0XTxPNkbKJos3D901
         aQAAxHg+OPoUg==
Date:   Tue, 20 Sep 2022 11:31:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] phy: qcom-qmp: more fixes and cleanups
Message-ID: <YylXP5LSUxFKkimB@matsya>
References: <20220916102340.11520-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916102340.11520-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-22, 12:23, Johan Hovold wrote:
> Here's the next set of QMP PHY cleanups including some non-critical
> fixes of tiny memory leaks on probe deferral (I didn't add a stable tag
> for any of them on purpose).
> 
> Note that the UFS PHY driver does not use the pcs_misc region either
> currently, but I decided to leave the register mapping code in as,
> unlike for msm8996, the bindings do include this region.

Applied, thanks

-- 
~Vinod
