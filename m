Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2792E60C3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiJYGUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJYGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:20:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE991BE92
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:20:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P1wdPC013574;
        Tue, 25 Oct 2022 06:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=gpgUcY+JnynjnN0vS/B33MSmd1UEFshxybe0cjgC3hA=;
 b=SGnKubO0/2qFAjMDK1spkAjmaomuxKFd+/JTdDimAwQMgzOXnBrJwUEBfkeh7Wxjt5rw
 i5kvJtdL3uZG6mpHLPoZtBvwAXEM4XVQP9iJbksgovCc9TZDWhbCzv+JAOHCIW3/Ej1v
 dou2nZcM52t3i891jZWfgOJbeUDqlWiunN5lr0fyfXTn0Dsal3P1t6aYyRozhoMa7kE1
 nGpSPuL3DvR2FD0jQmBivrDnuIshLqfZOD3UV321Rb2+DCh46AfkwSuB+aYLoAYd7pZ3
 oMPLfSaxVWK9I8siM+Zr7eq7OhLNxBESXSRGHNt0TgM+ZBz2bQ1EViJ0igDsEvI4vO3p Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xe0ewn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 06:20:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29P4tl63032086;
        Tue, 25 Oct 2022 06:20:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yaktqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 06:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWrtoHJwa2W/DHadqQhbEA553Kp5llmLV1ucdWltzsS7MCXhluA/hyhrNAJf5JFchINeGJsikK4O4EM8wutCWdT4xy5nXC36lnTOpoyC9m5Rq3V3C2uOvOa/ze+oHcqpJJ1CsiQF9oThm1nlOLCsGw9h8wW/RmPg+uQXJsr32P20BES1tu65nFgui16nGDLrH6SucEu/8sBe0rRHOlylNXlY9dIuMTa10zEMB57VTNZ4tzUe3kMnKrzsQF689ob7en8jxhh7U2r0XUl9MsPwN5matQ0iHi3Bz6Lw7VcSgLT0fvHGUQBx8i6573ULW6lBRL86Y4osPL08O3dWHjbZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpgUcY+JnynjnN0vS/B33MSmd1UEFshxybe0cjgC3hA=;
 b=SgC9AWinZlbWnv/AbXlIqV9eoVsOaansxCEOBNexnD+RaW7lXo6bqXj0Cx8g0tPWTmd8VqJsKFIzj6H0XoZiwbBNHDUO/Br4z5fcai3p8OsOO0dEpxOOveHoEfO2LXWqyWYozsmWNEyj/GMUw8BGB9rWFEwJvOLqubD55Vb2OEdTn6vATICKcsrmyjpeXZWnT7+hSAv7iNiH7C57Hn8xJe1V2YSZuPNLxoK8b8+9dTSHuHCkoaYu/q0UDQhZacVe9A7hEyBzbK2xe7OCRp0iTLfAkhiqeqaWU2qouAq1D3k7sEGpQPFnlECrphBqRClLxJrPJ1YLwQEmqY1xD9dufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpgUcY+JnynjnN0vS/B33MSmd1UEFshxybe0cjgC3hA=;
 b=fP7wh3LkDb4LLfzdR7AzXFMaCKHAKT9Vs4lX87ASlI5RstIeAw1E2bgfCEaNGtv/suOkEoJwriCNKOu5U5Yt+imJ1Qj/yg9pdkGGypzQGtF5SV+DWyJKcvjy7zI/PX12U1knFasFO1/AhywG4xr/SN5e63or/1ZU4Fjp0mI8GBQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4836.namprd10.prod.outlook.com
 (2603:10b6:208:326::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.25; Tue, 25 Oct
 2022 06:20:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 06:20:18 +0000
Date:   Tue, 25 Oct 2022 09:19:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8192e: use explicitly signed char
Message-ID: <Y1eADgj7fLKegXDH@kadam>
References: <20221024163005.536097-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024163005.536097-1-Jason@zx2c4.com>
X-ClientProxiedBy: JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BLAPR10MB4836:EE_
X-MS-Office365-Filtering-Correlation-Id: 950f01b3-65f4-4866-17b4-08dab650fc28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9KXRI6kV00hqmUF9ng0b2p7rRatXj54ZF8SLt+tssa1K994EuFCXeZZ7SQleuIM73lKPIY/uSIRlz5IX4xqrw29MkqnRZMhECsG7UKA9axc5NO3PLvOg9bXwYJKYr+d8of5PAvKwRhT0uyK5/uAuUh0L422R2JSp4ZNN8NW4cspC29YEcIRxP6E97DWwzeQO4kP/OF0h3atH6BpTGtvZtqbwksSdnfYCbyZ/fQe76F6V87gHGuoEbIHdqu4LMV/qBA39yTeOxrZqTF7gUDSms77sDI1iXymZE+zu7fl3Oy3W35pmFk2QmLdEv/LuNlV35CqnuKZH/VCOWdodVLn3C3ScYyXHWLW8ES92b5Nng3C7NKGMl3+aZTM34bCDUekdRPzddRmM8pSDhXtxpAjZEoemWofc8Terp7vuolYkNCeT/0MhQjg8fqBPwEKyquVnhufCMWyC6k2AaUX4a2LPGu0M4j/gXTp/YtG+q5AqoiTLSum3Fap+SIrXes2OU4rhIbdwXjWzkBWXKluMB5NfYcPlopeagHuTSommzwLbyn27ixEfy547DAgAZlE+Zhi/BZKatub0QQlIM74mlFPG7Bknw/lHoBreqBGidg797QGUSxQKv8R79iJbZKLj3SBrMOuqalBl07Q2PzXqeqXM30FujtrxWFSm5sApTgBbKBcnkwN8T8Pg4y79Qnns7p7+MR1FGXW6Zw6i4hz8e2SZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(33716001)(6486002)(8936002)(478600001)(38100700002)(8676002)(6916009)(6666004)(316002)(83380400001)(66556008)(4326008)(66946007)(6506007)(66476007)(6512007)(86362001)(26005)(2906002)(9686003)(41300700001)(5660300002)(44832011)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7gCp0dGPI+0lpyzVj7s1vlevddZM8PaWJNzZOFwHDehC4qqgjRalsGRBnQVk?=
 =?us-ascii?Q?A3JaON5+loZexdExObQhJOgvS2/aVWPpFzF5fRR9i8TSYQ8HtYKlE1QdPtIJ?=
 =?us-ascii?Q?x1hHF2eWNF8JUsmwdht+p5FBpUrpKjNYx4dlzhLBQr6gJImowX5ag3fO1FlL?=
 =?us-ascii?Q?KrQ4pmjFDGbQ2hk37v2bQBWQ/GfSszE22zdU80AZgyESPqtC5H3XxaJf9aTA?=
 =?us-ascii?Q?g4MyKpXjby7wtqLsrC+yR3nqhCQ9PVoF6+noPC6iy08NAkgDW3F/YHXuPKJP?=
 =?us-ascii?Q?YV8Ex9mXGyqBg1H0Lbgk7SyOZ13jmOdrx/8M9GShbFJGaF06fAbKH1qJnmEE?=
 =?us-ascii?Q?tnpAe00aY3wE7l91XE1ZSc5/mD2cEcdSKVnuzX6s28E384Z8kmBEytlGyKFC?=
 =?us-ascii?Q?0OX2Am7eFG4mir7UZ+5afQJhG6/4nPFmJPcz8Ao8/BZD9KDQiJ6JwVfrfaoT?=
 =?us-ascii?Q?uBEnwWTLdJVAGaePpg8UMqh7MXJyPIkKX/l4/ZkXnwS2nCf1kf43UnxrDxEZ?=
 =?us-ascii?Q?rIkHSEBfCMNOBBNCtt1REn5xAMRaHoMWSvzni6S1iRHtFQNE5bI1eDPXDPV6?=
 =?us-ascii?Q?nzUvbXAaRku4fDSV7pxrkbLyBpRDcjKFVJqAPTGry7sE5n1rWrQSfiZqDyFm?=
 =?us-ascii?Q?Ve3zf7q+kbZtjzOa+KKE3oMzI/t0/eR4ek2scuUPJIb4aUDrpl86XwpWB7mI?=
 =?us-ascii?Q?bKvIAsXRi8RWOvrElagUBTrY+hKhqznbb7rJLYhjyyp2+0swiExtihtWmllB?=
 =?us-ascii?Q?PU/M6twxdSUKW9CHUGDiJBkT1wf7s/Bvw442JZdnS9i0cl9OTrXWoLmJtrQR?=
 =?us-ascii?Q?9tHBF7HiUkSshVi8f2WM/H0JsZR+oZOzvQqZKZRTy2QXb0SHGGWaFeu5xmRP?=
 =?us-ascii?Q?1DUaOpkHlJrVAhYUmiiTUJkA6P0CF1vCFpqde6lp8oXbwLNSq3/WYecXQZU6?=
 =?us-ascii?Q?5XDJNYW6BLIskOZPaUqPsYXeYMZOeEnEUKLFR8bvePfqiZrZWoFnIuiE5jTz?=
 =?us-ascii?Q?QxKFXpayj4y2zzEHnFMDFS61qnZi4sLa1FhN4krF5Zs7SSMKLzi0dSW2Pwdw?=
 =?us-ascii?Q?9lWs9uMxmXzBAS85TPm0/NCg7eeYkrp0ZMtqew1r4ITlUhI058p9Cbt8S6R/?=
 =?us-ascii?Q?AQo9BuCqTiETmwpoDP6igKeAm0uznr9K5C385N+oEpNua4I6ujbfsFu6i32e?=
 =?us-ascii?Q?IuzqFPKO9bD0zsaOwfC9TKgh0QaPX8KPTU6Ww73zEC0DaaJdlmKI5v95Jmjr?=
 =?us-ascii?Q?zfiIpS0jSZ5CZjKSzacVLJJO5GvBzdANLZU6RwKiHBwNnzAQmPyaTuk7B+sv?=
 =?us-ascii?Q?OiggHpcTVUivHifMx5EBST5sextkQqyjjkBzGpcvQt/nXDJPseIkQGm56cxV?=
 =?us-ascii?Q?fTiRj8+ttB/+IS4bLvgeSBQtC1QBQ5YJXwVJBsrKr1L8XAKqqSaH38ClsIJP?=
 =?us-ascii?Q?Uan91D1iVuMWnBQ/yWhoaS8n3+6cywuuODe6W0ncD8/1hdZKEbtvhdev3Mha?=
 =?us-ascii?Q?NGqxPifPYEY5NqdIdRceM5uYl6eVNUgHtxNDs+v3oqGZLcTG9dXPJw00sNIP?=
 =?us-ascii?Q?PaH5vV8v1MO5wpJRenc30COye7XQmvjuHYWh/FQwheQTYXGvUEw+rTQNiaM/?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950f01b3-65f4-4866-17b4-08dab650fc28
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:20:18.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oaF6GxOPX5puUa6NmDRMzLgIGdvpd47FHpscSu0oVd3Z0sxh5GGD9sUl9bbx4JvdMwshJH9rGvpBrqUYJrltJ/t0JbPpqXIDNsS92C1flk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_01,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250035
X-Proofpoint-GUID: Yq04WRj4a2eH4xIGG_EiDyR2iXNozAqh
X-Proofpoint-ORIG-GUID: Yq04WRj4a2eH4xIGG_EiDyR2iXNozAqh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 06:30:05PM +0200, Jason A. Donenfeld wrote:
> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, signed chars need to be marked
> explicitly as such. In this case, passing `char *extra` is part of the
> iw API, and that extra is mostly intended to be somewhat opaque. So just
> cast to `s8 *` for the sign test. This fixes warnings like:
> 
> drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> index f9589c5b62ba..4563e3b5bd47 100644
> --- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
> @@ -456,7 +456,7 @@ int rtllib_wx_set_essid(struct rtllib_device *ieee,
>  	}
>  
>  	for (i = 0; i < len; i++) {
> -		if (extra[i] < 0) {
> +		if (((s8 *)extra)[i] < 0) {

I agree with Linus that this if statement is nonsense and should just be
deleted.

regards,
dan carpenter

>  			ret = -1;
>  			goto out;
>  		}

