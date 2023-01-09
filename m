Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B30662B9B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjAIQrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbjAIQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:47:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEED3E848
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:46:08 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309FQU3S011893;
        Mon, 9 Jan 2023 16:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hfLQIbE9mlSdMmFEQmfzoa8YnS5v3NohQriQSDNHaRk=;
 b=SoQa650Ef4W8RopHZcTppCH0bNmVR414RBOJubgcJLU41txWleEa9ZPZ9BrVqJTvUj0m
 lsrmjCxW9qYp6a1FBMOMEid2PBnSYVITmnf1P3X3hFwt9ZalZZ2dovB3yjpY9B5tokAq
 2yjgsgqkDw2I4WRdYhOlaJhqasYuFveB3I/bT5Muy7QwY50F4S4Y87Ydp3ZNvvQrEH0F
 GqNMgkzrYAGkZj1sM1bpM7QrG6P5lul7LTqsJadJula61BvlhsS86rzceckSGwUZknbX
 LC8SYdAwuhHZ2tjguFzJUYEMsf/TT+jKdD5BehSWmmfD7FA03QpVNHFsmE/radwpbv69 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scb6pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:45:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309FZLdi002455;
        Mon, 9 Jan 2023 16:45:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy648c3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjzyJ5mxqnmqtC1VX02RF/481AWhPz7cndjnAJmM2lUQNViV/Z+cfvSDS19Pa+7cdpJpvTb2D7qrSGzG94ssLQ60hyXohf8HjAszdufO+KygzYpWGsETdnmF+9BasA0QbZ/ebnjropDYKO+T6SF/Uy+rBqm+40+qjiMitR8iekPoHBp6h6MTV+tPME+VVarXiBMqWjqCgvOnW3RFlu3muVKBbFVabM1/KilB/nKKOEVhJMJwmLG3cKpOSKmhGJ2tpo3wwR6s+LUDGbrL0L11A/WBWpiybM0huP+JMVuivSWXmdC4nlrWeVikRauaDUAKYiVaugLg/YlqHp1TEZN0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfLQIbE9mlSdMmFEQmfzoa8YnS5v3NohQriQSDNHaRk=;
 b=TpmLHijk1Hfvuiu0LkMsS23vVZoVM4fDjdhibV/sivqiTmcIeB9XDWEqsYVPPSg5oQiPuh6XuQNe3dmqTOs5yfNtV3drt/AO9FZ8WCIy4VC+Lquzq7UgSp9Kj1PLUIZqZiFah7uS+u23b/mgT10k3ecCDum0Y0ts2Mnv4QPG2vpddL8tvD6JOSpMoR+oef37dIChaNYzrv59lyOsKt+JSEl/WuHNzBzIYwse2kZrA6TWxxd1nrpszdglN7FvEGR4FpyN15XBaUfqDJgBXI7L0dOk4Cjqjjm6i+xU1k5q4je4LKiQU58ynAsvL6QFoL4SAV/01ui1MnSvblVdHdcM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfLQIbE9mlSdMmFEQmfzoa8YnS5v3NohQriQSDNHaRk=;
 b=qoogeSPQIhVLpOAt+8NUz3/muXetK8KnuKGnqa4aD6frqbnD02KM4ZAurmES4Dwq90RuZUQnVfqbwfti1Sut5Hq+WeZH7wqMKVdGCUD0lM3aQ9zlDT2R2AfGMzouJSyuO+NpLVJOKWdWuNaX7dwW7/CwCDpbntWfJ9h50eOr5m4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4364.namprd10.prod.outlook.com (2603:10b6:5:223::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 16:45:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Mon, 9 Jan 2023
 16:45:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     SeongJae Park <sj@kernel.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 22/44] mmap: Pass through vmi iterator to __split_vma()
Thread-Topic: [PATCH v2 22/44] mmap: Pass through vmi iterator to
 __split_vma()
Thread-Index: AQHZIToky9xKc85E+U28OcnfnQqIUK6SNXEAgAAKwACABBDvgA==
Date:   Mon, 9 Jan 2023 16:45:46 +0000
Message-ID: <20230109164533.3qkorup75h3zsi7t@revolver>
References: <20230107020126.1627-1-sj@kernel.org>
 <20230107023954.1841-1-sj@kernel.org>
In-Reply-To: <20230107023954.1841-1-sj@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DM6PR10MB4364:EE_
x-ms-office365-filtering-correlation-id: e8d671ec-3d6f-4e50-a3a6-08daf260f4ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: abJPBSiZrNU1ZIyTDpp98PBIb8B5NCo7+xk9bE5zrbuGT4yesaR1DZC8tpOdaIold7dYR7CxVqSz7uw2S5LQ8AryoGgFufkim6C2GfasUS2T9Wc9b55/InxELsh/hWAk1nkB1wKrlJcFsdfOCrDWXEoCdn/CzBClnPKVQHQEa/hU/oF9p8jOgfMEGMvslPuWAQehADp1Dg3jIXJiFa55QPfcwywLRC7kmekwf7qHqIrNP9OWOi8d6ejR/ZFIed59u7l1877DgyOtu11hikfsZ4ho786OwEfjxmKBRnpHi2IwKPAvyZypL+i7Ei+WBoX69cMqlu2CDUVl+PN6MhyF0w1qyw56Oen/miqPSjaLYk18ThgVeH24gaMuOamxNbnOrTKtlCti4sekT0OCRlombdRFQOEQc+Mm2QjgmwbLFEQKZGOS4JVsPZso6X3FAfaYINx/3Y08mAhM5mklLyiMU8BDXyrGfykkd/LEf9zIwbl8PkwA9SHPEp6TNo8kxQWaQV35VWv7TmivBRadUY4+G5S7qNZDrNJa0AIbjqnfzKGGFb3HgVq7gKyFJgdaZKUl7GWoN+Ha1bS19ESPsPWPXEjXNycfw7zV1TFOTlBKa2DpQggGUfqANNswxFbf76xBCyzoG6n6Q7RuIKhuP2Cbkjqq+WsAX52NgwOCikC2GczQzII4GM1noAM1T8LzpMCwEE5FExciId8WYFoLv+xojg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(122000001)(38100700002)(83380400001)(86362001)(38070700005)(44832011)(4744005)(6916009)(5660300002)(2906002)(8676002)(66446008)(4326008)(66476007)(8936002)(66946007)(76116006)(64756008)(66556008)(41300700001)(1076003)(33716001)(9686003)(186003)(6506007)(26005)(6512007)(54906003)(91956017)(6486002)(478600001)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fvcLvrbjvRaMDaaV8r3CPMjU9XkNk4mMn11VXGb5KIswsHMtTuDXj/EvYgzW?=
 =?us-ascii?Q?D//nvYaUNcB6CmRmUTZl7Q1AOJxdEXk4+882b58ts/79ndG6q5XqoO5rhNu7?=
 =?us-ascii?Q?MPU3/l62TPSAmVHIk2Sc3C1SssdLGqDo4zXc36g5XFdpgzsYWnhFHxlH6Fi5?=
 =?us-ascii?Q?W7iH3Sggm5Wl6Sg9hyR2s+mOPfhKOGfef7Su17uXTgncWqVliGxUcrBuI7Bf?=
 =?us-ascii?Q?6Wlxw6GTbPtjBFSxJyWJry8gcbJJp8lamn+lRRf8E5rb76qmQ66qWm+0KVLt?=
 =?us-ascii?Q?R5ceCv7hAouViPCfyB23PVlmiGih192n8sC5mKTvcOsUOG4Z2gKEbSUAooFD?=
 =?us-ascii?Q?1oGVCbD+jqKFBCB8jK4cawc0VtTZO+PQT1wHxVyWlvCxgHXEXgX0tE7WI14m?=
 =?us-ascii?Q?giYKmgcDj2Jpka+ScbgGNxsOWSw3G7UkkmQ79IJEnBxHCe74s7u0PKV4DVIo?=
 =?us-ascii?Q?PC/Jo105inCKKznr4EbTHf1e7rq8+SpIEpVjY/SJWqpQ5V/b/bGonYa3dfp/?=
 =?us-ascii?Q?7YuHZBE3//sA1lu29vuuoU6e2fTcMoDpSkgIURpK3XiJFe9a3TrmuE8SceYm?=
 =?us-ascii?Q?dyQR0hPtDxXgxcoqqGr+r6FvcxhvF10x7X7l99OI/PL+ZyraY9ofxToy2VgR?=
 =?us-ascii?Q?3WU73oVUesWChb7iilXMC+8Id8TDwY29r+oucOm653Uddrs9tXzOpzVhcLE4?=
 =?us-ascii?Q?QPuqdyq61tB1aDtvh2RagY4f17WKL+csptpaM27Z4b/Crqgar/0lfljsCfRU?=
 =?us-ascii?Q?axkw8d3SpTghKypoYuSqzcS2JrFcrSqW2gO1MLklJgPsOWeLaRc9P1tuTJ9U?=
 =?us-ascii?Q?qgmWlgg7+PEdqMG2jHWe80a0Xw1PdZwjV3G4N14NGb6xDZNX7u85qnvhZ2e6?=
 =?us-ascii?Q?DlNJCAutJVSyK8yl1cL8ulAVTYdg9YcRepTBYyOLgAZPWJvzDTu67pxKXPfV?=
 =?us-ascii?Q?HV3+Eaa0pI6XpMugncVCFVpmDPFu/8zlnCNADk/C9ru4MNpQa/WZ7QVhjxD8?=
 =?us-ascii?Q?9f1XmHgGHrvX5crfT1yu2HznRNSZVX8y6uM2SMnQKul7K44+nlw3YKeCxgE4?=
 =?us-ascii?Q?V1I8n0t0MHyxptMjPQ42rUpcvTDxshOAasdAiLXb0O51XjriI6IfIr2YeFpo?=
 =?us-ascii?Q?I/GFGES93XHCJY3IrxthgnoZYwwfemmXdPWe77boh/iEsKHHoWAtjBXVzBqY?=
 =?us-ascii?Q?MINvj8lDWMjc9zwLtL/QT1XUZhCOxEh7YafhLuxplTf/ChTMcSEbpndKWwla?=
 =?us-ascii?Q?mF7D4yjvYOROX5Or+1DGooufuB1mkqSOX4lSxOcXAaVcKjoVpHtc0QNUyWDw?=
 =?us-ascii?Q?64efFwGgp0ZM9jmn9qQyktY4wC/hgKx/skYNk/c6tnb94u6FYh47OyViWwIY?=
 =?us-ascii?Q?NoThH2IcdC9OrIFkZW2t52Pp/0kCjyjCK974daINb+Dq2/tssONVIOBRegtb?=
 =?us-ascii?Q?TJtNzAmNGMX71ve94t/dAJzle7I3ajeJxvkh5/DoEtDXVjIarlhHGGbpGDTw?=
 =?us-ascii?Q?qUQ3z4q9POJhzA3mQq9vgaInuw5ltwEfAVN4G1YaTuQqSsA0glFaSUpfn69e?=
 =?us-ascii?Q?JpZrYok783mV1JZcFhvvFvdeK6U/xIcZo3lkg00qR+/yLli0YqK0VKFZgkVq?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01F0984641511044800461DD2C12A8C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kR67oUNiszrYxMEk1rk9eaKKVVayuVTqqRkeCVCaoaloAHTNRmYuuKgGo4bfoDiA1bnfALuY7OopW/4g+K2pPXwzJ7ptgqHTkx/ug/VAOa4LFD0ESBBA1RC9FYAtMucHRUJe8Y+ALqiGfk3FOUA1yon220oSGEFRCAcWyFraMRZrazoFXAFwdPPcE8DV/MeAvpj8cnH01kxP09GTUMV5lkXct/aspyGCQsVYPNb955ixO3EoLGbPCGCyZRpg0xr9ruojL0kPeFD/Yxfl5KBJEWD/vnsQsiJhCxvkYYOU0M/cHcf2u70iSIzo6fkKXYY9yK2b0JeZqNCS43l6BMl4I0iMPCKBTONVd640+TEn8TqvkrjAMD1loyceMk7T2ZuWq23dGPpfJtSij73Ec76CWKgeBjegEDnY1EelTznaIk5aEuO99bF6HpPJ12R/J81BnQjPKzTGQlZOKo5WQwxS7sp+6BBgP+mkbJfLs/e5o3gHcDFUxwpCzMV0INcra7YJgoiQN1hyFwf5xKuj3cPFKqouKJ9MXo2NLh6V1t7+rgEvwwsprSTyKee+I6spw2Ox4VtFarPoa8sUkvce7GigQ4x0jD94pWMIHjf5VqLk2bFkdbysvilfno1qSTrTXqEJiYS01RV8lG0A5wUyMeO/nn8UYrYJvAoeVRw+EFQF6WEniTR0saN850Nbtjw2fpntdxGLQ/7HgCwhpfUzSHMglaPH4CFPIS1xts3wfGG3A2RIoVHlFb1DyLXHdUx9+4BFJolRsq39TGFj+RGMmzUbU0Eyjp1A1lgPVOBDqpY4bYS5UQelkTtMj50sutKPAWOrh9/np44oB1l2hB0g6MMG4WEqIgwiWXjgNY6yWDdMrKIQ0fo7EoppiCzJv0bb86FMHApi/8vsHL/a3AbfLXGXIpw8WjZJpyoUILk1L0SldE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d671ec-3d6f-4e50-a3a6-08daf260f4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 16:45:46.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaf4PkYxj0HahYhpjA0hRLg2iz/lGafqMnzzlTCjBROkG/tQXo931I7kL9Xp2RpYoArcNniflDu6EworVKC5ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=550
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090120
X-Proofpoint-GUID: _cXL11IZlB5vPdlHH4ofN9Go7OtXcEsB
X-Proofpoint-ORIG-GUID: _cXL11IZlB5vPdlHH4ofN9Go7OtXcEsB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* SeongJae Park <sj@kernel.org> [230106 21:40]:
> Hello Liam,
>=20
> On Sat, 7 Jan 2023 02:01:26 +0000 SeongJae Park <sj@kernel.org> wrote:
>=20
> > Hello Liam,
> >=20
> >=20
> > I found 'make install' mm-unstable kernel fails from initramfs stage wi=
th
> > 'not a dynamic executable' message.  I confirmed the issue is not repro=
ducible
> > before your patchset[1] but after the series[2].
> >=20
> > I tried to bisect, but on a commit[3] middle of mm-unstable tree which =
this
> > patch is applied, I get below error while booting.  Do you have an idea=
?
>=20
> I further bisected for the boot failure.  The first bad commit was a8e0f2=
e12936
> ("mmap: change do_mas_munmap and do_mas_aligned_munmap() to use vma
> iterator")[1].  The stacktrace on the commit is as below.
>=20
...

Thanks for your work on this.

I have found the issue and will send out a fix shortly.  I am not
handling the invalidated state correctly in the write path.
