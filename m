Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D2C644B63
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLFSVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiLFSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F3A45D;
        Tue,  6 Dec 2022 10:19:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 864F0B81B2C;
        Tue,  6 Dec 2022 18:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA88C43142;
        Tue,  6 Dec 2022 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350797;
        bh=y2H0L/aNy4VskNtk/tr68wbXev/aBiEMQPSMycOYiyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fg5BLKW8NavVWybH3a0hbybxUpTDv4mtu/aaZ7RehJa6x1RTW4SOkxfnhx50BV0dS
         7n1MZcDsUa5sUNRLxKrEvP7492VmPEyWXEJb9zfoXt+noGAzjL2DZNt7G0GprfQjp7
         nhCskoPoH4iH9z6rRmmY5/Z+H6C1ZhxRtW04q5AssDwOmdRKWDWPLaT+j/+GOUd3rq
         VwRCLbhJJ81Ng/Gws2hCmq2T4OQ73SpyJpRidr8KZ86CrbBe2CKtKpWPSYT+QJ3jPs
         h7WfUaYb+rNWD7kWVBnmWBn9lI4M7/8C2sMlnGxYJFkOgcJ86WZrU8P1JRq4GBoaYj
         7sV2R5NS+FV/Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, patches@linaro.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: msm8994: Drop spi-max-frequency from SPI host
Date:   Tue,  6 Dec 2022 12:19:01 -0600
Message-Id: <167035076342.3155086.15441163142669323312.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117105845.13644-1-konrad.dybcio@linaro.org>
References: <20221117105845.13644-1-konrad.dybcio@linaro.org>
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

On Thu, 17 Nov 2022 11:58:44 +0100, Konrad Dybcio wrote:
> This is a device property, not a bus host one.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8994: Drop spi-max-frequency from SPI host
      commit: d132d9e7c4e53a23d158a9ec3d59c372eb30e70e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
