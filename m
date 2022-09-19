Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC015BD84B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiISXc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiISXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:32:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D574E867
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:32:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMi2BT020007;
        Mon, 19 Sep 2022 23:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XWg2sY2rBAL6GT/P1avHCKpLcnoNmPgrq4VmX5nf1v4=;
 b=K0lRPfmJN3JkBsO53iSY+sme/8ndi376XUzGX/IReK47j7WhxoIyoeMJVzwJGby44yD7
 nn6pLnHzI2e0FBgkomMJ7dk+1GT0B59zJxwQJdoJMO+NdbpQCrIYZIQ1XAV61p9jJFTh
 di00ryq+++ix3oqA+3D1e9lFvYaxrG4rG7nrbo/dxXbgjznMN6NKrDfim8gVnCqq4/T1
 95K1yo3V0IPIaF//6+MnFdx7fKs20NpnwlCn46tSy2Dsw3iloNmjQz0Joz5fNPZ+2Ics
 pmt6PlVuje04S5lbkMceOMmuuKXDqLsi/raEzEFrXupIF2sLC9aLNSfZ8xPrHtY06viv Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m58r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 23:32:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMwO5v009178;
        Mon, 19 Sep 2022 23:32:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3c8cp0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 23:32:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Znjj/L3UZn6CaEHBoifmZ4lKhXNYJS3K/rrkohJ8dvEojKU30sfGR/5hg9Kad1MaDuMwShQbojWm9R5YrE6bZnwg0jpE4UJQJATK64OBfg9fTeEsPnpnKA3nAbEKwgXf41rd0t9u8hc7YEcucSu4fDPRVHWn6KccAVv+qWXepSxbV+XxQjiVH5xRBaZXqDl8cKAOZ7+cFPW5kXFNfBozw1fOF8v3QvvjFB7u2hZmpBek8u61IAk7G3dEC1lpSROpesT5CgKQ/vgGHzF7+zU86a74WhqdJoINNpxDRRU3GGYg3LVz0ot17ROnSfOuGLVlevLwonJ/WZI/0JjTb0VMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWg2sY2rBAL6GT/P1avHCKpLcnoNmPgrq4VmX5nf1v4=;
 b=R0wHYjmjoB5RMspNKpNHsmrKQ/SHp4LvX+8RWEZXNi5GxPmhPX+zFuUEvEx0wNNdnpLSkJSXoCHzZRJht6SrcbPONcVVgF+OKUdk9/9oPI8dfj0601yWJYiZ6DWhonKVPz02n0NtKSeL53oGf3wxUPIW9yd6e25A9OVOfu0M3Rdm+8FArM3X2o3xbAvXvLl+pnesPcyadNNdlOIaAFdjXY8NDJbNbU7CFMJcb06F0r6MfS8ItqdRT2qVNT1Wu4z9ZlH1Hbv2oESWY27HwfDYJ3vYgftJ8PwUkPqEdpJ5AxFIEuDBM4VewcIiXf/UE3ee1IIh5YY36QezIh1JJRwuDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWg2sY2rBAL6GT/P1avHCKpLcnoNmPgrq4VmX5nf1v4=;
 b=Fy37PdfQq+Pe0BJjeIfSartSH0BZAHavMqiQ6J/y6zhxzCk3CTveGs/Hd/A85CkBlx9HUxXsKNv89gj3RhkUzh89XL8toGlHKXfDauXIAUkDl/HJOPmDF9AjHoXHkwQJSH8cpvYQOeqvNCRQqj3ek4Ole1OtTtWA4eho42vjotw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 23:32:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%7]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 23:32:24 +0000
Date:   Mon, 19 Sep 2022 16:32:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 9/9] hugetlb: clean up code checking for
 fault/truncation races
Message-ID: <Yyj8BdNjQiBMw66F@monkey>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
 <20220914221810.95771-10-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914221810.95771-10-mike.kravetz@oracle.com>
X-ClientProxiedBy: MW4PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:303:b4::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: 7916f8ef-a6a2-4cf0-33a1-08da9a9734e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/a06+xywir7FbBC8ozgoXpC2ENDpq7Ih5ycfCSw6dKxksLSWZww8ZVg7xOpQhcbsdB+rQdyJgib5LxzFOo1D2VtKsn094IReWd31ANozQ7wYUDw6SYBCAymrn9yGb9tGx9BA53DaZk94UbDAWYVx9plroBINqvSqgMq741XiKpvrByc1P9XST9fYp90nP31mwJrUuojTM6o8PEglKzrjlpDHoqhUjLUOqzBDAJWzjsaLPW4MTlq2Uexgo5+007rOab/83SHwV5Yjz8WSKTM/+GiUmroUvuW+XQSiUHilHxX7AYtpWIKAdwLW/CRg/d4oM/X/TdF7eDjY8RUzDl6mAyTah6YDYMjGU+up/FZYpEI1ssA2nQmSENZmxmWqmNrGvysvIkWV7IBmgoUWN6rF0/lDnKSTecGDk+pBskTS13RSQlICjknAhXAs+7YBZw3aenRb3TReAe/TgopIrIJL8Uj2BhwsXWHv2zPqH21f5RL61KaiBSGWNr/8+o7mr9jNmF368EOJ4yHIf4YJqFo+9yFXdOWzXbUkckHBINvSwSviZIDX/IGeGsp69s8VaErkg9iyjRTeAn7CmPOw1IX/XnJJv7aimA5Ibstdsk+jgUIBR/K5e/38GL8sMeqnBRoChGZAzGaxxZ/d7VdJvHFBxBhu8PmaRiZxL/4DoOkVYTwISvyLH/YJ2s/lGiNBB1jHF225zPYT3RHbYjee2TO4prn0dMR07DOYTVkD/sD7Jk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(26005)(6512007)(9686003)(33716001)(966005)(6486002)(478600001)(53546011)(41300700001)(38100700002)(6666004)(6506007)(186003)(86362001)(83380400001)(8936002)(66476007)(66556008)(2906002)(66946007)(5660300002)(316002)(8676002)(54906003)(7416002)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gm3aWBdsodTsPOP0yjrWzzqon95gVyWQKcvrDg6a4vsbEsttipMJQFgPpeUp?=
 =?us-ascii?Q?y8eW6ODVpABjUfhHOwDGGO0A8s/TTHHB/u8pSFE6f9tH3MUYwSIw7ij4xJW5?=
 =?us-ascii?Q?1NBdfhsb/oyXOwqqIgOuFOJTqvQJv09nzOdPNnMHT0rR06XBydGNfcvvNg3E?=
 =?us-ascii?Q?2MIeOhL3x/Ac9GeI/ZjT/zdBsHvKKjszWsOZHgKvgPMd68MeIR1RieC97NZn?=
 =?us-ascii?Q?RHZeARhiHjm2eM0UgcLOPuTQ+aDaXCQBj1VlxoO52nvnYpcsywJz009x+e1z?=
 =?us-ascii?Q?VJ4aZkEMIFV2QSkPTbUsvyaJsmbnRvLNUMYnNqLvMf3ldS5vKPDNQy+EEJLc?=
 =?us-ascii?Q?5OsmwXR2ah2C8vOobsgxBjYM+ff9QwdREzu3g+l8lYSHPbUxMhFL507Aw2Ul?=
 =?us-ascii?Q?QllBSaXw5AcVBIYYBPsQ7CR228sHe+htRjM2ejW3pN4EQmJapukemslQGd3F?=
 =?us-ascii?Q?cgM7kkGBnRBRif6/gP7aCwQT1w6mh+Zty1WjHztItNHsRzDQAzSgw6BDycq3?=
 =?us-ascii?Q?0T+qRJr944KGEP8cafVTXnJFhc5l2IBBTNUVf2HzMzCdXS2jyrudvFE5mHev?=
 =?us-ascii?Q?Ujr2jSeMk7mQ+ABXVNs0GYPLLYNUdrnatDCMSYXatMQ7vvCwoSxZeVc9iDXp?=
 =?us-ascii?Q?jQ/BP1GBbZXgqRaM+0ynKamzDXJuF8rfg/obzLrHrVFUth5PTnN6WFMsoFv4?=
 =?us-ascii?Q?lEAh4NWZZZsXbuFs9DL3SvoIgtjOqnRPcsa1c2NK31AQKh7Xkx2K+S4qgsj4?=
 =?us-ascii?Q?1O5624hp1gu86I5pshqspb7BhlyHgtdOIWfAiHiiITRn4aIVsN5tHsoga22Y?=
 =?us-ascii?Q?YVMeMbuIEpyVA2srGRqLJZYHYCiiiYKq0INwsSGo9//zVf5IY3sectrTj2Tf?=
 =?us-ascii?Q?ljiuHH0kQxZwCLGqIyUwFTUn2kJ3LXRznndjyKkrymHEJj+kldoPnrpdUZon?=
 =?us-ascii?Q?LOsF/A3q+Iwgz4kBVOE+xthuUCDYVW+haEpsBxwDHqwRlEmRKxPau36Jdgwa?=
 =?us-ascii?Q?Go9u1/FxCUzuTUvMGpFQz7km/NL6EYe5y9RML+BheOedCzfDWrDvgGMxNqpp?=
 =?us-ascii?Q?Tqci5GE25aYLWw7TqCVDEGG3zry5ofTccLPn6fDhAnamOykmWajKGon+fj0f?=
 =?us-ascii?Q?Cayh2cCDW/xbBH0bbU5wQtj2rtrwJV5B3AqurO99EROnQ4PI944Du3y2vsyl?=
 =?us-ascii?Q?nAT+AjuFoNKj6QIKEVhtmhz4McmdQraLqaUNIEZAg+e5BrGiY1AmzPE/Fe71?=
 =?us-ascii?Q?cEc2XtX1WTD8EZPMe8u7og1xFUoQ7h6yIJEcai4eYeSCgtRSczxAsUBVKKHy?=
 =?us-ascii?Q?ZjlBQXOsmU8yEL0t8NS7A/yVgAVo7nG0US7Zf1K6PObXhAgh8SgBDSgnNUni?=
 =?us-ascii?Q?/CSbAc2H9+IusN3ICLH+nZFYi1MfHuH5r8MvnGEEpx3ySh9NUaj37rU1j9TG?=
 =?us-ascii?Q?/8I4MAQe8ceTMT8Ba7B+5Hs/767CN0gCLvLrV6GpDaB5VIjxt82O4VANCaoe?=
 =?us-ascii?Q?AX0U+5Ax1+d8rXO08r7ljH0tZbutoiliUoY/aUwRlIChjByRYcOLTevNH0/M?=
 =?us-ascii?Q?oI04iRLETmvZDr/6aEDjO9PS35m8ESM6DvsZ/csndcQpGpR27gy3j10aa6xY?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7916f8ef-a6a2-4cf0-33a1-08da9a9734e5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 23:32:24.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQSkosOp97sjC/e9ueQGFo126V4KerSCHA06VVGLHNenLelXHVCYFU57Ytn8n3laJWKuGiYXPLv2/JxxO+uWxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=944
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190156
X-Proofpoint-ORIG-GUID: 55CywNVnZBEIuCzlKNYW8NFSmq91Gkpl
X-Proofpoint-GUID: 55CywNVnZBEIuCzlKNYW8NFSmq91Gkpl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/22 15:18, Mike Kravetz wrote:
> With the new hugetlb vma lock in place, it can also be used to handle
> page fault races with file truncation.  The lock is taken at the
> beginning of the code fault path in read mode.  During truncation, it
> is taken in write mode for each vma which has the file mapped.  The
> file's size (i_size) is modified before taking the vma lock to unmap.
> 
> How are races handled?
> 
> The page fault code checks i_size early in processing after taking the
> vma lock.  If the fault is beyond i_size, the fault is aborted.  If the
> fault is not beyond i_size the fault will continue and a new page will
> be added to the file.  It could be that truncation code modifies i_size
> after the check in fault code.  That is OK, as truncation code will soon
> remove the page.  The truncation code will wait until the fault is
> finished, as it must obtain the vma lock in write mode.
> 
> This patch cleans up/removes late checks in the fault paths that try to
> back out pages racing with truncation.  As noted above, we just let the
> truncation code remove the pages.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 31 ++++++++++++-------------------
>  mm/hugetlb.c         | 27 ++++++---------------------
>  2 files changed, 18 insertions(+), 40 deletions(-)

This patch introduced a compiler warning addressed here,

https://lore.kernel.org/linux-mm/Yyj7HsJWfHDoU24U@monkey/

-- 
Mike Kravetz
