Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D6705FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjEQG00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjEQG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:26:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DFB749EE;
        Tue, 16 May 2023 23:25:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 219918108;
        Wed, 17 May 2023 06:25:49 +0000 (UTC)
Date:   Wed, 17 May 2023 09:25:47 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lee@kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com, nm@ti.com,
        afd@ti.com, msp@baylibre.com
Subject: Re: [PATCH] mfd: tps65219: Add support for soft shutdown via sys-off
 API
Message-ID: <20230517062547.GN14287@atomide.com>
References: <20230511122100.2225417-1-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511122100.2225417-1-jneanne@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jerome Neanne <jneanne@baylibre.com> [230511 12:21]:
> Use new API for power-off mode support:
> Link: https://lwn.net/Articles/894511/
> Link: https://lore.kernel.org/all/7hfseqa7l0.fsf@baylibre.com/
> 
> sys-off API allows support of shutdown handler and restart handler.

Reviewed-by: Tony Lindgren <tony@atomide.com>
