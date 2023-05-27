Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F695713411
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjE0KkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjE0KkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35545124;
        Sat, 27 May 2023 03:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C666E60BC8;
        Sat, 27 May 2023 10:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE54C433EF;
        Sat, 27 May 2023 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685184007;
        bh=8Isxwih0uAr3zq1l6ccw91UiAglHni0Ws5Oq5epCgug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P63HBa+pLzOSxeK2Gt8+V/G29qLAkj0FIWwT177wpeWTv2OkzRyq32e76VRWeslf7
         LxMq6VtYf5JWwZzcUWcLr0hL77u/wVniZPbPIzh8qMo/GWBvRWWPqWcXRHVcMgib+G
         FdpWXzXw5uTUTbMTgVZXyAX70wF31rqXNZyxyoFq9aTxR8/PJ7Mf+kb1GxTLcCCWlm
         /DTFbLtGTRNV2TIOzh+MPk1bpb6fndhXhBPsRHIpjiZBUCO9i8lk35F1hAueFDmzfi
         kMA/NMtPksWOifI65yHktvH0phKq3UPmmM/GDy7jmLIm7MXvcSLiIphUad1ipofu2G
         eDUPMnTeGTOPg==
Date:   Sat, 27 May 2023 16:10:03 +0530
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
Subject: Re: [RESEND PATCH] soundwire: qcom: drop unused struct
 qcom_swrm_ctrl members
Message-ID: <ZHHeA7TU3YQS5Bib@matsya>
References: <20230515132000.399745-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515132000.399745-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-23, 15:20, Krzysztof Kozlowski wrote:
> Drop unused members from the driver state container: struct qcom_swrm_ctrl.

Applied, thanks

-- 
~Vinod
