Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF36F648C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 07:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjEDFwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 01:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjEDFwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 01:52:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 828701731;
        Wed,  3 May 2023 22:51:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CE41680C1;
        Thu,  4 May 2023 05:51:57 +0000 (UTC)
Date:   Thu, 4 May 2023 08:51:56 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230504055156.GO14287@atomide.com>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
 <20230425201117.457f224c@aktux>
 <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
 <20230425212040.5a4d5b09@aktux>
 <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
 <20230425215848.247a936a@aktux>
 <20230426071910.GE14287@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426071910.GE14287@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230426 07:20]:
> Seems that we should just revert this patch for now and try again after
> the issues have been fixed.

Looking at the proposed fixes being posted seems like they are quite
intrusive.. How about we partially revert this patch so omap1 still
uses static assigment of gpios?

This way the later SoCs can avoid the warnings and the legacy board
file and driver changes can get merged during the next merge window.

Regards,

Tony
