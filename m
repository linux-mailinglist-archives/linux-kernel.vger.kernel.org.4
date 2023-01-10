Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D6664972
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbjAJSVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjAJSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:21:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE0396101
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:18:56 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIEAon006236;
        Tue, 10 Jan 2023 18:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=6EY8V918kWPyF6vhStz+N05/nLjCZ6lrQPHGbFe+Np8=;
 b=zEFQ0Nl/ere2zsfo90+qvztelu60GF1Sf0m9LgFyKT1yMAJhxJnqjxGhkwmvv21973/i
 ABk663i+MxGsvLgNFEDc71wE5mTL6TX1u9gaapcI2c8LG62LUQIX6da7xy7SOIlxLz/9
 xMw5ezb+u+beMmc4gKrLX2dM+Vmp8WIWR1Htt2rq5MiBtILqieR6Hqg4uDx0fQhuDSIH
 KKFB4HSEMfXhG5CRlIyk3WFgzBfI7jv5aI+PeA3l+ty5iXFXbMLSHWtTN1VAynmmML/V
 otVfnWdPTMb5pexmzHwqYhJiLprCfMF3O36cWi5iiDg8UXZlrws+puC/mLKjQN8aFam7 Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n185t8thx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:18:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30AHIb60008240;
        Tue, 10 Jan 2023 18:18:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1a43kawn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 18:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jp3i1xHf2GX/CAk+YIR3fKCLAsDzRbXJgns1t/gdBq0ruFKAYlUxD9sJwOKPVmyYa+c95jrIK+d98nMjOjDPsbT4BhFjwsrqzMX+PVVALAvrauwZWG1hLBoohvde1AXcSI22vZC6wbyCNICT7qoVBpc8dPn8xU8WOs68mHx5pXwsieoDtgGZtp1nLmD9fdcJf3l27azJrya5bFKnjAd76pV2Yf9ASOKh7cLNqy2LzdS68xubqkg+V3xIBMQHFCy9J3rpGM/twD26F4AAmpyDJKifKtpvIZThbiJ0nY+8espeO55b4EDqVj1FnT12hr74WoB4DqXG+P6LQnWIoyD5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EY8V918kWPyF6vhStz+N05/nLjCZ6lrQPHGbFe+Np8=;
 b=IWaKHlpIme8A5yN1eH7TyObJ8eo1Zy29AfHK+E2kMEN1+ZsqWUv5NpbZjInG10+3GjAJ/rQCYc4ha539XStqR38xCCvE6lnTBr8KB+nRkg7jC4XqZhMZbyYKUKHBNGSqUy0N/xkf1HjSnU9yW4zHqqQjAPgfCiu0sZKorbt3TODg77Vy0CemhJu7sGb9EqPTrRqHHEZoltPq6VH/jyztJQqIcjIdx6JxuMJFutqC9pp1cWPpZjsr0dZXO+pwW//awROZmJS5FTxrEnT9nkw09W//UGKcpKv1/PeZhH7rQHK8cmd1zsEPtR3NKrwBLKaxzwvohf66vGNBUf8VHabCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EY8V918kWPyF6vhStz+N05/nLjCZ6lrQPHGbFe+Np8=;
 b=UlUqgBn+jw0Yox9c6xgR5zLKsBPeAU5n+jysNDt+VG/Ta8TamiqRZ++cqpZiusIMn2nD2PU6p6cAU7qQ+gH6UPwlM5R11pv8PEREiN6lhMcrdRGWY3My228qwILv2HpM3sKJQr8KwldnyW1TvInwox44JHKEjwkPPG05XH8JnxM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Tue, 10 Jan 2023 18:18:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 10 Jan 2023
 18:18:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        "syzbot+502859d610c661e56545@syzkaller.appspotmail.com" 
        <syzbot+502859d610c661e56545@syzkaller.appspotmail.com>
Subject: [PATCH] maple_tree: Fix mas_prev() and mas_find() state handling
Thread-Topic: [PATCH] maple_tree: Fix mas_prev() and mas_find() state handling
Thread-Index: AQHZJR/4k3BEl7/MLk2HN+83otUMAg==
Date:   Tue, 10 Jan 2023 18:18:43 +0000
Message-ID: <20230110181833.1263020-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS0PR10MB6030:EE_
x-ms-office365-filtering-correlation-id: 91b297f1-6d95-4215-2d2f-08daf3371b7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bC2yMc8YkMHGo+Q+LrtmCT2Aw48lTjpKVQfpRRNm0M3F59p1S49xurIiaLpg7XfU5x3eTrKyldqipC4P2T+7HikouOEyUpaQNuJMXg/+xYt8Ivb2Fq6d8FoEGN3um5h0X+RqNeTbRY1ATj7UyeVpUMhUqtc29PvdNDdA19t/yCFdZpYnEeDnuT72KWA3uqFS9RztDynwItuJwSxqKsX7rxUZzVzmgKwo/04BoBuXutQtICEQikxVGKHuKBNyilsFdggQOmdm60yAMbp5SvB7/7blRbP4SKVjuNBNC8lfNqzpXVjBesp/aCPnKHv1vDDIMsAIm+us0/FH6376WxrFUkqCAvUzOl/sXOsBMHbj7MvyOPj6Z1Mxrhl5nYs9sdf/lcxBaNFsS1gaJiL+Rd2aTvpBr5HtQBluw1v/4xFkTuuDk+Rk/LIez0oUwlS4vxVjbJ0mKcSCbCXUmMdlRXSabNfI51dmKbAEV7Q+3XfME0wVRgXo5aMoY7BF0IreJwT8UtEg4EAHwlB64l8D0tHNp73yoYHG/5gFpEeIHQx+QIKZlFaLLzKYSqGxjpTBP8e7jfUVbz+H3eB6SJsykpisW7vSUG8Wtlx70wsqkKyzCKCpvYRhQGp/uhsKcjdPwrfxaNp9Cdz53kKyeaxXLIRpAfBxTpg9SSbzzqTznFzemClhqvTaKyNAIKYxfMPFfzxddtckS1zEf++INFOa7Pux9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(6506007)(2906002)(26005)(186003)(6512007)(36756003)(478600001)(44832011)(71200400001)(1076003)(6486002)(83380400001)(2616005)(8936002)(54906003)(316002)(122000001)(110136005)(4326008)(66476007)(66446008)(8676002)(66556008)(64756008)(41300700001)(66946007)(38070700005)(38100700002)(5660300002)(91956017)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?quCMOGofe8GVhMOEddn9UjxiyWWcMZcaGwp6wBWaCpy+6ff0lFejYMKeVQ?=
 =?iso-8859-1?Q?yauNzL5UiE0LaMIcd+Kqw3qOUlXcP0zcvU6HxWhrF7ieLQ5jzVUA19c8Wl?=
 =?iso-8859-1?Q?tI8hupcx+LT3WkhakwrkUU8/6XEpIJFXvD9BPF3a18DFBXt616bZKqrg1v?=
 =?iso-8859-1?Q?O7se1qq0VqkOIvZdrdF+xzXaUJlmIg93PWsbOa2D0bKGndSyq0VQuS5t8P?=
 =?iso-8859-1?Q?7NcV2WrzasM/ka+cvM5mnCSTM2gMbXdT58rjldoXFOtfxA5qI9pFrJzvrt?=
 =?iso-8859-1?Q?aKIu3PVa5XQpPG2+iG2rXMwDP/lMHUe9pJH3e6bOtlmbgU5Wv4ZNkJ85p3?=
 =?iso-8859-1?Q?jAzIGyWfifb6iTFdEgGWIOYN6t+YKqOSqvTBaVlHA4qEcSU7xzH3OP+uT2?=
 =?iso-8859-1?Q?qQSW/emSdq3Ro5WeWh3IEl0ILtQuBKF1qvrcAKT3VokbYTRIp5AToLbr3l?=
 =?iso-8859-1?Q?AIrFwK9SC42qNKCOn4CUMt389cgeijjvClgDtp2SEjHVuRjygcY/sUuP0H?=
 =?iso-8859-1?Q?15Vdjs0ypGbrbw36/5RQVF8nAmkihPcmFkX3wanH33h9DoJfmsYyg8vqm3?=
 =?iso-8859-1?Q?cRKzNkGaOISG2XrfEEXdxX3w2FT+pxUUjbTjLcG7dpjsX/nNDDpT3IdBY2?=
 =?iso-8859-1?Q?W/94ZJ2BaEbY85D5e+T+H6jckonazQZXPXF/qkWgh7sFZukMMbX53RkFLA?=
 =?iso-8859-1?Q?yhZt85EboVvmg6Nu+FNsyOvdfEThKcF8BGIzgMnS6+96mBPivxq+nCBQVY?=
 =?iso-8859-1?Q?TU7WgqJoMsV53ENDkr2OzMaZ4osz7Qv+yMi/R4q9PhK/z+ciCGoertp/1J?=
 =?iso-8859-1?Q?guzt7SIeOScZO6zonRLVWMMj8FqdEHwyfnPZxSoAI5l6keqF5FK2SMH4gQ?=
 =?iso-8859-1?Q?HuomXN+p0iNcayjyOIhtKitfGs0ZR2LaIq2l5CEdzxFLqABXo5p5safOYB?=
 =?iso-8859-1?Q?4OoyZ0b4pe6K6M5eEQjkF1MU+s6i9d8/uZetYsZZx1J1/okB1PkvL0z69k?=
 =?iso-8859-1?Q?NhuE2S3yJxGR41yVJT/gvgmfOa9dN34ipkifTu8YNrqmYPrGgB4wzUzpCk?=
 =?iso-8859-1?Q?I0Fz30/Kjg+D+eKFQZWhyk6q4RsfIUBR6W2YkY15/BGFqNFT9FgWdrek38?=
 =?iso-8859-1?Q?u0JhxXyHlgHuDN9nIzRy6PdFBOfjG406TH6So38N69+KJscctc32p2xcgf?=
 =?iso-8859-1?Q?7Co2IAO6bDfufyhktK8pVwNBgbvewuFhRrJfEh6XMBtl6vJeseJZnucTsR?=
 =?iso-8859-1?Q?MUcvdlLL4ADNpUXvqq5JFm7OL46HiT0z4QUYcAIatNJmaUVyyWCeenRM/4?=
 =?iso-8859-1?Q?tHaCZjCUqoI5Fn9GDPjjYMOCqTxMApeXNdhfLjrpU9GCFzJf7MBt3Inl98?=
 =?iso-8859-1?Q?oPYftaYZUO6YtVD1G39pFeV/UiZwAjXW4lCNILewW7A1gGsnco3gGjtbnY?=
 =?iso-8859-1?Q?SzHLSdFxCyjbkG8zWxYTafgJlNRBZxYYQ6IGDuK8ZJfqKMTAiFKj7nCJMt?=
 =?iso-8859-1?Q?tnOQLMXKf9ORTggFs20rOt2nWkBlrmUeXF+Z4tRQqkNscFMSwwCwmPkpMB?=
 =?iso-8859-1?Q?JJeuEgkJ4ryl6Qhw8RMt5PV521NhwNm8NKKWnrcpTaAagwUymdx/x/OFwW?=
 =?iso-8859-1?Q?SVv1zH8GMCU/RnLEM17ZhV7NXEBUQ5Cm36Dhae4XEXTfK0sRGTZ436kw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?/7D70wlbVgnn5VwYQgeYtSd7hLkcRCWSlqiacsFWUeb9pwJQgC+zepdULr?=
 =?iso-8859-1?Q?PSfrQ6N3fuDgorsEM1CB3M7aQiir8vZ+ewjbEyoCVg6wRN7BBzy/isaIyR?=
 =?iso-8859-1?Q?NJIjnjIWp8mbwNzwP7HSuv6FESXYhQU7g2WKntXkBFNjoIWd+KGA+4BPO7?=
 =?iso-8859-1?Q?/pymMHuMuuYsjNeP4mNvvy7D25rs+ONJZTpb++eXBKNCStzBq30Hup1NZH?=
 =?iso-8859-1?Q?BcApENrZg383w1TrmO3oeMiD902FmzHBc+KAeeCXXUVPkzKMg+OMBww7/w?=
 =?iso-8859-1?Q?7kxSszob2JtEDmzWMof57EFxf0DeMfhiBBJFejo1C8RUxWb0yWQvSCoimA?=
 =?iso-8859-1?Q?WH7QgCa/NoXRIOij96AQpQDvYRUSh/0YnNjVf1H6QRTyNDdKZdSMl+lIjx?=
 =?iso-8859-1?Q?XF9Joze5ToH86T0Wilicy0xYmR5amjZLXSp1kPG0iFdcRC18sTPNHrdIdA?=
 =?iso-8859-1?Q?RZuVFrqwdHKpnAXQCFTGSLVz+tYoZGqy3OgFc5mSVKQpaKm2k9BgVQl5u3?=
 =?iso-8859-1?Q?OsqXNOv1Eidm+Pho2NltYehjrzTEIHyclME7CcImSqJK86rchAVCT+NmTV?=
 =?iso-8859-1?Q?LSj0tILIkGIT9gLO25cId/H9d5dn1lS6iOCqddhXW6LpDvdWYGU/R1Urzc?=
 =?iso-8859-1?Q?wgZOdXeWqMMD2X23v3odVxLWOQzATXTyQ0vm76mfdTmJ+8c0G63XoL6Yve?=
 =?iso-8859-1?Q?QhB8SbzkTzz2lZp45bHJBy0QcI+o4Eoxg3DfRPJv6/LEFfWe9FVAC3Esb7?=
 =?iso-8859-1?Q?L77yZRJxdc8BHZkBmpzT1cXGKywuJLE6MSzA3UiQtQDkvW/gMWziQB8eso?=
 =?iso-8859-1?Q?JL4wTXB9LkV6MzhUy/85jEtZ6UZkdkuArwC6VJ9OgZAhixe+zFGbl3xBT/?=
 =?iso-8859-1?Q?AXBC39KIb6QbN1sgaadXUk4kdVDUD8Vv6qHxVkU3xuidWETHCJUOUOYkcJ?=
 =?iso-8859-1?Q?HfBO2wy8egfJaxMVumhLsbCGwPZZOY9I6PJXisk4s/PbcwlEWZl8Ww=3D?=
 =?iso-8859-1?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b297f1-6d95-4215-2d2f-08daf3371b7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 18:18:43.5948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeXREIrsqh1LdAiuwBUFmxURUO4bedlGKP4+97AcVog//bEVDUMfD6vIHr3Rz8Ge0Dzzx0Jxw9azX2LUo3lAxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_07,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100118
X-Proofpoint-ORIG-GUID: oUlMHwS1ksNDVL3_9DY3Voo8fEhxn7fl
X-Proofpoint-GUID: oUlMHwS1ksNDVL3_9DY3Voo8fEhxn7fl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mas_prev() does not find anything, set the state to MAS_NONE.

Handle the MAS_NONE in mas_find() like a MAS_START.

Reported-by: syzbot+502859d610c661e56545@syzkaller.appspotmail.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---

This should come before 9df3d25a97ec ("mm: expand vma iterator
interface") in the mm-unstable branch.

 lib/maple_tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7d3131ecd5f8..19d272ee4b78 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4844,7 +4844,7 @@ static inline void *mas_prev_entry(struct ma_state *m=
as, unsigned long min)
=20
 	if (mas->index < min) {
 		mas->index =3D mas->last =3D min;
-		mas_pause(mas);
+		mas->node =3D MAS_NONE;
 		return NULL;
 	}
 retry:
@@ -5917,6 +5917,7 @@ void *mas_prev(struct ma_state *mas, unsigned long mi=
n)
 	if (!mas->index) {
 		/* Nothing comes before 0 */
 		mas->last =3D 0;
+		mas->node =3D MAS_NONE;
 		return NULL;
 	}
=20
@@ -6007,6 +6008,9 @@ void *mas_find(struct ma_state *mas, unsigned long ma=
x)
 		mas->index =3D ++mas->last;
 	}
=20
+	if (unlikely(mas_is_none(mas)))
+		mas->node =3D MAS_START;
+
 	if (unlikely(mas_is_start(mas))) {
 		/* First run or continue */
 		void *entry;
--=20
2.35.1
