Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A92706283
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjEQIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEQIOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA910C3;
        Wed, 17 May 2023 01:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71AF663AE6;
        Wed, 17 May 2023 08:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D4CC4339E;
        Wed, 17 May 2023 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684311272;
        bh=hQk2V61WT0ZjwjBD2C1jC1NdNjkBIK/8T3va0d3Yt14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1xp/Wh7+3wfQfMWt44YSKyN469bd+w+tMQvSbLbM7YduzmOMeTvzNWLJ1wOke2WO
         UIyGUxhMzohW1yPdTrzHkYhM13UOZo8YA0VTfb0+VnOaTcyw8MV9pznKxtJI5Fco7c
         dNQj9RSzsGXdZx6CroVHj12FKUFpVzaWAGGXnz4y2RChBOLkspNMCHkIAa1komDI39
         XF9E5OR1To0i87muELit2gX31C9X3bJLB+vcRW8Gzr509IKOwHGNbzn1W/Wb52SBOG
         ck3zxBFWzvtYYGpqP05ykHMi+RLQ7tBeLxKFlb/h8EVxcQxWzEisf7SCqD75hzXbCu
         UUfqXiyF+Q/aw==
Date:   Wed, 17 May 2023 13:44:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v11 0/4] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Message-ID: <ZGSM5FHG8Ln2t0G7@matsya>
References: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-05-23, 20:35, Bhupesh Sharma wrote:
> 
> This patchset adds the support for USB SS qmp phy for Qualcomm SM6115
> SoC. For the previous versions of this patch there were conversations
> on irc as to whether this was a 'qcom,usb-ssphy-qmp-usb3-or-dp' or a
> 'qcom,usb-ssphy-qmp-dp-combo' as per downstream code and hardware
> documentation.

Applied patch 1,2

Thanks

-- 
~Vinod
