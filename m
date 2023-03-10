Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251636B50EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCJT3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJT3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:29:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B17E8A9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:28:59 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AF498I017900;
        Fri, 10 Mar 2023 19:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=Y1Ul/E/gx6Ga5eqgGnoVBJsvo9oFjYjqxTxZQqiqRqg=;
 b=a+VhsTEA0O09p6iwqxyBjeoFlyKq2fij41VvDsrtHcdf8AnYPHAi7BwyjMZWEV59i3DO
 vFvU8+Oo9QGc+FH5XFLJ+AYKZvb1sl6NaIEE6i7we+CMqXKsyCVeYDfzaMtufs9ctdnJ
 gRLsLrYkWh+3S5iDRiqgNVg5xqVL9u3hh4c96UZAXP5fFJpQuhxmw07YDjlEgXuIxdia
 YHAdmmteQrl85SzW1fAtbLskLmcOa3BEuCHvYVER55E4E+UmIjab8wHMewDWpbpsFKo0
 QXFfZVNQWhi9Qa0FsKpEQu0ovmhBhjww6/4hDiDAaSiBZ0ZLW/KFKuHIUlp3TGqdSegV 7A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415j64mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 19:28:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AItp2i031715;
        Fri, 10 Mar 2023 19:28:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6feqm6nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 19:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YThRqXLxgxKMcUmboUmNq3CwcghrCXtGMQyn7ptSie6Br7i/tXftYWDT6p62uKLtT3X3fxqmevfcdjaoSAaBf6JegAzNoOWkxV8qDkGXAOF9lt+sCLjxP6GJILTEEHymBduqvUb1hdfyavFnnLv4zgdSSKOxvE9+PUYwLAFMhf4aFc25TjjxfQcdxbH+8HI+xsrIHJ27bCftyau7ddokjcOs2iu/G9kmjk7iC/pPOfbT55MLqhkFsD1exOaoLMaqy8/3Jq00cfCSPK7P4q96QIyfb8Vi8JbkUbok5HQzk55Y1NGj0x36B+xDVovdv9MTaoqyToRaIXkgh6t8JTprTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1Ul/E/gx6Ga5eqgGnoVBJsvo9oFjYjqxTxZQqiqRqg=;
 b=Ez4GDFbccxA/qsA218+f7WSAjrjLuNfvQFsMokKEHSDCa3BVGLj0oQMbpCe66TTlltniiSrOUAyUsYqwK1/gufzt0/x7kAldJmq3uDH9JYuqw0WDXarlaJr7GEmVuo3ouLrsmZzKkaVffzJIOa1KEXfoPt1CMCZD5JTcHxikpP9U0EliDHf8bQOVaQ5FXcwQigpN0NNq0dDnPu5L+RGbJw5/tkN1wbrkUgUduQv+o7/jEUir4yVTpGMyZkiJEqBTdQ/RZmGrnPI/ooRrZ38Wuq2lQG4VD/JD6lsO6QA47r8svEMBes2AYr6rw+yV4cgdMt+NLVNrtaZGYX7fUuYTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1Ul/E/gx6Ga5eqgGnoVBJsvo9oFjYjqxTxZQqiqRqg=;
 b=lCDKu4J3wZe9BJd/akO428SnrBrSacTGjoZmLnODfUF5Y8XbFpQp0URZPx3x6oExnUjxA1QM9FedYT6Xz8y5JmUiiN8o3GS8sTm3UqZhaKwxNGPp2VIV5iMImaswO4CkGOa7EwshAqgR5/TFYHPnIyTNpfoFwaJ+qjmFANwtvgY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5689.namprd10.prod.outlook.com (2603:10b6:303:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 19:28:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::93c9:c99e:5ab:4319%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 19:28:35 +0000
Date:   Fri, 10 Mar 2023 14:28:33 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/4] maple_tree: Fix get wrong data_end in
 mtree_lookup_walk()
Message-ID: <20230310192833.blfxxwkddth576ub@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
References: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
 <20230310140848.94485-2-zhangpeng.00@bytedance.com>
 <20230310175842.qkw54rj6zg7dkymd@revolver>
 <9f6ed89e-3456-28d1-0c27-0925b7238f97@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9f6ed89e-3456-28d1-0c27-0925b7238f97@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0070.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: 02118b44-a196-447f-daf8-08db219da472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /P0qc/5WSSC1K0cS84UBww4TllY8iy9TwQkmDU/rd6T028KydJWXlbFjCEWLJT0Tsa7EaGxGbBjYKBJ2xiCeoe5N7sg/xhKkS561pAVMa6HqESmpjQB1hnG+yCUZafIbx5Tsuf4BA0hkzRwBQ8IqvhVuXHsifKM9vgzyoTP66HYMub7OJAKd4YnDuiaRGiPkYQ0Zh9RhvcFCU4k3DCw25UMTybDl1Uu5IQqhs1iedq6yq9Lj4mF1R+WcI1hUWMgtaF82SANl+BOq3/SgcqzXN75Y0/agKL1ondAcCtqlg9WIQRPrax9YdDuWafa8z7u0Lx+SPajJuPnthtCsgDhNzvf+S1Ulvg52zW//jxk1IsRkTZCqyLPaE/4SYbV70oP/53aM3Q+vCRbSeLA5neUOvsHJbjRwvdfNlCdTpzbio5QQe24Oyr0aKaHKnR78s3HZzdciwy3bsT3F/GvF+53g7NFGaRTcDtHp8maTCUPervehAnsSpcfi+UCKKzikLGXNWup4t4z8VTiZlrb5PuAW3FdVxHa3Qd4Z0oZHd5T8UCXnEbREJdJRg+F7GYjHfq9ocQnDK7BobU0DrTmNi6lUbSQqXEZCcpiOTvnOGhsesGiR+HAcI/GwOplbpfTpjFUEgWjxGc/ojQ0cEONfyYuD8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(26005)(66556008)(1076003)(6506007)(66946007)(8676002)(66476007)(8936002)(6916009)(6512007)(186003)(4326008)(478600001)(5660300002)(6486002)(9686003)(41300700001)(86362001)(33716001)(38100700002)(2906002)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmY0K1pCc2tmeGpySGtxZk9Kb2Nvd2ZidUdvWkNDZUFoMlg3VDVZdlRoMzVY?=
 =?utf-8?B?blA2NXlHRW1NbnAzMnZVUHRPSWt1MDl6MVJibGdsL2t3SGxScFRIQStwYmRn?=
 =?utf-8?B?VmRKdWo0WWZqRklTUlRGckw2RjFJczVzM3N4MWYyOUxzSEdpaXEwNmhIT3hJ?=
 =?utf-8?B?TEo3a003ZGJsdFBmTTJBbE1wb0t0ZDNKR0lJVDU0eHV4ZG0rTC9PS1BwTEI2?=
 =?utf-8?B?bGptQkZrdURUNDdON1luKzRsVGlVTklQMmpOcmJZMFlLa2JCTjB3MVBRbmNU?=
 =?utf-8?B?ZU5mcHNmZnZ0eXJLUnJHSzEzVHozNVNiUTRhNVNFUDRsUWtSOXF4SzVWOUJO?=
 =?utf-8?B?NkZYUGMrQ0JGUEVBM3dSU0ZIN3k3Tm9oeXVrYTBXUEZmTE9laXczT1FoalBw?=
 =?utf-8?B?STFNSEI1VkcyeG0wWkFiMGlETzE4N1pNTHpnQXEvNWtxL3MxV0o3c20rNm5l?=
 =?utf-8?B?Z3J5ZGt5cUphL0pLakFGNTdlazh0Uk9MUitJaTRmZEtXTHZZSjVzWkNubm9x?=
 =?utf-8?B?MVU1UGJDQW5icks2TjJFOU1mT3daNkZka01ZWjhZaFRWUzBUQ3BqMm9CKzli?=
 =?utf-8?B?UkpVRmpmQ0FFMWdvaEhKOHFmcmZ2RDdOSkJ2WmRYT09tTld0R055VkhUNnlL?=
 =?utf-8?B?NWVEYTFWMk9wWnlFV2J6ak1iRWNOcHBIQUh3SXZwbk44MmhVRmVNSXh3RkdK?=
 =?utf-8?B?YnM3RmFweHV1R2JNQ0NyRW5UYmVKWDRSTEpaa1VXNForYWJWd2F1Q1lNRVJD?=
 =?utf-8?B?d29aYkQ1RWw5Wkc5aG14QnJPZE5IRTZIYXpERWo0VkNudjVXdEhJaS9FWWIy?=
 =?utf-8?B?NGRqQWNBWGRBdXZ2ZXBJVk1zTnYwMHU4LzFIWUNDcWtWV0JlYmh0Mkp3WGdF?=
 =?utf-8?B?MWV0a3hzbjZ5NnJpcWw3THVlN3RXOC9nSzF4cGdRL3g0MXJzUTFhQSs0dGhV?=
 =?utf-8?B?ZDh0NnNuVzVKZFQxUWtHdG9rMkYvM3BPZzU0Y3BuWHNMWGt3b3dESmxRUTVX?=
 =?utf-8?B?SXIwZW4xdmNhMUNITHBGdXFMOW9FY3JNbGlPM2hzRXlEcmt3UTVhZ3hibzA3?=
 =?utf-8?B?bTdRS2RDZTdOYkhHSDdlcC9KN29ab0pxK0hpYzZUd2lqckI1Y1hRVC9rbEtV?=
 =?utf-8?B?eE9ZMUx4cWlwdXU5UFIvaUZUclRzcDFmc29KOVAvQU9DSExIdDdVLzlFY29p?=
 =?utf-8?B?eXJhYzJsNGhUYmpob3ozZUR4YmFHZmErWmxEZGNpU3NzaWJkS1lRU3kvdFhL?=
 =?utf-8?B?YmxIcHEwTUdiYk1BcG5wN01kNjRobFZ6VER5a1BhWFpZVzBhSE5Pa1hsYm5M?=
 =?utf-8?B?MzllNjBYNWtqUTdZY0lxZm9uMVVGakZVbFNYbTVVdjV4KzNwNVpwbVZyN1VW?=
 =?utf-8?B?UnpqQ0FOamIwdlFVNElUTjYrZXRDK2VzTlZueFNBVjVsZjJlNzFhdksrWjVn?=
 =?utf-8?B?RFkzSzFwdXllU1hpdkN2NWEySC8yQWxBY3VUYUJNTTViY0FzQjlSVDNHdjcx?=
 =?utf-8?B?MmZ6ZnlEelQ4SUI1Rzc2Q2Z5dE1NTFpaUHZKdDJTWFY2eUdiNDlEb0w4Sll6?=
 =?utf-8?B?QlFoNys4RXRIWVJMMzlTNURFZUhicXVkSSsvb2daUW8zb25TbmZyYXM0UG44?=
 =?utf-8?B?WXpxS2tjeFBvQ09FRnBLWmdTQ1B2M2ZJWlFwM01hNGkwTk5yQy9nTmtidTIz?=
 =?utf-8?B?MDErZ1krU1lyWm5YZFpCb3B5M3NabFFzUks5eUJEeG5XNUg2K2xOcVgzNElN?=
 =?utf-8?B?Nk0ybW9qVTBmLzJVa2xweFNZam5lRU9ZTjNoZXBVc3pYNTIzcUVkc2V1VGFy?=
 =?utf-8?B?YWZ3SUxreUZVQTZOVEtjUkthSEw5NFFMVlR3RE9lek5YaUl1ajRNNzRSZHQ5?=
 =?utf-8?B?T2E3RDV2bXFlaUdoYjBubS8yc3RkcG9BTXMzZlNQV1kzTXVINGlpTkJTaU1u?=
 =?utf-8?B?bkEvZ0JEK2lOQzRiY1FZRVd0Y2xBaG5mc1FMQmNVNStLMHJMYldsUUhZeVF3?=
 =?utf-8?B?MTNvUkwyYUUvVXEyd0gvNHYrTHZpbUR0RVpXSCtuRnJUTkdlWUlVRVZ6SThN?=
 =?utf-8?B?eTk0c1NBVEFrcDMwVXpEZzlVam0vamFiT3YvVTVVL08ra0JhZ2JqVDZVYzNw?=
 =?utf-8?B?ZE40R1VCRkhqbm5QSm9Rb2x4MFJMMy9yOTNrVUltQWFQZXAxaCtWZVhOMzdK?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4e9WrMnNU6FX1rRM3BrVXPxPCUqkhtZ+lg8IKEYlsnbC18+MHqynuO2KwJUEFZccMtT3U5FUBbREB1OugC3eNws8bD/N4s4EQxW2quanhmCKESyV/hPWgoZ90rd4vpJwtT5sgeC47XbeIN07RAvGPF8Y7jLAGeWGplfXG/WSYODbYkEIoCtxST0e9lT+JSe4ZJ7mAhJF2y10ghMZkYOArGvDO405iHHabI1nJA9+7bTAS98kBulj3B5WFR+sX1GyKP4ovvs2ug3oeLfH9yhwkEmL09ay4sNBdvw6hCtXHi41iqoIbv1E1kq87LBlmPNl3gDn3Ws1ZUdNTnk52qkt8EiXatzm4mRBrl13SaVsh0ZuCTxSIU5sIT/wzBr5d1u75nproduhRtLmVWv9Pv4L9Ys/toQavgrHYrQAx+IheIjMYCn0Zj4ImO0LDorMitFNi2SK3CwlCneGg7BRpM6o33o3eGSidYUbLa0qH2aCjsdtoPPgwpM/FOod9eXsaSj7MfNV8ep1RvRJN/OyJUWZizRVahW3fu5PKp3n+QTuNnbIcEJFqrBYZjGUlfqYeHkyqnvRnlnNBx+Z+B2wGGb/p+18T8aVWm6aJnFIKU97akB8hRABTLSHpfjzZzAOsRhma4zcSU17zz6HbW/JQcS3Hpt4kqurlH+fYgeLawKYGFQfO5K1KCNvaNE2jCQ8hmwT/YNqAR5YLsV/Eu9TTAG/ONxBp3ay7Da/jfj0h9kjegKJ90EcGXF+rwJy/SA8tek6uUxZmRMWdT1seo9EsFFZSuUhofUI8FTL/LY15NMnD5xkNuIrQ+RRmTccuPqCJLvXH8G/3OI0BErIPw+HH7eh+ktN7GHTIfR0UKiD08+l1oRgpBCWWUDg6ceWq3sljzJY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02118b44-a196-447f-daf8-08db219da472
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 19:28:35.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXpXwA8B1oAeWKN4tqAUWNI6zKlsaRdcBqSdutJVMDLrH7t/1b9+svAw3FgF107ptgInkjyXf2wXJLcJPbwd1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100154
X-Proofpoint-GUID: WCynlkXzboYEsA9UG2QC1otfUqUVN13D
X-Proofpoint-ORIG-GUID: WCynlkXzboYEsA9UG2QC1otfUqUVN13D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230310 13:53]:
>=20
> =E5=9C=A8 2023/3/11 01:58, Liam R. Howlett =E5=86=99=E9=81=93:
> > * Peng Zhang <zhangpeng.00@bytedance.com> [230310 09:09]:
> > > if (likely(offset > end))
> > > 	max =3D pivots[offset];
> > >=20
> > > The above code should be changed to if (likely(offset < end)), which =
is
> > > correct. This affects the correctness of ma_data_end().
> > No.  The way it is written is correct.  If we are not at the last slot,
> > then we take the pivot as the max for the next level of the tree.  If w=
e
> > are at the last slot, then the max is already the correct value.
>=20
> As you said, If we are not at the last slot, we take the pivot as the max
> =E2=80=A8for the next level of the tree. At this time, =E2=80=9Coffset < =
end=E2=80=9D is satisfied,=E2=80=A8
> but in the original code, when offset > end, take the pivot as the max.
> =E2=80=A8Please *think again*, it is wrong. The code may have been writte=
n
> incorrectly
> by mistake, not what you said it was written.

Sorry, yes.  That does look like a bug.

>=20
> > > Now it seems
> > > that the final result will not be wrong, but it is best to change it.
> > Why is it best to change it?
> >=20
> > > This patch does not change the code as above, because it simplifies t=
he
> > > code by the way.
> > >=20
> > > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > > ---
> > >   lib/maple_tree.c | 15 +++++----------
> > >   1 file changed, 5 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index 646297cae5d1..b3164266cfde 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -3875,18 +3875,13 @@ static inline void *mtree_lookup_walk(struct =
ma_state *mas)
> > >   		end =3D ma_data_end(node, type, pivots, max);
> > >   		if (unlikely(ma_dead_node(node)))
> > >   			goto dead_node;
> > > -
> > > -		if (pivots[offset] >=3D mas->index)
> > > -			goto next;
> > > -
> > >   		do {
> > > -			offset++;
> > > -		} while ((offset < end) && (pivots[offset] < mas->index));
> > > -
> > > -		if (likely(offset > end))
> > > -			max =3D pivots[offset];
> > > +			if (pivots[offset] >=3D mas->index) {
> > > +				max =3D pivots[offset];
> > You can overflow the pivots array here because offset can actually be
> > larger than the array.  I am surprised this passes the maple tree test
> > program, but with a full node and walking to the end, it will address
> > the pivots array out of bounds.
> >=20
> > I wrote it the way I did to minimize the instructions in the loop by
> > avoiding the overflow check.
>=20
> It is not possible overflow pivots array, because only when
> "while (++offset < end)" is satisfied, we enter the loop body.
> So if we access pivots[offset], =E2=80=9Coffset < end=E2=80=9D must be sa=
tisfied.
> Maybe you need to read the code to know, instead of looking at
> the diff.
>=20
> The modified code looks like this:
>=20
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 do {
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (pivots[offse=
t] >=3D mas->index) {
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 max =3D pivots[offset];
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 break;
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 } while (++offset < end);
>=20

Yes, you are right.  It will terminate before overflowing.

Since this is a fix, it needs a fixes tag in the commit log.  Can you
come up with a test case for this one as well?

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> > > +				break;
> > > +			}
> > > +		} while (++offset < end);
> > > -next:
> > >   		slots =3D ma_slots(node, type);
> > >   		next =3D mt_slot(mas->tree, slots, offset);
> > >   		if (unlikely(ma_dead_node(node)))
> > > --=20
> > > 2.20.1
> > >=20
