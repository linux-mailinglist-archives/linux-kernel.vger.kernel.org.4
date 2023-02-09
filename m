Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B23F68FEB5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBIE1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBIE1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:27:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB15F3B660;
        Wed,  8 Feb 2023 20:26:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E5806189A;
        Thu,  9 Feb 2023 04:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD447C433A0;
        Thu,  9 Feb 2023 04:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916503;
        bh=wkxMc79CcdvnZsrFW6EJ39fFnePnAzCEwKuEpRye3u0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmWNmzhzTxhcUWm2LZj5+pBCFfptTZ7Pk0rS4J9FpKj80nRQfYrzRnw5SqQH3qFbi
         l+xTKinBqFZRwfXUdVm5BE2imnAmfX7XlkYC60o/Mr8R4XSxNjfnG8NB0fbJhfqvAD
         Ks/T+038z9IxRxxR7efz4BtzaqRL90SAkdHbaQzdCI4zQI38d6ioJV984GXhG0+eIV
         EnXG1Wd07s8N1Z1nHhams8qgAaaNL4yP1TE9sBXV3xA0l4l6+f1+2NU0kw/Spv85VL
         OCpJDuK32BzL9p4pLk0fgTwM2E8KNOqQAZW/BgFDomI0zjJD/7WgJHOib5YJeEMFUL
         6dDD8UKdS2j1Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, marijn.suijten@somainline.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Disable wsamacro and swr0 by default
Date:   Wed,  8 Feb 2023 20:22:59 -0800
Message-Id: <167591660367.1230100.12449196822226701338.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124164616.228619-1-konrad.dybcio@linaro.org>
References: <20230124164616.228619-1-konrad.dybcio@linaro.org>
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

On Tue, 24 Jan 2023 17:46:16 +0100, Konrad Dybcio wrote:
> They are not used on all boards, so disable them by default.
> Enable them back on MTP/RB5, which were the only current users.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250: Disable wsamacro and swr0 by default
      commit: ba23455e5b53013347537682441098bf83b0aa18

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
