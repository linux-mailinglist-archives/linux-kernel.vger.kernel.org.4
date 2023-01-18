Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F624672D31
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjARX43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjARX4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:56:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2734FC24;
        Wed, 18 Jan 2023 15:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1059E61AD5;
        Wed, 18 Jan 2023 23:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AE4C433EF;
        Wed, 18 Jan 2023 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086158;
        bh=CsmRA7hJj/+Yh7otRjmQK/BIao3htXGiXMDozIui/JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCLL/zOS8Gx1x1W90iTvTbX6Wpx6SlMnkVnKNpiT2HWjdUHkLDRf/lB8gFU/yZv/8
         XVX3eq5pBdQ5QRAeBQqxSGKuiRdYhHiGUdVXsxu99uOmRrLcabKBEdDQ2x18uovQT/
         qXj0VAJcJmKYRPXKnA+pnbCNNywhagLmuopxEuEFubkbECZL4IRG185ekVkHaXto22
         7d9kl6fx1/O8gt7GhqsfKq1ao7K/9vzxV1fhlLxYWCA5xyb8wnR+lVoQkbs6k2jfwW
         PC4gwl9Q74i8d0TkGSnps+KqMhEHLYHP1RnWrT6RCXPAawuTIb6+RzqauH+U8Wk2qT
         3JISqCSGckzNw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        rfoss@kernel.org
Cc:     robert.foss@linaro.org
Subject: Re: [PATCH v1] arm64: dts: qcom: sm8350: Add &tlmm gpio-line-names
Date:   Wed, 18 Jan 2023 17:55:42 -0600
Message-Id: <167408614052.2989059.9404889249188584289.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230117112537.1016250-1-rfoss@kernel.org>
References: <20230117112537.1016250-1-rfoss@kernel.org>
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

On Tue, 17 Jan 2023 12:25:37 +0100, rfoss@kernel.org wrote:
> From: Robert Foss <robert.foss@linaro.org>
> 
> Add GPIO line names as described by the sm8350-hdk schematic.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: Add &tlmm gpio-line-names
      commit: 638b7ada91f93d61cb65774dcb6ff2b7dcae3627

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
