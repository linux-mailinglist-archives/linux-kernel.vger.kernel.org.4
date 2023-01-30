Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4D768197A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbjA3SjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbjA3SjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:39:03 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153A746168
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:38:20 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso4772908oti.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jk1lMepgcQGGMLsbjZH3h4S+jgcPWnimmWRr2wOwvxU=;
        b=XqLGhUxxLjABBXhFKsE415q5f1AyU59dsM05iAi2i1AiLOFVLEr9cIgCMKXTyT/jYf
         69LtT/4TJ9XWIP940WWQK6qSWfhZSTtQUIgaArmocpz7q54yglYH+44cqlqaDBHX7Okw
         b8XqZ+2OaWW78AF2LKLaRTl6SyxuQuvFvXDH+6pOI3M9H79Os7z1lhSxrhudVKHyKcLb
         OPQg2HRR5PTG8Xd/G2I3YhKirVNujO3CWsccvlIh3bOWsnZaQOiBiepmUyGkBTDoYJrs
         lOPAlVssLPcuf/i/onvaMP4BVO0I6zcE584I3pBiqWtmfKl9L7w4UT8BlNpm450JAxg5
         vShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jk1lMepgcQGGMLsbjZH3h4S+jgcPWnimmWRr2wOwvxU=;
        b=EVsfwNgiGU180nwlTVzEsklBB9UhZ6mqisHxuM2dwf0nBnVTTCXgZOtQKdR8jAM7Lj
         D8obbtzBkei5DImzJqQ+J3A0Qz7URbZWLzCwXmnqNB1oqKNdixmoEnuF8PbyKOfu+UpX
         ndZqnF1IW2uxuDWhsn0bHXaJ89Rf4vNhz0fv8sfQ+YBLdGrWr0WCoh0f2rvay53Y72IL
         J4VmM1DRLkH3gfy69pHDhPvWxZNlCRZTpKq10QgGFstUY5wmLtcNKyXWHPAio1yhGGCo
         G+NapUr81iOeLWC30DRG1MEhmjMckekjc/toKnbt1NhBzcQ7wJpUFrMYEdYbucOR0Uew
         Ho7Q==
X-Gm-Message-State: AO0yUKU3+fV3Iuq6mekVyajngfKMpAnqCOwjGpd6OuSDbp7tMaJGx09/
        xTtP0KbwBsCMf8MBDqmeGBCojQ7oWGg=
X-Google-Smtp-Source: AK7set8vzr1uffqNw+bo06wRwipNoABlt6BCUPYiWLWpfX06ZwaeGZ4qOH0GIMP6pQbX+WBFUgZdjA==
X-Received: by 2002:a9d:3e5c:0:b0:68b:d610:e50d with SMTP id h28-20020a9d3e5c000000b0068bd610e50dmr1471066otg.18.1675103899360;
        Mon, 30 Jan 2023 10:38:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d6047000000b006705829996fsm5613618otj.56.2023.01.30.10.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:38:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 30 Jan 2023 10:38:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc6
Message-ID: <20230130183817.GA2819551@roeck-us.net>
References: <CAHk-=wiJcsgmgjEitJ97x3unFpaKv1d=YyNr_5NbOTGsGqCG=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJcsgmgjEitJ97x3unFpaKv1d=YyNr_5NbOTGsGqCG=A@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 02:19:50PM -0800, Linus Torvalds wrote:
> Here we are, one week later, and rc6 is out.
> 
> It's suspiciously small, but who am I to look a gift horse in the
> mouth? I'll take it and hope it's not an aberration, but instead a
> sign that 6.2 is shaping up nicely. Call me optimistic, call me naive,
> but let's enjoy it and hope the trend continues.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 504 pass: 504 fail: 0

Guenter
