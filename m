Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42837690F1C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBIRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBIRZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:25:34 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5876C31E33;
        Thu,  9 Feb 2023 09:25:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m10so2887915ljp.3;
        Thu, 09 Feb 2023 09:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbJO3Maf1JEAHMG56uNfordoM7VG9n3IPMLycBD2LwQ=;
        b=EEFR4nEyrlDLk84iKjsPmg9xzEPX85+RmHFwud0wKmPArj52xfRy/HxzBwwuaTt1Ht
         2HK/nuyMcyx0pOscg7pCqCuwzED6M9RUT3vBf6jan3YmyPdHIUBGMpSs7mcCWOTDm6vo
         4RcMjVF3DLD+vGvBj7cSgdRD1BBPniwoU5OWIUAvoZPVf1TCZDzryPjTrfpAHSMrgQ+H
         OXp0Ogm3bLtLmoQHn2FFvG8v8jvsd8GYRu+2q/NZb8Q7aZGggWCf3iqmR2go2cncqJFa
         Pa9++29SwbmKmEUDyrFo82KVIrHwRP130M4mblgkfjEp7GnjK6giKraVNBW5a16qbCFl
         ZDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbJO3Maf1JEAHMG56uNfordoM7VG9n3IPMLycBD2LwQ=;
        b=iw/EuhaTxRsbtx7B3FrfmzDaaqKLnKK/YGRZi5WFhl1Z1PeFT1vcNTf6/nKnl/Hs/N
         C3pvR3UXMYBO5MB8q2YlbAPTbRTJpXILJJbLU2YZT/urXlQHofr0dguVM+2PX7K4GFew
         paYZ0y36EFoFZXWzvPWQHogkLVWr9D/Zc9BZtuu8AtCOqS9uvqZUgDV6SniIdZME7TgS
         4fhUTdUv/97sWXtq0Hc/N8Y8oJPZ64/D+/Seh+v8FhiD5TXYKwkul+Apjlip/0yX7cdP
         UTjek7z1tlNBbZy9A1y7O9YHomra3ZmszvQyYySc+HaINcpBBOPYWkjxw9gg2Axo0Tci
         69wg==
X-Gm-Message-State: AO0yUKURAHHSebaEPbTTxVlr/HoHZgdSq+FC+0ic2yClnoBkScnrlsjd
        XzqUVseywNiyICo0PJC5TNozFg5vgYFv6GOE9ZNk3070
X-Google-Smtp-Source: AK7set9JRW+ahSw8FbU2acXz65vf+JYqV+gTsgESlqSEvOyOPu2yD/9rafRAdcJlp61H+BxHGxYwE7cCBcCLJ+NR5Qc=
X-Received: by 2002:a2e:88d1:0:b0:293:2d3b:9790 with SMTP id
 a17-20020a2e88d1000000b002932d3b9790mr746129ljk.140.1675963528441; Thu, 09
 Feb 2023 09:25:28 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mut-6o5Jy7Kb8ZmjyRDikAi7iueqNStX1JLdixrFmJPZQ@mail.gmail.com>
 <CAHk-=wiyY4ahLjKfvVho0CiCj-Nv0P3Edxqfu4bH4TcsZmsBJw@mail.gmail.com>
In-Reply-To: <CAHk-=wiyY4ahLjKfvVho0CiCj-Nv0P3Edxqfu4bH4TcsZmsBJw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 9 Feb 2023 11:25:16 -0600
Message-ID: <CAH2r5muTXCME1s8=HPrNHnZbNAQkFn9gjwCnF7a==nETU80kdw@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry - cut and paste error

On Thu, Feb 9, 2023 at 11:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Feb 8, 2023 at 8:44 PM Steve French <smfrench@gmail.com> wrote:
> >
> >   git://git.samba.org/sfrench/cifs-2.6.git tags/6.2-rc8-smb3-client-fix
>
> Hmm. Malformed git pull request with no shortlog or diffstat?
>
> I've pulled it, because I can see the SHA1 matching, and it is indeed
> a "small fix for use after free in readpages", but I really do want to
> see proper pull requests...
>
>             Linus



-- 
Thanks,

Steve
