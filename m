Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715F69954E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBPNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjBPNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:13:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C75A32CF8;
        Thu, 16 Feb 2023 05:13:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 996D361F93;
        Thu, 16 Feb 2023 13:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEEAC433EF;
        Thu, 16 Feb 2023 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676553184;
        bh=IOmJezREOeIOTxobjrrowR5ko3HRHewbRirrfaN+c0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtMjP3nzGeEkXR8vdN9Ryc1dOHmTk9xZT9tdZwSWbg8nPNvcB83DO2XW0jztLzxse
         QaQz01SbuPmksBBoQKd/S859qYHHPybZV6iFiWNfQaKSwlBnYxK5ImGZ5aORaWnMl5
         +2MHJzZkcCBixD5HQdvmRWSnyz7GaLosdzoTfGBIyr4GZwAOpVMVuYoq6Or+5wesTO
         QNwYlXPZEX4kT5w3un3J4frxqN6iHZwgZvm4G2CPT399f0ZGwqcNnNGO7vZHGpg42O
         38e2KyPz+AXyR9semnDxMJvXq0zrSKNFgiwwoEPfuv8ge8paWxg7/oLZHkaH5E+Zi3
         vMJWV+V4ODkLw==
Date:   Thu, 16 Feb 2023 18:42:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] sm8550: Add support for eUSB2 repeater
Message-ID: <Y+4r2UyBRj4uZ4pH@matsya>
References: <20230208190200.2966723-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208190200.2966723-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-23, 21:01, Abel Vesa wrote:
> This patchset adds support for the eUSB2 repeater found in pmic PM8550B,
> used along with SM8550. Since there is no dedicated generic framework
> for eUSB2 repeaters, the most appropriate subsystem to model it is the
> generic phy. This patchset also adds support for such repeater to the
> eUSB2 PHY found in SM8550. Basically, the eUSB2 PHY will have its own
> "phy" which is actually a repeater.

Applied phy patches, thanks

-- 
~Vinod
