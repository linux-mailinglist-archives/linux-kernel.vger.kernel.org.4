Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66565FAF88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJKJjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJKJjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:39:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB6FD48;
        Tue, 11 Oct 2022 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665481171;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=J8kcX+8LtEukoC4B1GeHkHmsTDqtm+m/Kn2u/N8i2bw=;
    b=sPXhS+iFXOWYip5w4nkcUSkJiZqYFUhrS3Pua6NlIsgjZ2wKRlpr+/i7NUMJyCVoOf
    alY8c0Zu1ZvNxkcfEkHJvsNHrg1Xn6CA66tg5+r3WVq2inwOFrHo3uVqMgqjWBqQ7hUN
    ck8nen0t6xk0grf1NBLCBATow2t2K8XPkefpAfEt2pJIALeIVI6Q3TaELkj9LYOifNke
    29ZO6ggqhPBGynJ7shmCwg9IJAB/xfugzHZTqlrR0IPPqnWebmzm0qqnjLK+SIlW1rdq
    tdJMYY0/IfVSsOqJ6GyYlapacfrOsImy6nUD/EhedTsBByfICQMLdWkBs9jZq7FUSYcG
    ecGg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyILymw8y23V5/v2HsOC"
X-RZG-CLASS-ID: mo00
Received: from [192.168.33.110]
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id zad98cy9B9dT58G
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 Oct 2022 11:39:29 +0200 (CEST)
Message-ID: <bdd72ef290b3c9d5492255358686a39a7aa3cde6.camel@iokpp.de>
Subject: Re: [PATCH v2 1/2] scsi: ufs: core: Remove unnecessary if statement
From:   Bean Huo <beanhuo@iokpp.de>
To:     daejun7.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Oct 2022 11:39:27 +0200
In-Reply-To: <20221011022153epcms2p1fcbf889099bd74279ed0d9b51ff26c1b@epcms2p1>
References: <20221010092937.520013-2-beanhuo@iokpp.de>
         <20221010092937.520013-1-beanhuo@iokpp.de>
         <CGME20221010093042epcas2p2462d3c50d81d613574332e3f39d971e1@epcms2p1>
         <20221011022153epcms2p1fcbf889099bd74279ed0d9b51ff26c1b@epcms2p1>
Organization: IOKPP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-11 at 11:21 +0900, Daejun Park wrote:
> Hi Bean=C2=A0Huo,
>=20
> I think ufs_is_valid_unit_desc_lun() is also used for
> wb_buf_alloc_units_show() in ufs-sysfs.c.
> So just removing this if-checkup=C2=A0will make different result when
> check lun value.
>=20

Hi Daejun,

Thanks for your review on the patch. Yes, I understood what you mean.
But I don't think that's the problem. Without this patch, access on
sysfs node "wb_shared_alloc_units" would get "invalid argument", while
with this patch sysfs would return 00. According to the UFS
specification:

"If this value is =E2=80=980=E2=80=99, then the WriteBooster is not support=
ed for this
LU. The Logical unit among LU0 ~ LU7 can be configured for WriteBooster
Buffer. Otherwise, whole WriteBooster Buffer configuration in this
device is invalid."

Per my understanding,  with this patch,  there is still no miss-
explanation of this sysfs node. The key purpose of this patch is to
remove any nonsense logical during the booting stage.

please have a think my comments. thanks.


Kind regards,
Bean


> Thanks,
> Daejun
>=20
> > From:=C2=A0Bean=C2=A0Huo=C2=A0<beanhuo@micron.com>
> >=20
> > LUs=C2=A0with=C2=A0WB=C2=A0potential=C2=A0support=C2=A0are=C2=A0properl=
y=C2=A0checked=C2=A0in=C2=A0ufshcd_wb_pro
> > be()
> > before=C2=A0calling=C2=A0ufshcd_read_unit_desc_param(),=C2=A0so=C2=A0re=
move=C2=A0this=C2=A0unnece
> > ssary
> > if-
> > checkup=C2=A0in=C2=A0ufs_is_valid_unit_desc_lun()=C2=A0to=C2=A0match=C2=
=A0its=C2=A0function=C2=A0defin
> > ition.

