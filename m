Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C45B9D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiIOOdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIOOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:33:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82E8980F;
        Thu, 15 Sep 2022 07:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5453CCE1BA7;
        Thu, 15 Sep 2022 14:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E978EC433D6;
        Thu, 15 Sep 2022 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663252385;
        bh=m6FgdNZfe9kL5wW8u/LqxPTIJ7S228NcqIqaAQZSBQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzdbBwE275PV3GRN2MXYT+x30wDawVP6L2Vo7svd//3xVjfpkp+PI8vlzBBsCIcdj
         wTi2cpTEl2BIPGuComqYBBFOFIUSHD3VttWn18HhWTMMiPO1lrqWHzLXXWQINnjyDF
         NP9NARS2q/dOv56T3OojTTHuqxcNxRgIsdgqSHAQSk8GdC1FKQ7JVqMNdKZfFo459C
         suB0p/MRRZlQjJlaAlZ8R+JcIhl0979XTcd3ettlaxOay+/hRRiH3oHLteZAwArctr
         xNsxmVqa8QVtqYimS3WyPctYQc6dNi/tcg/wy86IsyFddvlWQwkZUpX5mdlGA0jMhS
         y4lSIG3j4gr6Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oYpvP-00058t-Dw; Thu, 15 Sep 2022 16:33:08 +0200
Date:   Thu, 15 Sep 2022 16:33:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] phy: qcom-qmp: more fixes and cleanups
Message-ID: <YyM3o6aSwt0zM0t4@hovoldconsulting.com>
References: <20220914162545.6289-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914162545.6289-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 06:25:34PM +0200, Johan Hovold wrote:
> Here's the next set of QMP PHY cleanups including some non-critical
> fixes of tiny memory leaks on probe deferral (I didn't add a stable tag
> for any of them on purpose).

> Johan Hovold (11):
>   phy: qcom-qmp-pcie: add pcs_misc sanity check
>   phy: qcom-qmp-pcie: fix memleak on probe deferral
>   phy: qcom-qmp-pcie-msm8996: fix memleak on probe deferral
>   phy: qcom-qmp-combo: fix memleak on probe deferral
>   phy: qcom-qmp-ufs: fix memleak on probe deferral
>   phy: qcom-qmp-usb: fix memleak on probe deferral
>   phy: qcom-qmp-pcie-msm8996: drop unused pcs_misc handling
>   phy: qcom-qmp-pcie: drop unused legacy DT workaround
>   phy: qcom-qmp-combo: drop unused legacy DT workaround
>   phy: qcom-qmp-ufs: drop legacy DT workaround
>   phy: qcom-qmp-usb: drop legacy DT workaround

Please hold off with applying this series. I realised that we have a
couple devicetrees in mainline with overlapping register regions for
which the drivers would fail to bind if we start checking checking for
that.

I'll see to fixing those up and look into how to handle backward
compatibility first.

Johan
