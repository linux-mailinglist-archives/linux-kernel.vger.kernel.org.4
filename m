Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162B9628D30
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiKNXJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbiKNXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:09:40 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5326CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:08:30 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id l2so11485520pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CisNQEoZieHBjHrIOAEKT6bP8SOhHtD3MgeZveaDbsM=;
        b=XViVBFm4z6epk3o4pHV8XrOzPHzY3Ni+wN2DxOy8w8eOkxgfNUqKFaTYf6Xa+5H3vd
         tLJIoirtxKZfX+6dgRcRtQU0QFK9MDn5eMwHd40Jz/UIHSBTGAkPFPAzNuynVrrPdHyV
         QmUXaeJK5HCuAig7wigPLW1O7Ndu3a7SMxTiZrquTv5NJCbb+MWbLWrR0Z6hR7s0u9Ea
         ySkGTJkZh9SHs8+40vaGUerd342xEaLleZE7kxO9UJzMv4trEsIJQxUmTMamMuY9bICS
         08h2EqoF+fxnO36n7/YCBq2bp8R/rGb02wdVCwVEgl6/2ipVOGd4Emq2R1wjZ6B7xO1h
         ULew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CisNQEoZieHBjHrIOAEKT6bP8SOhHtD3MgeZveaDbsM=;
        b=oyHlaZesuz6tBVWKq/EqkhEW7PAz0rR8y1xqaE0Ck2Pncdi8cHjVyhRnLn6Xmw+m8x
         VCXKPiLGPqd47fM1JEsnI+QymTm+tThwh9kjb1mamP2VoQx+ew9gmdAKInun2k1ved0v
         cx4GZBLxYnQa9N4S4mOPurINVUIZoRMtmkNq1cQPqZhHKoHfPI400x8fsplwdI0lOh+n
         itvJNbch1TBEIvRk76x16VtQ1A9d86xO7BTxYQsiALKowZ/8vOprBnLoMe1g4hT5Ume/
         1QcBEVrRWhbJFR50xZPXbRu5fBzyRQXj8vWV+DqxjFrqujonjxUEukW/BNjcbEBPKqc9
         AwgQ==
X-Gm-Message-State: ANoB5pll2lMEQJOgoLVoCVKhoII+NQyRcrAAbPd3wXstvm199aZF/zV4
        aquaWIZESzn3yCSQ0T71Jub5rxKnoPI=
X-Google-Smtp-Source: AA0mqf7krqPWFiLieSSGV06bgmxON2Lj6yIyT2W3WBz0xN9NBRgsXaAv7Y/6RDW5t2O+Z4CT6sH+Rg==
X-Received: by 2002:a17:902:f790:b0:186:6180:fb89 with SMTP id q16-20020a170902f79000b001866180fb89mr1232864pln.142.1668467310198;
        Mon, 14 Nov 2022 15:08:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a394900b0021282014066sm10339647pjf.9.2022.11.14.15.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:08:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Nov 2022 15:08:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.1-rc5
Message-ID: <20221114230828.GA2089561@roeck-us.net>
References: <CAHk-=wicGu7PD25w7BCdvxRcs6Yvo-BPwCkzSYjM2CYtDjz2kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicGu7PD25w7BCdvxRcs6Yvo-BPwCkzSYjM2CYtDjz2kg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 01:29:20PM -0800, Linus Torvalds wrote:
> Another week, another rc.
> 
> Did things calm down and shrink this week? No. We've got about as many
> commits in rc5 as we had in rc4. It's not outrageously big, but it's
> certainly on the bigger side for this timeframe.
> 
> Am I getting worried? Not yet. There's nothing particularly worrisome
> in here, and the rc5 changes are just a little bit of everything, so
> I'm hoping it's just that it's one of those timing things and all the
> pull requests came in this week, and it's going to calm down now.
> 
> But we'll see. If things don't start calming down, this may be one of
> those releases that need an extra week. It wasn't a particularly big
> merge window, but I don't particularly like how the rc's keep being on
> the bigger side.
> 
> Anyway, lots of small fixes, fairly spread out (the diffstat looks
> fairly flat apart from some maple tree tests moving to the testing
> subdirectory). Nothing really stands out, the stats all look normal
> apart from the "just slightly more than usual". Drivers, networking,
> architecture fixes, with some smattering of noise elsewhere.
> 

Nothing to report from my side.

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 500 pass: 500 fail: 0

Guenter
