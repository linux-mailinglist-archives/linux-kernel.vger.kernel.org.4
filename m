Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80386572CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiL1Eiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiL1EhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46384DFC6;
        Tue, 27 Dec 2022 20:37:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3283B81259;
        Wed, 28 Dec 2022 04:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D2C43398;
        Wed, 28 Dec 2022 04:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202232;
        bh=550yazXnN33DzSXFPdd8hpYrbftpXk1toLx1NXw1kkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DT8lz8BM/RvYAjMqLfzgIcX5M4zdgQhjB/vm1+tPZ5FhYBffhMgVBpbKGVX/Kzn8x
         XR5Ly6tzdPRxgDPEiOWSukvIYRtd7iNrMIUrwlY1zmE1HzMi9taM3tJpdXPphOfIj5
         SoeGppIUIb4teIP5KQ2pNDu2di4AhiVvlTvafoG0hiw8BfBS/BdBrm423DxPAKroGP
         8rcUZFiNro+WGJQRk2Vb9rDpdJ5AWuSwKfROWzjYuUEFiRt9A82s29nlanTEXse01L
         KTIIuaBJ6MFsxu/WGM+P2Vdj3M2hR+M83r9lSQHrZwrDVd4vSKVKT+992GokGl0+W2
         +hLRLW7o6RrHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     pavel@ucw.cz, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, luca.weiss@fairphone.com,
        robh+dt@kernel.org, agross@kernel.org
Cc:     quic_fenglinw@quicinc.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Add PM6150L flash LED to Fairphone 4
Date:   Tue, 27 Dec 2022 22:36:47 -0600
Message-Id: <167220221227.833009.6597844186095388521.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
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

On Fri, 09 Dec 2022 14:54:05 +0100, Luca Weiss wrote:
> These patches add the necessary nodes and configuration for supporting the
> flash LED found on the Fairphone 4 that's powered by the pm6150l flash led
> block.
> 
> This depends on the patches by Fenglin Wu adding the driver, the latest
> revision can be found at [0].
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: pm6150l: add spmi-flash-led node
      commit: e48b2f1fb1749e6ceeca13ac80e6e46b954dce41
[3/3] arm64: dts: qcom: sm7225-fairphone-fp4: configure flash LED
      commit: 1c170714490e4d8c0886019145c9d90dfade14f9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
