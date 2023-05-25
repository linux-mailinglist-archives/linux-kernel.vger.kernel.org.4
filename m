Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963371042B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjEYEvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjEYEu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9B83;
        Wed, 24 May 2023 21:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4CA0641CC;
        Thu, 25 May 2023 04:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442B4C433D2;
        Thu, 25 May 2023 04:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990255;
        bh=1t6Ly7zZaRTPYT0Wj/YL6Y1w1AfESDjHkdB3UReF1vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zrub4NTkBM5uqX0E++NwBfIVWGmIwtO9ucosLTx/yNmcqX4Xa74cSW3ZAC96KYyCu
         qssRSyoYfCNFg3nynznw+kuufNZSH6bwgotwkEvQWQJa2hNFL4kfjm/gcKTrGjjdti
         4NmJyMB4OiLt5y/XjIQ0ypQr6b3MIsuGYfzIFHvLDEF1/UJZBkNFiaJIG/0lDJogE0
         ntNOI+6R/KlT2uCVSUEp3LWDVq0JQvF6eCZeW/KaCLR0VHodfFWO9e5JpsxPM4nQiX
         t78S9idCYOp5pxR/83FvxrmABYBeP2xr6ROuxjq3eAv/rQx8HBTi5sk8I7NHXZAV9H
         SEEYeN0HCyktw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v2] soc: qcom: Rename ice to qcom_ice to avoid module name conflict
Date:   Wed, 24 May 2023 21:53:34 -0700
Message-Id: <168499048182.3998961.6545338882046514516.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512123632.3024857-1-abel.vesa@linaro.org>
References: <20230512123632.3024857-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 15:36:32 +0300, Abel Vesa wrote:
> The following error was reported when building x86_64 allmodconfig:
> 
> error: the following would cause module name conflict:
>   drivers/soc/qcom/ice.ko
>   drivers/net/ethernet/intel/ice/ice.ko
> 
> Seems the 'ice' module name is already used by some Intel ethernet
> driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) from
> 'ice' to 'qcom_ice' to avoid any kind of errors/confusions.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: Rename ice to qcom_ice to avoid module name conflict
      commit: 47820d3263a4a7ba258fe2efe26ae5afb5b83036

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
