Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61005BB885
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIQNbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIQNbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D3AB7FD;
        Sat, 17 Sep 2022 06:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 415FF61140;
        Sat, 17 Sep 2022 13:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89607C433D7;
        Sat, 17 Sep 2022 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663421466;
        bh=JwoRkYtBS5Ryz9d9fB3jgYVYzUySbqoYzL4oZ8VII3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=niemHtG118jvmTcaAJ0SEh3WhrYREueXrl/sXytTFnmsMyrAtYBpuZdz8ulTLnBDc
         XHEOV4TsoO7hwdGzOKR6fjhur692Zzv2zih3d1okp7YGPL1WxQRDRgTSgxzPLroWO4
         Mx+Vbmrv7BAM3hveqj8MRwV877W9bjmJOCfZUCxGoEP5hRdPPFnT9wRYQy1ZMEXrnO
         WfXYmbXdLm7xnJzwRJi9rrwndAfwiMIUCmAyC4wOspKIVPPnhYwjO4eHCAevncfz36
         EABIWfB/4eP4lKsCj6nRBACR6FEX7cM3mOFYA7/GsTzYHJlycMcBBV/J0QQOh3vQcj
         tpC5I0JkTtqcQ==
Date:   Sat, 17 Sep 2022 14:31:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] iio: pressure: bmp280: Add more tunable config
 parameters for BMP380
Message-ID: <20220917143109.6a22b2a3@jic23-huawei>
In-Reply-To: <876f8a2277f71672488e99aa02aae4239d530f51.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
        <876f8a2277f71672488e99aa02aae4239d530f51.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 01:54:42 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Allows sampling frequency and IIR filter coefficients configuration
> using sysfs ABI.
> 
> The IIR filter coefficient is configurable using the sysfs attribute
> "filter_low_pass_3db_frequency".
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

Applied to the togreg branch of iio.git and initially pushed out
as testing for the autobuilders to poke at it.

Thanks,

Jonathan
