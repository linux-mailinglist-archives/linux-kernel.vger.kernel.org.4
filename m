Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2C45F2526
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJBTiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJBTiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:38:05 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64E3AE52;
        Sun,  2 Oct 2022 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664739460;
        bh=+1ZBqOo7xA2jLDjhoiw+E7zATj85pXRLG1CyT/DpX8o=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QA/mIfpIs0fwsvoNqitibNfy9L1z3JpZPTQmfnUUUASjVl5Iyr4BnPSx+AiQa0xZv
         VGTNrWcUWOowh32AqfU830rmIyPvUGxG14DI+imiatJ0wwToZ6XNaLiPMkjuky0ObD
         oFrUonD7ji56uTGMBMRe3dgHDGxGL4TF1x2tsF+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.13.110.23] ([143.244.37.73]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEm6L-1oPvhv1mV1-00GMCc; Sun, 02
 Oct 2022 21:37:40 +0200
Message-ID: <20ddd12f-7277-f343-885d-b39d9ab5c2c3@gmx.com>
Date:   Sun, 2 Oct 2022 19:37:38 +0000
MIME-Version: 1.0
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <11098E44-8BB4-4318-9BE1-A659573E6BA4@sladewatkins.net>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <11098E44-8BB4-4318-9BE1-A659573E6BA4@sladewatkins.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KyKHEMu3BEyKf9CGcIoo3gsYb1vi7VrYOeIFlLHisE2SFF2ZW97
 kNjQ1Q5/7R5ldyNi6dVQQ565jUnsIHmsqn6uqG6J7YNuceXtzvTsgmlcHxJ7QIWt791Ta81
 zxkxNOqRKNQmU/qgcmAa2Q/siWMH2MHEpaRa83qHd5OcHHHcsztXMgYZCLnDdVlLg+zb16+
 nSg8W3Z4//TW2FA0PSw5A==
X-UI-Out-Filterresults: junk:10;V03:K0:F71exuKNqtc=:BKrmcvFCrjTkRCG4uil5HfRB
 DRdw0C3OkL6u/tdQLiC08/2n7198pYI1e6oTFuNhJ44uaUbs9uvHWjryxrKEGfBdkzOt6eHDv
 pdURmrp345BKCvIAhh6oQqsOmXfeCF3vYb8MjPOXdmuGcfavbFdXa0fB5Dz4gUkAUt7rqx5hU
 H4pkBteLzSl/ICI/OEjHx90g9k/ovMF55PWbH5zbyZevY3yWkTtn+BiLmu8JNvEX31WM1RyLs
 WyLna222uKMXLbgmXMlgPJvRp/bD3XV++r9D8dvMWYiVv/tMs+jIssFNy5SYxJyscT90WXz7Q
 qoerPqVV5hGruw0ZuV5vOaJGLNtXIyxCEAhGgWTdK2YRiPYTkAwYgSSQhXkyYvTVFEbfe5n1G
 ZPu0cvH8WSWf1fZn/zrB713XWXPZfRrUub00DHWO4+KS2ImJbmwPvchrTCGnO0NIis+osL7UI
 JjKg2GS8SwJufQQhVub1kftIAUk4Jxt/O0opJZw7jRcPsdB50tZV1+ngx8g4BZsUBYQf1FjVR
 bacZFBS0KCEbKG0emxw6I6AvWyd3nLzWY4+uKzriI18fBlgRjK6JFYrqd+bmcs+b5mZ01+XA8
 FAo/jJP30FZekXB2zMMLLxns+byf4B6NPlj49ZaEOtNMJIgHmOeCJdvK+IBgIh49PLOWGofDv
 SZ1CARI9ImDCZV3rBLfWGs6Ka7nQZN2ChpFsO8YAcFrDIkqnzeHd9dbgkLKqyV2i1KJ3S9weZ
 0jfeqL4MYJrUjrkZOcigkZ8rviWq9J9aP+YMusTOBOq56PgHITY+fed9jjqbuxJT1PAWyskQx
 zWWsn67y/KeLGi3f9oivj6ISrEtlqOhDKxsH7Q0t/qMJd0urgBfSpViVwx0Ek0bUgjI+AV+59
 ePe8GZBD/dc30ovbZ/ISG3qjRgCiBfuPtXELvAgXTx4WGAMnm8zkc8i11CQ2BmJbmk3rneP5T
 0h62ymPTxKD3Tio1UNh20WGUvNvYQd6PxKdqin63gFkCz58m97nhvQD/8l/qf3AioxOrIZLXr
 lUQ7cWoin3CEIOUkS3VAJi4kn1oiA3W5IaYCVC9De2uJf8LFV+6I+792J86Gpwsai0PIjuVcl
 tq6vZni0dBbD0PkB1Irq2ejVyMBaenkpVTjnHS6JB2ms9kSfLB6+mqqQUDeuW9m13jh2+2tX8
 t7zJM+Hf+jp8FqbUu4+05R1Sif/qwCni9TIjxZUUNTQu8g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/22 14:48, Slade Watkins wrote:
> Hi,
>
>> On Oct 2, 2022, at 8:49 AM, Artem S. Tashkinov <aros@gmx.com> wrote:
>> As I've said many times already: bugzilla must be an opt-out, not opt-i=
n
>> experience/option.
>>
>> Let's subscribe the past six months of developers using git commits and
>> if someone doesn't like getting emails they go to the website and
>> unsubscribe _once_ which takes a minute. This is a non-issue I've no
>> clue why we're dwelling on it.
>
> I disagree with this in its *entirety* and I really don=E2=80=99t think =
it has any chance of moving forward.
>
> If this were to happen (and it won=E2=80=99t!) then developers will just=
 send the emails to spam or some other filter because they didn=E2=80=99t =
_consent_ to being subscribed to it. And in my opinion, they=E2=80=99d be =
justified in doing that.
>
> -srw
>

It was a proposal from no one, i.e. me.

The other option will be what? To _mass email_ everyone asking them to
subscribe to bugzilla? Do you know what will happen? 2/3 of relevant
people will forget about/neglect this email, they will never sign up
even if they are willing to and we'll end up with a disfunction bugzilla
again.

It feels to me we are back to:

"Users are expected to break their necks finding random mailing lists
and sending their reports to them expecting feedback".

95% of users will just give up.

4.95% of users will not receive any feedback: the developer has been
busy with their work, life, past time, etc - "Sorry, missed your email".

Maybe 0.05% bug reports will be actually dealt with.

Again this does not work for serious collaborations requiring multiple
people over extended periods of time. It absolutely sucks in terms of
filling in the missing details.

I begin to sound like a broken record repeating what we've already
discussed to death a dozen times.

Let's deprecate bugzilla and just say "f it". That's what I hear. Great!

No responsibility, no bug reports, no fixes, welcome regressions.

I concur. This discussion has been a complete waste of time.

Regards,
Artem
