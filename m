Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0A266447F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjAJPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbjAJPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:22:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B43AE0C0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:22:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AEmRo0028602;
        Tue, 10 Jan 2023 15:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Eyv8tFNhERVLN784cLQc6egj28bgjNKwAFP4wAqGoDQ=;
 b=ynR9PoD2R0gRskE97p5KclMHcNqSLLGlu/QcD+NCpJOsO2FJaocCo2nw1CcWwelqzROx
 Kt0lR8pIumDImPj3rBaBfsRHmpDALd2l+c8nzgprEUA12MXGtRS5Ik1fmhCzLIuD1/bN
 jnNHht0s3L7vaQIZZb6zim7/wws/1VowEKFQdyfGSYgHx5Tz5ebzyieOYoQOmqLFUaWO
 7r8ZVsBPP0YQD41mLip42DW1H1TXFSMkfaeVl1T/9iW/j9XdINkBd9seya8VzPwEh2r3
 vgHrbXA9UcAeksFUKAThRzrvXsQ5gNbBf4/3H/kaQPSQLj6mGoRgGCqjoOA14lYapgJ8 dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n19var4ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 15:22:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AEFPCd025402;
        Tue, 10 Jan 2023 15:22:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n19mckdry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 15:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNMYVuHrQKe95jE9ExGw0GyZ5Oct3L+t78MO6biaVfNkwggKysokL+mEEKFB1GKEXbmyP8ETH967etWvnuZM8F2We2a0h3R+iKh24WHQ3tS1ZGHUiz+LvMqggIx4ZVTJjuUY8UA3Y98P8Z4G3+GbCfaD2E+wzEewNS+B97ykI3SSHUnb3W8iyJDU151d07nKELs5frx43heuZ8nLN7cTNHrVD8UvyQUb5Sc7/3TWgFWSAnlVPNDuV/31NjzeZtXhL6RT0pdtO+N0Da9a1aOlWu445BLSxu+jZHdLJ6Od7dgEgjx8QGXl+2xMzSOD+xbgCB0XPHty0Vmj76bYNtN32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyv8tFNhERVLN784cLQc6egj28bgjNKwAFP4wAqGoDQ=;
 b=O4xjDT8cH6dqMED/SBYuUhcoIlkWCfzGmlcEZ/UrBSllhUf9JGVlVrlBTnQGXotG8SmKUaoVW0tHtwfGzznCACpLTAaFeDwHtnkBSjgvC9ezL3NR19sVJXKJHAvAF+CBdlp4APUFk6Vagxf9L4wyZIA89wtkflhea5CzKl3aTg7FyZa/eRHs6eBb4kohH8PHq53vp5QJdYB2UGqsYyM+/hgvZ5Al2ryfTUX12HfxgDWvkPXR32AditislEVrVjlbdlyksGhTGZR8a+JzN8gy3gLIl8FKvmSUqywemlSqyZO9cttwmEjsgSCjMp9ZgYUo9pr9G3/hUYa6ajmrdhTXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyv8tFNhERVLN784cLQc6egj28bgjNKwAFP4wAqGoDQ=;
 b=VUWc6XXlKCsNOL2r+fMfiF9mIuLrTq9/eGP5u6+I4zhy8yCWY9B9+oGfbheOpV34bQch4R0HOTwBAOmUVMxFIc0Eu3Mp/ggO9XqCllURtvyD4WWXR1TleGtDOF+tMuoTcdR6MLAx+gxncCf77uVt8K4bmIcAZ8QbAUcDirDlMyo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 10 Jan
 2023 15:22:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 15:22:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     syzbot <syzbot+502859d610c661e56545@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING in mbind_range
Thread-Topic: [syzbot] WARNING in mbind_range
Thread-Index: AQHZI/fWTFNFiUSqkkGjy2ZmBBp5GK6WIcOAgACj6YCAAQDuAA==
Date:   Tue, 10 Jan 2023 15:22:01 +0000
Message-ID: <20230110152154.fpydtasxppz2bx3q@revolver>
References: <00000000000053159f05f1cf4cad@google.com>
 <000000000000de1c8f05f1d566d0@google.com>
 <20230109160219.1bda9e780e0fdf7b43cd0210@linux-foundation.org>
In-Reply-To: <20230109160219.1bda9e780e0fdf7b43cd0210@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MN2PR10MB4270:EE_
x-ms-office365-filtering-correlation-id: 7b872b94-f1ac-4ce5-617a-08daf31e6c80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYgLtY8pfhL8OyO8qVDmcSr/2x90044kgSw80A4yQKajqbUgm7U0yCWILAVm+vaPFA6g4W2sAowS/xPDWbzwn95Bb9FX0hMmb5/ycHYm3vpbnVocFV9J2h2x1FmnuXIB/746pLEPyRGDgdzA2RjG0SW5ywsVQW8DQdDOVxIwbGU5Dj8FG0ADlaRCh+AE3GJn6zLZX9xreMDxA2EKmJsTNZv3XUKaJwzqcLePL+NQybxcK/b2YX7Ncp77KNZ4Z0IWdOacSSHYlGDFAqJSqKpLudccJeRIjDOuYDWk7WakEUxLvb1Hw2aW0BYQJziiOQM/Vc5wxl4hFVTXNHxDe0jfdNZ7cwlyIhGkYsmjwRJMcdc+EWWSoFOVKL2e7kNH0rsOvp+JsMeX3wkPmLOZzubjJCYbyySa9FpA3DG/8L4gepWj53DY6OTIdSNs8lMCkUF5lDvP1ijbAAFomYnHdG7mAozCQXH7+8ZonvyQFnKfzWPSOBV9J1dbKudmH1FNKV5ZIDi6pE+hRB0zMjbVRnf+aMNhmBqjcUZYE8/C+sxZ80/ilnUPdWgiTV/tz3RhSndf94uBwjCzKZIv+WAf3vvTr5r4AWYJbHUA0DW6xqk8fQCrpzQ9YogF6lxL2u3EaSrk/uqms2v0dGnZlVIesWUPvA70FjHE7/GO7MUEAoMQDMaR+7cqaFsC49JIKd24WiRXdzQvm9wwzrvmJqKVmiGdgDGzp6VauTn+89N+FNFzJCHXsgVTVHfqymF6rY2BRHGU5njIaihB5GjsybMyml3L6QJshMLjs5vb0RMmnsnMw8E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(38070700005)(91956017)(8936002)(41300700001)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(4326008)(316002)(54906003)(6916009)(1076003)(44832011)(2906002)(5660300002)(86362001)(6486002)(966005)(71200400001)(9686003)(6512007)(26005)(478600001)(186003)(6506007)(122000001)(83380400001)(38100700002)(33716001)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vpY5ndTSX1lzXcG/igSU5/OUK8Y9FcC62EfOBrQVpYddF6xPvsk23gnhpjll?=
 =?us-ascii?Q?86ruLbTNLN6Ot8mJFK1Ri4utskFDCmg137z+TTHQTQV2SUjzhDKiR0kb/nES?=
 =?us-ascii?Q?OytMD+nGJK/2w2xre23WdKlAto6uU09Ik+fotCKDFRCytFqwvt6jzuQSrby2?=
 =?us-ascii?Q?FCZttviV9Z/TzpkFbDBgyZnYpsZ1dkTZzqYJ2dbIuUaDBCtwXUpVl3c+owlS?=
 =?us-ascii?Q?7mDhVR+FpVPS3fs8gNJfTUp5qMUDmgMgZuv2pr3AfcEhLo6kIgzP15Mc4kYb?=
 =?us-ascii?Q?raLNNB6F/x3GtMbiCq3/XHGftjB9X4Z2WYBWFoskf0ZB9D8np4VCvuLZRCRU?=
 =?us-ascii?Q?CUp2NQLS9xE023/ZkCSjmtCCjDVEOcMEgqF76GPLUNVzWP8fjZf5y7EkmebO?=
 =?us-ascii?Q?U8DY6s7KKF5p5EU2am4zjkFad6Gvvc4QUsl08aE2LsNdkdbvWu0NRFEX/G39?=
 =?us-ascii?Q?aUz/dINlNGlzyitXPPyrWvH5JqBy6i8hD+87CquRYhkKFRMCqOd5eXxXDfuV?=
 =?us-ascii?Q?TJaMroOdH4KVVDzDEkKuNy0988rovA2e5C1zyrbIy8DdyKrMdVBim3crP1rC?=
 =?us-ascii?Q?PWcQ8jnztwXukHwvxt2XeuWMHApLZ+7rY37O/Z7z6juoDQPLzTayBYcYlkGC?=
 =?us-ascii?Q?xW6RqSKRGO/KwN0uvenjlKxeqJvh0mCG8NdEVmqqWUwMSmC4vE2BZtcN01k8?=
 =?us-ascii?Q?Vsd2TR/XG2NTGtIxwTebW0AL2v/m4f0q/Sh0XVxOU38KOCEE2CagRZ8s+1Fi?=
 =?us-ascii?Q?fYsXlwGN/DbqdiUJ7fcw0AiaByYvhsXIJyY8alRTuJYsdlQyWYKzf85draM9?=
 =?us-ascii?Q?ROWPZQtVNcE9taIqIeeVC6iwXUp0GUPWbhl9lzfANbKHk07X2z4U1IHzXPB/?=
 =?us-ascii?Q?ekrQHOKDpLSUBai4ldxKVogFnY9ZaUs2P6VfKog9MOrjxqOj2+d0DIeEfSBm?=
 =?us-ascii?Q?LuaneEANvwEyW40ofv4WxVxWpt7fWCcMe62HBIVspVlWClxiUYAX6xSJwa6D?=
 =?us-ascii?Q?vrDKkOpY9Bj0udXFRBAzA8a9n28g9EXFXKR0fzP4fKlEFD/2xtssIo6WJdk3?=
 =?us-ascii?Q?tk043OgkwRYi58N5Prh0ZvJB9FBRSZzeZ3bS4TZWhEIWtqo3+E6+nAZnKUhB?=
 =?us-ascii?Q?v2hGi9QGAjZdDWwUM+iCg58Eh2oldIhFY9PoGLHhaLqnX1ao1Yp837pzMPQj?=
 =?us-ascii?Q?YXJaD2V7UQy/qXrnl5Brf7uw5I5MOgtVNV7Tzt+OwhYRCTQ0oKqJq//r/8aI?=
 =?us-ascii?Q?XcahB+GjRdNyksVK4BVVBRK4IHKrP/krN5ciM0X8N5OvhTNGz5xrg+HVVZNt?=
 =?us-ascii?Q?ejUc7wy0y7Nz+uU0N4lkFvPtrkpqDMpvMN7cUa9f56E3fyTGpkYsfg62O3GW?=
 =?us-ascii?Q?M6pYdAo0jpRb6CKcm5H1/k9IVKeMyiC8x3inewI1gSYFW6vtiKF1qSbTkLVk?=
 =?us-ascii?Q?cXoHI8V67lyw7cqtEkbkUOpV/F9K7KENn7F816QokVALIgx7D0E1zihXotO2?=
 =?us-ascii?Q?OFBsqm848+D89efYqcbMKqIh7/GeVSFfq6sLlrLeom4k5CI9HEUUwns8rBOf?=
 =?us-ascii?Q?K9wPehZcOlXuaqsI205cqeNwoy0tKtwpAfO2Qr2mUcdIq3cWw2G7yeke9V31?=
 =?us-ascii?Q?lA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63458B30F951B841828871D65F081360@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2sdalXEN33d269hgmLPmUgfBo9tk6aa/LBUzmAjE3IPcGhAGLq7+f7vcPBsV?=
 =?us-ascii?Q?M8UqXpym894/TqLLYn3zMsdQiMJGFNAetDvHqG6xL/NmOrUIbjqA0RPqsRx7?=
 =?us-ascii?Q?5JgDwUJqXW/luk0nuD3yVQl1PPtXcjrovuqY6a7JYqF5rP+hLh5BNMW7b7IA?=
 =?us-ascii?Q?HP0jfNiajPYQ/yACjA91FbOTqO4LhfkrSC4bnIhwXFlEODZUwOCyiJqe25sJ?=
 =?us-ascii?Q?rS1izM4vrVkN8NbzaIgs6ooCcWclKi0+Ou2eUzZtxWES+Sv/Q35yyes74RLs?=
 =?us-ascii?Q?v5S0Bae6qGWGdP+fojKptxzhJyb2FkM54ELHPfnhkk9LWv+PKAUAH4/SYTux?=
 =?us-ascii?Q?wRxwvagO+zOjd6La5MSJrU8nF4u2TENbX/joKWok3q/M8h30MVWf1UlSVhjo?=
 =?us-ascii?Q?y5Burc4EJ41EpJ/btr+sAaSxO48EJd/0OTnznPRbyx0mbJtbuRxKhxuHr7mr?=
 =?us-ascii?Q?8FNAumBF4Anbvrykh8WyszK2TFV373G/5yVzQmrGd6MF8h9jAD0Mos87mWIp?=
 =?us-ascii?Q?h1qeviRv5++w5MMkqz4vhYFdNMgFWjOHkgi6fcbDm9MoF+WyOWYjYK722fJA?=
 =?us-ascii?Q?miXj8zJTACxtzlj1Wm5vpIY1LgHFUOBZt1uoDROAVFk9ycKcU4LTiZyrUydI?=
 =?us-ascii?Q?5frkZz6Hlr6lb6BAPg5y/HsQbSiKiaHQAqMU5itEh4DpS1UrhRul+q1GBRwJ?=
 =?us-ascii?Q?g+mmv4wA0Pyk6ZNoR74Hse132xwG1E1mLw2zqP+eezTwdNhlMCQ8S+awz+gR?=
 =?us-ascii?Q?SrVYz9XfUgVCDfxtdIebOjX81AHvC8VjtbbDG6wyWgcPMM8Dk056XFPA2yz7?=
 =?us-ascii?Q?hWnpQUgDcqjPNCAOJMwbBc8Jcd82x/hy39skk+sq2i0YXQpyT1UdvXS+oRjx?=
 =?us-ascii?Q?JzFI3Zw6+9oLmvfZZEzOqI44OxA8fMh5yp6u/kMbeBRijGk8gERmXv+NyO5P?=
 =?us-ascii?Q?HZvrU8LIVA+aPiWMRr/hnA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b872b94-f1ac-4ce5-617a-08daf31e6c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 15:22:02.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FxD5yuI6JXE8Wi59oNNSpN1+1BI9ByY5vXA3wBrshHlc1SK/UT+Ett96OlqVoJKxJ2v/N4ksaIybsUoIyYAJYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_06,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100095
X-Proofpoint-GUID: ul1cqYA8KIHY3Z118dD6RPBJRoYmOIjK
X-Proofpoint-ORIG-GUID: ul1cqYA8KIHY3Z118dD6RPBJRoYmOIjK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230109 19:02]:
> On Mon, 09 Jan 2023 06:15:39 -0800 syzbot <syzbot+502859d610c661e56545@sy=
zkaller.appspotmail.com> wrote:
>=20
> > syzbot has found a reproducer for the following issue on:
> >=20
> > HEAD commit:    543b9b2fe10b Add linux-next specific files for 20230109
> > git tree:       linux-next
>=20
> THanks.  Will you be performing a bisection?

No need, I see what I did wrong.

>=20
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12978216480=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dceb6f70a080=
e19c3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D502859d610c66=
1e56545
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D117fcc024=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1396d7d6480=
000
> >=20
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/22f2428ec2eb/d=
isk-543b9b2f.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6003c7af47cc/vmli=
nux-543b9b2f.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/ac9a6ad60347=
/bzImage-543b9b2f.xz
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+502859d610c661e56545@syzkaller.appspotmail.com
> >=20
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5072 at mm/mempolicy.c:797 mbind_range+0x5d2/0x760=
 mm/mempolicy.c:797
>=20
> static int mbind_range(struct mm_struct *mm, unsigned long start,
> 		       unsigned long end, struct mempolicy *new_pol)
> {
> 	VMA_ITERATOR(vmi, mm, start);
> 	struct vm_area_struct *prev;
> 	struct vm_area_struct *vma;
> 	int err =3D 0;
> 	pgoff_t pgoff;
>=20
> 	prev =3D vma_prev(&vmi);
> 	vma =3D vma_find(&vmi, end);
> 	if (WARN_ON(!vma))
> 		return 0;
>=20
> Liam recently altered this code with "mempolicy: convert to vma iterator"=
?

Yes, thanks.  This helped a lot in seeing what I did here.

...

Thanks,
Liam=
