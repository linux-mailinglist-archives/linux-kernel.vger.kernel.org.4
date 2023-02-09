Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1091668FEA3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBIEZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBIEZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:25:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4C19F0E;
        Wed,  8 Feb 2023 20:25:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06E361899;
        Thu,  9 Feb 2023 04:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FDCC4339E;
        Thu,  9 Feb 2023 04:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916488;
        bh=YuuzCC59t3tYMRoZvdCdBZVWh2Jbp1bxOpP2zNXe4tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSLys7WWUw1TODm3pzupYwm1Fg1F0s7+wkONRJQLDaxErI92cawKIA7f5uD54dMh8
         2MCjK5evPJFzsTw3eACHItLpRQM7HzQJqbVfKqmtRkG5TRD3DhrvhGkV8XO5l2x5sS
         C/YXNdh55ZsDpQRx89OUi73wSZO0AGyzPK5faFfTqRoPtPcTJbO/M42FOGIs8ZF6w7
         96YoKQSFUt07nUi4Pq0E5iaIp0EWsvvt1oYPt++nD9iFqVHt//nFcdfqMEU0Hcr4qj
         6U6jp7l4l9keWjNoQ2OmhjTQtcg5Jrx+jOdyqqRIQA6qGrR+0ScpTCZrEpq4wCKkGt
         wq8Fn+c253yow==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Stephen Kitt <steve@sk2.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/7] arm: qcom: Fix touchscreen voltage for sc7280-herobrine boards
Date:   Wed,  8 Feb 2023 20:22:46 -0800
Message-Id: <167591660372.1230100.9738507558526610892.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207024816.525938-1-dianders@chromium.org>
References: <20230207024816.525938-1-dianders@chromium.org>
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

On Mon, 6 Feb 2023 18:48:09 -0800, Douglas Anderson wrote:
> Trying to figure out how to talk to the touchscreen properly on
> sc7280-herobrine boards was a long and difficult process. Many
> Engineering hours were spent deciding how exactly one should talk over
> i2c to a peripheral. In the end, a solution has been found and this
> patch series attempts to implement it in a way that will work for all
> herobrine-based boards.
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: qcom: sc7280: On QCard, regulator L3C should be 1.8V
      commit: 428df177013bad1a0a062878e3d5224122b7a5fe
[2/7] arm64: dts: qcom: sc7280: Add 3ms ramp to herobrine's pp3300_left_in_mlb
      commit: 4261cea17a2f5e0ec78eb3ceebb68dddb918aee9
[3/7] arm64: dts: qcom: sc7280: Hook up the touchscreen IO rail on villager
      commit: d90b98f5702dccc41a5885b65361573654fcaabf
[7/7] arm64: dts: qcom: sc7280: Hook up the touchscreen IO rail on evoker
      commit: ef29188fe0b4de5c04b833378db92d3a3e0709e8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
