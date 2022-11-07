Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC161F4F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiKGOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiKGOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:07:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032061A055
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:07:34 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DLAAM000379;
        Mon, 7 Nov 2022 14:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7qPz8GcpaY/pfHhbvglkNozfbH3lt8IioajRQsQNiOI=;
 b=el/1zvoVnyiiuDwCZneNNeLUe9cyXe1CtwXJZAgmKKqV4QaCSCvSjdGF+Tu8p2ufkXX9
 xOtzvr0d88mZlJnRBik6pvMF+zpyKizvEZMnGivgtVDb1RyqVnkQY112pHuI+OPe8tPJ
 T38Zd6IxMwO0nXR4CXDaypXI8FMtchejivipLJ16b3TmZS5NC6DIzZpyAoWGvc9L97RG
 BNpmXTnQjp1v1Nn3L0zrT1BjRPXZzZRmA+S5YaqqgQ9UB/bZDnCwN96sOAJElwV8MqNI
 LT3j7VI44wlm5sdo4jcOuEbnsfiz6n2Vd/fnMwrumi5fnW+rj3YS71qVwfJ87qKTMMwM BA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj3qk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 14:07:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7D4l2e029016;
        Mon, 7 Nov 2022 14:07:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcscb6b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Nov 2022 14:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGEGSeO+2wD98XRbn55FVLLS2RyT8Mz4bzjDMiVP3ixm4LsnNrvFwwD8wGWNVPacpo7laqYojDIhpLNFSHT5msXhEssTp5xGhqvR7diUZBlMm7hREVw1CDyhFKQ8P6/5YHtdhPL8ZvEdQ9Jb4Ue+lVy7/z9xYMvy6WEmoPhw+f9gRwCb5wknX44R7D3G8WrdlqyjgyoSbKqez9wR7UL1NTJmh2zz2Jb3rtFEtzkQO3WBVWj7XV41TCJJC4zdJ4IKCfMwZUIUu/SFfZkoJCiE3va7AqDwxH84gukuFOHZmARLOXa1kDf3faiLN5IQn7+QbpxsJoQbQVMcqI8JLafnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qPz8GcpaY/pfHhbvglkNozfbH3lt8IioajRQsQNiOI=;
 b=dwgCEWuwlI03Auf24e0gk0pxh3iS3Uk6pARxbYq43yVbzMUQNWO5nW9jtg/Ph+OSpPkPsSi3eHVwXvsPFWIVj5j3O2B5vMHBBl3GudZgT2LHmhaakuNpW64m23TCAL1BMQp8ZYi26FLpL85Se6ldI56JNXVS1FzjgpaG1BLBio2lbTQumsfUVwu9xdTAOP/Z+DiOFV3JNLhpijMdk+UrXTTJ3pvf8APJR2RJlTtWsamAbutwG398tu1pGGBR1ef6b2PyKnfhNRUK0wcMSz/YCrm+X8ZZkNACpT/AX1EttX/hECQ0YwCAHGodenrc2jv/JaryccGAZJr80FOSjCWj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qPz8GcpaY/pfHhbvglkNozfbH3lt8IioajRQsQNiOI=;
 b=E9nuFoGaW5iN9+7Je/x0WuXKBKpQrofqpDUTJesv9zYxaXccP4t3DcmsRqaWQOBkfYqS2tJiBbqVS2Q/PLweBeysbxX0gHXbjQVFOVZl7T4gTfMUffUa9/NaRDr5nEl2RRgXraWU4yVtzFIMQC1KduZ6H6jzvWwywujcTwGiZ7o=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5372.namprd10.prod.outlook.com (2603:10b6:610:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:07:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::b500:ee42:3ca6:8a9e%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:07:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <error27@gmail.com>
CC:     "oe-kbuild@lists.linux.dev" <oe-kbuild@lists.linux.dev>,
        Jeff Layton <jlayton@kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing
 freed memory 'nf'
Thread-Topic: fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing
 freed memory 'nf'
Thread-Index: AQHY8QhAgfUG5bljWk+vlS5eU1Ez/K4wd6cAgAKg2ACAAGnfAA==
Date:   Mon, 7 Nov 2022 14:07:07 +0000
Message-ID: <DFAEDAE5-7A7C-459F-B0EA-02F938D9D2BD@oracle.com>
References: <202211051543.2bnSgTQW-lkp@intel.com>
 <6F00D08C-6D94-486A-A3F2-B11C9FF5E9E2@oracle.com> <Y2i4Olz9GHpO02bP@kadam>
In-Reply-To: <Y2i4Olz9GHpO02bP@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5372:EE_
x-ms-office365-filtering-correlation-id: 4c871e00-2e46-4554-930a-08dac0c95b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54CedcwhvgWGGE15x44J9Iy+IBsSQcSBh1RSqS8z5oMdq8bVgffuHV78RFR9WwTvTal6TrYrLCeV0UnLi8BHOoqbbCc9nHmOZwILWeJdy0O68UAYaUX+dyK/yb+Ck+N1yb/22WdWOhRoAXov7/kEcYb4V6S8pvMwP3wFJrItn8QRe21MflIObpadfL4a8zJCoKMirWHWGkHNuEwto1vAjEPnz6iaUC+E6PoZLeJTwkl5btaXAf1bSTexNoPTXn1ElwFmAiQ7mVRwAJzXvNtFyNuC+mE402aU7/AdiXUNIxlGShsU6CTVoBMXJ0dQuf1nPXmsPOWYoZEEejMEuNufBuvaYVXOX+zWadUZgdAidptv7D53/TxNUSbY3qS0Q0SCn9Ne4CNJs5MVTf+b6tIzATQCAbveYvlmlCwAKXtue0o2yw3La5vtfzkVFk4BwCKkzyPA0VRKi9juqkob5IF7dNFImKF7+ksCSN72k/Lz1Vw0Q5KT6fBW0R1yblicURkQalakQbuzxo+RZjfrBEMwK52kNVoT2j6djusDpgt7F5ZPVZPrY306tWUPSl4UusWlAAvoalGrO3iln/llOHzTBR1MLf1dS+kBhaSsFwg5d9nKATf8CutX+ovVblvumpZM8D4MGKQae7WG0Quv5cZ9OYk6LTI2Izkyh2G4VY0GIe+1rF0JyJvvetgSg1Vc5waWmDjWj9DRqlmZd27bN9FJYbPk9gOUigN00045VRn+GOZxikYzVGj71FAM7XFDaFplkGC6Zx/p6N1+m6IjHB26pstUqDXotYrCYQLQKMm1QRVWUpEEouNZA/sXhyMz396fhRTvkW+SET8Ib4QXM6igXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199015)(2616005)(186003)(6506007)(38100700002)(122000001)(26005)(6512007)(53546011)(83380400001)(2906002)(8676002)(478600001)(316002)(54906003)(71200400001)(966005)(6486002)(5660300002)(41300700001)(8936002)(91956017)(4326008)(76116006)(6916009)(64756008)(66946007)(66556008)(66446008)(66476007)(66899015)(33656002)(36756003)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IX4ygNnSjWGVowxZqedDaev7a5NSgb0LLZKViVDNrYdcY9/6Evp+snKia60Z?=
 =?us-ascii?Q?JS6N08R/GZINaxrS03sw2hY9uNKVoLDApvDg2URtRPPjuUh3Iq3QJxQnS/Qb?=
 =?us-ascii?Q?zNcy/JEdzcfqZ3Pfpy/L42AXxP6nuYFgPaAoe1/aWmQKsq+RwsoBa8qLQ1OI?=
 =?us-ascii?Q?TsoTskK6mwatavPQVRXW9OdKTzPq47+4ARgHKBJZek/6ikHDpAmd3p7REbf0?=
 =?us-ascii?Q?S8DtnW9G6JogZ9KxnhyVJZcUoGRMlPf+l4YLEF6Mc4oFTpV2yGsb7W9NV6X/?=
 =?us-ascii?Q?e19ybndijpPAP2kPR6/dbdO/wxGheKHhi6v296kcQoFKkuOX8bSmi+jZcJhB?=
 =?us-ascii?Q?GDMlq8jajI++pENzqT3lRYENsRXub+Qi0X+ZOimaETIQ6+j8sfMmGU8sxzbm?=
 =?us-ascii?Q?DgoQoQUprAJSNQZhgD0j9jW2kla2W5vM40FGAzl7EMoIoJCN1lUYyJgDLsgC?=
 =?us-ascii?Q?oU6YYf9UTTz1iLZCiduTlJQJp6d+YrHDd7irnQtAENotQDZTdVVscZVjIlJo?=
 =?us-ascii?Q?BTRgfebJMiLKNBBqzB4Dmx7TqE67Dll0fk8ro8QQJPMvpe8T5Z1y9c1cf1JH?=
 =?us-ascii?Q?cNKI26avroIF5Sw/NE9VO3ay+v331ol9lbJYp+ar4oUEiivVFjQ59ev3hg9N?=
 =?us-ascii?Q?hVh20Z6BYvdpaCdZ6rKtsWYCYhets5h0oabe4/itox3oKzAUlFi2b/TqKJtO?=
 =?us-ascii?Q?L3zn/zpp9CViL+ha4kH+lOoODT+juuN+KJBtUbp2gFofFS9TJGMH2TbueDaN?=
 =?us-ascii?Q?dA+MDTL9BokmWHPj/Ng6tfBaO1gvF5YJAydQCWvpGd2t21H8Ou01MbxAKUyQ?=
 =?us-ascii?Q?uIyQz+ua3RbyJcH1snrHMqbvZc8CD8PBp6jJkhDC5Mu/ojN4Jiqq+BMGlfz7?=
 =?us-ascii?Q?ewkP+luqJtUu/t5b2EqsuxLwb0KF6+gnQ0Kzh0xGNUdkLdlVDE9iy8JSqjlp?=
 =?us-ascii?Q?CKdkHkdtE1LL8/ejoQn1rBpmiewNws00ciMY5XkGKaL5AG07H7N4BmErBUgU?=
 =?us-ascii?Q?mz4guvmWtdgNM62++YEREm0seA8iovITQzhSRHPMb5JwzDyNDNQGOQMhQkss?=
 =?us-ascii?Q?89RJD+fF/SCRolDgyZGpZRMAYikj0UfEjQjuCPY0Z48B6h+ZDYxQo3wXYOpE?=
 =?us-ascii?Q?WP4cubIopELfbk0/jKmycx/dXdLKoxjwNWtHAVVEKHdTeYXVloMxkn+qe5v+?=
 =?us-ascii?Q?RzHPP/Pe5zWFf5ygW5U6D+uPfUvL2dxmTVyFzDComB3JiYZzv/kakBYhreZX?=
 =?us-ascii?Q?jJ22RqJ5FMbnLYBl8F+JACrAXNPlKsxdT2f6DUgGzB92TfWp2J90flwxgPIM?=
 =?us-ascii?Q?cb3g9jFfR8899rn4TJ1jQU6PNVZJtCb/bWHRQsjsYsPJdaw7dcxkfEOl8GZn?=
 =?us-ascii?Q?gSoOuUdxeiEyLYhyPTkffGDg4Um9O8f/SNWRAeCSe8iTujqYkIeZF+Bk7J4+?=
 =?us-ascii?Q?GZKVzuTP87YTesi1gc5iU4bC76XH6EOv4AG8qqWZW/TIgQ1bdokMPfC8jggx?=
 =?us-ascii?Q?ECIocWSZ+gFEUfDYHQGRQ/aynAndm7GiRNeytX+O2T1RAifDecI/3JkYka1T?=
 =?us-ascii?Q?SQD5Xk38z8VmaML7OJv+vztfbizYauATnDpmVW5sSIeqWRjaKK1YgaCWC+j3?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <409F2F62B6E8664BBDA7A4517E6B641F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c871e00-2e46-4554-930a-08dac0c95b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 14:07:07.7427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2khVfYWGpkyOnbZYNd0ImG794Yj5kqq4ch0rNQ+NgzHCDMqqi87zOu6br9VmmJWIDePFhPAakjUjlYkOsfkCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_06,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070114
X-Proofpoint-GUID: rafc8wBcOy-o8Z9h_nGpP6oDif2fdG-4
X-Proofpoint-ORIG-GUID: rafc8wBcOy-o8Z9h_nGpP6oDif2fdG-4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 7, 2022, at 2:48 AM, Dan Carpenter <error27@gmail.com> wrote:
>=20
> On Sat, Nov 05, 2022 at 03:39:59PM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Nov 5, 2022, at 7:17 AM, Dan Carpenter <error27@gmail.com> wrote:
>>>=20
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
>>> head:   b208b9fbbcba743fb269d15cb46a4036b01936b1
>>> commit: 243a5263014a30436c93ed3f1f864c1da845455e nfsd: rework hashtable=
 handling in nfsd_do_file_acquire
>>> config: alpha-randconfig-m041-20221030
>>> compiler: alpha-linux-gcc (GCC) 12.1.0
>>>=20
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Reported-by: Dan Carpenter <error27@gmail.com>
>>>=20
>>> smatch warnings:
>>> fs/nfsd/filecache.c:1118 nfsd_file_do_acquire() warn: passing freed mem=
ory 'nf'
>>>=20
>>> vim +/nf +1118 fs/nfsd/filecache.c
>>>=20
>>> fb70bf124b051d Chuck Lever     2022-03-30  1036  static __be32
>>> be0230069fcbf7 Chuck Lever     2022-07-08  1037  nfsd_file_do_acquire(s=
truct svc_rqst *rqstp, struct svc_fh *fhp,
>>> fb70bf124b051d Chuck Lever     2022-03-30  1038  		     unsigned int ma=
y_flags, struct nfsd_file **pnf, bool open)
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1039  {
>>> ce502f81ba884c Chuck Lever     2022-07-08  1040  	struct nfsd_file_look=
up_key key =3D {
>>> ce502f81ba884c Chuck Lever     2022-07-08  1041  		.type	=3D NFSD_FILE_=
KEY_FULL,
>>> ce502f81ba884c Chuck Lever     2022-07-08  1042  		.need	=3D may_flags =
& NFSD_FILE_MAY_MASK,
>>> ce502f81ba884c Chuck Lever     2022-07-08  1043  		.net	=3D SVC_NET(rqs=
tp),
>>> ce502f81ba884c Chuck Lever     2022-07-08  1044  	};
>>> 243a5263014a30 Jeff Layton     2022-10-04  1045  	bool open_retry =3D t=
rue;
>>> 243a5263014a30 Jeff Layton     2022-10-04  1046  	struct nfsd_file *nf;
>>> ce502f81ba884c Chuck Lever     2022-07-08  1047  	__be32 status;
>>> 243a5263014a30 Jeff Layton     2022-10-04  1048  	int ret;
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1049 =20
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1050  	status =3D fh_verify(=
rqstp, fhp, S_IFREG,
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1051  				may_flags|NFSD_MAY=
_OWNER_OVERRIDE);
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1052  	if (status !=3D nfs_o=
k)
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1053  		return status;
>>> ce502f81ba884c Chuck Lever     2022-07-08  1054  	key.inode =3D d_inode=
(fhp->fh_dentry);
>>> ce502f81ba884c Chuck Lever     2022-07-08  1055  	key.cred =3D get_curr=
ent_cred();
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1056 =20
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1057  retry:
>>> 243a5263014a30 Jeff Layton     2022-10-04  1058  	rcu_read_lock();
>>> 243a5263014a30 Jeff Layton     2022-10-04  1059  	nf =3D rhashtable_loo=
kup(&nfsd_file_rhash_tbl, &key,
>>> ce502f81ba884c Chuck Lever     2022-07-08  1060  			       nfsd_file_rh=
ash_params);
>>> ce502f81ba884c Chuck Lever     2022-07-08  1061  	if (nf)
>>> ce502f81ba884c Chuck Lever     2022-07-08  1062  		nf =3D nfsd_file_get=
(nf);
>>> 243a5263014a30 Jeff Layton     2022-10-04  1063  	rcu_read_unlock();
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1064  	if (nf)
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1065  		goto wait_for_constr=
uction;
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1066 =20
>>> 243a5263014a30 Jeff Layton     2022-10-04  1067  	nf =3D nfsd_file_allo=
c(&key, may_flags);
>>> 243a5263014a30 Jeff Layton     2022-10-04  1068  	if (!nf) {
>>> 54f7df7094b329 Chuck Lever     2022-07-08  1069  		status =3D nfserr_ju=
kebox;
>>> 54f7df7094b329 Chuck Lever     2022-07-08  1070  		goto out_status;
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1071  	}
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1072 =20
>>> 243a5263014a30 Jeff Layton     2022-10-04  1073  	ret =3D rhashtable_lo=
okup_insert_key(&nfsd_file_rhash_tbl,
>>> 243a5263014a30 Jeff Layton     2022-10-04  1074  					   &key, &nf->nf_=
rhash,
>>> ce502f81ba884c Chuck Lever     2022-07-08  1075  					   nfsd_file_rhas=
h_params);
>>> 243a5263014a30 Jeff Layton     2022-10-04  1076  	if (likely(ret =3D=3D=
 0))
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1077  		goto open_file;
>>> 243a5263014a30 Jeff Layton     2022-10-04  1078 =20
>>> 243a5263014a30 Jeff Layton     2022-10-04  1079  	nfsd_file_slab_free(&=
nf->nf_rcu);
>>> 243a5263014a30 Jeff Layton     2022-10-04  1080  	if (ret =3D=3D -EEXIS=
T)
>>> 243a5263014a30 Jeff Layton     2022-10-04  1081  		goto retry;
>>> 243a5263014a30 Jeff Layton     2022-10-04  1082  	trace_nfsd_file_inser=
t_err(rqstp, key.inode, may_flags, ret);
>>> 243a5263014a30 Jeff Layton     2022-10-04  1083  	status =3D nfserr_juk=
ebox;
>>> 243a5263014a30 Jeff Layton     2022-10-04  1084  	goto out_status;
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1085 =20
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1086  wait_for_construction:
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1087  	wait_on_bit(&nf->nf_f=
lags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1088 =20
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1089  	/* Did construction o=
f this file fail? */
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1090  	if (!test_bit(NFSD_FI=
LE_HASHED, &nf->nf_flags)) {
>>> ce502f81ba884c Chuck Lever     2022-07-08  1091  		trace_nfsd_file_cons=
_err(rqstp, key.inode, may_flags, nf);
>>> 243a5263014a30 Jeff Layton     2022-10-04  1092  		if (!open_retry) {
>>> 28c7d86bb6172f Trond Myklebust 2020-01-06  1093  			status =3D nfserr_j=
ukebox;
>>> 28c7d86bb6172f Trond Myklebust 2020-01-06  1094  			goto out;
>>> 28c7d86bb6172f Trond Myklebust 2020-01-06  1095  		}
>>> 243a5263014a30 Jeff Layton     2022-10-04  1096  		open_retry =3D false=
;
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1097  		nfsd_file_put_noref(=
nf);
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1098  		goto retry;
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1099  	}
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1100 =20
>>> 4a0e73e635e3f3 Chuck Lever     2022-07-08  1101  	nfsd_file_lru_remove(=
nf);
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1102  	this_cpu_inc(nfsd_fil=
e_cache_hits);
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1103 =20
>>> 23ba98de6dcec6 Jeff Layton     2022-07-29  1104  	status =3D nfserrno(n=
fsd_open_break_lease(file_inode(nf->nf_file), may_flags));
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1105  out:
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1106  	if (status =3D=3D nfs=
_ok) {
>>> 29d4bdbbb910f3 Chuck Lever     2022-07-08  1107  		if (open)
>>> 29d4bdbbb910f3 Chuck Lever     2022-07-08  1108  			this_cpu_inc(nfsd_f=
ile_acquisitions);
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1109  		*pnf =3D nf;
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1110  	} else {
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1111  		nfsd_file_put(nf);
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1112  		nf =3D NULL;
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1113  	}
>>> 65294c1f2c5e72 Jeff Layton     2019-08-18  1114 =20
>>> 54f7df7094b329 Chuck Lever     2022-07-08  1115  out_status:
>>> ce502f81ba884c Chuck Lever     2022-07-08  1116  	put_cred(key.cred);
>>> be0230069fcbf7 Chuck Lever     2022-07-08  1117  	if (open)
>>> ce502f81ba884c Chuck Lever     2022-07-08 @1118  		trace_nfsd_file_acqu=
ire(rqstp, key.inode, may_flags, nf, status);
>>>=20
>>> Passing freed pointers to the trace code is a border line case...  Not
>>> sure if we care.
>>=20
>> Speaking only for NFSD, let me echo Jeff and say yes, we care.
>>=20
>> In general, I think Linux users/customers and of course our fellow
>> sustaining engineers want to feel confident that enabling tracing
>> on a production kernel isn't going to result in less stability.
>>=20
>> Thanks for the report!
>=20
> Your welcome.  What I meant was that it's only a problem if we
> dereference the pointer...  (I haven't used tracing output so I wasn't
> sure on this).

Following up: yes, the @nf parameter happens to be dereferenced inside
the nfsd_file_acquire tracepoint (the @inode parameter is not, though).


--
Chuck Lever



