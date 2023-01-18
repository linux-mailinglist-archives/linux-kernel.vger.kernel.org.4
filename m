Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379B4672709
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjARSdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjARSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:33:03 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D8658971
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:33:02 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 12so5884069vkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=79B2mrM6u98RtgwVRK2YijfD555WnZ5B39rU02m7674=;
        b=g5B7qyrUaNc6oolT5docVghEpixtXxxQmEGVFsP5Y5bDqTjWVJCjUyZRX4dbXP76/C
         5N/GBgQKjP/DtjBsuc2j974xWnwW9I45go5sewvORaC78STOhyX2AasSSIPiF2bavsNS
         Qo3lnC5xxZLps4e5RJ8pf/WwRNOrCvGDkZYvyH6r74OF1dZ+KIz2VB3jsBFaUl5LPx7T
         i49elfR+8eRBYIvsxt8VULh6ovHY1X0h5VWZNfXMfbp9fLHPq8MX+Hu++2CmPYHRmJuk
         tBf2XSw70mG7UaHkT50n2vbpDbiLWH0RgpW9sV53TtOEYlTjjI/+hjmXvJyJlptOWqyr
         kCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79B2mrM6u98RtgwVRK2YijfD555WnZ5B39rU02m7674=;
        b=HU2vwOXQgfztFl4MVKGUb++scCJFzf0h0qAeekmKWAIeL6udVw/KGpUvoXO8Z3/O32
         1tFGbYsx/pjXm3aql8y8gySA7Vpjv7CnYhheKZTgnbT/LowFzRXBndYTzQKL6dlhyFm5
         Nsp+6tNypRnTmY8zq3znI/ro/1XsE4IM6ceTz9mc0MAfxs/9/2CfPbDO22q/hHYqB9h9
         VW6IYo4zIEF3DvEpLvbmZUHH9Fkw62bW2Hnol2vEBtmRsO0gzI7d+i19VXtc/WlUx5oZ
         R+v36aB9BC/K/dHvdsVb2eNKmMgQlcnkQMQOw48MwagG5sejlIqwOx7FNlqVDjjF27+m
         7z+g==
X-Gm-Message-State: AFqh2krrvIWj+rVenshmTO2PFX6kMCDuRY/mHd75s6uClvdgZE4GaNXz
        QjL617gphImkhl1XW9nLDdsVh0DP+sDLtWY6I3b9c9eGaVyevQ==
X-Google-Smtp-Source: AMrXdXulXPk/v5TNnovUqrx8h4pMJTAOQuYyjn7YpigNfB8lvbsUI8BI2RXnI8ByaCCOSUXwLRZIIy5y+4HTM87Gtec=
X-Received: by 2002:a1f:9b4d:0:b0:3e1:722f:9a6f with SMTP id
 d74-20020a1f9b4d000000b003e1722f9a6fmr1086514vke.1.1674066781258; Wed, 18 Jan
 2023 10:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20221214220727.1350784-3-jcormier@criticallink.com>
 <20230109233534.1932370-1-jcormier@criticallink.com> <20230109233534.1932370-4-jcormier@criticallink.com>
 <d49d4b4c-e7ee-e0a1-56e6-7f193e0d1340@roeck-us.net> <CADL8D3YEkZaOjUY3mRLGT0M+b7MwN5zQZrbsw5W8Mn=PJ7PtcA@mail.gmail.com>
 <dd80ee77-3b71-ee47-2744-36b09e0ec372@roeck-us.net> <CADL8D3YksXnRkEgXkY86KZXM4nouJBemno=db5KgbCi3xmSa8Q@mail.gmail.com>
 <20230112004413.GD1991532@roeck-us.net>
In-Reply-To: <20230112004413.GD1991532@roeck-us.net>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Wed, 18 Jan 2023 13:32:50 -0500
Message-ID: <CADL8D3af+HTAbOwFKhv7h6hgwTaL=9dQDK8bv8Nkc8zuYEY+ug@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] hwmon: ltc2945: Handle error case in ltc2945_value_store
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Dan Vincelette <dvincelette@criticallink.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, I'll take another pass at it.

On Wed, Jan 11, 2023 at 7:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Jan 10, 2023 at 02:25:37PM -0500, Jon Cormier wrote:
> > On Tue, Jan 10, 2023 at 1:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On 1/10/23 10:19, Jon Cormier wrote:
> > > > On Mon, Jan 9, 2023 at 7:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >>
> > > >> On 1/9/23 15:35, Jonathan Cormier wrote:
> > > >>> ltc2945_val_to_reg errors were not being handled
> > > >>> which would have resulted in register being set to
> > > >>> 0 (clamped) instead of being left alone.
> > > >>>
> > > >>> Change reg_to_val and val_to_reg to return values
> > > >>> via parameters to make it more obvious when an
> > > >>> error case isn't handled. Also to allow
> > > >>> the regval type to be the correct sign in prep for
> > > >>> next commits.
> > > >>>
> > > >>
> > > >> Sorry, I don't see that as reason or argument for such invasive changes.
> > > >> As far as I can see, a two-liner to check the return value of val_to_reg()
> > > >> should have been sufficient. Most of the rest, such as splitting
> > > >> the return value into two elements, is POV and just adds additional code
> > > >> and complexity for zero gain.
> > > > I can do that. However, you had also mentioned changing the return
> > > > type to match what the calling function was expecting, an unsigned
> > > > long. But I can't do that since error codes are negative so it would
> > > > be a signed long which would lose precision and seemingly defeat the
> > > > point of matching the variable type the caller wants.  I could make it
> > > > a signed long long but that still doesn't match.  So it seemed saner
> > > > to just return the error and the value separately, that way the
> > > > function declaration was explicit about the types it wanted/returned,
> > > > and less room for error.  Would love to know your preferred solution.
> > > >
> > >
> > > That is only true if the upper bit is actually ever set in that signed long.
> > > Which means I'll have to verify if "would lose precision" is actually
> > > a correct statement.
> > I'd like to argue that is another reason to go with this change
> > instead of working out the math of just how many bits are needed in
> > the worst case and having to document it. And potentially getting that
> > calculation wrong.  But I can if you'd like me to.
>
> You are turning things on its head. We don't make changes like that
> because of maybe. It is you who has to show that the change is
> necessary, and that there is indeed a loss of precision otherwise.
>
> Guenter



-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
