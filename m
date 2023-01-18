Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD95672D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjARXz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjARXzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:55:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251838B52;
        Wed, 18 Jan 2023 15:55:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D332C61ADE;
        Wed, 18 Jan 2023 23:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D74C433D2;
        Wed, 18 Jan 2023 23:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086150;
        bh=huo7Dx5LeyKK14EKOI6NOXQrPu2uwkUxnWmXx2WLv+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYjKZgAKdT5SU2xGQscEpdRouie+4hiX6iQQ7SiOSXyDPGJmvRtJO0mogJBz4M9K2
         8v2DFEo3RCdMojT9l9dEUZYae71xUuWfCvDrS2AyGP/8iD/8fFMZY/EpKrb0RMSK7L
         +ardY7qiP0VL0FbLJ7EXpwvXKlNnWWMtIsRINPP+YAgHHqfWTBh3ieA/+OBHv4Wz23
         OmoPpugs2YbeqrlGZuLqopO7/FZBWPULVjVp4gYq0nGQFQy4NjDcJ1PbS81oV272/v
         iTxN56TTfgEEo73iL+41Khf2k1gr7bWVGpi/TSzC7w3FwGyVJfr9dU9tPU1F+UU580
         05iyCNoBjGzXw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, elder@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     quic_jponduru@quicinc.com, caleb.connolly@linaro.org,
        quic_subashab@quicinc.com, mka@chromium.org, evgreen@chromium.org,
        devicetree@vger.kernel.org, quic_avuyyuru@quicinc.com,
        quic_cpratapa@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com,
        elder@kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: sm6350: enable IPA
Date:   Wed, 18 Jan 2023 17:55:34 -0600
Message-Id: <167408614062.2989059.13063218102847930815.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104193759.3286014-1-elder@linaro.org>
References: <20230104193759.3286014-1-elder@linaro.org>
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

On Wed, 4 Jan 2023 13:37:57 -0600, Alex Elder wrote:
> Enable IPA for the SM6350 SoC, which implements IPA v4.7.  Enable it
> on the Fairphone 4, which incorporates IPA definitions used for the
> SM6350.
> 
> Version 2 of this series uses the new "qcom,gsi-loader" property to
> specify that the AP should load firmware on this platform.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm6350: add IPA node
      commit: aed7154a30239f0275b13d622e1edd9d4d356308
[2/2] arm64: dts: qcom: sm7225-fairphone-fp4: enable IPA
      commit: 60bf8740870e0377f29b44593c0bfbab379b4909

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
