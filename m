Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358BB68C95A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBFW2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBFW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:28:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808821207D;
        Mon,  6 Feb 2023 14:28:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEF0FB815D8;
        Mon,  6 Feb 2023 22:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04DBC433D2;
        Mon,  6 Feb 2023 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722504;
        bh=wwK4aOUjBlt3rzG6Kcx1HdPiPb8vMgnBRT4QR6p4GhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lx9urWcq1s3TexwoJLCg2QYetZ+vEh8QgnYIagWBZfD27M+hQtxjDFa+oqsYfJH3l
         4+rvLoFndR7unq05GaFWnEAbK9yns/DQdgmKTZFdtD3SlDW70BW3wH+4Qhk7ZltmII
         g7+9bUlKhZnx5QPBtESJB8yYnR7Kyk8bGpgsieLgPdHXzFJKjakPeds1dQa/CnhBBz
         +cysICEbwcN5FhvO5ikCu5Brb6AOSNQ0oDLtR27dvMF1Dc+S7EQS46M5uQYC0RVb7T
         i7BfYkXFS+1E1/wtEv7mHbnQNI0EixLmL/tur/Ofo95g4nLCd6TqIA3etWdVh0L8fi
         /knLCXTB8mFbQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] soc: qcom: pmic_glink: add CONFIG_NET/CONFIG_OF dependencies
Date:   Mon,  6 Feb 2023 14:30:31 -0800
Message-Id: <167572263441.3569822.16032534413689253271.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206193804.191343-1-arnd@kernel.org>
References: <20230206193804.191343-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 20:37:58 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> QMI is a network protocol, so anything using requires CONFIG_NET
> to be enabled as well:
> 
> WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
>   Depends on [n]: NET [=n]
>   Selected by [m]:
>   - QCOM_PDR_HELPERS [=m]
> arm-linux-gnueabi-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_new_lookup':
> qmi_interface.c:(.text+0xf0): undefined reference to `kernel_sendmsg'
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink: add CONFIG_NET/CONFIG_OF dependencies
      commit: 9049453a56300b04164c78a8ae3fbd5c225483bc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
