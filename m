Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBC6953BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBMWVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBMWVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:21:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A11C328;
        Mon, 13 Feb 2023 14:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 625CDB8198E;
        Mon, 13 Feb 2023 22:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149E4C433D2;
        Mon, 13 Feb 2023 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326865;
        bh=gyEBgi/ZJxfjujVt8qdq2ODYI+cbhVDZ/ejBMlMgUU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkPb458LFkSiCqZFiHUpHFAmcmtaHAEShEnQNxmshmE7cyCf038IQ/ITfAaqNeIIW
         Ux6e5bIGwCQeulraxJ04RN8pxj/K5v1Vt0n1VKEKcf8ETYAbd6bO/DmwLAUoQ9z9bV
         qsuAhDQc4nV8MoH0XKauEE2QKHoVb6N55bG4mxWs4lOcZGCezvIcIFvyjW1TU2PWPz
         sfJfCQYkoFuKkvgBBawP3vK7sg17HUD9jv0+3eymT2s82G/vLAByhcxhort04EWNIp
         +T6d5UQAwfRvd6Bm/1q9UyW5TeHGgUFLdvnG8uwQcW+thrJ8DStGUB4aZNJfx05nBn
         sQkaOY7QimBZA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     Abner Yen <abner.yen@ecs.com.tw>,
        Doug Anderson <dianders@chromium.org>,
        Harvey <hunge@google.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Bob Moragues <moragues@google.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Adjust zombie PWM frequency
Date:   Mon, 13 Feb 2023 14:23:01 -0800
Message-Id: <167632698311.557014.5527785958615724088.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213105803.v2.1.I610cef0ead2d5df1f7bd18bc0e0ae040b03725d0@changeid>
References: <20230213105803.v2.1.I610cef0ead2d5df1f7bd18bc0e0ae040b03725d0@changeid>
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

On Mon, 13 Feb 2023 10:59:05 +0800, Owen Yang wrote:
> Tune the PWM to solve screen flashing issue and high frequency noise.
> While at it, the comment for the PWM settings incorrectly said we were using a 5kHz duty cycle. It should have said "period", not "duty cycle".
> Correct this while updating the values.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Adjust zombie PWM frequency
      commit: f15c1b1bd3c2b3a688d1139593be6c620bb9af6f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
