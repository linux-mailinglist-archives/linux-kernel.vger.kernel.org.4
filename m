Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FABB6745C5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjASWSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjASWRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:17:30 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1923D9EEA;
        Thu, 19 Jan 2023 13:59:54 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id ud5so9390676ejc.4;
        Thu, 19 Jan 2023 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3VE041wvuNRNbjGYZtx0e/0zgM5UPT7CKrc367fPVk=;
        b=IPCeWzq6Su6zBpvw0I/tB6Sg+z9fwSOmfPRSY3r5ylze79JUCxWH7yR76NoAjnfhLh
         /3mvmpBmlBNQd1w54wWfwthiQ7XwLGSwPVXyGcDeLBja5rMaREw6mUQUQGXTpF0S8FCt
         KGvwJFgmRa5lNwhjPEdBH2Q5V3WlMnDp3GRTcfjgJaxvftYQoufWESdoRZihxi8k2wwP
         +v5a1pYiZOUNqipdHEIU8A7GXXUhk5pFB9Upv3xzLeWLVJq2xaI04K9dU4UumlONHsB7
         YdDMkZ/A0IfpAKgSnPA4+0CZV4bsg+chTUPE6koNjqn5vhjTmno0C8rBZ/qWwu7EigsR
         Yv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3VE041wvuNRNbjGYZtx0e/0zgM5UPT7CKrc367fPVk=;
        b=vdkMh6COPaxH0TqZ2IUqWr6Fopi67gVyc0ngPD5lav+e8yMIdGJ7ljRfOMZXHdbQ7n
         8Yd1B9ToXZ4S7R9W7vwRzHVaUyAzLi/66+H83hg0hcSBEhzmdW8dl4AjH7u0mk7VSSTe
         zYCe12pJ6rYyA64cgNcAyyqz501fZ0KyVjUZIkW0Dk87XPv2jaj7e6JDjXhvKMdkWGv5
         plGx4mrxtMcHlKksVcYD4SJywHfBRkdJNh50IuYVz9ypZhnxbzzhHMv9ME00j/cZd4t2
         9Xu/dYg/r6ZU55BvQkN8algGsZfyVi/DVbUte+QBcjcufSmz20insCt0EugJg3HqFetF
         7Jdg==
X-Gm-Message-State: AFqh2kr1At2Sfc9p1lSmZeFx5x80OKUDsg6oD3W+COjKW/VS+ohlI6o7
        bZa08belDdhZAZt4eXWI8w8=
X-Google-Smtp-Source: AMrXdXudkdRSemBU0Ipq+6BnTLm7omlc+r5e91BFxGZUSaPfat1wNjMDIRVlQJVRWpm6uCKC96ehLQ==
X-Received: by 2002:a17:906:2b8e:b0:86e:3531:5548 with SMTP id m14-20020a1709062b8e00b0086e35315548mr11768857ejg.73.1674165592554;
        Thu, 19 Jan 2023 13:59:52 -0800 (PST)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id nd38-20020a17090762a600b0084d1b34973dsm16915714ejc.61.2023.01.19.13.59.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2023 13:59:52 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: linux-next: Signed-off-by missing for commit in the jc_docs tree
From:   Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <87ilh26vrd.fsf@meer.lwn.net>
Date:   Thu, 19 Jan 2023 22:59:41 +0100
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3804F4A3-7CD0-4A77-8E4A-07459F9DC64B@gmail.com>
References: <20230120083419.1fff9149@canb.auug.org.au>
 <87ilh26vrd.fsf@meer.lwn.net>
To:     Jonathan Corbet <corbet@lwn.net>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 19. Jan 2023, at 22:48, Jonathan Corbet <corbet@lwn.net> wrote:
>=20
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>=20
>> Hi all,
>>=20
>> Commit
>>=20
>>  6b25b190a9a3 ("docs/scripts/gdb: add necessary make scripts_gdb =
step")
>>=20
>> is missing a Signed-off-by from its author.
>=20
> Sigh...my tooling is supposed to catch that...  Patch dropped; Jakob,
> would you like to send me a properly signed-off version?

whops, it was the first time using b4 submit and I can see Sined-off-by =
in the email
=
(https://lore.kernel.org/linux-kernel/20230112-documentation-gdb-v1-1-09ab=
556e9124@gmail.com/)

was it perhaps put in the wrong place?

I'll be taking a look!

>=20
> Thanks,
>=20
> jon

