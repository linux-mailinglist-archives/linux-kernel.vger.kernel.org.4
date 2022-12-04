Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28671642023
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiLDWyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDWyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:54:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865BCE08C;
        Sun,  4 Dec 2022 14:54:16 -0800 (PST)
Received: from zn.tnic (p200300ea9733e72f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 037431EC0662;
        Sun,  4 Dec 2022 23:54:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670194454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BeMthFctUynP+ijWo+gAkXBXZmHN+zwjWM9OMuQz6L8=;
        b=S4knuQByGEDef200v/oyW8W2juDLoVZzB2lIhVcaHAb/7ETP8q7Lrl7KRjnobuB/xDzCsG
        RHn6UEeVvbOBtaxg9gJKUWDnzMkX13AeIuZO5uP8gJENLcA27RgRJKE1tBswb8GIZl3/Yt
        mw1PO4/cvHRTl8htIIx0XYWTB5qzhN4=
Date:   Sun, 4 Dec 2022 23:54:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-hwmon@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_SENSORS_OCC_P8_I2C
Message-ID: <Y40lEZwV4rEA/Fui@zn.tnic>
References: <Y4zfBRahZJ0QM758@zn.tnic>
 <1085cc7c-00af-83f3-7da6-7820143b162e@roeck-us.net>
 <Y4zxSEo4OhZUd2OU@zn.tnic>
 <8eadc1cb-3648-b0b8-0250-9b745bb8b71d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8eadc1cb-3648-b0b8-0250-9b745bb8b71d@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 01:32:50PM -0800, Guenter Roeck wrote:
> We are not typically that restrictive in the hwmon subsystem. That isn't done
> for many of the other drivers which are typically only used on x86 either.
> Why is that suddenly a problem ? Just don't enable it if you don't need it.

Yeah, ok, fair enough. I've switched my build script to use
olddefconfig.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
