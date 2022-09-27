Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8445EBCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiI0IGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiI0IGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:06:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96A78BD7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:00:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R6OlT9022448;
        Tue, 27 Sep 2022 07:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=1OPIYfuIeAQz3WKFE5G4P87PIzkBr7i+H45FEU8wyAM=;
 b=TUdX4m+MiN826wv0wo1CSVnkTKN3Z5AxtR5ESJl1ZBT17638v5jImUlGlJS1zwvqRX1x
 aArTNPKSgPBR+7F6M+CU+6Un+F7uzc2uJWPTobs80ydTF1EM3bFz3Ts56Jh+csjtI/yT
 3Ux6XJaUEc14Yf3k+ofJmz/ZBvWOMSN6d4mH7WCOekr+wr0I9Pv7DkprSc4VYiVUAVZT
 N4hhbp7g/h3j+vD8NE6zO9AjI012wD/wKAn3PzcKGlSqN6jsxhGXJt6LjaHQqPFytaI8
 4ThQvHScmIrtw8lIaib12am61sbc3XdvJZwrt8GzCteWMYkuPP6IlfS2O/lneXpbbsPW xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssubdu2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 07:59:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28R7ZhIZ001501;
        Tue, 27 Sep 2022 07:59:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv0865j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 07:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9LbS3/+JBVPxCkcNJM7YXdnF/2c64BCTy/4XknIH3uitWuOBOHguG2AAFPgF2+ot8Z4svmBlKPtSNxstVDiDRSnkaKlReaRzCKBoihx32JWq8dQF+YzSIV+lke2ikOoHWyuMQ4DVaLUrV/JRub45Zc6J4VrBgYqk0iBApFvzA62+RH1UKeG81ieba4qLPJX4lZCvTZQULTyCKBWZTKNc3XCn6yVrZ1fjuf14na1ygo3puGId4q+rwMSTnJYknLwDb2CBlPalyppJr6/dG8KuiFGUEeqiY8g4J0Y//1Zu1yWBrft9e+16jpny1bH3HQdWINXTCXpJ0ZCfFjQzykgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OPIYfuIeAQz3WKFE5G4P87PIzkBr7i+H45FEU8wyAM=;
 b=ZWie8ZXfzRK3zEZ1e3aOgM9sMBGxrq1NJ9vWNNxuIyOvhjiKFk52piSKYdIOVY/ygixKPG7AAXaJUxsCzGR9AI10Ybv1FerlSp+4jlq27y4vbooVPDyu78qc3PtdctGKQV+gyhZuSPfnAZg2FThznremFyxYyzh+1gQR1JNJ+RaDLFDer1eUrvzkyMAF/804v3ZlmHf8Qoxu95NX4bRhxPHDeWe/JyiqPU8X0rnHMTmKH0N+mzrp5EZ7264ULI1b6F6lHV2eZ5kE1GGgz69meqrGhDQmMUDRJeWQ/AUCCN6559ZHFR7SKPyk91ee1EcpBAdUmE1pwC5xvkOOixNh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OPIYfuIeAQz3WKFE5G4P87PIzkBr7i+H45FEU8wyAM=;
 b=ce5lRYre36WpiHzYMcTCU5oQY4zT2prmlPy0K0qs/W59+wqS0qvqZiDIeeK//rsdS5oeJDFsw8dz35C4Zg18aTD6Y76R81W67hieQMsskJQQOwZqjTnlkf22YNByOa8gej0jc/YrOYA2DuF0pqQamBuklIclySQG0e+W2XJUeZI=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by PH7PR10MB6154.namprd10.prod.outlook.com
 (2603:10b6:510:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 07:59:38 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::25b8:540b:9e72:ca93]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::25b8:540b:9e72:ca93%3]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 07:59:38 +0000
Date:   Tue, 27 Sep 2022 10:59:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xkernel.wang@foxmail.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: fix potential memory leak in
 _rtw_init_xmit_priv()
Message-ID: <YzKtYksCuy+xrum4@kadam>
References: <tencent_F8100CE69CDC080E218AEF7033A5CCFF2507@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F8100CE69CDC080E218AEF7033A5CCFF2507@qq.com>
X-ClientProxiedBy: MR1P264CA0160.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::11) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2358:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: df8ca91e-c9f3-440e-c781-08daa05e39c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZaWQeWK4VKdGeNTvIh+SEk+a5YUt5y4DCRxaU1U+TA3Hh4JXAr6Sf/HJY2ryviIwYGBXeFNruHj0Pv0nUwmHsZptRF5+f9Z28wP2t477eeZ7JYxUYnMiZNc7ZUe4BosCaK0vhKvkdo2usk4Nq2AkBRaN6B44dnMIuJESiOh82/R/wthURV/X2XBqc0K7tSkkyzi2XZuhUfyZBvAqlN10rFkhQcjGrJQolWVX7VDnheMLmdUBlmBaavuXckxPZMe9jTEhl18vAy70QLy6CCan8+ARP6yaUF6wI4pcuBs2bPWobUz1j7KZJd3gklJYZojRPEfk+u00pdGO1/8224EHo0xXBZkrovzLRU2rBKNGk5AHelsMFN71YKXkMuFg8KHAFmWuZ7z8UDvtFvWGjt1mt76c9AYb3+ugSJRzp7LU1ksEIZ68sFeIDA1e9M1JNyc2Y5io8lclM9t/Fd+SVNasN8JPR+N9ZLhWjf2vPSSn7wlZWq5EokgjnyXLZi8DpVldxQnADk+e/z/iV1mVWuv1CTSZ2qYO4FrOOeuTJdAi0QTOqyJSpL2BzTZV0zMJ0KPfsxLdR6t7xao45Fyye4NzyKjQKvKb7LpkvGiR93WOdgF6B2gHFbwJySNQ8V6XdKg9ImtlcrRTrVazf2CAD/ar+zdhCBV+h9gkDasEllJaJF3xEY56H0yGZ7rsxrFg4svo8W/xf2CBi9PA8cpKPdKTgSREvkt9t+o0jvM44opYQKLnG3SnRuLJF9f1j7O+xqMv/8oL3FSsfcrJmwf+shY2EcF/ci8ZM9OxjjSvwIJ0QQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(38100700002)(8936002)(4744005)(41300700001)(186003)(5660300002)(44832011)(316002)(6916009)(86362001)(2906002)(6486002)(478600001)(26005)(9686003)(6506007)(6666004)(6512007)(83380400001)(66556008)(66946007)(33716001)(8676002)(66476007)(4326008)(48020200002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LH8vKLJI3sZS+1FMLQHFVmCfSm+JrJftQePGMmZhbQeGmeW2puP4yQ1QqUbP?=
 =?us-ascii?Q?np1TcqS34iCVtFMBA7XIqbdyaU+mVGIyvt9xwseG4nQKzCu1UPaWk6kNzet3?=
 =?us-ascii?Q?Xo4NdnYtCb9vU8adid4y9+7YTeAf/FOc2fH2lHcppvMQveRSnZlhxkXnxHis?=
 =?us-ascii?Q?5Ay1kCjIU21rwt6HEI/i7NPnZs7M57+lNT9YlaIMqR6L9/XWS9aStlIieY0g?=
 =?us-ascii?Q?UFGpGwjMA8kvXvpyUFO5YgbHZAU3aB5yWHCvWxzz1kWpTqvaTGm7mtejnyjK?=
 =?us-ascii?Q?x/UaHRB53iQ2sspZLizNjZLnqutCGt76Aw4zVkB1j3RRjh8iIFYcLcXOQWwC?=
 =?us-ascii?Q?iDCoMiN/uaxmhipwNAlDJkwWV2zdRgUIe7NNYR4ecyvxXwkR4F/YhREC+PZ5?=
 =?us-ascii?Q?S8/pT7EOCOLz06o7nKzNXrGuV+K5dA0RFfWzvccWi8YSLicp0XlW68fBA3il?=
 =?us-ascii?Q?wpFVE7uocwsybIBJw+tNTKQ1WH9Dv9rGOgw9mfsCMmIPrIF/SHJSVqvLpm98?=
 =?us-ascii?Q?GfF4YjZ7ekTB8sF5Iqi8c1e5cwX+RN/33wl2qmIW1wRkJwzBF3yYVptw74V2?=
 =?us-ascii?Q?1vPcP4CH9Gr4Q+phsrv1Gg4vBu+KcJnmjUDCM/7bSwbpsU7Vjoerelkvx2Ir?=
 =?us-ascii?Q?XxZT5Dd6vfXfAZ5Dje9QbbNv2FZEdLceW/h2SycpzV0b0vv3bH4RMo370HuX?=
 =?us-ascii?Q?n+aK7PDy+4gPhLwO3woOeLvAETtgumgEDpsMLPn4ce12spINu6TbrMIu7tOO?=
 =?us-ascii?Q?V9OX3DcoxXepqSPYFugQ++DYhd63W62OuN25voaX2zPOWPVwlx/5O81lPHQI?=
 =?us-ascii?Q?G2ZN4AMlbYw5OSWOjN9hNIBib6uowa0WL0mGtj3QFSDTxTOqc8H8XA7SWFgP?=
 =?us-ascii?Q?ECyj41cUSwanf9H+BghdagFl/JJOgz//00CsK6/ra/zgm8ly+i0GvpIKhema?=
 =?us-ascii?Q?q+qKbquhOWFP2p9OIKxxfiJIik4YAURTfdqIFB43DEcjFG+D5TbzTZSDXJFw?=
 =?us-ascii?Q?NcaunGtXaqAyav/wsn2ffd31zYDb2ZKETvTJ7KyP+rJu/9lqINiiJU0D3CVw?=
 =?us-ascii?Q?eCqY6/Q42LQZZPtTDVAN1Gpj9CzYXPHS+UQNtQrGKVp1yps3lYAaofKZSwjj?=
 =?us-ascii?Q?+STEgCqOEur/uUomVjEdIUq00TF7G9MKa1yaW7eDcX1xkcSkiG7Np1jV+kF3?=
 =?us-ascii?Q?srQErMj252xywiZf26gDHzssXwdu9eFngWzmzRJ8Vq+T5SoS1GRDfQ2q21vz?=
 =?us-ascii?Q?rHSHVbkJD1DfnIUbyRxvjDt1u0g1LlahugEIgupCZ4yBLdZqVX+Yjx0Zp4GS?=
 =?us-ascii?Q?OCqXQMVjTo8IK7a4gkC/a1Z7vVDgUxsq6ibO4s8YYsRTNj7T98hv2Vfb9+ZE?=
 =?us-ascii?Q?ksdsYLtiLW0OJgdwmQjqiS5EZehXoomSeJwxSX9shjB6Akq5QXQDk6R+LAI5?=
 =?us-ascii?Q?rHllTsKBwvffygcSrobgNbxBltshDDCKOYP1/g11fQK8R+4D+5mXGHBxZ77f?=
 =?us-ascii?Q?3WirP3M2SeKSvLZ+7FmqgMQ0mMenHNc1Foq2JbmHmNx9/+g350YoB5btSBCi?=
 =?us-ascii?Q?X/FTiIkwfzhh3eqxv7GLGuVtHQhLh6xwAZDKfDqV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8ca91e-c9f3-440e-c781-08daa05e39c6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 07:59:38.4919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiFH/rL2aeE3ZVEw7imEvHBzGERZDgKTskB+wdKq7pCQXr3MjwhJuQk97YAZLU5oSl1o+WRbIO4LEsB5D/pVvmIDL+p6RazeLpPJscm/trs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=836 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270047
X-Proofpoint-GUID: pxEZwsWpHlZKUenK470Z8ANYG1etTyx1
X-Proofpoint-ORIG-GUID: pxEZwsWpHlZKUenK470Z8ANYG1etTyx1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:54:57PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In _rtw_init_xmit_priv(), there are seven error paths for allocation
> failures without releasing the resources but directly goto `exit`, while
> the exit section only executes `return res;`, which can lead to various
> memory leaks.
> 
> To properly release them, this patch unifies the error handlers of
> _rtw_init_xmit_priv() and several error handling paths are added.
> According to the allocation sequence, each error will jump to its
> corresponding error handling tag.
> 
> As there is no proper device to test with, no runtime testing was
> performed.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

This seems to introduce a similar use after free as mentioned in the
change to the other rtl driver.

list_add() followed by a free.

regards,
dan carpenter

