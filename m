Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6269C619
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBTHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBTHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:43:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D77B9EC0;
        Sun, 19 Feb 2023 23:43:31 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K5m1lZ015802;
        Mon, 20 Feb 2023 07:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=IZ3UDbe8GXPYSTJfHSki98DPOJ24seeXlEMY0PwYd8k=;
 b=bVTR+U2WOQbj/oMculrSFGLFmhMbTQHwC5k0HMoqOluXem3mjaAgj809s90hdl2sP0kW
 pbpPWr5yQvi46b47oDUA3YOwQjWMBwAS9ud/VqlAjW8oELbIB8aZ33CyHm+NwG6i54eR
 OyDEtu9F2oi0JLpwPpF+fgCpa3oJ4Ai9+YNuvEf9Zn37gsR3epgNxqpy4WQw2JiAJHUK
 6lcxHPSoN0PWk2dLSEy/0ehfRQr/XSUM5IVqFBEWNLRM0J3PbvXzuAHvLCHDeWZVdtq/
 OWQZ234P+AzjeUfX1B0XkJNaYQlpZk3AmQK7zXqFyv5EIrbqKcfZqQVu9tSfM47J98Y+ fQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntq2emc3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 07:04:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guplKb6mQZ5YbHDoCraOJyqG2/+f/st5Llvu3rdcvtLW0LrrDL2/2+4eRSzJhvaDde+Dy66drO7nZ4jwi2lfh2b1Ig+d/FlZ/pGE9xM6FBa75aYap2KqsNOkUBqPD/JB1uZW2MwsJrUN8+MOUVUpLRvqh4MwV5GmNS9spMTi9iOiDMO7Ft+DSCqP3dcFAzzh0Clddwh1fSyI3ZkXGDtC4Jl7avvud42cbELU/c97rRaSbUB9rddgjZGAbEe7px77M8fLl2Ve8NDp8Jv/sObYRSW2BSOSYl+OsvCjSqq0ma8C8ikEer6f5IjtbWZ3YlVJRgXl4sSfA221cgufThL9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ3UDbe8GXPYSTJfHSki98DPOJ24seeXlEMY0PwYd8k=;
 b=MuX+SXjCUk8UceqDgHaVIbqTj8BG7eLwdzsmJLFh0mUx6Xx+382pHCz0FZSKMSNjVQGrRHE5wbXd4HGY4o5vw5Ybiq7lnBSs971DLC2N9vJW8hVUm7IoT/9KtP0fGj+eQmY975Nyh1mXqbdsutaQo5ILAFrdxooS9zD6hSP8vPBgweA4Iz4Sqm771qrX3kAhKL6lQOzadCOkqQfdRr2K4ODMbDa/sW8z+dGy8Yi8BIpnK0hG2dfT97WJtfJF7uVusU3OCH0DvdLg8pS3clt+eTFTVO/kVMb4+rkTmv8wdJdC+dLrsucVY1cW0gozCQ92eAg9fmIKB8ulzvhAhOCZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR02MB3686.namprd02.prod.outlook.com (2603:10b6:4:b2::39) by
 MW4PR02MB7169.namprd02.prod.outlook.com (2603:10b6:303:7f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.19; Mon, 20 Feb 2023 07:04:31 +0000
Received: from DM5PR02MB3686.namprd02.prod.outlook.com
 ([fe80::72ed:b550:1325:6b76]) by DM5PR02MB3686.namprd02.prod.outlook.com
 ([fe80::72ed:b550:1325:6b76%3]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 07:04:30 +0000
From:   "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
To:     Steev Klimaszewski <steev@kali.org>
CC:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>
Subject: RE: [PATCH v2] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
Thread-Topic: [PATCH v2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Thread-Index: AQHZQeg+G1wnKRsWA0alDqcMCYIjUK7UG4eAgANTyyA=
Date:   Mon, 20 Feb 2023 07:04:30 +0000
Message-ID: <DM5PR02MB36863752A525F50AC05662B0EDA49@DM5PR02MB3686.namprd02.prod.outlook.com>
References: <20230216092236.26720-1-quic_tjiang@quicinc.com>
 <20230218041545.3801-1-steev@kali.org>
In-Reply-To: <20230218041545.3801-1-steev@kali.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3686:EE_|MW4PR02MB7169:EE_
x-ms-office365-filtering-correlation-id: 30ba65f2-f8f4-450e-fd0f-08db1310b6a8
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kADwPXmnjkHDFd2yOFQDIeKP84P8Sl+7zITyT1QwMc8UOav3dWrEuo9xeDYbOCjilyQMetgsK24g8hFhy2U4afn9qF4HNW6LDvjlu18B0LYkHyEuDYvCqPD230Ky7mCYT2LYLe8XFoKZv2K4UJRwdkPMNXlml62DXNRMlG5g/Dacvt3LjhW/e/8xERLfGp43657e83PHqtLy3q+tkvbvigvfcU29KO8w/fNJgiyaHgaBusza8CRBpnDFbkp0QdePLZqOq1DVaUXFTXWFfZiPrAcPzCbaW2S5XEeABX7NeH9QZvBa6YGsb0jfY3olMq1rqcaw8/aED4l3nR9zq4P83YixPs5//It3P4tIaOE4Y71IkPEAVH9UH82XI3Oa7SX91YdxbwHdTExNgEMwQnsAD9InUVrf4kQ2LqDpeshtIWYWcI59+/XX96GRYgjb5QoP1lBwyLDRYKceYN9F5iAJACfC3A2g1zUBAo0xoL0dBVnywre5S6Po14LLxiMPLPS5gDvRMgcqbIN71jrY0QTyd4eBjPDWdyAXI3NMekSS/b3G+n7tfPVWa3Mb9IX5cTPDTRmS3H/creDuVrA59l9eBf8L3PoQzLZ1mLjwegdnTkMfBUN7BLtkgasozdTsdTlo520+JVPLdKJAdlEPSSZ+nxmsvr7F911deqgGt/uT3Ok3lGkJz8ZF5a4YpxaXeXQbmXwxzhNiyALfDlfrN8nPjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3686.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199018)(8676002)(478600001)(107886003)(6506007)(4326008)(26005)(54906003)(316002)(41300700001)(186003)(64756008)(76116006)(52536014)(66946007)(66556008)(66446008)(66476007)(4001150100001)(7696005)(71200400001)(9686003)(5660300002)(8936002)(122000001)(55016003)(38100700002)(86362001)(38070700005)(33656002)(2906002)(83380400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?58jZHZ2h8xBumH7K69YX8S88YP2EAgp3U+QsB4rpE4NLkaHHmZH+bxrZo3KW?=
 =?us-ascii?Q?Dgar/C3A3wLKeHnuk/izllDe5YOFzOlqBm5j8mwSvpu4qQ9imY26U8HlEMqs?=
 =?us-ascii?Q?+DIgSVs+OUOwtmDrwtLXT7NG4tmdvi+phLPPqU06pbsmayD/73SkI6ecUKSo?=
 =?us-ascii?Q?Qpexzi7QTLaTQQuZ9DAMWnu+v3f40gpA1hMZ1BQK/BqsSvZGtm/DpvE2NxTa?=
 =?us-ascii?Q?e3Yxtvkvi+UXybWm+vwP3aZSMGEm+1JpMr9+wY9RcVoF7opONokSXdjv5Uwy?=
 =?us-ascii?Q?OM+4dr8cNJ8TyGQ4bhla3FwIkrONUiBrbHqLIB2BwNAVMNxt7TtY5pU5SCIS?=
 =?us-ascii?Q?YhYGVlSeTx1mc3LwYx9CSsP3zxjN3fxyuzR1HMhY8yYOSNSiCARMR+rX8k3+?=
 =?us-ascii?Q?WQheJhpdFx3O+aMD1eAaQ7wb0i7GMD/6ilFtFP26kZUHQlvPvoaTp3ZONVlT?=
 =?us-ascii?Q?GNU3YmaJ1+v1IlAYq1JuQn8lWg7a/pFfwj5eBfX+U/aGIFqsf3RPONJVrhXy?=
 =?us-ascii?Q?JiVPBWiyNLNfUqpJRxlkwrh9Kg0tQOfjdSL7tINA/EPxr3OiK3QEs5/X/Gsf?=
 =?us-ascii?Q?wX3aSzoZqnxImQyoSfQDLT5RpqG9ZzWy6SJ8Jj2O2OHJzBPh/FD5EIVhHZqY?=
 =?us-ascii?Q?DbpexyFGVR3B6EDCb31kEwfvP4gVhI//C7/HOBCn2SQniEC+OQJF2gg3pp59?=
 =?us-ascii?Q?2erh6Ovy8Y7Cvqe2tu1h7pvkrhkJlVCQs800dChxvjBDtCJI+esLUWekvHmT?=
 =?us-ascii?Q?KyJ4IBHf+mSjzoGHu4ygShQXDskp6VaWqSi/hi1y9h/Edi8Kmo4z1Gf819ov?=
 =?us-ascii?Q?jh7t3FIruGUj2Q63xPoXeWU3Bej/qVz+GgPwNx9DZsmT9rR4YihQKhMBf7Uu?=
 =?us-ascii?Q?zNYKzItRw9vRma/3fhYGMv6CJaYmI23wE4DTcgh9vn3V77bDBCJc8UEM27Hm?=
 =?us-ascii?Q?ltuFtY4qXbIhPF9T7R6bGWPFBugE10Ez5amWYCHGBFOt/tYootLIHS3WF+89?=
 =?us-ascii?Q?OPOUbBZ0S4tVLY5r2yoRtWhW3lKgCPwLG4khjTllNsvXa6vGPrgvWbQubdpP?=
 =?us-ascii?Q?/H9PLy1U8l/0U3OxDjT1j3/X9bfUDWOwm4L1DeWFTlIjvHcvdmsnTxbgW/4g?=
 =?us-ascii?Q?qMxZaF/ICfbujrsVqboMTRiNUlh5tLvZYpSi1wvzskifN7w+MJ9Y1eXSR3IT?=
 =?us-ascii?Q?S3Fbr9S+hJNGQqB3uh0FtOZMbP6R05beACy8zbPJgh2+0j2OZ9KJKQs6Pqxo?=
 =?us-ascii?Q?864cl6pfgIFdpTgf7K+kgYaMvv2/nRNuXbj9KkLrQ23XKxmq/OWosUqFE1/q?=
 =?us-ascii?Q?gOqe5cwxZRlluRSTlDhRTng6+T0OhF9tSMd55MxNF53/Fo08Zs8DhEOM+Ne0?=
 =?us-ascii?Q?k3d2gVQDYXSmsVCPmCDEcfhJ16M3glbAO5CrwS18i160XwtgmEbsjLnnSp0j?=
 =?us-ascii?Q?i86X8ewD6al1RbOxlybN5ecrCo8lN9UbZF1D4gLn148dMhnHFGAWyezcsnjO?=
 =?us-ascii?Q?+7egCNUsaFf/GNroJRNDH1NvqnihEugDpXaNMN090Tb99n6F+HYmABU+dC+W?=
 =?us-ascii?Q?fkS2mZ7Wt6Z+QfaQCBD/6+577nm9oxJCk3/bNzdw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TEhl56X8q4Yr6WUDvAUCTjMGzl70zAnQjX8CgrqrRy3BuZIiKgYCOng/kF3qKaHIrHtxHWXVzCOmDDp/jdgrwXZlVrblUMriXyX/+f7RGtQ7eakqHv0iavYsKBsOkNv5cDv8UoIFg/sKmPbXR9dAbzqMSwqIhdtvWqhEzEDUODouF+JQpD1Qh2zu7VslFADeCtmCdjXCPvhGTaloW8krtbRGNiSy1x7yUiV+piAqbrjjP69EsgbvdffIHZzlwh8wr3N/0zHhK0ES71ufcxuq9Vw2O4O80mzJRCTa5besUglAvU70wGmAjBCzDQcq7mKTb9KGkwn9ZHHoDP5HOwNsbToezULqFlAr30TZNV3srr+EPn3Sy06tW41KM+KCcpbfk5q5+BWYeqNfMbtEMWi4sHoewQWUj7MzzQcrsWjsVD887GH026CqA3yGVpwHeLDnpz5wEkcW2rUAPLPI42pw1F+/fp1qFthQAd7jfeXrBNonJEwpY5Pzfs6z2705sbm8ccKnyOwoq4C0WFxZYJYkdVVvjHq3Cr3etrloZ7SDxHerLTzZ6jWVoJx4nuOL3s+ptydYcwfKgPP8N/a1UQLiPGinedv1/PYIAGDuVLh8FpKOxowtdaM7Dd2eGojT7+qC63UmqTOPqgp9h+ofxnZqnCY/X4l9p2SGUO626U62ZIqEeDrkaSNbNWMcUneXtwxQjsmyiV2/Xukd8XJwcc+giehPDRV4scAMpsnNwHuhbitIVhHNqt7zVo1Zgvuw+gd+4Wk5y9Db+49jSt9I9SeaizTanARA7yT5pwbe3L9ZDt8bkD8/fGy331Om5BoT0XJ08OnrI24lQ6OPSdPPlakmszOTzZtczalFqUw0+skSroqKen1jBFIgw7QG4w36/Lz6a5HhrtJZNiS0FaCR5+Klgw==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3686.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ba65f2-f8f4-450e-fd0f-08db1310b6a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 07:04:30.7364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOX9duw+8FCg2D2X1QQq94wtZ5Jfz0p2pR2Z1uWMjrXgu2So370eIQwt/vmL/5XtEY2wSumeXNK2KaBukdS9lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7169
X-Proofpoint-ORIG-GUID: v9YMlvur1DUm_d2JVeq7NCguY8imY3xu
X-Proofpoint-GUID: v9YMlvur1DUm_d2JVeq7NCguY8imY3xu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_04,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302200062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve, sorry I does not know why I can not send out the email as have some =
warning  , so I removed the code part, you can refer to my inline comments.

Regards.
Tim

>This patch adds support for QCA2066 firmware patch and nvm downloading.

Is this actually correct?  I ask because here I have the WCN6855 in the Len=
ovo Thinkpad X13s, and when attempting to use this driver, I end up with a =
board id of 08c, and according to the firmware, we should have a board id o=
f b8c.

[Tim] correct, I does not know where you get the WCN6855 firmware, for our =
side, we will use different name rule for android and linux , for android ,=
 we will add "b" in the front of board id, for linux we will not add this b=
it.

I'm not sure how to phrase this, and just thinking out loud - if the qca206=
6 is the same as the wcn6855, just with an additional antenna, perhaps ther=
e should be some way to indicate it?  In my patchset, I had a print of the =
name "Setting up wcn6855" and locally, I combined your patch with mine, alt=
hough dropping the above qca2066 hunks in favor of my already written wcn68=
55 hunks, and then combined the two in the print so it says "Setting up qca=
2066/wcn6855" - is there any way to differentiate between what qti consider=
s a qca2066 and what is considered the wcn6855?
[Tim] steve ,as I mentioned previously, we have different board id  for qca=
2066 and wcn6855 , and then which will use different nvm config files based=
 on board id.

Below is dmesg output, and so if we go by the wifi device check, we end up =
seeing that we get

chip_id 0x2
chip_family 0xb
board_id 0x8c
soc_id 0x400c0210

[    9.724834] ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_i=
d 0x8c soc_id 0x400c0210
[    9.724850] ath11k_pci 0006:01:00.0: fw_version 0x110b196e fw_build_time=
stamp 2022-12-22 12:54 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILI=
CONZ_LITE-3.6510.23
[    9.742346] ath11k_pci 0006:01:00.0: failed to fetch board data for bus=
=3Dpci,vendor=3D17cb,device=3D1103,subsystem-vendor=3D17cb,subsystem-device=
=3D0108,qmi-chip-id=3D2,qmi-board-id=3D140 from ath11k/WCN6855/hw2.1/board-=
2.bin
[    9.742358] ath11k_pci 0006:01:00.0: failed to fetch board.bin from WCN6=
855/hw2.1
[    9.742361] ath11k_pci 0006:01:00.0: qmi failed to fetch board file: -2
[    9.742363] ath11k_pci 0006:01:00.0: failed to load board data file: -2

But with your driver (mine too for that matter, but then it's just doing th=
e same bid bits)...

[    9.081003] Bluetooth: hci0: Frame reassembly failed (-84)
[    9.141992] Bluetooth: hci0: QCA Product ID   :0x00000013
[    9.141999] Bluetooth: hci0: QCA SOC Version  :0x400c0210
[    9.142003] Bluetooth: hci0: QCA ROM Version  :0x00000201
[    9.142007] Bluetooth: hci0: QCA Patch Version:0x000038e6
[    9.170612] Bluetooth: hci0: QCA controller version 0x02100201
[    9.170620] Bluetooth: hci0: QCA Downloading qca/hpbtfw21.tlv


[    9.760537] Bluetooth: hci0: QCA board ID len 2,id =3D 0 8c
[    9.760547] Bluetooth: hci0: QCA Downloading qca/hpnv21.08c
[    9.760638] bluetooth hci0: Direct firmware load for qca/hpnv21.08c fail=
ed with error -2
[    9.760640] Bluetooth: hci0: QCA Failed to request file: qca/hpnv21.08c =
(-2)
[    9.760643] Bluetooth: hci0: QCA Failed to download NVM (-2)

Is there another way to check the board id or board family?  Because it's n=
ot coming up with the correct one here.
[Tim] as my comments above, read board id way is correct, only we have diff=
erent name rule for android and linux .

--steev
