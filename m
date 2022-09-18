Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7F5BBE3C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIRODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiIRODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:03:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADB923BEF;
        Sun, 18 Sep 2022 07:03:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c24so24548966pgg.11;
        Sun, 18 Sep 2022 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NRTsRoZq68Mxvcc0uJgWyB8RLpcLxxtOeb25FXO5W8w=;
        b=GMcReAOx9b7ZPOdRgBNpKaRoeKWDGu7XyqHIC8z9tIit3E9TGN8dCfPG7UbYZ4TPIS
         VEVbcRKB/siCz1OmxdGa710+xs/Hra9JoSKxsIy0tWfqRzpQbbp+82MplF69GmKGQ5kC
         YIP7QQJcD3x8hMbH8TO6hJmxiXktsZXD5q4YKwqQ5AK745jfPBY14xDowthTW05ZkOzw
         56clZxN13oYVRbqMQ4QUae3bkm6jlBntYUSjDeDkMNhmanIVi9R3MOhq/NihYS0/buO5
         X1r0sB7kxblfUT6jtjkdMLdU7rS/CnHXFxL3HfNO8mkCc6c++/vmk9j92IDqqM6M48e0
         1c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NRTsRoZq68Mxvcc0uJgWyB8RLpcLxxtOeb25FXO5W8w=;
        b=HVe7CSKgmRabV/x9tqpU87+soYLZjMZz/gO0dD5FlLP0Q/fIo45eOpzk19OO8OaTfO
         V8RGyd8M4s4E3W34ANMX3sfgEdpdhxAmLKH7cd3fJY8DtTNWs4zJevNmnZgyOs54AE9P
         vHm6oDF3ymF9b6hjIHoq+3YtsC1Z9E2W5koo7A1pt0gCOnX/qRUDMWFn9muyhBhQXJrZ
         RsAr5ndCUxHCI2uPksMJruHf5tDVanZ8jg4WcUPVGgNSVL57hNgDIiC+GYT/kYIMHb21
         2NctVwpjsJh065z5HBDeclZ1RAGTxPl/s8AYWox7Sh9YzRH03AfpRa7qCBZJcr2aUGI8
         HAGA==
X-Gm-Message-State: ACrzQf3al0xfv8vQEgV9vSZ6qcorRAtGAzWA/Ap2ZFkugsp/rnajT3VH
        g+SbaLwWkIGxtU8LwwX2ax0=
X-Google-Smtp-Source: AMsMyM7qgSJdqhKgz1PblDV6bKrAm9ziTxsEmmGfkaWkNBt7muaFASEzLIO9ts5AW4HZKq8vSuu8yw==
X-Received: by 2002:a05:6a00:4206:b0:545:68f2:292e with SMTP id cd6-20020a056a00420600b0054568f2292emr13697451pfb.76.1663509830518;
        Sun, 18 Sep 2022 07:03:50 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-51.three.co.id. [116.206.28.51])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b0016f975be2e7sm18573030plb.139.2022.09.18.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 07:03:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4230F103B70; Sun, 18 Sep 2022 21:03:46 +0700 (WIB)
Date:   Sun, 18 Sep 2022 21:03:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: base: fix repeated words in comments
Message-ID: <YyclQlws9d7vheDk@debian.me>
References: <20220918095957.24537-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7yCBxU7llMplZvup"
Content-Disposition: inline
In-Reply-To: <20220918095957.24537-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7yCBxU7llMplZvup
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 18, 2022 at 05:59:57PM +0800, Jilin Yuan wrote:
>  /**
>   * of_match_node - Tell if a device_node has a matching of_match structu=
re
> - * @matches:	array of of device match structures to search in
> + * @matches:	array of device match structures to search in
>   * @node:	the of device structure to match against
>   *
>   * Low level utility function used by device matching.
> @@ -1175,7 +1175,7 @@ EXPORT_SYMBOL(of_match_node);
>   *		you pass will not be searched, only the next one
>   *		will; typically, you pass what the previous call
>   *		returned. of_node_put() will be called on it
> - * @matches:	array of of device match structures to search in
> + * @matches:	array of device match structures to search in
>   * @match:	Updated to point at the matches entry which matched

That second "of" is the device, so the fix doesn't make sense.

Also, PLEASE stop sending these mindless redundant word-stripping patches
as byproduct of whatever automated tool you use.

As Edward Cree said to one of your colleague [1]:

> #ifdef RANT
> NGL, getting kinda sick of these bogus comment text 'fixes' from people
>  who clearly don't have enough mastery of English to copyedit it.
> (Previous one from this author was actually wrong too but I didn't catch
>  it at the time.)
> English is a tricksy language, why would someone with a limited
>  understanding of it think that grammar fixes are the best use of their
>  time and energy?
> I can't help suspecting that this is a box-ticking exercise, where a
>  certain corporate culture has a standard requirement that engineers
>  must get X number of Linux / opensource commits in order to get
>  promoted, and this kind of mindless patch is the easiest way for them
>  to achieve that.
> #endif

If you really want to do real cleanup, consider joining kernel-janitors lis=
t.

Learn from above, thanks.

[1]: https://lore.kernel.org/netdev/30f2488d-9af3-fe8d-6e6f-713a7d38800b@gm=
ail.com/

--=20
An old man doll... just what I always wanted! - Clara

--7yCBxU7llMplZvup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYyclOgAKCRD2uYlJVVFO
o4ueAP9rOkS3/cc61IFsELqltLUWs+gQLDZrhG3lOmPXT1DkJwEAtQKtChFrPySL
n/Op1oMwsl+TgNxGjw/TNhQ1U/+tFwk=
=NZ1v
-----END PGP SIGNATURE-----

--7yCBxU7llMplZvup--
