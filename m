Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA655B932F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiIODhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIODhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EF48FD5E;
        Wed, 14 Sep 2022 20:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E298F6207C;
        Thu, 15 Sep 2022 03:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE29C433C1;
        Thu, 15 Sep 2022 03:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213026;
        bh=NA4vUx3CdUJJXA0CDhqCgLfROQzZlzUG1H7jgLMiY2E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uWTGkVvLAb0zEwelr8UxbaNTClJ1DG1AiBeTB2vZmE9tkjDdgZTxdGtB9UJO4pseC
         I0A1YFHXfb+x3cV/mfAKIG4QiPbo61JinlXlKwXbVQ7WbEh7Wjx8/a1zD9hc5IqcEn
         bXQXeqaClH5FC6btlu/3d3iXdW/9wMsFUPxMiLSzk7hwPjve8ApcdR7soUShzHNvS+
         a7MfMz9P7HUG8c9KeawDRf0dmYRKxN2rdJLN1YSkPqZOLAKaSvjLRF+3xNOGEAmOX3
         M4H/FRuJmzvm3SWvBvIRmEBtxcu1rWDtqwSi2ousscj65dooHF45e5pvRLM7SqgzcK
         1rvB3utn3RNrQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@somainline.org,
        Bjorn Andersson <andersson@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and sort them
Date:   Wed, 14 Sep 2022 22:36:49 -0500
Message-Id: <166321302061.788007.18183689542662464163.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220718153815.29414-1-ansuelsmth@gmail.com>
References: <20220718153815.29414-1-ansuelsmth@gmail.com>
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

On Mon, 18 Jul 2022 17:38:14 +0200, Christian Marangi wrote:
> Reorganize node order and sort them by address.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: ipq8064: reorganize node order and sort them
      commit: ee1e278a84e7578e4aa20820852b7f73b4929c63
[2/2] ARM: dts: qcom: ipq8064: pad addresses to 8 digit
      commit: cc02fed341d5f5ea1af531ced213c41a836a3678

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
