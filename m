Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D269D6131B1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJaI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJaI2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:28:51 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F5CD260C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:28:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 568F080CD;
        Mon, 31 Oct 2022 08:19:20 +0000 (UTC)
Date:   Mon, 31 Oct 2022 10:28:47 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Subject: Re: [PATCH v2] clocksource/drivers/timer-ti-dm: fix missing
 clk_disable_unprepare in dmtimer_systimer_init_clock()
Message-ID: <Y1+HP+Hw0cMNJIAG@atomide.com>
References: <20221029114427.946520-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029114427.946520-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yang Yingliang <yangyingliang@huawei.com> [221029 11:36]:
> If clk_get_rate() fails which is called after clk_prepare_enable(),
> clk_disable_unprepare() need be called in error path to disable the
> clock in dmtimer_systimer_init_clock().

Reviewed-by: Tony Lindgren <tony@atomide.com>
