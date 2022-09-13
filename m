Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5F75B7627
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiIMQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiIMQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:09:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB474CF7;
        Tue, 13 Sep 2022 08:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B10AB80F91;
        Tue, 13 Sep 2022 15:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F83C433C1;
        Tue, 13 Sep 2022 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081491;
        bh=uBt1Nx391HTIc29tju+LhHlN3Nn6NpFnc1kVjX52Dc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRyossn3zNZVxG6BsACXX35rHrGAlJdeYiSjpizA4ADu3RcGv1vkmIxY/RGQHaXOI
         Xr1ug5i1IoQtAj1DcpRG0sBaWt+ZIhg/X47klM6M10Fmmj/1b0nKDQMVCzPP8JI5li
         lpIwPVMzcS/YtzVcS84RHhgP6z/d1/I/qWj8lVXYOXig+Rr2YEXHV5y+jODnqU9LGi
         BohKBGdaZ+J6nWmW0UTTsl+LA/pomsM5TkXXdvni8/Mgao1FTRInYzypts03XYxZUc
         f30X2XIM93biYLfHS8gDuvEbaQq53W6h6K6ncg3Ff/GA+GvkLTrV7btQpDOV/xc6Gp
         PUQL48wzqEobg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, quic_rjendra@quicinc.com,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: correct CPU BWMON unit address
Date:   Tue, 13 Sep 2022 10:04:43 -0500
Message-Id: <166308148200.625876.9745403373729682305.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908085830.39141-1-krzysztof.kozlowski@linaro.org>
References: <20220908085830.39141-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 8 Sep 2022 10:58:30 +0200, Krzysztof Kozlowski wrote:
> Correct CPU BWMON unit address to match the "reg" property.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: correct CPU BWMON unit address
      commit: b626ac159e5e2ca3eac4079622b9f4105814768f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
