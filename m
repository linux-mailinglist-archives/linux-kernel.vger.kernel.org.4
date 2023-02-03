Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566E68A460
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjBCVNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjBCVNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:13:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC5A23102;
        Fri,  3 Feb 2023 13:13:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE1F61FFE;
        Fri,  3 Feb 2023 21:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF6FC433EF;
        Fri,  3 Feb 2023 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675458793;
        bh=wD0cJN6Tm9r37/mmwTEEUQeaVE8GiEKNj6SEKB73dsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EY+fVLWnaeDX7JS6BXG8MQc+rBangmmzIqOceTarYT/W/7zZjm7uBXDGW+L98dhho
         uFVTGGh40HkHEPfEIWOEKs8cHDi3f/6dEWvZkFE3slwDFpzgpL5auxv9UcfgqdeyS6
         si4OgEyBX6QRW/EeU4FE+f5My+EWQPqbUn4IgwabiXQWhqcCyLci24zPsL7FROYs+z
         sXRIxstAoTcWSJSr309UYfthU9aHF0MnGRr/ityW2ajTXVZTUYQ5lY+8H+Z97flPDp
         GF5sLGN8WbzP37Q1aU4K7Oe22MNvBlBFac1P6wDAj/oox+S6sSzmZAZLrqm7Jx5fR3
         F3Drb0WKZzyzA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450-nagara: Correct firmware paths
Date:   Fri,  3 Feb 2023 13:15:32 -0800
Message-Id: <167545892334.3290628.10998398232052602739.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203142309.1106349-1-konrad.dybcio@linaro.org>
References: <20230203142309.1106349-1-konrad.dybcio@linaro.org>
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

On Fri, 3 Feb 2023 15:23:09 +0100, Konrad Dybcio wrote:
> Nagara is definitely not SM8350, fix it!
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450-nagara: Correct firmware paths
      commit: e27f38e6255306527e32af85592d805f3360ff94

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
