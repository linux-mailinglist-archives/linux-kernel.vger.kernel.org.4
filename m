Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73B474CBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGJFGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGJFFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5097611B;
        Sun,  9 Jul 2023 22:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CEB960DE4;
        Mon, 10 Jul 2023 05:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B478C433C9;
        Mon, 10 Jul 2023 05:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965494;
        bh=HTAy/g8EZawI0HAPxGauhrZqCOkDqVYbdCCt4PyEBcQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Yab21YNKCdVNTMJehri714Jp21SeptgGC3nOFV3hGE7BUDGpxggoQr6jQ7hsnHECf
         VAb1fTJOFgI0Id0swj/ShYtZ+UemNBc624Cnb2pcoNfFXnoRwWSGYVEDT/21wxfjAf
         +USh5E4GYYRQyDi9pDeSLlznClhXZ/aKf4RkON/bCcs3pAwFDaBP4EL5Ihaqlo+BXQ
         OIeKKD0GcVjlG/ydCnt5Xp6AhDeCFwH6Jr9X00PVRdUM+ZblZ4k+2gzc6zjkfouWVj
         5UUyiS3gjJfjZ6LuiC5GshVjK8FI0GFgoaDPJT6wBqZgZeL3aVn2zOauGj4AWtEZaw
         Rpes+CsuD7D3Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: correct crypto unit address
Date:   Sun,  9 Jul 2023 22:07:33 -0700
Message-ID: <168896565955.1376307.188291654231025401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616174955.1783652-1-krzysztof.kozlowski@linaro.org>
References: <20230616174955.1783652-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 16 Jun 2023 19:49:55 +0200, Krzysztof Kozlowski wrote:
> Crypto node unit address should match reg.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: correct crypto unit address
      commit: b02966f8689795406ac210189924a8cb02a71bbe

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
