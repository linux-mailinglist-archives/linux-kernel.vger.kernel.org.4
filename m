Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D843689A30
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjBCNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjBCNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:51:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6521FA146A;
        Fri,  3 Feb 2023 05:51:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53251B82AC9;
        Fri,  3 Feb 2023 13:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0303CC433D2;
        Fri,  3 Feb 2023 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675432285;
        bh=KD3LsNmr8AeTUGEQmjS9XypGII1lkv0pPnS38zTLO0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOIeODnIR2cjzp+WhuNKJRp54lthxVAtxUI7ApJwmb/ADlWJ8VXMAemKt2wkAF0tj
         1uvNVOqalYVNqAp/FJNPN1u7vGgamlJ8PdRoOCRveZOmMhPISA4Gdo5vGlga9ahle0
         YRHHDZ+Ms9++QrSQfD6vrCHXR9wd9jQA+14DaZCTve0PaZP1Gz/28A9HjvlDhdYB7Q
         Mm0CVBFE5zO8uD640jTwfSL1TskmBGqIBGwm9BJuytZYRyiC175jHG6hFMUDJJ4fky
         dY+a5D2rD+dSFookB0u3i7//DVowI2cwYKt0Cb44a9iExSbeeD9wXQNkIgRCsCwjO7
         bxQVoRN/V+r9A==
Date:   Fri, 3 Feb 2023 19:21:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2] phy: qcom-qmp: Introduce Kconfig symbols for discrete
 drivers
Message-ID: <Y90RWZAwL0vk7i5X@matsya>
References: <20230202215330.2152726-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202215330.2152726-1-swboyd@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-23, 13:53, Stephen Boyd wrote:
> Introduce a config option for each QMP PHY driver now that the QMP PHY
> mega-driver has been split up into different modules. This allows kernel
> configurators to limit the binary size of the kernel by only compiling
> in the QMP PHY driver that they need.
> 
> Leave the old config QCOM_QMP in place and make it into a menuconfig so
> that 'make olddefconfig' continues to work. Furthermore, set the default
> of the new Kconfig symbols to be QCOM_QMP so that the transition is
> smooth.

Applied, thanks

-- 
~Vinod
