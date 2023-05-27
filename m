Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89266713413
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjE0Kk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjE0Kky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AFFD8;
        Sat, 27 May 2023 03:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD4A61E19;
        Sat, 27 May 2023 10:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8C6C433EF;
        Sat, 27 May 2023 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685184052;
        bh=uTfcgi+lhkriPaXy2kU439QU60IlPz9ZzUpA1gh+Li4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxZdPIGVAWhALQGmiG9+jgxdfOOKkje5eZjF9o/rk60AF19aSguj+h9UTDXzhGpcQ
         e4J0kwdQuwgEzbp/PVcD5rMYzA6MbxlP1yPBcenM2Iik68XOcizaJmQ3G1uzB3t7BC
         GGr9xhNt/kqXYjHUC9K7rRlmluB9fOfjM1xOopbMlqgSweNG7Dwr75MOc8MlJR9uB/
         CXpUTJ73KJuNFuSXG8Lrjd8n3Mlrw52ZuK+F64BgR/5lYmC9FxlzKBFXyxOt96k2wj
         E1T5/ywzITNQqM372SjAvquJUf3+PoYQMsY3GbeOExN1HzPIfXkj66Iy3UAKHrxE88
         wAO3Pq4PFkZ2A==
Date:   Sat, 27 May 2023 16:10:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: qcom: add proper error paths in
 qcom_swrm_startup()
Message-ID: <ZHHeMGzeqQlNnc3x@matsya>
References: <20230517163736.997553-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517163736.997553-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-23, 18:37, Krzysztof Kozlowski wrote:
> Reverse actions in qcom_swrm_startup() error paths to avoid leaking
> stream memory and keeping runtime PM unbalanced.

Applied, thanks

-- 
~Vinod
