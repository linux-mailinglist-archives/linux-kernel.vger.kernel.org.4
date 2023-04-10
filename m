Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDFB6DC30A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 05:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDJD4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 23:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDJD4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 23:56:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F552111;
        Sun,  9 Apr 2023 20:56:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33A3ok1M023449;
        Mon, 10 Apr 2023 03:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=CZSr1f3tqHnIfw5ComVyP01XrPwLq1lpMi72NA6HJOU=;
 b=GFT3fVzGFa6Uf9Y/EGxoErzaJ/UVwqingTtwHx0xpLbMjq0Ds8go/fWhfM5mxoVNreJc
 jFe/4VLXYqgizSznmSXqpu6Hv6XITZEmaTD5HCuHzSxOlI0kV8psQ6KXo2vJGx/5Fl17
 Eyf5yxUGrZdjs9060ghiTEr41E+zLGrvBNZjQpK6oCeRSATh0tgkP7JjapPM3jNFnL5M
 Hh6Dnhj8mEXVNDm0rLp5PfJ2aiBhwWGyzzAvXbl0oZ8UOV1ZErSIBalxCFQaPHRM/nyR
 m93HQCTtwDr0vcs3IBzaCuReDvNbKrePNCgrsMCUwQ6/8f5pExIDmOZ7QIRxLFvKEKZD gA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptwyqa9fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 03:56:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeIX8ndPep7J5HUV8GuOlA0YEgHjWabUoOx3SvolKzS50qAP9MjlR1E0V6zBjHUhZ8tZnD5wDVbF3hGN0XcN7YreiIjF/9SLF2SD/3/C5VSYFCYyue5XPRWTdaBN2O0zIdVQFUHB1dzN+GRkJ227Any2MaIxGOBM4usPGNzJ+mFb1HRn3RsxmpaKiG8tJsnI2/CgHs1Fw0Ydv6QQXOWBRWENs4viHu3W93i45EnA8z0VkWaExW0JWxm10wlDR434mh6uHTPq3sbhbaHPvv4JIJiXjdHigx2VT3Zs2YnrJVj/nYy1u0gCcyyivfGmp8+b6U8nsqEgAdIrbzeXTrwajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZSr1f3tqHnIfw5ComVyP01XrPwLq1lpMi72NA6HJOU=;
 b=SynowH4Eft4n2++utTctKusxHktbMv4urASGd4Bef4qSCsiSwEcm2MWciDPfqadi0d4d6j6NQCa0YLhEAnsmK4NVmdD8hxOj6q0LQuFLfBz4+18c576/jr0UTM5RbR2lfnxIP06+iNDYlQDdLTcB3pIvU0gkpnsGR+PZpCaoCS3U4NltMZriLrnlcGH3tFpyf6MD0152BP+dOq14h3wGgrxxpHuJX53NPFkdbEABQ57ocN6xu79jb0vbr5DNAjaSAc4Uc9y14nVwXYe0WYxhrCc04N4v2I/zRzc5GEWnULYFLKV9w05NccuCNsRViV8JK2M4EhAMjxxRjHP7h5Xoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM5PR02MB3686.namprd02.prod.outlook.com (2603:10b6:4:b2::39) by
 SN7PR02MB9303.namprd02.prod.outlook.com (2603:10b6:806:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 03:56:29 +0000
Received: from DM5PR02MB3686.namprd02.prod.outlook.com
 ([fe80::78e7:1bd:8fbf:38a9]) by DM5PR02MB3686.namprd02.prod.outlook.com
 ([fe80::78e7:1bd:8fbf:38a9%5]) with mapi id 15.20.6277.030; Mon, 10 Apr 2023
 03:56:28 +0000
From:   "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        "Tim Jiang (QUIC)" <quic_tjiang@quicinc.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "Hemant Gupta (QUIC)" <quic_hemantg@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>
Subject: RE: [PATCH v1] Bluetooth: btusb: Add WCN6855 devcoredump support
Thread-Topic: [PATCH v1] Bluetooth: btusb: Add WCN6855 devcoredump support
Thread-Index: AQHZaQE4blh8BZXh3ECiW3gbddTkJ68gBY0AgAPjGHA=
Date:   Mon, 10 Apr 2023 03:56:28 +0000
Message-ID: <DM5PR02MB36867598C679054414EB735DED959@DM5PR02MB3686.namprd02.prod.outlook.com>
References: <20230407032936.14799-1-quic_tjiang@quicinc.com>
 <20230407161242.hydjluny5y6bttmh@ripper>
In-Reply-To: <20230407161242.hydjluny5y6bttmh@ripper>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR02MB3686:EE_|SN7PR02MB9303:EE_
x-ms-office365-filtering-correlation-id: b77523a9-d0f6-47c3-2a39-08db39778ff0
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NWBfsGMu/VEu/1sMIy1nkB89jxSDU2LRxhWfPPQQCByTKf9+/51ft4k/qFHk2B44luuT9TkDMRlfAyCpDZ7AIPNj+hF31j0crkwQ0rwL/kIQxMhGyQNc7jqn1FKo8c+Ij6iCbSt1YiRMk7TUYwbd+TvnQv3gUWabrbJKu+1c+2VwWvZW9RUaEmnIbBqtH23ltQSXbUIBdhOmWbhP101UaQsYh6czZM6W8CaNFBTz6hh71Hg5cyYe81g8xG3TEMz5m+pjyKnqCrw2a2KMLtRo5MxrVaA15MJFMp2mZv9aL5uf3H4LpVLzkOPFhHYJ/iqVCk4XMRYmg3yBDs4tnO8oJzGLyXLXqIUqfrZE6Bp7aMOJ6NyhYXLvuss2rJHPNrmQo248uRMhdzqpbERmoRLPH3rsWV1pSqVDurLyhTbOfnv7BHMLh6cD3n3LViLgCyajwdbOiv9R67uUTmkpuotfKsA85UbH0pTYP+iKvCAhB7xKf7dg5w/3OIAZjpe/Hj5B4lN8NwxHP5IUF+9Xdfo30v8h0fX4KYVGgO48I9kAtOaMg/hA5Ey/4XuYE94UrjSgtAym0p5UmrP4hM/n35quB+3I4na57H8FKGMJSOKIkkGtu76Za8z959Hr31UFU99
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3686.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(86362001)(33656002)(110136005)(316002)(41300700001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(7696005)(54906003)(478600001)(71200400001)(55016003)(5660300002)(52536014)(8936002)(2906002)(38070700005)(38100700002)(122000001)(186003)(53546011)(9686003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NriCEI9mI6m2FrPLSKYFsxARGO/y/2uKudwX4+dKXPQDePBUzG9HwagVm8bW?=
 =?us-ascii?Q?TeKgJK3goA1Y2T+yyG7ltAeuxlJfoxbhRS1QW14QmFoxZaMaWVe2tgAnY9uJ?=
 =?us-ascii?Q?9Sq97ovejjpjKEcVeSY57FZMiMk14rhGpkoPyvu5Q3KmvB3AJGOcdVGQGpY/?=
 =?us-ascii?Q?IygvfiaCC82mRLpOA/LP5Fh7x/pnbAGTK/mbLJN2des8DHr/2IxtLaXfZofP?=
 =?us-ascii?Q?UEGLyCQGbKr3Wf69TO/8Ucqq+gwLrd4F3HR0JrR/7vQdx1Ulin50njdN4OSz?=
 =?us-ascii?Q?vLX+PHuGAFny+S9hZiHTKhsE/fXejZwo41HI5E/CA/nuzcxzxW9lR7w2nuHA?=
 =?us-ascii?Q?wqb6Kxn6I9hFSrVaABCJSJnIHCAtrqp2dobZABnanwsDk0y/NA+tDrB+ajOB?=
 =?us-ascii?Q?mmz6UwDi/U5IFmrXvb53/DtEAcporFkjG+2MaQUC+l51nrk/iv7E4kw1d6Fy?=
 =?us-ascii?Q?sG5opKLwE8wA2J5clnIFkYRS1yZp5wAvpa2P/lDSxIIyTfXb9rWzx8h9h7WN?=
 =?us-ascii?Q?RlumJw461L5GKmAv7GeEc/DC7a6hmWYeET/uGBeZMFC8rzYLE5vJ8Ki8YnFS?=
 =?us-ascii?Q?c+2N3WOk2NqJ00b5SVlvB3qxcC4zTFl4gK6wmIRestpEhnlv4Xmjk7nitqRZ?=
 =?us-ascii?Q?hSdYiJPO/jErQL+MKmfsuOuKNuUMjTkf05PGwI8/FE1O3IJWlljTU0DdXDxe?=
 =?us-ascii?Q?8XxFxyz0SO2q1Rr1NpXufpp0/vNGxzo5l2E6i1+TL9iallAKZJkMOo9dcjjg?=
 =?us-ascii?Q?Ug9lfpM298+SXAbua6p0Vu0Pm03ZHHKs9l7E4uc2iypP1HLe4Yvu1Gcom4VN?=
 =?us-ascii?Q?luSHvYhPxbeUDna85ncGQ8AmHXnokAaYF/16CpwtUBdRTpcIydmLE3LLdfV3?=
 =?us-ascii?Q?KKlFasTz+GdQuFcG84H6CtceJT3eoSpLzgsyARYXj1+3EX9gKQWZGtrQA5E+?=
 =?us-ascii?Q?2SGSLH+deeiHbhv9QSpFQwslOwcg35kPrUbidwNFS5LOpklmbJjD239eTA29?=
 =?us-ascii?Q?3W3lB9Vo21YxHbTf2Ysmyopewqzk4LaFB8os3ya0CyiLSKj295m6ZDOnNI51?=
 =?us-ascii?Q?V64LedqdHn76huESTamtqjcV2YGhRASp//zvABskWONI3JXqmxZEUjVs3gOQ?=
 =?us-ascii?Q?t0X7sE33LOk0RzZnhmmQmbeG35MzdGg2+2HDJZrarlYyFwXRrHvcIFx/qFMe?=
 =?us-ascii?Q?MRo5Vsk+n3br/hQqubpqupF8+4u+edZebrq1sL/mn3jFDIqttVyaUevcNRNa?=
 =?us-ascii?Q?Y4i4GyoHF9gJhXbnyL14WywFtyMzSx1L8MdwKXVrmH3qoH+N0EgRQrvUg3zY?=
 =?us-ascii?Q?CBO5VPjEbTYM2pZN/nf90QR12Xv3M31MkL743PLSt1kk76ZV1PSnhRmg880j?=
 =?us-ascii?Q?aPDITvRGf6jLADtvIX1Q5cGBHqOc+C0mMUTSHhflnS3Q9/jyZyEBoJ/S5wmY?=
 =?us-ascii?Q?/qbGCWgD2rQlFcuTxjq9DooX7H8KsRpXQcEby5duwWyvBf1TmoJDEO/M/i2w?=
 =?us-ascii?Q?pfU1mstHuy4XUlEsDm9nKAFDPbJwW01e3jA/hFSbUM6rZMUb4EieZtysuZ1d?=
 =?us-ascii?Q?VY3vL0yCrfGE35gEF2QF9NueqkpaaHEFDsAmDaSq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oxn3HaWIeHV4MHXfpkHQBB85wO3sjj9jaUpvbSGfDKs5hlV4rgkrPEaXUCucfEyEulGnfhRV8Nip2NWPUPIVvISA/67uCezUtV9qkd9ZHZHXFSSa56C958HPtMKr+pj7rWzqbnL3MnLoVkejuEg4+s4MS8NoV1NHd0ZH7Mwwquh9QtKhjettJkmYajpmIQX9g50Qy+BxKcxRa2wryxvJS2s/gAXEYMnDPP9WRdz7ZDEjgAZ6PZ1Op8neaQd/1Pxeka0gB3Jy/UfUB1RHrUfcPvF8fHdQDsuzADfQKZxoZbaQW8XC9DYQOo9QiI8XOvhMjEtIoPAZd4otm1KTmvXj/IlemvtLZMmQZgMshaPiwflwukX8wOJNPdK4qpBGNXljN3yy9VK8BPHoVJbiq6sVoF8QMcyHTrDh8OERADhZxhGTJOAQ1QqKbolXf3Pxfv2AtrOgVD4OHZmuq5zIHMzLg5li8pooZGV80sIrWWCiP3v2f8dOg3ivPQcoz9ceYYgyiVlnpgWTh2i5aGZWppjDfmmeVWKWqxSZ38T10C6ZSCGLRVSFYSbJz5lsYA+h1DB/v9idkuNstMcO2Ow8YdqwdxQyT8W9LtByPuz1GsY00Awiz2TKScBZO2xvE5i1vnfZhErPrq0rqzd4gTd91e+W2Rl30SuaLwdMPuVEpvNNbaYCoP02OsGXnO16Vp75A810LbCIV6qH2y34d3KKYoCLn+Dd7wRCQS1GDnCrQQB05yIOPKVZfGC+1IyJRhga3C8Tq9bTe/ORZUNoJ0zLaQ1eb4Dmhdo33Y/tVnrhWOrFNaXy/0BtFmht6IZtR73ueXk9u5IUjTTm7/IA0K7zy373kHgPObx1T65OiU1HLGTHHX9tP+NWdW86yUMKrbE9Z4Nc
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3686.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77523a9-d0f6-47c3-2a39-08db39778ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 03:56:28.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuZzGu/TUo8JdwhETuCywwXPUjx4J5BkQTHh0ynYfpWu3tigQ63Ph0LswNTau9XDuvXIdTXy63iDAj9HhU5EuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR02MB9303
X-Proofpoint-GUID: 0_qhbfw_4f5F9MgjZWK1tl9lHWvuMIFA
X-Proofpoint-ORIG-GUID: 0_qhbfw_4f5F9MgjZWK1tl9lHWvuMIFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_01,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100032
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
  Inline comments, thank you.

Regards.
Tim


-----Original Message-----
From: Bjorn Andersson <andersson@kernel.org>=20
Sent: Saturday, April 8, 2023 12:13 AM
To: Tim Jiang (QUIC) <quic_tjiang@quicinc.com>
Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; linux-bluetooth@vger=
.kernel.org; linux-arm-msm@vger.kernel.org; Balakrishna Godavarthi (QUIC) <=
quic_bgodavar@quicinc.com>; Harish Bandi (QUIC) <quic_hbandi@quicinc.com>; =
Hemant Gupta (QUIC) <quic_hemantg@quicinc.com>; mka@chromium.org
Subject: Re: [PATCH v1] Bluetooth: btusb: Add WCN6855 devcoredump support

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Fri, Apr 07, 2023 at 11:29:36AM +0800, Tim Jiang wrote:
> WCN6855 will report memdump via ACL data or HCI event when it get=20
> crashed, so we collect memdump to debug firmware.
>
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btusb.c | 221=20
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 221 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c=20
> index 2303b0a66323..ecc346d8b2ea 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -752,6 +752,7 @@ static const struct dmi_system_id btusb_needs_reset_r=
esume_table[] =3D {
>  #define BTUSB_WAKEUP_AUTOSUSPEND     14
>  #define BTUSB_USE_ALT3_FOR_WBS       15
>  #define BTUSB_ALT6_CONTINUOUS_TX     16
> +#define BTUSB_HW_SSR_ACTIVE  17
>
>  struct btusb_data {
>       struct hci_dev       *hdev;
> @@ -904,6 +905,11 @@ static void btusb_qca_cmd_timeout(struct hci_dev *hd=
ev)
>       struct btusb_data *data =3D hci_get_drvdata(hdev);
>       struct gpio_desc *reset_gpio =3D data->reset_gpio;
>
> +     if (test_bit(BTUSB_HW_SSR_ACTIVE, &data->flags)) {
> +             bt_dev_info(hdev, "Defer cmd_timeout due to dump=20
> + active");

"Ramdump in progress, defer cmd_timeout"
[Tim] will address this comments  in V2 version.

> +             return;
> +     }
> +
>       if (++data->cmd_timeout_cnt < 5)
>               return;
>
> @@ -3294,6 +3300,213 @@ static int btusb_set_bdaddr_wcn6855(struct hci_de=
v *hdev,
>       return 0;
>  }
>
> +#define QCA_MEMDUMP_ACL_HANDLE 0x2EDD #define QCA_MEMDUMP_SIZE_MAX =20
> +0x100000 #define QCA_MEMDUMP_VSE_CLASS 0x01 #define=20
> +QCA_MEMDUMP_MSG_TYPE 0x08 struct qca_dump_hdr {
> +     u8 vse_class;
> +     u8 msg_type;
> +     __le16 seqno;
> +     u8 reserved;
> +     union {
> +             u8 data[0];
> +             struct {
> +                     __le32 ram_dump_size;
> +                     u8 data0[0];
> +             } __packed;
> +     };
> +} __packed;
> +
> +struct qca_dump_info {
> +     /* fields for dump collection */
> +     u16 id_vendor;
> +     u16 id_product;
> +     u32 fw_version;
> +     u32 controller_id;
> +     u32 ram_dump_size;
> +     u32 ram_dump_offs;
> +     u16 ram_dump_seqno;
> +};
> +
> +static struct qca_dump_info qca_dump =3D {0};

Do you really need to keep track of this across the individual packets?

What if I connect two btqca devices to my machine?
[Tim] currently we only support one BT device , not support two Bluetooth c=
hip in one machine.

> +
> +static void btusb_dump_hdr_qca(struct hci_dev *hdev, struct sk_buff=20
> +*skb) {
> +     char buf[128];
> +
> +     snprintf(buf, sizeof(buf), "Controller Name: 0x%x\n",
> +                     qca_dump.controller_id);
> +     skb_put_data(skb, buf, strlen(buf));
> +
> +     snprintf(buf, sizeof(buf), "Firmware Version: 0x%x\n",
> +                     qca_dump.fw_version);
> +     skb_put_data(skb, buf, strlen(buf));
> +
> +     snprintf(buf, sizeof(buf), "Driver: %s\nVendor: qca\n",
> +                     btusb_driver.name);
> +     skb_put_data(skb, buf, strlen(buf));
> +
> +     snprintf(buf, sizeof(buf), "VID: 0x%x\nPID:0x%x\n",
> +                     qca_dump.id_vendor, qca_dump.id_product);
> +     skb_put_data(skb, buf, strlen(buf));
> +
> +     snprintf(buf, sizeof(buf), "Lmp Subversion: 0x%x\n",
> +                     hdev->lmp_subver);
> +     skb_put_data(skb, buf, strlen(buf)); }
> +
> +static void btusb_coredump_qca(struct hci_dev *hdev) {
> +     static const u8 param[] =3D { 0x26 };
> +     struct sk_buff *skb;
> +
> +     skb =3D __hci_cmd_sync(hdev, 0xfc0c, 1, param, HCI_CMD_TIMEOUT);
> +     if (IS_ERR(skb))
> +             bt_dev_err(hdev, "%s: triggle crash failed (%ld)", __func__=
, PTR_ERR(skb));
> +     kfree_skb(skb);
> +}
> +
> +/*
> + * =3D=3D0: not a dump pkt.
> + * < 0: fails to handle a dump pkt
> + * > 0: otherwise.
> + */
> +static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff=20
> +*skb) {
> +     int ret =3D 0;
> +     u8 pkt_type;
> +     u8 *sk_ptr;
> +     unsigned int sk_len;
> +     u16 seqno;
> +     u32 ram_dump_size;
> +
> +     struct hci_event_hdr *event_hdr;
> +     struct hci_acl_hdr *acl_hdr;
> +     struct qca_dump_hdr *dump_hdr;
> +     struct btusb_data *btdata =3D hci_get_drvdata(hdev);
> +     struct usb_device *udev =3D btdata->udev;
> +
> +     pkt_type =3D hci_skb_pkt_type(skb);
> +     sk_ptr =3D skb->data;
> +     sk_len =3D skb->len;
> +
> +     if (pkt_type =3D=3D HCI_ACLDATA_PKT) {
> +             acl_hdr =3D hci_acl_hdr(skb);
> +             if (le16_to_cpu(acl_hdr->handle) !=3D QCA_MEMDUMP_ACL_HANDL=
E)
> +                     return 0;
> +             sk_ptr +=3D HCI_ACL_HDR_SIZE;
> +             sk_len -=3D HCI_ACL_HDR_SIZE;
> +             event_hdr =3D (struct hci_event_hdr *)sk_ptr;
> +     } else {
> +             event_hdr =3D hci_event_hdr(skb);
> +     }
> +
> +     if (event_hdr->evt !=3D HCI_VENDOR_PKT)
> +             return 0;
> +     if (event_hdr->plen !=3D (sk_len - HCI_EVENT_HDR_SIZE))
> +             return 0;
> +     sk_ptr +=3D HCI_EVENT_HDR_SIZE;
> +     sk_len -=3D HCI_EVENT_HDR_SIZE;
> +
> +     if (sk_len < offsetof(struct qca_dump_hdr, data))
> +             return 0;
> +     dump_hdr =3D (struct qca_dump_hdr *)sk_ptr;
> +     if ((dump_hdr->vse_class !=3D QCA_MEMDUMP_VSE_CLASS)
> +         || (dump_hdr->msg_type !=3D QCA_MEMDUMP_MSG_TYPE))
> +             return 0;
> +
> +     /*it is dump pkt now*/
> +     ret =3D 1;

Perhaps you can redesign this so that you don't need to set ret =3D 1 in mu=
ltiple places?
[Tim] Ok, I will address it in v2 version

> +     seqno =3D le16_to_cpu(dump_hdr->seqno);
> +     if (seqno =3D=3D 0) {
> +             set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> +             ram_dump_size =3D le32_to_cpu(dump_hdr->ram_dump_size);
> +             if (!ram_dump_size || (ram_dump_size > QCA_MEMDUMP_SIZE_MAX=
)) {
> +                     ret =3D -EILSEQ;
> +                     bt_dev_err(hdev, "Invalid memdump size(%u)",
> +                                ram_dump_size);
> +                     goto out;
> +             }
> +
> +             ret =3D hci_devcd_init(hdev, ram_dump_size);
> +             if (ret < 0) {
> +                     bt_dev_err(hdev, "memdump init error(%d)", ret);
> +                     goto out;
> +             }
> +             ret =3D 1;
> +
> +             qca_dump.ram_dump_size =3D ram_dump_size;
> +             qca_dump.ram_dump_offs =3D 0;
> +             qca_dump.ram_dump_seqno =3D 0;
> +             sk_ptr +=3D offsetof(struct qca_dump_hdr, data0);
> +             sk_len -=3D offsetof(struct qca_dump_hdr, data0);
> +
> +             usb_disable_autosuspend(udev);
> +             bt_dev_info(hdev, "%s memdump size(%u)\n",
> +                         (pkt_type =3D=3D HCI_ACLDATA_PKT) ? "ACL" : "ev=
ent",
> +                         ram_dump_size);
> +     } else {
> +             sk_ptr +=3D offsetof(struct qca_dump_hdr, data);
> +             sk_len -=3D offsetof(struct qca_dump_hdr, data);
> +     }
> +
> +     if (!qca_dump.ram_dump_size) {
> +             ret =3D -EINVAL;
> +             bt_dev_err(hdev, "memdump is not active");
> +             goto out;
> +     }
> +
> +     if ((seqno !=3D qca_dump.ram_dump_seqno) && (seqno !=3D 0xFFFF)) {
> +             ret =3D -EILSEQ;
> +             bt_dev_err(hdev,
> +                        "expected memdump seqno(%u) is not received(%u)\=
n",
> +                        qca_dump.ram_dump_seqno, seqno);
> +             hci_devcd_abort(hdev);
> +             goto out;
> +     }
> +
> +     skb_pull(skb, skb->len - sk_len);
> +     hci_devcd_append(hdev, skb);
> +     qca_dump.ram_dump_offs +=3D sk_len;
> +     qca_dump.ram_dump_seqno++;
> +     if (seqno !=3D 0xFFFF)
> +             return ret;

It wasn't immediately clear to me that this means "return OK, but we're wai=
ting for more data".

How about turning this the other way around?

if (all_data_received) {
        bt_dev_info("memdump done");
        hci_devcd_complete();
        ...
}
[Tim] ok, I will address this in v2 version

...

> +     hci_devcd_complete(hdev);
> +
> +out:
> +     if (qca_dump.ram_dump_size) {

So if I get seqno =3D=3D 0, followed by seqno =3D=3D 2 we will print memdum=
p Done and return -EILSEQ?
[Tim] we can also apply pattern byte if needed , do you need me to apply pa=
ttern bytes in v2 version ?

Regards,
Bjorn

> +             usb_enable_autosuspend(udev);
> +             bt_dev_info(hdev,
> +                             "memdump Done: pkts(%u), dumped(%u)/total(%=
u)\n",
> +                             qca_dump.ram_dump_seqno, qca_dump.ram_dump_=
offs,
> +                             qca_dump.ram_dump_size);
> +     }
> +     qca_dump.ram_dump_size =3D 0;
> +     qca_dump.ram_dump_offs =3D 0;
> +     qca_dump.ram_dump_seqno =3D 0;
> +     clear_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
> +
> +     if (ret < 0)
> +             kfree_skb(skb);
> +     return ret;
> +}
> +
> +static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff=20
> +*skb) {
> +     if (handle_dump_pkt_qca(hdev, skb))
> +             return 0;
> +     return hci_recv_frame(hdev, skb); }
> +
> +static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff=20
> +*skb) {
> +     if (handle_dump_pkt_qca(hdev, skb))
> +             return 0;
> +     return hci_recv_frame(hdev, skb); }
> +
> +
>  #define QCA_DFU_PACKET_LEN   4096
>
>  #define QCA_GET_TARGET_VERSION       0x09
> @@ -3628,6 +3841,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
>       if (err < 0)
>               return err;
>
> +     qca_dump.fw_version =3D le32_to_cpu(ver.patch_version);
> +     qca_dump.controller_id =3D le32_to_cpu(ver.rom_version);
> +
>       if (!(status & QCA_SYSCFG_UPDATED)) {
>               err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
>               if (err < 0)
> @@ -4117,6 +4333,11 @@ static int btusb_probe(struct usb_interface *intf,
>       }
>
>       if (id->driver_info & BTUSB_QCA_WCN6855) {
> +             qca_dump.id_vendor =3D id->idVendor;
> +             qca_dump.id_product =3D id->idProduct;
> +             data->recv_event =3D btusb_recv_evt_qca;
> +             data->recv_acl =3D btusb_recv_acl_qca;
> +             hci_devcd_register(hdev, btusb_coredump_qca,=20
> + btusb_dump_hdr_qca, NULL);
>               data->setup_on_usb =3D btusb_setup_qca;
>               hdev->shutdown =3D btusb_shutdown_qca;
>               hdev->set_bdaddr =3D btusb_set_bdaddr_wcn6855;
> --
> 2.17.1
>
