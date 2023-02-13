Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C6C6953C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBMWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBMWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E1F1C7DC;
        Mon, 13 Feb 2023 14:21:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CB00B81990;
        Mon, 13 Feb 2023 22:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC15C433EF;
        Mon, 13 Feb 2023 22:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326866;
        bh=vxeo/vuFj0qDSgYX6SgvpUmg5JORzmHvn8S13Bz64UQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcjpHCCfvBnzXE+Hf4CnO8/0H1zZQAX0HT+N9KnYv4iFkQ3pPRXJT29oN7nWd7SQF
         Mmiizy3B9EknwXL4ZhBXb4agU6OACiC4DhQHElDbPMStxAuQt1L02TO5oeC1ZGB2kK
         ZuxpQh3PHc4rHRs2eClmphlhkMHCtz30AvTzJlHE1T2CVC91eIlOztWToq6bQG1ow6
         3O097VMImpGmhcHziVflmkKwc4tbikxMp65p4ccBbIWyymSDM8Eoqx5RgwwEG39B1/
         YS/fgUJ21kBX2ByP0s7T4EzOlHuxt63pfk/OVqw3VhdBtyVIYS2hfHBWbIztxj3qxU
         U6uiX2/AZG/OQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        devicetree@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: pmk8350: Use the correct PON compatible
Date:   Mon, 13 Feb 2023 14:23:02 -0800
Message-Id: <167632698310.557014.9784902275013954138.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213212930.2115182-1-konrad.dybcio@linaro.org>
References: <20230213212930.2115182-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 22:29:30 +0100, Konrad Dybcio wrote:
> A special compatible was introduced for PMK8350 both in the driver and
> the bindings to facilitate for 2 base registers (PBS & HLOS). Use it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: pmk8350: Use the correct PON compatible
      commit: c0ee8e0ba5cc17623e63349a168b41e407b1eef0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
