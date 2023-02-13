Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D316953CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBMWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjBMWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410BB2006C;
        Mon, 13 Feb 2023 14:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D89ACB818EE;
        Mon, 13 Feb 2023 22:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D05C4339B;
        Mon, 13 Feb 2023 22:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326867;
        bh=IgFSxGVW+g4L3K+r5WNLqzfyj/9O8AXEX7jeT9PfUOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2s4hik6PHKM+c/6j3z6QeIYoHCzVPGfa6WFsZQ5G1nb7Z0RSf6qJMzdCN+TqwfbK
         ylSba7C7OE2sHg4S7YJAv2wOUGj5TsjIXQ8bsF8ZIC/Vd3KIXLUHz8rv1o457AkUk/
         ZhPjAWnu2aXkaKXuW9B9bwg5VLCT7RtljaLll4bQvuJar7Y6C9M+E8+YRKenC+8CbN
         ZYoOqebjix/PvkILYwB/AXgmgQfQU/NvzLQ+4GaYSI7UB/brBNINyPrtMPHsq183Za
         XlTw0kAZ9Q8guVZOYV6MsV/ZQ9XUo3JdnH4dljROaIzzn33Ilhl6eeLJaMshbJxzIa
         1Sq4TV2hLr/gA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: (subset) [PATCH v2 1/7] arm64: dts: qcom: ipq6018: align RPM G-Link node with bindings
Date:   Mon, 13 Feb 2023 14:23:03 -0800
Message-Id: <167632698311.557014.8382168807767874732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 8 Feb 2023 11:15:39 +0100, Krzysztof Kozlowski wrote:
> Bindings expect (and most of DTS use) the RPM G-Link node name to be
> "rpm-requests".
> 
> 

Applied, thanks!

[1/7] arm64: dts: qcom: ipq6018: align RPM G-Link node with bindings
      commit: 679ee73bbee28cab441008f8cca38160cc8f3d05
[2/7] arm64: dts: qcom: qcs404: align RPM G-Link node with bindings
      commit: 7bf30eb441b3bdaa368e65837a03f9fbba033180
[3/7] arm64: dts: qcom: msm8996: align RPM G-Link clock-controller node with bindings
      commit: 407ef897bd0275e38ae33d410857e71c092679bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
