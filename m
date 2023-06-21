Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41A738395
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjFUMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFUMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:16:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F2DD;
        Wed, 21 Jun 2023 05:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8A0761545;
        Wed, 21 Jun 2023 12:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48464C433C0;
        Wed, 21 Jun 2023 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687349810;
        bh=JXIwDofI9GYjGLRPPWn170gzYnLu+hqTNCc91usYlLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+FnuV9F8FOm/SkPSh0F54HASVB8c9jUgRJImpENhLbUsof3A6+47KnQObClkV0YY
         fmlH3urfSg28mFX/47z54gj8eP1ZEf6r29k8Sl5r8ZEHuJKuGh+O9clZtJJbc8Kg1j
         690lcbQ5FFp8YPxKivkkyOwmeiigRv0uiww9PKXYw17liacOqBeJ66Vuzx4gvSvcRq
         dyvgHIt1BKpaWbZtHZXBxBbn1ByxYdayNmK6gg6GQxOB7mg6FnGgrw0TPzKeKRd1Am
         RUjoACbQBT/BZAyhMcN7sNiZXQikaQjtJcZJoPjTO3T6u25f/j4SAYHqEBFwohj94o
         RlUDWCyX5LrlA==
Date:   Wed, 21 Jun 2023 17:46:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: qmp-combo: fix Display Port PHY configuration
 for SM8550
Message-ID: <ZJLqLcf/hDmgx5RF@matsya>
References: <20230601-topic-sm8550-upstream-dp-phy-init-fix-v1-1-4e9da9f97991@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601-topic-sm8550-upstream-dp-phy-init-fix-v1-1-4e9da9f97991@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-06-23, 11:39, Neil Armstrong wrote:
> The SM8550 PHY also uses a different offset for the CMN_STATUS reg,
> use the right one for the v6 Display Port configuration.

Applied, thanks

-- 
~Vinod
