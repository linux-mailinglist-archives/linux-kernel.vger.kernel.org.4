Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB72768FE7F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBIEXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBIEXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:23:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC5537B4A;
        Wed,  8 Feb 2023 20:22:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 516B861889;
        Thu,  9 Feb 2023 04:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19657C433EF;
        Thu,  9 Feb 2023 04:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916479;
        bh=2xHo3hTYBscksn/1NA1kiHV7qUo0e/0XtSspaqXtU74=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S9p8oB1w2W1B+ogfk+xoHQWaMLqWTn3+jZNxMm8Lcrcz39ZsnEahesi8rsguVTLov
         ysUM1bUlnNuartxdPAYpul8HtsfrlPTxkpJ+W0Neq2n0FLBDPcuOUx9uyCJA9XlTNb
         29L/73H1WIqfcpPWaDqCZlpYJMRM0CfgoTIWLseHt8kWTRgRxDlIEpvUVs3waYwNN4
         Q+62FmvlH6jL5JwKleAhgKYl5tzzVfk+Glx8WfQvc5wbMqb6iO/Tcmf3JES8H4Rcba
         B1xsvl/LsTLJ2DVoJYm+wbfreYUnMDk8lR4lef3cSgKyUkVM73lDCuE4A8H4vMBpiY
         nK0mhwkl4DFsA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: ipq8064: move reg-less nodes outside soc node
Date:   Wed,  8 Feb 2023 20:22:37 -0800
Message-Id: <167591660364.1230100.5486441858754435831.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230117224417.7530-1-ansuelsmth@gmail.com>
References: <20230117224417.7530-1-ansuelsmth@gmail.com>
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

On Tue, 17 Jan 2023 23:44:17 +0100, Christian Marangi wrote:
> Move node that doesn't have a reg outside the soc node as it should only
> contain reg nodes.
> No changes intended.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: ipq8064: move reg-less nodes outside soc node
      commit: 6739f57dea1657d410f267c05349b1d2d90771f0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
