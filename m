Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2C6AA7DC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 04:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCDDmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 22:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDDme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:42:34 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE33A199D8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 19:42:33 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id ev13so3094323qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 19:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677901353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JTqINNOjAHRV2z1l4pcHsw/HVcR6hqCYsQ0ki1nc3A=;
        b=IQs+bGVxCN7tAPYBUNu/4ajSq/K057XcWaZxXaMacysjfn3sqxKEDNraTyHCQ0IcKM
         +L2fHgNWiooxUYR4CS1YSfkLaHAS8FNpNB47gZ1V4kCkPoFuiCYwJW4LoyHeyOiWFgey
         DEmqOmrvVTOA4cCPnKxvo/ap8ofxx8eFHRaYdl5pop2I5euD/h8oCclq4VClHSIV4NHm
         Oee36V659BT3edKEXX+1zlPHvJ63vj7x+yiUQP4oLXFZ5RXnlD30/l8K0K8ypreDTsj7
         4H5yR+amMwTOq3k87k6tq5ILsDOhVt1GsEznPzTWByQrP6orpjRiPcp50a1copqJUD3P
         lilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677901353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JTqINNOjAHRV2z1l4pcHsw/HVcR6hqCYsQ0ki1nc3A=;
        b=GiBdArzYB0FbQDZomvMq89lnzyAo/7X4Qbim6CG60K7/uE5IXEYZKxdHi9Lt2gTAG+
         I/TKySwSbQ5SurZTj02E38xLzU2WVqRXKLB6MtZRvzfvSO4thSl5PIzXu59l8lVMb119
         vDmMNSmC2diyUJYrOcXRl0UJQEKKeuGc8p7CSBq7N6jqyyKQTUJyUjsS6wBsA+Wullne
         4NzJhlMmDUOmMWwWtB/Dct7zh6qoMKltvC7xDm3O9xAQ0C9gUpETFflC45zECkemAvFN
         RC0FrjQ9CbBv6yOYObJFjZSApEK6pG9DXQ/3lPpqI7NIPQpX/F+dhPLUMztnlUYXkGr8
         b2ag==
X-Gm-Message-State: AO0yUKWIe/bt73xoyix3KkQBJTBFL4t/NNVBI2cxBNdSGbWJ1Srls8aO
        8MRkCEpJJWc+R4ENm5LuxItzwYKlhyQ=
X-Google-Smtp-Source: AK7set+Flbbxc1BjHNhT0TscwJWOyy2ysUdBOuXqy+3AgqeW3Hrs10s1tIn0u6ubbJ1LJ7IXLjBC/w==
X-Received: by 2002:a05:6214:2484:b0:56e:c18d:ca79 with SMTP id gi4-20020a056214248400b0056ec18dca79mr8058624qvb.30.1677901352868;
        Fri, 03 Mar 2023 19:42:32 -0800 (PST)
Received: from mjollnir ([137.118.186.11])
        by smtp.gmail.com with ESMTPSA id 4-20020a370304000000b0073bb00eb0besm3046718qkd.22.2023.03.03.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:42:32 -0800 (PST)
Date:   Fri, 3 Mar 2023 22:42:30 -0500
From:   Storm Dragon <stormdragon2976@gmail.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <ZAK+JrcnIxPL7h4t@mjollnir>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <Y/OacHw6nL/ZtrH3@hotmail.com>
 <00e5aee7-c7b3-4077-8c9f-4f28ec220567@t-8ch.de>
 <ZAJqrfcfoM2eO5VL@mjollnir>
 <ce24d06b-7967-4b50-8913-ad42717e4c05@t-8ch.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bb8KRy6pqJUoK+RF"
Content-Disposition: inline
In-Reply-To: <ce24d06b-7967-4b50-8913-ad42717e4c05@t-8ch.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bb8KRy6pqJUoK+RF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 11:25:00PM +0000, Thomas Wei=C3=9Fschuh wrote:
>Does this mean the screenreader now works correctly or is it still
>broken somehow?
>
>Thomas

I forgot to answer the screen reader question. I hadn't rebooted in a
while, and I forgot that the work around Chrys put in place for Fenrir
does really well until the screen fills up. So, right after I sent the
message saying it was working better, it reverted to doing its weird
jumps and things caused by the bug. Now that the correct version is
actually running, it really is better.

Thanks,
Storm


--Bb8KRy6pqJUoK+RF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEjjImGMhZhYoKESBfW+ojcUPdwZMFAmQCviMACgkQW+ojcUPd
wZOICg/+OJY2L/t/wE1AmhY4J/5WLm3dCDPvat1JrWej2687aZbnRDtz15Zkw9ca
zNw6WTEnWZNxrEhUSCMmL8Qb/FuEjw+njDNnK+jiyamH9BMPN8YumNdf3fDVMMgM
4BzMRUCW7AVKe0CFsZP7Yx9DtO0THB84lfLhaSWMNWM8j9pgnTjqDliZBdA81cSq
pTpPVy8/ceTqsr/h9FIu6iQN3Qgrd9WbBUlocTC5VJJ4YRHL0Hy2jz6nxCZ57mqL
RdSUEEDnjxv8j/Qvrops8Eniwdso2c6zMBRk7sszvO7kgd9ynYPVyHNpO8UYW7ZL
tyZtoZBIh75h1WvlRB9aOGrbZYs7tefIXNIE0geu18q2oC0MWLGnTyAwOYy7rKuB
agF+AwNPQ6l1b7zusFqP30CsSSZrguINsFMQE3WdrKJk0fMlSOZIgVZMIOi9+lEo
5YX/GoVIWTm+AezhYe8S+Tpf13mXSe2BAH07wfHQAYX9aQ708SIJELi7SJErci4u
+ooRJ5Kg7Z0unOJVl3n/IcCBenPofOhxXALDSPY7fw0eeSkko/xAcOvdmqd0yuLv
QliLm94pu1AeIoMaHRwB3fHk03UHHPC26DZQzyW8vxwdea/L65deTMgOwYjQZZVB
1gBjQgfLxNZjkzNp0IAaeehtpq3VZ0MgTvpvmVL8jp/ALELJHms=
=HJCW
-----END PGP SIGNATURE-----

--Bb8KRy6pqJUoK+RF--
