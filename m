Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550F56C4E31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjCVOnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjCVOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BACD67028;
        Wed, 22 Mar 2023 07:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E96FB81D15;
        Wed, 22 Mar 2023 14:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A59C433EF;
        Wed, 22 Mar 2023 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496135;
        bh=+XH1Fh5Yv192myI+F/GCaVxnx0Pg26Xcsdf83OUUBqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7tBUu5+WUlTVVj9IijVpSmrYYzg6FANnku4Ew5YrQp2zzGnPUmVj9za6VdqA5XSS
         mFtHqyodDBidYFMnQJeffpHMWzevV5db8Siinxs9mwYYAObNkz3ujaPA+U1FNm6EN/
         7aQvD2h8W0yw2bqfxt/fB8MkKrqXwJhxO88fcOuAGjJGVoFYbXuSHG9RgsPmkymdct
         en3MMl4wiDZmlHZEQITK4QOd1Iv1MvMBEak/9owyvzLoHrSvwEF+OMq/HWEM7Kw1w5
         IsHscq6hQ7YjQM10pXIfCj9M4Nb+OE+bEjqYZL8NT1OjbGrd5C8sX7P1/HFi0D/p9p
         qZ/0X+mdQ2DhA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, abel.vesa@linaro.org, agross@kernel.org,
        rishabhb@codeaurora.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, Danila Tikhonov <danila@jiaxyga.com>,
        saiprakash.ranjan@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] soc: qcom: llcc: Add support for SM7150
Date:   Wed, 22 Mar 2023 07:45:05 -0700
Message-Id: <167949631652.1081726.3077531537243278747.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305202627.402386-1-danila@jiaxyga.com>
References: <20230305202627.402386-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Mar 2023 23:26:25 +0300, Danila Tikhonov wrote:
> This series adds LLCC support for Qualcomm SM7150 SoC.
> 
> Danila Tikhonov (2):
>   dt-bindings: arm: msm: Add LLCC for SM7150
>   soc: qcom: llcc: Add configuration data for SM7150
> 
> .../devicetree/bindings/arm/msm/qcom,llcc.yaml  |  1 +
>  drivers/soc/qcom/llcc-qcom.c                    | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: msm: Add LLCC for SM7150
      commit: 1e0952e7b978eb4a182c4a9c003f9313d30d00df
[2/2] soc: qcom: llcc: Add configuration data for SM7150
      commit: 92b9d86252c1d76faf06f155c2a73b0c673bf59d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
