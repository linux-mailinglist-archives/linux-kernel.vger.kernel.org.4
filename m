Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7226733C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjASIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjASIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:33:50 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB9E68409;
        Thu, 19 Jan 2023 00:33:49 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 93F5F80F1;
        Thu, 19 Jan 2023 08:33:48 +0000 (UTC)
Date:   Thu, 19 Jan 2023 10:33:47 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: Re: [PATCH v3 0/2] ARM: dts: n900: use iio driver for accelerometer
Message-ID: <Y8kAa/GlX8IB9P1T@atomide.com>
References: <20221229171348.3543327-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229171348.3543327-1-absicsz@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sicelo A. Mhlongo <absicsz@gmail.com> [221229 19:14]:
> The accelerometer in the N900 is now supported by the iio framework. This patch
> series makes the switch to the new compatible.
> 
> The iio framework does not support some of the extended properties in the 
> previous driver, but the change is useful for modern userspace, which expects
> accelerometers to be exposed via iio.

Applying these into omap-for-v6.3/dt thanks

Tony
