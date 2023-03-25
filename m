Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D06C8F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjCYQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:12:01 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Mar 2023 09:11:59 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF6E192;
        Sat, 25 Mar 2023 09:11:58 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4PkNt02rTGz9sSP;
        Sat, 25 Mar 2023 16:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1679759640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0TYQawUAqRpI2Fv/GPDX28AxWWdreTmSldYYgDDUG0I=;
        b=alBFC/JmyiMbU7N7uiCj0ObhfIIoqEXq5wCZ2KBYvgn37TOTTwKVwQctlx9SXb6AN7UY+U
        OzAGirY7JxcW6D49j1j/oeCjE+13w9bJu95CCJEMYDk8IXBaf8HyM9101XKykBmhiv1UpA
        GznyaPrdvGXyIH4FVqZdgTOoBJGPb3yqsMfwXWRLAKDrEpIHIB/hQGzSuAA+K1CVk9Yz+e
        D2MReC4MZ5AhnPzLkJpwClPylsMCgjzFxhXy7XRcBzVL+oQbW22jt3P7ODYIWVzeQUV7/z
        Psi8AKtAaFxv4IpMRHhgq2+KXZ81WISz46kOuQsRbU0sMcMTn7Gz7V+gji2q5g==
Date:   Sat, 25 Mar 2023 10:53:55 -0500
From:   Joseph Strauss <jstrauss@mailbox.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     lee@kernel.org, jansimon.moeller@gmx.de, conor@kernel.org,
        christophe.jaillet@wanadoo.fr, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Add multicolor support to BlinkM LED driver
Message-ID: <20230325155355.gxnjpyl3mnyq2lst@libretux>
References: <20221228010958.9670-1-jstrauss@mailbox.org>
 <ZBw5E4ecNvfgd0RB@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBw5E4ecNvfgd0RB@duo.ucw.cz>
X-MBO-RS-ID: 072ee88ef689a48dbea
X-MBO-RS-META: 9rbinopkeat1hthumqcbdhzex87iqowh
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/23 12:33PM, Pavel Machek wrote:
> Hi!
> 
> > In the blinkm_probe function, the multicolor LED class is registered
> > after the regular LED classes. The blinkm_set_mc_brightness() function
> > had to be added to calculate the three color components and then set the
> > fields of the blinkm_data structure accordingly.
> 
> It needs to be either single multicolor LED or three separate
> LEDs. But not both at the same time.
> 

Thank you for the feedback! How would you suggest I go about handling
this? Is there a preferred way to ask the user which way they want to
control the LED (Kconfig?), or should I remove the code for three
separate LEDs entirely? Originally, I didn't delete the code because I
thought it would be bad to remove the existing interface.

Joe Strauss
