Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4C6A0363
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjBWHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWHui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:50:38 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE04AFC2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:50:37 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230223075036euoutp021c4c13a4bc07b9ebff857ce6912e59a8~GZLQpC3z61802818028euoutp02b;
        Thu, 23 Feb 2023 07:50:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230223075036euoutp021c4c13a4bc07b9ebff857ce6912e59a8~GZLQpC3z61802818028euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677138636;
        bh=GFAZ/3IuE6eIIcn01fkSuz8JSlgQCo7Nso4cDg9+cgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dT52E8+my4by4vXXG95Ynz5tNYQ6JS1GJzC3vH8akNRh9mn2RY7xjjdmGtQDeJ0iy
         KNu8DS+c0rMxYlFsCcZ6M7UlMqbo8/8aeP9x5eFoDN9w0IcEkRFJ6bmNKBNw6XHoyU
         D7DjI3yCLG7eXFiiZAPaZRcPwIhlsHXZGtUDT2wk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230223075035eucas1p21b3a07e8438962f3d49818f4ae8d35a7~GZLQY_xwD1526815268eucas1p2n;
        Thu, 23 Feb 2023 07:50:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4F.C4.61197.BCA17F36; Thu, 23
        Feb 2023 07:50:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230223075035eucas1p15a1c5f534f932b2b36510a39f6921d99~GZLP_rvFy2599225992eucas1p17;
        Thu, 23 Feb 2023 07:50:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230223075035eusmtrp1166f53104f454cd5dd4e63588e215c12~GZLP95CcW2270422704eusmtrp14;
        Thu, 23 Feb 2023 07:50:35 +0000 (GMT)
X-AuditID: cbfec7f5-7dbff7000000ef0d-2a-63f71acbf4b9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.DD.00518.BCA17F36; Thu, 23
        Feb 2023 07:50:35 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230223075035eusmtip1584df142059fb8dda2a16a0f8c916d88~GZLPyubwT2175921759eusmtip18;
        Thu, 23 Feb 2023 07:50:35 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP EliteDesk 800 G6
 Tower PC
Date:   Thu, 23 Feb 2023 08:50:34 +0100
In-Reply-To: <20230223074749.1026060-1-l.stelmach@samsung.com>
        (=?utf-8?Q?=22=C5=81ukasz?= Stelmach"'s message of "Thu, 23 Feb 2023
        08:47:48 +0100")
Message-ID: <dleftj8rgo95x1.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87qnpb4nGxw9bmhx5eIhJovLu+aw
        Waw9cpfdonNXP6vFhu9rGR1YPTZ8bmLz2Pd2GZtH35ZVjB7rt1xl8fi8SS6ANYrLJiU1J7Ms
        tUjfLoEr49nNWywFbwUqbizbwNrA+Jmvi5GDQ0LARKJxj3oXIxeHkMAKRollU+YyQThfGCUu
        z7/ACOF8ZpS49OkeaxcjJ1jHzp3XwWwhgeWMEp9X80EUvWCU+P9oGivIWDYBPYm1ayNAakQE
        VCSeTp/CDlLDLNDPKPFpTQMLSEJYIERi6b9DbCA2i4CqxMUDHawgRZwCMxgl9j8HuYODg1fA
        XGLV9gKQGlEBS4k/zz6yg9i8AoISJ2c+AZvDLJArMfP8G7BLJQQ+cEhMu3KTGeJSF4nrJ+ay
        Q9jCEq+Ob4GyZSROT+5hgWhoZ5RourKQFcKZAPRORxMTRJW1xJ1zv9ggbEeJPYevs0JCjE/i
        xltBiM18EpO2TWeGCPNKdLQJQVSrSKzr38MCYUtJ9L5awQhhe0hcuXWADRJaExklVs/ezT6B
        UWEWkodmIXloFtBYZgFNifW79CHC2hLLFr5mhrBtJdate8+ygJF1FaN4amlxbnpqsXFearle
        cWJucWleul5yfu4mRmAqOv3v+NcdjCtefdQ7xMjEwXiIUQWo+dGG1RcYpVjy8vNSlUR4pzJ9
        TxbiTUmsrEotyo8vKs1JLT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXApHdtzfyi
        Lbq9/9rvrCx+MXvfnbasY59K9Tb3B/y2Cv6/Z0uVhcJxCd5GjW97JnvF1UU43WJ//0v6uGxm
        /x2TsH4prdr7PBUrTrivNFshHV/gqCkyXTDY7tTc8AmXH8df6bTb/GbqS/9JEQVB2ZOfSS7+
        xu9udcP3QtPsmtqzSWo39goKXmxxb+ny9rR/buKvtTym0vXHtX3fEqfF6spdjWaRYHGrrk06
        vNldK+zpy12tLWy7A34tW2N1h92WWb63iCn9d9ydya+m2E8/tMXiatKvG59jmj5+a5qZ0sLh
        tKrE+ledlOja5V1px258LL7jyHak8sQWYeXFe/YvV/+z4V3AMjfpLb/VAlgc5ZJrlViKMxIN
        tZiLihMBemoGacADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7qnpb4nG0z5IG5x5eIhJovLu+aw
        Waw9cpfdonNXP6vFhu9rGR1YPTZ8bmLz2Pd2GZtH35ZVjB7rt1xl8fi8SS6ANUrPpii/tCRV
        ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv49nNWywFbwUqbizb
        wNrA+Jmvi5GTQ0LARGLnzuusXYxcHEICSxkl3nceZuli5ABKSEmsnJsOUSMs8edaFxtEzTNG
        iT0HbrCD1LAJ6EmsXRsBUiMioCLxdPoUdpAaZoEJjBJn5+5kAUkIC4RILP13iA3EFhKwlehd
        sQ0sziKgKnHxQAfYYk6BGYwSv//MYQQZyitgLrFqewFIjaiApcSfZx/ZQWxeAUGJkzOfgPUy
        C2RLfF39nHkCo8AsJKlZSFKzgCYxC2hKrN+lDxHWlli28DUzhG0rsW7de5YFjKyrGEVSS4tz
        03OLjfSKE3OLS/PS9ZLzczcxAqNo27GfW3Ywrnz1Ue8QIxMH4yFGFaDORxtWX2CUYsnLz0tV
        EuGdyvQ9WYg3JbGyKrUoP76oNCe1+BCjKdBrE5mlRJPzgfGdVxJvaGZgamhiZmlgamlmrCTO
        61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAFL/Gy++J3fp2lRtbQ1gKJzbZ8T3kyRGKfhLsV/Fg
        l++Vukq77UHzIw70HPx83/xO42KNkKV1l54vL7Q1P1D4WGOF4uZ80Xt7OnevXM+z5p6NzwT3
        Cb2mHiu2ThCf5iU480Xs8n0LZxjsviJxsC5mru5yblXLRPNIkZINv/6VC61beS/we7LzgtnZ
        PyVOvmHp/RJR12j58PQh30aZrasec4rm8mx7v3R33on46Sdlbh9O+/R3nlCg4k7WuoUVE77M
        vlW1orz4VoR4iX9HWIXkyQ3auQcfrI5TP2P7d8Kdoy3iysxJhfkLz9ptmrdu0yHt/mKuk1zH
        N9zxd5p2pqNtSfWcr9sWWqQ/rNwWxbnd8LcSS3FGoqEWc1FxIgD9MQUjNwMAAA==
X-CMS-MailID: 20230223075035eucas1p15a1c5f534f932b2b36510a39f6921d99
X-Msg-Generator: CA
X-RootMTR: 20230223075035eucas1p15a1c5f534f932b2b36510a39f6921d99
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230223075035eucas1p15a1c5f534f932b2b36510a39f6921d99
References: <20230223074749.1026060-1-l.stelmach@samsung.com>
        <CGME20230223075035eucas1p15a1c5f534f932b2b36510a39f6921d99@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2023-02-23 czw 08:47>, when =C5=81ukasz Stelmach wrote:
> HP EliteDesk 800 G6 Tower PC (103c:870c) requires a quirk for enabling
> headset-mic.
>
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D217008

> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
>
> Verified by
>
>  echo 0x19 0x01a1913c > /sys/class/sound/card0/device/sound/card0/hwC0D0/=
user_pin_configs
>  echo 1 > /sys/class/sound/card0/device/sound/card0/hwC0D0/reconfig=20
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 6fab7c8fc19a..ac196db573e4 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -11599,6 +11599,7 @@ static const struct snd_pci_quirk alc662_fixup_tb=
l[] =3D {
>  	SND_PCI_QUIRK(0x1028, 0x0698, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE=
),
>  	SND_PCI_QUIRK(0x1028, 0x069f, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE=
),
>  	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
> +	SND_PCI_QUIRK(0x103c, 0x870c, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
>  	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
>  	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
>  	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_=
MIC2),

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmP3GsoACgkQsK4enJil
gBAVUQgAhBKTIp6oQqMufqdLTmtjA0NB91AuBWEE2y3LEdBWepSoM56Uz10fXeEI
7AHhPcKM6pWMrjQmchakdCQH1JcOeZFGyuTG3oHZLngDYtB2LM1wUjIWVD4ceLRB
TnfEiiH8BgzA55xe+67KxQrXLJuzIj9GTEJUrwoD4tuv2r2anuhGbCCX+Z65zz6H
fmc6HZ/EYgxLph4lFq2Qj+YCcpvS4IPvNGLJ/gilcZFX70cBobRUa+kjco+8Di18
WWLpXqH5/ht7BQS40CJwXzCH3Cnzi4d0Y127eDH3e+3v5fvW5YMTqJmuIhkdR3+D
srlpcQKDFnnzgpp/r9aLqfLgSfe6EQ==
=00pt
-----END PGP SIGNATURE-----
--=-=-=--
