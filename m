Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F171763C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjEaFcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjEaFcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:32:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F085A11F;
        Tue, 30 May 2023 22:32:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 33B458164;
        Wed, 31 May 2023 05:32:06 +0000 (UTC)
Date:   Wed, 31 May 2023 08:32:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Prathu Baronia <quic_pbaronia@quicinc.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: omap1: replace printk() with pr_err macro
Message-ID: <20230531053204.GW14287@atomide.com>
References: <20230518103324.881394-1-quic_pbaronia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518103324.881394-1-quic_pbaronia@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Prathu Baronia <quic_pbaronia@quicinc.com> [230518 13:34]:
> Use pr_err() macro instead of printk(KERN_ERR "...").

Thanks applying into omap-for-v6.5/cleanup.

Tony
