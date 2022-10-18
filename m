Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE05E60222A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiJRDK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiJRDIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B33D9AFC6;
        Mon, 17 Oct 2022 20:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81F356136D;
        Tue, 18 Oct 2022 03:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25741C433D7;
        Tue, 18 Oct 2022 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062435;
        bh=yrkC0pvgPvpDKwgj/vYv2JEF3r1i9da9LRxA3R0N6fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPCgHiUmypUcltI+S+pF+niIsGr8XkhmJOR81VVHzD3GJCqe5Uv3SonHphVeHSpY0
         EGBAoSHKCYgpvtv5pw5Ux9gEIPBq08UmzKtQIwHauYvfhv1YiA44H4bK9x3MRRU5f+
         NaynS9RcmaAuXzknEckKYs8f34CSImYxVZkkI3Z8c8EeMhn4xRVF27au6ew5bATFMx
         kQOK58ILg/Q1MS3TqjV+9XidZItQA4lqU3EasbzvcYSxn89rH5iz6ayZk5c6ZTxpWW
         EZOwUKTrmfBYvaXLUkONWSLuOH2qCmv3TRNMH+i0xTanIzJlVLnXKrAZQiz9Gi0lqk
         BGF7IxPnJysdw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH 1/2] ARM: dts: qcom: fix msm8974 tsens compatible
Date:   Mon, 17 Oct 2022 22:05:48 -0500
Message-Id: <166606235858.3553294.5669486829553405282.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220925161317.76356-1-luca@z3ntu.xyz>
References: <20220925161317.76356-1-luca@z3ntu.xyz>
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

On Sun, 25 Sep 2022 18:13:16 +0200, Luca Weiss wrote:
> Bindings mandate the use of the fallback compatible qcom,tsens-v0_1 for
> msm8974. Add it to fix the warning.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: fix msm8974 tsens compatible
      commit: 23fa8ec64963b504071bdd0bdc6ade28cd7ecca1
[2/2] ARM: dts: qcom: apq8084: add tsens interrupt
      commit: 078d683252d9ceb06661cd3fc07b6fd58ef06548

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
