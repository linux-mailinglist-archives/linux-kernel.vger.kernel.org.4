Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2FB5F4451
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJDNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJDNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2545B4CA0F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:37:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294DPUrC009821;
        Tue, 4 Oct 2022 13:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4YuPBB8PVWaYQlHYr8vbaOBIGU+eAVyo2b9rnpOWFxs=;
 b=GhAZ/LzHwvXpXALD7d/SZnKCB0kDTW5fL8wtGlOg6IZwmmPSs+/Fbi/nMbXDat46ESn3
 RrSbeSMMfunEJXePQ3bvBIV9yOrCSdDvBkAKkCOZZB9JxjEdg1WXryA8HV71wBrZZhOK
 r/ZVgoy5MLieFCf9MhZx7T1CgiwiQMhTWN90rgJh0s98/jVPj+mEMWfbqIIaOCa5CHxT
 rfzez48gxCYG5IqbGgezXS18wZMjIpV5BGpNt9yaJTv2Zei/Y0MWpeM+hfY26N2oyPsH
 Tpb3QS8esBIEQNiMvuOHooaH/V00zA6d6FZyTKVTu52pCYNsvdMMtHM1YdDdMGQ8OPi2 ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxcb2perq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 13:37:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 294BVhi3033932;
        Tue, 4 Oct 2022 13:37:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc047rx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Oct 2022 13:37:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuJmTKi3JzbTN2KpHObFwah59VL+h3MSZnzHXtFeWtMMT3x1JZX63opBN7LP2QJz7GNoCq8ygTj4OVEcQMbJ3zBiQfTm7QuGS6tDj4byN+wh/7X0hMKrTINiX4BwBJzYCX0LDP9Cl3FDFyM+CPoGmVSIcIVRRLZRrF+J7gq0ZZ8KEf8DD4izhmo6albKx0M0hw7h/ajlhS4H8/VkAcJpwlLIDSPaQ8yPCQaDCeDxNx4cUwlvVXNoLComGqgPO4Ccv54WOY+DaMg7uN4/9b27vJbvVvGspwXhjPIK5cLRy/z3l31exGuDZxVA5spRoMVrkT6YkYI9gYUq0jz79V+fLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YuPBB8PVWaYQlHYr8vbaOBIGU+eAVyo2b9rnpOWFxs=;
 b=B5gp1mrkDfkiD1eb+XeZunASL/b29NiaaGFT20qoJZD1fl0y8qqp8AjE3NHumgpcoPtO5CFxo2ckAtdtFe5qBt8hSJKjuH9ZTS1V70F3HO/h6XR20RUimKexdZ+cbGISzXUXlaPTISTan5r6OEFmJAPcQ5z3iXyMwVht36HFEGfvk+ENZd2pq8j462fkUDQGRdAnKk3pIGyZCwoJSYMJrjgpGDMki7zS2ynyjINeQ8BiZng02Zjq9uR1TKz1QFb3SlvStz13+3yJgI13/tVAqTxh/W/RJWOE+byuuCGNp/DcoTHwcTiNhKQw+qq19xQrpx/ikmmN6llxLiQ/AhN0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YuPBB8PVWaYQlHYr8vbaOBIGU+eAVyo2b9rnpOWFxs=;
 b=S80ynDf03sPMho1lQfb8C9eE032+u9o627padBi9HxIoBjGBViyVlt8MBYFx14fK1T5sgcXQ7IbPNJWI6zLlBwDK9wNcJ8N5mzZgNjisOUFY2A/uE3I3Y1DmhEuF3vbpl0asg1vDsvg+0h3Mbs9ZfIS5BcuFT9tY0qWdmzpAbhg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5633.namprd10.prod.outlook.com
 (2603:10b6:303:148::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 4 Oct
 2022 13:37:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 13:37:38 +0000
Date:   Tue, 4 Oct 2022 16:37:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     "Larry.Finger" <Larry.Finger@lwfinger.net>,
        "florian.c.schilhabel" <florian.c.schilhabel@googlemail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        linux-staging <linux-staging@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] staging: rtl8712: fix potential memory leak in
 _r8712_init_xmit_priv()
Message-ID: <Yzw3G8rPsW1TMhPW@kadam>
References: <tencent_FACCCAB91E1C6F141FE1CA4AC1FF2420DA08@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FACCCAB91E1C6F141FE1CA4AC1FF2420DA08@qq.com>
X-ClientProxiedBy: MR2P264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO6PR10MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 34fd01c8-6a0d-4e13-20e5-08daa60d9a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6Gvo2/PFJNjETAPItYK6V2ak7Y3uaal/SXiodf6HIwuulBrDBe+VfBuMmqpFStwlLcUeBDu73oSy6Qy9HLYJJBceueJkisaaLr1vVVoxUAXJpmACNMeLzZOu3EelsRemceUcgJuVETCWOin80CbUfoFTQZgH6VmExwRj12tnVlJusLEWxEsCCA4VRj3y3KenugWMQ/WfnSNbKeUk1SGGXxp4dupda/vBCoAncqQvDO94Oe1jmhkZykzS/T+Lf1FaXVtc0OUA/UYTKvt0zlosNGSsRcxft15dcDyqEVmWJNnhlp8tKXRTtZ3WuCXIbTra9cILrknK2IdKSWLkKm1jzTEJaQeBCQxsUydmuV626H8hPnrUowVIxvOziocA7C3tUKEvCcO0oqtQhtgHUiNtKZNrDJ7Pg70UIJ8r3DS6qNhG+QakSG6U79st9WiWaJXTKVQhLGyORBYLyTgtzZk6DRl0sfjcdv/QxnliVIkVqmGNPD7+3DNv+0fsMVcHaD3y1L1XhYUk7FcTT9s9N4Vjdj7ve7PBra7GmKzlPsVYmT6HjMfDthLpJSKs95SYFdQHYQJZV7Oq/xL4JzyF7x/pUp6zKSYwmYmfEMt7cJROxVJZhBdA9FJOZJRWKM1A+9avhBp3MYJsNUiwp2F4FV6kqdbCXmC+Wl1fd8buxzFGoqaNBdQbf21GPpetLTXuSUUFuevhz4IkAdivOWeIGNxTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(6666004)(9686003)(86362001)(26005)(2906002)(8936002)(38100700002)(54906003)(66946007)(6916009)(8676002)(6506007)(5660300002)(186003)(316002)(41300700001)(66476007)(44832011)(4744005)(4326008)(478600001)(33716001)(66556008)(6486002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PiooTI/7Zc+SLrwvUB6ECAV0XKMyrKJu9qUBrAccvLxMZl7En2PE0Bffnqt3?=
 =?us-ascii?Q?luQJOi0lV/gdCCTb9LfVVibkftViKiePwXOvkphQKn2CyUMnFrkkRpIpA35S?=
 =?us-ascii?Q?XMofdrCOk94sXrtXgl1jkGNheAyHL1sWmR1bLTpKOchfgxNEhKcbANXuR6tm?=
 =?us-ascii?Q?nXgV7yMMIsesk0fEUYUs9fMX0OhvKMWrfTUo0KbEe8LLWXGMouC5pWzB8t0i?=
 =?us-ascii?Q?+7dqClTBV0hXfVKBV8lVjt5JGoIpVN3wKxwZaYDbjti6o0xY+ouqwkI3hdUh?=
 =?us-ascii?Q?iHTaaXSpjKiW9vYmd+AHtXHKMACWA8VwpdFEMdbX0glzDuI9C56KneQS9Wi1?=
 =?us-ascii?Q?ug+XkJBw2ll5oevr+vmJHEV3baSFELz5Yv9IHmuSeOZIqE0kqTp2Dpq4DTfF?=
 =?us-ascii?Q?2bubNVj66RV8wUvubiTNmY3IVitElBduI3ATIEeplN0mKv25wxgneWVgJjFC?=
 =?us-ascii?Q?Ojdc1QJpC80uL8Z3q/AilAI9rfwVEQxQz6UiQzeWPuFZJPzZ1TYfvcON3QvT?=
 =?us-ascii?Q?wQKSNrcK2g0UjnBR/CHzgAbfAhnYjKA9Inso5e4SxTgBRchP5dDdfAg8RF0P?=
 =?us-ascii?Q?kjreh19fbaLQQ6qJ1WrymiLgQOq7lZuesLflkCeJ3wttU2tAwshCEibAUgGc?=
 =?us-ascii?Q?DS3sa9/UIbcuOLe2H1wanPMUNLzAmhH0W6Sfdn/Kz+PlfI62NBt3iUUcnGKw?=
 =?us-ascii?Q?D6ySRGY5e4Z4NJakVJ0umf2uNB1TcbVtqlZZXhbDXwhrXoezQ81JqeA6d+0s?=
 =?us-ascii?Q?SkzxgCb0UI6Wbd6OOkHSC9ujb5Q3K2HUL2chDA7gtuKvLpWXq0h2IlJqfFCu?=
 =?us-ascii?Q?2jfScQiQR22tngiPJG+XS2uWsf/42KTDLTaVeJyt2cMc2v6uAqrIlTghrWPc?=
 =?us-ascii?Q?PP2E3xeEbhMtM3gPBo/AzQbW/dQObK15Mv0f5vYCeKVZ8/KwTHe0SsnlHZUp?=
 =?us-ascii?Q?p4w1bBpzWAWKriexF624O8I1yzn0D4n5kTt6RSKzkhUypWapsysITL9HHTXv?=
 =?us-ascii?Q?lIwyAek93euyAp/1h0xV1do2xVp3KWMByklYC5jpBd+TtHYdnYJyR6R17ed1?=
 =?us-ascii?Q?8yR/lBTJIzOoCqPfPXpN14aI8sEQYY/b7Qh7M4kYL8lHMhEn5zxEUktlDhis?=
 =?us-ascii?Q?8AJcuR8HefJI+XWCTiGXkXD4+lWHq+iPIWMb9JGM0lZIcitxw+nnjM2QjoEq?=
 =?us-ascii?Q?73UgJPrmpcv4xAEvffrKthLhLnvSJbs8qCn3Yi+HGNtgWg5J1eGxN6KT0YUi?=
 =?us-ascii?Q?9lmf2CA6P4NGkOIJCOU7dBQuebxrjUgQE+unEUzFMIVkstW9hJ2+e4aArLiH?=
 =?us-ascii?Q?s6CUKFygVHKSaZ2D148Gc7sMuk1FdK41gZo6QooD1MrfLmBVcmAEyc6EY7Nn?=
 =?us-ascii?Q?xMnBTZid2Rh+oRc/Y8EVPMoasm+whx+hu0S9s2cssTpP5XVqhfVHfwvBuy+K?=
 =?us-ascii?Q?nyipwGfLZMPn6bd7DT6f6VemruurTFFy0x+y8OuFmAW7CaLk0Ej6SCxUAcH6?=
 =?us-ascii?Q?imj02dJzjRcCUdthJnN+unI3nxCrVA7akubT2801euxVYmjNPT1OlrpC9RlS?=
 =?us-ascii?Q?7jKhkJ+phbg4lrn3/ICpSAvCdcKPMUFEGNMgwUjLVtcTc7P0l8b7rvmp/m7t?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fd01c8-6a0d-4e13-20e5-08daa60d9a27
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 13:37:37.9262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvtZGNx9JBOV5Hcytpg3NDaZrR+jnPLx98yESO2gFi9OCEfu17TiaT1ynNc+D4aNjRf3V5aR5adIax75FP89PWf75wacHWTkwUNuvtMCsks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=844 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040088
X-Proofpoint-GUID: 62yS8A6lVl0rWqpqyOzPm_48cwDEzGd7
X-Proofpoint-ORIG-GUID: 62yS8A6lVl0rWqpqyOzPm_48cwDEzGd7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:55:08PM +0800, Xiaoke Wang wrote:
> 
> Yes, the memory address is still on the list, and at the above position of
> `Note`, the address of `pxmitpriv-&gt;pallocated_frame_buf` is also left on a
> list named `pxmitpriv-&gt;free_xmit_queue`.
> However, these lists are in `pxmitpriv` and this function is for
> initializing `pxmitpriv`. When this function fails, the probe function of
> this driver will finally fail. So I guess the list in `pxmitpriv` will not
> be accessed.

Sorry for the delayed response.  I think you are right.  This patch is
fine then.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

