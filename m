Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D3868CD79
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBGDc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjBGDcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:32:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC50977A;
        Mon,  6 Feb 2023 19:32:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3D6D61166;
        Tue,  7 Feb 2023 03:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65923C433EF;
        Tue,  7 Feb 2023 03:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675740737;
        bh=/2xXDRQIxXfrcDUwObc5uFNl1siTx3Qk7+9Vc2clWWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAL0CrXBthrdyGicHRLtIT/bmHG0FnihmtnL2s4vyLg1K8kQvKvMAEBzH9y+gkFF1
         rgSeZ5nIq29r5eCyJxKr4y7iilGai3tUYh/a6I9Y2bzfLOldAg+wU1T83pQn5G702z
         B9yAn+AWd4TtUhlg/P31BGejTnZF9LbJYqdUmfyEAk7EbFejtyZ4G3IqM5d+JS+osf
         Y+Y82xa6ZGd7VmTvWfsC8Wj7ldYMcu08Ls2+VKlNXVBzIR4mq5BKTWFuECsNTPmv6j
         hRysB13rvXXkmAHiQYHGrbs8IiVc8urNqEY0s2yeO3jcWi2OIQfFDfn0hz/xB+WCac
         Ciyr1gtt7qwZg==
Date:   Mon, 6 Feb 2023 19:34:30 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_varada@quicinc.com, quic_srichara@quicinc.com
Subject: Re: [PATCH V3 2/9] pinctrl: qcom: Introduce IPQ5332 TLMM driver
Message-ID: <20230207033430.pwf62j2cdu6igkhb@ripper>
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <20230206071217.29313-3-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206071217.29313-3-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 12:42:10PM +0530, Kathiravan T wrote:
> The IPQ5332 SoC comes with a TLMM block, like all other Qualcomm
> platforms, so add a driver for it.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
