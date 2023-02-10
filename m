Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF5692AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBJXCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBJXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:02:11 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7919430FA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:02:03 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h24so7762850qtr.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nxy6oaVvJpFGn4QobTdjEMd2Mp4o+TBw2jtDUOlFKu8=;
        b=Yn/aS/9/W+by0hMh/vUDMoofRWfuWl/oYiWHr7UMqVWVuBvNu4+h6Net/1xlnCBxup
         X6mJoMtRT1wbBV9GZt018WP78DM8rl78wAZmy8u1cXJdjhmlcl0lEPqdxJ0eFBjrM7MH
         TGfCYafO1kX/ZfaY31EQfFGi67MEcbwjReXpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxy6oaVvJpFGn4QobTdjEMd2Mp4o+TBw2jtDUOlFKu8=;
        b=Q6lMgCJJ/nLbJkeqvcg0Uhf4AsVVURJGmsoCtoMa4Qt7KdW7lW/f4FOZDYc1W+uQq0
         XIDor5tG9r9BJSYRhQ5DI8itP5uY6lnEJ+6hO/NX6EjxWAhjKzuPc1Nc5/t9BKJQbP3O
         2h3PKNxVjB8/Z//zuB00WdDcToPu30BrTMoAkHm1Pw0aWBAe5AuVhVDMuSR5m17TUurn
         RgDkKw18j0ajMMaBdkaZMsEtRb2FRoB3trxwQKXqhMOxj8+H7ZF84+LTk/0Lwg0tObJs
         KDOt/w791LIquMnqx7UzDNUYp7v52NWRiQpji6RV3FZh1cfxm6ZLj9LbGHJ5iSV+n2Y5
         D7Gw==
X-Gm-Message-State: AO0yUKV+dZ9aHZRy0cmPUUuhiUSXCoiZBs1c+hxDGCexvKWOz41hu+ob
        /b3FNiM6q4plLdvCXWWurPH9Olm77kMIyhjnwuQ=
X-Google-Smtp-Source: AK7set9wIzegqF6GJpscWy0InX0LwQix1er7eMILF4zgP/yeabs6kDd7jhLlPczpaQAz75RAKUmejA==
X-Received: by 2002:a05:622a:589:b0:3bb:7c6b:9cb5 with SMTP id c9-20020a05622a058900b003bb7c6b9cb5mr17478028qtb.27.1676070122608;
        Fri, 10 Feb 2023 15:02:02 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id c29-20020ac8009d000000b003afbf704c7csm4217364qtg.24.2023.02.10.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:02:02 -0800 (PST)
Date:   Fri, 10 Feb 2023 18:02:00 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20230210230200.gmf27ywrookqoy5k@meerkat.local>
References: <20221012191142.GA3109265@bhelgaas>
 <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
 <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
 <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
 <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
 <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:58:31AM +0100, Geert Uytterhoeven wrote:
> > > Thank you, I have triggered the export from Gmail. After I have received
> > > the export archive, I will merge it with my local pre-Gmail archives.
> >
> > I have just sent my merged archive for linux-um.lists.infradead.org
> > and the old user-mode-linux-devel.lists.sourceforge.net (starting
> > from 2003-09-02) to Konstantin.

Better late than never -- this is now done.

Sorry about the wait.

-K
