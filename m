Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99F61E971
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKGDPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKGDOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F1B12625;
        Sun,  6 Nov 2022 19:13:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F9A360E9E;
        Mon,  7 Nov 2022 03:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A6C433B5;
        Mon,  7 Nov 2022 03:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790799;
        bh=ZChwjuh8vAHRS/cZ6NlSuzI2ch5I9Xdk7sSEwSL132c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DZ2ppTY/u6SRRf33acYOlvn8Cxe/jp2zTly0qwhrUL1tqADIH4e+3OoP+cfTCfCog
         LGfkYSej4DWCo/cLZH7nCQvbQFtDTMG6UTcauA2gOZRBl2oTAtoqSqJs1Kko5+mr+I
         VSLOww02A6XLgGhn8zgI2QKX80VUUazILVoBmrI2qrorAIPGecRzZUbhcrZ+x1IJqx
         d2s3VsqUSFiJJ9hIcofvzUL1dusSOT1iKc818SPFv5g3by1lJDvD0P1jfMAginqlrb
         KPRpWyokixqYcnpqPvbudsQqYlbBnqY8Fm04CHVAW9hWRQ7h/6R/c/8olHqRnH9qyL
         3u+qvoc+QSNSg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        vincent.knecht@mailoo.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v2 0/3] Add msm8916-alcatel-idol347 torch and LED support
Date:   Sun,  6 Nov 2022 21:12:36 -0600
Message-Id: <166779074270.500303.12566673389513895031.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
References: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
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

On Fri, 4 Nov 2022 14:23:57 +0100, Vincent Knecht wrote:
> Add support for GPIO torch LED and si-en,sn3190 white LED indicator.
> 
> Changes in v2:
> - Added patch 1/3 to use -state suffix in GPIOs states node names
> - Changed patch 2/3 and 3/3 to also use -state suffix
> 
> Vincent Knecht (3):
>   arm64: dts: qcom: msm8916-alcatel-idol347: Add GPIOs -state suffix
>   arm64: dts: qcom: msm8916-alcatel-idol347: add GPIO torch LED
>   arm64: dts: qcom: msm8916-alcatel-idol347: add LED indicator
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: msm8916-alcatel-idol347: add GPIO torch LED
      commit: 64323952aa5a14471a1225f2c1121aa5447c6ded
[3/3] arm64: dts: qcom: msm8916-alcatel-idol347: add LED indicator
      commit: 1c8cc183d07059d23d28c29a8e345464c4055127

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
