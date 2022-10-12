Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315D05FC571
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJLMgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJLMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:36:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32127C7040;
        Wed, 12 Oct 2022 05:36:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAC1EB818F7;
        Wed, 12 Oct 2022 12:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B50C433D6;
        Wed, 12 Oct 2022 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665578192;
        bh=Db+uhFCwSlxVQ3TiIbRMEXABKltWPh+mXJQChhSYZlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i84PNqzlzqRLLjJ2tzk5cG8lz6wp18yYayD0cYlcjx2alRv1ll5b5BRIsC9hJ7loG
         2+52jjuOS3CMxwVByoVhGcGa/rql8sbjR0dB7KTMmwGWIK8PBmX9frvgbfU9sMOyLA
         TTayfJWPW1iy2X1+Ai94/uT/02vD292ZkUR0Zw5696SQpiPshTbs87zCtQuvikhpCW
         dbWZ59uHRY6Pxu1BHUup7j5ny1bamYxxeh0a7zEA8/vyJWXbaEU0isDq3gZTeS/g4C
         zQGVO01Sq8FuoPOrrVZ5zqNSZ5bDqzah/hTTObC3AVH1tggNGEOySqlocpjUV7ykK6
         GFztbC0MZCzlA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oiayA-0008G3-NF; Wed, 12 Oct 2022 14:36:18 +0200
Date:   Wed, 12 Oct 2022 14:36:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] phy: qcom-qmp: further prep fixes and cleanups
 (set 3)
Message-ID: <Y0a0wuhKieNLDamy@hovoldconsulting.com>
References: <20221012084846.24003-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012084846.24003-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:48:46AM +0200, Johan Hovold wrote:
> Here's the next batch of QMP fixes and cleanups in preparation for
> adding support for SC8280XP and its four-lane PCIe PHYs.
> 
> Note that these apply on top of the following three series that have
> been reviewed and should be ready to be merged when the PHY tree opens:

Same here; I forgot to mention this series:

	https://lore.kernel.org/lkml/20220928152822.30687-1-johan+linaro@kernel.org/

which has also been reviewed but did not make it into 6.1.

> 	https://lore.kernel.org/lkml/20220929092916.23068-1-johan+linaro@kernel.org/
> 	https://lore.kernel.org/linux-phy/20220927092207.161501-1-dmitry.baryshkov@linaro.org/
> 	https://lore.kernel.org/lkml/20221012081241.18273-1-johan+linaro@kernel.org/

Johan
