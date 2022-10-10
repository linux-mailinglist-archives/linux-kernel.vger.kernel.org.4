Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CDC5F96A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 03:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJJBkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 21:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJBko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 21:40:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E64CA39;
        Sun,  9 Oct 2022 18:40:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 299MEY0c013661;
        Mon, 10 Oct 2022 01:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=dZxIlTPO2gYa7lkSds5eq0mtyuy5OSJg8rtbiD75/ts=;
 b=oOfdv0pOMxe/IJiIxXjD/e7iF2o11IsnA5C+vOngghLVBpoydgnX/O05V0y0gNOP6VNZ
 9NuKXwaZRndKqVVrUGxwMyUcqRp6TE/1obduigm/0PqLr+fcyzsZtlHvqYOUHYxS0MYb
 /wWpdAHrCI/CRQHXtv38WZDBXiIILLT781h8YT3cdtHYoRIBvFlgJUQzed89K5Xg8Gqk
 nrcP0HVW4ZEYFcI0LltMtUOTyNnRTg8lg6Nuk7tp7vV930UoYzcQq3fDn6LEdvlr9sc+
 cPfxShaEhDJ2+w0jZ13XoWHgtT2bSkmrPpSxm6jrmzqmxLlJZiuUT5N0flbZQCRAK8jl KQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3002t6ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 01:40:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 299Jn49Y000768;
        Mon, 10 Oct 2022 01:40:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn2q7tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 01:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irTak2pfQVLxulfhv7x2TwjXhxIqs25VhOu+SROLJcz/yp35YHjdcCSn0rKb0WcjrO5igS3SNW17RRBdM6DC1pTTpsysGosxJeeA8CB6yAXeoME2xZUTYmWVPwELX+ZkIaREMCUTMHXKW8CK5uNU+OVwZ6mCz9lu25Pk/4FTpAiFc0Cq6ThyjPUQaSZ/A3QLrOC+R+FEaUY8EMyigt1F+31JIWYTn1m4F4CbgPab9asgxxsfcu+M/89bqhhdoHhwhfFH/XEwAzPNefk3+CW45L5U5tiHacsZh6Zhybn4MZ+DZtMc6YQ8D2cOC2hUJCQuEbESSirRmDUVsNrbNqIQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZxIlTPO2gYa7lkSds5eq0mtyuy5OSJg8rtbiD75/ts=;
 b=gFiiuAq4CaN8QQPadfTZd3t/00iGKy+MGIQTU7uD2PgT7h5fiJ70/hgYtHnYBVeof/c0TKwzswRJ+oWZrdVXesJDFQnUt303izy5xSGGh/GR3a7jEDtCjlUPBkk+C2DbQ4g0OZD6xX/MH6IxLhFZcHX5Aax8/PcS1SaceH3lAF4roF/d91+JVh9M6UhJ6NmAxkJQJOsikVpgkxaFwMcbGBWlFyJ4XBjnkXnFiCGaPFM+x2W/3S0IigyroFbKHNSctwO3HMmA0rmqaYGMOFdD4Qao3FXYJLWsP6n6clSLcrYOiqpZuVNH5ernsYe8QlYlWNvrKHQMp5RZgwM4zP4fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZxIlTPO2gYa7lkSds5eq0mtyuy5OSJg8rtbiD75/ts=;
 b=n9LmdB2OvLXFjtq9WRlJlDUKzYD0nsdNSKeUzSxPnHxgC3uS6TcFwAPE3oADVk66GoifFokJMvtmDDkzLCL4afljNAKvkZzkc+R7Z6vBpWOVrBza9ym/rS2ZclTg3B+bEBDJNwW7SS+tiQzubFEMPGH+W7XPnx+ySMbj1YWLTHo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB5723.namprd10.prod.outlook.com (2603:10b6:510:127::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 01:40:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 01:40:19 +0000
Date:   Sun, 9 Oct 2022 18:40:15 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm-stable tree
Message-ID: <Y0N3/wtn3dR2h6TT@monkey>
References: <20221009193544.27055db5@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009193544.27055db5@canb.auug.org.au>
X-ClientProxiedBy: DM6PR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:5:337::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dceb669-261a-414c-6d70-08daaa606383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWzkIDTllEXXwDI5wlsazCjXPav6JNfA4WvAz2vXHuYJ4nM4sgz2w+UBFKAWdxHRgMQP7jPWz8CDP1R8OzN0CdmA/ubRRdPkaWavdsZ/guwXe5nx9k/r0tt8m2Egchenn6t1jjbBscHv3pqeADCIP/gi1tP+cjIexvHWMj55OsV/KTFOMnbfOJNU+KI7xU8RGWnSk0VV43j9tHbcUCeJHzS17GJemi8sDpT1bBng2Do1xg3w7MrbOPlzWWlt2jYc7ZigGYsp7yCbzTrfPRIqi4dtkDMltEGhiKrqPwEQnYyPC/KPoenx9vXp1s7z1nk0+nQnATzxABA5+eGR44JIDk7gpy/CK8JhvGCcdOGZiqJ9DH90TX9b2h409G9W8JgsctrS0ON3PErRU3CtOXKe8h5dhpxre52ahlT1R6M8IcLZaemYjSaLMGv+YbQnK0Pi1WUmVYrzhO2KTUvPQlpza8eGfYhbSLz+9sN00eC7MGRT1CR9H4K4QiOVKbR/1oH/KEDu5myKpWF6W8wmiXDrbUP+zylBU18emdSku+cy+ubmD5RNLjwU6Ne1o+rLQEXcXtrNVSJ57Z8z7tTkBN6ffhUwNxf4RWEiQJQNt0l5LcnzwmWChGeCK8FSpT7ZtSxqafmnsZEq3JmcfwhCsU5mhuus6rx8lgpVb2mGnbxM2Mkt98SxEKQMQN+/cCf7o+rKlcC3EfTBNbwsSZQjKmpVkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(8936002)(83380400001)(44832011)(4744005)(5660300002)(41300700001)(4326008)(2906002)(186003)(86362001)(66946007)(66556008)(8676002)(66476007)(316002)(6916009)(54906003)(6512007)(26005)(9686003)(53546011)(33716001)(6506007)(6666004)(478600001)(38100700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dRwZsrP3KZRQrMeeKGttWxLThlYF9natpcwTnkxPFakT6Q9Zr4ieqs0BKkoE?=
 =?us-ascii?Q?dAMn5rgu2fDvzSU55lDhu7PCyjvL71S6dT4fA4dyl/qfwwO7D1z7D0zpU8EE?=
 =?us-ascii?Q?CGKdw0sKB8s+Xj8gNcH8P7McgpyAJEu++M6YkJvYmU1DWS+ufa7WBjcJjY4A?=
 =?us-ascii?Q?mCGhI1FpsxM/YoCF75aOx7jZB/4vGGhZvipFaKeWYXi3BuhVMWN/U/ngGcOH?=
 =?us-ascii?Q?o21Eox8GBNeHKyUk2rV1PpfTxDtQYJdlH7ZzbREYwuEbygQEGBl1g9bXw3+a?=
 =?us-ascii?Q?RM2RnsW73jrcrG8ncsqAN1F3K5RfCTv6oj8SLS2H6iQCgIWs2gMxvo5WrlKk?=
 =?us-ascii?Q?E+qW5+GUiha+qb/eeXxTzdomxHEz66ShPjDY0zINAkC74+XWFr4I4zKbTP2u?=
 =?us-ascii?Q?irev93K0E+PsZkEAZixw6Mi+IynDtzBwGQSAb75VlAyK+NCLFkvgNlhATT1/?=
 =?us-ascii?Q?uwP/A9CA8+nbrPX3v/GVepXT1/85+Bll9GlvuS0CznCCeD7iXXT7LrkrgzHg?=
 =?us-ascii?Q?hbHmuk9KBHg2Y1AD9MfkyZCZhoyaTQ7o++HD0Lj0tkLH0nnq0OWBknfRWlCM?=
 =?us-ascii?Q?sR8c2UjgwvWFD7OM9OtZthpyG2RnOb/BJ9AMoo1Y0Ef+HWbe08WqwtKfd3Sr?=
 =?us-ascii?Q?gKYdGcDnqH8ESB1Yk1XpmMYZiX7QJp8nWIc130DJgfhwGCqec84qTCqtloHt?=
 =?us-ascii?Q?ZWKoBkJNFFqD/LcTIy3ZGHQB5yOprATC9MsiriJIS1BUtV/JJDgaeFWr6tMM?=
 =?us-ascii?Q?C1W7Z7L/rovIzN8dEe6vSJzAP7rdFaTWu/aWJtFULWn17g2A5k+iFGhsEv+N?=
 =?us-ascii?Q?JzeNWZaXqiLdL9k/FtTLE+S29/rHmwL8Ek0fuCPqNnbxcCwv9ncsxP5RbAqK?=
 =?us-ascii?Q?GH/n15yYqlzUnmpMC0Py8OwwCn4t5louOVR89/y7BgNqynFALsaNDDWriVHu?=
 =?us-ascii?Q?/Yd454qh2oIZXuRwswgQTUQVU8Qovy7J82AEsimy+TFFi+qxLwlXt+i9+h8s?=
 =?us-ascii?Q?Iwmfiki+3U70wEg2DuVhlwDt0FAC7Ef2kT3NHtpkTpXkVzDD/YVRskxR9BNA?=
 =?us-ascii?Q?kpfx8lZNu0/tCdplW9TSsut4VJ9nvrGa+6Ebd/8B8AA6y2jf0nd3VIzjWVag?=
 =?us-ascii?Q?19YVdSVVdvMYhIG308g6T8fQqvF6kL6v8sZ5muRHdhjlEdcf46jwb8ln4gta?=
 =?us-ascii?Q?oHwyndTSM8KX2YhOps4La1BK6CCxkF+aO54HxFJRQNla3AI0j3wE9s7Ly2wY?=
 =?us-ascii?Q?p62L/+oZIQtayAmhV0CUSUHSSbygMCq9CV1SObz9ScN+e4aHfGQyE8ULPDlN?=
 =?us-ascii?Q?ZTj4Tl0QKRT060M2AP43k4wGqFGDHQLv2OpdLcG2rfGgAUkZZ90A8+nqjRtB?=
 =?us-ascii?Q?wctKC0rx153swg24i50W3X79bZv/DIqZlw7SDCBVkse1MLfhwFDP4g/EH/h3?=
 =?us-ascii?Q?Y15yISCCBbQ1aF0xiBwrQNu2QUUtw8b6wFf1xCIpEVdO7DoJ9SKUJh3J16C4?=
 =?us-ascii?Q?Uvnj41HOWt5/rOrWVQLm4mCgQpGql2vjXxzLCVEX7xfCTlZP9Q5ghO24ld+T?=
 =?us-ascii?Q?UTzXw+h0+x9/t5a+1Twk7Ohp42y6IefQK4KoNtw/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dceb669-261a-414c-6d70-08daaa606383
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 01:40:19.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey+rIVwQuG1gXYFJcJS5jDqbmYGX/UKZZ/DhNR6fYKOsrzrvqCrrUs2mpofZqiPRuA67AMbu2Ag+zukj2YuxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100008
X-Proofpoint-ORIG-GUID: 9peh0EKhtxKnzUU7ozBM0pSR4cwv7ls2
X-Proofpoint-GUID: 9peh0EKhtxKnzUU7ozBM0pSR4cwv7ls2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/22 19:35, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")
> 
> Fixes tag
> 
>   Fixes: "hugetlb: clean up code checking for fault/truncation races"
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
> Maybe you meant
> 
> Fixes: fa27759af4a6 ("hugetlb: clean up code checking for fault/truncation races")

For all of these, I was under the impression that the SHA1 of commits in
Andrew's trees were not stable and could change.  That is why I purposely
did not try to add SHA1s to the tags.  Perhaps that is no longer the case
since Andrew is using git to manage patches?

I see that a pull request including these commits was already sent to
Linus.  Not sure where these are in the process, or if it may be too
late to update.  Let me know if there is anything I can do.
-- 
Mike Kravetz
