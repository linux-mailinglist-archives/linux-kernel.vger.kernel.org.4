Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE669AD95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBQONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:13:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5086CA04;
        Fri, 17 Feb 2023 06:12:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hgx6011455;
        Fri, 17 Feb 2023 14:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lmeartlsuNxdRXRqbCiGzlg6pdZXllNkILXYYpVQSe8=;
 b=hW4p2cowNXDKMA8YrZGEcWTrhsCYXh8LdiROAdpnrBj01Jn8B2+l7EPghXDE6U8+bHvh
 fAsewiNXlV1iTG1AUAfMC2XMsnysFN+Fto6wzBtgTFOp1jrvQhMdjvF4khudjmIgEG5V
 aluyLr0+/iNttpv5h0WFs+FuYSYPVLVmaXInG0x5TrTy3iOIXW7eqf03qBSldYDetUgF
 yOZ6SfCM5YWm4E4rbPQ47BoKTYe4eow/3hdnHXwe2KUYNF6q+r2ykZSnFa/3SgJ0lwId
 gCPjsIdBdR1ocTCs/jUGe6d7u7l/503bnrQsQKy+lq272VCX/e1+Lwj24fUoS6MMM5N5 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3nw77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCiGGc022914;
        Fri, 17 Feb 2023 14:11:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa588y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGD//zB+pggahnNy+f2mYkvD6oT2J6ztxPjSULyEddZ8cRqf/551Oxq1uOwxmnIjpdfo2nbkxuj/6TxuSE/7/JiBpjNpyhqDvQbcQWfB55ZZwnCn8kR5IwC1tLCpWfsnYb85bzqvLs9XphOjX4TiIjA7OlAHBqgX+LrhmSvRk04uNZeBHjwnwZHSU1nmb8lDlsbNtzNKpbfDrYcUvOyTpgX1haa0BRvoXSsMjUV626OUl3Rr1Ms2WblO98jb6h/UMyWl820R/8qwaRDlizWnCH30V1dq1h/aMoZvI01Hm3925Pt1phXD7SDK16FKxqZSupLS9r6rMxg5QBnvqJTd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmeartlsuNxdRXRqbCiGzlg6pdZXllNkILXYYpVQSe8=;
 b=GIUBb2mKy1CfFe/pEZrjfj33IGfkTwFndPsYz4GFI4L172O89AQelhJlvq7wPADAM3A0Sl9WJ1yg/CX8gZZkdB6JXy+y2noLilgdu9YtWPvg5Seazbud2qbqmbgEHr3IkiPtHwb+CrSPvWaiO6eiw2/bSshOTZLtFrVbeI3vr72PvTteR++oqPv/JHomdydQUaYOV+verr2Hobb9T4jarUabUfKd3Yz72r3iPHT69Dys9RKFX6nMl3e2OlIgWrQEvz9Q/OrkeavJ+k6WhC7ZLXkjhyuEssWoPVQGHCudvrEe0DffVDCe/jmQDpcjuoY3XGyjCTXVYY66NZIKZadPHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmeartlsuNxdRXRqbCiGzlg6pdZXllNkILXYYpVQSe8=;
 b=mVtnw0iihYf0F5/azAGvmoMlDLbjl0oCVHc8QyKTXZ1GrJLaEKXLlcxHqwtC0Os55MXK7kZ73fKUAonFGI4OpWlf3y8+lFRjoWzAwqeksxARgzySCTnliqfUEIBHRetvbAj3g3VWMQLEHOYox9CyBD2Tu7ln2piP0YEU4gGE4vw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:11:57 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:57 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 10/24] kbuild, pinctrl: actions: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:45 +0000
Message-Id: <20230217141059.392471-11-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a403ea-b2c2-4076-30f9-08db10f0edbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OR5kmp3oZvCkleFi3E5j+MebbnXjfTyKaWIrRVZiiykosNfqn/C50+/9PUSyjZhm4/eFNEjBQrSgtm5B5MIt+gLedbAUYxpccpZ20ROsbAPEINrxCHe1a3hgFWqNrIp/NVfm6sx+HpN2aPOmnKJLTfC7sN8LJVsqSlhBxiNRIDXIQc/0EzqhSw5o1C1USymPPiTVqRTaHTBzWoQMivET6DKPS42Rx3bWpS5mdsCYogHpWgDwe35MHvNbYx4cmJ7c+N+D80q3l4lcA2497vFP3fyp6k3E0+Xrhm0QVelkDWsiBE4/xjGphRVfJ4HIhx8QJeOmRsbUfi+xxNZQ/tDw2bb9+kg82ZgzPR4+uiHAcW37En5pq+5ql17zIWuwy/pjRUQogzKKlg4CvwpdC6moutdvjik0Rq8dDGF+wWvJZQG+4wrrf5ZTrw0VahjV5BQqPY6C/eNFXNG7LGZitiRbHVlr1u/qOfrrElfw5FmbDTUWvv1mQQBG5pFdCc4CaAfXpyrxy9fjaYQN5yFZwTuB9MutyFRkjR2/n5AwPR/97KeUMpbZPMK5bLdbe15Gy4hcnT6liwPLLYjqKHkTq6C2wHqRV4eax340wKR8JSbkz2vUiuJvkH2hHmtVD6c97uKYhBwYvtdPeYLFlMpfLGMkog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(7416002)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1JrN2M3Zm9KSzZXb3dHUlBiUGhzNnRpZ2tsdi93cW4vUzBaZVhPM0ZkYjVY?=
 =?utf-8?B?RXoxRlJMZUFjdTV0aG8yOVVjNUJWbUdKaU1ZQXRqWWpBcTRPOWR4MnpldW9R?=
 =?utf-8?B?a2Nla3cyVVNQMjQwaWlUTFhGTmlpbjVJbUp2TFRVMS9sNE12S2hqK3FmZ2Va?=
 =?utf-8?B?SDVVZ3BqRVk5TkFRTXNxZXNxeG94YjdTYzBwRzJZOXhtSGZPUFNZK1NnL1RX?=
 =?utf-8?B?UmVkVzYzeU9KZTAzRmtyb1RjR2p1b3JEMzJJY1J6RFdhVHVLVjd5cWlYUFJV?=
 =?utf-8?B?bjNudWpNVyt0L0dzcTM5a2RXQktlbVJkbXY1dFJkdjVTbkRqTDE4dDNhTHRw?=
 =?utf-8?B?bVRuWGRGZ3lHM2dFSVdkbjBhd09va0M3dGQ5aU9leTZIN3hKTHdvanRIRldt?=
 =?utf-8?B?eGxNdGN5ZWs2QnFiVTd6eVE1U25NYi85RVNvUFpISEVZQno0MFo5RkZMRXMx?=
 =?utf-8?B?VHFVOEZjaHNKOVJEK0pieVFMOVIyNVFLcDY5WjRsd0poYi9TVTI5TzY0alZ0?=
 =?utf-8?B?NEhPSGxFbHUwUUFlWGNGS1dhTXh5SnVPSzJ1SzRTUTRDM2p0TFAwdG5rdHAw?=
 =?utf-8?B?Q0VEVm01QUNQaGx4cWhsc21ubVNYQmtNdjhHbUl5SkIzOEZFcEVaK0dTZGxh?=
 =?utf-8?B?RmhqQ3F1V1doSDdXdEZ6eU1SRko1U1NReGFoeGN1bUNMNWFVK1U3M1YzZ0Yz?=
 =?utf-8?B?bGx3b1RpR3UrUHc1dVd5Ykkvb3lPaU9xZENISE14WFoxbGMwbHBZQng5R0k2?=
 =?utf-8?B?cnpmWHhrUFFKV3ROL2k1ZjFrbUFwTi9yT05nTzdqekpqejJGUDVraVNwSFNt?=
 =?utf-8?B?SHM5RUlPWVZlaGRMSWJ0NHhMN3JncTA2Tk5zaXNzNWRLQUgzWHoxM1E4a0hj?=
 =?utf-8?B?TXFFRVpnY2d1Q0F3WCtTSFBLanliRThWcHQya3JqNjY4c0pSd1V3K2FlbVlT?=
 =?utf-8?B?VXZEa0xOMVYyTmxTTDdNcG1uU3hYd1pSY3Y0bWdsSVlLMDg5akpPdUI5UHo3?=
 =?utf-8?B?NlRCTndSSitidi9GQWplWE5xbTk4QXZtcE5lQjlCaC9WN2RnNzQ0azVHMXVq?=
 =?utf-8?B?SUNOWVMxQndvNlN5NVBhR2hoYzNNU09HTCtXd0VUSDNSa2krbkM1anphazFR?=
 =?utf-8?B?YnIvWCtxa3hFOG1MU2xBbzZNcVd6S0xhRUtrOHVEc2hKVUhMVmhpcXl0NThh?=
 =?utf-8?B?NXRjV1dPbjNBYXR5TFhVWlhxaGR3UUFjWDNwbkF0VFdtUGtvOUpUQThMZVFD?=
 =?utf-8?B?VnBwRFk1cW1ObDNDTTh3UHdYOFVmTDI2OHord1FFU2lSNFcxdTVySEZjblJC?=
 =?utf-8?B?VHc1NUNPb2FCY3NKN3hnTHJLbzZ5a1ZCdjJSMGRWK0xYckZJSDJ4Tm02MDdO?=
 =?utf-8?B?Nm05d01YZUJqNktqd3d1TGN6K3IyOC9Ca2VEVVlzMURiUGs4NEZlVXh0Wmla?=
 =?utf-8?B?REcxWnFBeE84OUhBQmhhdjl2K01XcnhFUmREbURZeXh1Q3BQMEU5alJjRUlB?=
 =?utf-8?B?MDVXS0U3UWxDMmxMN0FLeTZ3cWRrblQvT1gxc1owUjZZMTVjQ3dYRDlvRUts?=
 =?utf-8?B?WlNPbHo5Rm9XUnFUREIrOHNvSGtORUExQmxFZmtOWTJyempMc2V4T1ZVd1I2?=
 =?utf-8?B?eGgyaDg2ZFFsSzRMUGlyblduUGpjaUFyWWF4a3BUSDVFaUREeDdqVUJ5aHZF?=
 =?utf-8?B?OWFCNEkrQzljNjdmeTJvSU9uZ3BQOXZKSWRLekZ6MVR6SnhxckFSMkR4c3JE?=
 =?utf-8?B?eDNXbUdUWS84UEpoN0ErZnNVQjlCQmdvdVBPdk5JNEJjS2cxTnRtYkt5RTdh?=
 =?utf-8?B?dFB0KzRibjljTkdmYmFoWUJxZkYrTmV3elhQMWMvYXBDeHU0cDdZdlZoT0ha?=
 =?utf-8?B?R24wN1VzS1I0MGxaRmg2OUZJbzI5WWR1WGJXNFJyNHBFZXh0ZHQvZUtKaXEx?=
 =?utf-8?B?YnpJek54U1d0Q0ZGdFB1Z1NrZzBuWFNTYUk5blp3MjV0dzFaNW12aTdndzZB?=
 =?utf-8?B?M0h6WW1BMVgvQ3dXeVp5OVFyeDJyWUlOUE9KYUlHVUFZQ3ArUVJDNzk1MHpP?=
 =?utf-8?B?TERFSWdPNlkzNjBFaVkvTFlNd3VEd2pVZThYMGs3eUJSbUl4dWI3ZmZCQzRy?=
 =?utf-8?B?S2JXc2V0eXBRd0xJeXB6Y1JoOTEzVkFOOGNNbDhjZjhRNnNpMTJiZ2NxSnFt?=
 =?utf-8?Q?WFrb5OlXGfkjtYIzwjNhA7A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LhFHQG3AFBOb+W1qwuSuaJApt6jmysE+3plDRB8wy6n452wEQ652JP9Q2NN+BjEzrhg7r/o8Tqwg4LSAK87sn24Vq1y+MWRlTBu7g8RTpWmQJ4qgHImCH+mKYvS6+oGPcaKV7dJ5ZGYfQ/2AW0myF+Nu7WlNaAfBKs5JyGtvzHcUK7sxgDsGFkRaipVRF8vIPvEhFOMFg1Sl2dqTrVXKYqrw7UJ+90nGRxqeUyVf3VPTQHUsPpqzhSW0RToN8BHwmm58aqN7ZzEN9kmB785KkohmN8bS441t7MXENO0nrPVFFrr833J2kRAzOBeOiYVJrgLrnHVd7O7aJ+LBPw8Y98GcnLWrQKoTqeKhjVBbDTPOgt4CUOKVWOkaIveiVh6PFm7g4CflTnpXbFOYYRhX1QwtYcpu9iedIOD6ww/ggyTXH1/IVUOl09aTOSs269KCKggkRQcrPYF5qhesSwzzGLmU8vJAN9/wP0jsSLomSuhTA+ZbwzvB0fecAwmToYMNX1Qif8sgwFYLt1HexmHKmwrdY/UKZX+5kzkQP505E0HPKO4cWSXDr/QHS/SCqzwJNLLfY/x42cWXfjIuNrOBipSu6xsBQw3FP+5ciotET0+CIYqQt8xlO4df86A8OhWyGh0+CSNfIo+l3iFndYcm2Nsb22VanbHgF8rP2iatSZiIB7FmQ99XvEbXDzC2eHYV4Yghgu8PcSbPLtuBhzjCedX4amwrtibgTdo0a9ZwiprOTHvkd/TK4roekYZctMy3qrI/hFuzW8mRsPNbtjzvJnxfpVZICtFYUllYtqbrHd9wzEJzVPfsCTek4tvCpzDHig1pBGa8Y8eudGSbhi5gmGRZ3UWZd2H4UiWwRw8XTjJl6JP8uYc2mx4S00OBssSNZvhA54BvpY/X5E9QTszSKZhkh/aQ2lF5dUlc4VcUHjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a403ea-b2c2-4076-30f9-08db10f0edbf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:57.2340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xywuv1jL1DH9hVyk5vowNTh5hyX6YShfyb8gQYOIFJ6VCVo47jaakHoYCHg/l0MT+0c3ci0AicN4Fm1xFVROqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: 3G9vn5SoY69W-I8UzzNpgLaJO_xyVMyI
X-Proofpoint-ORIG-GUID: 3G9vn5SoY69W-I8UzzNpgLaJO_xyVMyI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-actions@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
---
 drivers/pinctrl/actions/pinctrl-s500.c | 1 -
 drivers/pinctrl/actions/pinctrl-s700.c | 1 -
 drivers/pinctrl/actions/pinctrl-s900.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-s500.c b/drivers/pinctrl/actions/pinctrl-s500.c
index ced778079b76..3bed4b8d08e6 100644
--- a/drivers/pinctrl/actions/pinctrl-s500.c
+++ b/drivers/pinctrl/actions/pinctrl-s500.c
@@ -1724,4 +1724,3 @@ module_exit(s500_pinctrl_exit);
 MODULE_AUTHOR("Actions Semi Inc.");
 MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@gmail.com>");
 MODULE_DESCRIPTION("Actions Semi S500 SoC Pinctrl Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/actions/pinctrl-s700.c b/drivers/pinctrl/actions/pinctrl-s700.c
index fd00940a5799..c2b472660e53 100644
--- a/drivers/pinctrl/actions/pinctrl-s700.c
+++ b/drivers/pinctrl/actions/pinctrl-s700.c
@@ -1908,4 +1908,3 @@ module_exit(s700_pinctrl_exit);
 
 MODULE_AUTHOR("Actions Semi Inc.");
 MODULE_DESCRIPTION("Actions Semi S700 Soc Pinctrl Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index 811249a8011e..8638d3007cd9 100644
--- a/drivers/pinctrl/actions/pinctrl-s900.c
+++ b/drivers/pinctrl/actions/pinctrl-s900.c
@@ -1827,4 +1827,3 @@ module_exit(s900_pinctrl_exit);
 MODULE_AUTHOR("Actions Semi Inc.");
 MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
 MODULE_DESCRIPTION("Actions Semi S900 SoC Pinctrl Driver");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

