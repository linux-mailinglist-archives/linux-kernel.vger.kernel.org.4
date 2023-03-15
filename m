Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4016BB5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjCOOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjCOOOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D736FED;
        Wed, 15 Mar 2023 07:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B387761D97;
        Wed, 15 Mar 2023 14:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B79EC433EF;
        Wed, 15 Mar 2023 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678889630;
        bh=V2DqD28+RXNNjS2aAghs1Y8A/D9Ogfl49T6VIVzYeCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4JKQ2lArhj5lU24BlQ/yJmiUZWxYbmoHE6CmLB7YIGMFck78npmWTUab94bFWHci
         fjk6Uabk1XX+GUseY2gTB7acpc1FGpP8g6W8xVw/RFdjOfmS7OwgK3b2yc2tYG41f/
         VIax0vgTBZImzLMZCankk12+tg2PnksSqJ+Ha+/nZ1jQrurnGceVnP9wJyK0ZrTaFu
         P7RqlWNLVOWz89OpTiLqWWIENKaHJ8FwjcwWXb1d/bY9M9fGInbsnfdnrUPjbaK6Kp
         C/GjoGuZqG5rN1nQbO0sfZ4t11FeE8/8r3VmAcyGBJ66jN58dHy7rQKCDuZlpW7LB2
         2slgZjUvWhDBw==
Date:   Wed, 15 Mar 2023 19:43:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soundwire: qcom: define hardcoded version magic
 numbers
Message-ID: <ZBHSmb3TlR0Bv3o7@matsya>
References: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-23, 15:44, Krzysztof Kozlowski wrote:
> Use a define instead of hard-coded register values for Soundwire
> hardware version number, because it is a bit easier to read and allows
> to drop explaining comment.

Applied both, thanks

-- 
~Vinod
