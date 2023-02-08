Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7442768EC05
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjBHJsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjBHJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:48:44 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB03166C5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:48:40 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id g8so3994353vso.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2R7u1B9huXeTwYGwisMYMDWi/V1Cx5ZTUdTzwGn73I=;
        b=IlJKkkQ9DVJ9BBezrgLajWcjqtAfSLERWc6m3OhnttTI1TwpXXxv808qA2f9FPQ6Qn
         ASMvpSNr5IsbkhVmy1uwXFxpxv8FnZRXqTqaw8mepFxOQyLedixXKz2vUnfYOtVLTyum
         Hg010jv23W2pM0D0qOmpTvfSjsLHysu1y1+h6XM+0wmgASqc4d4ueEd+7aeSFYUXiHGW
         3G35lHVpFTg/BBaORqazWx+JZhNZR+NccEPuIdwqGL+cWQ/Y7gVdoOzrDVlhwWLsHXjY
         XyaxwRrwGK7vJV4kYT2QE6vfUWeRT+vir1bQFzuj0HCvwEa91lnsITZYVdr5vkj+1EW+
         SCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2R7u1B9huXeTwYGwisMYMDWi/V1Cx5ZTUdTzwGn73I=;
        b=XCJAEFacvWBp6KZaxobWjIHuEObitutfk8F+WuPiRqWbHxn+Cl0yRZffX9djazTv7J
         etcS6PVPQGlJV4UG12B/ZLYvieMZtl1DwreFfoVCmf29u/Su3O2sMWgiPt3J2s1mzNHB
         b7vOZ+71INLvr956+tQYJ6PBPdSByG1nPDTQ1BqsMHvh4y+5Vk7kjTebxOp2VPreM+ao
         IUhfAdJwihBKfbkmqvvj26yDVRZzgPpnNS3MI5lL7LWtitjKk3MYWRhpHjEANM/NaxTN
         4+mgiFxhNTIokp/cxJkq+x0P72szNOCQ3pyRM6ubqnX9M3FfIQYe5CxTPUTUCqANJflg
         JqTA==
X-Gm-Message-State: AO0yUKXZ/3nz75xWwGmiP5cG+MNupSTe2Kc1Pp2dN2Cbh+Z6g6xzpkuB
        hTTA+FWQ6tON3nUX3DzqdIpJMlwMPi2le/xrmg==
X-Google-Smtp-Source: AK7set/pXdbr9Oe43ar4h0PMJIlLqqmoltoo/jo/EMyJhAXrJY2SAjInemX2OyjtdW0XbktNH8ZWszgHnfIjDf7GPAQ=
X-Received: by 2002:a67:c286:0:b0:3f7:8e7b:4a5e with SMTP id
 k6-20020a67c286000000b003f78e7b4a5emr1806958vsj.7.1675849719643; Wed, 08 Feb
 2023 01:48:39 -0800 (PST)
MIME-Version: 1.0
Sender: mayawilfried2000@gmail.com
Received: by 2002:a59:dd01:0:b0:3a1:e6c3:5df5 with HTTP; Wed, 8 Feb 2023
 01:48:39 -0800 (PST)
From:   Sandrina Omaru <sandrina.omaru2022@gmail.com>
Date:   Wed, 8 Feb 2023 10:48:39 +0100
X-Google-Sender-Auth: Gknm0OnQ6iEmuXcrXQ92n4UYjZY
Message-ID: <CAFevH+7jcMLBL23qALJpb29XTvLDrVP3Fe_DgAHWpOMRxuicFg@mail.gmail.com>
Subject: Sveiciens jums,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sveiciens jums,

Es izsaku to dzi=C4=BC=C4=81 cie=C5=86=C4=81 un pazem=C4=ABg=C4=81 padev=C4=
=ABb=C4=81. Es l=C5=ABdzu izteikt da=C5=BEas
turpm=C4=81k=C4=81s rindi=C5=86as j=C5=ABsu laipnai izskat=C4=AB=C5=A1anai.=
 Es ceru, ka j=C5=ABs velt=C4=ABsit
da=C5=BEas v=C4=93rt=C4=ABg=C4=81s min=C5=ABtes, lai ar l=C4=ABdzj=C5=ABt=
=C4=ABbu izlas=C4=ABtu =C5=A1o aicin=C4=81jumu. Man
j=C4=81atz=C4=ABst, ka ar liel=C4=81m cer=C4=ABb=C4=81m, prieku un entuzias=
mu rakstu jums =C5=A1o
e-pasta zi=C5=86ojumu, kuru zinu un tic=C4=ABb=C4=81 ticu, ka tam noteikti =
j=C4=81atrod
j=C5=ABsu vesel=C4=ABba.

Es esmu Sandrina Omaru jaunkundze, nelai=C4=B7a Viljamsa Omaru meita. Pirms
mana t=C4=93va n=C4=81ves vi=C5=86=C5=A1 man piezvan=C4=ABja un inform=C4=
=93ja, ka vi=C5=86am ir tr=C4=ABs
miljoni se=C5=A1simt t=C5=ABksto=C5=A1u eiro. (3=C2=A0600=C2=A0000,00 eiro)=
 vi=C5=86=C5=A1 noguld=C4=ABja
priv=C4=81t=C4=81 banka =C5=A1eit, Abid=C5=BEanas Kotdivu=C4=81r=C4=81.

Vi=C5=86=C5=A1 man teica, ka noguld=C4=ABjis naudu uz mana v=C4=81rda, k=C4=
=81 ar=C4=AB iedeva visus
nepiecie=C5=A1amos juridiskos dokumentus par =C5=A1o noguld=C4=ABjumu bank=
=C4=81, esmu
bakalaura un =C4=ABsti nezinu, ko dar=C4=ABt. Tagad es v=C4=93los god=C4=AB=
gu un DIEVA
baido=C5=A1u partneri =C4=81rzem=C4=93s, kuram ar vi=C5=86a pal=C4=ABdz=C4=
=ABbu var=C4=93tu p=C4=81rskait=C4=ABt =C5=A1o
naudu un p=C4=93c dar=C4=ABjuma es atbrauk=C5=A1u un past=C4=81v=C4=ABgi dz=
=C4=ABvo=C5=A1u j=C5=ABsu valst=C4=AB
l=C4=ABdz tikm=C4=93r, ka man b=C5=ABs =C4=93rti atgriezties m=C4=81j=C4=81=
s, ja es to dar=C4=AB=C5=A1u.
v=C4=93lme. Tas ir t=C4=81p=C4=93c, ka =C5=A1eit, Kotdivu=C4=81ras krast=C4=
=81, nemit=C4=ABg=C4=81s politisk=C4=81s
kr=C4=ABzes d=C4=93=C4=BC esmu daudz cietis.

L=C5=ABdzu, apsveriet to un sazinieties ar mani p=C4=93c iesp=C4=93jas =C4=
=81tr=C4=81k.
Nekav=C4=93joties apstiprin=C4=81=C5=A1u j=C5=ABsu v=C4=93lmi, nos=C5=ABt=
=C4=AB=C5=A1u jums savu att=C4=93lu, k=C4=81
ar=C4=AB inform=C4=93=C5=A1u s=C4=ABk=C4=81ku inform=C4=81ciju par =C5=A1o =
lietu.

Ar cie=C5=86u,
Sandrina Omaru jaunkundze
