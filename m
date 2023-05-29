Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61B7143A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjE2FOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2FOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1E9E;
        Sun, 28 May 2023 22:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DC7261028;
        Mon, 29 May 2023 05:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA324C433EF;
        Mon, 29 May 2023 05:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685337238;
        bh=OxGM0AKBIx1XvIlUi5jL9Y/t0Cuh7kuMddjsyZ2j52M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8io3SHganogAgrD8ffbKmawDWKacV9I4vjf0B2uUTRup5dH5a7GA2OmxpTI0K2Ez
         +avXfFu6Q+2bdI26UlqWnM3JBo9LCTyJ2tbSIIqC/RH+95QUQK2IC7Fysk9xaVJgLD
         eVDTFYssWJskm7XgA1NCGlLMxYew5FvpYd+SNM7JROjFnZcPLzSaGP/46X8r0IhVSz
         a+6ocY8eWpvb9MsGZW8ZvnxMm9FYbzMs5XCyq7yRHaZmEnFlPMRXk92vutHYPWVzae
         jBAsca0UBWe37K8T2b9/u1brcqyxYrT0oETt2CuNd9Jwjb1DiITnNXY6XYjySXtE88
         zhEPlDMnP+Aew==
Date:   Mon, 29 May 2023 10:43:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] soundwire: qcom: stablity fixes
Message-ID: <ZHQ0kosUz15P8jo+@matsya>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-23, 14:38, Srinivas Kandagatla wrote:
> During x13s audio testing we hit few corner cases due to issues
> in codec drivers and some obvious code bugs.
> 
> Here are the fixes for those issues, mostly the issues are around
> devices loosing the sync in between runtime pm suspend resume path.

Applied, thanks

-- 
~Vinod
