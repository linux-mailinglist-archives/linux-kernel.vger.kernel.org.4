Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A74270E2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbjEWQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbjEWQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:56:17 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E70198
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:56:13 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id b8b31ff5-f98a-11ed-b3cf-005056bd6ce9;
        Tue, 23 May 2023 19:56:12 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 19:56:11 +0300
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, hdegoede@redhat.com, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com
Subject: Re: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for
 suspend related messages
Message-ID: <ZGzwKwkWU6aJRQ1S@surfacebook>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522200033.2605-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 03:00:33PM -0500, Mario Limonciello kirjoitti:
> Using pm_pr_dbg() allows users to toggle `/sys/power/pm_debug_messages`
> as a single knob to turn on messages that amd-pmc can emit to aid in
> any s2idle debugging.

It has the same two regressions as I pointed out in previous reply.

-- 
With Best Regards,
Andy Shevchenko


