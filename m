Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B756A13CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBWXaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBWXaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:30:22 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2CF570A6;
        Thu, 23 Feb 2023 15:30:17 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230223233014euoutp013432478f076d105e6ece38944117b873~Gl-q309ay2582325823euoutp01p;
        Thu, 23 Feb 2023 23:30:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230223233014euoutp013432478f076d105e6ece38944117b873~Gl-q309ay2582325823euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677195014;
        bh=0ywFQ8P6Yql+uODvbJGncexD+FxERSBDlno+uI0KNa4=;
        h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
        b=L+0QRHX/f7NerUlxl3v0VDda7TNret1wrbpyPdhj8GunMhH/bX+bbgGmCGUIpf+Ng
         d7lAHcvLrQgYwqJR11+Lh7Hx/ajb7MZB/TiCkpE8J/d2qv36LRIDmmlcOIt9ROuTw1
         lET/vmTFhaZT9ktlvWu5MvSzACwtku0jDI6Z1uLo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230223233014eucas1p1ac33a311fe3dbb50829efaf7a6f5e381~Gl-qrwCK71218212182eucas1p1r;
        Thu, 23 Feb 2023 23:30:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.2B.13597.507F7F36; Thu, 23
        Feb 2023 23:30:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230223233013eucas1p116af5ebe8e229aa6fc8636728b738156~Gl-pxyYks1218212182eucas1p1q;
        Thu, 23 Feb 2023 23:30:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230223233013eusmtrp1c0b7b90d66737e278cc697dd98be2b38~Gl-pxLWiV1896318963eusmtrp16;
        Thu, 23 Feb 2023 23:30:13 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-b0-63f7f7053143
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.98.02722.507F7F36; Thu, 23
        Feb 2023 23:30:13 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230223233012eusmtip1e887d824eabc8ed887ae97d3c5fdcef9~Gl-pmry2v0325803258eusmtip1L;
        Thu, 23 Feb 2023 23:30:12 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] merge_config.sh: do not report some differencess
 between input and output
In-Reply-To: <CAK7LNASjsRYyRCAy_EujsX1o2ybR3KUQRA2HuPxeN=ppUpBa_A@mail.gmail.com>
        (Masahiro Yamada's message of "Thu, 16 Feb 2023 21:17:24 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 24 Feb 2023 00:30:03 +0100
Message-ID: <dleftjzg946jus.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut91td6PZzzXppKUis+jhsiid9DKIsIReUFZktc3LLHXW5qPE
        yDTcsnyghjrtMWxpltNWmQ2LWqU9TC0NfJemVpaUD5TKNK9Xwf++853H953DIdmibI4jeVQd
        QWnU8lA3roAoq/xd48EdGVF6xj1DslFrOUtWb83jyoqft/FkHZ8aOb6En6XoPNcv5V4R8hu0
        OO9kHxCsC6JCj0ZRmhUbjgiCUxrWHB9dfjLxyzArDtU7JyE+CXg1nBu3cJOQgBThQgQv/2VN
        BUMIDMMfeUwwiCC3t5GYbun+aubRWIQLECS0eDH4K4JfT+2SEElysRSKi/fRtBgvhVaTnkPT
        bKyGru5Amp6LlZD6qGlyPB9nIogveYDohAP2gdGe/snxBHaH9BYak6QQe0NOgytNC7E9vMrp
        mnTDxmGQU/sD0SWA60jIdmJMbga9LnnK8FzorbrHY/ACeJNxkaBlAesmZBuMHCZIQzCoj2cx
        VWuhteYPl8Gb4HZtOYcRsIPGPntG1w7Sy7LYDC0EfaKIqZaAObViStcRknsLp6z5wYt2AXPM
        6wi6an6jNORqmLGNYcY2hsljLYES6wqGXgY3jN/ZDF4PZvNP4hriFKF5VKQ2TEVpV6mpaKlW
        HqaNVKukyvAwC5p4mDdjVUPlqKC3X2pDLBLZkGSiubP0Vh1yJNThaspNLLzEGlGKhEHyUzGU
        JvywJjKU0tqQE0m4zRMuW/9KKcIqeQQVQlHHKc10lkXyHeNYuuDbwSHp/u3q2PlNeySNIWPt
        WzgpA64en/syrnUuqlaVSW0u9Tnxb+/e9b3pLs7Y6it5PHZBkewZcNkj6HWHxcV93Jo963TG
        R//OnUU1Fat4zYFDp2GH4Vh84Qbjtj5V094LG0uHd+WdfWm802F6sgb/3WwymGzVXiM9rp0n
        +j/89Iod4J96Jiq5VeiTcP/QwFgT60r0/XJ7Knq3KV8QNVsh+bY/YfudnvEqcfOcvtkHz3Bb
        VsYYn4yHZAmtMihNDFIMXG0I5yf8EuszzfkBioOBn30Wesd4VaLdoT1kRb5/vWJv1CGdbrGg
        zdfhMT+y+9y7XOnlNNX7rTDcDA+dX7gR2mD5yqVsjVb+H96cHm6rAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7qs378nG7y4x2LxZ9cOJovLu+aw
        Waw9cpfd4uGDG6wOLB6bVnWyefRtWcXo8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5G3xXTgj86FW3PvzE1MF6W62Lk5JAQMJF4+mId
        excjF4eQwFJGiSmvPrJ0MXIAJaQkVs5Nh6gRlvhzrYsNouYZo8SSE6eYQGrYBPQk1q6NAKkR
        EdCSuLO0gxXEZhbIl/g37Qc7iC0skCzRv/cm2HxOgSmMEk3rtzOCJIQEAiSe3jzCBmKLClhK
        /Hn2EayBRUBVYtJtEJuDg1fAXGLmFQWQMK+AoMTJmU9YIOZnS3xd/Zx5AqPALCSpWUhSs4C6
        mQU0Jdbv0ocIa0ssW/iaGcK2lVi37j3LAkbWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIEx
        su3Yz807GOe9+qh3iJGJg/EQowpQ56MNqy8wSrHk5eelKonwTmX6nizEm5JYWZValB9fVJqT
        WnyI0RTog4nMUqLJ+cDozSuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi
        4JRqYFoc+Nq+rcr9z9mUEw22N09VHP8jLd694e7b35d5stq/t9ecDZX8zZ+VvKDvdcWb5oXL
        ip5c0VYL/K/yqGbeCv/m8DQviysmDZqusjJ3v5bqmLxItOwys/sdyX23WP8ov8ynW3E/vpjx
        OsoeXN0yS/7Esod8OWt+t1jIKvra7z0jzPvO8ZaM8uHM/v8cv3426Ndctr1TFmm09cGz0J6g
        v2Hs+f6dL5sV4zu3/J4sPOW6K+Ndi6fxdzLEchY4KsfqLzKItlqrPE9EtPl/uXGYxLe006dn
        Z4fHLSzVmmVRe+RSe6/u0ffxs+yEWDu11wvLx2wr+3/k6P8Jh973r/hamh9ydv+2hlD7w5d3
        X50roMRSnJFoqMVcVJwIAKgTBj8mAwAA
X-CMS-MailID: 20230223233013eucas1p116af5ebe8e229aa6fc8636728b738156
X-Msg-Generator: CA
X-RootMTR: 20230223233013eucas1p116af5ebe8e229aa6fc8636728b738156
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230223233013eucas1p116af5ebe8e229aa6fc8636728b738156
References: <CAK7LNASjsRYyRCAy_EujsX1o2ybR3KUQRA2HuPxeN=ppUpBa_A@mail.gmail.com>
        <CGME20230223233013eucas1p116af5ebe8e229aa6fc8636728b738156@eucas1p1.samsung.com>
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

It was <2023-02-16 czw 21:17>, when Masahiro Yamada wrote:
> On Wed, Feb 8, 2023 at 10:08 PM =C5=81ukasz Stelmach <l.stelmach@samsung.=
com> wrote:
>>
>> If an input config file contains CONFIG_FOO=3Dn the output one
>> will contain a line '# CONFIG_FOO is not set'. merge_config.sh
>> should not report it as difference because the end result of
>> CONFIG_FOO being disabled is achieved.
>>
>> Inexistence of CONFIG_FOO (because of unment dependencies) in case
>> CONFIG_FOO=3Dn is requested, should also be ignored.
>>
>> Change-Id: I129f3a0b4205a76d8c42020f8adb72b1889d75fb
>> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
>> ---
>> Changes in v2:
>> - suppress reports reports if an option was "not set" in input files
>>   but is missing from the filnal .config due to unmet dependecies.
>> - apply the same logic to suppress some reports during the merging
>>   phase
>>
>> BTW. Do you think adding "| sort -u" after "grep -w" to avoid reports
>> about repeated entries may make sense or do you want such reports to
>> be printed.
>>
>>  scripts/kconfig/merge_config.sh | 30 ++++++++++++++++++++----------
>>  1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_con=
fig.sh
>> index e5b46980c22a..1086bdc7abf2 100755
>> --- a/scripts/kconfig/merge_config.sh
>> +++ b/scripts/kconfig/merge_config.sh
>> @@ -144,12 +144,17 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
>>                         echo
>>                         BUILTIN_FLAG=3Dtrue
>>                 elif [ "x$PREV_VAL" !=3D "x$NEW_VAL" ] ; then
>> -                       echo Value of $CFG is redefined by fragment $ORI=
G_MERGE_FILE:
>> -                       echo Previous  value: $PREV_VAL
>> -                       echo New value:       $NEW_VAL
>> -                       echo
>> -                       if [ "$STRICT" =3D "true" ]; then
>> -                               STRICT_MODE_VIOLATED=3Dtrue
>> +                       if [ \( "x$PREV_VAL" !=3D "x$CFG=3Dn" -a \
>> +                               "x$PREV_VAL" !=3D "x# $CFG is not set" \=
) -o \
>> +                            \( "x$NEW_VAL" !=3D "x"  -a \
>
>
>
> In which case does $NEW_VAL become empty?

You are right, there is now such case.

> I think it is opposite.
> $PREV_VAL might be empty, $NEW_VAL may specified as =3Dn.

Let me try to determine when we would like to see complaints about
changes being made to config options


| PV\NV | y | m | n | n-s |
|-------+---+---+---+-----|
| y     | o | x | x | x   |
| m     | x | o | x | x   |
| n     | x | x | o | /   |
| n-s   | x | x | / | o   |
| empty | o | o | o | o   |

o - OK, don't rport
x - switched, report
/ - "n" and "not-set" are synonyms, don't report

This gives us the following conditions three conditions under which to repo=
rt value changes.

(PREV_VAL !=3D "") &&=20
(NEW_VAL !=3D PREV_VAL) &&=20
((PREV_VAL !=3D "n" && PREV_VAL !=3D "not-set") ||
 (NEW_VAL  !=3D "n" && NEw_VA L !=3D "not-set"))

Does it make sense?

>
>
>
>
>> +                               "x$NEW_VAL" !=3D "x# $CFG is not set" \)=
 ]; then
>> +                               echo Value of $CFG is redefined by fragm=
ent $ORIG_MERGE_FILE:
>> +                               echo Previous  value: $PREV_VAL
>> +                               echo New value:       $NEW_VAL
>> +                               echo
>> +                               if [ "$STRICT" =3D "true" ]; then
>> +                                       STRICT_MODE_VIOLATED=3Dtrue
>> +                               fi
>>                         fi
>>                 elif [ "$WARNREDUN" =3D "true" ]; then
>>                         echo Value of $CFG is redundant by fragment $ORI=
G_MERGE_FILE:
>> @@ -196,9 +201,14 @@ for CFG in $(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_=
CONFIG_EXP2" $TMP_FILE); do
>>         REQUESTED_VAL=3D$(grep -w -e "$CFG" $TMP_FILE)
>>         ACTUAL_VAL=3D$(grep -w -e "$CFG" "$KCONFIG_CONFIG" || true)
>>         if [ "x$REQUESTED_VAL" !=3D "x$ACTUAL_VAL" ] ; then
>> -               echo "Value requested for $CFG not in final .config"
>> -               echo "Requested value:  $REQUESTED_VAL"
>> -               echo "Actual value:     $ACTUAL_VAL"
>> -               echo ""
>> +               if [ \( "x$REQUESTED_VAL" !=3D "x$CFG=3Dn" -a \
>> +                       "x$REQUESTED_VAL" !=3D "x# $CFG is not set" \) -=
o \
>> +                    \( "x$ACTUAL_VAL" !=3D "x"  -a \
>> +                       "x$ACTUAL_VAL" !=3D "x# $CFG is not set" \) ]; t=
hen
>> +                       echo "Value requested for $CFG not in final .con=
fig"
>> +                       echo "Requested value:  $REQUESTED_VAL"
>> +                       echo "Actual value:     $ACTUAL_VAL"
>> +                       echo ""
>> +               fi
>>         fi
>>  done
>> --
>> 2.30.2
>>

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmP39vsACgkQsK4enJil
gBBsfgf9G/QGrR5+NFhRFZvXhR9O4ahwH3U0ZdLT081ElbmlfZbz9p5jyog7EOSH
2Og5kDoD3fvtFAE3jyMRY9UCvnU6BO7GmYawGf/iymMSmhnmbgpvZYOEHgXnQqhg
Dx6V9+VPWIlLw0PUF/SWaZ1M7yawaYayyakPvgedT3bobxKka1zRRw7hPtf31MqQ
wVEvj3mcj0h0g8D5qP/mJZoDxs3okFXkxj70fFPNsjBs9HTxSTa9/Eptl0qtyG/X
YKkyg+ene1IMgB65OjjeYFXYFwEV35jFR2Q6ThIP3iZa44bz4AtR+QF1UUGfHj8b
mFy4UV3hlj00Cz7ZoB+FuPH6klfQyw==
=As5Z
-----END PGP SIGNATURE-----
--=-=-=--
