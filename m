Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E09D74CC03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjGJFI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjGJFHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B6198;
        Sun,  9 Jul 2023 22:05:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CFF360E0A;
        Mon, 10 Jul 2023 05:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B9EC433CD;
        Mon, 10 Jul 2023 05:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965491;
        bh=f4aOjTCTgpASfAkNjrE6WOZbK8/oyOiowxT0COexb68=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mtmrMlHS90w2b1GHxj2gx5qWScYxRg+vWljsqxgAzAqodqSu+6xxdKTm+Ws83h6cZ
         O6uAItPFrtIlZGI4JxWDjvpXNFS7VoBumRWe5HyNnW4+7aTAdkwuUb0puzKMYLE5Je
         F8fwtt4bYWXcncclKNT4UFHz7at6tSte3dyxX7Usd1Xbx6uzOx0Sx7UJMmVkaPOJPZ
         v34cB3tAdFG+VW7VERkoPE9+gP0jUOEyydEEWNn3rSjXtXUhK95NZIi0on69uyWsu5
         VBIRbpmseqF/Bm1LZGb53QrE3Ua0WowMvciiSL3tjPbMWaJ6pwXRkbmaNlWUWfUIuK
         6zYcFEjquF2PQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/7] arm64: dts: qcom: sm8350-hdk: correct FSA4480 port
Date:   Sun,  9 Jul 2023 22:07:31 -0700
Message-ID: <168896565958.1376307.14051968542242639160.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
References: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Jun 2023 13:44:36 +0200, Krzysztof Kozlowski wrote:
> FSA4480 has only one port according to bindings:
> 
>   sm8350-hdk.dtb: typec-mux@42: 'port' is a required property
> 
> 

Applied, thanks!

[1/7] arm64: dts: qcom: sm8350-hdk: correct FSA4480 port
      commit: 44f2f74df42910ae3a2289f1020788a348089718
[2/7] arm64: dts: qcom: sm8450-hdk: correct FSA4480 port
      commit: dea98746f90ab368ec51dc7a070090165560a5de
[3/7] arm64: dts: qcom: sm6125-pdx201: correct ramoops pmsg-size
      commit: c42f5452de6ad2599c6e5e2a64c180a4ac835d27
[4/7] arm64: dts: qcom: sm6125-sprout: correct ramoops pmsg-size
      commit: 2951e7e7611a3ea04de98d0f1bfc4e7ec609ef29
[5/7] arm64: dts: qcom: sm6350: correct ramoops pmsg-size
      commit: c86b97a72065e06eacb993dc71fa9febc93422af
[6/7] arm64: dts: qcom: sm8150-kumano: correct ramoops pmsg-size
      commit: 4e6b942f092653ebcdbbc0819b2d1f08ab415bdc
[7/7] arm64: dts: qcom: sm8250-edo: correct ramoops pmsg-size
      commit: 7dc3606f91427414d00a2fb09e6e0e32c14c2093

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
