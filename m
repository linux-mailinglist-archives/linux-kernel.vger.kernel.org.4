Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574407104F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbjEYE5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjEYEz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86CF19B0;
        Wed, 24 May 2023 21:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2578E642BA;
        Thu, 25 May 2023 04:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA466C4339C;
        Thu, 25 May 2023 04:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990318;
        bh=RlqdAlFBRWPWS1AIhyfo2/h/TNSQGHGcMnTN0rQ2Pfo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cbik4o2tbHJBo1LyPZrSeq3W6l5VEqneG2CE1Uz//tYal/3X0b40gJI418DORowdB
         +tGZaxn/Y6OQRk8DLjYPKfmiIa4UniJ/0mD06sa8GSxvcnKPykASLN90C8RQ1Ob9PL
         ECKioKfXhu+YljFuy97xh2LkttW4WJ2AYiASKPkLcAw5GvLMsVQ1pVsutxi57uhyKU
         a6CSe0vh1HQNmOFYnz8FVmjdCWf0V8/QSxQ6fCgHoMnIvLrILcD6RBlf4pxobPS7KV
         4MG20cPVLx1kbDylu/I3i8L1JripS7wObXkLPHWzj6iSx5La4Fuk5CFPq3Xlppq3T4
         sKw6oM7+mUkVA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, Kathiravan T <quic_kathirav@quicinc.com>
Subject: Re: [PATCH V2 0/2] Add SoC ID for IPQ5312 and IPQ5302
Date:   Wed, 24 May 2023 21:54:36 -0700
Message-Id: <168499048182.3998961.14268571937081566896.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509033531.21468-1-quic_kathirav@quicinc.com>
References: <20230509033531.21468-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 09:05:29 +0530, Kathiravan T wrote:
> Kathiravan T (2):
>   dt-bindings: arm: qcom,ids: add SoC ID for IPQ5312 and IPQ5302
>   soc: qcom: socinfo: Add Soc ID for IPQ5312 and IPQ5302
> 
> drivers/soc/qcom/socinfo.c         | 2 ++
>  include/dt-bindings/arm/qcom,ids.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: add SoC ID for IPQ5312 and IPQ5302
      commit: fe78d73a914d86070ac15c9a6d1f885ce5bc4a69
[2/2] soc: qcom: socinfo: Add Soc ID for IPQ5312 and IPQ5302
      commit: 7f6e0028a0ca4317aeb070084e72d44ca39ace7e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
