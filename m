Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D179646DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiLHLBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiLHLAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:00:31 -0500
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690ACEB5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:56:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 548F65F84166;
        Thu,  8 Dec 2022 13:55:02 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z8dTSsIKyTlO; Thu,  8 Dec 2022 13:55:02 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 1EDCB5F84177;
        Thu,  8 Dec 2022 13:55:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 1EDCB5F84177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1670496902;
        bh=rUvJnpVqda/XrD0Yslbfg4XSoclqItYAyzzRSPgpCEg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Lr6sUffBHSb0XYb5YxQwir+YBgQ3slJp8WYPPtsZMpTKzirduSUnClWKIIt5zDXFr
         aMIqn84h5oZjHUoCJYIfNis+Ou5vS9VjsBciiuhr0f1qS3723W+mKH7LMR/7/JRDcD
         sUewJdXTWrUgYDmXLAUam0tDWS2L/+q11r1EMxKecVJwm5VoUQFAzFDAJGbz/HaEtj
         OAAWRb/4FutI6pJESV2F41w5M7wepq6Vw0Z6Q9LAv9XxCj4O6WJyfQGtTc31B6lf7o
         pF923HyswiaeYBLR9HG8pG7oCn5/x3sYMgE3WCK8kbxjhB1hseQO1mVnG2IGpj9ke1
         okH4ZhUp0HyQQ==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L6S1boAvc3F1; Thu,  8 Dec 2022 13:55:02 +0300 (MSK)
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
        by mail.rosalinux.ru (Postfix) with ESMTP id C69B05F84174;
        Thu,  8 Dec 2022 13:55:01 +0300 (MSK)
Date:   Thu, 8 Dec 2022 13:55:01 +0300 (MSK)
From:   =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPRgNCw0LrQvtCy?= 
        <a.burakov@rosalinux.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Haverkamp <haver@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Message-ID: <1315574310.3286650.1670496901569.JavaMail.zimbra@rosalinux.ru>
In-Reply-To: <Y5C98NpQr2G1bkvs@kroah.com>
References: <20221207141808.22922-1-a.burakov@rosalinux.ru> <20221207141808.22922-2-a.burakov@rosalinux.ru> <Y5C98NpQr2G1bkvs@kroah.com>
Subject: Re: [PATCH 2/2] misc: genwqe: card_dev: Array index overflow fix in
 ddcb_cmd_fixups()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF106 (Win)/8.8.12_GA_3794)
Thread-Topic: misc: genwqe: card_dev: Array index overflow fix in ddcb_cmd_fixups()
Thread-Index: RRqjlDELV3nhlQWpZV8ap6+s8P+eZg==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BAD_THREAD_QP_64,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The subject was created this way due to technical issues. There is only one=
 patch here.

With best regards,
A. Burakov

----- =D0=98=D1=81=D1=85=D0=BE=D0=B4=D0=BD=D0=BE=D0=B5 =D1=81=D0=BE=D0=BE=
=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5 -----
=D0=9E=D1=82: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
=D0=9A=D0=BE=D0=BC=D1=83: "=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=
=D1=80 =D0=91=D1=83=D1=80=D0=B0=D0=BA=D0=BE=D0=B2" <a.burakov@rosalinux.ru>
=D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: "Frank Haverkamp" <haver@linux.ibm.com>, "A=
rnd Bergmann" <arnd@arndb.de>, linux-kernel@vger.kernel.org, lvc-project@li=
nuxtesting.org
=D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BD=D1=8B=D0=B5: =
=D0=A1=D1=80=D0=B5=D0=B4=D0=B0, 7 =D0=94=D0=B5=D0=BA=D0=B0=D0=B1=D1=80=D1=
=8C 2022 =D0=B3 19:23:12
=D0=A2=D0=B5=D0=BC=D0=B0: Re: [PATCH 2/2] misc: genwqe: card_dev: Array ind=
ex overflow fix in ddcb_cmd_fixups()

On Wed, Dec 07, 2022 at 05:18:08PM +0300, Aleksandr Burakov wrote:
> &cmd->asiv of size 96 can overflow because its index (asiv_offs + 8)
> can be equal to 96 (0x58 + 0x08) that is out of range.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> Fixes: eaf4722d4645 ("GenWQE Character device and DDCB queue")
> ---
>  drivers/misc/genwqe/card_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_de=
v.c
> index 55fc5b80e649..d58ce2622307 100644
> --- a/drivers/misc/genwqe/card_dev.c
> +++ b/drivers/misc/genwqe/card_dev.c
> @@ -867,7 +867,7 @@ static int ddcb_cmd_fixups(struct genwqe_file *cfile,=
 struct ddcb_requ *req)
>  =09struct genwqe_ddcb_cmd *cmd =3D &req->cmd;
>  =09struct dma_mapping *m;
> =20
> -=09for (i =3D 0, asiv_offs =3D 0x00; asiv_offs <=3D 0x58;
> +=09for (i =3D 0, asiv_offs =3D 0x00; asiv_offs < 0x58;
>  =09     i++, asiv_offs +=3D 0x08) {
> =20
>  =09=09u64 u_addr;
> --=20
> 2.25.1
>=20

Where is patch 1/2 of this series?
