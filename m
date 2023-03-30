Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCBB6D0F66
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjC3Txc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjC3Txa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:53:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2613349E3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:53:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UHNlmR012533;
        Thu, 30 Mar 2023 19:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=hg2G3Pae3FYIGlBveTudOpMzokGNS42Tj6/YZGihso4=;
 b=eCbaAYTvEBN4ttyZ+emBes4alvBPih+rOXA+FmvbRg7a5/p+vpNFr0WwMcsZHv7RBHnJ
 Lt7pRM9zE8qQMxoeQfvZ3jiaLyZZcaU4r/bFsFkiIUUTN7vYSVRXlNkqSX21M9I5jEsN
 EMoivAJU56OtJwOP6Pft1FFxcDnKW1goliCffj6cjkTqykj2bRajb6IN1zOq99M8GX95
 Kv3mmgGbt5GukUjyNqt41k8bvZS//HpvDz0nEIFpq75U225cN1cNAzr7kEgC0bSW/F6P
 hWWWJvVWSbjM41pIOw7APGr0aVNMC2SamPzZk/hR3f0uBBjGexPs/YaEpErUgkzOduE/ KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqbyuneq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 19:52:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UJcUOA016309;
        Thu, 30 Mar 2023 19:52:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pmyvvvfsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 19:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7pIwgn5wMmDLzr9wvbAD4BIupLNzaYuUFs4AglG5f5U/RLQlkNyyAm138euCo3Emmuh0Tcrmkke7nR6qbzwbyKeR2ClzLDdv9hOu9SHJZeez8DnnsrKRuw2Uh4Sy0FSjpvU81hs0r2dCgKmB7F9wLNCP9BC6kf197SvGRlDI/MpNkapzaPVRABuIz/1f0TFsnvjbYtbWjt+QEi3naH4DW+htpFZFF/gwmdeK/4OxQjZi748b2jdxLmzmZYBWsS5rFmpva/VTM1vRjkd6ndRWjFipxZRCnEhpYctAbmgGln1YxNBTqEnko00KHmR1xICn/UoLo745AvC/I9zlQzEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg2G3Pae3FYIGlBveTudOpMzokGNS42Tj6/YZGihso4=;
 b=JubGXP8WBlSC8QtHRBrl+p5KO0gFdeSneJHB92FUxP4tqXN38RIgt9uNN0AsZX1qL8H4p9Ysyy8OHCNCtjYe0HaGMNs9SmbDQcNeTvw82Fiw+m6od9r8KawRX/LMUe9QvvoIwB5EWPR26Bgt2XbYSw5gYbQswFvNBeFTVNXoDV9AttxFe2Gyoc5QEa8nJ5RsmdBPF8LlQs4PlgcTGO105YbQ39+Dgf93ah3woUuPeRNdbPahd/6dWvVI6ggHjt5NRNmttcO7scWHkRL0y+7Rq3Q0jEu3ab59q5nk8C8Ze1wOQ9STp5LlzT3QVXxyGTVmCkk0eiiTMyEc6kAc52bvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg2G3Pae3FYIGlBveTudOpMzokGNS42Tj6/YZGihso4=;
 b=Bc3rsVWhqx5DnQOJf/vUd5+lcb0YTpdPIr7A4n4mYg1rotXBFNeVMpHYCIbcWRslzbPAb6gcw1+A3/7PM+xh2k5dr3PlEtREWHUTnDAYJx45tNcJSFKYVXcC9pHj0gfy1jbKSiYkgZPM0D71vvAXwiPTbse/wY5RbWIkJW6jopc=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by PH0PR10MB5683.namprd10.prod.outlook.com (2603:10b6:510:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:52:01 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::3e0d:2900:bdbf:949f]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::3e0d:2900:bdbf:949f%9]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 19:52:01 +0000
Date:   Thu, 30 Mar 2023 15:51:57 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230330195157.afbqtusnnbnvtlyz@parnassus.localdomain>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
X-ClientProxiedBy: BL1PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:256::6) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|PH0PR10MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 63045a53-dd82-4214-ed24-08db31583a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTi6fwEDlVbWG4dIRzhYsISdSMQbPr5e0HRJsaFewgBWoYy3whQSqwwE3FX/nMZgt9adXTszdyWZUfQ8ila282lXj7diKX8dcJwKbsYKA+tH6tnC6vpuNixFftziHvE5vLNcOh7pqQ/NCFpI/Fsfn1PHSossVpoWphlUjip2Ttn0Fg3ploAPeAIU1WpHsC2aUsmQtR7uCWB9Tpj+2q/q14UTpM2lEFTw8sDyz7wkM9li3jXAlmAIl4lJIITUge5EoMHE1xhehNxbmpn4nojUcFUIs/7Qe/GwlqeFurKJhVrzWtX2PM/OsmmWtPqUHHk+sGIQZ7DVeHQHVs8fo3wMGB6NnnHZsLyBnDixjRdk7vIGZyLA0mRcUfaOL3IfACF5CQNC3T53RjLFD30x0VLJQJLWWDhjW3jVA54gV/wPEOMzU6XlK4tCM4CrTVQRPJ5wdBFRp3QG3PSKwCMPSgSUxN8eoDnRib/qKldx0uLyCEbdJrj+M3edRSYVqbB42uDvM2qWesPP+ig8aEmOKfjh+ha0Q9+6ujS7HDLGrXT/jQBSoF9ZMS/I311qr2+98TQr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(83380400001)(4326008)(53546011)(26005)(1076003)(9686003)(6506007)(6512007)(38100700002)(86362001)(5660300002)(66556008)(8676002)(478600001)(41300700001)(7416002)(54906003)(6666004)(66946007)(8936002)(6916009)(6486002)(66476007)(316002)(186003)(3716004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XK5CEM8HHWztv52GJCqvZp6chPGWgy1qTG4zF4CBriBVpYR5r6l+IYZlvo1o?=
 =?us-ascii?Q?zHesqeI92azeAtKHIDHb8hOm1YqTdul0yyQbMe0aUqYfRaUOalJxHlKwHdjA?=
 =?us-ascii?Q?25Q31iH+KOwceqgSdS1DMFQC785kITtxNrcbMx8aZGKWRzjhpXRCVoSdeEPS?=
 =?us-ascii?Q?dshjR3ypnJHNeGGEUV/MdrnBPLK6CustkORFyvcK+vM77jOA22lEG5pv6kb+?=
 =?us-ascii?Q?ZcRVKELsflEE+yVHsB8oqzlAY+IcPu7Y67Ng1uU3PfuNq58R7lmbQKxosNam?=
 =?us-ascii?Q?RWeIhI5AqGhv1QwBBzzT1nMHixs9li4hd4ujmoGEYNlyCM9DVy2Jn/HtWkwh?=
 =?us-ascii?Q?UjJeTjwZZmE2oj2peApC5syk9wHfTAxByBF5Ni2oiyU5sfoMC3c7CEOfB/6g?=
 =?us-ascii?Q?rpFtegHr6eGmxiQz+lXENZ+jVzBeycYYryh7rDSzAeM7GMN4BFS1FuNKGZxN?=
 =?us-ascii?Q?2nUy7PklPZd/lVktRJKVHaVIWbT6gZAXzOKVeUAS2fepf/XyJUcZOn5fxSfp?=
 =?us-ascii?Q?jjGbJ783Xs6iy1PyvtqIGOrrXOOvZ32mFoWBasyJxOwmvDUb7/tM/7Ws+Udx?=
 =?us-ascii?Q?1aZRiGnMU8f3jNlIR26ZC+OHOYR5BzfV/UlRgnv99DnHml5kGlRCQSPu4jj/?=
 =?us-ascii?Q?bqFlIGYNQmBfMozKmkglvR2TlaFNyIkIU4EILY2S6cuSGInPAfLnrV2yJVaG?=
 =?us-ascii?Q?5nMAJzKbNkMVSZ6QsMZxw1wOErS+oPaHHr1pf9UUTeSVh+50yCqdn1ZvRRVR?=
 =?us-ascii?Q?xvgp23NXB+TfC6toewpPu536GyN111pRg0IxYaSyFoVfKITdzyaOTZ5Ea6zQ?=
 =?us-ascii?Q?gHXwjMFMAbZUrOIEkeyOYF5lii7rxwbpAqiIyIk3VhuHetdM3/StB9TA8d8s?=
 =?us-ascii?Q?pIHrE03tg4hzLNDMcDqoM97VYKCF9DfOSpl69O7E9F1IdzdMQ3Q0CYO38kKm?=
 =?us-ascii?Q?XI4cYz0SrVWfM/8yLpBE2S0jaB/muWbepkR1OeVIMcfsXHgR0o6uKSMCkPIC?=
 =?us-ascii?Q?+nxrehT0TwApdTdbjS8szSfDnz2reJAoXmQXYtX4V/lew0kE+968jvDNgePZ?=
 =?us-ascii?Q?3dazfArc6R162D7DNp+xXCMN2OBCs1hzuY155+HoS3dIWzu2i074dIShl1vF?=
 =?us-ascii?Q?Inv0Ap8yYLLB8BiVVaro+G4VEQj7Q9bP9SgykFwX7SgMxenT4W3fl6AXwXyt?=
 =?us-ascii?Q?HsBJ0INeqgyoNJXFZTb+7sA7VCXrGLNHHoLOqA3xzpuORjFGKKISptidPqvL?=
 =?us-ascii?Q?XBFDOavEqy5bo4xTjr+NKD0VD6eSkXPJXB1HdEUtpaeu+AKmV/i4lRANBLjF?=
 =?us-ascii?Q?thVixc4rfQ3qc5MMQRvYKu3rfXV6qiohO81Kok6EJOnPG3iXOcEeAgfyC5nH?=
 =?us-ascii?Q?XoSaq5+iNA3ss7AaGvRsW+t8EqngU8yKorHarpGOdXY/Uhq9K/+IHUIsA8Zq?=
 =?us-ascii?Q?TBRUGgk15RQtO1nNiDo31t2HNIyadjWMCKdp/0WfnCmTMSLJNAKRF9PjaVv/?=
 =?us-ascii?Q?QIQhYSDz+O/HCx9upxeg+CL6NdY2VcZNRtgffFZqF3XhQAChGahxBfA2qOhX?=
 =?us-ascii?Q?dAamG9nV5FjZCcCuIerNGEGWM2HTLlNnynnvd3tQ2IlrkgSibPzN9/ryLdYr?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8FutWEQ8+bDcbzLX6F4Guggh3p+0tbKlUt4N0/XlBLZOfqyW0vAE8Vrg8R7U?=
 =?us-ascii?Q?r3lGePZXJ87t9eP3x8/9p8XReZXq7be7bo5TQWXR8rcWcFNaKYlTX791sJV9?=
 =?us-ascii?Q?X3lmWD0BSPd1Y/tnGSfwNy3A/NbMCxGY3b+ssU2Syb3/GEVKQdNKforLvZhO?=
 =?us-ascii?Q?JeEIb+ezDNxbJS4cpUeK1c0P98f8btumYcYjUbceR0ycPD4I+b2ufasryRrW?=
 =?us-ascii?Q?wW4V5BiTZ9+oSo69yQQY+py+2+G/RLpBz5IrAa4dUc09VcqZaUr+fuhDAgUB?=
 =?us-ascii?Q?gus67cPYk7xerdueg6JtTUAJ1hSCVIlhKAQrp+bjfNiSFdt1KoyLuhJ5ysBV?=
 =?us-ascii?Q?dotoawZTLSEqqpXjhvx0RwIgq6pidG9Fz9ZoU331f9zVwA9We0ap6fCzSQId?=
 =?us-ascii?Q?ZfrOwXYnEHNFZjVg8y82+N4onmS/VMz9ujHORomPh97eRN352xjtO9fVmk2S?=
 =?us-ascii?Q?Is4YNpAVOyLfFTEEb1adR99OIpVaiXoegBs7wCMYeNUcka38buAsCZS9Hsw8?=
 =?us-ascii?Q?gpzQMZ/YM2EGzoNmWxC/mRDKulmt2mx0Rf2GIyVdupdxKyjbfexHA5BAqV8P?=
 =?us-ascii?Q?AC1KuU3KW4/Ryb1pWIqnRK1+zydK8Su1zB08zlLoYZJloh872l/sNciwCUuT?=
 =?us-ascii?Q?p3pDG1Yg4T0lA3ZRMTVQL1c8rN5SRtreADg88BXoXmXClN0L/OQr7Bd9V7BC?=
 =?us-ascii?Q?d4o276H17ddm5UQYdI8r/JXk7ZNGzZXUO5KlsdMWIcpdCbKP0ei20dbVEnmO?=
 =?us-ascii?Q?r3OAGsIfg7Dr+9Qwvo1U9POBXYRBGHtrIXyqtI5ffylzz5JX9hcapzrMHDES?=
 =?us-ascii?Q?F+HLsPZyuqu3MMORcWhhI76LADa47+JutfeCCL6vWrkMU0nk/W+oWv4B8UQk?=
 =?us-ascii?Q?yEQoI6m0THAtpFdsvf2jZQYXcYpCLyNu94R5J1uzT0YtMD99Ls6Ra0VXKOdl?=
 =?us-ascii?Q?81z0w+F1QYzdhrLeOGkOPW8aCoaYUyxS+EateK0ZECg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63045a53-dd82-4214-ed24-08db31583a64
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:52:01.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSj77JkZswd7btPch8bxFPKKECijVNdRBysuBXHdg81yh4uAtsJq5qqyOLCtYtKI0sJUrA8EZk0/un8ENmmGqtiLYZfg9ehCIFkpYko99mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_13,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300156
X-Proofpoint-GUID: 5Jc9hpRiFBaxGOoiurfBtooyMaM1--l5
X-Proofpoint-ORIG-GUID: 5Jc9hpRiFBaxGOoiurfBtooyMaM1--l5
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 01:46:02PM -0400, Daniel Jordan wrote:
> Hi Aaron,
> 
> On Wed, Mar 29, 2023 at 09:54:55PM +0800, Aaron Lu wrote:
> > On Wed, Mar 29, 2023 at 02:36:44PM +0200, Dietmar Eggemann wrote:
> > > On 28/03/2023 14:56, Aaron Lu wrote:
> > > > On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
> > > >> On 27/03/2023 07:39, Aaron Lu wrote:
> > And not sure if you did the profile on different nodes? I normally chose
> > 4 cpus of each node and do 'perf record -C' with them, to get an idea
> > of how different node behaves and also to reduce the record size.
> > Normally, when tg is allocated on node 0, then node 1's profile would
> > show higher cycles for update_cfs_group() and update_load_avg().
> 
> Wouldn't the choice of CPUs have a big effect on the data, depending on
> where sysbench or postgres tasks run?

Oh, probably not with NCPU threads though, since the load would be
pretty even, so I think I see where you're coming from.

> > I guess your setup may have a much lower migration number?
> 
> I also tried this and sure enough didn't see as many migrations on
> either of two systems.  I used a container with your steps with a plain
> 6.2 kernel underneath, and the cpu controller is on (weight only).  I
> increased connections and buffer size to suit each machine, and took
> Chen's suggestion to try without numa balancing.
> 
> AMD EPYC 7J13 64-Core Processor
>     2 sockets * 64 cores * 2 threads = 256 CPUs
> 
> sysbench: nr_threads=256
> 
> All observability data was taken at one minute in and using one tool at
> a time.
> 
>     @migrations[1]: 1113
>     @migrations[0]: 6152
>     @wakeups[1]: 8871744
>     @wakeups[0]: 9773321
> 
>     # profiled the whole system for 5 seconds, reported w/ --sort=dso,symbol
>     0.38%       update_load_avg
>     0.13%       update_cfs_group
> 
> Using higher (nr_threads=380) and lower (nr_threads=128) load doesn't
> change these numbers much.
> 
> The topology of my machine is different from yours, but it's the biggest
> I have, and I'm assuming cpu count is more important than topology when
> reproducing the remote accesses.  I also tried on
> 
> Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
>     2 sockets * 32 cores * 2 thread = 128 CPUs
> 
> with nr_threads=128 and got similar results.
> 
> I'm guessing you've left all sched knobs alone?  Maybe sharing those and
> the kconfig would help close the gap.  Migrations do increase to near
> what you were seeing when I disable SIS_UTIL (with SIS_PROP already off)
> on the Xeon, and I see 4-5% apiece for the functions you mention when
> profiling, but turning SIS_UTIL off is an odd thing to do.
