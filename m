Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75C267B129
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjAYL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjAYL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:28:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25C22A18;
        Wed, 25 Jan 2023 03:28:02 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PBLh3n018188;
        Wed, 25 Jan 2023 11:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=bwgT6XPQgYZu6KY4CkDGcfvOTvOwgDdvEnGUhKGi29Y=;
 b=E+PvCZPmcKNegHksMQoNu0bPk802LHtS9YvNBPyM7UDdeEaHKfGXfbAcsaq2VUT7H6kO
 ost8wqtXEvJ8JVYSl+8kVeKpEgIPpFq9Gxl/ZdavCqPIRsoIPQGwtLou4gb3+Mk2Gllw
 kqYHlZvPFRmqG72vm7mElS8j4jCefdOlbaXsYuDyEEF9TqXFdioO/d+3Kemy4G2bRhJv
 jJ7sjeqYPNBeCKYwD1xdgDciJ2hzO75ovw5cRlrwBLVQN4vRbq1J3OpXUj7EZ/WVifnv
 uQtfiMK5fIh71aQwD1t9j1EUklrFfF8K5uDZDNYgRS/1vzNXyeJa0diBU3bbgkd3i4Ki Yg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najqa9mfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 11:27:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1bOfuJv2S3vBkcbnoI/LNbWkSrfq4nDyJ0MOvI8EibQhjWvJd4flY8I6BEGEaMpvt4w5Rmg8qs2MYVEvevl/zgdsawW3opXTu3DG1+jbOj+Rxlm5DD006YsMRUY6KjHIeKpJlLFo+rf3J7kTS+PbJH6D30bsTDsbPzs3Aft9BdGK+aJM7Q/j31G9fwhHB93KI4o7VDqtAEVu0tsHFbF2tTWDCdcDyt3iiZKr87LAwY1q5PeP7e8msCmeCxD0bOsqK3JSWARsH4QQYmEBbPNkyTQFL+MQwxdWKTbsVel24WF6NWFqe8gpImuANP5jdlC87EYEihavgLHdNN8K3PCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwgT6XPQgYZu6KY4CkDGcfvOTvOwgDdvEnGUhKGi29Y=;
 b=AIRfwibnpoE26QYr8SlydbRYqaCH2fXV8jYcEiGfuyfvXGbRix8VN/ovir4FTQN+KDADj9d2B40x3KfW3ROoJeu8DytKVXCjrxBbYY2zry7fUwqr6mOpX3dqT56eIJnWEBfn8rfmJ9iIxgGFuf0oEsymJITOM93mvolsg+hUNRv7Dg0M7RWEN541NegqD6+cHXL7bx0JTCLfE/DahPAf7qo4Cja9NYt0mekriFdOvzPU6AnyOvG2c/oHPqxqfdfOF4dgxUDif8w7zUq71vCY6SXetboclVxFemmFiruf+/i9iwM/moqAMzZiDojZImx/4sl57V0D2E3Wf9LHQCXpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from PH0PR02MB7431.namprd02.prod.outlook.com (2603:10b6:510:1b::8)
 by CO6PR02MB8770.namprd02.prod.outlook.com (2603:10b6:303:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 11:27:50 +0000
Received: from PH0PR02MB7431.namprd02.prod.outlook.com
 ([fe80::e310:5630:2a7a:d34]) by PH0PR02MB7431.namprd02.prod.outlook.com
 ([fe80::e310:5630:2a7a:d34%4]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 11:27:50 +0000
From:   Viken Dadhaniya <vdadhani@qti.qualcomm.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Viken Dadhaniya (QUIC)" <quic_vdadhani@quicinc.com>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        "Visweswara Tanuku (QUIC)" <quic_vtanuku@quicinc.com>,
        "Aniket RANDIVE (QUIC)" <quic_arandive@quicinc.com>
Subject: RE: [PATCH V1 1/1] Serial: core: Add compat ioctl support
Thread-Topic: [PATCH V1 1/1] Serial: core: Add compat ioctl support
Thread-Index: AQHZFcDUjAE2vAPamEOfh2X1BnVfYK55ZsmAgDXMZ6A=
Date:   Wed, 25 Jan 2023 11:27:49 +0000
Message-ID: <PH0PR02MB7431B1CA343760B422D34B97EBCE9@PH0PR02MB7431.namprd02.prod.outlook.com>
References: <20221222044925.27846-1-quic_vdadhani@quicinc.com>
 <Y6Pv5WWtM63DwCAl@kroah.com>
In-Reply-To: <Y6Pv5WWtM63DwCAl@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB7431:EE_|CO6PR02MB8770:EE_
x-ms-office365-filtering-correlation-id: a862fe81-b841-439d-6040-08dafec730e5
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gNlbuE5cJlz8KUgl6Tqsy6ELkBXbOCgNAhBXCBT8K4JLtW1FdMFoja3wgo3uMsXqvghmky8lgp3sLHgj/9ROFAN5XhJ+AgenEM5nZCHxP7grgP/WP4YUr+SM1rLJgDB7H0jcVbOolkLOQBPISsEIhLUSlg6ymN6iRTv4/z8PvLQfAXeLDSbI7jKJ9E6oVrHKQbSPgNqms8ktQ8FaLckxX38XZSfikw2RtB9JN2pQvPOU+/ob8Csiz7QmrmG+YlD4Mj0UaCB8ScvEmtEiuHvtv9CpPdNt4fUijiY7Wc6KQwuxtqZmVFLHvUvq4bmnhSHE3+/efawaaDLSPomj42u+HvNjD5Hze6wQwN0QmoZq85Lg6G7LY3QTp/wJg6TRMQXScGUT+oQtZJkw/4WwFZyIv0wTQo5vQbUZlg50Opp2Ll8F11onuUF1WXWdwQspnMk086Ed4VDs7qJjwSAaQJRAdBd84yaI7a3CJIB4cc5SlZos7f3Y+OVh9YJ6QawcdVR+DdK8ZUqqLxOhrw5NktnqVOproVLP53Ecxp5YKt6cbivOX9kNiIEce3U9SWJrSp27abnSfckSz8ls8Lu6NxHQ2parFpxwR+qL26CufETNs/+75oZBcGvkzMCLfz8cKr1cSxOPQ3YhgBB6GArF+oou04e+pdf8SGOP16wRJxbUn7k+akEB4EqfFxAGP/hzrpDjGbJiEYjkaPyyJz40n3AZ+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7431.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199018)(316002)(55016003)(38070700005)(33656002)(86362001)(64756008)(110136005)(2906002)(5660300002)(38100700002)(52536014)(8936002)(4326008)(83380400001)(8676002)(41300700001)(478600001)(66556008)(76116006)(26005)(9686003)(54906003)(6506007)(122000001)(186003)(66476007)(107886003)(66946007)(66446008)(71200400001)(7696005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AQCP7MhCbNyEpp/Q/BL5KPbAKgtUI+hx1GFbJkKCDfnZ6zIR088Fqu9IN5Ss?=
 =?us-ascii?Q?7XVD0Rw+GlDZi5yRspEfhqtlgWo5Chulq2DrQDEbHix0Ra84OZ9pjF3mzo8p?=
 =?us-ascii?Q?ujcJ/QldMKIWrs7sb1zjuFD158k5P9lzuoHrDEm6uQZaPCrzkgiUC3akris4?=
 =?us-ascii?Q?vNjVS1sJ8wCLwYErEszzRh2vnyHh/Fdrlc7hQnGhPH/JF5Sd3XauLArf0h8f?=
 =?us-ascii?Q?jVTcTYW1W2dBZXd5GOL55ojmY4kFHEp4rKGKoKOOHgWRRuNjo8scpFCZ/Ln8?=
 =?us-ascii?Q?1uesypW2lqnEVHuSmGS6tmsDbExE64rFbVgmZJwIELrEr7eqarWEjxgJ2+ob?=
 =?us-ascii?Q?kia60WpoXACvkikr/LwRNelaj90gs+DrcNZB+Xr+o7ncwm8piG9cFQUJs1+V?=
 =?us-ascii?Q?UrbzfMzdOVw7AEdINcGNqlQ2zzsd4xP65ETlbONcTZZsRu5N0KO33uR8GaRF?=
 =?us-ascii?Q?fXO+8XAHPMKoHYNQ5vRZeFZ5I1+GEiB7fMWcwZSO7k1PMyMLYdQOWjQgQm+d?=
 =?us-ascii?Q?wnKQs/eawLbgXA7udv/77Gdpw0YEe97iAj4lWCY1X4Vlvopkjy5qAdBC0B9m?=
 =?us-ascii?Q?bsAbE1exU+FWy4qYfPmc7arp1rXgLU4bJOdOugrPTnUytYWroytl0L0sVXCB?=
 =?us-ascii?Q?yXzcipfWAHoDQGYTSKE8k2EWx8nn3MTMEcfxeyC6FB1eTbxXTfDubG/z3QMi?=
 =?us-ascii?Q?h0C8OX8nkqhMm+4L24J0a3uC+vpkRNqk0ijLhwVQY7nkaGDtSddx9wa/akJv?=
 =?us-ascii?Q?Iw9fi2ycr0KgF08aIQdUxZZdZ+pSh10V8gAZsx5nyoNqwTEQZ+dyKYEI/FWY?=
 =?us-ascii?Q?YhIsfK6SXc1/aW5KM/VgERvl/177mPJFYsoG1ea7wMqwcg/FVhIhLeEM0nfn?=
 =?us-ascii?Q?UM8gx/Jj+C7CCbbZJXw19duhozJjxF3Ij4TsFXOXdfZ15za4+CmsjQoDpkWG?=
 =?us-ascii?Q?RJWJAk9QCayjXU/+8oSZ/CzWXVU+hVLX9EFdSSeZtKJ7qWoex6Po1E+EGKSF?=
 =?us-ascii?Q?tY2/MxgdYWjrFAFiHiZ6UsOSVsjXrKIn91/Pt/x7odoqwmJ/gYHDQpEgHnn+?=
 =?us-ascii?Q?+BBoF6K4tiXgNVGMKmEGSJooE6RZmlSyzPNPwKBNG8yskmRxWKjqIHJQuFRT?=
 =?us-ascii?Q?jthlsHOXp/jyAWGCeUFQ5/oq3740uRPhJiN5z4Z9DuvqDe9axfR1oBZdmlRy?=
 =?us-ascii?Q?RrNzqSECmWZcD3jIfDT34IXwS3dxKSyP9QikXJ/RLLzJTd3M9QzYukdDh1Do?=
 =?us-ascii?Q?1/R/F73siXEWVjn1tcwEO9hxxQup8aMpDwn0/KTwl9xNjEhr8Jj4hZAFgFn+?=
 =?us-ascii?Q?bnvH9MvmFId6m5X+XIPd4u5BQ+gFdzvH5qLDc0w2sFNA3xhh33bQCjuEH5Zg?=
 =?us-ascii?Q?YQR4FU71oPk/fkW6QabvLIlr1uhfnLF8Tb4dM0TeBVkK86MbX9UILCQAsPTI?=
 =?us-ascii?Q?6JF+ZiZ8H2mXkKerR9A8vUpB8puyw6ywlW6pKbnCSs35PNSMUBoEIXdyt0az?=
 =?us-ascii?Q?j0dvBTK3PGpnesRBfbRxRkRYVqSOPWyp2dRIwsSnBwakbiZGZUjHkqKpckFN?=
 =?us-ascii?Q?XACvJMvsdNItdNVosREc7iNPYjA7e6xZGRlg7fuFnIyrm4WvxpoPvWKBD/mY?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /3Kxs2RS16oUfPH8NgGQnQ00vYLEQCn516AiTu8HIwpX25efTpdhvS7Qlrd2+Jg1WoR+tvUw1dxIcppvUpd1R6b9X/rxNK0yUSOMHq324bpQji1xPvO90TLATPoaM4lKpNoHAcq5fu9GMuo3+aC99L67bYg6HVNWNGBojN+J+vyzI6xb43IwubvnKuElEZyHS6XmqIB2vdp7xdQBqP/ijwgJn5TJ8v0n7eRm2eE66PTJaJvbPo0OvKyfqLM5NHy8Jov0w7FwHtt8Zr7CYOGEWedl9bScfCfxzE7oRE8goXW7JXOXmjnQY0TjOOpfdFoKxNJC7ymn1tWStcbXo48NWj/oF4eliHfJZUDgo64SYjFFSnQg/EIrg+Clz++LwJEl5SBZsfTi+0zgLUZv4FdVNFVshLFGrUWK3uH188D64fbOoKAyQTsGGEDIqGCCd9byzGgE/05wuYedtT4ak6solfl+8zNm0UHwJGmuF5Y1vt2Q+zYOERE/pZepcCJgN8x7eE9VcgUJbxA+yq7D/6ZtHQdUtbF0yZi0BzZ1ZSkMvEb5PogaoSNAk31COSd8Kh1dqiuvVFmoDmkFwjlsNGgH5s4Di4xK1v6LO+ma+eAJCur6Sbo0POqu1pdq6gWCGyQTxb/xnd9waj9jQOVHmfh+CUgyRjGklvjLqNn4j/41DzZaz6Jhf4Kkin1pOprqj/sldvBMB+ih67ONEUsqroKv5+XH0MIXvGPMtZq9h93a51sJoQ7jbcVifroxztIxlU5Kcy4Er+tetQTcNEXgQ+Xj3AHPfAal8X334k5BRz2yMkMBOPqnsfTU7CQG1D5SJpe9CPVW/RxLPKoRn5E5wmCZVdLsIR6b40/WqttEHjcsPZA=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7431.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a862fe81-b841-439d-6040-08dafec730e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 11:27:49.8475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O05Dv9lfRzM9N3Yy6+vz4geP91YAHvcjwyaE1X1MR+pTpBw9YzDq7kvJz7HrDeoqUT5A3GyalaycIoE0WuYZ0BB8ZkLGkcB38LwY9uvaApc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8770
X-Proofpoint-GUID: 7Jnea6Ibl2KVL_tkPvT9Gm3UMJbgeWgS
X-Proofpoint-ORIG-GUID: 7Jnea6Ibl2KVL_tkPvT9Gm3UMJbgeWgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_06,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250104
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, December 22, 2022 11:19 AM
> To: Viken Dadhaniya (QUIC) <quic_vdadhani@quicinc.com>
> Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com=
>;
> Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>; Viswes=
wara
> Tanuku (QUIC) <quic_vtanuku@quicinc.com>; Aniket RANDIVE (QUIC)
> <quic_arandive@quicinc.com>
> Subject: Re: [PATCH V1 1/1] Serial: core: Add compat ioctl support
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> On Thu, Dec 22, 2022 at 10:19:25AM +0530, Viken Dadhaniya wrote:
> > Current serial core driver doesn't support compat_ioctl due to which
> > 32-bit application is not able to send ioctls to driver on a 64-bit
> > platform.
>=20
> Are you sure?
>=20
> > Added compat_ioctl support in serial core to handle ioctls from 32-bit
> > applications on a 64-bit platform.
> >
> > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/tty/serial/serial_core.c
> > b/drivers/tty/serial/serial_core.c
> > index b9fbbee598b8..5ffa0798db3b 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1601,6 +1601,22 @@ uart_ioctl(struct tty_struct *tty, unsigned int =
cmd,
> unsigned long arg)
> >       return ret;
> >  }
> >
> > +/**
> > + * uart_compat_ioctl: uart compat IOCTL function.
> > + * @tty: pointer to tty structure.
> > + * @cmd: command code passed by user-space.
> > + * @arg: argument  passed by user-space.
> > + *
> > + * This function will call normal uart IOCTL.
> > + *
> > + * Return: 0 for success, Negative number for error condition.
>=20
> Why create kernel doc for a static function?  uart_ioctl() does not have =
this,
> right?
>=20

I will remove documentation in V2 patch.

> > + */
> > +static long
> > +uart_compat_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned
> > +long arg) {
> > +     return (long)uart_ioctl(tty, cmd, arg); };
>=20
> Really?  Why has this never shown up before as an issue?
>

We have only seen this problem with 32-bit applications running on 64-bit k=
ernels.
For the first time, we are combining a 64-bit kernel with a 32-bit user spa=
ce application.
=20
> How was this tested?  What is currently broken that now works properly (o=
r the
> other way around?)
>

We are running 32-bit user-space application on 64-bit kernel, and vendor s=
pecific ioctl command issued by application is not reaching the vendor driv=
er.
Without these changes, the IOCTL call was returning from the tty framework =
rather than reaching to the vendor driver. IOCTL call is successfully reach=
ing the vendor uart driver via tty framework after adding compat ioctl and =
functionality is working as expected and below is the dump stack with compa=
t ioctl.

[ 1265.554002] Hardware name: Qualcomm Technologies, Inc. Monaco IDP V1.0 (=
DT)
[ 1265.554008] Call trace:
[ 1265.554011] dump_backtrace.cfi_jt+0x0/0x8
[ 1265.554023] show_stack+0x1c/0x2c
[ 1265.554032] dump_stack_lvl+0x80/0xc8
[ 1265.554041] dump_stack+0x1c/0x2c
[ 1265.554049] msm_geni_serial_ioctl+0x2cc/0x3d0 [msm_geni_serial]
[ 1265.554099] uart_ioctl+0x1a4/0x1d8
[ 1265.554109] uart_compat_ioctl+0x14/0x28
[ 1265.554117] tty_compat_ioctl+0x1a8/0x2dc
[ 1265.554125] __arm64_compat_sys_ioctl+0x158/0x1d0
[ 1265.554132] invoke_syscall+0x60/0x150
[ 1265.554140] el0_svc_common.llvm.3148309083493694862+0xc8/0x114
[ 1265.554148] do_el0_svc_compat+0x20/0x30
[ 1265.554154] el0_svc_compat+0x28/0x90
[ 1265.554162] el0t_32_sync_handler+0x7c/0xbc
[ 1265.554169] el0t_32_sync+0x1b8/0x1bc
=20
> This patch implies that _every_ driver with an ioctl must create a
> compat_ioctl() callback, are you sure that is the case?
>=20

this depends on user application and kernel version. for 32-bit application=
 to run on 64-bit kernel, compat_ioctl is requried.

> thanks,
>=20
> greg k-h

Thanks
Viken Dadhaniya=20
