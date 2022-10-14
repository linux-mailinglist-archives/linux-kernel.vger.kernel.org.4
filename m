Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA25FF40C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiJNTVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiJNTU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:20:57 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112C11C6F6;
        Fri, 14 Oct 2022 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665775245;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=3oVx/XxSaraEYgXxlTdKz4mv75fSpJE+2vW+gdrQpsU=;
    b=HBC5oLym4tU2JiQcHQd/y0tfjGyZp9vv6KQMkZY2Zj/RuNRLYW2N6xXCvPc7fnNeWN
    Iofry4AW9BKD2emTUzZyyWnqK44LIGdXMRXlyUChqMN8lAGFgmfnuy6f/+O2UxsKuk80
    QssjEcD6qLAtqvZMObFjvwlB82EK76Qq69MSmHJmChfBNYOjksHlD08uD6ev8DhTooug
    XPLextbtoDqg+gpfdOBPh9NbXp/TQTP+Mh4IVLrHgGT+J9PWcg1q//g6qp8DPjQ4OE7Q
    etBeKXoUEQl81o2Ez/5zkZmb+W+XiZvK+7/Nzgfxi3NtFzu1xU1huO7cnOY3SZfg9phi
    FheQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05IioW1izutXbo2gMUkZ35"
X-RZG-CLASS-ID: mo00
Received: from [192.168.3.3]
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id zad98cy9EJKiLdV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 14 Oct 2022 21:20:44 +0200 (CEST)
Message-ID: <d06a264c4544a23ccccd016c6797d889db526b64.camel@iokpp.de>
Subject: Re: [PATCH v2 1/2] scsi: ufs: core: Remove unnecessary if statement
From:   Bean Huo <beanhuo@iokpp.de>
To:     Bart Van Assche <bvanassche@acm.org>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 14 Oct 2022 21:20:44 +0200
In-Reply-To: <a1cd6719-a743-fc96-e0e7-364a52b62952@acm.org>
References: <20221010092937.520013-1-beanhuo@iokpp.de>
         <20221010092937.520013-2-beanhuo@iokpp.de>
         <a1cd6719-a743-fc96-e0e7-364a52b62952@acm.org>
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

On Fri, 2022-10-14 at 11:37 -0700, Bart Van Assche wrote:
> > @@ -300,9 +300,6 @@ static inline bool
> > ufs_is_valid_unit_desc_lun(struct ufs_dev_info *dev_info,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err("Max General LU supported by UFS isn't
> > initialized\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return false;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* WB is available only for =
the logical unit from 0 to 7 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (param_offset =3D=3D UNIT=
_DESC_PARAM_WB_BUF_ALLOC_UNITS)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return lun < UFS_UPIU_MAX_WB_LUN_ID;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return lun =3D=3D UFS_U=
PIU_RPMB_WLUN || (lun < dev_info-
> > >max_lu_supported);
> > =C2=A0=C2=A0 }
>=20
> Hi Bean,
>=20
> I think the above patch reintroduces the stack overflow issue fixed
> by
> commit a2fca52ee640 ("scsi: ufs: WB is only available on LUN #0 to
> #7").
>=20
> How about reverting commit a2fca52ee640 and fixing the stack overflow
> issue in another way than by modifying ufs_is_valid_unit_desc_lun()?
>=20
> Thanks,
>=20
> Bart

Hi Bart,=20

I knew that fix, it was because the user tried to poll
dLUNumWriteBoosterBufferAllocUnits from RPMB LU, as you know, RPMB
doesn't support WB, but the root cause is that we don't separate normal
logical unit descriptors and RPMB unit descriptor when we create sysfs
group,


in ufshcd_driver_template {

...
.sdev_groups =3D ufshcd_driver_groups,

}



ufshcd_driver_groups {
...
&ufs_sysfs_unit_descriptor_group,
...
}


so all the logical units will have the unified unit descriptor sysfs
node. This is wrong. =20

Another problem is that Boot and device LU don't have unit descriptors,
but we still create a unit descriptor sysfs node group for boot and
device LU.

I am working on the Advanced RPMB, and trying to seperate normal unit
descriptor and RPMB unit descriptor, will let you know if it is
possible. or if you know the solution, please let me know, thanks.


Kind regards,
Bean

