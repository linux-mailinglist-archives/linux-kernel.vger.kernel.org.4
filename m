Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF916205E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiKHB2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiKHB14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A12AE11;
        Mon,  7 Nov 2022 17:27:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14BCCB81717;
        Tue,  8 Nov 2022 01:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE831C433B5;
        Tue,  8 Nov 2022 01:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870871;
        bh=Y7HSCIjpVlJ0sTi3TaP9mSaVIbx6PToqk6Hxyezlq/k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EWqcf/zTypxGtWscklvezTDNo/WFRPqvccnCkrFcRgMs/FeTbGHQTqb7KQmnv+syd
         lw5+mqO8IkFUwWIUyBiuYmlnfEaLBoejHAD93dWssHSiVJK0MZTABUTCbYWXdTCwqS
         lg5R8Im6+55pxdB97u6c+pW9VRv/x6SYyzcyPNJb6VR2R89qDpqZj7XnUVI9s8qL7i
         SkMxGrk5oqjCiREzoswBQRcLpJxCuF/YVLjhPgNPSGjuTA5FTR8jKg0/JQy2jWjX/B
         wBWUYoFubjVYzcLQnxsH0k5eh5YuV15wIv8UfTxG2yfRkG0rgZB1kyFyZCsOJD1M6R
         cDo1lw0mfvDew==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: qcs404: align TLMM pin configuration with DT schema
Date:   Mon,  7 Nov 2022 19:27:24 -0600
Message-Id: <166787084686.599230.5443101144952745052.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104161131.57719-1-krzysztof.kozlowski@linaro.org>
References: <20221104161131.57719-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 4 Nov 2022 12:11:30 -0400, Krzysztof Kozlowski wrote:
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: qcs404: align TLMM pin configuration with DT schema
      commit: a979f2e5d5b530d190b9c02393f3c69160f06aae

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
