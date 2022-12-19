Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E0650A40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiLSKjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiLSKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:38:41 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90469DFE9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:38:23 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3b10392c064so122024357b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urVzOJiFjaExbOR7eyWhTrdxzeojntlGIqnKowQq5Kg=;
        b=ZLI9/UeHQDli7p54x6EtjDq96G8SbqWr3tBDLs6ZdeUZ0mmXgln65KIu2N7aFwrE/6
         RUqKWwNTnb+PiO84Ic4AFRJVhaymvdJFGsFELInUR9v7LWeo1MV3OG13wp2XuOeX9NEc
         QEIeXvC/x0b7htbdxohICNRuyl79DMFBCPKaSBTtHCg/pVpRvjOiL1WYGpzVvvhCIUcD
         TKVkEAOP+wK8ovm/GYb0G5oTAu0x52wZRnV9TKwFnKPVgfWaMJYyqzdXFJtb9NuNAaV2
         x6ALmJ9GIuws3vUJ0ODtmmqKeXXyXCvGxuvoG+dJ6EyUp3ZjdIc2kD0On587XtRWfBn5
         a0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urVzOJiFjaExbOR7eyWhTrdxzeojntlGIqnKowQq5Kg=;
        b=Z9dvo5moajOK4lNXxSDCu7IulJ1WRXBMEY1ZVykmMUpGMf1czRCCaX10bDc27sHVnv
         8wEgh5Cbj92MnXpD5yrbPiNeiiqXqIb4ETVcAMRZGQRnxY3byDX7vnYXzeS7KolecmHF
         9fZLzeSiXhPzIIIPWWJCRG0ON2Jxw6FERs+5cw74qeLp/IxhgvDyVcaSteG5vyJvyd8q
         w/NrODkSjvf157mFfOHm4LCnHxGFEdw+EUJdHOXu3YiWmtAqtSJz42PA/+lDr3een8fU
         9Oxv5BIaMK2eYNqpbARnGyPkirBTAuydeyZWStFV0TbaVnkArwS3fy7KUlzlsuIRSPut
         crrw==
X-Gm-Message-State: AFqh2kpM3uF/UTzYJEGRTP6gGDTigRbToCdSB053Rc+icG/5M3SNe32Z
        GIjirrZFmoP3ITlu0Be1B6YhBm/9U6HuaLlRfXMFBuAW
X-Google-Smtp-Source: AMrXdXu70jsBvZ7bn0UPHmyMBjy5IQ1SxjOOXxtXfwsZtg1CojWAJPZI7agQBJ1v0vUo9tYKEciOeY7Ywk4dEMi/iGk=
X-Received: by 2002:a81:5207:0:b0:44f:24df:7008 with SMTP id
 g7-20020a815207000000b0044f24df7008mr199511ywb.401.1671446302606; Mon, 19 Dec
 2022 02:38:22 -0800 (PST)
MIME-Version: 1.0
References: <CAKXUXMxpWOXCUY-dd02P4ckAhF211VJtPTFeTriCMozZon7A5w@mail.gmail.com>
 <df35a27cca8444b884e35b1b9387beb2@dh-electronics.com>
In-Reply-To: <df35a27cca8444b884e35b1b9387beb2@dh-electronics.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 19 Dec 2022 11:38:19 +0100
Message-ID: <CAKXUXMwZyEzZxM8zT8z1mHkLnNCBd=VxcxCPn=0QE-Gn-iU0aA@mail.gmail.com>
Subject: Re: No matching files for file entry added in MAINTAINERS
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>
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

On Fri, Dec 16, 2022 at 11:54 PM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> From: Lukas Bulwahn [mailto:lukas.bulwahn@gmail.com]
> Sent: Friday, December 16, 2022 11:02 AM
> >
> > Dear Christoph,
> >
> > with commit 894799e1f496 ("MAINTAINERS: Add DHCOR to the DH electronic
> > i.MX6 board support"), originating from
> > https://lore.kernel.org/lkml/20221117105131.7059-1-cniedermaier@dh-electronics.com/,
> > you have added a file entry to DH ELECTRONICS IMX6 DHCOM/DHCOR BOARD
> > SUPPORT, but there is no file matching this entry in the repository.
> >
> > Are there still files to come or should this pattern actually match
> > certain files in the repository, but they are named slightly
> > different?
> >
> >
>
> At least one DHCOR file should come soon hopefully:
> https://lore.kernel.org/linux-arm-kernel/20221123173601.13291-2-cniedermaier@dh-electronics.com/
>

Thanks for the pointer, Christoph. I probably just missed that, as I
checked on November 22th (when it hit linux-next), put reporting it on
my todo list, and I did not re-check for pending patches afterwards
when sending out the report on Friday. Let us just wait until the
pending patches land and then the reported issue is resolved.


Best regards,

Lukas
