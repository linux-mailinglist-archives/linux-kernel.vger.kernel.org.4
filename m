Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB65F2577
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 23:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJBV2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 17:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJBV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 17:27:59 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB0367BC;
        Sun,  2 Oct 2022 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664746062;
        bh=3XR4RF6qxOPpohcyIVBACjMVCQ1syTtTe9tcw6Ot/xM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=N0rj8hQfwx82yFZb5ZMIeCQ0GNJc/9/Wq42foBDoI990+CXKojDaQFbri0pNnwuOY
         tIY+lO5IyGHiDM2NlLtbVA9pdqSxaruUwjCNlc/bY6wbYy++wTMqd1+94clpGTp3TV
         RzLMRWOv7xBVyADoQSkQAYNmeMgEBuNJFurYXgCA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mdvqg-1pEzXs0keU-00b2fY; Sun, 02
 Oct 2022 23:27:42 +0200
Message-ID: <8f2ad360-8719-e275-050b-f279201a1616@gmx.com>
Date:   Sun, 2 Oct 2022 21:27:40 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
References: <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com> <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu> <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
 <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <YzmhoglDyEf3z0n8@kroah.com> <ce0b5780-a8cd-83fc-5b91-3acc574f426e@gmx.com>
 <CAHk-=wiGZEGY7kDXSD3ryL3yJ6fMp-+zzdyRFUc30kW+512-2w@mail.gmail.com>
 <7d57b7d2-b39a-881c-65e6-969c4f0948cc@gmx.com>
 <CAHk-=wjfAERC3XjZ=rF8HM+Q52LD-j_EEtv0hhiyhi6PC6MCUA@mail.gmail.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <CAHk-=wjfAERC3XjZ=rF8HM+Q52LD-j_EEtv0hhiyhi6PC6MCUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iwwfmZCOuulqIGJ7oRSk32ZC6ykTfevf7ETj4l+8gUeU7qqEj0w
 TQA4WNhnnFWh3HPhflAv6MSHl+WWlbFTCGrBrPDIq7NiN+vuQc28mzn3hBD8BIXaPYROu/h
 Ul/pIRKDIoTNcL7Sb5Oznr1DF5VPQ2wW4K6i63MSELsjcEaM6mL4udpyk5Ef665l4v0kXHh
 ZJy3J8aDHcAfwjiXnJhZw==
X-UI-Out-Filterresults: junk:10;V03:K0:dd2UfWbgR90=:454zkcTQ94YoYLCXmFdR+++a
 NEBbnCcptRZS4uIGhC6WS8g/p7tuXEFxwpNomu+tC+iWjQ4fiFUupMeH9KxRG5W108Sy2FJuJ
 Grm2g1IaEjHIaZjQipJEI1RX97n/hyig+UOzVe4aMc0kcC8HNbSGbSvwEGfeAmVfEuRfKpMJC
 V636cVebQTUop4GtbRd75pPOFXQvY1BE1pkzdx053lNJGoiWOnrkwW1DU+LDNglX3vyUift0m
 QcDXc/EIT1746nbAJCCA+pNqVbnYtd4xRrC68pibWkDcp9C/GK3bZtne4kca/n0xZ2ryDg2y6
 tPa/MY/qZ5J25y150Upq5moHRyMVRx3jyDDzkQh4TagLvfM+FfajJRPShL8PwosOIoVSpMkj3
 AyvneIOujExnxNrl89VuXIJJXkJzMIFhWsPluBIGpjGuww6mIiROIK73eygAuTO4CKrv/9Wmt
 NDBgjfPVMqvjbgLPDSf+vRMB1GOrhXDHTk3K+3pjYYozg6wZ6Kjh8oxvWHj7LwzeCTPTwnjeQ
 ihRWHXztnxE817ha37lpiOh0GFdrqU0L7UyqZ+hdCugnJ5bUPD9dk22hE3e7+ouK/EdRDWD0R
 RopSvG+N2jDq+Su2xpWJyzrCTcDIpwxSLFB3VIlZ6j9MUqiiydBqARehgIw/tldz6XAn8HlkI
 bHFIWaMLCLXXwQ7fDdeP6t5CN4E6v5Bta54k/+FyfUzzEud1XQr/GttPIGzQBd+HUGEOZlI/A
 sbNyVvCzvkdk53QYF9DZhXVFLgUsbSJZB3QMraQ3NngNltfYqGqYKSXbwGE3vCj+WfcE3Nny1
 blJuCbEteO/QKrdbcfblX2+es6bIHmNNDC9IbWYQx3n9W1QCHEPLXCr+YcnlF6AoFAsbMLbbs
 sVmKvoFTTj5BCcbbGgiGiBHGpJoDNWpS4FLIy1q5D7tf0GU0SEHc50oJMuYR4H/6cAndyl+1S
 NrSv5tacNIngKCFrS1wfLMsIsKxwBQxdOdvcLByEniRQkm/7kcz57s/NDSY3GG7b22x4jaBQF
 48IdIS4G9M9f4foC0U4mqR6WlvMJJp9/FcSAkFxQ5SINWvacCo+5D7z1i1vqs7H8R09CybuYi
 beiwEN6RXDz0jLJ/5wOdZUcW62BQVF06llwcmUpNMTN7CEoWt/WqEV09hKJFaDc66JDKhr7KY
 xJMDef8tr5zIAMxZ5/6q4Bu5D3ue/mnzYXxkK/kcKHZ1Ng==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 21:07, Linus Torvalds wrote:
> On Sun, Oct 2, 2022 at 1:56 PM Artem S. Tashkinov <aros@gmx.com> wrote:
>>
>> I just want a bugzilla where I can CC _any_ developer _if_ and _only if=
_
>> they are willing to work within its confounds. That's it.
>
> Guess what that "add develooper to the Cc" is called?
>
> Email.
>
> What you do is fill in the bugzilla entry with all the data you want.
>
> Then you use email to inform people about it.
>
> Put enough data in the email that the developer knows whether it's
> even worth looking at the bugzilla entry or not. Don't just put a link
> to the bugzilla. Most developers will just go "oh, this looks like
> spam"., Put the overview in the email, enough information that the
> developer can go "Ahh, this is worth my time", _and_ the link to
> bugzilla.

That could work or could not work because e.g. my email provider,
gmx.com, is blocked by a large number of companies/people because ...
reasons. If I'm lucky I get a reply: "Mail cannot be delivered because
reasons". Sometimes I get no reply, there's no way of knowing your email
has been delivered.

More importantly there's no way of knowing an email has been read or
seen. You perfectly know that.

An email from an official bug tracker, not some random Joe on the
Internet? That will less likely be considered SPAM, fake, scam, etc.
Some people have no idea that kernel developers prefer to deal with
plain text and may simply ignore HTML messages which have long become
the default for many email providers.

You're asking people to know in advance the kernel developers email
etiquette or know English well enough to communicate your problem.
Bugzilla doesn't need that. You can dump whatever you want however you
want even in your native language.

>
> That gives you exactly what you ask for: you can CC _any_ developer.
> And it doesn't force the developer to have to go to some bugzilla web
> interface unless the developer thinks it actually adds value.
>
> This is *literally* how I end up using bugzilla. As you say, I
> actually do end up looking at bugzilla entries in the end, but I only
> do it once it has hit my mailbox first, and I have some fairly good
> indication that it's worth my time to look at it.
>
> And yes, for some projects and for some developers you can do that
> email integration from within bugzilla itself. That's how people reach
> me.
>
> But this is exactly the kind of part of bugzilla that is a TOTAL
> HORROR-SHOW to manage, and it's impossible to expect every developer
> to be somebody that can be listed on bugzilla, without bugzilla
> becoming a prime way to send spam.

There are many easier ways to SPAM people ;-) I've not heard of anyone
complaining about SPAM coming from the kernel bugzilla yet.

>
> Which is why in the general case, you really should consider email to
> be the "lingua franca" of kernel development communication.  It
> doesn't have the fundamental limitations and management issues that
> bugzilla has. If you want to add more people to the Cc in an email,
> you just do it.

Attention, Linus, the problem is attention.

Once something is filed in bugzilla, it's public, it's easily
accessible, it can easily be found, you can easily add new info.

Emails? You've flown to Japan to a conference for a week and you have
much better things than to check any email updates. A week worth of
emails have suddenly become worthless.

Here's yet another issue, how would you send a follow up if you don't
know the reference ("References" email field)? Instead of a follow up
it'll end up being a new unrelated email.

Lastly, if you're on bugzilla, your email address is a lot less likely
to be leaked. Bugzilla doesn't publish emails. Public mailing lists are
used to collect email address for SPAM databases all the time.

Since kernel developers/Linux users love privacy so much, I guess it's a
good argument for Bugzilla, not against it. Many email clients/providers
leak a ton of information about you (email client version, timezone,
even IP address) left and right.

Regards,
Artem
