Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE499682A53
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjAaKVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjAaKV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:21:29 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FEF244A8;
        Tue, 31 Jan 2023 02:21:25 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id o5so12789858qtr.11;
        Tue, 31 Jan 2023 02:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zKP87TjiGZNs0yCcl80tXkV44epFLNcF2cOejqOOv20=;
        b=qWaOS81AfJwBWXGyhdbivBN1cu5C9V3P859ZE5gbkrNdHSfM+e48bswhX4pvIceVtQ
         6gNWrO7RLZMpl0DYMNSjiI/9LWvgCRqrKtKx8UdRbLWYFqwg6LF3LHs4m9dq7iKO8v3F
         00jCY84ieVBBK4DpqSk9csNoOaXEWdJocV6kvi+k/IRJv9CBeDjeFYtbrYtf88eHlq45
         4aByQu5WUVoqlKpKxKoEQm5Y8E4Y8BREsAkLrx92waPSIer4zGLZHBA/RT955D2jYQ1H
         nAVH6dPuZAFbJs4hsGaX/Klgk7RZw7H6h1RAc/BSw9NEhKaWW5srJYO7b1euG75M4wm0
         aumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKP87TjiGZNs0yCcl80tXkV44epFLNcF2cOejqOOv20=;
        b=4O/qe/GB0nWCPHxw+ZAFdl2rqaZbGKAljcSxcHkuvb7M+fmrWYZYR6pPvAHvmD8sn2
         PmqfA5QmRlGZjUe9UHA/fjYkdg3bd3kI0hFw1NrbI24oP7P9CvS63GWl/9ZbAvHa0/tJ
         bCAB323HuG1dmRmXi4rZuOK1cujRRvc6RkCRjJy/EQ1w/sAOdAuzmE2Dl0JJnkSvTPtF
         6jaXdlA7TjiSUj+FgBb6xQuSRtnQ4AdSu5P+uMw7cl5e+Tm5gduZkAexzg600ESB50YY
         RM92IfiWwOiADBi3I8PuzY7dUqJ9NdV/6TLSMNgUq/tqsuKh3OQBeR0ABYh4sPpwuOjQ
         S8HQ==
X-Gm-Message-State: AO0yUKWyG+9udkOOFOYWsM9TXLZ7aH1VqCSyN7v1GrGVBfrF3l8uVuWQ
        Anw94mTvJA4VcKBpMYORZ3/R+OWD7gBN5w==
X-Google-Smtp-Source: AK7set9giH92eTTcoPQQi5neUmN49ZbW8xRnRwCPgG4fgOGr/aVOcwbtnOHAHLt6gLZqRPVebqXXQA==
X-Received: by 2002:ac8:4e90:0:b0:3b9:b297:5ec5 with SMTP id 16-20020ac84e90000000b003b9b2975ec5mr1708716qtp.13.1675160484448;
        Tue, 31 Jan 2023 02:21:24 -0800 (PST)
Received: from p200300f6ef015700e657423a1f156bec.dip0.t-ipconnect.de (p200300f6ef015700e657423a1f156bec.dip0.t-ipconnect.de. [2003:f6:ef01:5700:e657:423a:1f15:6bec])
        by smtp.gmail.com with ESMTPSA id h18-20020a05622a171200b003b8238114d9sm1259328qtk.12.2023.01.31.02.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:21:23 -0800 (PST)
Message-ID: <2c8c64f95569a3bfb142761bad7a948c71a8d266.camel@gmail.com>
Subject: Re: [PATCH] iio: adis16480: select CONFIG_CRC32
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Nuno Sa <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrea Merello <andrea.merello@iit.it>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 Jan 2023 11:23:10 +0100
In-Reply-To: <20230131094616.130238-1-arnd@kernel.org>
References: <20230131094616.130238-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-31 at 10:46 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> In rare randconfig builds, the missing CRC32 helper causes
> a link error:
>=20
> ld.lld: error: undefined symbol: crc32_le
> > > > referenced by usercopy_64.c
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 vmlinux.o:(adis16480_trigger_handler)
>=20
> Fixes: 941f130881fa ("iio: adis16480: support burst read function")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>


