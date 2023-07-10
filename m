Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8074CBD4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjGJFGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjGJFFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C105E19B6;
        Sun,  9 Jul 2023 22:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADEC160DE2;
        Mon, 10 Jul 2023 05:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4908EC433BF;
        Mon, 10 Jul 2023 05:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965484;
        bh=zEY2Gf2T1TbVG9MEs4vDmhR2ngcCtjLFZKD+16Q4S2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btKGo4nnIYN+mIsmUJH0j62aHYZQPihMYSHP48CfCF04SsJvgJieRfsVW7PbXnPnk
         5oklrjEeFSaQ0Fsck5Xd/GaVq48Z+XtPgWdJmG5KgLoZylKlS9gaq2+Hz7YIOw3UME
         9dXjATuk0oiN+bo4LR2nPUNcy3ae01nJKkAdt4xgJRMGFihM8hj1moBYJIOUwcAbai
         rt3BlQXNR8mNKOTLt3QG3ZYRtIehFJ8stPkc90SpWp7XxetWyE31xjcDClN2OiddMr
         +aC3fI26BwfTbjErxxRanOtRMZomttJbpZ2j4ZUh+hq9hTvEWs9bG8FoyX7Z12Q7x+
         crx/yUtX+PEPg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 0/4] A610 enablement, J606F display
Date:   Sun,  9 Jul 2023 22:07:24 -0700
Message-ID: <168896565966.1376307.8332596344598642435.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620-topic-gpu_tablet_disp-v2-0-0538ea1beb0b@linaro.org>
References: <20230620-topic-gpu_tablet_disp-v2-0-0538ea1beb0b@linaro.org>
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


On Wed, 21 Jun 2023 13:21:51 +0200, Konrad Dybcio wrote:
> Enable the A610 GPU on SM6115, as well as on the RB2 and J606F boards.
> Add display support for the latter.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sm6115: Add GPU nodes
      commit: 11750af256f8287f853daed0424eac726dcc5b9f
[2/4] arm64: dts: qcom: sm6115p-j606f: Hook up display
      commit: e3dc814d8ca0fb3c8e2760d004ea048e502887a4
[3/4] arm64: dts: qcom: sm6115p-j606f: Enable GPU
      commit: be9f88abf8695b59f17ac0ef365cd2d2a9baae78
[4/4] arm64: dts: qcom: qrb4210-rb2: Enable GPU
      commit: d368279dfa02c6c1eb5eb91126613769527d450b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
