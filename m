Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBF6CAC43
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjC0Ruv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjC0Rut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:50:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F0D1B0;
        Mon, 27 Mar 2023 10:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70E54B818A3;
        Mon, 27 Mar 2023 17:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC50C433D2;
        Mon, 27 Mar 2023 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679939446;
        bh=4ugmWmuiMl+/hfzeF3U78kUMmtkCW7+chKe6rQSQdr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NV3XYmmC26ZpHzeMGTq5WauPcmXuah88PnxJS8WSJY54JWtJYsRlEWRHYQVSD7onE
         3+KmlDginzIoz4Thr0D1MC8o8sWCejzKaO5pvnqZwQqcPjvHyZhS44RxuaAMiR+wNT
         Wb+GS8FRqCIOcAX7WoHGV7YmItOULSLamBS+acl6py4Vv9MJH1kvTjICyNEegkgTPL
         d9kGJc2lyNt7URlOIBFYvjJmXPFVl6Sw9jsdsSzKw9agOQBurWXuM3FzO/zeahTgK6
         dyeY+LP9+ZmJa4UCSTpnRiPBdmHWAdhBEQ25kjpx2Lg/V1eYPRzFxkIqc6Nc1KyIFZ
         j89B7r6hlW76g==
Date:   Mon, 27 Mar 2023 10:50:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: crypto: Add Qualcomm Inline Crypto
 Engine
Message-ID: <20230327175043.GA1882@sol.localdomain>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327134734.3256974-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:47:28PM +0300, Abel Vesa wrote:
> Add schema file for new Qualcomm Inline Crypto Engine driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
