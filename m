Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0390F68FBA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBHXxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBHXxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:53:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9291E5D6;
        Wed,  8 Feb 2023 15:52:59 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318Kx7u0002750;
        Wed, 8 Feb 2023 23:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mEhx3Sk9N8F28Q1BAHdLAFHCn6tCG5Wthybv5WxExp0=;
 b=BGjxO18f5lve39rfJa9umWf2XEvLlTYCcfN/+vAaA7P2bWRb9m1EPI4++Wkwg9b4xPR8
 /le0pG9YqygdlSSuJhlIG5YVZKzM/UOAHjfN4amwCva/osjdTg6PVlZtPR8TUK/futKY
 cbP6jEzrsO3OXvCQlZdn0jBNaHuGfaDRoCNhlIhhNrf9dFlgRxAEpK358Du7cTkz4u6F
 wTdk9eyn4u6MhZv2N19fYL3xhi8QAfm7UktmLi59nkBaPuDC2mj6apdm7YxRVQ6863ZM
 UXwAO1NqEXNlpkwS1KvEwm0bfFdCM4uiYgWd9aD4hv3Mi1U3gMUh1VFagiXXcZEYEVLn +Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy19ntj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:52:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318NQIXQ028419;
        Wed, 8 Feb 2023 23:52:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtegagt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 23:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFq1Nmg20zd4GW4ChLt+4fV0QdSxkbqHGsOCyaVpT+lH128DhIz6HX7qONVVwaySsxFr5M4ciIvI5ubtrlmF4T/Jiyqz8ezh70txMzkTEDo1Tar9ggG+fnlngs2Cr7V2eTHX+WwnGj1zIru16wklBSxHsP9X6FFAKduO6hz5ZVC4aFOmw0YAssXjJN+bwnkRHGXT6RXJMGxbsAnWWZ+jeXsW5VSbjNJhsZnQLCgEj25KQu9rZLNWgMCi920ucyUyimzvnV0eOiMDhjQ+SDZGkv4kzoOTbjd0/j4N3Y53oRji2mDTqYzgFWMgejzlRXjpJJEUp9BgeEcfPA6ePfRuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEhx3Sk9N8F28Q1BAHdLAFHCn6tCG5Wthybv5WxExp0=;
 b=hoIYJCseE0T401zzl97VGTv8cBqG60zBFtpq2VIypay/vmSR338XAtqMCWmHjgkgKop+stVDHVErhOmsd2MpTOif16W7ENzcwtpMxKXj9EBwo2Prfirc5RCp6/7Wl1GwR+Lo8mulbEDO2n+GDImrYsjlRvhxkrqVCyDdOkVkdQTkggFpbWNX+vH1/dTRj0w8OaBnnN3tN/Ndc/mEmx9OFnmaueWXUthM926YS6qthRGrVPZe3WNIsmBGmpsvf49nxShmy+Vwagzuj45tfAg44pF4+B+DXiQ6pcs4UmosMTJPz2UpOHfAxmRg4onwK+i/jZXob73CJ14NwwoIE4OaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEhx3Sk9N8F28Q1BAHdLAFHCn6tCG5Wthybv5WxExp0=;
 b=S4JQ31RhlzsBeBx9iXzacF2GSs26bqywpEmWTU4g2PZPB3mJq5gUbkQkfc8jZlK9wOhmePE2vWyfYElFlgAmqYEpvWhbS2OswCthLBZ/m8/L1Ucrl+CkJMdvUOTNHMXAn6D4tx0vJtn0PYwtf9KsgxjdNaDktLK7fFKI/fInmXk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 23:52:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Wed, 8 Feb 2023
 23:52:44 +0000
To:     Anjana Hari <quic_ahari@quicinc.com>
Cc:     <agross@kernel.org>, <andersson@kernel.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <alim.akhtar@samsung.com>,
        <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <konrad.dybcio@linaro.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_narepall@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_rampraka@quicinc.com>
Subject: Re: [PATCH v5 0/1] scsi: ufs: Add hibernation callbacks
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg9nyatk.fsf@ca-mkp.ca.oracle.com>
References: <20230202161045.3956-1-quic_ahari@quicinc.com>
Date:   Wed, 08 Feb 2023 18:52:42 -0500
In-Reply-To: <20230202161045.3956-1-quic_ahari@quicinc.com> (Anjana Hari's
        message of "Thu, 2 Feb 2023 21:40:44 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:806:24::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f5ef75-4507-43d5-0cbc-08db0a2f9270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etFIladvJ4PRUfsrrxTEsxPXws9WwzgcBWE2e1qOyL8wQvlogbW5Op6EnjrrJAZebZ4XqVhMAinB/60ocNjOSK/VdNvqcQBBqrSiXnCRwhr4XQtbGJTyOoror/ZaisObpLnNWSgIsgGaRKpwgwCYqq5LzuU5pI3zxuBf2u+IYtv1/Ztj/CLvli7MXWXjGZvL+negR/R1X3rzoRnNwrJ8o60wmhnTmqHkmJqxtsyimhmxftSjnRmYY9OFkIArmv4URGHE5sqX+ezoiaQOo3iCnoLGdp2H7vFwXsz9/7ve1T/Hr6KwCxDhfmEG2jPa2cDvql9oVlFxySkHs/JoQSQsXq8OkQ9+cdjff+yi5wY4whws/Ztdd1XSFwokQoErLMLJOmkapt+VZMMj5FfjZms8N/qY49w2H/6ikPDnh4FCA3sZYbwPryRUXx9i8uPcKLYCzM55+S6+siX7UsHal7r9R/HgNjIq1HAN1Okbg9/Vu2XY9H5sAvWj0EzX56mkzQuA/ZhLcVzmbaFbE2fuoLfDIUwHnuY/mKiJGRF5J+Ulayo04XqwYgCA304iw0HlI39IpDR/GGYe/bV/uPOYd+b1zRcZJRkY0xNNbxdI5wyp0JZ/xaiO3IrPmNJtF/tbWzmr9U9AdEBHpVitRSvCoDT2SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199018)(66556008)(66946007)(54906003)(66476007)(83380400001)(316002)(6916009)(8676002)(8936002)(7416002)(5660300002)(41300700001)(4326008)(478600001)(6512007)(186003)(6506007)(26005)(36916002)(6486002)(558084003)(86362001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?onNmzwhEqNZAS1srvyium76Hj54SIhXOGbCEaIDpsG+0Q7NMlZ+a2HfWzUsO?=
 =?us-ascii?Q?TeoRk0gNBS1wWSTzmBYH0Am+2Zp1W9RCIBQv177ITMHjD/Dns/27DfXpdF39?=
 =?us-ascii?Q?EqaNvVOXPMrrsWQjhkjD+HpX1qGDEjKsQtwCAGfyYfSBP0qjBvEuKGUyMthe?=
 =?us-ascii?Q?3nTBMxjHFE0rYFS28WzHSm9fLSAJdXGpBFtHAz4dcwtI5oawSKC5McEd2iny?=
 =?us-ascii?Q?w9IpwaEE20b0by/G+ZRD+kMdIPwolgdRfBguxb0H41vy0gppcXLgEvbVIPLs?=
 =?us-ascii?Q?XBrhWuPA64si0/5gXILMdeXW4JKRRAgpweHkBrkkf6mvw8cX9Gl0Iof7FArj?=
 =?us-ascii?Q?PMKtEYPkzwH5WuLXkqWYi9d5ltklgiTocLYJNVP0wCnkrxJUnK49Rcb250Hd?=
 =?us-ascii?Q?LnYpA0dSlJbXZk60JObzCo03BxJdgO2E9d6TxhV3UfuvJ5QZDROKz9gb9x8I?=
 =?us-ascii?Q?BVpBfv+4s07TcM5wDH4r51tJWzhYOSJJT2IowhxqaA9+cAjb5ojX5/h4Cq7I?=
 =?us-ascii?Q?sJYXxyL3kO72EoDj7852yaQAkKqEvw6aL5kbaOE4H/h7MoIbmNELtGES8EfI?=
 =?us-ascii?Q?ECqS5bK2R8hNLSF3Jrapmz7QYAYnnI8dtO8zVoj/mOxHMKeruZb/GnsAjdl5?=
 =?us-ascii?Q?Bacav/koaiSs2kamhoYMO6vV3YG7BHudoHDtovGEDFHw986bTrHT3wjv2fiP?=
 =?us-ascii?Q?HbnUmmv8vLiedCb7NuJrhOu+hA9h6GBCeU/Cb0W6ShaMZrMwLKKQ6G8L06zn?=
 =?us-ascii?Q?PBpsrDa630evi94S1Bvy8xzL8TzSI8GTVJB/P/WQXpAJE4pGM/7xN8fsCnRq?=
 =?us-ascii?Q?8hSgonSOy4VYGwfQhOcy+bYcwqwOaSr893GtZpgZaPA9h9GVxrKn6VSJtIxp?=
 =?us-ascii?Q?YqWFs3jG9NQMUqOKTEdMynh165sRgbK5bgKM17zx9yBBmrAl6m38kWo6Q/6J?=
 =?us-ascii?Q?xCu7Z7oLiBfNNHOhZDCB0X3jbh/plXxtojK+sSUtjb4eq706H8Mtfm0Lc26q?=
 =?us-ascii?Q?tcZp2XsOfaLIxnDlWYmzSKeFVvxrVKtFXdGqn/PUTbvS4VwTH3aflXl7iiLA?=
 =?us-ascii?Q?mbjbTIhYhA4z/B7JR94LFH23kRO9zfS3JM9VCHVNxZreV0G0Ymy0pz5JUuOG?=
 =?us-ascii?Q?IBU1I7cIgy73b6sNPWUlKuOeok1zbjz0WUUrqs80BNawznNCASrIS5GZgIdx?=
 =?us-ascii?Q?vScqgjlkUVUo5HmWUw0A37pTazjU87WcbXJ+0kONrA/n4KNYxqri1idXF31B?=
 =?us-ascii?Q?M06ZASMpLzbVUVM+JBGGLUKPzMEHVr+I10PgH6Jc5mNLwso5lxFyb3oFjiGR?=
 =?us-ascii?Q?6rr9cwFa6CGiH9Jtw4SsGxC7nrcdMSwXCR7XfR280UslrC6n275TvnZqYZDF?=
 =?us-ascii?Q?8Ix90phYn5VHONZU6Fa//LT/CnCsvLPcq1Mm4ZV360WOyr2m2OJKi3JBvtqq?=
 =?us-ascii?Q?etAjrfopGt97UgKiqXdN9ttfsqWhDapZcm3sU+8uuObq2Ev1EJRaTNWnzyrl?=
 =?us-ascii?Q?+aaXEqtaEsCzY/P6JPRZJg4GJU8dUd7mHLfaWqb00I0Az77LgJUkUnvisOZ+?=
 =?us-ascii?Q?jQN5VuHYdtKAybC4XJN551ojZTSG/d7EUe61SLuAjL8WWqSVfehq8hiEt9FT?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?A325+hbe+0aunmw/q54limmGPSSAmtAqTkB3oqylTVHkHxaLu/4IyBhpxPbV?=
 =?us-ascii?Q?QPg90kyklNB2hX6YfT0DHJUAmPIoha8M7QExUSxuI03WFBC4pqQNCwnVhaG6?=
 =?us-ascii?Q?dZvbhQBnDU1qkikZjGROD/PRAkeKdd5RFHZOAEs5RQOdaVjS6JzRuhoNZY/y?=
 =?us-ascii?Q?KutLfqAypmvjdRRAFQIVHGbJ6XHXb4e6j0kK7IzhRfJLrrsaNK6UNChgrotc?=
 =?us-ascii?Q?l+TvIOsZtJxiCdRm4JjfRtATUtTYUfGjNkm0GNeIsh1ilwz009OYRPNp+qyL?=
 =?us-ascii?Q?N7UAZT3F6K5Z9Prh18oVoFciUAFV7WP4xQp3VC1FkoxGU4tnrCR3lECnOwdV?=
 =?us-ascii?Q?XisqFcNk9iv+dKgML7Nip0aUig6Dosay4kT1ZzresijTpDVuHWkYTRNoORgH?=
 =?us-ascii?Q?wkFXEo226TcHJSXD0ZoPDXbEUuZoJj5he4SA9rdciXupdCW5FY4t7m2kCmGU?=
 =?us-ascii?Q?sIP/DV7oxnRzWW0brd65KRSJjvop6y+/qP7Jn0iliUc6j2GSO2B4sAfkMlwl?=
 =?us-ascii?Q?4DcnlxeD3wxb68ZOjr3wJImBQHnquPi3j6cmkvGNrlvOiYj2b+R+M/zyoEGL?=
 =?us-ascii?Q?88bZdzC7QtmXFfRNvRoKBsODapDcbWHZubHzWWc2yEW/ubX16LBnfee38n0O?=
 =?us-ascii?Q?c5+KYRgmGDfg9vtlTfIDiifpH30fRKhD7sJJFOFn/3kUaWtewR/5Aoy2C5Dl?=
 =?us-ascii?Q?JDHoiXpkRr4oz3sixJMfLADQO/BykTbLYLNhbJP6g9fy9pfQgcABhOE4zglD?=
 =?us-ascii?Q?vdkbrKye6AWwvTC2asd/W5RoE0lWeJAWzhUVyErLdfxmhFT6/KpxcpXI+jN5?=
 =?us-ascii?Q?UjjrbFv0SVp1HTY/g6EWgJR5VcZHJNqY0KCncounhdAxKabpHrmAtWiYs465?=
 =?us-ascii?Q?rbClXaQRgJUNuVwcAWWtQe5Tsh3WGu+TtM7/nZrQKoHNCnsce3g4SFr4gbOX?=
 =?us-ascii?Q?46Tn7oDmZzYQRjvrw68odg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f5ef75-4507-43d5-0cbc-08db0a2f9270
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 23:52:44.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pfntq6xhbLF18bjfpYXalbFkinmL/OGHjvi7De/1vbJSxGOOuUFzNhYqzFVwoJIQ/rVk38LI7jFvxZoo00UNBx6RbEim/qjtpGrfem3GejY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=729 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080201
X-Proofpoint-GUID: 4E6-GXqS_ZW4uTqbovK0shI9qZTCPnOq
X-Proofpoint-ORIG-GUID: 4E6-GXqS_ZW4uTqbovK0shI9qZTCPnOq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Anjana,

> - Adds hibernation callbacks - freeze, restore and thaw, required for
> suspend to disk feature.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
