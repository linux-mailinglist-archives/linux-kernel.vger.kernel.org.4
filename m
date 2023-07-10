Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08CD74CC19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjGJFPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjGJFPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D842123;
        Sun,  9 Jul 2023 22:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E0FA60DF4;
        Mon, 10 Jul 2023 05:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3926C433CD;
        Mon, 10 Jul 2023 05:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965489;
        bh=zuib2MswZQqn0mEBRDU9A2CywuROWoi/3NqycOpQKj4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=acfec7lNjpJysjkL1HwisMFDTN8rKCWLBqGgOm+NW/RX7+FwFj8O+Ar2jeBQuTydI
         e8IrjXsLDNT+VgxipUj5jEYnaVkYglih7L9/dpXzbbw6sZWMv2uUiUMN+O0IAJ8yMn
         6/vETK+reZiEMir5w9pj4F4T/T9Jdnq9lXydZsBMmkntSeoz/q/7IcrL14tRcLn90h
         BbyV0OMT1NP7z+scSvLv2mTvCF4pqbOPxJsrfvgWBJKVjQdS0l1KpoNPcuFoyKYzTy
         bEOl9MWP/yXkdUfpARTaBwhbspPE38qB0z9ZdK+huOzfC9JnEfQ872Zrv2kCMnv+ki
         E1VykfcKJmP4w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: minor whitespace cleanup around '='
Date:   Sun,  9 Jul 2023 22:07:29 -0700
Message-ID: <168896565985.1376307.1575291897747570972.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
References: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 02 Jul 2023 20:50:50 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> 

Applied, thanks!

[2/2] ARM: dts: qcom: minor whitespace cleanup around '='
      commit: c4cf1cc5afbaa84513d1d4e2b60b1a434927f4ae

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
