Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A355BC61E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiISKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISKND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:13:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F621A3A3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:13:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J9EB8V026328;
        Mon, 19 Sep 2022 10:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=9N+DBMhwPkzn8eXTGyihRwauc0vWmzUdZW4/m+Fa8IQ=;
 b=icwtgq+p3iRhLCxJUW1QVD9r4UpUxnIgwaH5cCTqB9vRiCsQnTStuMuV2U3pnIPeBrHf
 e33oRWEpI+l9vQ2Y0mUsX8ZNtQ+ve+KyscxNFQRIkJrfIedaVmCkQhgmFO92nZTXKVR0
 9gSCpDM3VoQH7emrIIVvQvLcoIlur4nl+dONnIbQmN91UxdDh67THdetYIZluL5z7HlP
 QOTap2eFzbhcTi4rW2ywi+NQlQgzjhXhKp3RtIAD2V8HCY2Q5O1gaXuNPwfNnbHF+B1W
 swQTVeAdYNFT1CqcLk52/U1yOwJPTPLmfsb9OTK2G5av/EhPMBadHzYjiot7WJ0lgxWQ Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kkc4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 10:12:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J8CpHM036338;
        Mon, 19 Sep 2022 10:12:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39c58ej-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 10:12:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbW7/PAnMcmzSGzG9w68gUXN90eHj2O+F/mWaTNsvhjAA04+z3hyczcY1U2OJSl6CFsck7Z0YmSO2ltBFLakN7Tzq9jr06T3ueFV+LgJOUYvC5/JAxkln6cf9gy78UpVCj6iISwwElWtGCrAv/EhqX9M3VjKASsDuvnzXOzWNrGSnaRfs9ePMUHr6tM6KtV5DJlTZ1MDhL7A7JVqWqv/pnKChMsSM7IPrFR3nhuRrKSd093C9JovePiWsweTQ778FZbSQsoFoJAegulLUwUQN+pcSstVPaWp8dvIOGRVwE96VC8pOr4rV28XrZUNlBemvi/icdomg5iQUANtueIgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N+DBMhwPkzn8eXTGyihRwauc0vWmzUdZW4/m+Fa8IQ=;
 b=mxc2YBpM14Ommg0u+Mp/MqCo+YBunlE6m1VTvCEtxUVcb7p4M1JmQ3kDC8tdWYel8geKAdj6wi80dNU91i7xnB20VXC7Di9JAfP0jV5brK58CDgVWEkhB/5LItPi/6tJPsdooM9+DDDmLqOAiyYyz5X5OZP95iRurrLJ8PQVua9ks+poeODUSbuappNkoQytwWlVH5Dy6Fak89HemtzamkNr1kRKzUa3gxdj5f6ZiowhmDI7eKl1DH7yxmZ6u81uS6jArfyvuxK1Ho5xBDdJOL3+mAxk/N6ZEm77rCwsY6Yy5cTpO+DaZMNwSwGPZK5vr/256145wFWCUZ/9yYcPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N+DBMhwPkzn8eXTGyihRwauc0vWmzUdZW4/m+Fa8IQ=;
 b=diKnIM0GK+xEc05f4o6mZmE45zfJMJGkmZog74M8TmKxex7I+WltVv5ADgEQgidxGICtaHEm9F4UXgNhQ7eCUBGedDH4WCFtUQu6conK5i7mIT/IW2J2ij5SWiz0Ba1QjfRttN8V/5BVHfsJwlYDQMTQ4slTDLXFAuqXDsetE6M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5741.namprd10.prod.outlook.com
 (2603:10b6:a03:3ec::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Mon, 19 Sep
 2022 10:12:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 10:12:52 +0000
Date:   Mon, 19 Sep 2022 13:12:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        philipp.g.hortmann@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] staging: vt6655: implement allocation failure
 handling
Message-ID: <YyhAhiUlclk7HxE3@kadam>
References: <cover.1663273218.git.namcaov@gmail.com>
 <dd63998765f1ea1bf507a94c2d49317b36b5f32c.1663273218.git.namcaov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd63998765f1ea1bf507a94c2d49317b36b5f32c.1663273218.git.namcaov@gmail.com>
X-ClientProxiedBy: JNAP275CA0064.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SJ0PR10MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6ae19a-35f2-4648-29f0-08da9a2782c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAUsYy2hnb+fHCip0XgPed8o0XiI3JFSe1U7iY5nlGaoC7WcRog9uKnjBh2f+p1LqrRFeIlwQ9kbgMe1sfWm5APcfDw/iasSJULoMbuF1MIVhplRMEtHaAdIY2922cTA+46/XfWBt5XA4yWQLS/JyBi2aQbRUfeY0rDLS4BI/oyaZkTOc8JyPi1ZeKD03BI1920l5Yinr31oUrTvWAixxZBpGv9MKDY6B37crNl8Nr/QIbG32yq0BVC2PKjuQHS9IglEjEcB0KlnnrudjTOslY6W8H9GxGLim85crmjOv5yT2mFCmPcxywyoxU5nJZBccBuMouYO7HfO3ffCEqxyBfJaM3s6wZJDoo8ImhLhvApx12wg6sjudOxPSKD/aOCe4/ZhZjr0M+we46AgFkjeB+VyiIcizkJgppJ6DCyhNR5Um31vYsYsdlg1ammwT3npfX60V3PM7uIGtjdXz/if1eAj+OCbnafErz2nDAR/R7YobM9YPKDqFCH3yX7+7+ntFSflOsn1caBnuC32Ex5UnC3o0+BIfIAV1osJRbIAOrDBknvkSWB5aoMCYswnVdH8QvVGqtkHmcl5eHlOmdgsTxs7VdFRyrkTGF9Z1IgoFL+9C85I1Z35L9SM6vIRalOeoVGVkalskgYgttvu6Dky3XAL5TeLfRg0GuUiPhoQoexIxf6KMoHSQmsgfmG+nkwrxABJdaIlm2BRLgpsPfzGC6Hg4D4prJglcMGT9Q//KUit8N1WF9eR/uJWj0fHlF0r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(66476007)(86362001)(38100700002)(44832011)(5660300002)(2906002)(6486002)(478600001)(66556008)(4326008)(66946007)(8676002)(8936002)(316002)(6916009)(186003)(83380400001)(41300700001)(33716001)(6666004)(6506007)(9686003)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tABB5xx7UMCheA53PuRm1o3z8ntiymbGVPotVqmZ9XuWJ6Xlq7kByv1m72c1?=
 =?us-ascii?Q?Tzd5L7xZQMhb14ruMBvG2ZWMcgIe8mMIGN0YlqURQwMSWUD86dCil0bp9zci?=
 =?us-ascii?Q?qCiFsVOuXYC3K1dRgsVN4dGKw7QA+pChtM4QkQ4oSpY1cfGZ9cgOt75L5onV?=
 =?us-ascii?Q?BN7/Pq1tUohuiXdXICuqRItY7sxW7I3DsebML5aG383w0xrbXjJPivM+JA1d?=
 =?us-ascii?Q?AETGwTGuVlykZL6vxdyjENLykhi5mSnL+f0mc0MtW5Y/lTwJVyqV78OmER+g?=
 =?us-ascii?Q?jmeK64ogSBU8Bih2XTg32sooDL4i4jEewE2HbahRhRr3dIcGbry2R5p2s3Ym?=
 =?us-ascii?Q?cijQXPNYjcWWjrbqYB/YXNqj/bvAk8Y9+bVfGOUArs+YHI5fCMOOvRhgs47u?=
 =?us-ascii?Q?bIdInctOeQshV25FlRGpM1JFOEGhRj8ylaXFFnEKpx8JkIVhO709suZweTRj?=
 =?us-ascii?Q?5fh614SVwP8mDqMCCtjbcU1v3GE0VLDPYemjNgwbBsNy7eyO5HR2mwr7am6D?=
 =?us-ascii?Q?6zTcge6Lbr1wewj46aPHuXrpfVTOR4u0QnPIRwlQ0aCS/xyCHVvoRXRbyzH7?=
 =?us-ascii?Q?ZCHKEgjGNHB2+FIbWfEsyeKKdBBtxoLh1Q0FTZVn2GSilft1gKXeIWeX6dPb?=
 =?us-ascii?Q?+3jepqhtqCs4+eNqtK4775EcIfHTnGwNe3Vv/cUPs4nkou8FAlctqnSfageY?=
 =?us-ascii?Q?NOLEEpuOoOr6ejyO0I5/94NprJzwsyO6uKTXquS9x+VCarknx87FtP66GEOo?=
 =?us-ascii?Q?kvg/N9WJ+gbsADYh3VbvV4f7+cvQKCTBkc2eGFX54YpvFO7FVScofwLLdWFh?=
 =?us-ascii?Q?no47n5OI0EwFXol3xyVKdleiz+m6dD+n1CPNbOrRNDcQU5MD+atMGJZ86okN?=
 =?us-ascii?Q?+QQP6BUvXIf754u5Puaj6qvNSk2rsiBLNqsLWWMpvD8mlsmOi/akP0PtxfEh?=
 =?us-ascii?Q?tgbe5d2q7ss6QsHaKnwu+QudpBH6pk58Ps4UDrBfGd2ikYFcVt1CJJ2weFnC?=
 =?us-ascii?Q?rW/sKFO9G/rrPfU3XP5W8k6t7pPlWxZjiu3BBX+jjXwNFYIkwm5DF8zZUHXS?=
 =?us-ascii?Q?DwN1Y3rZrFDlXdk+rb9ppxIuLvT5BI+sh/hBYnZAfVfXQh6+Z+Y8Qcm4YUHX?=
 =?us-ascii?Q?MNETRcRt+GzgsM9e93z6+GRth+IOoNUOAtwNC3J957tuUiFit5g2MhYPQ+LP?=
 =?us-ascii?Q?Hj2o8u9qIrNf4JgdEvqciDCgugX+5zuc3+RfbSBXcYlbk2fF8Wb3io6r9If7?=
 =?us-ascii?Q?MRroBy4RfqMCp3kcg4yOOW1IWh56MDCbHPpANj47/7wb3OxyuEYKvoRw2Qcs?=
 =?us-ascii?Q?XwY3wja99/XmnvL2K9/2ITPfKWAfDXJvxBE/dYY7MzDdybHoQwWee30EyceZ?=
 =?us-ascii?Q?+XJ74BLH3Qv0YU4nQDZkKqI8q/fVxRuaxy+duETgDRlA4SZex9ZEXfbE02Rw?=
 =?us-ascii?Q?23PuOfR+C1pzghN4wOVCIXx2d9/B4XR8Sfp6goLBOkUhm53kcEM9YaU3raHi?=
 =?us-ascii?Q?EV7S6b/yKou7BrfYA6iQfL5D/EU/bZ1FTIXjv7Se5wfRuwxUsLcthq9wm50q?=
 =?us-ascii?Q?mounc8eIC6xXkEqUeGOlZTw60qF0qWQT8XWh+Z+IfqOXEPJ8GGsyExCXP8ut?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6ae19a-35f2-4648-29f0-08da9a2782c7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 10:12:52.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdPehHO3nLKmsi4JP0h5aOiKRNBc3Lstvk6CCT21rEGMg4Wl5nyjiV1wKI0dlcqspdHE3i88tgWZ0/Mxl0JEoCHr8mpVqgf1WjrE7Q8vapE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190068
X-Proofpoint-ORIG-GUID: vRouj5ZJdc2rwvG_Xive7ja5oHWI61kf
X-Proofpoint-GUID: vRouj5ZJdc2rwvG_Xive7ja5oHWI61kf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:29:36PM +0200, Nam Cao wrote:
> The function device_rx_srv does not handle allocation failure very well.
> Currently, it performs these steps:
>         - Unmap DMA buffer and hand over the buffer to mac80211

Does the unmapping happens in vnt_receive_frame();?

>         - Allocate and dma-map new buffer

Is the new buffer for the next frame?  So in your patch if we don't
have space for the next frame then we do not process the current frame?
(Rhetorical questions are a bad idea on development lists.  I genuinely
don't know the answers to these questions).

>         - If allocation fails, abort
> 
> The problem is that, it aborts while still marking the buffer as
> OWNED_BY_HOST. So when this function is called again in the future, it
> incorrectly perceives the same buffer as valid and dma-unmap and hand
> over this buffer to mac80211 again.

Where is it supposed to get marked as OWNED_BY_HOST?

> 
> Re-implement this function to do things in a different order:
>         - Allocate and dma-map new buffer
>         - If allocation fails, abort and give up the ownership of the
>           buffer (so that the device can re-use this buffer)
>         - If allocation does not fail: unmap dma buffer and hand over
>           the buffer to mac80211
> 
> Thus, when the driver cannot allocate new buffer, it simply discards the
> received data and re-use the current buffer.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  drivers/staging/vt6655/device_main.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index ca6c4266f010..8ae4ecca2ee3 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -826,6 +826,7 @@ static void device_free_td1_ring(struct vnt_private *priv)
>  static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
>  {
>  	struct vnt_rx_desc *rd;
> +	struct vnt_rd_info new_info;
>  	int works = 0;
>  
>  	for (rd = priv->pCurrRD[idx];
> @@ -837,16 +838,18 @@ static int device_rx_srv(struct vnt_private *priv, unsigned int idx)
>  		if (!rd->rd_info->skb)
>  			break;
>  
> -		vnt_receive_frame(priv, rd);
> -
> -		if (!device_alloc_rx_buf(priv, rd->rd_info)) {
> +		if (!device_alloc_rx_buf(priv, &new_info)) {
>  			dev_err(&priv->pcid->dev,
>  				"can not allocate rx buf\n");
> +			rd->rd0.owner = OWNED_BY_NIC;
>  			break;
> -		} else {
> -			device_init_rx_desc(priv, rd);
>  		}
>  
> +		vnt_receive_frame(priv, rd);
> +
> +		memcpy(rd->rd_info, &new_info, sizeof(new_info));
> +		device_init_rx_desc(priv, rd);
> +
>  		rd->rd0.owner = OWNED_BY_NIC;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The device_init_rx_desc() function sets it to OWNED_BY_NIC so this line
can be deleted.

regards,
dan carpenter

