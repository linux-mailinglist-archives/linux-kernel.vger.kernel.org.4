Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C493620611
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiKHB33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiKHB2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6177C2E688;
        Mon,  7 Nov 2022 17:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE6DB61381;
        Tue,  8 Nov 2022 01:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B0BC433B5;
        Tue,  8 Nov 2022 01:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870894;
        bh=Crxd1ML6E33FgEfYcWzzIz4tDqidtID7RRad67vi5CE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aAb1r/6h5zWL0QrUxmaQ8c+BP8PAjPp6e22FYud3MX+q/EfFxRgZln2vT78W1pYlj
         su05M9ibmWRYORqcLf+u2SCYOrBLLMFjJiyVaPKiVydk0S39TdN05vg5jVGcHQGL2u
         jBxJzFiy4wbDxLVjtMaYpJKqvfx0+XpOLySevpJSpKudqhHB81vKvZrgbs5aWlw3Vu
         b7Rc8XnavGw9bbqezHFMx19WKr5ZOcirMUd5EG8M8z8CnygLhkE52jjdMRwppFuy0X
         hU6K02knHcpdM6h7awyFTavmgSf2BLm0VshaqvKl/pHTIoaNftvZg9cTNJ8vpnoaPU
         7ccP6BYGvEiYA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     vincent.knecht@mailoo.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v1 1/2] arm64: dts: qcom: msm8916-alcatel-idol347: add GPIO torch LED
Date:   Mon,  7 Nov 2022 19:27:43 -0600
Message-Id: <166787084681.599230.10487688499814954760.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221029145557.106920-1-vincent.knecht@mailoo.org>
References: <20221029145557.106920-1-vincent.knecht@mailoo.org>
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

On Sat, 29 Oct 2022 16:55:56 +0200, Vincent Knecht wrote:
> Add support for torch LED on GPIO 32.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8916-alcatel-idol347: add GPIO torch LED
      commit: 64323952aa5a14471a1225f2c1121aa5447c6ded
[2/2] arm64: dts: qcom: msm8916-alcatel-idol347: add LED indicator
      commit: 1c8cc183d07059d23d28c29a8e345464c4055127

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
