Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E94719A42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjFAK6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjFAK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:58:28 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DED2F2;
        Thu,  1 Jun 2023 03:58:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F17F380F1;
        Thu,  1 Jun 2023 10:58:26 +0000 (UTC)
Date:   Thu, 1 Jun 2023 13:58:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-omap@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH] serial: core: Don't drop port_mutex in
 serial_core_remove_one_port
Message-ID: <20230601105825.GZ14287@atomide.com>
References: <20230601105548.29965-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601105548.29965-1-steven.price@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Price <steven.price@arm.com> [230601 10:56]:
> Commit 84a9582fd203 ("serial: core: Start managing serial controllers to
> enable runtime PM") required the caller to hold port_mutex rather than
> taking it locally. However the mutex_unlock() call wasn't removed
> causing the mutex to be dropped unexpectly. Remove the call to
> mutex_unlock() (and fix up the early return) to restore correct
> behaviour.
> 
> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")

Reviewed-by: Tony Lindgren <tony@atomide.com>
