Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BAF6A2451
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBXWfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBXWfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:35:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486D1B2D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:35:51 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OHi3Kw028665;
        Fri, 24 Feb 2023 22:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=zJ3nB/d6NMQFAyrcvo6CFHpeHqfwuMu5eo3YvtFCWYk=;
 b=YVW+Zlum9KCx4xlV6y8uTbOIX//77wq32LeDrZWr6kdFV/ic1QA4HFCd2OfztgWe2WhV
 AICc9njuovGvvrgjLxHsV3C/SDCp97MgpW1ssnTqwHZldTZSo405ACLDDeCkEm6vCMd4
 CIuS+rudn6mwsp8Vnl5k8gmqaSUYIze6xC3/AggF1TR+rdvhmD8ZPbliX6t6Az9pr/rD
 zRZHcTxjrruYit9SBpOC+1X7iEBEkHI9dUGfWMXTFA2kVzMmQAU26hC/pAJsOkqsNdhG
 myx9aks/7OvdsMpqiq48cGb7jCCC/UKfYqADHZ6fJ1GTILTYAkYrpixa99y0/M8tQnnO OQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbx613-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 22:35:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OLieuw025988;
        Fri, 24 Feb 2023 22:35:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4a3915-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 22:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIPyYNz02hU4igY7jn7Aov4OCZymBaPJYhZfuWXhPHhE9qcsveDw26pAzs9ROAP1km/FZrWSGF0u2Jyvsz9KSFld/Fe8ku6y9J5Z8pnQB/NJ1EMwJ6qmPycQAnyHRd1M4UytCaXXRhWQM94nLzSIB2dety2UZTIkjFn/5cRZ08SSUdDD18EiDAwzCwAGjA4hBFz8J2A7AqOjKkIqPECnjFF2qIuhLlD+tzzfsSQ6AvnUFy2KQ3RwIfSMLen1LffQCeXTM7G3aMsIXyNckxMR5t3bSxW8RKTkTGC/bZjDynRM0Hkodw1COK++WclE7WWiiyxedaT46K2Xi48cEeCOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJ3nB/d6NMQFAyrcvo6CFHpeHqfwuMu5eo3YvtFCWYk=;
 b=Ur3/qPdL5Av6H0Qfa/w5/XJASfsl6UAK3JNeiwY/HduCVcI66JRkcCar6aVbPSqEgp2CDJbYDJVdT7TkaJxoVQ1mGOStPHbZSWzE8hqwnmoBeYcxPioRHaUq5wuJCi/Vqk+yIGUKxPj9Rl4hxv+0uO5kBbk+SHYDGui7mjlb3qIeEgRfdNYwDmVVmezNtb5xq3rU26zMLrwJkFfncEsNaHsygtkr0eg+dIyJkER7K1879828I+GoWvPfwlOSTei6O5IcuolYYIrmnk0+k9qAzAIAsZMFfQFY+LSx7cDe35KWvJF9qO02nTPzefqrOZMLaKGWtjbz8Y+0fr+wuy2WtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJ3nB/d6NMQFAyrcvo6CFHpeHqfwuMu5eo3YvtFCWYk=;
 b=G3wtzMF8ghlsgxPrFEWA8KAyIiCwt3xtMk0vcqYk8XyfSz2iuiu04GhHUUzOXmLCe/wxXGbnrnrqPKaChK69UPk1v7zQSa5fAcmYmpw3LRfqr9SoWXG/5rW5oYoS8/zGyoqR1KvEJVhPRSq1cWHshuogr9G2P3A7MRQa75OvrfM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7139.namprd10.prod.outlook.com (2603:10b6:610:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 22:35:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.007; Fri, 24 Feb 2023
 22:35:05 +0000
Date:   Fri, 24 Feb 2023 14:35:01 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/46] mm: add VM_HUGETLB_HGM VMA flag
Message-ID: <Y/k7lc8/bKjg8Umj@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-8-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-8-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2083a5-a8b3-49fc-75f5-08db16b76000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /i4GTAWZHUYzuJdMOVQVVFQeFIH7x17oxXUyrwzvL9k6tP+h8DWMUqhEMVvhR2LWEDPb4f1I/YmslDSbqwIZQRaXbG0W+mHujwBFjuw1GTuDP4m/mpA+4SeSc86TuVxVgElmxPyPQgOJiHaOdq0oboQcFnocZ2VyW+hx920Ap0m2F0HfkD6HgRYhoKzjnsgZt3HklQjJ7+eZRvCJcr1kYwAuFeeRwALNLbwV/IUFvB1+Dleb11IjMbJC1/H/Kpg2wnozZKQ8/Z8az890g1MBrv145wE2fojc/Fu8otJjlruAGAmAlqYmQwm9GI6WUy29hU9rLaSpJiaxysNTuDvkQBX5Xtpr8JmrSIiWMa+E3fSn2AjTnl4JiFUDhyLfUrrXz+plUHABuejs2Jki0Oz0QbU6jQZpitEK3kEBkMubBLEog9IaYbGRJG5XCLqe0tinf+1Hvr3HbpNiIQkeqDSKQ5hSGT2FJ/01+AAkslTwAdRgVFXMdpq1boPS1GZeUlOm/mc9C44HKPPcjdoX+eGInJf/SoXxmrn3bo8OwaN2nY1i+ninH2B3XNEMQrt+8B4s1cU95P/Q4leFHpdMw8Ton/nRDKegmIrvrJWoPdOa0Oux2vCjVLvFXzhIf5cp8CxkVmOkhcQUfIZpa+1LlNHGrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199018)(478600001)(53546011)(66946007)(66556008)(66476007)(44832011)(83380400001)(4326008)(8676002)(6916009)(5660300002)(186003)(6512007)(26005)(6506007)(9686003)(6486002)(6666004)(316002)(38100700002)(41300700001)(54906003)(7416002)(33716001)(86362001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NjccUqVHEvZV572mE5/Ueawo7E/5EJUxqYc6sB8ua9pSU+btmpf8J+dgSfta?=
 =?us-ascii?Q?O3THs2lfZ9578UDbis/5YIfXGbZjDP24O03SaUDsJcBpLwSD9bqVsUl2wS6m?=
 =?us-ascii?Q?egQnEUqzxbZn6TFNVpL67ci20r7JFtYkudjP5MRafMMaVJb81YRrOuDTTJUP?=
 =?us-ascii?Q?OPEei57hHOvMur32M0/f3JBDQeVfi1En4fwlAck0W8+IfpR+JO3HlCySSONW?=
 =?us-ascii?Q?GwhV4fyaabhobGisF+VctGIhkMWLbz4U3IRIXFhXcpOpHfoQ3L3CludpoJnL?=
 =?us-ascii?Q?/wFgPr0E6hsS4Y1Ey9vCnS8hYlq9My9+HhSlURRn/NuwfanuVk7QfdhtnQxl?=
 =?us-ascii?Q?zKHzx52Xeu88mADnDUzvzZl+dJiLLhiNXjKSCP+WzTOhO+gUnP+nRNd5qoOD?=
 =?us-ascii?Q?4f7XQwtMXDJJa7tnsbm74xyI3JuXB0Dj0e5JVFf0yFX9wE4jVSSyQ1CQUoPI?=
 =?us-ascii?Q?6nz7qsfv62Mgx8NC0f8mROcEe/C6Yjk4Pz/Wb6Fl6PKUAnOgNaic1+cwdibR?=
 =?us-ascii?Q?BzxY9c9UlRa8SelrRpaorfmqSG975T2JEM47J9GUt9+K/31Um5ODmivZ2xbe?=
 =?us-ascii?Q?X2QwLPfIoMgg6SFzYEUTlbHKyZqBcEx3+krfxyddFnSI7Vx34Eqc+gUA2ExO?=
 =?us-ascii?Q?ytyT9SARx4J9UxRnQRRKvFobJ8gpf7MMBQlR02G77Z2s4RxZCSIbyPdN/bsf?=
 =?us-ascii?Q?UkOsqSSID8gAhOPUg+cxlh8XL3Ge6Ubs3FzQHnbcR6C7kCHgtIcjL5OE2vEu?=
 =?us-ascii?Q?b1d4toEhleilbzsWDVaHNkvW9ecCKKKvaVsFVCaKfjLkzFjtgoh2oFuDGsGc?=
 =?us-ascii?Q?07BZC163/zGMJ4dV/+cJQ3XRM6/f4xmBpEWC/8qsXIttbTQM5uNBs79/gDSv?=
 =?us-ascii?Q?xnGp5RsIYNVL5tUK4utB6NmGSL5aOZ0+Ce4Ge4ea8twPq6QzS+kgWRMUPMTh?=
 =?us-ascii?Q?KazllHdRIRjWlxHxKvsrwdV3GOkR+/J1WlY/+WjRa7+CXcOqdfg+0mzvncxt?=
 =?us-ascii?Q?TQ9RXFAba9aBsJzKsDp07tPbA9kYQQvv7so2JaxxOuwpoLKW24X4gjIuOwad?=
 =?us-ascii?Q?5Y9YHwr+UclzjeXUtcOH9gb1iPOnlMTclRLViRLcMpZEN6nQOiE5CW2VMpeO?=
 =?us-ascii?Q?2YIg70RUOUeIOPKp+QBeilNvsLyT3s2tdxdnyGDNc3cVSs3mjI3Ehquq5N11?=
 =?us-ascii?Q?dbCl6KAHVN2YSbH8tTEL+zgpRoOI1sMSUKaaOM52LwK/AEfuJS0yVo0cZq4v?=
 =?us-ascii?Q?nMQvEIMSUSVP9xRlE6JJPZ7iMcibVspFhkU2+plieZnTEDLN3BBSSElEZGCS?=
 =?us-ascii?Q?hezd0qxxhX8yu6oTDxYnOA+rEJIhrZfYu2ej1pHDreCaijYXKn5QvQBwXAvL?=
 =?us-ascii?Q?YTSF3rtNYUXCPy5AsARSCN0LQuAjIwa/NANlXlhGnGfkdnnNZFTLmur8Q055?=
 =?us-ascii?Q?rWrNwian+CRl5bAPbRPzgCLwZaLBsZOyJj/4xjE1U5g5QuppTtyfg4HSEAg3?=
 =?us-ascii?Q?88OOiCDVB27TnWY29KNWAVCRgHlnyWzTv8x4SggnIZgXchDlS2nN3Y2PIZxu?=
 =?us-ascii?Q?pFmaWpFLlnKWCzSMeamAo5fdCWjnm+yfQwTNb8vnk51obS+jZ6lG8wD+r+4/?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?k/Sby2ehCWg+Iex1I3NfuaEnLnojEE7HRmYfOM4oQn9Eil7UKtsZlUxv+Opi?=
 =?us-ascii?Q?dIsQRnLU9h5HDRR3EIWDdAizelknpsY1a3+lZKJVjFLal94ahqePuKgPmCNZ?=
 =?us-ascii?Q?vsyTiC5BHCmxTur+IQLznkvyVz2rr4n7waDtDiKic5X9tnZCaqTiraopsiqr?=
 =?us-ascii?Q?zsrbMMlWqy7PTYSvhJ2BLD3iuTfaKUeq7+NuaB41Lda5h0a0Ra/4mBYuKMMy?=
 =?us-ascii?Q?OfWk6fNwa+IeK2fYSD97kgeQM6wVsbyk/epqMMompF/5tKHMzdz5UiULEt1k?=
 =?us-ascii?Q?hAClKfHqSkjHAQh9DunE5jhWj8BsEGxw5Yu3ypFtTDy6sxpFi19XjxIshNDN?=
 =?us-ascii?Q?/tdgU1ugyKedU5itGs0YjvILEuw4B6dSEmNYPAZVnBnxxYtXyYjNCEap8GR/?=
 =?us-ascii?Q?w0UKqwi3JxUN+ivvtGPSXfoa5mchrN9GwhLE7O+YB7Np+ZDHbZ+R0bFMXEQg?=
 =?us-ascii?Q?LdSOk4nkVwcvwNqww6g5zp7pTSg44m0r9egdAVAn6TAZmFfuGjRxYP++s8kq?=
 =?us-ascii?Q?in7VxxPqlN0V6kUGDyY1CBdWxx46e79nlGGrvtCb0tiGUKi/xxbfRp3XbRfS?=
 =?us-ascii?Q?kLPxDo9Kco6AauBQzaIuKY/OggyZUrx8UKuQCS8+nFFYW81YZBNncqftFuFW?=
 =?us-ascii?Q?s9oZHx6WkTO0bAoVldXFkb9vCGKI3NUF2iOChadAzOVzhogy/SwnlhEXhCUr?=
 =?us-ascii?Q?xt5tAFKQ3YxvwP+EXLVlM7duyEwLaSX8dKxzwEg6SR1eVbXx+tKgtFWNoTHJ?=
 =?us-ascii?Q?Ss1UvGVK4UykyHMkKDl4c0WzBi1Eq0h/OtTJ5pDChj5DSmvNPse+Cyk0Fdnh?=
 =?us-ascii?Q?mD9GllSblctXpCApP7ONvJubdzTRCpX1WmQUQTGyNaW9VN5BqdRKRA2oOKIq?=
 =?us-ascii?Q?T0qr5OGkE1ppF1vVAhUBCYVqkSFYba3hLNrs3iubxDPbEkxaBeqts4uWtfKG?=
 =?us-ascii?Q?3T9WNQHlawF4TxBJ4vtgsbm/IM3OH/9+UyxZzO1VPoKbl3gNbm9tzm4sKzvT?=
 =?us-ascii?Q?HGHYh/0lW+ybwVaZyjcCC70FtZnrc+H2q63ru3zZKTpSCXcsoJXWAfKuaXu7?=
 =?us-ascii?Q?pfaFoeSd79JEW4ioFpTyzhaAG73VxKn4dGt35mmUpjIptq7JkIqrXnQRm6PY?=
 =?us-ascii?Q?d5P2U5PLEUrFoO0DT3bNFEkFrdejUpKbZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2083a5-a8b3-49fc-75f5-08db16b76000
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:35:05.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55yJpHZ47lw5yvo55cPOyAgVm6JJ95G1AIUnuGkD6kMkxjRNErCkC5184MxiCwo+4F7Pj4EM8xlZhBwiz2SU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240181
X-Proofpoint-GUID: 36UrPMX5mIrjxghPGuRn8QiML-Q0ivOg
X-Proofpoint-ORIG-GUID: 36UrPMX5mIrjxghPGuRn8QiML-Q0ivOg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/23 00:27, James Houghton wrote:
> VM_HUGETLB_HGM indicates that a HugeTLB VMA may contain high-granularity
> mappings. Its VmFlags string is "hm".
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 6a96e1713fd5..77b72f42556a 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

If there is any push back on using a bit in vm flags, we can go back to
your original scheme of embedding info in the hugetlb per-vma structure.
-- 
Mike Kravetz

> @@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>  		[ilog2(VM_UFFD_MINOR)]	= "ui",
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +		[ilog2(VM_HUGETLB_HGM)]	= "hm",
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
>  	};
>  	size_t i;
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2992a2d55aee..9d3216b4284a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -383,6 +383,13 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_UFFD_MINOR		VM_NONE
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>  
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +# define VM_HUGETLB_HGM_BIT	38
> +# define VM_HUGETLB_HGM		BIT(VM_HUGETLB_HGM_BIT)	/* HugeTLB high-granularity mapping */
> +#else /* !CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> +# define VM_HUGETLB_HGM		VM_NONE
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> +
>  /* Bits set in the VMA until the stack is in its final location */
>  #define VM_STACK_INCOMPLETE_SETUP	(VM_RAND_READ | VM_SEQ_READ)
>  
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 9db52bc4ce19..bceb960dbada 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -162,6 +162,12 @@ IF_HAVE_PG_SKIP_KASAN_POISON(PG_skip_kasan_poison, "skip_kasan_poison")
>  # define IF_HAVE_UFFD_MINOR(flag, name)
>  #endif
>  
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +# define IF_HAVE_HUGETLB_HGM(flag, name) {flag, name},
> +#else
> +# define IF_HAVE_HUGETLB_HGM(flag, name)
> +#endif
> +
>  #define __def_vmaflag_names						\
>  	{VM_READ,			"read"		},		\
>  	{VM_WRITE,			"write"		},		\
> @@ -186,6 +192,7 @@ IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
>  	{VM_ACCOUNT,			"account"	},		\
>  	{VM_NORESERVE,			"noreserve"	},		\
>  	{VM_HUGETLB,			"hugetlb"	},		\
> +IF_HAVE_HUGETLB_HGM(VM_HUGETLB_HGM,	"hugetlb_hgm"	)		\
>  	{VM_SYNC,			"sync"		},		\
>  	__VM_ARCH_SPECIFIC_1				,		\
>  	{VM_WIPEONFORK,			"wipeonfork"	},		\
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
