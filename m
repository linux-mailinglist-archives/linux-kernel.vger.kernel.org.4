Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD3666414
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjAKTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjAKTtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:49:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CB63D6;
        Wed, 11 Jan 2023 11:49:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABBA6B81C09;
        Wed, 11 Jan 2023 19:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B11C433F2;
        Wed, 11 Jan 2023 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466556;
        bh=hPzyI3CiEx91WuzyQsH8x/7KWCOERi1lTUONBW/k5gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVHMZnm7L2ovjFtXuWWe03iiEcA4jAdRMGqFqzE0UDBLfWrINisws8v5/fjVFVFVv
         8dAMUwu/TkBjWKSpMCZ9BcpbF4ZPXFMr6PYudiXnwFaGSzDMemqmF2Q21L2FpBKgKt
         vL1oCsyEzqpB3SuBGyER4FH++hyJ4q9KVWVu8pUtktLYQ2V1ys4rWwoV7WrCxPu49J
         dWNiczOhoAHdMoe+LgOCpXJ+b7TIXK4vBiYtwUCDZwtEgzjzhu9AF3qFUqZ0HkzS8i
         1jkQHPc6Vsn6LpoJ8X9myPwBTtmCc5EI5rXWTt+5zlNmSucyG6gTxDXPooJQcvXbuI
         z9VqpUXu7/pnQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        lars@metafoo.de, jic23@kernel.org, konrad.dybcio@linaro.org,
        luca.weiss@fairphone.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Support ADC5_BAT_ID_100K_PU and use on PM7250b
Date:   Wed, 11 Jan 2023 13:49:05 -0600
Message-Id: <167346654444.2315924.9361818063890512484.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230106-pm7250b-bat_id-v1-0-82ca8f2db741@fairphone.com>
References: <20230106-pm7250b-bat_id-v1-0-82ca8f2db741@fairphone.com>
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

On Fri, 06 Jan 2023 16:39:41 +0100, Luca Weiss wrote:
> Add the bat_id channel to vadc driver and add channel to pm7250b dts.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: pm7250b: Add BAT_ID vadc channel
      commit: 7592ba4d3e9bf1cce40323f59e48f4ca03b105e9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
