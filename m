Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C154A6205E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiKHB2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiKHB14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C72AE12;
        Mon,  7 Nov 2022 17:27:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA8E611F4;
        Tue,  8 Nov 2022 01:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166B5C43143;
        Tue,  8 Nov 2022 01:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870874;
        bh=3rIhWhWaO/IhkSOEqoQG5y/c79UcKpSiyf3xTXVinD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jz3iIZMe6pL/rIL9Elm05Xwt//0QsMabqjxHScDpN3cm6Dsm1fkHCkT2SDXDp6aDq
         QunJBHd6a+Wd8pBNF7y8hDN7wQZqTo8uVdgTaLbOxonhAf40QTEob09qWOJ4WmNzkY
         pkZl6c03oDdLZw0aEYOFlb3biPFyqRlnHripFPot3mKoGuVKb6HHPh5l4shM8QVeZS
         jiFsJ1PYrqG7LGw5SKAruRSIZQG5CMYP4uGN1OsaDF1ivPJ8gKrrweLc3ZT4kEGq5x
         HOGFe47qUl7WiDm+UXejhEt6b2X23HNUxHHv91RLeGRKuuGNm5bHwudPwdx8hmXc2U
         ZRdxveIlskojg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/2] arm64: dts: qcom: pm6350: add temp sensor and thermal zone config
Date:   Mon,  7 Nov 2022 19:27:26 -0600
Message-Id: <166787084681.599230.14951776882326244215.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221028075405.124809-1-luca.weiss@fairphone.com>
References: <20221028075405.124809-1-luca.weiss@fairphone.com>
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

On Fri, 28 Oct 2022 09:54:04 +0200, Luca Weiss wrote:
> Add temp-alarm device tree node and a default configuration for the
> corresponding thermal zone for this PMIC. Temperatures are based on
> downstream values, except for trip2 where 125°C is used instead of 145°C
> due to limitations without a configured ADC.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: pm6350: add temp sensor and thermal zone config
      commit: 16c0c46f38183573de5361d278772cfed2090b1c
[2/2] arm64: dts: qcom: pm6150l: add temp sensor and thermal zone config
      commit: ce1b5eb74b3ef042b1c797f04e8683e7cad34ae6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
