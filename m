Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7EE5ECC24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiI0S0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiI0S0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:26:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F30F102521;
        Tue, 27 Sep 2022 11:26:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RG4Gug013977;
        Tue, 27 Sep 2022 18:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hVTc97AUjy2DC9Tgkcd0R+lioZTt2Jny6oLoT6FwmJ4=;
 b=dB/Xl1HVIwlz6yYp2uKC92pEn1j2rujcEhvMnT9NLSVdlfWjFXNo7W4i2xaIMkC9/rQj
 /9l1ozMprqsRuNXYv9lIV4CZnlqO6ikOD7GQLiEZiY/3sRGtDL5mZHZp6e1FfBvhZB/w
 00M6bySCj4VnMPRNvI1TJ8Q1dyEGsHsl5wgtFGOEQskg2xpsZw54NjTWPhLAbG4aYMMI
 TiRF54zgEVimSXxrtfKskYEK9nyoGCL6OIDqpqT7kqokoetd0rufHOHj7mHqv05NhBiB
 SvVqKiQyFHFFGOs+nzbVEIYb/6hlTfOVuDkMcDstlPYePz7RhXsME94O3xufBOQTLL+k 0Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jsstpqcgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 18:26:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28RFrAKe019931;
        Tue, 27 Sep 2022 18:26:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvej9a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 18:26:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVwREjnVvjMHZxH3rLAWMrUigbwRIj/aloGC4VPFoypOYNJgTrRwO5pgWdSLwuIY3Uyv2jkPUAAGwk43DgXC5QQN3fjNQq2kQDi49S7sTbRNO0MiakCA7olwlofyjfqmCwX4dB4/DYPBgPLEKhQJgWNrGcdAEPDaKkPv086JgY70kMzzJ54xmtSRvMuUC6EZH+WlLJwgFY2NRj14+Uc8R3PsNqqiu+IxwmLd5W5Tn/jfbrYUsuTYK6B+gpqB+2BhX/t8jRsD610RxxS7y44mx8OZMtyDAyza70ZZ6fKkXKcJhWQxyTHxplw2kjT9wl8p8E0ypcS3O+gakoOg5PNbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVTc97AUjy2DC9Tgkcd0R+lioZTt2Jny6oLoT6FwmJ4=;
 b=YgpKCvYbauZ+vIwCu4sDWXA/YrORjU6hLCUucHK7VtGZCaNCqtuvHtm1vEguRciDPkerJBW5xBaecnG3+D/qnwzUtdy0Bhr5FY8/iDDbyG6RZWdzGzPPwIwzOIB9SziEjRZ/q4996cWaQmuUf/uuVl6Jrw6THvYp6Yy4QdTZHVFmoDbgcrhGbpXwQIsOv2nmogLSfTx9UfTAsZEC9L2c1ucEZ3C739AQhpA6g9nLOM8QqaNbS6nQEnqa5VSkvW1Y2xqctq36CrY2UPmXTwq6P1ccqKesk7OtvmL0dj8kiMjNHiFfcTi7zVWVmfhZsui4959qC6HXhPLO7Wo/jc3/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVTc97AUjy2DC9Tgkcd0R+lioZTt2Jny6oLoT6FwmJ4=;
 b=sqkg4REA4LzpfNyiLrKUwha1P3GNrKePlHUOh1ewOlgJ3U2eEbPEI93CBpbPxgWK0weQFOEtWFd/XTucRqHsUfOmHjUWlKK/zi9Qnp/BBHLe+mYFpLT6A4SFvngsZskhvG2bLzrFvictMlEJ8hEUBWWrPjoOGPaxKDOkQ2Gehjw=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by CY8PR10MB6659.namprd10.prod.outlook.com (2603:10b6:930:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 18:26:13 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::498c:82a0:ebe4:d551]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::498c:82a0:ebe4:d551%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 18:26:13 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <quinn.tran@cavium.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: qla2xxx: Fix serialization of DCBX TLV data request
Thread-Topic: [PATCH] scsi: qla2xxx: Fix serialization of DCBX TLV data
 request
Thread-Index: AQHY0fwnkq/kzu1Kn0GHnztdbOJSZq3zmUUA
Date:   Tue, 27 Sep 2022 18:26:12 +0000
Message-ID: <185F81ED-2471-44EA-90D5-08503A719426@oracle.com>
References: <20220926230245.790508-1-rafaelmendsr@gmail.com>
In-Reply-To: <20220926230245.790508-1-rafaelmendsr@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|CY8PR10MB6659:EE_
x-ms-office365-filtering-correlation-id: b30828df-d013-4cd0-09dc-08daa0b5c1f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0tZJTx23YPVkERg/q2v7KThd3ZCnxL+34TsFxnpIEMfy9sJXDVPqqsh/cVbZdhAtZd8fzed9cRa5CGFOLjQ/vM/a7NaOQXt2elsBbDjHlOVUfQfDSA35I9T6RxYmVnfKO+3Cvn1Ut5zuB4ckzm8swkGvL1aUobifOIDdQWwZGBarcK9E/cjQoeeVlA0v3cGoEMwEnnhrlGWp3jV0Dxb4hYQMfHhk0gcRDY8kMUWECzR8u8v91Q+HsJH2f0sBpp/IldLwnKvPLVZ46neF2oO30JZWg19eHDu33NGqZPolsMkmeifc3ZGDw6bBdTnnZDH3Lcg/LF5QjPpVY06qNVO9NSjvMMWyZ7C0cxgBt4a43sNhdCdAxo7ZaAtSbwhdQyfTOGxQoEdsdZtOePP5F7W2utHqABypAKbyfYvWHJ3IBs18vGQSyrouvVUP1kJurlrxbV8e3j4e1awIhSMdAVmggdcul0KAeqH030IJYriwNjOuiJC1QJnQWvWO3h1ppN3qE1bEdOw/pj1wOcTQ0b0Ce6yk/V4tOX/ADEd1pS0CKcXUP8RwfuUQHn6ovoC1KvrUL4w6ywNf3JkUjM11lkrs+Eo0MJqoL2ocCe1EjXhND+fMlzU0Royp2063qoVv6mn0JL8fE92IUSKlCEb/o0L/NOvvDj0VKHPoMlNxOB1ATKV6YVGUh3xss0p/+u78UnU9C76JIgizss1Y+uvtiMbpzntx4U/hZFAkDWMonzd6FnFUR7Q/WIM9LBGEEhOcdB0120dhM8Le99BnzsncvEcOnFQ8KcAADskf4aCA6nZFF0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(86362001)(38100700002)(36756003)(33656002)(38070700005)(122000001)(2906002)(186003)(26005)(5660300002)(478600001)(44832011)(6512007)(41300700001)(6506007)(71200400001)(53546011)(6486002)(83380400001)(316002)(66446008)(4326008)(54906003)(64756008)(2616005)(91956017)(8676002)(8936002)(76116006)(66556008)(6916009)(66476007)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZjtmYZLTGXQOT4dz07fjZNyCEzql6GfwCQS6rjl5XouAQN0TwrQsOK/JtazC?=
 =?us-ascii?Q?Wbz6iOQ2WxcjnrHMim58jfVaibIslcZZk8l3vwUMyPHmCIqkoSXOuyA0cpFs?=
 =?us-ascii?Q?ocbpnziCffSJquAcYSgQcH8Fepc/PR7ltL5XD1OrQ/C1G1DPFVpjLKVaGo/P?=
 =?us-ascii?Q?gRc9Ed/qJPuD5M1gNgQq0ZvIWA4YcW8wRXyRLPJ029Td32YzD0dmvcjKsVpM?=
 =?us-ascii?Q?dqCLkLUfWSlXc/8uOTRqZmDlf51IgOZuMNfIpVq5er4Ut4PM5zyMfoyNteMt?=
 =?us-ascii?Q?1EzkJQVnu2Ei1qqhvq7uJaiEXTPMaf47/3pO6qKMlsbGXU38ita+SJnuaY9D?=
 =?us-ascii?Q?v0GXlcW9SCpxLYI4EcMuvCZOAE50T+XwinIBVB7pyKrDqsLbNwc9GrTSM2FZ?=
 =?us-ascii?Q?w9L4Z1f9/UWF515Md9a364jlIrR0W4iugYNS7Z+H+rN+hKBgSoUBuV4ZWhCM?=
 =?us-ascii?Q?1sTNeEmOaDQJKNiLD1dOA3Gq2yp9n8IslICPVctMx9h4UhYhJetK5ILR+u1A?=
 =?us-ascii?Q?qC5wqAnu+LoXUBYh2OeI5pLeTMCFv47/ve4mWIpXh502v/JnwT/zEFWXJ6ae?=
 =?us-ascii?Q?amGASH1Qp/H/xXiEumm2aNC3v9eXqNS0KyyI5v6ptSPmTY4/JNyPCG/4dWJC?=
 =?us-ascii?Q?sqjxFB9RF0X3A8osiBbNiB4EPQN1V6vmzVKCtsRTyhr67ACIQO//w3w/0VkC?=
 =?us-ascii?Q?znZo2nA8/182H+FH6mpV0Anq19eO3ufsQIPSBjwA+wly+0suT5dCtN36PeTw?=
 =?us-ascii?Q?w0affBJJ+fNjC/m4Iq6vMn/cfDkH2oo/Fe8QbzTkS/2wcyO/xkWsPCb3JdsU?=
 =?us-ascii?Q?f4wo/IgJVLp4K1weKMLJxw/C6tZdnjugC7TAZq5cRgpglJjOQGrf0WSQih+G?=
 =?us-ascii?Q?c3NCYXeAKFVMGv3ctoCTGyBb6CumcoIpseIEqAoYYMe63w34rGoP/fgdopFY?=
 =?us-ascii?Q?djdPj0cqPlVa7s1u2S7VmCeO5rN1lY1I+HBEGkyZ+PCow9/nVyd6bjMy8uD7?=
 =?us-ascii?Q?HEujn/vqBr+/1EvaVZ+oOZ0h0pm+71p21PTE8Ddk6TH+H5wsISYpBnhvtD4F?=
 =?us-ascii?Q?PRnEVmXrYqJXA/qGpDjJVNM+ky/DrrKdhw6Yk1wxeksT1KuIyoi9PehE+zVF?=
 =?us-ascii?Q?ITeaFaV3maAYbf92cesXMR2yBoh2VcP7XbT+Wiv679OAU3Bdf4wykPcrHNCe?=
 =?us-ascii?Q?tlx9Wd+PtJ6bqC9rzKnPRHgPtTttkQIvjnhhnrWWxXCfumX6IYT5mwkfhc5y?=
 =?us-ascii?Q?cN2rL/W4YW5EQ6kIybUX51L+Nd3MKC1C9iFzBv4NOCAau49/Zgq+LJdO166v?=
 =?us-ascii?Q?NsciOkFwC6w445ExV49MUfZ848SRxkrgZEQegyzEtR6OEPqm3RmrNo7dtdDF?=
 =?us-ascii?Q?pfhzwOcGleAMYHkD5AenVQm+s6AXzm/PpoRcBk/5zT0bj8YjStRSK+aT/NZS?=
 =?us-ascii?Q?9RLdlUzsFXyz2NwgdT6L4pv8nJhbzZ6wspwnHWC6RKTHl9tN+031P8x1aePG?=
 =?us-ascii?Q?3RwlsGkE67ZeXWGJ4ANQFoW4L7oT6+5UkMZvFyO+QaZto2sNSw342jiXduV5?=
 =?us-ascii?Q?LVRdVWAlGHWvqLTzOd7tpNeR6riU7AYTMRCcThIiA/FfXXhR4Kpix/qyf1cC?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C38C826A78F6B4E86F02CD930DA58BC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30828df-d013-4cd0-09dc-08daa0b5c1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 18:26:12.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jingRad2wT81bw9gOgb9D9M0zqPS3RFtdrttgBxYhR12PNao/7gLHxKey9jB48UXF52omvb6Lezq3azyV7HBrDU0RBheYvQGEkrFLZdxdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_09,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270115
X-Proofpoint-ORIG-GUID: PYqUGj9-3HjUgmrhu6_ilxFL5ZotpsnI
X-Proofpoint-GUID: PYqUGj9-3HjUgmrhu6_ilxFL5ZotpsnI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2022, at 4:02 PM, Rafael Mendonca <rafaelmendsr@gmail.com> wro=
te:
>=20
> Commit b6faaaf796d7 ("scsi: qla2xxx: Serialize mailbox request") serializ=
ed
> mailbox requests from userspace using the 'optrom' mutex. However, in the
> case of DCBX TLV data, if the memory for it is already allocated, then th=
e
> mailbox request ends up not being serialized because it is done without
> holding the 'optrom' mutex.
>=20
> Fixes: b6faaaf796d7 ("scsi: qla2xxx: Serialize mailbox request")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
> drivers/scsi/qla2xxx/qla_attr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_a=
ttr.c
> index fa1fcbfb946f..c2bc7f9c728a 100644
> --- a/drivers/scsi/qla2xxx/qla_attr.c
> +++ b/drivers/scsi/qla2xxx/qla_attr.c
> @@ -951,9 +951,9 @@ qla2x00_sysfs_read_dcbx_tlv(struct file *filp, struct=
 kobject *kobj,
> 	if (!capable(CAP_SYS_ADMIN) || off !=3D 0 || count > DCBX_TLV_DATA_SIZE)
> 		return 0;
>=20
> +	mutex_lock(&vha->hw->optrom_mutex);
> 	if (ha->dcbx_tlv)
> 		goto do_read;
> -	mutex_lock(&vha->hw->optrom_mutex);
> 	if (qla2x00_chip_is_down(vha)) {
> 		mutex_unlock(&vha->hw->optrom_mutex);
> 		return 0;
> --=20
> 2.34.1
>=20

Looks Good.=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani	Oracle Linux Engineering

