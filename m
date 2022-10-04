Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B835F4552
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJDOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJDOVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:21:04 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960A32DB0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:21:00 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id s9so8417239qkg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=sksSxmDzq+l5y2JyJDEQ4qcmFgIzRvNW674+EJVW7qU=;
        b=PxsQTV/IZTBcLJ4l4PRfGFGh7qibteRj70rhqlb2CHUdrRUdxIruJ/emzYCIL85n/0
         22gXZZPQ1vVMf2UzqX/xxESSDyJsOrs0EMYjLV9ERZiR9ea67b7hBLyFwFxX0xbTo0qu
         SPC4I6QYiL1KbL/KPYavrkxB1JamkVpwg+i20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=sksSxmDzq+l5y2JyJDEQ4qcmFgIzRvNW674+EJVW7qU=;
        b=h3NqCdYT6h9Wx5hAOOV2LTfVUNFmoqhgjHJyng8nBl+ggpeRqOIg+u2w/z8jR8H2Td
         /CwnxzMRnHWNV2uMC5mh1FTuDKBw5NX21mg5/calNS+nYwv3fSnESDdd4oz+KdAXyGK8
         po/urbPXCiC+yxZGHygnKmfEdBskFD6wDbMG0TmLGNdsH9Jo9j2551hb6WFv3Ay8+aZS
         5GC0YAflO6ML8dp2sXbpV8SNwv/xOPfKCJdk7QzxKr162uENEE7T7Zojme/qYgGTki/G
         YuWVOBF7TxkvAiU3iA4dPM1kmM78BjehaspMCeqexmLfCXc/8uMq+oYZ4HU4r//N1sM1
         yaCg==
X-Gm-Message-State: ACrzQf2rKTU36oEkqzp9kVP9gqVvpj/cP6jgIarECS+IuuLittKRa4Lq
        ycyJsTJ+rMs+FUt249JFXDiXLg==
X-Google-Smtp-Source: AMsMyM7fDhRaZSiO5q1BcaM4NzJ0ug0AjTwXSbG5zLt6H4mLje1qIIWYTGEGSFL/vgmRMh/Z0PQsPQ==
X-Received: by 2002:ae9:e114:0:b0:6ce:33c9:5cc2 with SMTP id g20-20020ae9e114000000b006ce33c95cc2mr16369225qkm.388.1664893259526;
        Tue, 04 Oct 2022 07:20:59 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id h16-20020ac85690000000b0035bb8168daesm12287282qta.57.2022.10.04.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:20:59 -0700 (PDT)
Date:   Tue, 4 Oct 2022 10:20:57 -0400
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
Message-ID: <20221004142057.aornje2s5fxe7vac@meerkat.local>
References: <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com>
 <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com>
 <YzqjfU66alRlGk5y@kernel.org>
 <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
 <20221003142240.hu5gj7fms5wdoujk@meerkat.local>
 <80457c88-7344-e362-9873-8460f0b75c19@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80457c88-7344-e362-9873-8460f0b75c19@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 12:21:32PM +0000, Artem S. Tashkinov wrote:
> > It can't, actually. It only works with MySQL 5.7 or an equally ancient MariaDB.
> > No, there is no official fix (because nobody is working on bugzilla).
> > https://bugzilla.mozilla.org/show_bug.cgi?id=1592129
> > 
> 
> What do you think about Bugzilla Harmony? Works with MariaDB:
> 
> https://github.com/bugzilla/harmony
> 
> A continuation of Bugzilla.

It doesn't look like there's enough momentum behind it, at last at this time.
We do have a plan in place to avoid the MySQL problem by moving our DB to
Postgres, so the software side of things isn't something we need to focus on
fixing at this time.

-K
