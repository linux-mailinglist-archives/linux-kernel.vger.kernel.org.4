Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20B5B8CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiINQXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiINQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:23:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A879606;
        Wed, 14 Sep 2022 09:23:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG1rSi006209;
        Wed, 14 Sep 2022 16:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=elaYQNKKmD3m//Atie6yZglgDOal9dPMMuvz9v98fv4=;
 b=R5twxtPqLgRB4oaZ50rUnCbPqu4KCtXhDW4T9Fd+phzuHMilZog8PefIBRc1TAOSnNc1
 /GpIMPpNUuVBtkGdXsV0BWgYybve6rBWqJjkHbQvDICOQp1n7UEze3ABtYgm/HoCIpvn
 xSo53QnU0CdELR35Bt7QYE/50BSbtEmGNCnksXV/3l27DYLC0V3CE9vqtGbRkPIAvPvO
 rHM6qsqC45ysOjGWtmkZDs9bQyutDg2nqF+QijU8KlSgOXQuvjAEstUQdsCFj2p9uFJI
 xW9NyrRcztB4SZYWStzO5vu9+EqTd+X2BPgVNWLkeBordbMUlcfj8880jaaZQcToAiyq Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxydtvd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 16:23:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28EG1r0Y035485;
        Wed, 14 Sep 2022 16:23:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyehcemx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 16:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG4WUCxD10gC2EZkJyPGJAvd9XWcv061YkC5RhAAp5SRJBjMe0UdxddsnO3EabTQVM6lTIyN3kWtm1x7xH2xW+SibCL/ARMMbBdIsWr61HJ1LFqjhdGO+REmUJJoLQkdZ4CAygOcfgpe67NWXLSdm2bNhaFnZ/8ydhcNSor3A8ma/5cQPQ3AgpBnl9eLcZ3k+v563uQ+j9IFARer4g/SIoGYrpNJlgeutzgXl6AqqLTmEY8q1FTjotjesoPAAPUjtuiGAACMQ6j9TE6rihRpqluKZ+c9dD0qZTSf+1dwkKcpHRLf9UgvaWsel3p6UG4Vn8yylaoHCKpip6NvoTspGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elaYQNKKmD3m//Atie6yZglgDOal9dPMMuvz9v98fv4=;
 b=ayUxwPiZC2EZHxFqV2SPDM04ExHRCecz5Jd1txdEyw75gFCeiJFaBuqLpvsWr9KukRJ1hEzW253KXONkT52MB/3zox3c2O0RPJoSSmGKK9XU56qhJpr9QCT+MJNAC+tgYgisPK84g832nIKjRigprMfv4CcYfCCYN3rqi+ZOGr2FPKsWnxX+rX0QnkMWeqPbcT9zTMbZOTHTas2a5Bz+blt1wQXRtUucOe+RNeb8mRSkOySo5sPg71awrwTu9rP+nazKpsVDmNHN/PMTXMVoGoSWR5C0FaLVVxS2qAwtqICxtuw1QsF0gx8claUyXnnyc5ye9vVFT7NvtcIKnNqc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elaYQNKKmD3m//Atie6yZglgDOal9dPMMuvz9v98fv4=;
 b=lATVIIeI+qE8zXZbdJUCaEvVHC3BOq0mnBJYTamfzfyS2Jv91DgXY5rZscCcH9VLU5IuCZDWetVXCzS9DYeCasC8/12OIOh8KRXTMrCgOWs869/ASkxPL5kAcl0bDqZe0LKMO0GhBMBGpxfAi991RtRQHuEhP9+gihe6ODV9RlI=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 16:23:29 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::6577:47bc:8bb8:92df]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::6577:47bc:8bb8:92df%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 16:23:28 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Michael Christie <michael.christie@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: qla2xxx: Fix memory leak in
 __qlt_24xx_handle_abts()
Thread-Topic: [PATCH] scsi: qla2xxx: Fix memory leak in
 __qlt_24xx_handle_abts()
Thread-Index: AQHYx+SjMrMXH8lkYE2CBQQw7hx0P63fHNqA
Date:   Wed, 14 Sep 2022 16:23:28 +0000
Message-ID: <4E653C94-D457-4881-BAAC-35EA5DC178D8@oracle.com>
References: <20220914024924.695604-1-rafaelmendsr@gmail.com>
In-Reply-To: <20220914024924.695604-1-rafaelmendsr@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|DS7PR10MB5070:EE_
x-ms-office365-filtering-correlation-id: 44d4ef0c-5954-4a49-0d5a-08da966d74e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOEknltkHnq6jizq/xPOHKMVVEKddD2BGcCN+x2XX2hHzDDYO2newpiJSTXl9U4bwOCREFJ5RzaBiYLorZ1mPHUeE8HkEJCxjTDaDn73YEEjNle7GmHBDgJ944yyv8pHLdEqZplxzTbcGzs6n9It7QaXmvmlYQOyW7S4Rrz83Oq5TsG8z+wz2A+6R6MTlfU7KHyifBu/wroMRgWSf4h35Lymzj3kRS/oPMetxqEfcgQoE4r5oc654Cm4mbqkIPTvGIULTuKCHPD+1zf8wtGmDikga0ZlZlH75wITF0j48GcYaNqpe0j54zhA7/gW2K8eblJfACjbk0n6s+RABSZWvsF6/w+SSk7kUqeZO8Td6LWbH9Pu0i30l6RzvSpXRF0bUQC5wnyDc34kLr36vUPbe3TeYhEAcAVWTbggo07P3d7ES3tzH+0HJc8GXFqaVAwDLnKYqSCeoHSfPhvQnBhk838Oyb6OCBXxVpr+oRUpBltgonRj4CD9frUMJ7+0Vw1dkFQELKWeTkvYm7gDvPs57lkn2kvuuCn1x+JVaaK36cLpRR6jqiu5HypcBCQ6F9ouKMn4Vk8eSkxLTmaHNaapaAJUncx6Bbp2WrqsnH6MmQ4AURVWD4iNz3PT1CAkdyuCuCZWliYv/3N3gpTyPxfgs7ZdIIXZrVIZ+7JX+uygQ0Fs+d/fhnB9bC2Vxrlqfbxq2LHCWkXPhQVdekMACMONkY8MINHupqAD3GKhejD5KO7/Dyyy6dH2Y4XREoEAIZtGNB+B3gDVSVeEmu2BFA74Yd7H2q1nhEeeDbb1IogMj+o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(64756008)(478600001)(91956017)(122000001)(36756003)(6486002)(38070700005)(66446008)(54906003)(53546011)(83380400001)(66556008)(6916009)(186003)(44832011)(33656002)(41300700001)(2616005)(6512007)(6506007)(38100700002)(26005)(8936002)(71200400001)(316002)(66946007)(76116006)(66476007)(8676002)(2906002)(86362001)(5660300002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bKnSiCMkb5POIByp1bZ3p/ODFbRQ8TJM4iPkHYfEuDS/vGDE5f0/rJLHhu5H?=
 =?us-ascii?Q?cB1wp9RTxZsvgJWpUwXC9nE1AgVc7As0SiII5PlnDpmJ3IGoIJ9zhbX3tnB4?=
 =?us-ascii?Q?UCwXBX8fw2cjVndq60pd8m5Y5R3b+e/bnRE7A9kJSYZSDWId3I+MiEmHSIIR?=
 =?us-ascii?Q?VkcOlTTzhh4+kX687qGHeAWFMccF3vFKyaA8FZzMblikiF2YZiRonKGSmNUE?=
 =?us-ascii?Q?1PCZMkF74Do0ugxndEcPaCLosxQkkbnj9HGJCfvlYJi3Nem5zIHaIhgaJaP7?=
 =?us-ascii?Q?c75xTPa775FJcpSjx8pKlwiJMTDGitWQumTLIceKhSM0eULfTzqoBRpiyRQJ?=
 =?us-ascii?Q?Np6CT0Ct4inQWtAlBfqFJUt2G2GefNeZVg4LZVkNUDE6opEVE4+5xoM/9IHj?=
 =?us-ascii?Q?00oBJLiKW3F2EXO+OP0YzpZ3W2GXRObcKw29ja6rek1VbMLE35XiyCP68Oea?=
 =?us-ascii?Q?Yhvu7uaAO8C4UifLdcfRq6uU+SyaAVxacEWlIjdxs6hPriiqGps1HHevu3CC?=
 =?us-ascii?Q?t4hRHc/J4i31vQkqSCCXEXud5kVNPj4qaOG4fSlTnafAYO4+P5uMGbW402tG?=
 =?us-ascii?Q?JfcYcYq1eY8au8/kjuelXjrBBAF7P9aWGsmfHauhFe7y00GHZbGDerqWhpiK?=
 =?us-ascii?Q?O8gPytvmbA81U9IhnTBItzS//OjeWYrxHBnuRP+flRzvWcszSTQ8Szd7lUZx?=
 =?us-ascii?Q?w6sIt7ArW1pQebk2MgCAXrQPOT9FcskN2Y48IVrhIQmCgZ2N68bDO7N7vijl?=
 =?us-ascii?Q?aoZZz1ZAf6dCjmNqfOkiUP6hPL8HjfvHMBXHvxJzgxVhoRN3oKpACWbKZiB2?=
 =?us-ascii?Q?zAxOolLlrfkd++J6FJ7JmZ+LlDiDQSdBHOsbGG2Nh19y/YtTLWOZwzssNou1?=
 =?us-ascii?Q?BYs1HoOUP4dFy4M3ZHE7X+xMStTQgUknxMDASZRzG2W+mqVFPfW0fcJrwh2y?=
 =?us-ascii?Q?tsT5V8qBwEcToXxReu6Ee4MzBZNvjGSXfUTwgeR8HH3EXox3CjHkS/t+0Xu8?=
 =?us-ascii?Q?kJtctCfHBQRNFNR/95o+o8uSxLjDMMluTQ0RhlWA+YE661SyYegJwbm3yhd4?=
 =?us-ascii?Q?Pbai+85CzJqYmOnF3V+xLEK4Jl9G0BXKBUq8fHOx3Km9IlKRNGiPArkXH4dr?=
 =?us-ascii?Q?m2d4u7wWqG23q7aMMV/HiqT3WvOQW/M8VP+eNpN6/yVFjRhvjzL66GZ5E0dI?=
 =?us-ascii?Q?XVcjNPzuuSOxTJWlZIFMBoNWHmOis/jxOR09cd7USawQzEXawGxxL8+B84H2?=
 =?us-ascii?Q?OOWbXYE32iFa3xJUhPfryKtDMQQwEC2xr0V5eMi/4EDSbu8Z+ewtejF6GihU?=
 =?us-ascii?Q?RUzwOkwSwW8S9Qj6hjBOQVjjmmCjViJDkfix70Lx2RIkAwr1BoT1jcrd0PTM?=
 =?us-ascii?Q?cDI41FvhZ4d8fSvW+prRLHawFQ6xAVbCshGoHH2MEChUYRM0xEe0xdpQwVE/?=
 =?us-ascii?Q?gPIYuMB3Qc9hgRuwHRI2bVsrl7Eisjpe7QTPKI2WA6N7tGLZNGj8uH5U5O61?=
 =?us-ascii?Q?VMjUvzXxydTZKCnOYZOr9oWrAnLJk9KQgQC7CVkRdS3BXT/rSLzqOfczKyiv?=
 =?us-ascii?Q?0JC7oJjPizBBUeaoSUWNdeONZCHL5yaOjwMVvbM4Ml2U4BjKPCMWjhyYTQDP?=
 =?us-ascii?Q?NA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <795FFEE752D8EE49A73B84EB6B461E87@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d4ef0c-5954-4a49-0d5a-08da966d74e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 16:23:28.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKCiJTLMuWWAFOBa4nMTgqV59sy+NeFhZ6Pt4tqeAXQI4r7mI37xySCuWbKtV+0zjDU0SLyBVCdMpcdIGhFIzTrlOFmM5TVM0ioyALCv0/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_07,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140079
X-Proofpoint-ORIG-GUID: HqdwpqGxYMGK8qVMOou4inhvm3i0ILSJ
X-Proofpoint-GUID: HqdwpqGxYMGK8qVMOou4inhvm3i0ILSJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 13, 2022, at 7:49 PM, Rafael Mendonca <rafaelmendsr@gmail.com> wro=
te:
>=20
> Commit 8f394da36a36 ("scsi: qla2xxx: Drop TARGET_SCF_LOOKUP_LUN_FROM_TAG"=
)
> made the __qlt_24xx_handle_abts() function return early if
> tcm_qla2xxx_find_cmd_by_tag() doesn't find a command, but it missed to
> clean up the allocated memory for the management command in such a case.
>=20
> Fixes: 8f394da36a36 ("scsi: qla2xxx: Drop TARGET_SCF_LOOKUP_LUN_FROM_TAG"=
)
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
> drivers/scsi/qla2xxx/qla_target.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla=
_target.c
> index 62666df1a59e..4acff4e84b90 100644
> --- a/drivers/scsi/qla2xxx/qla_target.c
> +++ b/drivers/scsi/qla2xxx/qla_target.c
> @@ -2151,8 +2151,10 @@ static int __qlt_24xx_handle_abts(struct scsi_qla_=
host *vha,
>=20
> 	abort_cmd =3D ha->tgt.tgt_ops->find_cmd_by_tag(sess,
> 				le32_to_cpu(abts->exchange_addr_to_abort));
> -	if (!abort_cmd)
> +	if (!abort_cmd) {
> +		mempool_free(mcmd, qla_tgt_mgmt_cmd_mempool);
> 		return -EIO;
> +	}
> 	mcmd->unpacked_lun =3D abort_cmd->se_cmd.orig_fe_lun;
>=20
> 	if (abort_cmd->qpair) {
> --=20
> 2.34.1
>=20
Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--=20
Himanshu Madhani	Oracle Linux Engineering

