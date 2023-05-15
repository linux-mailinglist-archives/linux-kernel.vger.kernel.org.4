Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E443702273
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjEODd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbjEODcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7843D26BC;
        Sun, 14 May 2023 20:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A63661E40;
        Mon, 15 May 2023 03:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93158C433EF;
        Mon, 15 May 2023 03:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121362;
        bh=lnP2+dVucsO/s8HZ7cKMyYN9t2pIBMq2zZ4BICHHeN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUxwLW2/s0rYCmBJ6Z+nRBnGdV3zRDDhVsauqQV47AxMtEnmD68ix829N5WslHcbg
         Ljv/tK2LRdOsKJkvE6sMoW3DAgJMgRA68xRAfXkeFsMFLiogIW0KoEUTbcqjWnQO9k
         ffVeCPyT9R86vAtqw22y09X8hddgFf/k6lyCzWF6ncThq68e27B/duAaQraklYT/j2
         T65l4ne7ISjxwdeZ/8Kh6XZ/Of+Euls41DnC+MruAJ+BhLTIvp35AI1Cqs7ZwD3u7c
         af8iqKmW8BrtllF5AcnLRAuFt21MH/RTZryicTaU2HUBmrsLG+snzmHtHNObJE8ome
         4Yv6tPNuWszkg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bart Van Assche <bvanassche@acm.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] arm64: qcom: sa8775p: add support for UFS
Date:   Sun, 14 May 2023 20:33:01 -0700
Message-Id: <168412158455.1260758.15219460296636419401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411130446.401440-1-brgl@bgdev.pl>
References: <20230411130446.401440-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 15:04:41 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Update relevant DT bindings, add new config to the driver and add UFS
> and PHY nodes to the .dtsi and enable them in the board .dts for
> sa8775p-ride.
> 
> v2 -> v3:
> - fix DT bindings: move allOf: below required:
> - collect review tags
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: qcom: sa8775p: add UFS nodes
      commit: be543efeee17b93edaac61e49c6361d2209bd3d3
[5/5] arm64: dts: qcom: sa8775p-ride: enable UFS
      commit: 35c45a1125fc0772b95aa41acc25deddcf5492be

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
