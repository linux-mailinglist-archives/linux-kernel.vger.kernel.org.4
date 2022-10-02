Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAE5F253B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJBURw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 16:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJBURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 16:17:49 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEC138A0F;
        Sun,  2 Oct 2022 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664741851;
        bh=MrTrorDUfBo/z7u5/fPZ+r5xWIzR8HRHISJbfI/d9DM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=h3IxcPzMD4lOWBycWKy1jRTxdHsB2/+bghZZzoPw5OLcvg8rRLBYTDEyvZyKGrEZ9
         oznk/AzOo6RpzT93+4J+Hamj1/SYqGzPagAIOgkywsYU7PjwwqmfiJ4k/V9kpUP7+k
         dP8jLJq8BQCh8164X6wbuT54yDw1CTVF19kF1PIc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2O2W-1oeYEf2M3C-003vXx; Sun, 02
 Oct 2022 22:17:31 +0200
Message-ID: <9d0b30a7-a8d4-2308-a833-313c30aadfdb@gmx.com>
Date:   Sun, 2 Oct 2022 20:17:29 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com> <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <CAMuHMdVxUgyU97EK3S5Xx_vsbTv-cNO1wC9kDwsWEDx+6w9phw@mail.gmail.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <CAMuHMdVxUgyU97EK3S5Xx_vsbTv-cNO1wC9kDwsWEDx+6w9phw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xnUxEgu1NheUqNGBsnjiVoHSIWqADBqkWW/4RXF6oL2LamuYaWr
 iol9xZFaa/6zIVcILtx2pTXoKQhrNMBw7MvkiwWmtFxUm9ycY/V5y5Jp80zM8UWjf6h3vSs
 zs2kGuULZBQOoFv51p6d4EjISvhVb0HKNuPtvYMg8zImI8XrK2h9WYZGtdzdQhqtaGMHg4p
 hzl15UEBtUrH6rKmA8Gvg==
X-UI-Out-Filterresults: junk:10;V03:K0:sVkWtDPLdUw=:65XBoCldrO3u+32pnPxh/vTN
 yG07G0ZNrQ6//XSWaiQk8Mktqjo4pbeq7upqJJ/kCMgTPPpjuRzJPGzuY1xplUHzXv8uLyNbS
 dDUrZjypvchol4nkNVlualx5RWCZh/jiFw7wfdVqco7gS76WdJx051Kmq5KMHxNWIBmsPMSZE
 cnf6A1/DTGzCBfosby5nzHg70pBp7WQFZlPHM3TqfG7K3124zTwjrHDb2xPbQ25tLUhgh5pcD
 2+kEnLwk5X1lWeWq7VcGrOB79y0nG59EeAF43BQiCg0tfxa+rwjUbN7+ZHSbqKYXvUXWEoMLI
 TqbqrHxD2ufZ06IE3r0iv1IaYNgfb6AX+wNhi00uXQ0VsO2M5IueFEBDZNh0bgoRfPmsR3Ff2
 39aTmbfcboqdzoAul3CxKf1Twc/oYuaE4MCQY4TiDuIY5sU7N46jwu6O1tZy7Z8avA8e+75+/
 PfgBsGUVQyBNMSUH8ILKLdbFEPfLNnMBMZuC8te4RZXOnphN9KgTbhGYYdfrN8bDSkEO7ATWi
 OlBRcJuEvO+C8DJjjSzA3cBfXrx70Y2RIjNW7Ce32CK3sLd3EF/9/5g/VCOKGqfx3PAseOYw0
 JG7pQx+Yq7uYVKPqxmAcSR5t2NXVibDVDQxBE+dqZwA7CgkcwcUEodyW/oigwFyE4hYiU38vs
 957Y0r5RbmQcz6o6fHswvyLt3OqQO5ogTBjmlrnI7OlQ6KwC2/ZYqNPVd3NMlmrW1AVYF7IIC
 vRS9EIWFn0vm7+UtPKjWApuYRQYnur4jcyIGpeNS1bnDOcEPzY6uUM7dJyoY7mjG3fHZfqX+A
 hTNwFqNH0p7vymN7fdr/Wu6eHO+xNJ/Yq8B+cO6mxe8lsQanhbfteQONgKCz10dsrk72CS/+N
 RC6KXRJQ5Og6nO7qf1sncCTTvXH8D5TRmme1ts7jPyvUKAfvFVI6QSNCUCo7YK3GAkkEeYyEN
 eOtY1RS64aOrAS56zqh4jLOiyXCPjcQZ9HrpYV2IPy4DC4Xg4LC7xOEZ0tJ8njLos3dglVE85
 AxCOAZatR4QjVLV8PraCpi2ITvTuuqBq9H7LjIgAkVEWFoNrbEN85J6STNGC3ilwsDuEcePlY
 vyeNnGPJ3N3YJv7BXFmuPsAyNlPyCJRi0P43kLw5VB9QwY+KT7NQsvbebuPcFCgiimAyh8YJL
 sW1ALvML6zPLN7RJ68pShxTTBufxrXgPW4IAswTINuiW1Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 18:17, Geert Uytterhoeven wrote:
> Hi Artem,
>
> On Sun, Oct 2, 2022 at 2:49 PM Artem S. Tashkinov <aros@gmx.com> wrote:
>>> On Sat, Oct 01, 2022 at 02:58:04PM +0000, Artem S. Tashkinov wrote:
>> Bugzilla gets around two dozen bug reports weekly which encompass at
>> most thirty emails, which equals to four emails daily on average.
>
> So we're discussing about the fate of a tool through which on average
> four bugs per day are submitted (some of which are not very useful
> due to lack of information)? A tool which is not maintained upstream?
> Perhaps that's enough reason to just kill the tool, so no one has to
> worry about it, or maintain it?

Yep, there are not that many savvy Linux users out there. Filing a good
bug report takes a lot of experience to be honest.

And most bugs reports in Bugzilla are semi-automatically closed (by me)
because they are about amdgpu and i915 which have their own bug
trackers. Without such reports the volume of bug reports is basically
halved.

>
> However, at four emails per day, you might as well just subscribe the
> subsystem mailing lists (each of which would receive only a fraction
> of that, right?).  Maintainers and several developers won't even notice
> that minor increase in the number of daily emails received, although
> they might still complain about the contents ;-)
> And that still needs someone to keep the tool working..

Oh, God, finally.

Regards,
Artem
