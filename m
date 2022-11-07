Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB30661E930
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiKGDNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiKGDNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC1DE0BD;
        Sun,  6 Nov 2022 19:12:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CD6F60E86;
        Mon,  7 Nov 2022 03:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14305C43147;
        Mon,  7 Nov 2022 03:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790777;
        bh=WUtm2U0A/CO3KFQPZikX45IlMbJoyuVByko9/qzxXxo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gSV5lRDodQCTvwrzpwGSV+9RiQ4ZZ1JRD21WEoISDqUlEL669GQ9P7q85sd366IwT
         eJ4KE3nqnPiHdZrX2YvDLCm+Ko3pHaSCWQH9AS5Qw+lenzP3CMaae4EWDSghabaiFr
         qOpVba7gYCDAyW1K6FzOHTENPNsknRvcngKdQYxG7CayHDkxJqIhLc1bdUbPM47+06
         iVgohrOqkDgyPk/E4rJZN+J7pNfAFmPogSEcYIR4MMqncV9ydDKQi2UaPAlunJAxNw
         sqpa2PaaE/WIeGQ9q5Gs3lx+w3jQgwl7m2WNDCJpn28St/Dd/seAJKp6pB3fazkXG6
         YT2KgLdK6hlkw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/4] dt-bindings: vendor-prefixes: Add ALFA Network
Date:   Sun,  6 Nov 2022 21:12:15 -0600
Message-Id: <166779074258.500303.13493332831111343217.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
References: <20221013155418.47577-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 13 Oct 2022 11:54:15 -0400, Krzysztof Kozlowski wrote:
> Add vendor prefix for ALFA Network Inc.
> 
> https://www.alfa.com.tw/
> 
> 

Applied, thanks!

[1/4] dt-bindings: vendor-prefixes: Add ALFA Network
      commit: fd42d456bf22a894b3dafe19d7d8302e5de5fcb3
[2/4] dt-bindings: arm: qcom: Document IPQ4018 boards
      commit: 2c36509c9c7b0e9be1ec68828826a3754c5b0f28
[3/4] ARM: dts: qcom: ipq4018-ap120c-ac: Add SoC compatible
      commit: a35f1a75e7e2f73157a16ab56fcc01f09b133e50
[4/4] ARM: dts: qcom: ipq4018-jalapeno: Add SoC compatible
      commit: bd40a8c773165e8175fa51d9f3fdcf00968ce8dc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
