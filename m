Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C034667A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjALQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjALQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:15:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEDA55A1;
        Thu, 12 Jan 2023 08:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D6A6206E;
        Thu, 12 Jan 2023 16:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E96C433EF;
        Thu, 12 Jan 2023 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673539948;
        bh=dX2scFFzTh1LRjQiS/hvAmTEVH8M+mE8PnR/uCjzsvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+R5mGnr0I2WZDUeEB3kBTez2MsBxaIywJRrwDcrvygv7dBkUn/LJw0grQfWTN5hX
         hoIMZl0rYZRf7ufoZOntczjdLnnQ0iAdzMZhcmLfoxuDVEdUXDJid0nkX8sWCRK17S
         1+QPSyYAts4O/djtYUGMnO3ju3gQkETUdJLxaW50TB+q4L4y8s2te4ZJrgukZFnWeH
         /FFu7j5ycHvxjvRqdNAqgsJg+kXxt83+hUgICY1czE/g9Ui4ravYJ8TaTXJ+Z5sWkK
         8LX0XjE7K2CYc2woCoPJiZFRmFytfcqBcK49czRcERG5SL5F+l5FfUEylscf+uSMWF
         NLea5WBksqVWw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, quic_mojha@quicinc.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: mfd: qcom,tcsr: Add compatible for sm8450
Date:   Thu, 12 Jan 2023 10:12:23 -0600
Message-Id: <167353993748.2393683.2612853906580487491.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
References: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
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

On Thu, 12 Jan 2023 14:24:56 +0530, Mukesh Ojha wrote:
> Document the qcom,sm8450-tcsr compatible.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8450: Add TCSR halt register space
      commit: 1f731bbf71e374d93d477831518402ebcfddb75b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
