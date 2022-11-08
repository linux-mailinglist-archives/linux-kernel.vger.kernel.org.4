Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B293620D49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiKHKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiKHKaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:30:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3F9614A;
        Tue,  8 Nov 2022 02:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7420E614F1;
        Tue,  8 Nov 2022 10:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1302AC433D7;
        Tue,  8 Nov 2022 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667903411;
        bh=QScj0SPWiAoUuCjvCzfGcgNluCdjviFFK4yyG9xTUTA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YWeCvuNtkh38gLaCWRbJiHi7ors2Xznh8Ga26ofr+FraGaVxfBYsDBaFTWDbuOo8k
         2eNP5PJ7pwpEfqgrbLNUolY3p57MfQ3f1T3h4UFrcA4lsgYqVSVV9NlhceHCYwgD4r
         i2fOC7cHZI1+JyDnF67KKQ/L4tgOdcWgtoABweRdmENvYqzw8BaI+guMHTkKipBUcI
         +Y/dZ1KUDzYJgymyRBPkWNMALOF2RQd7+z6ixvxZ6xCMbHfFTdPnGG2C3fhntxQiol
         nixHjzeEXJg4GpJUmvH4MVQ9FPXipQ5zLMvVaseRspuf60ltx6tattvs76SPbEsvo9
         IZknsBhAuvLUg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: Add WLAN firmware image version info
 into
 smem
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221104082828.14386-1-quic_youghand@quicinc.com>
References: <20221104082828.14386-1-quic_youghand@quicinc.com>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mpubbise@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Youghandhar Chintala" <quic_youghand@quicinc.com>,
        kernel test robot <lkp@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166790340662.9633.4549756749859911615.kvalo@kernel.org>
Date:   Tue,  8 Nov 2022 10:30:09 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> wrote:

> In a SoC based solution, it would be useful to know the versions of the
> various binary firmware blobs the system is running on. On a QCOM based
> SoC, this info can be obtained from socinfo debugfs infrastructure. For
> this to work, respective subsystem drivers have to export the firmware
> version information to an SMEM based version information table.
> 
> Having firmware version information at one place will help quickly
> figure out the firmware versions of various subsystems on the device
> instead of going through builds/logs in an event of a system crash.
> 
> Fill WLAN firmware version information in SMEM version table to be
> printed as part of socinfo debugfs infrastructure on a Qualcomm based
> SoC.
> 
> This change is applicable only for WCN399X targets.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This doesn't compile unless QCOM_SMEM is enabled in Kconfig. So should we add
"select QCOM_SMEM" in Kconfig for ATH10K_SNOC?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221104082828.14386-1-quic_youghand@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

