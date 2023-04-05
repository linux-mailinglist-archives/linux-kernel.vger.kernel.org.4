Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E426D7325
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbjDEEHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbjDEEHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D8A5586;
        Tue,  4 Apr 2023 21:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E0B63B02;
        Wed,  5 Apr 2023 04:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76766C4339B;
        Wed,  5 Apr 2023 04:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667595;
        bh=pcBiVyJlyPyARNHCqfLs3Nvrd3SP3jm8pRSmt2Z/m6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5iGN6T1E8B3UHIoSMKnvgF6qDTuVq+/qqz3E6HhrKU00+SY5V9OMlZPuHv8MT/nc
         nlASlBbNc6+qfkLrVZA3KNdHh/43hLq7M5ENWMFdyYr9zt9EERWO26VKfItJb/wF1g
         UO+u0wyhg9skCflaj8HU1/iLjjI/68Cfki2nChufovZaziIuMkS0NvP0/B8ay5pqaV
         1Ue1a3UeVRxuGJIMV7oLQhbYTUPVvTVTPnqZuEYMd1xuSNHBvod2cOG6CBo9S5ak/j
         2yxpAfdu5n97aoXCimqoOrXTa7cuQHj5nRHbOebIwKOsc19G2qxPKDSb4DnpoqdP2G
         Y0EKsmqtJKCsQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller
Date:   Tue,  4 Apr 2023 21:09:06 -0700
Message-Id: <168066774412.443656.2209336758663929943.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313125731.17745-1-quic_kbajaj@quicinc.com>
References: <20230313125731.17745-1-quic_kbajaj@quicinc.com>
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

On Mon, 13 Mar 2023 18:27:31 +0530, Komal Bajaj wrote:
> Add a DT node for Last level cache (aka. system cache) controller
> which provides control over the last level cache present on QDU1000
> and QRU1000 SoCs.
> 
> Changes in v2:
>   - Addressing comments from Konrad.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller
      commit: 6209038f131fee84ff1536dc59864f54d06740f2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
