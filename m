Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06BD701FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbjENVKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:10:45 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136210D7
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:10:43 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id c70aa805-f29b-11ed-b972-005056bdfda7;
        Mon, 15 May 2023 00:10:39 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 15 May 2023 00:10:39 +0300
To:     Lizhe <sensor1010@163.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drivers/pinconf.c: Remove redundant check for the
 existence of the member
Message-ID: <ZGFOT9cWNTzJDXo7@surfacebook>
References: <20230514165932.251200-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514165932.251200-1-sensor1010@163.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 15, 2023 at 12:59:32AM +0800, Lizhe kirjoitti:
> "pin_config_set" in pinconf_ops.
> 
> In the function of registering pinctrl_dev, pinctrl_init_controller(),
> a non-null check has already been performed on the members
> pin_config_set and pin_config_group_set in the ops structure.

NAK.

Try to analyse what `if (!foo && !bar)` means from the logic perspective and
deduce from that the problem in your proposal.

P.S. It's not the first wrong proposed change from you. Dunno if you even
trying to read the code...

-- 
With Best Regards,
Andy Shevchenko


