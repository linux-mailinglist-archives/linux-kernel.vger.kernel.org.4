Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE72660BB77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiJXVBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiJXVBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:01:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E66FA33;
        Mon, 24 Oct 2022 12:07:05 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OIhxjL013482;
        Mon, 24 Oct 2022 18:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version; s=pp1; bh=IzJ7jg6e3PsQHKVoduFzkG/km7Wk0osi8XmusOE2sXA=;
 b=nzL8f6khTCzPknLo8CVeewd0NK1kxuz8CG0FQWxXYl5bzwBEWmvUT4EcqfQlUCtvi2BB
 PF3gIIhzJfabnEUjD5mGo5kJ+sGlWG0cgMDOgUjCncy53tn9D4OLL9YgqQIPIT4HWnDN
 DSIYGAw+0WfdBHGhmDP3D9/x6IO24vT2omVw3laBmf5aoqHGsUJNzfTk4o4p/evWDTDe
 oz+zLgwPVRq2rRCgZwSGO6vCd0ZZm4690L4nlc3u5UE2qGD+fItmYvV3a5wRfJpWr7JD
 xr+mbp9g8hh37VaVSSFyOxe67KmI+7kxeclbrRy3h1vC0oEz7abxs0gz13LPs9+7L0dd mA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ke08186ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 18:50:32 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29OIZdMR010259;
        Mon, 24 Oct 2022 18:50:32 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3kc859smrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 18:50:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29OIoTeg852552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 18:50:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8FFC7805E;
        Mon, 24 Oct 2022 19:33:28 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0F9D7805C;
        Mon, 24 Oct 2022 19:33:26 +0000 (GMT)
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [9.163.14.162])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Oct 2022 19:33:26 +0000 (GMT)
Message-ID: <aa9ebdef1f1dbfceb5a32f5f437b865861976957.camel@linux.ibm.com>
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Juergen Gross <jgross@suse.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
Date:   Mon, 24 Oct 2022 14:50:26 -0400
In-Reply-To: <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
         <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
         <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
         <016732f4-d129-69bb-4b5f-82198407ee5e@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OsMKRDmTTv0MyMAb4mqc"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EFS9Q0lFOaGkRL_FiH7rYr8o07kVNk6r
X-Proofpoint-ORIG-GUID: EFS9Q0lFOaGkRL_FiH7rYr8o07kVNk6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OsMKRDmTTv0MyMAb4mqc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2022-10-24 at 14:55 +0200, Juergen Gross wrote:
[...]
> Please recheck the backported patch in 5.10.y. It is _wrong_. The
> backport
> has:
>=20
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -2993,7 +2993,7 @@ _base_config_dma_addressing(struct
> MPT3SAS_ADAPTER *ioc,=20
> struct pci_dev *pdev)
>=20
>          if (ioc->is_mcpu_endpoint ||
>              sizeof(dma_addr_t) =3D=3D 4 || ioc->use_32bit_dma ||
> -           dma_get_required_mask(&pdev->dev) <=3D 32)
> +           dma_get_required_mask(&pdev->dev) <=3D DMA_BIT_MASK(32))
>                  ioc->dma_mask =3D 32;
>          /* Set 63 bit DMA mask for all SAS3 and SAS35 controllers */
>          else if (ioc->hba_mpi_version_belonged > MPI2_VERSION)
>=20
> While the upstream patch has:
>=20
> +       if (ioc->is_mcpu_endpoint || sizeof(dma_addr_t) =3D=3D 4 ||
> +           dma_get_required_mask(&pdev->dev) <=3D 32) {
>                  ioc->dma_mask =3D 32;
> +               coherent_dma_mask =3D dma_mask =3D DMA_BIT_MASK(32);
>=20

That's not the upstream commit.  The quoted upstream patch in the
stable commit is:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De0e0747de0ea3dd87cdbb0393311e17471a9baf1

Which has the same diff as you quoted for the stable tree.

James


--=-OsMKRDmTTv0MyMAb4mqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABMIAB0WIQTnYEDbdso9F2cI+arnQslM7pishQUCY1becgAKCRDnQslM7pis
hSQsAQCC7A2xVu85X8YkyFbTrfUGtyIwNToEhWGfvxT9jzz20QD+JhzALYu83cJ2
RUsBjRW335CWiHkcm1rQRKHqXvW0RsM=
=vyiC
-----END PGP SIGNATURE-----

--=-OsMKRDmTTv0MyMAb4mqc--

