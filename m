Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D893649964
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiLLHQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiLLHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:16:20 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 930547665;
        Sun, 11 Dec 2022 23:16:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DA80B80B3;
        Mon, 12 Dec 2022 07:16:18 +0000 (UTC)
Date:   Mon, 12 Dec 2022 09:16:17 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "B. Niedermayr" <benedikt.niedermayr@siemens.com>
Cc:     linux-next@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OMAP GENERAL PURPOSE MEMORY CONTROLLER SUPPORT" 
        <linux-omap@vger.kernel.org>,
        "open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory: omap-gpmc: fix wait pin validation
Message-ID: <Y5bVQSfFV+luA6T0@atomide.com>
References: <20221209123147.591982-1-benedikt.niedermayr@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209123147.591982-1-benedikt.niedermayr@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* B. Niedermayr <benedikt.niedermayr@siemens.com> [221209 12:32]:
> From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> 
> This bug has been introduced after switching from -1 to UINT_MAX
> for GPMC_WAITPIN_INVALID.
> 
> The bug leads to an error when the optional gpmc,wait-pin
> dt-property is not used:
> 
> ...
> gpmc_cs_program_settings: invalid wait-pin (-1)
> ...

This fixes the issue thanks:

Tested-by: Tony Lindgren <tony@atomide.com>
