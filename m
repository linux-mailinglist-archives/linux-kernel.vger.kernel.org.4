Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734F55B9C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiIONt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIONtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:49:23 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC213EB1;
        Thu, 15 Sep 2022 06:49:22 -0700 (PDT)
Received: from [89.101.193.72] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYpEt-00053R-Gc; Thu, 15 Sep 2022 15:49:11 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add HDMI supplies on rk3399-roc-pc
Date:   Thu, 15 Sep 2022 15:49:08 +0200
Message-Id: <166324955276.172936.16409378178377671658.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220915111138.1108-1-m.reichl@fivetechno.de>
References: <20220915111138.1108-1-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 13:11:36 +0200, Markus Reichl wrote:
> Add avdd-0v9-supply and avdd-1v8-supply to hdmi node for
> rk3399-roc-pc to silence dmesg warning and match the name
> of the 1v8 supply to the circuit sheet.

Applied, thanks!

[1/1] arm64: dts: rockchip: Add HDMI supplies on rk3399-roc-pc
      commit: 1c33f8508b625e8c792b396155f6ef7cbc8f4212

I've moved the regulators higher up in the node to keep our
alphabetical sorting. Please do similar in future patches :-)

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
