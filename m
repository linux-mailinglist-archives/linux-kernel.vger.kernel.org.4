Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A7644B82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLFSWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiLFSVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:21:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BA31B9D1;
        Tue,  6 Dec 2022 10:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40140B819F3;
        Tue,  6 Dec 2022 18:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4E6C43470;
        Tue,  6 Dec 2022 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350810;
        bh=K7svBsNTuBhFucxOsO+b5wqi3+zBS24vo4ReVXgk9c4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VhJDp/T8ofFPGMhfOP3GACjubFAb5WA4pXgDoojbje8E12WPpXlQhaLGq7RbglcwO
         ZpT2ximHWsmDWJthVSfM3A/Rh2SZ/y+2kVYQgXklSljphVWVP3dnC4mxe09VDQumQG
         T8RUUeF/nbXjqmbAR2NA5Ol/15rYBPjP25waS0WyAgRSZLyvEFgUhc2XtabwlC8Y00
         xy+zAmNeS3kXzkmSTbx0C5ZOYQT9BO2QiNFiybCm9DfSLbjhsjhsNVD4tN09HpzRjM
         0HgFSW/dMrWiVt3Uo9AkTPqbLHR0BD7xvqPFQl+Lyd5WueKAgc+nUEhvq4IVanOZP+
         ZL16bfdE8YHOg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org, bgoswami@quicinc.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: apr: document generic qcom,apr compatible
Date:   Tue,  6 Dec 2022 12:19:16 -0600
Message-Id: <167035076353.3155086.4461257223662824256.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221201133637.46146-1-krzysztof.kozlowski@linaro.org>
References: <20221201133637.46146-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 1 Dec 2022 14:36:37 +0100, Krzysztof Kozlowski wrote:
> Document the qcom,apr compatible, used by Qualcomm Asynchronous Packet
> Router driver.  There are no upstream DTSes using this compatible -
> instead we have ones with APRv2 (qcom,apr-v2).  The driver does not make
> distinction between both compatibles, which raises the question whether
> the compatible is really needed.  Document it (as compatible with v2)
> for completeness.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: soc: qcom: apr: document generic qcom,apr compatible
      commit: 9ed8503114ccbfd116f18143a3604b9f1155ee9e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
