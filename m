Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D914374CBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjGJFGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGJFFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A810F6;
        Sun,  9 Jul 2023 22:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FC7460E0B;
        Mon, 10 Jul 2023 05:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333BCC433C9;
        Mon, 10 Jul 2023 05:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965481;
        bh=Ly8qWzz6hQ9epLG3pGK8zTPsGJBN6QyRf6FUMLTpHtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCbICDmhHAM27YD/FkL5n1ZZZI4J9Z2DyCDzV51EwSqo5vvpIgvi8SeSUKJ9XC38J
         iOLHiqvo8Uy33HR4vXYdTgDs7E7B2BJQlGW2guYsYGqbKRl/HPvIDf0C2dTUvOaVSt
         at3nuEyBY+6OVGG/HCBxDI9P4gYccM8WkIXBjWCXjgY20jGgzpoMRzKSd1QdzT7Qiv
         Nr92Hh9vPWC5/taZrPPTHD7J1g7ODpHZld7tiGYbKM5LH1IOoIK8vHaufkcTQXEmow
         87A2chw/nk4DiYi8+Tpa50FJkiMUgPPM9Qc8dTCzzwWYHmWQOXZDyI0sBxjGPvN7o0
         0kRuRmT6eBFJA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: rpmpd: Add sync_state
Date:   Sun,  9 Jul 2023 22:07:22 -0700
Message-ID: <168896565960.1376307.6474903581359892505.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619-topic-rpmpd_syncstate-v1-1-54f986cf9444@linaro.org>
References: <20230619-topic-rpmpd_syncstate-v1-1-54f986cf9444@linaro.org>
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


On Mon, 19 Jun 2023 14:32:26 +0200, Konrad Dybcio wrote:
> Add a sync_state implementation, very similar to the one already present
> in the RPMhPD driver.
> 
> 

Applied, thanks!

[1/1] soc: qcom: rpmpd: Add sync_state
      commit: 98c8b3efacaec61287a096dd37ca3c197f298b70

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
