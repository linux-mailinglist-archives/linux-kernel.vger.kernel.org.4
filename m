Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F0C5BDBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiITFFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiITFFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:05:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66426ACC;
        Mon, 19 Sep 2022 22:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18A61B82469;
        Tue, 20 Sep 2022 05:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465BCC433C1;
        Tue, 20 Sep 2022 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663650299;
        bh=wnzt8PW3zP9wtrewvt5xUq0/W2ToEB86MUL4a6EzQ74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alEivXXaV7UE1FPN9+i6lHMvQP2Y35TWzGnpVSO3WlAf+WoMPOlV08+t10uNZAmA6
         UQUSQfjdv0x1Mg3ErWUUZP2GXVQZFLoPJpwP30grxbu3FM8mojq6oWoqXWAWPE4JSW
         Q9DslhB7EwVpjekwVUEeAIMCWwRxxMvVaNxCHLVvVZzVgMaGXvNHyKyv7+Yt4XGO7k
         4zHGFY1RThlLcALwNrOhntokSCtcqciIE75WEvvUKnnp5kNMWhjCoVhwC9eEJlG4ur
         30a3agResor32XjxuoTFXacUYEzZRZSDEr9whTllllOID0U1sQWJ+wQthn2KTfl3wj
         6Md58N9TCp+nQ==
Date:   Tue, 20 Sep 2022 10:34:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH v2 1/2] soundwire: qcom: update status from device id 1
Message-ID: <YylJ90Vu7SUhSNIo@matsya>
References: <20220916135352.19114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916135352.19114-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-22, 14:53, Srinivas Kandagatla wrote:
> By default autoenumeration is enabled on QCom SoundWire controller
> which means the core should not be dealing with device 0 w.r.t enumeration.
> 
> During Enumeration if SoundWire core sees status[0] as SDW_SLAVE_ATTACHED and
> start programming the device id, however reading DEVID registers return zeros
> which does not match to any of the slaves in the list and the core attempts
> to park this device to Group 13.  This results in adding SoundWire device
> with enumeration address 0:0:0:0
> 
> Fix this by not passing device 0 status to SoundWire core.

Applied after fixing typi pointed by Pierre, thanks

Also, pls check, I got conflict which was resolved

-- 
~Vinod
