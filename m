Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7225F31E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJCOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJCOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:22:46 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5482D48E8D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 07:22:44 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id mx8so579897qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1mNtnrUJyTQxjM/H58kPO2FBj8ctREemEmZLeJQjiiA=;
        b=HHOvlrEsLsjIt8pkWJIJaNi/7w9fH7/+USdEgJk/pasP39/PqJRX9gJNl+6RLSmCMf
         GVyofV26jlyTxOmuA6eiwfdzwft095SM77pgF3xPOqSYIty+eZ6BqJxbjuVad1yp9Zty
         Plox52neU37WQikTvfXrSDCcANY2b6vl+JjSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1mNtnrUJyTQxjM/H58kPO2FBj8ctREemEmZLeJQjiiA=;
        b=Qox0A5m3KGDCtpNPut7p0n7jfKcPadxnmB9BLi5cckUWQdAd5wSejXsG+/qU1t77NC
         ssZeDWeSQz1D6Ym0Da8YR1prD2VQZwkt7ESxEWU6e2MwVUvWH+TRh7AZv4njvkroM+Oq
         45o+9BrDGL2k+ctCpeHMtFSAR2PxMuEof/69Ov15ZoENxQWyl0m6PT/orh+iVHbHZCL8
         +TeySPsBJbTKIKwb5W1TxGJGP20FQooawKogyygJ/s7/phAbF5KuZ1wskbAUgH2xIGi+
         iW4hx2ziN5hf1jNRSPuGmaBN/zY9Y5cpWDI2pfc3TSBRIpuW5gOl/q05fZY9GjTHIpLt
         nOLg==
X-Gm-Message-State: ACrzQf2bFyb1VJh19dcAsIGBnAmA8srRUccM36Zwjjs9hJme7fG5Kc4w
        f+qVD2DJiXhHyBT/CGio8G+Evw==
X-Google-Smtp-Source: AMsMyM40Bz2C89dANTyCDKluBnuuyuFRbPI6+PRG0AjqrNrChvyQCbzmIZu+Hwe3O2nDYy3wQo9z+Q==
X-Received: by 2002:a05:6214:d08:b0:4b1:7127:f615 with SMTP id 8-20020a0562140d0800b004b17127f615mr10560443qvh.92.1664806963423;
        Mon, 03 Oct 2022 07:22:43 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id p3-20020a05622a00c300b0035d0a021dcasm10246739qtw.63.2022.10.03.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 07:22:42 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:22:40 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221003142240.hu5gj7fms5wdoujk@meerkat.local>
References: <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
 <YzqjfU66alRlGk5y@kernel.org>
 <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:16:06AM +0000, Artem S. Tashkinov wrote:
> The initial conversation started with the fact that Bugzilla is old,
> semi-deprecated, requires MySQL [no idea what's bad about it, Bugzilla
> can work with MariaDB and Percona as well]

It can't, actually. It only works with MySQL 5.7 or an equally ancient MariaDB.
No, there is no official fix (because nobody is working on bugzilla).
https://bugzilla.mozilla.org/show_bug.cgi?id=1592129

-K
