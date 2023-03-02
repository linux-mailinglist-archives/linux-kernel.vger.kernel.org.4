Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6982B6A8977
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCBTXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:23:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B15E1B2ED
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:23:43 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322IvxAo002232;
        Thu, 2 Mar 2023 19:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6Sicfpx+a6oxX4PJPfXyYcX6s+XQPYPNZ6zOVafw39I=;
 b=UEXnHZuzblATpJxQuJlSB3AYzAdPGWz7ewinB6lVlTRjwhCSxnc4tqJCDEmfDNJBFZ2M
 5UxmfJaFHn7d+Jb58p+j2yVuYM5jJy2qx6z4lbYc5/58uSIQkI6jqIdkW8TnmxC5Ji/Z
 dlNktKkJ1JNNBo91cAS/ZYIFY6tsYJrpphuI1jLsPL83MvEkR56oM92AY5R+IZH/eerJ
 NHUEHU8b0nh9BYhrF3sSsFY2CXNP1GCvYkQWdxHKMVtWyDYEifmMtyMKoh8lNW+sJnqK
 cxVIc0faZt+yr/EzZs9k925jJiTIaGcxzF36KPmY+M7NbkfVS7jGzz3/6KDOzjQPTkkH pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2mtnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 19:23:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322In04J034891;
        Thu, 2 Mar 2023 19:22:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sgk7n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 19:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoGjZOc34S7VCIXBrBBlWtgD0/KQuhMSlP6G82d1WYXE4WfbGC9v4YkGBj+qfiTkp3VTRW5KmC0UUK84SMdlyirHcgy/ofEAQ44cPOVebweT6tR/MgRGNX3O6xx+WtqhU8xTp52/2CUWacEdsJ2rsjLxHVrgcL5RPBmL7EykG1271b1QY4QGZoAQ8DQJrxU+UiGtFgUR9/Tfbf389YM48jdndLR07Jy90cVQVADVpIFXa+HtRhfyGzxyaeiwR4UNnqqK5gUWs1yBYFOXlsm7JQTnM2cn3PQEotx81dJyg7Mtsr90RGBrm9oriAhrpZFMDbajgSch6jlx7RX5petlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Sicfpx+a6oxX4PJPfXyYcX6s+XQPYPNZ6zOVafw39I=;
 b=JyXYNvRK4yr0+gHzjzgrSS2msTb/3+YvrcL233EUYf55Vaf4SfaIWotuFVyYP1UGAHZl/VY4EDDgpFaGcM+1UTtK8acHc1WTbUUMMLDP+WNX/7u9D55bKC4r3649zX8zD1/DraxikR2LA/mwBwi4BhjH1k8bk6yoN0MnTrDoMMICpCOoq3isxdcGhHtBMhGYxWptsGeim280ju6pIpcEfE6ggCMDY6El6Hy2H3Ccx1kpgRO2C7ZVBrxuZ2eJ1FQ2pvI8Kx9Bx0Ai1XZbtvXrqCaFWbqRdKs8NbplWWf8OEWlkt75tr7NcnC+gG6Wiv514jczn9tOeUcvrKRi2j2kYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Sicfpx+a6oxX4PJPfXyYcX6s+XQPYPNZ6zOVafw39I=;
 b=u1aCloSAi/QZqb9R1b5k2Ym24O4++WSQnqwga5W0QJdGkDoPXKCIWaxrm1XLcJAqqDv01T7MvtVW/u43OhFDnO8T4aYUiZLZ3CRe8+q00SPCK0ZnSwr4qb1hZEwsYco8kpp7O0mPIzSxLTRjliOHTSuYSuFyxiT7byBBqKhbuig=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4880.namprd10.prod.outlook.com (2603:10b6:5:3ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Thu, 2 Mar
 2023 19:22:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 19:22:56 +0000
Date:   Thu, 2 Mar 2023 11:22:52 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
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
        Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/46] rmap: hugetlb: switch from page_dup_file_rmap
 to page_add_file_rmap
Message-ID: <20230302192252.GA10997@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-6-jthoughton@google.com>
 <CACw3F538H+bYcvSY-qG4-gmrgGPRBgTScDzrX9suLyp_q+v_bQ@mail.gmail.com>
 <CADrL8HVMp9kA=c904pUCqa-J_1vY4UPtsL9up+ZVVDp4TZbG2w@mail.gmail.com>
 <CADrL8HWPJuFixYzh97nT_8XO2kaS6i+wY+T58HL3GTmq9u=yTw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HWPJuFixYzh97nT_8XO2kaS6i+wY+T58HL3GTmq9u=yTw@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:303:b4::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de44fa4-1749-413d-e6ee-08db1b5386af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mT8ysGi8Q3Tw81mNIdj/g+klE4hkFAU/IJcO7ZpTY3jtwS9JSsRdTIPWtdlGuJ8TrIhQYqauRRp3RbuHqs3Eq1bMt/ir1kAzFHBcVL6q/tR/eEGsICo2JlH+siku4Dn8OC/CBbKLjl4Y9SJAR8vMXHyksdlRfY8eV+x3G37247UQ6B/DsKJSmxKkaNVoReQi4reAdsysDa3E9s4uZGInj5BTXksQxOWVoCshtUbtRVMaQ3ypG4x3wDMGY071y2/RjwqM3zOnVZJ902OciU6n2kUqfRG4i8/frBkGVoQWRMxDT+AfDcpd7Zf3AgVmCXCkKpOsXGU2wjmYAhtMYBpIScnCHsyBrjXhrNbHRlauMP+yvF5upPKmeTRTPzvtOhqst5wGiqxWu7Mhs9iirgvgtE4/0vHomg53AFmloq84VXbmpawxZfVcenAw5YvvxOwSLuDDyT1ZiW7ZqzX02Ric/pYwdN9Fi94ZXXlzUmVuXVDQOPZw4ByPHBBY9Bcoi6hHk2EuhnfVQIRSz6IhbtudevgwoRdFuFDg6O5xzTjf090OfqvjXGJl0MZk4f+v3N0my8UzuWyK+OJ8p6lrWWUQICvtoGJ9zDbzw87TJ0C+DKTY9CcOndWnO3RRY0kRKY0Wkyi9i1dQ5kizTiFOURSvqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199018)(33656002)(86362001)(33716001)(6916009)(66946007)(66556008)(186003)(9686003)(4326008)(8676002)(66476007)(8936002)(5660300002)(41300700001)(6486002)(54906003)(7416002)(26005)(478600001)(6506007)(1076003)(53546011)(6666004)(316002)(6512007)(4744005)(38100700002)(83380400001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gd0UV9sswGu6D735nN/rYnJjAwi/sNItrOZiMXFjVI8TGK1FtE3uTsZsJtdn?=
 =?us-ascii?Q?Zhb2O8kjwpfk7606g5QwXTVxl/g1Hi7SdUdiT3zExfQEi78veji+EABPvqXC?=
 =?us-ascii?Q?7/3ZiFGWQgP/SpwHKEhYotjaGllT9yZlX2HwWebSpBs7E9aYNDTvF4fNbVZy?=
 =?us-ascii?Q?iCmo+6lKO22dfRBs/9AexBEgLlVtZpWx8cconTDSy30MssTIPTzMG6PzkGz2?=
 =?us-ascii?Q?AEtKX+dN/RNfnv2Sr8KgtFuHHrmTNk+VCQe5IFbmBxzvaS2Bxeoh4+IwlKmp?=
 =?us-ascii?Q?cEWALE4Uutm3NZwJ1S4B+y046vtksWgI2q+GsVdNZIZC3uTi5zVBZ2K3JsOp?=
 =?us-ascii?Q?vMiWkG5lCI6tWr6x9nPPNRlWVVce/66FnvzAnU/ItIXiSTxjqe5iWyLroUa/?=
 =?us-ascii?Q?xKo3EjweFhIQ1rWoVVVwY4yuCs4CJf+EacO8CjlFHHSdWkz1odgTIIMAgkiK?=
 =?us-ascii?Q?9W1tvlpGmT03RiMDBNGDUifkkoLDpOdi0M0OzaGNnyKRmQZRef1OPldUrwfA?=
 =?us-ascii?Q?fdBxlm0a8Sm5qwq74VRkWSHW36Xo+voAoZPMLAbi4EWTWxiogCPaHeXaXtj6?=
 =?us-ascii?Q?X6xV/+EpSq40DIgbI8XqjnBrTWwWK+tb9axCsGM3JQTjV9mvU3kMjTVVYmg7?=
 =?us-ascii?Q?cPgy5kkYn29A6wSyBeSY/2YZ5vwFWNug0WxgeZnZwxB6EyGaAR92lG2aEooD?=
 =?us-ascii?Q?mrbVKWafyJtAxLdCObJrhNS1O+k0CdExHWB/7Hi8p+r6y+AuzjgTDJlDLpPg?=
 =?us-ascii?Q?6NdBw3B5FPfY9eJuETs8N6eskLjACk/KynfTQh08cuJXUOTx/gcKLtO5KKMV?=
 =?us-ascii?Q?6M/SY+3+HXiPNUtaAe1yoJGrAAIRw3m3/BmBS/ZOudRhNbiq74Oc4RwBq0K6?=
 =?us-ascii?Q?N3QRX0ZOmkcTbRPw5/mZGXRHp7QmWnzxZtB5ayOVQbt/3mV+HaeCvhnhJHZC?=
 =?us-ascii?Q?HunQ5sAJKU7MeGwCL1ylBqflnCBnM5Zb8ECLzKJmOP9uyFN2mQRBvXt933oW?=
 =?us-ascii?Q?IVf8OHlCX+DX27JBU3bXzMeVY2rOZAzdKQKsJwXzd9zDtNLmzZ+uc0YoeRia?=
 =?us-ascii?Q?8n/30Sa69HEKI7lIN4dksvzrQCoaeui+FdmYWVm5SBkrltZaAouObHrOJD/X?=
 =?us-ascii?Q?6Ao9HrNMuQPxCVorGR1UDQC9HXNQmPmo+sdYPSvYh4iYFFdhUQFixUGiM+IW?=
 =?us-ascii?Q?N3X+r7clxEJ8FzE2J3RPFYskOyXTuUnSMLLkWm3ONJY2qU+6PrwfPmDSl3O4?=
 =?us-ascii?Q?AGSYSI9ICRDFyeiktF+7K2ww3sjjuW7jCpMKt8OWfM7Yi/Y0k9J3WmXRFoyg?=
 =?us-ascii?Q?eJrCq7K4Whg+JuBOCaBHrgx0FOBXwPRv7TEVPwi5dTdkjO8QA0FqqTVcf8N6?=
 =?us-ascii?Q?mzLJ0NK0MtwaxLWfxt9pIvVrCoucVqjUUarI7+fOuEfOPGhhwLCzQShQX3S1?=
 =?us-ascii?Q?GloFzdyGd1pWvz4hDlV6XMQB0sUjlTTAp2i8w1eBIvHLlJE7orM43bzFd0yt?=
 =?us-ascii?Q?lavUzuzc0sf0s7xpO94BDki5QpAgg7Rg/vdoR659Fz8WhtK3ZhTpz2C6cC1/?=
 =?us-ascii?Q?85tUDdqrhv49TwS+HOpEDZzaMzy/+9H2Wg6qsm38VPa7bbKOMmYmbDZeE5D/?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9MyY3DcWMYZXGJBdAIeeBYmlcEYeD1v+/AC+iKMU0bPRlUWqUauBcQ5vKUmH?=
 =?us-ascii?Q?NBAzdN0rzRImLioZ3+B2FKaRpBN6VAtUUEDtyWxQKWRtysJM4Oa1xqNaqaxE?=
 =?us-ascii?Q?PAMl2Jxtdpw1fEECx2z2CB5VreJXST0+dQH+s7gdi6Heco7VTICLiEOOFeku?=
 =?us-ascii?Q?1Jk7MGQ6OyIAy54NPaqNfiohK9foXb+CtMDnjXY0jQdNmsvd0MRRZDajHNjx?=
 =?us-ascii?Q?xcQTSkyC+JqNX3McCi8T7vSd0a1WV0ucoEfBNc/NuXSb68sCFpNXZD1PQKDU?=
 =?us-ascii?Q?fon3HqBnfcpP8Znuqm/wp8Gmee8SmANBuDvzUiUl9LCmYmv/AlcQ+AoWXXrn?=
 =?us-ascii?Q?Y1MIs+Ik4FSv9j5xOvEq5b7dO1k5PKBjeCl68Yz5oz0tjotE+MZUIp8ws3aQ?=
 =?us-ascii?Q?t/Jt5xKoL+MczNMJ8DAaQBdkTJev/58uw98UJrIgrZiPOtZnkCA0iW38dvPe?=
 =?us-ascii?Q?oU9Nk82sqhYcIa///z+hBuGEw2PUpZtISXTFIblFIb+CaExlB9Ea5o5CMWH8?=
 =?us-ascii?Q?o+plJqnPnMHMNCv36MyJlxnJdkurMYdYdGPEUYaM9DAca6htjow+OS5cgbhj?=
 =?us-ascii?Q?CKnC3yRZgqA1qZdRx4EIgUAZCJO8GqJii52M2V+9wBRFyPxhAACpiypnTPiF?=
 =?us-ascii?Q?HVg8RiBDeD9WkkCTOtTN3J41/ULUVNSa1ID0uTl9kU2ex05NT/NFAI9W941J?=
 =?us-ascii?Q?KwcbkmmqLcPC0lNYPmRVrUGkDL8urB7bOQ/Bv2nuoKusw13Lu1NRg2LG8fy/?=
 =?us-ascii?Q?mHwmiClsEVdannbEmURyKiU2SJxcOttD1vXK0g8poSYOvwQvHrjtSbooFOsr?=
 =?us-ascii?Q?Bdk4zXSFAV0NF9bR2RAIuU9t5fgSCIEWF2kwcKWrHpKTGr59VdNqisSCWek1?=
 =?us-ascii?Q?UEmXFqUVXVoS8uaC6VoGEqTC6FVr3sKKcVwaKfaPsEmylMzNrFlHT0OYMryu?=
 =?us-ascii?Q?YT89vrHFI6gUcD6Zes9Q2EWiqjV91/pApaKx2GndGKl14pgP2TD2Y8QLfhc5?=
 =?us-ascii?Q?oK3sLsJ1tbzH8K6JphOBV03qNU46UkAsxCExPhIjlFoCFUcc2+lzP0uPuvNN?=
 =?us-ascii?Q?lcdd3tqUmXVPXF4HpONJpDGQgzJ3aY/hK/tKiAtnSkxDh3H9RKUY2xlFNnCx?=
 =?us-ascii?Q?2OQDSpPf5JCu3Tt5zVkHcJMVd3mTqwjFpg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de44fa4-1749-413d-e6ee-08db1b5386af
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 19:22:56.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZtZ2AmT3oxc2stGeCWgfWJWkuJATQiHWJ8KN5RgrriQEpxkg5H0DqVPAbmfnw0V/vN1p43Fh0SVi5Aoa9UGoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_13,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=845 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020167
X-Proofpoint-GUID: jEsw4Hp-SA4Egh-QdgtF4F_nGh5r3OBV
X-Proofpoint-ORIG-GUID: jEsw4Hp-SA4Egh-QdgtF4F_nGh5r3OBV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/23 08:43, James Houghton wrote:
> 
> This solution limits the size of a HugeTLB page to 16G. I'm not sure
> if there are any architectures that support HugeTLB pages larger than
> 16G (it looks like powerpc supports 16G). If they do, I think we can
> just increase the value of COMPOUND_MAPPED. If that's not possible, we
> would need another solution than participating in _nr_pages_mapped
> like THPs.

For now, I believe you should continue with the THP like approach.

A couple days back, Matthew asked me to take a look and comment on his
latest mapcount proposal.  I have not done that yet. :( The hope is that
this will make hugetlb HGM simpler as well.

It is somewhat troubling that mapcount may be changed in the near future.
Better to be consistent with THP than invent something hugetlb HGM specific.
That way, when THP is updated hugetlb updates should be nearly the same.
-- 
Mike Kravetz
