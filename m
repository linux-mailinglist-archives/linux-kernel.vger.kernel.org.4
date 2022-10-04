Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEB55F4A49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJDUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJDUZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:25:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562896BCCC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:25:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x18so9086844qkn.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DGvJV2IIUZV7S3zU1Gd//TygTt/OG32AqXy+s65/XH0=;
        b=CQ6jzxz7pGsi/7Unxn/3myaDbDXR9ldixRssga58u32qNXAC6JjOpSI/qeMcu/HIUX
         EFZKLfcJkGHxiZasUc+40u8aAkxk+iPZVw4KCaeyTry2PMcmjVKojL9rrmRNk8Lg44fu
         YRxoeUmyTDJiq+KqrgkkWv23G0AOM3RM/FsI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DGvJV2IIUZV7S3zU1Gd//TygTt/OG32AqXy+s65/XH0=;
        b=vWvrMMGYnRkUEq+72+TPPXKi8wfccxzmjvE1/kXKjMKVH8LT+anjjdiV9eIKtpLRDL
         6zFfQ7OFBg+XT2f2BdxEcqz/ypP6el2cro/oAikdXCAtMwpdO8RDcQ3IyeZej7wC4qU+
         T/CCaBg+lQdU0/G4UvMzp1gDb6BkSouFuQ8lQusIUWAiJJhr5UGd4kpNwg2pMYumqYW/
         ynjnrIdSFTelpB4DpzbwZS9J588iDhI/McE7WZpEjYlLiJMmaM4DnMmWbZsF+GgyEVTF
         ySU1uzlC4HBjioM1WpA7Y40v62N1jQcWK4IVsB7h+gIxEkhYuF6pS3izKQ4ySfRrMs6u
         t4Fw==
X-Gm-Message-State: ACrzQf1TiFhdeovOLxvCTOqABI2NrhYi+9DGmVq4s4piORiVlGA9h7xl
        2oG42iSU0Uw3xOoGt/37KGNYuA==
X-Google-Smtp-Source: AMsMyM5g235+vx6KmW0J4fCOEYlimbuJcIi/EoLRom6zkxz2Hs63d2hk+LFSJ/eSNDEQQfP6UjUKNQ==
X-Received: by 2002:a05:620a:12f5:b0:6ce:742c:b0d0 with SMTP id f21-20020a05620a12f500b006ce742cb0d0mr17910376qkl.19.1664915142362;
        Tue, 04 Oct 2022 13:25:42 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b006ce7bb8518bsm15160606qkb.5.2022.10.04.13.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 13:25:42 -0700 (PDT)
Date:   Tue, 4 Oct 2022 16:25:40 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>,
        ksummit <ksummit@lists.linux.dev>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221004202540.etokkm3jk6sk7z7y@meerkat.local>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
 <c74d9d75-4428-e22d-1adb-334b1173d871@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c74d9d75-4428-e22d-1adb-334b1173d871@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:06:28PM +0200, Thorsten Leemhuis wrote:
> Your plan would afaics mean that we invest further into a software
> abandoned by its upstream and already becoming more and more of a
> maintenance burden. That investment would also further increase our
> dependency on that software by establishing workflows that rely on it.
> Is that really wise at this point? Wouldn't it be better to spend that
> time and effort to build something better that is more future proof?

Unfortunately, there's no such thing. ;) And maybe we'll even help tip the
course of history into the other direction -- Red Hat uses bugzilla, and so
does OpenSuse, so there's a pretty good core of well-funded companies that
would be in a position to help keep bugzilla going if it's looking like the
platform is still alive. Or that could all be wishful thinking and they'll all
migrate to Jira or something equally horrible, who knows.

I'm hoping that by keeping the bulk of this exchange relying on established
decentralized end-to-end messaging, we won't be painting ourselves into the
corner quite as much as with a tool that requires all interaction to happen
strictly via the web interface.

The alternative is to hire the folks behind patchwork to write "bugwork".

-K
