Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4086B71F842
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjFBB76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjFBB74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:59:56 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1813E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:59:55 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 2a11ee8b-00e9-11ee-a9de-005056bdf889;
        Fri, 02 Jun 2023 04:59:53 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 2 Jun 2023 04:59:52 +0300
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Rafael Wysocki <rafael@kernel.org>, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH v3 1/4] include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume
Message-ID: <ZHlNGF79cwicmWde@surfacebook>
References: <20230601232923.1248-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601232923.1248-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 06:29:20PM -0500, Mario Limonciello kirjoitti:
> All uses in the kernel are currently already oriented around
> suspend/resume. As some other parts of the kernel may also use these
> messages in functions that could also be used outside of
> suspend/resume, only enable in suspend/resume path.

...

>  * Remove pointless do/while

I believe this is a joke.

This guards against weirdness, like

	__pm_pr_dbg(foo)
	else
		bar;

NAK for this particular change.

-- 
With Best Regards,
Andy Shevchenko


