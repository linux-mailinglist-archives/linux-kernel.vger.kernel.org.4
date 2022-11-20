Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB76315E0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 20:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKTTiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 14:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 14:38:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B97921245
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 11:38:04 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKIfsmu015160;
        Sun, 20 Nov 2022 19:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5ciXUMfDaSKdFKViiu2wXcB5mFQaRunRPJGbH5HbQoU=;
 b=NRBxWqszPNtHfHEED9nEsVqqFq0Fs7VBL9YZ12Pt13iIMaUrWkZmV3P9iVYtHw5BxJKc
 ZqbNjXbAprqckcmFtlhZoyFBWwIUhkGc4Sa6OOlcF/IopKJJiE2TwpQcDS0bzq0gjlCJ
 QIyYRQr7LrpkSFg76JcCWRnZ3/7kxA48fUkCVjdKS1iGDPk0gLyL8fe8O4+llw6HpuZa
 reismONbGLnSkut5KGfZ4DmrgpggZKA/ezf4CeyXDeRBYiBhB7nKjxqsY4mplf0AJzDh
 v2Z2sofgA2q06Y3bLjUJDfHiM4iHfkRa/xNxhKjKC44FX5W3CxTJPxKwzeBf4GWt4R4N 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxs57jc0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Nov 2022 19:38:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AKIw5Da023522;
        Sun, 20 Nov 2022 19:38:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9mnp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Nov 2022 19:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GstxZXnfi94yhM6uX2jPI9CStNDjxiPmhyraHTn3tHqwHCwUUfoxI1mCDSKzXsm+4sgshvukoJHCHV11ZtUqKHLN2Xd1t+fWHuVqFoC+YFA8bqRE8uPL27A/rnLku9gaojr/MZmzuA7l0ZARL9pDNeEUwfzDOkxf3EGVBmUj8dlx10Sau3DMDVAlvuXMqdPlNsvrh+xBLmzfCbzn2l5OCGmzN5aLOHzqbPDOcrXj8wYGVsksNBOtJgimSEnh2p7Ys7lsPSz4+YoN+rmxdbhA4Ai9Sir4KNohhrsq3m1RwmYmKc9k9NtMxRmjwgoY2y4ym/2RsF6XMtxP8RWPnUFyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ciXUMfDaSKdFKViiu2wXcB5mFQaRunRPJGbH5HbQoU=;
 b=mpBL2eDTqxiBSeE0YirI2dUFNVxVfg0YnJNLbx4bafNaQ4DEtAgUexxYDbr/p4WYsaek6ncIblBsaCPjAC+ttvbuzYb3axS9G+SRQvb0FTTkdXs86npQ5B6U8CG7/ZOZdtC8eRBpJzIg4zSeu7iXHU2Dh0tUb1BSmfF8Z2zAFEI426fEXZM7w3FvCSQ2tJ0Tt1Vg+qvKtuUZ4KT+3J4FEw9VsitofxAvWklMKUkpGh4V8J4jWMp7f09Plrwclz0JCo6AImqz0G6uZXn02sbH+FYwbSXX0p39BAQnbvPBtWD6kmEkTbuhef+V6fNClcHsWq+hMV0mDhfQK0rcFkFzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ciXUMfDaSKdFKViiu2wXcB5mFQaRunRPJGbH5HbQoU=;
 b=pWTf29ae5qXsBPDJkE6lShtqiLjMW8u4cr8gipFKxGIHz5LH1seQsKkW8h8Lt/2wyyyq4+XcdkruTl33eb4Rv/ieQYJ8z83aSFYc7Nr9LaNFFS/E/h0+3UHj8pkaWVKLaV3RvCXBfEUVbPOCyM9Z85iX/xvtAD4/aFWloGgm0KM=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SJ0PR10MB5583.namprd10.prod.outlook.com (2603:10b6:a03:3df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Sun, 20 Nov
 2022 19:37:59 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::76e8:e14a:3720:b01b]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::76e8:e14a:3720:b01b%5]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 19:37:59 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Add a new generic system call which has better performance,
 to get /proc data, than existing mechanisms
Thread-Topic: [RFC] Add a new generic system call which has better
 performance, to get /proc data, than existing mechanisms
Thread-Index: AQHY+4GmP5NllLDqPECTxLaw13LSZK5F8KIAgACWrUOAAPPsgIAAvK1s
Date:   Sun, 20 Nov 2022 19:37:59 +0000
Message-ID: <BY5PR10MB41295F82C3586B97E72EA4D2C40B9@BY5PR10MB4129.namprd10.prod.outlook.com>
References: <20221118191202.2357801-1-anjali.k.kulkarni@oracle.com>
 <Y3iYlLmxvIqn/ETF@kroah.com>
 <MN2PR10MB414411D0E29F20412E6DF0C0C4089@MN2PR10MB4144.namprd10.prod.outlook.com>
 <Y3njl8c0Azfq6QKm@kroah.com>
In-Reply-To: <Y3njl8c0Azfq6QKm@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SJ0PR10MB5583:EE_
x-ms-office365-filtering-correlation-id: 8479903e-1869-4fb4-90da-08dacb2ebb40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4kTi7LA+sxyvuzTBv36lA/QnYjXyFuHRULRWKLfRJD9SkVfX17jk0mo0apCRVomngRhmtR3lOOPMnsQao7jGpTm83QRD2IfBelXK5QZPIC2UEPZSXbRE0NRUA4NU6oBC6nneGmJf/bq8r4+UwFwX0btF6IAbPLh6OJH0i1FU9PsNSTCmcSBKLhUOCWojX5AhU0VNZHHj8UOE0Jj/JA9Z8v+O3NoadHC7ykYa3mVMKgE+w68jzPY/TUs6T1ChsrIheH2olNc96OocV+sHMryR4jcdZtWjpj+REvqTyn+PdEVkI0B8YgIaoEX36Zd9x+3owtI7m+pj9+s81Op6JJ+/uSd4+djd/oLmknhM0eRUs6Ab/zm8uF3S7KgLMXcMdUSnjvdb4muaTT/GGiUOQ/d6Gz29DH4NVAYfQWqYlvR4HseZxBt6TtsiHmtUEH0Gq/vAZZ8r9rzeJbbAxUOCuSQVaqLoZDueFSaiaDxAAkZNQ4xdAXPt+6QNL3vdhR6L468Vr+8fZ3t7OUG+/C/9q1AuUp6TfNOuH6fjgMNlHkMJs1TdT5HK/9fLjUrQF4dYNKFJDefduTqHUDdvmh2Tn6dBcWoP4Cp7nd7hvRKyEyaYZDdPLR7E0dDMj+9sBtpejuppy5rIdZioMEwysA0qJcIgnxf4gHxoUP0HM/sn71dThMRzRJu6ViZwPgtTteHVQM+e9XPo4ycni7tCE1UsNmPSZxTAu/yqNj2GBiOmXKSuk8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(38070700005)(33656002)(7696005)(6506007)(86362001)(53546011)(38100700002)(122000001)(5660300002)(4744005)(8936002)(2906002)(66556008)(55016003)(52536014)(41300700001)(9686003)(8676002)(316002)(186003)(6916009)(478600001)(71200400001)(76116006)(4326008)(66946007)(66476007)(66446008)(64756008)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2UwEOucIDnCsJEoxIdahI0FgZfQUjtbGKbz8NqWUEFifbVTVJ6S9fgxdUp?=
 =?iso-8859-1?Q?zq5JDfItOEGGEzE1Q/m/wP4g7IM7aMyBCD+MJTuRYle3umo/2eK69zalEA?=
 =?iso-8859-1?Q?mHUhl0AR7Jnsz4wmYy9qnALWf/zHiaNTYgm7lyaaNU3pfMdZTnzJPv4+ez?=
 =?iso-8859-1?Q?iccDGJWDA5nQC6PM5CYZ+Jp3KhEvNHAGI8Kd4BwDPm4a4DaNLhhopARj5S?=
 =?iso-8859-1?Q?KzzCE6dBBtMoJYuolrnPqvpZs2vsJEJrp7WLUmUlA8M7u464OnkGJVVCnz?=
 =?iso-8859-1?Q?8OiR7Zak2vc7hGuYAseN9PrV3psQh6BWbP/qS6WN3xugefF7DKmZ4/JnqF?=
 =?iso-8859-1?Q?xsv5taC6FVZUyyg0741i+zcqTYOHGdfUdGuwEZU0erNiLh2ADJog9X7wWP?=
 =?iso-8859-1?Q?JqWxxKrg8UP6UmPYXFzf3Hed3mzL2rprQdGV5DhVLrRv1bH5jSkxQf8Uz4?=
 =?iso-8859-1?Q?Oh4YaXX2GJo1ovXPwWiSM3/KKtJ0BxfACybPKR+xWSL6ISs8CckEpOxmuv?=
 =?iso-8859-1?Q?wUPHfpRVtdDhbAhDKrMuAJgPjVPYs7dBtmCRZ3xdFuI+0ziSF2vM5I4IOR?=
 =?iso-8859-1?Q?qXIsCOWhfat31mw3Hoy/geoVVqEpq3K5P6iZmVSuys9fEq2fzDGLUa0DBv?=
 =?iso-8859-1?Q?t/diEOy2EGKKDpHhRB7bh9jsjvZlkTIki/Go5kH/0SdDUDTXb8UqUUQT91?=
 =?iso-8859-1?Q?ywrVP75V6VZAZB6kufIoht+45dxmtkQ9TRfmw3V/wd6nRC3TRYN4WxJswU?=
 =?iso-8859-1?Q?0GSJKjM0TFKGXH2wbGzMexfZlJEPFaBDDP29WG4rt/QDb4Xy7g8Ta10ItS?=
 =?iso-8859-1?Q?JmsR//aD3Caq5GFz9Lg0UQNK0ue2ZwG6F6tSZ189CHVUf9ogZ7e69q8sso?=
 =?iso-8859-1?Q?RPsuIOXTo61VW8MMQbuBcbdlD/Wqo5IIqs6iyWM6iX6H7ZGQd5aLb8Pdzr?=
 =?iso-8859-1?Q?q8egkYReE5losbtmDtK+UN85T3rG6HOXfMwpF/DX6rxpWcja17ltjECBPp?=
 =?iso-8859-1?Q?B1XRY/BlEkh9yjMuvjabklcKPnTmqW7YOcDueg64PSnY9vLmnyYRDCoBb+?=
 =?iso-8859-1?Q?muY4sD4vxwvV+tRpvIH7bu9cpwPW0iA/mi+FNqDk5Drn0qlG8PHZB8ELX4?=
 =?iso-8859-1?Q?1HiToLN9djSXuuU2tRqxy962NpOGhIBVZXxMWYnHXTOKlhE8NSVRU/k7Sz?=
 =?iso-8859-1?Q?NqDeNkr5Fl3+62Ty9dBjXx1+hHHlpc3fIyH+n4LTEj0Y7JsKAs69CrdO7S?=
 =?iso-8859-1?Q?pYuTQxPo1BEMgguvKfLYQHPlqK7pk2T04N/vGp2y5SVGuFez1SJowLX8p+?=
 =?iso-8859-1?Q?xS6avlUzWyX1vjPkABBLbqOWUYnh/nHVs4dUt9QZadS5p+6mMN5Bn6fNg7?=
 =?iso-8859-1?Q?0slRhGixBZoMdht5KSDWJ2Rd4E7adTvTwo8vOfu7sRdIyGYLNXK4GyYAlh?=
 =?iso-8859-1?Q?OZytA+82MO8iR+biHCy/EqO/Jd3NRC59x5GZwQvjYv1apt5NGMmHcMNjk7?=
 =?iso-8859-1?Q?W7fIXXiSsPo34FFNhpMbPYrkhKwywDSBaM3YevW2195NxUlpI60GlpoXpZ?=
 =?iso-8859-1?Q?3SAGm/npuo4P9YMmjhjCoHtmfjGpgNnVX7i3Fq9wFbIJXL7ceZFK7bkPMG?=
 =?iso-8859-1?Q?okbezSfQZYItycwIzGk8xckC2aMxaSP3ugIJthA25cvN3c+sgRB11Mm6iX?=
 =?iso-8859-1?Q?cXI9Z0yvrDjHBtXCnhGT0frcWOqU2GP506a1bjoyMqKugf8hCJ9APPMMlO?=
 =?iso-8859-1?Q?+j/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2WLbHKhuEPCV1kMRlTPWwlZP/CQuLPXBEa+FMtv+aQCFdFP6tRNODUkdnSTXd4XzcQpl/zF1JnJEUUGix2FqqUmdHhe8NG1KhYoi9SdZvgO1ZQtUnjdlwXIZm6C0tjP6jKTkUtfL6lYIPQe0Z9vIBHPC/QxHKH1djn68Y+WX8VVHPT2reXZmC8TlFucugT6zJQ27hEOXh2zORoWEAtwSfQ8hPQtkyvWNSZYieEFOP46GSeE2gLspauJA0d6vuEtqje+A8gR0mtHQcHHhQfkD21T5cAF860DKzS7gUeIs4/aBQPKkZcLHvOqRYtug97NKbbgvNTzaAZH3gm3Ovkje0idkBjWjkRmxBhq3m9E9dBKolvSpltfT2B8suDWeRBaFAxokWYNDMImw0EVBEOwQqq/HvRGYydiuMgzteCGzrYSJDR4SKhc4lNThU+tCEVC8K0/JETCSRFXUEP4N3LWF2BfxQZT1ZpGDczdyX4N6yQj2a49/kEemrphnHlBRNGcheK1IwpE2m6fNru3hdd4Hl5kePHW9zg/2uiolTdqAu+Sn8Pe2EjFPPGY3ORrX6DftROP3m8WgRf1gbS4b4dTdodRl4GfmefZJwKJkboizG/k8chTpN9GhIRYM6B8ntISrTj/0OJuyC2SmPY8ZtUIgGQCW8NFEQjIKSPqmN0irPTNbeKviLy2oLINHw2C+p8q5CdrUDz1WSJiy1FudGNFuQgxbFQkPAn1Qs4mmcqGlkT5XYXEM5Q2MRfQrka2TrB8GYrLH7dYRMWr8i3QRzFa41/Jur/aV3nOJPQDb+uC6Z8I3YO4kyW0Kz5ddtbmXjquu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8479903e-1869-4fb4-90da-08dacb2ebb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2022 19:37:59.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1m8X465+bchG5+UuMV7dwXfZDL+hUFtKLvEBcccshBlkmi4fmDQwxV/KYiekR8FUs1TeJG2piPSkIkiZdIzMqkjqK9PZ2bJOBU3wUp0ultA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211200167
X-Proofpoint-ORIG-GUID: BmdH8JQf9Ta8RrgYN4LfVtQ3D7AI8arX
X-Proofpoint-GUID: BmdH8JQf9Ta8RrgYN4LfVtQ3D7AI8arX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you! I have fixed it.=0A=
Anjali=0A=
=0A=
________________________________________=0A=
From: Greg KH <gregkh@linuxfoundation.org>=0A=
Sent: Sunday, November 20, 2022 12:21 AM=0A=
To: Anjali Kulkarni=0A=
Cc: linux-kernel@vger.kernel.org=0A=
Subject: Re: [RFC] Add a new generic system call which has better performan=
ce, to get /proc data, than existing mechanisms=0A=
=0A=
Note, html email is rejected by kernel mailing lists, and top-posting=0A=
does not work at all in discussions.  Please fix your email client if=0A=
you wish to participate in kernel development.=0A=
=0A=
On Sat, Nov 19, 2022 at 05:50:03PM +0000, Anjali Kulkarni wrote:=0A=
> I will give it a try, but the majority of the savings are due to avoiding=
 the conversion from binary to string in /proc.=0A=
=0A=
That goes contrary to your previous statement saying that the readfile=0A=
call would help out here.=0A=
=0A=
And there might be ways to convert binary to strings, perhaps look into=0A=
doing that?=0A=
=0A=
good luck,=0A=
=0A=
greg k-h=0A=
