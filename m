Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB3712C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjEZS2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242340AbjEZS21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:28:27 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D0125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:28:25 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 1846e744-fbf3-11ed-b972-005056bdfda7;
        Fri, 26 May 2023 21:28:23 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 26 May 2023 21:28:22 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 07/11] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Message-ID: <ZHD6Rps5laEYfut4@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
 <20230525040324.3773741-8-hugo@hugovil.com>
 <ZG9CWhiTbLBKjPC9@surfacebook>
 <20230525103443.d3d31e80221aed1ebceef30e@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525103443.d3d31e80221aed1ebceef30e@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, May 25, 2023 at 10:34:43AM -0400, Hugo Villeneuve kirjoitti:
> On Thu, 25 May 2023 14:11:22 +0300
> andy.shevchenko@gmail.com wrote:
> > Thu, May 25, 2023 at 12:03:21AM -0400, Hugo Villeneuve kirjoitti:

...

> > I'm wondering if we can convert this to YAML first and then add a new
> > property.
> 
> I also thought about it, then decided to focus on simply adding the new
> property first since I am not an expert in YAML.
> 
> I think it would be best to do it after this patch series. Keep in mind that
> the original intent of this patch series, and this new property, was to fix a
> regression related to the GPIOs, and I think that converting to YAML would
> simply delay and add much noise to the discussion at this point.

The patch doesn't have Fixes tag, so it's definitely not a fix. Also new
property can fix a regression, it's impossible to fix the users' DTBs.

> If someone wants to do it as a separate patch after this, fine. If not, I an
> willing to give it a go.

Not a DT maintainer here, I'm fine with either way.

-- 
With Best Regards,
Andy Shevchenko


