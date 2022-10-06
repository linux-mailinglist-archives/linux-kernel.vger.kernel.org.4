Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC4B5F647D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiJFKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJFKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:46:38 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522A98345;
        Thu,  6 Oct 2022 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665053190;
        bh=CVAJNVccyTnvqFUKt2qhoZ3SSQTQEZAtvmO3iOKMZls=;
        h=X-UI-Sender-Class:Date:From:Subject:Cc:References:In-Reply-To;
        b=V5M1qQCo9OdHL8ak7bbmn4YXkX/f2K9NsVs+y+x3UgD62DLdN6AYxMz93DU8gJI7W
         MhkV3NeaJvaHj9qlbBmFjld0Figd9q1iVJ7cespd/EpIM7/GyWlF1FMLCfUTXyT7sG
         PyrwHORzRwTlCJZLHwUmNNMIKyaOEGV6oXL8ChQU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.24.110.15] ([143.244.37.25]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU0q-1pEMEc2I9U-00aV83; Thu, 06
 Oct 2022 12:46:30 +0200
Message-ID: <6363db78-f676-427d-b479-7065091f3f59@gmx.com>
Date:   Thu, 6 Oct 2022 10:46:29 +0000
MIME-Version: 1.0
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Cc:     workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <YzmBjgXq9geMnL1B@mit.edu>
 <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
 <20221002141321.394de676@rorschach.local.home>
 <6de0925c-a98a-219e-eed2-ba898ef974f8@gmx.com>
 <20221002180844.2e91b1f1@rorschach.local.home>
 <3a3b9346-e243-e178-f8dd-f8e1eacdc6ae@gmx.com> <YzoY+dxLuCfOp0sL@ZenIV>
 <b032e79a-a9e3-fc72-9ced-39411e5464c9@gmx.com> <YzqjfU66alRlGk5y@kernel.org>
 <251201be-9552-3a51-749c-3daf4d181250@gmx.com>
 <20221003142240.hu5gj7fms5wdoujk@meerkat.local>
In-Reply-To: <20221003142240.hu5gj7fms5wdoujk@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/T9qNnatvq6JAullCLcdS33+cIlq9WfwvAi1kVZ3kQ5n3x+m+fF
 4xpYW0LIkYE+oUf1WqHc2eTjn5PjevFKCr645WjI/WdsnAJmNBrqIJVJVw6B4iZqIuFoSme
 5pRpvpuBZ50cPcBFwwZXEqkXNW5iKlT2ikehn419q4seKiPRMA252Q3BvTtA/kkEmuFQQgQ
 YTDX1pfAXNjtiYcT4nLJA==
X-UI-Out-Filterresults: junk:10;V03:K0:3sij++BXOwQ=:gAN+cI7T6MUJ63MzWulkflwB
 e4jrmNcpwvcohQvEKcJTYbJxq9/HjJNGzCDXL+rTj1v7HFSFScqjcDoCqg32vdl8UkeoDRm6i
 ziTosPjXnATs9SUZX9TtyG4P7tzQ4SKM3WcDKaYsWH8E0YRgqhwG+AMynrGno5pK3vVxhLaku
 ROUUJPPsLtp6cQ4eg34KfBBEsPfsOpmR0hczj8b6GhxHw2+6ZRZsr50OT9ddvLbZDBQDPaZtp
 ymBgzdMCkWZw0g1Y3/UZk3R2f91y3OOiCrId1E9o1eqxCgCN6zDfRPcgB1AR9AW+DKUqaQqBz
 6oJ31rrduemFVK8KfgOMsUwU6KKvm0cv2Cv6QhZZLBhgl8kfALxHHgog9NoYSB6Iu0aHOzKDe
 FTri8erpMp6ZFcLcvIzu85QiZBS71cgofYM+uHRaZRfQgnRyMB0pyCXiHMvTxugUOpeRJ7B/K
 hzLu8qKj0f6MAlaWzfZV79zA8b7YxSyZ8ox+rokq6WG/Qe3nBcS+eP1/NW/TOqT8Fo08YeYJx
 2nWQuVF11CsOOyUpEgHodfPWLr1DPJ7KxQb6COA11sr9JYK1oqjU5fA5spkLlBKtT//65tV9l
 tejVqFobGVJj2lu8z3STcGSs4TJLYZx6qApgWgjriBe9L1hKoth5MFXzPZBz8kqBx0c81CtG+
 Syxy3N9gIMJi4+r3KGbA9nwWP6yu4kUlmTfLTbS/sTr0nZRnnimcNXJ2QUqHQkz789RhNvVqb
 7al6PA7r333z8RgpDpxsRGvI3gReOhUW/yKIKSBTFsL5Q7PKJHSPFj9OvE5WEwObUvvdMwYXM
 2dfEnINY4/CnVNKYtCGuyfmnG/lPujO9CRHzjMZBZnUVWAsHJB6NR5BR+Uad0h+Om/awfwJwQ
 AcElHBU4J+4s7jDGHdCMwV0lpZa7qHCIZgN+VcC7J9y+4sHifkPb5IQp1OPdGst6JEe52YZWP
 8xl3cKJSzI8PYlDNYHrax1ijFvZt05j41HZDVpep2lonAtDQG+Gq20weiTLYXDIxSBVvJif5K
 iWeyEnq3x+6zxCc0BjW8DqIqjIo6qXzvSaOHOZiOQ+mBXougs+EqjjiStB0WWvLG0YNcY7v3n
 Dat3H9abAyX+3DbHoG//wJJLoMMXXTLKAujwM28/myAqGavlB1e7yLB2o/++W0TKkFk+DYY8X
 Zp37NHIVsxwFBjVLPhamgM0i1mVaUg7J37y1Z+etO/HV0g==
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,MISSING_HEADERS,RCVD_IN_MSPIKE_H2,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/22 14:22, Konstantin Ryabitsev wrote:
> On Mon, Oct 03, 2022 at 09:16:06AM +0000, Artem S. Tashkinov wrote:
>> The initial conversation started with the fact that Bugzilla is old,
>> semi-deprecated, requires MySQL [no idea what's bad about it, Bugzilla
>> can work with MariaDB and Percona as well]
>
> It can't, actually. It only works with MySQL 5.7 or an equally ancient M=
ariaDB.
> No, there is no official fix (because nobody is working on bugzilla).
> https://bugzilla.mozilla.org/show_bug.cgi?id=3D1592129
>

(I wanted to send this message two days ago but my email account was
suspended at the time - I'm still sending it though it feels like it's
no longer relevant).

Speaking of Bugzilla Harmony:

* KDE already uses it:
https://invent.kde.org/websites/bugs-kde-org/-/merge_requests/1
* Mozilla has been using it for quite time already
* It has a docker container/image, so it's a breeze to install

I've dealt with a dozen other bug trackers and to me Bugzilla remains
the most powerful and featureful, while not being too complicated to set
up and use.

Lastly I've had a crazy idea for a second of maybe migrating the kernel
bugzilla over to RedHat/IBM (by asking them whether they are willing to
help) but on a second thought it's really really bad as the company is
very large and there's a ton of bureaucracy, so managing it would become
quite a hassle. Also, I wouldn't want the LF to hand control over it to
RedHat.

Best regards,
Artem
