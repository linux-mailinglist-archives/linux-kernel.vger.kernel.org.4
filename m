Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3D66E0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjAQOaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjAQO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:29:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7985587;
        Tue, 17 Jan 2023 06:28:52 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HDYTHJ016614;
        Tue, 17 Jan 2023 14:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yENRC9HhlkPXmLK4JMBMMlLITKTVHCiwFEB6/ZR9JZ8=;
 b=KCovLiRDSLf4xj21DN/Mh/HeL0MW2kylVInoJRzZxyb///lqOb6RtCIZKDckxuOSkzSN
 2Qz5ueZN9K1/KYpJ4x09vpQsBl6QB9TxKDa9beVAEIbDurQ469D1kk05O3IiPUUqr2d6
 i3tAUl34FrLCoy0ToE0kDhvuYYNnEx2PPRja7PUF3KjjBwncG1lmg8sa9ifKkQNf8R2T
 iBhERcobvl4TePAB6XoQMgh5c/SNUS8sOt/kA2Njm3DfKM1YEiqH+lpXF/hUjPCCtr6e
 7ISJjZDJ+Q9fWJeXwaZ1xMnY3G5/kQt+zWJV2X/n8pVwn4Ey2xnqah1jBOYMnr6kirI/ sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdc9q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 14:28:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HDIk6V028361;
        Tue, 17 Jan 2023 14:28:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2s4tfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 14:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJo4ZWb7/7KqC/tDNtrXCI8i6M6K14AiqCboNzPgPBBsfwr+JKC/n5sCDKLInpdBaSoVLxiI4FnBMWvr0z46IqfI/wGP+Yvaxmx5cyfxknSLMfPp/JDnckUtpHAhgHeWuC3QaQkD+NA9CxdXUP3Meg4m7acUjvxKvamxL4A1y+D8BlmD6O75+pIinabJV3D91iyFSHiqYTY22ymE2LOG+AV5smx4cs04qYYdO09gErMgklhSYX/L4vT5shR+IlCNK8ginNpT9Q2JgGN22Yyy+ob0pA+buIVycMIaFzXn9mKQq03+Z4Vz6f8N00VtHxiA6pcgP0cQea/5znfUbM1cEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yENRC9HhlkPXmLK4JMBMMlLITKTVHCiwFEB6/ZR9JZ8=;
 b=A2JYE0ztESDRHanF+EbqAX4WtvziLuwHtbDQ5eGVyh0vmmCrO4c06EI69kquqHyWZQzIzahfkPAU2hjRWS0v473SqFJ/YsiuV4j7Isb2bxa9aMViE7wgrKa3vJbfTGyhPEAqfUGBeLXuqjU8X5lPOnGB37SVgnaVMRuu1C/TE8T6Y5YeNREkDFWnDaBqtwMfSZbGEe6Z7hI7h1AfWurAhAXml2YZZwYaQdffIdYtEVblW5ct0pESrrgZXesHpFL7D5Kj2hh1qqqazcLrJFuy0kxvwt0g6zese0CBbVbsU57+vcv6cBqXbL91dE6fUxwplAbIgbbn2xspaujdVle7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yENRC9HhlkPXmLK4JMBMMlLITKTVHCiwFEB6/ZR9JZ8=;
 b=LtLQf1QPcQs7z7Px84yQeni3/oN/fUQZ4B0X0mXbqfc+OnpflX1WQlSPNseGzAWhi6Blvchi8yJntMsSRfMW5nyGhBuRwO5as/anqSkOyCuQCqj6RwRDbYdwZdKTqtLDWEnufS4YHrDawE0+mkRRHVQkNExI6H3MDCuo37pV4uw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5872.namprd10.prod.outlook.com (2603:10b6:510:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Tue, 17 Jan
 2023 14:28:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::d8a4:336a:21e:40d9%5]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 14:28:42 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Thread-Topic: linux-next: duplicate patch in the nfsd tree
Thread-Index: AQHZJtuHjKaXgt/yjkWRrCUo/8ISo66bbLAAgAW0fICAAK0OAIAA5AyA
Date:   Tue, 17 Jan 2023 14:28:42 +0000
Message-ID: <C72F2CC7-EB89-44D4-AC4A-C33EBED4B120@oracle.com>
References: <20230113101326.09b1250e@canb.auug.org.au>
 <53DEC27F-0AAC-4EFA-AB6E-0B5D44AACFB9@oracle.com>
 <F7CFC18D-6AAC-4DAD-AA43-5C718FC1100E@oracle.com>
 <20230117115228.13b55d07@canb.auug.org.au>
In-Reply-To: <20230117115228.13b55d07@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5872:EE_
x-ms-office365-filtering-correlation-id: 8de61055-2f39-4b96-44a1-08daf8972207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Xnu67UcLoGFCtoEH6eFlvNWwSAO7yaBewwjQeClRawWNwpJFA19MO3kSkbpfd0CkWQCm62y8ne2pSJYFLXw0lLIEX7j1EoIKU3BxI3w+03u92dTmc4kC0sjsl+gAEH7GsbN9tro1WtyMgS+FkzFUYjT2joT2StOUdhN3PxfD00A/tmMorZ4mDQRuJ819ttb/psXNVvhulUPA+MVKys3GTiRQTSOqqg2yYmTyGjJDgQdYP65kR7mYeob+R8Pdzo6eU1hRt6U0CvWeLpMNPcItwKBXPi0rwhxTrftSgyIohhNuydLe9EGsRi/M/a4Nl+j/W0rSW01MBpwvUSya9j/WhpnjkqBLHuwJdP32YSPHfElcuuiU4PN9sG6Fi0O5ldowh1mTaq1AHV4MjYplGQwTktDWDrxvD/GOBdrqpzuwjRhmmP/1zvLFs5UO6YXoE1ysxWw09Lng3EJ0afebFTSFLg2hZNYMABzInUGFuu57+7CAt3ilV6Ycrxnb3qX/d7MdgJNerK1mrvnh5UXI6yaL8xHmERoZdzr0bljCwREbXf71eMCOcGcIVbpb+NuziscAusOtOMy2qVP9wlphzsFx14Es5aXFjtN6Gxt4uCZwAmqvP4U8Lckn5aAUL+wSB6B/iPX6MjMfHjxBIeKd1rLktPqGI0MnAoHMT9zOVrxhAQc4UWkyJNLzci/PlYEBMp8j10wTFHWns3jn43biJvGEJvQSEJsG3LQRXYl1a9Wp9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(54906003)(6512007)(6486002)(71200400001)(36756003)(33656002)(478600001)(186003)(38100700002)(38070700005)(122000001)(2616005)(86362001)(41300700001)(2906002)(53546011)(26005)(6506007)(66556008)(91956017)(66446008)(76116006)(6916009)(8936002)(8676002)(66476007)(64756008)(4326008)(66946007)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SX4Fo2a76K/TcjqPgFmjLjSNVOKZ5dGPEUNg6EJ/+Ur2eMsCzW7L4BuI8Zat?=
 =?us-ascii?Q?IOTFGyfWFbs78YPgjW1v43vQU7oMZruqMjgoOXE3a3m36YJj0P1v4ezKmGL2?=
 =?us-ascii?Q?hp4/zyvSTFiJiocBlzKeJ+8u1GKJIEIT84Pq6mTrhf30WNISzWNGUQOmf/B8?=
 =?us-ascii?Q?Vqb9r5+x83beYtUBKYeR4aQLSJ0AMMpOBYz0nVO62onBhYOAaE7GXpBnbEu+?=
 =?us-ascii?Q?DvXroRzCXQWc4dMWQBln8nn9TXepEJ0WqDpsrH5ZNW0iTqgTbyaKRS+uLR+K?=
 =?us-ascii?Q?YeZyjmXhR9ttb3RrrqpliVCb4ZvnTp47VUBnP582FKWSI0d83kUIcil1o2DP?=
 =?us-ascii?Q?hUSSBKhsCnQXZ/0C5jW/OFIijv54CaraCUrsu00CRnR89pNgM90QMkEJ9vvA?=
 =?us-ascii?Q?MHwD8zndVcPsGYiukpA/LP9BWMgIg6V7Hf1NZL8PKwrY/CWlt9w44chmCn7P?=
 =?us-ascii?Q?rvtcfvpUx+qf/FIixZBBsW1AxGs79V458PeKbu1b1QJWupN9Xi4Jn54khfi+?=
 =?us-ascii?Q?Xihkpwk01I2AoP1D2CNlaAEnycBPUamok1kcS0raXFPwsvB6AwlmCUelQiHM?=
 =?us-ascii?Q?kVfrx8wSnTpmZOiVZmFaC2/vBlG0zXbQg5TfJ9SIoRwbJpyS0mLMZfF53HNW?=
 =?us-ascii?Q?coUqJe05eruGtBqzmIUhPMfyt82GS/P4UHy/LjPlQk/Pk6m8C8i+CCumJBbO?=
 =?us-ascii?Q?3jPeNoLE2d9v177/Z0NAmjSA3MgsVwkq7XtEFVe/IFWl4B8VyFImXjo7vd/W?=
 =?us-ascii?Q?XwOsa6ruGTfX7xbxLWS3XSe4YGiYbGwAeNgenY7sNVKZlNqrRVQlu8zAOoTK?=
 =?us-ascii?Q?d71statz09OJJ3KjmV/wu8LdjfNzO6y90/beJgSsaBAoFqjgTTAHVQS55zO4?=
 =?us-ascii?Q?pi5JT3F/2uj+WCJQmpO9JGULrHo0LzCjLUnNQYZTC/NaS3ZVWsGre5Drtou+?=
 =?us-ascii?Q?yWlUgn6pqF8uPJ7TbPGs9YG8x0xi5MrF5Ix9OW9fIUK7twllBul65PZSOrQo?=
 =?us-ascii?Q?RkCDWV9KgYvB6BweEs86NL7xIgR9uQWZFiEXl16dEfhXIvDNTD7Awh+9fote?=
 =?us-ascii?Q?/R+YFngy2+YNlGF2HJD6vppZ1FJU8ijo6jW5FzkRjB24ZiFyCvJKiPyMo9Zi?=
 =?us-ascii?Q?83XKwda/wa5rAWz9FepisnZ+nG761S0AdR9HmpvpNUt5vRSKhNzQ7xIqsLF6?=
 =?us-ascii?Q?L0ubEz4TtoCqa7Vge/Ocy7+EmeiN20KCLHvrCs8jMXoakSw/wAoLmxHcOkfR?=
 =?us-ascii?Q?2dDfw6+fwPy0TAY+LXDXSUB+jjP3H/G19ejlrFT1pLJ7dB4oi7XgWEzYgciS?=
 =?us-ascii?Q?+HVNavcvAVZOO/uHzKJE/Vu2oftZ5WobXpNp36DAkyz2LZEeChdlJKvLxy0a?=
 =?us-ascii?Q?CyO9MaSMtgXzVDeFstEK+a+RkTwPsM2mrU7XNZ+cUXJv9buw9Dr5XIOYbUXy?=
 =?us-ascii?Q?+TLExnrvhiYyCxHOT5eZVBwCvQXwFsMkLglmxxzhCILAcxzoKHjGQ4jWXacG?=
 =?us-ascii?Q?mfPSNuorIo2PxiT5aiuAnxdpAJ0U0AUWySpN2qUe5ovLlCE0LePiGeKEoQIN?=
 =?us-ascii?Q?JUnthT+ZfikxP5ZF8FX9DEoxQJ+6GYwEuK2NaWBzU0NHSFTfVGLq2LwJ6wa9?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F43FC67DBFD6F4ABCE7B6282AB06B39@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P0aRTDA0T2I6bA12pyem6kqLXOXlvpbxr3528nwQO3Rk6AvQbtsQMBwdXT+IPx0JeDGWqEKYT/ndWcXTUZQHczAecipmIKidn8ylZKPMO91aC4zOGzeE2Easxqc6NYdHzE5+d99WRHHkonBiyI2TVbEI/BLDXxDq9i6I1Qs+kUXMNJh78Xv9WZcN+eGlYC80JD6BBUXZa6dPsCfgIsrznEV5/DuC2WcIWZOWl/hoNc7ogzOV3OTxiSB0qbDl2S6rKlC/kuPBhvy41ymhKPTPF/ydXfChEAiHzZbU5MUiVFds2Bxf8ab9Y5kq4OEUuFXQod4N/2XlbH75EF/F/3RYRn3OLCF+ytnw9zbzuc6zV3zqDzrGMM1/8iXodDFCfz1usHmrBQhDsjeBrwwHJG8ItmooU9mhvYs0dJNbJaRmN8FHG0+stChp3rEuIq6OvLgH94YD1d+KxiN0YykBic/895hdrG/CEWmSuTx5FpAojzD1nT7OnjIx3z8Q/Fp2WfBEqrrx81U/cvm7enYdvn6/mN5LYaRyR7pCQyeAGzTMgJjUwn/I6qOiO74Le9cl1VrTMqTW1eTo5IUFfLVO3XoQxISNyLTnQXxbimcO3VL3ahArxpWrZ/Dj4VSCRFz7v5NpQVxevWbCqsHktWHVbnchVMv8mZhMqiXTefw2+GuFViwHQAVWGxQfSKbDRRMc7JrJaAyAasS4X71D8qKiVfYOY5KwpyN2P8PuVtAm68aFO0VYiA2RlWMms5wwvUxFJ7Oij2AZ9qazd+EguSJc7Luu9PF9ztk2XFhAJnAJhHl+4RmWej7XgJ8GM3D9LBB9WCyn
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de61055-2f39-4b96-44a1-08daf8972207
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 14:28:42.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbhGzRUFqOuhImRuTnxLyHCiyxVALaPB2C5PrGiTc5OT7NKjtvT9VPCFs3ButlGgYI8xxRU6o+0ylawdnbif/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170118
X-Proofpoint-ORIG-GUID: 1o6zI8Gdeh9SnvppFyTvaNtrotjCXp2h
X-Proofpoint-GUID: 1o6zI8Gdeh9SnvppFyTvaNtrotjCXp2h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 16, 2023, at 7:52 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
>=20
> Hi Chuck,
>=20
> On Mon, 16 Jan 2023 14:33:06 +0000 Chuck Lever III <chuck.lever@oracle.co=
m> wrote:
>>=20
>> Sorry, I wasn't clear. I need nfsd's for-rc to be picked
>> up and merged into linux-next before I send a PR.
>>=20
>> I've trimmed for-next to temporarily remove the duplicate
>> commit, so you should now be able to continue merging both
>> into linux-next without an issue.
>=20
> I am not sure what you mean.  Your for-rc branch has been in linux-next
> for a long time and the current version (SHA 7c24fa225081) was merged
> last Friday.

My bad. I was looking in the wrong place.


> For clarity, the cel-fixes tree and the nfsd tree are both branches of
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux - the for-rc
> and for-next branches respectively.
>=20
> Maybe I should rename cel-fixes to be nfsd-fixes?

Renaming my source branch as well would make things a little more clear.

How about I name the branches in my repo nfsd-next and nfsd-fixes?


--
Chuck Lever



