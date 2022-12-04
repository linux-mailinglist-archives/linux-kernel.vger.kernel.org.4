Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A38641F27
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 20:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiLDTNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 14:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiLDTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 14:13:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6AA274;
        Sun,  4 Dec 2022 11:13:18 -0800 (PST)
Received: from zn.tnic (p200300ea9733e799329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e799:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C21F1EC04FB;
        Sun,  4 Dec 2022 20:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670181197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vQ6hjyCN0l668BdqXmHKqQk8hdT2U3XsZ+uX42X2Vmc=;
        b=aboV3fCBIeE3kFZJs+zKelUlscHrKXq0iC+q8KNF5OborbcSiZUVspULo+mf5FHS4oX5bz
        a/Zp+juAAwtWwf2GoftmRypQGwHjrvJLFBYF9bQaHsmW6y1mXOtZAGIF3H6S4bO8fUXJqk
        KoANxRLN+vLYQdoCm4rbMMVXVZwOBjo=
Date:   Sun, 4 Dec 2022 20:13:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-hwmon@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_SENSORS_OCC_P8_I2C
Message-ID: <Y4zxSEo4OhZUd2OU@zn.tnic>
References: <Y4zfBRahZJ0QM758@zn.tnic>
 <1085cc7c-00af-83f3-7da6-7820143b162e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1085cc7c-00af-83f3-7da6-7820143b162e@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 10:37:09AM -0800, Guenter Roeck wrote:
> I don't immediately see why this should depend on a P8 configuration.
> The driver runs on a BMC, after all. My understanding is that a BMC can be
> of any architecture. Is there a guarantee that there are and never will be
> any x86 BMCs, and/or that BMCs are limited to a certain subset of
> architectures ?

Well, then it should depend on the architectures which are currently
running BMCs for P8 machines. ARM maybe?

At least on x86 the majority of BMCs are ARM-based AFAIK.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
