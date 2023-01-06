Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D3D660369
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjAFPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjAFPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:38:10 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF41C745A5;
        Fri,  6 Jan 2023 07:38:08 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-482363a1232so27541097b3.3;
        Fri, 06 Jan 2023 07:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+ZK+xldlBv3g2AO74GvzA01lQCjrDMywdlfRiZz/Z0=;
        b=U0ennM0rkwb/XaDc2ipEFra/aR+/f1YR6uRKcywa23iAUMqmuhTad2DQ9Q95zGLfK9
         WVXiJb1+oylczNCnzn8WNm7GJ8OvslR7coxntuO1wYNlXVEJEnBd/I4V4zbSFPqF4zyJ
         VyqE6q6US/7YlCYhPep9B/R27Bsg7rVX+KcSd2KgNj7TWZZ5eo7ninS+BzBKe03UDJ8k
         FpQyo32R6BWYHj+Lqh66b44u+regFgKk1xfqcsg8OK0bm96eH+GClWXKcyryAXGGJc+0
         vvUJe7cfQ+2r1v+7ObGG1WJTG/37MC8lxR1ZHB4dQNwZO8fjF3zUoQKkTu+C0aVsmVRo
         sLYQ==
X-Gm-Message-State: AFqh2kp9LeLbOIldReU9Y/YHdSaYrFLgqqMsEokFjvt/l/hckW5+W47j
        F8edSSVB5aa9dFqgsVHCKvf++NF+6hgT2A==
X-Google-Smtp-Source: AMrXdXtYMhaEy1/bh9OyVeJQX45xZqIrrBhqi0jQJUd8Kx4Ycug8zdLASvql8m6sGHUoCuGjHiRRLw==
X-Received: by 2002:a05:690c:98b:b0:3c0:405a:bdb2 with SMTP id ce11-20020a05690c098b00b003c0405abdb2mr2550712ywb.51.1673019487673;
        Fri, 06 Jan 2023 07:38:07 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id u8-20020a37ab08000000b00702311aea78sm662869qke.82.2023.01.06.07.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 07:38:07 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 16so2304816ybc.0;
        Fri, 06 Jan 2023 07:38:07 -0800 (PST)
X-Received: by 2002:a25:8182:0:b0:75a:6c58:ac5d with SMTP id
 p2-20020a258182000000b0075a6c58ac5dmr6429676ybk.91.1673019486809; Fri, 06 Jan
 2023 07:38:06 -0800 (PST)
MIME-Version: 1.0
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
 <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
 <CAMfi-DTwX2nvP58FRb6NaGMyWO0SBo9W=Fpdtr=XfNRzkqAwHw@mail.gmail.com> <b5e9c8911a46802ddb017554f266c92a7a0b2605.camel@intel.com>
In-Reply-To: <b5e9c8911a46802ddb017554f266c92a7a0b2605.camel@intel.com>
From:   Dave Chiluk <chiluk@ubuntu.com>
Date:   Fri, 6 Jan 2023 09:37:55 -0600
X-Gmail-Original-Message-ID: <CAMfi-DQYU3WQk8x-GFieexEE_enRDe4J0AzyZHk9rtRykpUEnA@mail.gmail.com>
Message-ID: <CAMfi-DQYU3WQk8x-GFieexEE_enRDe4J0AzyZHk9rtRykpUEnA@mail.gmail.com>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 12:15 AM Greenman, Gregory
<gregory.greenman@intel.com> wrote:
>
> I'll try to explain, the problem here is not technical. After some
> internal checks, it appears that we (wifi driver) aren't allowed to
> decide if 6E should be enabled or not. Because of the legal restrictions,
> OEM should make this decision and enable/disable 6E in the BIOS. This
> commit only gets the value from the BIOS and configures the firmware
> accordingly. So, unfortunately, legal restriction is the reason we cannot
> revert/overwrite 6E enablement...
>
Thank you Gregory, I've been reading between the lines, and this is
pretty much what I expected you to say.  So in the past when
OEMs/systems manufacturers have been irresponsible/inept like this we
have implemented flags to force ignore the values coming out of the
bios.  As it's now obvious that the problem here is a legal/regulatory
issue, I'd hope that having a force flag would be acceptable from a
that perspective.  I'm no lawyer, but I expect once a user decides to
explicitly set a force flag to ignore the bios values I'd suspect the
responsibility would shift from the manufacturers and back onto the
user.

Would such a patch be theoretically acceptable?  If so I'll write up a
patch to do this and submit it next week hopefully.
