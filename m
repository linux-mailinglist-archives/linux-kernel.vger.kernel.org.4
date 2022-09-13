Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AF5B6530
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIMBre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIMBr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:47:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB174F662;
        Mon, 12 Sep 2022 18:47:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CLEKl4031187;
        Tue, 13 Sep 2022 01:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=a/EEgBaSFb32Q8Ge1+4alXmu1skfI1ICYvaeUjVRw6Y=;
 b=OJemK21XKEQHk32PMfA6b+XAalTbjf6myoTM384gYR00RfAs15s3KwpRhykRMKKt9OnN
 dBhouwY8NAxEz19jDncB6YyzKoj6kN8KOby+8QHdwpHcw/WH0k4XRcZNrb7iISXp8eiN
 G6BPelAHsE43iUpxcKQy7nyDs7N9PWLFDQDrTUm6lyGFK89KVNaSuwE+deJQdGEDcG/0
 sVOd8w9tNzLcOFty+W7jf1tb6n2+qrIOmIbQKroubgUb8HjB5o8gaYy1+CDBTnqa9WDv
 FwZ2OaOEV+HLXMjWWvLrGdrznjo3iA1SDhef+FYsWRoVTHHOse9NmEi2t91cOYwgvSZF 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgk4td5qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 01:47:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CMjmao020410;
        Tue, 13 Sep 2022 01:47:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgj5bnwbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 01:47:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQB05JiJDe5K7TBi4jfWYzc4QpbujKlt3OFA6dzFyWLJQ6SEfnSsZBNOXB2Jep1q1fOmX+brB57qQSEUDwpl5V25ccumSliUHWmIZAgIPzOYFz73yTV538juz6yyK5UwIOpSLKszqwuitCkLPndK68BR4ZpRrfp4YL6iDa8WqeG7f82istxaNSIhOa2ky44H4dXQ+OG86d8umIRy3l8tywY+gC2154I64Z3O3VY6RH4ei7OZPTKNGVGy09jVcCvt075V7zmLLhz9kteIiaXNyba18wawzZh5t+uvrHWtdKBAxibKCMOYxM0gSbiXlzdYFgYHZrQucq4eP8HZicm9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/EEgBaSFb32Q8Ge1+4alXmu1skfI1ICYvaeUjVRw6Y=;
 b=LdSC73phWrq6DBH7wrI/7GnZ44OlEIJymuN/itguv+PJ0PpM1rpDACpo7X97jVtUGs9zKXZI2KnmPLIJu01M0+9D0AWUN9zrip2uHyQK6S6wJTbAiD5R+XTxN8Er5XEOL6G+/wsXRnMLwIlCmIEBM/mAT6pluChURMiEcfCymxh1dZW6PjCnbp3LcN1TMCKWVMflw0Pp7KrzL28YKNaAU55sPKQw4vMKqMNmhr4N6LF1d4H8r8KRlNMFDC/0cvH2yP2qz6zAtGWNuoeJZj3PRW3qooLQ1WoEl5nxBbIM58nsbryWcwZA8dhWsAduQbI0s04u4RGMA8DTJzIUlWpT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/EEgBaSFb32Q8Ge1+4alXmu1skfI1ICYvaeUjVRw6Y=;
 b=t/gbfB01jOQIMa0cV+XW5//OqyTzSLg6rKYTylL0ZQ18dcidpbDYTy/Ms9D13HY/yhxirh9RqNZtim2a5+IoOSAWKCskXA3YevfccSBylAHr/b3isBijPcAkbQrT1SkkSmrfXuve3iyJXUpPpTX99EAPRdDylNqaL7m3xTY91zg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB4565.namprd10.prod.outlook.com (2603:10b6:510:31::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 01:47:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 01:47:01 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the nfsd tree with the cel-fixes tree
Thread-Topic: linux-next: manual merge of the nfsd tree with the cel-fixes
 tree
Thread-Index: AQHYxwdWTUb6RimhjkSTD3F9xU+W363cl2CA
Date:   Tue, 13 Sep 2022 01:47:01 +0000
Message-ID: <2D1DCBBA-FC98-49D7-82CE-9CDA31BB72B6@oracle.com>
References: <20220913102507.3295ce32@canb.auug.org.au>
In-Reply-To: <20220913102507.3295ce32@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB4565:EE_
x-ms-office365-filtering-correlation-id: 1b9ae890-d8ce-4cdf-cb3c-08da9529da7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jr8FYiIS6WzRKGbUbRE78TEvUjbBnfXO2bHVS1SwYW2tavYfuaX4ig/R0L6QpJlAKDolMbV0bBIT2iAN1rjeW+PNcTrsyR/l1xwHzgJscvalz4HedzE82/DWue5WYnSt26FqVZMjXfcboYglEMI1mjELyjGhKz7X3JKqDlE8FbND8ikmZCj1Q9ch497utLdEkdqjeOuGNGwY7QjpQcsvzNgnp7/rdrYBtq7tqRJROx97QgZ0LYcH4Nfl7LT5/i2+gOGiMWmOIYTKGgK3a68VYhjnqgJxeKdkfLaqaL9TdZTomLIlYkcBetH8J68YLKSOvei/hAtIcD1ydGzg5fxVif1VfyTrcRH/jxeEJO5ueLJ41jgvOktayAxRkhZHrKt7uFbJ174ZBJg8qje8X1nIpJZdxGOKPUlgfXBpQo9KaQeAntbkeqN6a9R5JZFbNwW1+DiWioDxE7bi8AbjU4g71IzeuINUgGTLkql71Az4stn9VtrkelbfQtxC9FhBf2uiqMACBDT9zfORnEk2KQKQm5j3Unpzg2LCP8dbjU0vGWvO0gtXicnyiZ9dxoRO2WMR0XFeYP0+NnIG2rbtznh2jnDlMe9jz5xgcNTpHLKeiPtHLD0I/RBm6PsU55R3RUZ1boLEpxR1b6mg6boCwRgIBnHcPC30qGbqnUiWh4amS1mRsT4UtBYz3nbynAmtwiEYfbLBHhBlDnEcknacsMJ7F6Lh/LxpGi2l7bwzKG1dXpqBcM9IuXlOw9pSRRjD2TQXLMLHXD/3tPH/qLpp2Fpi/Hxc0p3swjSdXrvzFRHcni0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(66946007)(316002)(36756003)(6916009)(2906002)(76116006)(8676002)(66446008)(64756008)(2616005)(6486002)(186003)(53546011)(38070700005)(26005)(478600001)(83380400001)(33656002)(54906003)(41300700001)(6512007)(38100700002)(86362001)(71200400001)(66476007)(6506007)(66556008)(91956017)(122000001)(4326008)(5660300002)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oBAPN/Vz3oz538mYTnZWBJwJemxFBROm4f3O4RChvwrxnu+DiVk5onfda3fj?=
 =?us-ascii?Q?ngEpfmV6uI53pYygLQT63UROZl0ud6iFnU+8V7tRg07ZMCed0gyaZn8C7q1x?=
 =?us-ascii?Q?tnTlPyypLilDbbYFOqLv6GDbiOaimBR3VLPuRb5a0pDmMCXeTvXhlslvMv8B?=
 =?us-ascii?Q?fP4mgMwCLen0/W2ZNyIufrWEdw0/AW2fWrkf3MfSvLDxt0kTQCMNEJBi15cz?=
 =?us-ascii?Q?d+yWfqS1izvb2tvddSX4NZVJ82OxXpg+4Mlt+XBa1SQc/Y0DBQNfd7g6R+N6?=
 =?us-ascii?Q?bbIuwcwqRDOFk7NYK/hoAKCtG0Ekh+GlsPO1aEiNCby5D7m/Ig3MrBYDL2uY?=
 =?us-ascii?Q?LwAvM0FvQmRaecCvM3/kKOxTmhwLRADjj0qQZ+iT+VEgMPquiKlAGj69Qeyo?=
 =?us-ascii?Q?/gUIVqg6p9maeZxfGRsOhLnOO42dV1QaybNmhwP5o5tp0wsCZ4EGZlz26wPH?=
 =?us-ascii?Q?obo/iimhr/D11zNBXbgvmlQLrYvZ8ZQSrwyvnkBbiFL+wEXZRD3V/KK32zkh?=
 =?us-ascii?Q?ohoC1/FDZHQaUvK0p3iaQS/bI8IpqyT/hAHKjcc19gVTRpI+7GDRYIlxevFd?=
 =?us-ascii?Q?KIjMMHKqhJWtC3v07GcZc1YudPbz3fFQ4MfF7EUjWcJigcttsgilrelYUOiM?=
 =?us-ascii?Q?tiG7y/z/rx3FkVeXdozIR25rvFN4DDheIc/ODWMokrtIb5KqYe2aJ/8aZK8g?=
 =?us-ascii?Q?NS1QwAd4PDaM3HDS/4Ie2GEE/dj6rjswpNRM1+Adg3HdCT5lKP8OBR6z1Tcn?=
 =?us-ascii?Q?xLdOfoOKrW3TIcvUHvRvo1ushzKlAKSjfCpn2FoeJ3qVwBIvxINC9gXxg8r2?=
 =?us-ascii?Q?qarj+rc1v/iP9jyJl04jRQl101UmbGJuDRTAaew/7dskVCAz7d26n9ZemyEO?=
 =?us-ascii?Q?mbfTpoRSz/b76+V0tJYpSnQKo69EpFCLzmhqSbGIZW2r/Rg2Lk9yeQywOZZ6?=
 =?us-ascii?Q?99nv5Mi7CjR+Z8luZOJLc9FNjKLQ4gx8RdBg0oPnzadimgbBLy3bOLozrM8l?=
 =?us-ascii?Q?nkrxbMa1EmW7EsGJg9m/ZewyR9zeTJ/DAlD9gDtiR0R1hcu+o5IUD5D+WihR?=
 =?us-ascii?Q?13CVcJFu1g37xgin1TMEm1hhepdm4J1S9ALrXtMRpTNq4CAv53VMiAxiKDHt?=
 =?us-ascii?Q?qJKOdelwz/F3rUJrQdaZMzV11/1lmNmer3uXrv0GDf6htunJrz7xgVTBRytq?=
 =?us-ascii?Q?G10Lq0E9VxA2fd5N2YHtuLJg3acbgrOS643CcacCkSLAZcPurELDiZSyrzZK?=
 =?us-ascii?Q?TJIiNS3xQFWgzu5kyp8vBXNwFvdaSNpFzAK/1N4bqKZEgOe6mWsrINhpzJ2T?=
 =?us-ascii?Q?0yvEYYt+BQZeyKYKhgYLQM56pXur/GhQubmt3gvCvXbM9pWfStlm3adYMkDc?=
 =?us-ascii?Q?4y2vayoqAp76VX47cseg0fkCPr5EZytxv8O9IP5u2dQRR+U7l6r80JWF59Y1?=
 =?us-ascii?Q?LOrVMP/avLiCHUV6Nf42x8RioGpeloJzcTwNw3RcQmapVjhsc6xafyf6HGDg?=
 =?us-ascii?Q?Lb9MAOMNr9jc+XqRiFOASlao7/iNvdfxU+3jSKJ3bIA98/XxMF50HsfG/+oN?=
 =?us-ascii?Q?9bgLiC63jPfQYs5lAu64NZcWoXlkzaR/Dsp9IW/QAZ3uwm2n01Tx2g33MiGd?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEC33AB63005C64887A891A465A3CB28@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9ae890-d8ce-4cdf-cb3c-08da9529da7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 01:47:01.7818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcUapjR8Q3xWoPu6FZDMhMX3Y3bG1knWPjo67TZ1eEQMTu3pUEvTE8+Fbetk46pms+UNf+JRrG32No85ul9cLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_16,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130006
X-Proofpoint-ORIG-GUID: 59u-RJZWMxlDt_ZH8cAT2Ji1sAGGS85d
X-Proofpoint-GUID: 59u-RJZWMxlDt_ZH8cAT2Ji1sAGGS85d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen-

> On Sep 12, 2022, at 5:25 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
>=20
> Hi all,
>=20
> Today's linux-next merge of the nfsd tree got a conflict in:
>=20
>  fs/nfsd/vfs.c
>=20
> between commit:
>=20
>  00801cd92d91 ("NFSD: fix regression with setting ACLs.")
>=20
> from the cel-fixes tree and commit:
>=20
>  e9de96c3df55 ("NFSD: Refactor nfsd_setattr()")
>=20
> from the nfsd tree.
>=20
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Apologies, I didn't realize this state of affairs would create a
merge conflict in linux-next.

nfsd's for-next is currently based on v6.0-rc5, which does not have
00801cd92d91 ("NFSD: fix regression with setting ACLs.") yet. Next
week I will rebase nfsd's for-next on v6.0-rc6, which should resolve
this conflict. I will test the conflict resolution with the usual suite
of NFSD check-in tests before pushing that update to for-next.


> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc fs/nfsd/vfs.c
> index 19f28c33e44d,8eda499de545..000000000000
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@@ -343,6 -339,44 +343,48 @@@ nfsd_get_write_access(struct svc_rqst *
>  	return nfserrno(get_write_access(inode));
>  }
>=20
> + static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
> + {
> + 	int host_err;
> +=20
> + 	if (iap->ia_valid & ATTR_SIZE) {
> + 		/*
> + 		 * RFC5661, Section 18.30.4:
> + 		 *   Changing the size of a file with SETATTR indirectly
> + 		 *   changes the time_modify and change attributes.
> + 		 *
> + 		 * (and similar for the older RFCs)
> + 		 */
> + 		struct iattr size_attr =3D {
> + 			.ia_valid	=3D ATTR_SIZE | ATTR_CTIME | ATTR_MTIME,
> + 			.ia_size	=3D iap->ia_size,
> + 		};
> +=20
> + 		if (iap->ia_size < 0)
> + 			return -EFBIG;
> +=20
> + 		host_err =3D notify_change(&init_user_ns, dentry, &size_attr, NULL);
> + 		if (host_err)
> + 			return host_err;
> + 		iap->ia_valid &=3D ~ATTR_SIZE;
> +=20
> + 		/*
> + 		 * Avoid the additional setattr call below if the only other
> + 		 * attribute that the client sends is the mtime, as we update
> + 		 * it as part of the size change above.
> + 		 */
> + 		if ((iap->ia_valid & ~ATTR_MTIME) =3D=3D 0)
> + 			return 0;
> + 	}
> +=20
> -	iap->ia_valid |=3D ATTR_CTIME;
> -	return notify_change(&init_user_ns, dentry, iap, NULL);
> ++	if (iap->ia_valid) {
> ++		iap->ia_valid |=3D ATTR_CTIME;
> ++		return notify_change(&init_user_ns, dentry, iap, NULL);
> ++	}
> ++
> ++	return 0;
> + }
> +=20
>  /*
>   * Set various file attributes.  After this call fhp needs an fh_put.
>   */
> @@@ -357,9 -391,10 +399,10 @@@ nfsd_setattr(struct svc_rqst *rqstp, st
>  	int		accmode =3D NFSD_MAY_SATTR;
>  	umode_t		ftype =3D 0;
>  	__be32		err;
> -	int		host_err;
> +	int		host_err =3D 0;
>  	bool		get_write_count;
>  	bool		size_change =3D (iap->ia_valid & ATTR_SIZE);
> + 	int		retries;
>=20
>  	if (iap->ia_valid & ATTR_SIZE) {
>  		accmode |=3D NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;

--
Chuck Lever



