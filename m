Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFABF6059A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJTIXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJTIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:23:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE1183DB6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:23:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K5pDRp017748;
        Thu, 20 Oct 2022 08:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Clfj87675GHdX4Rj6pHC1Kc3scNEvSoiZL9LOWBWvEs=;
 b=KzqjY7aN76EFNvEnVqk9a+JILx2ZdqRh21Bk+yHWNtn0be9VAmwpiDu4NGfqPjwxXgBQ
 0bl+hQw5lZzwAO9BxILkwtebfwCTcgyu+faNj2L05h+EymKcJoVTaUkENvCLqZHHd9IS
 nXM97YFGoiArq8w1W85WKsyaM5EnuIF1msvEtL/Ouy2xb+0oDPfx28vEtGiQXbP4mqt7
 3lBJIXHOBiHwYM2pF6+1o6+8a75tDUD0KmaqW/NuQLU2xmU+5nEf7maoCbnMuumIyyAC
 LHpwit14/M6js2kJLCcp6iimgCHtIbhHMBVHReL4zuMtoNoPbbZhyExEJh6jd9aTlaZd hg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtn0ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 08:22:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29K4pY0P003893;
        Thu, 20 Oct 2022 08:22:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0srk8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 08:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOOjnl5nQD9APnKw+YzCkEzPPxL33LTjiaAjBvBME7A8DCy6MAT+0jtQWSTCYhBgJ5qK9bEmRhphA0AMysvOD6Is1NE2p6Q/tEHxSF06etElFR4zUU4PN82ay3SX5kvYryZUieGNUwjPrXhvDHbEunA3RutoyMl7bvTMpDQj79WQZASJHIhJIEgCXZFTwcH0UiR74Y7bGQhcUIg/nj/0HSycbaxQ2h+FF8gOlfMek4moBV6lViTYa3pgWg+8bmu3UlG11ZwkHD4Tb8Ih9fG0Fb3IRgVHgDzyXXPxxIzVNofAJgv11b09mHUcv1EvM1Zyft+0Vps4wlQyirwRuhSGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Clfj87675GHdX4Rj6pHC1Kc3scNEvSoiZL9LOWBWvEs=;
 b=EmhJJIBqSfzCKzjA5f4W3Ocrzyuzro1nkSRb5wQRssLcWCXtQWSHj3py9PSkdsz2TB1bHiK0NOZbynLwkv9HUdQVGgdoh7YjjhO8785kbJPLAd+SlKfQLcF6+cRR3ZzyCcWa1siPfRhDtmJwHNnqH2Fw59/lxvXSK/DkfEZ+umrHbuhaWlcRM/7Sk9x2eXWye/36gWu3IRUgVePmEIfANcWVlRTanGIyzK8Om5dt3D8o7/GlE5cUvcfvr8WWFZe/Wjegs62EQBzDzS0s9ODCEfkgULcV2DQefeDVnu0prEyyu9QB5UYThsAc+JsIKm/+xohfTSGiP+aw3eDPnhyQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clfj87675GHdX4Rj6pHC1Kc3scNEvSoiZL9LOWBWvEs=;
 b=heTCzWt+uXG+b33hIW2VJtZh6B6k3JmKw5kdtOtJIyjOP++LxpFeTaaHibjfmSGAns273ITi8zgugzwv/+5SSviBMDc53UdCQnXaA/UbQYPZMnNTIMhiMpdKave9fBYSM6EgD+pROT9yTkAtm331oVzjs82KG/EOt2xf3v760gQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN0PR10MB5934.namprd10.prod.outlook.com
 (2603:10b6:208:3ce::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 08:22:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Thu, 20 Oct 2022
 08:22:29 +0000
Date:   Thu, 20 Oct 2022 11:22:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: Re: [PATCH v3 05/10] staging: r8188eu: correct misspelled words in
 comments
Message-ID: <Y1EFMt6fjLdRirnA@kadam>
References: <cover.1666249715.git.drv@mailo.com>
 <3235c0f681d817f7f89dd80537f36e1f9686fa24.1666249716.git.drv@mailo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3235c0f681d817f7f89dd80537f36e1f9686fa24.1666249716.git.drv@mailo.com>
X-ClientProxiedBy: JNXP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MN0PR10MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: e125a5a1-2aa4-46bd-b61e-08dab27439aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zh/Ym6Q+o1Op8VCbghsWNC16p1bEZ9aR3mwenLIGsdmM6XzOXFKn7IyESZXjFXdW80p75ARgtqI7RJoM5AkYFpxzb3QP5tDC2ZNDQTDhesjqVFQFwwl0hSFSOjQ0Ik2R/9z2YepjnzCsfj0UFMM2UQ6jmUif7YHnZJFGFrIxfgdVTkKylERyJMg5hAdSSOKgA/sgbV26r3V/vRr2r/miOB9w02amLE46HixLJTf76y1rw0XRH9UBnIxnUSUjj+bZjpuaqCR3nJIB6xO3oTy8wLrTxJOmx6cfJmk/dQGaa7xt+rg76hgVaQ6vSZHdAfg0bKKTWPqZzkP3b7fNytvp/az/gsPrejsMgFu1bsyR8xiHG9DS4WxiHSzHM5B/RH2e8M6Qwpy2TGOsMc69m5iWee4QJqHW2+wVmfLZr9Kk/tDRxFk/ZpA7bsG1hncbkDRONsjHIGqCmBi2nXfpVo1O3dxXfyfNFwlIliAmSr5KlEk+/CnFJmI9wVv3jaq85jI4+8p5/Sim6KZ/grTlYXv65/hX9G02Cnv6vXRot6jrlVpW8OaC5nIE8vKgHr2I7KaG7418jaN7KQrs1nvjWP2g/msQgnfGHePGdPiaxHrzh2KslzTj/TXCNkYX+pcROZS5Eab9lFRzFN2LRza/2E0nFVs4++8G6MTZXUwrBZX/qDzh5qzjXoRJkGvY+EUsnnReHMaoq7pNNyG5e8PWI7UyZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(2906002)(44832011)(4744005)(4326008)(66476007)(7416002)(41300700001)(5660300002)(33716001)(38100700002)(8936002)(66556008)(8676002)(26005)(9686003)(6506007)(6512007)(186003)(6486002)(478600001)(6916009)(6666004)(66946007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?etxcMbKNmdkaur+Ncl7fuasLDOCGtG1b5hYk7ixjMz9zRxBpi5nxrBHq5gbM?=
 =?us-ascii?Q?7D5+cujNe+/baxqPd1zb+9aQie92UFfG4GQyWMJnE+IYyK5vW5WRt1Tiqk9L?=
 =?us-ascii?Q?dbk+eNJreJ9sNWSgwrKtK7NyCilKyUsHsVoz+qa8zIji3uXlVp6fR5kNu7NQ?=
 =?us-ascii?Q?o/YWQLE0paHppvwE8i4J0qQN93l8YObR9135Pfj8SS2agyl2lv5fbyHaPpIT?=
 =?us-ascii?Q?Rkc8BPFEGWT39BQCsIq5l5dox9+9b6fV3tIfjZixLUnoj3hARqj/zy5FO16u?=
 =?us-ascii?Q?m+pvYjw0k+YKI04X7vqZj/OyCjyg0W7rEZvGEvODXg3OkM0maUnLa4Jwy4qY?=
 =?us-ascii?Q?zychTqS1RsqbdUIYvibLOg6yDdMTLQTvJ843ccryCW+2TIklG1zZzpSunF2F?=
 =?us-ascii?Q?esd0ZyJVrJJLrkHnEPfHDkPYN/14rVc8OrGMNDt8Lo7lECIKe3aKnfR4oPPs?=
 =?us-ascii?Q?QojNayx/dGugA6abOdBxLPO+LLxLWJ+jcESa50DMDU6Hz8K331DCh18rAPBO?=
 =?us-ascii?Q?W5EX5tNLIKFTu2gVjwc/svDFeSlJT8iJTiAEGAazqN1of40MVZoA5o67Cyhu?=
 =?us-ascii?Q?TARFj0x6vEINuGjXRd2ZXT9G9B3uNpoz4auUJlTcb4yGy6njjFG4UcWqBns6?=
 =?us-ascii?Q?DoExYxhXnig2Cj4ljadKFdJunidLkWFp/6TbAoVqNMiEybKUs34ngHU3YJVd?=
 =?us-ascii?Q?Pcto2T73Fx7na3X/F+u6Ox0FW0d8D0gz/ma6/c/v3FXxzu5iDj+KUh9HyJ9+?=
 =?us-ascii?Q?Ac96wEEzZW977cboEb3K9kAx/BdVsZSz0f2wzOVDracc6C6UeR4uxTcmHKWe?=
 =?us-ascii?Q?gZRZ+NETCnE8pcEt/WTZIttWwmA8o1kHtL2PX+Zh67IlyufPIt3TP7xstHQG?=
 =?us-ascii?Q?C3fQTmsnbAp+6h0V2nLAbkzjJ29iDVzCotq0PaIabOpqVnHOIoQVNiq1z7xG?=
 =?us-ascii?Q?OpRmgHsuASkqbhJozxUBeonTH081WdYDJ7SCcAqGM4q03WE5w3X31JHDTKSc?=
 =?us-ascii?Q?KJVT8CvsF72owgwx2yJpIksS5YPBG019Obu3uRtTq3CxotZ57tXgQokVF5Qn?=
 =?us-ascii?Q?n/BwuAC/B3I+YVj7ao2ZO42VH7fDpRBUdKigf6fHUWU/MuFia6c58r0kNajx?=
 =?us-ascii?Q?cZZ8bTVckpYaP/lIqcpKFXlCIfunXAZDvx1z5idy/eygmxoZRt9A4zwQD+bE?=
 =?us-ascii?Q?dW6/TtIftuJbuB0PY3YroRm3DF89m6SBBS3sXJ+LNJ+DEtqUMebt7P4x8vP0?=
 =?us-ascii?Q?lM8aGweeQ5w5o2PjtJ6MrzEi2SbHgp3uBCiptw5/MHOuxdy2TIXcgtW/uUG+?=
 =?us-ascii?Q?A8lLoFW+4roHXT1VtJ/qpNYHClR/O7XYkhsnYOkGfRyXbBv1PIq+wFteaobN?=
 =?us-ascii?Q?aqAeiBF4v4g6KQ5AifPdNXIXKSgaZzY9lKJF/Kdw0ReYXpQ/YRgJXbs/OfuE?=
 =?us-ascii?Q?X8xsnX56iJKymyVUxvfytLSWIts7p+3cJiwJXMcY12L+z7HJ+JMba1oJS1cf?=
 =?us-ascii?Q?ZNjSyAgOoEujjfAl9NvxQSIlaHEkdJ24aOfKzt6jsGivrPRUpugJAmNpdkFw?=
 =?us-ascii?Q?naV3Yvr9MIaH230nBOnAcDKEjkxuQFsja6JdctBh0wfk3Ez2l8U3+FMlJ/5p?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e125a5a1-2aa4-46bd-b61e-08dab27439aa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 08:22:29.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwBhQEBRg5rpj6pTnp040fBy+Ta77+GeGpaY92qaUPescwi9d3FU+hHVf70LYipS7Kg5AFj6HjeBCe2cLMRmZcYX4RV7S19YurXR+FQKYx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5934
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_02,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200048
X-Proofpoint-ORIG-GUID: UH9umQ1zz44VZ0oycO35wQ0XuKhL6SL1
X-Proofpoint-GUID: UH9umQ1zz44VZ0oycO35wQ0XuKhL6SL1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:25:16PM +0530, Deepak R Varma wrote:
> diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> index 55e6b0f41dc3..1de808832ed8 100644
> --- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> +++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
> @@ -287,7 +287,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
> 
>  		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
>  			if (check_fwstate(pmlmepriv, _FW_LINKED))
> -				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have chked whether  issue dis-assoc_cmd or not */
> +				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have cheked whether  issue dis-assoc_cmd or not */


s/cheked/checked/

>  	       }
> 
>  		*pold_state = networktype;

regards,
dan carpenter
