Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A5602252
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiJRDMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiJRDKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:10:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE29B84E;
        Mon, 17 Oct 2022 20:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF69CB81C62;
        Tue, 18 Oct 2022 03:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8888C43146;
        Tue, 18 Oct 2022 03:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062448;
        bh=mtbiyZyxyDyp3rBzhcxrhY9RQaGjGs2D34CX0ziC7dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1Ks2aYWzwBpUu09rzAL3f79kQ4C+DLY9keT0MgYhNJGTVmdtiGxnqdF7PCvQkMX1
         ekuDePUEL09K53H2eoeHXQd9w2xu375iLVWdO6LynEZNGlAX75j0nazxhoJVhCoTPx
         B9HIV9vLRt6iZyHuGLQ2oRt/z6QGlJJBlSI+dVUT308dURAEyoSFbkvS64K+glhpnN
         i9qm32Mo6QpTRs2LY+pMkqxShY0K/QbTG1jjtj/xKmty9n1yyQHwAy4OBRhAV/U94A
         ZSnhRs2dZXUOtqSae2WJjDSpMQ5tO2rcfWdSqOarleUGiVbIeDQw7/d69LuIuUiHw5
         Z62vpTi3gqKCw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        quic_kriskura@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Configure USB as wakeup source
Date:   Mon, 17 Oct 2022 22:06:01 -0500
Message-Id: <166606235849.3553294.12498432546497387227.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901102946.v2.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
References: <20220901102946.v2.1.I347ea409ee3134bd32a29e33fecd1a6ef32085a0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 10:29:50 -0700, Matthias Kaehlcke wrote:
> The dwc3 USB controller of the sc7180 supports USB remote
> wakeup, configure it as a wakeup source.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7180: Configure USB as wakeup source
      commit: c50e30b7e2614d140929280377337ec01bdbdc84

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
