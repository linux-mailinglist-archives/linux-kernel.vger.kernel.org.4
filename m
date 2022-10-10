Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3D5F9A74
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiJJHv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiJJHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BE917E05;
        Mon, 10 Oct 2022 00:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0017E60E75;
        Mon, 10 Oct 2022 07:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64026C433D6;
        Mon, 10 Oct 2022 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665388192;
        bh=XzSPUlFclW0ZT9yGjU4jJfL3cyzm5SGlmsXOFLYFHS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEfi9vyV9guaQaHEIdM695B2FrzfkFzQTIO4Ay1e0PeVo5hvT7bCPVw91eW+m1hBR
         gogYIj1z3Drml0eEpCzJdRb4hpixLpfiVUzcgy9vmbJQuZ6wwEIu+Rvc21mpVKUX6p
         T2vSFb5+6j4b0IqjTxq8osZDLu6EGYTOY0sAIFj3fH524B7r3PLpBairUX1JuCLntr
         m/tzIA/nR4C6e/Eig1rFmxkdBqeR4K/EQct/JcBa3BcZVDxKnWAYSUAj6nr27LguKn
         wmg2kjRwF7Ji3kFdTC7jmQgUNFSjbduoFQBH67ZWO9X7/kgRTtJZ6bm8X3hmzgGQ3d
         ixznRVnddti4A==
Date:   Mon, 10 Oct 2022 08:49:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v9 0/3] SDM670 Pin Control Driver
Message-ID: <Y0POmQ+xrQ/HT7RF@google.com>
References: <20221007213241.84962-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221007213241.84962-1-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2022, Richard Acayan wrote:
> Richard Acayan (3):
>   dt-bindings: pinctrl: qcom: add sdm670 pinctrl
>   pinctrl: qcom: do not reinitialize gpio valid mask
>   pinctrl: qcom: add sdm670 pinctrl
> 
>  .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    |  127 ++
>  drivers/pinctrl/qcom/Kconfig                  |    9 +
>  drivers/pinctrl/qcom/Makefile                 |    1 +
>  drivers/pinctrl/qcom/pinctrl-msm.c            |    3 +-
>  drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1345 +++++++++++++++++

And I'm receiving this because ... ?

>  5 files changed, 1483 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c
> 

-- 
Lee Jones [李琼斯]
