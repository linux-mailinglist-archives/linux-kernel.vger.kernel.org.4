Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F70681FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjA3Xb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjA3XbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:31:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631F2B2B6;
        Mon, 30 Jan 2023 15:31:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UMiEZY030134;
        Mon, 30 Jan 2023 23:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bXxBNafNf+g8HmykRnSr4IvUcf5G/vTxBDEcPcfwQ44=;
 b=gd9mRve3w/MJnw6SXqhgscVe7p8cVWfLW2dw4v2KRda3FLiOmuQ1qTkCIzceR93gC5Of
 wtJyHT9ofHcmLC7i1IreDPWJ3BGFIvrYhQACnbayBO8T4FyIV8CscPbi0jWc3EC789c8
 5rohA70A+WXQaMUHgpJxq7tYqjt3LDuj8vGjpNqpy0scMP5Z3yJLa+R8IrKQ6wuGR849
 pBKs/PVQhBFGcJDRIa2Sw1towfxfqiSfHbqlaGTelrFIB6M1Acs3wKWGhEQrJYnFUfel
 VzcErgs859JVbAZTDWdD/fn+1i0vQjQKofu1IJdsOu7pUHDS1owbUGEHHzvdusOo3OXp 1g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvm14a3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 23:31:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30ULkoWI039440;
        Mon, 30 Jan 2023 23:31:05 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5bm47r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 23:31:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/Uzjz1L70X3aAnGVFlZA8rMD+F3jpn1pl3AVCzZWdyogcbsmQGc8kpJ4aN9OnSBaAkpSRVxoaWBS8LIsZowZH1IK6TSiSibgpUnicsyx6G+eHMGRVkJQ2GOj+woRMf2NMwmSlfEfccDImchLpzKxusOup7OzTzbMOuIx3v5OuArYoc7+hdXHQU5hZrwrHv3DUldnBueRhQoOA1CkRbmmZ9rxTTPcoNyPS3O8cnGJn3oTK8+9LAXMORJG1nOwhCmUMvrfiZzw60/q0obodvUnkH5Lb9LfpD26n8mnjNOy08blgs4xOv77bSghsWbErmKvcqws3im4zuGyxt0OYtukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXxBNafNf+g8HmykRnSr4IvUcf5G/vTxBDEcPcfwQ44=;
 b=QImW4VIyYTF9fLe0JRC2s9sVwWre2eE+4FfK+hsS6nr2jEYsnq9BaObwDUpBUxBnRIvq9eHVWG29uP0sGrf7RehbsuGeO3whnvVNVsqmrk0lLiZTPZj0Kk/FpL5HRS2E1D/HG1GWKIiVE0qqi5o+QsUWz3wKmASRrFgwkK+brxCWYQfwRq6oXP6uiyaNDzUeDsXFMEqZdgIMjkbhW8qj+itDzKfgijrE5nrubxgm5HB/I6TazUpAurAkA2LZl6ETdannykybQg26yNuSFJPptAhqJxATOMHOK6re6SKtVlJcro7f6zAJS2ILHgonUCPyLiJvgghBLCCv3Ldr/P7M/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXxBNafNf+g8HmykRnSr4IvUcf5G/vTxBDEcPcfwQ44=;
 b=MgDRF4c9yj8m6w9s3A4FpSW1iAEhr3GXMGsbu3x0mouRsqJ5Tt3xSE5gWi3uMWcj8C9uO0Oqxyu29YeWwybPOTRJBYqmymSRhDexEoF84KVx5nhQZ0rmrFIkKjCR5iFf3teJgVsNJJhcQ90Z08ouG8UB2+m+gMYRAelwKjFum9Y=
Received: from PH0PR10MB4581.namprd10.prod.outlook.com (2603:10b6:510:42::16)
 by DM6PR10MB4235.namprd10.prod.outlook.com (2603:10b6:5:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Mon, 30 Jan
 2023 23:31:03 +0000
Received: from PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::54a1:30f9:c42e:d74f]) by PH0PR10MB4581.namprd10.prod.outlook.com
 ([fe80::54a1:30f9:c42e:d74f%7]) with mapi id 15.20.6064.022; Mon, 30 Jan 2023
 23:31:03 +0000
From:   ALOK TIWARI <alok.a.tiwari@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
CC:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: RE: [External] : Re: [PATCH] scsi: snic: Use sysfs_emit in show
 function callback
Thread-Topic: [External] : Re: [PATCH] scsi: snic: Use sysfs_emit in show
 function callback
Thread-Index: AQHZNMes9b1ZeznjS0Sp1mi1PwJOLK63VpkAgAAD4YCAAEG78A==
Date:   Mon, 30 Jan 2023 23:31:03 +0000
Message-ID: <PH0PR10MB4581EA3C11DAD8EE14CA6CD8DBD39@PH0PR10MB4581.namprd10.prod.outlook.com>
References: <Y9fvsSJrflcIHm7e@ubun2204.myguest.virtualbox.org>
 <4bd7788a-bf6f-40c7-4439-2a300045c5e3@oracle.com>
 <Y9gcBe/Qmp6Vuz/3@ubun2204.myguest.virtualbox.org>
In-Reply-To: <Y9gcBe/Qmp6Vuz/3@ubun2204.myguest.virtualbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4581:EE_|DM6PR10MB4235:EE_
x-ms-office365-filtering-correlation-id: 83735029-6d4c-44eb-a335-08db031a0da2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l7Y4LTy7TWcYfK/j/+TGvaIWQF9qkOcpptyGVCGd79YJsyS0yqW5F+OCy3WPxP9HfIeafMG0VhFAK3B4T6waOBmCWVMXO9N8vFEzIYODbQe5FInDPljpbBIDO+SVvX0KsGxjrF9ETTVUdBwNImG4AMdDHFwCEWek8piK0rf9uDOwoOOfkh9V5K8Cxg0mOEHGVKFT7Jy+YOo43sc1zq3th4Q+Gf340k3YPgBk3neeG4uiEvtxeGLZunFrHwg/TH5sf5FmfxXRTITq5eEe2y8Njo4E8u91r0VGDAo0yRTRqjwcdon5TgOKwPBigBrQiRT+47897dCmcqN+XFviwKRgNbZGwnKbQ09BBU2RVKVOrxVBLcfGkiugoXjfnfABybG0wF44yZNJ/TtYpj06tzPG2t+PMidxiIQtjD+0AAk0B6PtlAp1nfXK7eCnhel1ZM5pGPjC7W+r3rYZRJMBXprP2ytjkY+veve74yeJj8Jn4RPaA31pqFJ7qiqlPkwj1vHVn0NNp7IzwoxLJvy3dED29cIR5ushvAfmQUp6linTg9HB6JZXg9Y/r09wDkvvcrxBPW2XT4ORsdwFfr30bbfl3L3flNA0AEZ8eBMOGtT2DfwdaENDw4Kr/zy59D0J5S4mxa2sTxMaCRd6vxovVq+gdQxcBURNqrX3qUefktpgeezcfEpZgfdDv9qxehq2ibTG2M7eRaVhDHxX+HCgFdpkZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4581.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199018)(478600001)(71200400001)(7696005)(83380400001)(122000001)(38070700005)(86362001)(33656002)(38100700002)(55016003)(186003)(26005)(9686003)(53546011)(6506007)(4326008)(6916009)(64756008)(52536014)(8676002)(76116006)(66476007)(66556008)(66946007)(54906003)(66446008)(5660300002)(8936002)(316002)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pTaER4TiVWfpWRUCbw07JesTn2FrvA1dfcfj+6Rk38aDaGS9Pvd3/N28Jo?=
 =?iso-8859-1?Q?qdarxvRXJ8yqczaVTrRv6lMjTWeyc2C92oW566hzWOZZVDbYVWYh+PGnuP?=
 =?iso-8859-1?Q?pqJAG72C7SjUZU5viD9/wjfTWRMNSQl5VGByiTRQktZIbXWJ8Xq+IbLzGJ?=
 =?iso-8859-1?Q?21m1Ht10lzsS8F+Np2xstCcpdJ1r+W72j2LVcxoEwDFqXEQutwNGj6dmGf?=
 =?iso-8859-1?Q?O2UuEqUqzrWIilt5s8lAVtVX50uQ9oVIyO0+2v1Gdj0SqcyRFBGLmxXeVS?=
 =?iso-8859-1?Q?aYmzTBNMwktvf4xGNpg5F0GxCLx2Ry7hIFAMxgE3hSTUXcTGx0BKh4yJYH?=
 =?iso-8859-1?Q?ioBMmSbzM6Vnz94PdFwPU73PRZRTAfb8fiME29Z1cTZbynMGw5HbPW75BW?=
 =?iso-8859-1?Q?9SqfuXUTBePtQrmMIkPL7OEb2BYEOMRGYIObgZ2UKn4KJlPEgEG19IPq9n?=
 =?iso-8859-1?Q?jpohmKpcDjtKBF13T21t6WhBXppderVZoK8qbhCYoei4FCg7WEfTb1aOfE?=
 =?iso-8859-1?Q?nFO76Vp4a2/CCNsp7OC2t582j77cIsr7fTr6Ektjg8JMNLPtdB1BsEtpfe?=
 =?iso-8859-1?Q?tGPVbRYoVgXyjyTYF0ObkRWnb+qUOU9P0HXQZs8pBuyxnQYEhQSRCRGaF3?=
 =?iso-8859-1?Q?g8SpM1UKB5cWo++JPwPTxkv6BtPRDFHeYjQ3JVrEdAXTgD7p1TemqPITMZ?=
 =?iso-8859-1?Q?c6YGbAKoHyz7DRUI71nCbo3owjEXf6IVdGiwbf9Oe7aB5/DujhBymzp+Gr?=
 =?iso-8859-1?Q?fZ6Th2V7L+Y/E0wxr2TLAX88HylOJmZOi0J7q1YY9THaC5hZsAOi5tkQJ/?=
 =?iso-8859-1?Q?tLNp/gjq5T/abh9lVy7Ow/UU7GafUY2njwTiFMAAQ5JkgH61AkGkSM/4ck?=
 =?iso-8859-1?Q?DE4Bi7svnILPQhKcEZFxyhPdNyZFCf2TJ2U2xvc9VldGeGPBNCpfspkUuI?=
 =?iso-8859-1?Q?MFDDkVney/4vjG9ZtfYkMN5NTLaHPRvfIxEkezQTw8iYtd91fk0CUx3pj8?=
 =?iso-8859-1?Q?Oq/SaEQeyLPpGi5GIh+iVfwgay32Df+GdyMvpajiPzpBTE8/DX4P+5ajgm?=
 =?iso-8859-1?Q?CR3ZyxDJPhuDnttWivg7ORbBkow79zBxgOFePhZciyUccQP4hUqY35Rncm?=
 =?iso-8859-1?Q?TKB0JdV29jbXchK6cXF3H+x/jWDQmYbXtEvoasYld70dIgEY8u5d8YZFNr?=
 =?iso-8859-1?Q?QIu+IqotD23v5p3bs97Z1EwiN7Q+cRyOdHHhgof7XGKObSp0iupQlbl4Er?=
 =?iso-8859-1?Q?ZotdRF2OJ8JhmofVFFFcikUi5Mh/U73XwuVfjI4s0VfyNloPdNJ4kVBoX2?=
 =?iso-8859-1?Q?1ibM/2kAc+6g5Op9VlQMJ3/Pc8y4/q1O/NGOollWPRKV1LprX1g2+phkEg?=
 =?iso-8859-1?Q?3zfdOZxTSjLEOnVrkc2qsdL2ppQs9CNAM/AnwKJVbpvllKVBx9DEO7MPjR?=
 =?iso-8859-1?Q?cxliTxm6FoLYfQa2aUUTzlg1YcDTuKQ4KLS0qjhuTJOuRCZrvqlI7ejSG9?=
 =?iso-8859-1?Q?Sjqlml8OcAZJa2EGkLsM8MCtaubNhj6vQZtzD3otyUaeMu71Y73vsXQvfc?=
 =?iso-8859-1?Q?eQo8XYvJST+Bj9be9S69BPFgxkaXi67demvvHWmOFfV8RU6wnBUI7tiQZD?=
 =?iso-8859-1?Q?CrGgwOmyjOevJX9ca/oQibs6wlS0QIKXFw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?NoNb04GsYLWNlcYFLcDnOo8AVNaT2J3Qg+QZO9LpNR9QVOM4FBbJW6ODU/?=
 =?iso-8859-1?Q?2rPiUwsvc9yQrMWfjewRBti8tJ5dN9S67GfdTMHf1ueH/1gpvL0n1J/sDF?=
 =?iso-8859-1?Q?0HtnOHnt7VeAHekK7G38byvb7ovJauSK05ndchxnQjzlfXTLw1VKDAjMC/?=
 =?iso-8859-1?Q?FcJZSLsDDyyV2ODsvHNwMQ9IapB7/dNJrjXXoqJYei4sYQ7H+lXfdKR2os?=
 =?iso-8859-1?Q?cBBX95NiqZc/tgFIa6mgD0CGx748bXMkmKrGJgteAmx0aKcLhiiYFHfs9w?=
 =?iso-8859-1?Q?SxY4XgCtIbpqHMojzNimIMIL77dWXt6Z4yTWSiiOK7tj0cVqC7q0RSsbAw?=
 =?iso-8859-1?Q?az1e0IXVXU/HGLHjhOIjZo+a01/3tPsbpVuxciRQ3FmVO4yE2PN0M9C83A?=
 =?iso-8859-1?Q?0jYu3epevLlWAyZiNP01x+uI9WDovVmBOCk0nqzRADPfp2MloxcWBuLH1k?=
 =?iso-8859-1?Q?w6YeQG7sa1Ckbr9eDbZR68O9k+cuEerfUWnHZc+D3HGPKRT5aiL+MTczRW?=
 =?iso-8859-1?Q?64bqsJdsxJGtmh4c/vWtKD3Mz4F5BmRW76C5VHvtvBrC8H6o178rwnvmuz?=
 =?iso-8859-1?Q?jYrcOqi+8223VQ2oEwSSDDtbX9Alm7W8X2vgcQEi/sIktwYo6k9vd7Kytl?=
 =?iso-8859-1?Q?7QpnQ5L6I3bMeFHa0Vr6rp0EdUkr7zGE+tCS+g3v3QXp/ajlukYv7UoRmT?=
 =?iso-8859-1?Q?Vhf4uXFyYEjRz466vC5fsTzbA9mP2cralBPsjwgp8hCY9ugae6562c2DJQ?=
 =?iso-8859-1?Q?eoCFEPsGIphIBlSdZaoSW8sR+pckNdxbkplyQ6e3ANouYKC0a/onv2Qmww?=
 =?iso-8859-1?Q?yQxQXR4Pw3Sv/nB4TcWpcXjCf50ycXPfaXvaL22oa0WrUXsRg/TIjv8Zvu?=
 =?iso-8859-1?Q?IbL9tUWNLx5ilIDTaTJD2Dd8/Yo/YLadcPAm0CimCqrGbP9aRGagwTKM1u?=
 =?iso-8859-1?Q?phJJAs+e5vjsuLp49XEW54u/HgZjPq+j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4581.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83735029-6d4c-44eb-a335-08db031a0da2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 23:31:03.5384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8wJXs5BFJtX1kd6Jk9mZefJGCNUfmT5rR9e8Qwd3fLuxtkWRkmVnMqKAUEbqrIOpZnDDrHAn7cvYSoSnsScmMHImAtx/4V8nsP4fld6h8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300213
X-Proofpoint-GUID: 5zxAq4mY7GGKUzUJs97Aeq0Rz2S9Z-eG
X-Proofpoint-ORIG-GUID: 5zxAq4mY7GGKUzUJs97Aeq0Rz2S9Z-eG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, please.

Thanks,
Alok

-----Original Message-----
From: Deepak R Varma <drv@mailo.com>=20
Sent: Tuesday, January 31, 2023 1:06 AM
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Karan Tilak Kumar <kartilak@cisco.com>; Sesidhar Baddela <sebaddel@cisc=
o.com>; James E.J. Bottomley <jejb@linux.ibm.com>; Martin Petersen <martin.=
petersen@oracle.com>; linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.=
org; Saurabh Singh Sengar <ssengar@microsoft.com>; Praveen Kumar <kumarprav=
een@linux.microsoft.com>; Deepak R Varma <drv@mailo.com>
Subject: [External] : Re: [PATCH] scsi: snic: Use sysfs_emit in show functi=
on callback

On Tue, Jan 31, 2023 at 12:51:40AM +0530, ALOK TIWARI wrote:
> code changes look good.
>=20
> commit message can be more simpler like=A0 "show() should only use
> sysfs_emit() or sysfs_emit_at() when formatting the value to be=20
> returned to user space."
>=20
> and in place of kobject attributes , device attribute is more relevant he=
re.

Hi Alok,
Thank you for the feedback. Your commends make perfect sense. Shall I resen=
d a
v2 with the simplified language?

Regards,
Deepak.

>=20
> Thanks,
> Alok
>=20
> On 1/30/2023 9:56 PM, Deepak R Varma wrote:
> > According to Documentation/filesystems/sysfs.rst, the show()=20
> > callback function of kobject attributes should strictly use=20
> > sysfs_emit() instead of sprintf() family functions.
> > Issue identified using the device_attr_show.cocci Coccinelle script.
> >=20
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >   drivers/scsi/snic/snic_attrs.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/scsi/snic/snic_attrs.c=20
> > b/drivers/scsi/snic/snic_attrs.c index 3ddbdbc3ded1..56c46ea06e60=20
> > 100644
> > --- a/drivers/scsi/snic/snic_attrs.c
> > +++ b/drivers/scsi/snic/snic_attrs.c
> > @@ -13,7 +13,7 @@ snic_show_sym_name(struct device *dev,
> >   {
> >   	struct snic *snic =3D shost_priv(class_to_shost(dev));
> > -	return snprintf(buf, PAGE_SIZE, "%s\n", snic->name);
> > +	return sysfs_emit(buf, "%s\n", snic->name);
> >   }
> >   static ssize_t
> > @@ -23,8 +23,7 @@ snic_show_state(struct device *dev,
> >   {
> >   	struct snic *snic =3D shost_priv(class_to_shost(dev));
> > -	return snprintf(buf, PAGE_SIZE, "%s\n",
> > -			snic_state_str[snic_get_state(snic)]);
> > +	return sysfs_emit(buf, "%s\n",=20
> > +snic_state_str[snic_get_state(snic)]);
> >   }
> >   static ssize_t
> > @@ -32,7 +31,7 @@ snic_show_drv_version(struct device *dev,
> >   		      struct device_attribute *attr,
> >   		      char *buf)
> >   {
> > -	return snprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
> > +	return sysfs_emit(buf, "%s\n", SNIC_DRV_VERSION);
> >   }
> >   static ssize_t
> > @@ -45,8 +44,7 @@ snic_show_link_state(struct device *dev,
> >   	if (snic->config.xpt_type =3D=3D SNIC_DAS)
> >   		snic->link_status =3D svnic_dev_link_status(snic->vdev);
> > -	return snprintf(buf, PAGE_SIZE, "%s\n",
> > -			(snic->link_status) ? "Link Up" : "Link Down");
> > +	return sysfs_emit(buf, "%s\n", (snic->link_status) ? "Link Up" :=20
> > +"Link Down");
> >   }
> >   static DEVICE_ATTR(snic_sym_name, S_IRUGO, snic_show_sym_name,=20
> > NULL);


