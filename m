Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA455B8339
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiINIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiINIod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:44:33 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAF9C33;
        Wed, 14 Sep 2022 01:44:31 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3457bc84d53so171664657b3.0;
        Wed, 14 Sep 2022 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dqAn30NBH5wWC0YSQoOmwLCH8Zt1NyHPb4rM2z+XItk=;
        b=i8oTzkrZ6U1oFp6AtcPLInEYhkcI/UTVOtU4xv6qaDq03YeVJnUXHcMKY4NW8jiI4F
         TbZ/yifLUbjUx05F6PYTY6QPkohM8VA4M47TtlY6b0TVIWkeVPFS9iSAfbk+3RjISLPO
         ssUT3uz3/EivfltQkIvqCXDeplai/r23tjt3pTEyYhJxw7wq8iFYW5PxMGsRdW9woLzD
         14CPOzvDZTRz/+keblspCK/BGFDy+dJsqjdbNWzxDH6NqWEbVvLeK7Wo/lxoSb+lZ7g+
         ZMby7Z6xVR6W/cZX9zmQS9aezV9joWCsPBWf8SprWbbdQ/236PZzH3iOve+49F9VGuY8
         XGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dqAn30NBH5wWC0YSQoOmwLCH8Zt1NyHPb4rM2z+XItk=;
        b=2xwMV7/yI+yzu2tXWUyWVyWbnK2RC967Qxcp6GJsiSBpTR2HE8y5pTXSsmO11i33eP
         btjLyZ9X5Y2lL5aiWzXJZGUGlDU4bHSfEVW6W+if4zo7Oouf+2TAmt4ubrcVfkVOwfw4
         5hVPbFiBFTWj9PB6U9OnAFNSduun2sSNVcvZ2m/3WnllFrT9ilaq2NuF5izXMxy0LKxf
         5sN7wJRE0mhrFqtNlwlwxgn3oUR5/e0hqA2bQr7Sm36UihdIsz9XBddHR1EozgETvxOL
         ZuxrYu9xK9RDhjbV1crDB6mtj9I2LTcdTrYzb799xO9wECq8Z0wGzPGlGZS5J7oxWhn6
         5MOg==
X-Gm-Message-State: ACgBeo1Q0FRRdNk6Z8U4yB6Z3G1A+G3qrKCfu/tgHams7YWPMfcSwkxC
        Km7AZnj8L+GwqdATWQNVc1AORAE9nEfe4stGtzI=
X-Google-Smtp-Source: AA6agR5rMtfCqA+jIpqodfmMH8ZSX91+ezS39Peoiq2bwbWL/epSR/2RQ/2lDLjxvnEPOG2QQ2H6DaO+RnAWtDQc+2E=
X-Received: by 2002:a0d:f905:0:b0:345:3b1b:a00d with SMTP id
 j5-20020a0df905000000b003453b1ba00dmr28342057ywf.510.1663145070172; Wed, 14
 Sep 2022 01:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXUXMyMUNgra_B47Qk3kjqgmR-FcCbDpEZMH5rv=whrQDRQww@mail.gmail.com>
 <MW5PR84MB18424AB8C095BFC041AE33FDAB479@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB18424AB8C095BFC041AE33FDAB479@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 14 Sep 2022 10:44:19 +0200
Message-ID: <CAKXUXMyG1ZeiM5FjA1GL6zX12YaivnOKvNwdYMQDFen3ax77HA@mail.gmail.com>
Subject: Re: Accidental config renaming in commit 3f342a23257d ("crypto:
 Kconfig - simplify hash entries")
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 10:30 AM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
>
> Sorry for the delay - I'm out of office this month.
>

Robert, as you are out of office, I have sent two fixup patches for
Herbert Xu to pick up:

https://lore.kernel.org/linux-crypto/20220914083626.17713-1-lukas.bulwahn@gmail.com/
https://lore.kernel.org/linux-crypto/20220914083827.18939-1-lukas.bulwahn@gmail.com/

I hope that helps.

Lukas


Lukas

> 1. I agree this is wrong:
>
> -config CRYPTO_SHA1_ARM64_CE
> -       tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
> +config CRYPTO_SHA1_ARM64
> +       tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
>
>
> I think my grep comparisons to make sure the config lines didn't
> change were foiled by - being a special character.
>
> Herbert, can you fix that in a way that won't
> cause bisection anomalies?
>
> 2. There's one more problem in that commit - the
> CRYPTO_BLAKE2S symbol was dropped by 6.0 and should no
> longer exist. It's a remnant from the original series
> being based on 5.19.
>
> The extra space before "config" led me to overlook it.
> (I'll investigate if checkpatch.pl can check for leading
> spaces before keywords like this next month)
>
> + config CRYPTO_BLAKE2S
> +       tristate "BLAKE2s"
> +        select CRYPTO_LIB_BLAKE2S_GENERIC
> +        select CRYPTO_HASH
> +        help
> +         BLAKE2s cryptographic hash function (RFC 7693)
> +
> +         BLAKE2s is optimized for 8 to 32-bit platforms and can produce
> +         digests of any size between 1 and 32 bytes. The keyed hash is
> +         also implemented.
> +
> +         This module provides the following algorithms:
> +          - blake2s-128
> +          - blake2s-160
> +          - blake2s-224
> +          - blake2s-256
> +
> +         Used by Wireguard.
> +
> +          See https://blake2.net for further information.
>
>
>
> > -----Original Message-----
> > From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > Sent: Tuesday, September 6, 2022 9:28 PM
> > To: Elliott, Robert (Servers) <elliott@hpe.com>; Herbert Xu
> > <herbert@gondor.apana.org.au>; linux-crypto@vger.kernel.org; Linux Kernel
> > Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Accidental config renaming in commit 3f342a23257d ("crypto:
> > Kconfig - simplify hash entries")
> >
> > Dear Robert,
> >
> > I noticed that:
> >
> > Commit 3f342a23257d ("crypto: Kconfig - simplify hash entries") makes
> > a lot of changes to the config descriptions, but among all those
> > changes, it also renames CRYPTO_SHA1_ARM64_CE to CRYPTO_SHA1_ARM64.
> >
> > Given that you did not touch the corresponding Makefile, it seems that
> > this config renaming was unintended and accidentally.
> >
> > Could you please confirm that?
> >
> > Best regards,
> >
> > Lukas
