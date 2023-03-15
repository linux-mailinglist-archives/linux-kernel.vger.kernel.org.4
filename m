Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C96BC186
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjCOXf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjCOXfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:35:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178DEA8EB0;
        Wed, 15 Mar 2023 16:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C01C461EAB;
        Wed, 15 Mar 2023 23:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD95C433D2;
        Wed, 15 Mar 2023 23:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923170;
        bh=t7+Fc3/HfjcAPtm2VleZ2987TXjNK3lB5tjbiH6eVv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aS3ilp4S+z6QOY/Kyr2O/+gzKybdn5wBJ1iCnsJfmfWl/hinqkdHuI1CsjUwurlVv
         6zGKtLdgmymsUIy+2T6gJaGlAIRNXyE3altUwGlGzvzGibvrughr3MvvdGWSYwKHf7
         V00LuQGtDkDVSrTugMF6IfVhp/ob22ywPQtg+FheSeDJzQNdz8hgCiHvtnel+p+bQW
         H8NKK+3FQILT1Ef7ebWPMXrwZvIvwsH8KuAOHEp+VcE5ByI7oF41NFz1/TVgh520m+
         7+cC01jEOaFZCaJGXsA/Lc+1WXKp1QmIV2ZAkSxfUVc33/3vQgKmhvC/TuW9b66s/Q
         jJEjtkc+YouIg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, elder@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8450: Add IMEM and PIL info region
Date:   Wed, 15 Mar 2023 16:35:21 -0700
Message-Id: <167892332567.4030021.9263636003654841857.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1677079845-17650-1-git-send-email-quic_mojha@quicinc.com>
References: <1677079845-17650-1-git-send-email-quic_mojha@quicinc.com>
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

On Wed, 22 Feb 2023 21:00:45 +0530, Mukesh Ojha wrote:
> Add a simple-mfd representing IMEM on SM8450 and define the PIL
> relocation info region, so that post mortem tools will be able
> to locate the loaded remoteprocs.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: Add IMEM and PIL info region
      commit: d39469f5ce81b2cabf07b1cad3deddeafb7b8a8d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
