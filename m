Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88067602273
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiJRDUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiJRDTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:19:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A685B1F9F8;
        Mon, 17 Oct 2022 20:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D035B81C66;
        Tue, 18 Oct 2022 03:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC55DC433D7;
        Tue, 18 Oct 2022 03:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062880;
        bh=jrFTSkSw8/OLP0A8Fwb4P0GAlBszX3caoZ5KrK3ljEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1+t1IhIYwzgwbOkbSNMO/bNRkrBjYOYiNqurdi+LW8vyuZTF8jIPt5M/oVo5mSOR
         WkdS8gCf1OH/kk0yuvQmkT6YrkvpnqwMVVJfQT4aYAd6pO7US7MQnBKMU06yOBOckT
         9czBaAsTEHwTzewgU79gXPBG+s4Xt9Nht+kYlBOUBQQ5fEp8N5ih7Yx/nwwbTC0Ucq
         ckqMKYZhEaiHHB3bHdvu1HklqxMg11i7RqEk4IjPtqMmuhRu331GY0WHVwbpE5o8v5
         SrboLXhxOplLDqLMFpowRcVjxYXXO8kdN2CTgKPAVeSvdKqh8rkKdBfR75Pv7ITKTM
         u/AL20LuHTB4Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, quic_wcheng@quicinc.com,
        agross@kernel.org, quic_kriskura@quicinc.com, vkoul@kernel.org,
        kishon@ti.com, robh+dt@kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     quic_vpulyala@quicinc.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com
Subject: Re: (subset) [PATCH v13 0/3] Add QCOM SNPS PHY overriding params support
Date:   Mon, 17 Oct 2022 22:14:30 -0500
Message-Id: <166606235851.3553294.12620286711674222439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1662480933-12326-1-git-send-email-quic_kriskura@quicinc.com>
References: <1662480933-12326-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 21:45:30 +0530, Krishna Kurapati wrote:
> Added support for overriding tuning parameters in QCOM SNPS PHY
> from device tree. This parameter tuning is required to tune the
> hs signal on dp/dm lines for electrical compliance to be successful.
> 
> Changes in v13:
> Fixed NULL pointer check in driver code.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280 IDP device
      commit: 3b08e3fdf056cf30ecb1413d2bcb1353a333024b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
