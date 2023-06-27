Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5107C73FF95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjF0PX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF0PXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:23:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F74273C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:23:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDOuYO008598;
        Tue, 27 Jun 2023 15:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ZTJTe8ZuZdTFb948/1PGgno3Be7zT9pWZTfBFDsmY5U=;
 b=ljthddz1u76c45xkmVJk9oBHfdk/N5lsOAnC75da7UoiC0cWveZnlS2neJNcFAQyW4PA
 SAl1CqK7hy5gEMvJDa+vd+ZBg8q1AIY/yr7N+YtlMLueXSAo/Je2Ej86wSR4yVupJFgo
 ezn7aKEEizGOIk761S3A/QlMqG2W0p1jVvGOjpnewahWudnynmltcD9cwEhJ3hoy/XHj
 bTQhh/p9cMXSN4uIlP7FpKjEk8Sg+0bCiX57EzbndUAsNpEidjXKAWIpQbfLdlkTmdtv
 vvi8/IaDXKPH3zN1f8F6VA1j4pMbpM8/IuN8+zCSe1JJDsWOI0o0NqMwZkUNABIgp08y Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e3g42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 15:22:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RF4AXj038226;
        Tue, 27 Jun 2023 15:22:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxb5kp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 15:22:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUGPEvII9ycTq+u3gacQP9GoK0gZJcuQ/j7rXPAHiWYo2CvUa1+l88iO4ayTjw5gtbj/owTO9c7IDBySDmshfH4kk6VLsj5ueQj4vF1GswP+zT+y1DWGGGiK2QHdltgzk7ecouhVJ9xfnLnPcmBDu3/ox2MRKTCFknccCjAwpwKB8T5vWb6/MY+5Cpk4+MksXPGx12CykhwG4rEb+NeQ7cpraXTZaNp6a62AcrEOrynhTT+6s/auGkF18vVJ8FF4K+E3IxuD03XEYVADQLt5y8c45lXPlig/I7dVgveE4MKzZZod4Jr4JS3fD1smYbr1/BsPcDmCH6Rpp8aqzTl7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTJTe8ZuZdTFb948/1PGgno3Be7zT9pWZTfBFDsmY5U=;
 b=fYaPx90hWPp+FFe5d45Hc/sVP+YjtY/p4jfU89/BnsHtOemR482XOWcdKFZdOAZC0KunYw27d4DMpQbLFx7Jx39YmxghMDpEWP6NT9zT+DgYvGy+/HdYWVETAXykdZ+HgXqfHCx5mdBtpRWH6ifWo41KkBybRC1jrdjz8ck6ubiXQNP+ree+dF+8MnVMmY0ywhvX752RB2Slmn2ybJyVY2T+nFIFzcK1KPbR/SJiTmoomfD0dE6pQpH0oIlv168mV576Ayj3s2vN3PaQyRpMOPSw/uwMFAnfzI+el3iFMvRnT5dm08PIhCEH/O97k68KaYGNgJ8wHlQl9otozzITxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTJTe8ZuZdTFb948/1PGgno3Be7zT9pWZTfBFDsmY5U=;
 b=A00eVSbOOTzcyu6r+JUcfL0PUIMj/H04sD6+Iov3ble1tEvL5Kx4eZe44xl37XR47HXjP9GspZViljXjTqD81IOb/gpuqhkoO8FhM+rgXO8B5uvf5tHTCxZpsSTmV7JJP8uFki4i26lmD4Z2w77kVkORSbR4znUOrVqXVDYfjqE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 15:22:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 15:22:53 +0000
Date:   Tue, 27 Jun 2023 11:22:51 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Optimize the fast path of mas_store()
Message-ID: <20230627152251.eegydhbsuh5gsqls@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN9PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:408:f4::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c274224-72b7-4269-1608-08db77226086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joVS2+1o3PPLDr1Tva5ub8B8GJX2P8zp2EKYyoRaPnkC/cMGZ3dsQRCOs9GQAdT0PrQwa9tdZGC2w1qbWOl2hzWx0+6OoZ27MKM19uaWZs4InTf8OQAap3l3mM3TJV4X/fIT4Uqp6Q5CvzyO0zwZD/W8jt5G2Ag7PJItOQceJ37G0vX1wiND23su+di4HLLm1kibf25s5++Vc9ipWH0bOZKQcARWi5i+llBjFL1RSzW+pk4HHa+VkSqroXreRhDbj/bESANbHPyZB0jrKt5yPG7RMeTlTJ6IEHENiEIPJ6zYC0rIXvz7W3tTLsg9qmhzyE/M7vGtJWeOjkVqJvqoXgB5eY++N+ZLDfUceD+wUJe8uj1q+MNOQNA1vEPEL+tj5OcsdoEt2QWDmgtPvkhpQ+SXRVrOn8zix50TtCFhdlvxNBq/rgSvDu3k6kJzUgOk9G/K2u/lb7fkGcMoiNrNQ3zB2xRegCksZmewzbwWasfTvAIhLJkp0C9Ui8R/bS4Qo5ppdZApUqp8mpSiqnxBamnSc+z9YVNYNvNdD4yLEAIWzTJtpoegH1EHy625sueML31RwHh1oX/b59Rh4mmTNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(9686003)(186003)(26005)(1076003)(4326008)(66476007)(66556008)(316002)(6916009)(6512007)(66946007)(86362001)(478600001)(6506007)(83380400001)(38100700002)(41300700001)(33716001)(966005)(6486002)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FoSw4DUyjPH8fwgzFr4s51AVyH1MFzP05c+tWWN12eioM2rsolq4q9INBGv?=
 =?us-ascii?Q?2h2Fvk3XnlXhGbvKxSuHEklq+zAGy+9q04go0OxML7ODVMMztqSs/ugysoxg?=
 =?us-ascii?Q?py5P1h3MG0a4YSY3U+MCLA1DCy8NJODnYHX1Xd17FVB2Q+hHvlBtZGnUlsjy?=
 =?us-ascii?Q?DV/VACVE3klNPzxNqpVFDP7AhxEt5M5d8RFE1hCJoVGVjLjtxVz1vkLZi6n6?=
 =?us-ascii?Q?PddxThAXXoH1/DjypoptjTqJjUlzuO0XLi+I3i8drAiE2R34eSK/+UIKjVWp?=
 =?us-ascii?Q?PE47YorwQCJh2wp64xuXIEoG+6T0OpysbQv7EXjdr7Qv1th5jB/KGqlrUdqP?=
 =?us-ascii?Q?/mds5QFSvjzwgfZH3+pZm/OlsCgFXODnqSxujP3mEzAqtacH2gNx8o9C0qvU?=
 =?us-ascii?Q?5YmWrucXxQNx6VTn57lq3H2+oRvzFJLoUQ7wFtBb4/nQODj82ww5+aZaKi9Z?=
 =?us-ascii?Q?Lb0S5KhsiS8MhlIespbt3mxBKdmJpQkO1Flo9sggnW/rhvfUETT3dzUTtFvO?=
 =?us-ascii?Q?uwFrWKWATSB2Y2TYOaIL9U/tvNkniOYfAsWyejVpAK2e865M6iujoK8ZWHb6?=
 =?us-ascii?Q?UI/u8aAszNbH8NOjGMZziLPQWk0XVSpy1sAhGuhQPVMzywyrr5e5zt4UcgI7?=
 =?us-ascii?Q?K1suOvXN5XU3BJgPEWlqievm7jzetIFpGBNeuoa463rxaTVfxiLwYiqiZ0W6?=
 =?us-ascii?Q?xafP+D5uGj7i/kKXTB0uMzAavyDE0rDJB6kD9FJKNTARM9SmiPKQJKP+ZR5x?=
 =?us-ascii?Q?8+cCT7GNx65YW788PIsDVr978S8YtJAh15ohh1bFBJIhKLh+x0yJsnXevJWW?=
 =?us-ascii?Q?3wMclNQFllxcqo2sVURk3qyFFxiMOFY6SY63zkw3vOkLjP7U+Qk+ZwHMScdR?=
 =?us-ascii?Q?GRG5dIOUmN/ibQouMe7YWbFmBO9BRxyzD7EsZyMsp7/rH/XyBtYyQ+AwcRwO?=
 =?us-ascii?Q?NmOSs7LdUPs5uH4S3DbWX3niBQgYtumvN3CYMsyhFjpgmcOpYaqpKX+wyqQD?=
 =?us-ascii?Q?q1f6XCrQCVZLjp3SETg35FgWp/JnwaFMO5HyaYCFy177762VNPFt1a5DPTXr?=
 =?us-ascii?Q?rsr8AadTN3b4o9mUw01cbs73Qy3mUNnrZ4e9JW3rp0gxgcvPgkcRLQNB+J9y?=
 =?us-ascii?Q?oCLSiiy+idh+PPdmsXAuifGBCs9k4gAzmbTonTa4DMTEBYY9SqIYsNzSmJZ9?=
 =?us-ascii?Q?H9ok2TQqYIwEbUCq+ThaXLBPG5yd39PEmEtGs0Ig770zFSICu5pmsEQc4haa?=
 =?us-ascii?Q?bwJWFZBLuEDNk1KCZIV9y1zkuPuaRDv0Iszg0YEBhre5MMMpwa6vLigNYpVs?=
 =?us-ascii?Q?s8HmMXsrhbqs4b78D3BKawqEBL3M1an3mko5xHGJCUCMMR1kJppMyDwzVG/5?=
 =?us-ascii?Q?aUswfVzRIHlTyfpp/HV4TQ301Wtn2Asku/7zBm5A47S3cffGk//calmLxtrV?=
 =?us-ascii?Q?p3TPOmQfJ3MkcMan0LXwit6hjdiXH9rJvf7c8RlwY6sbwpItKc7uX361PbWT?=
 =?us-ascii?Q?lhwFMYGUF4MAWeE5817SaSG1771rhDk+mhlXtZLssYtv7HoeAj13wA8nJDBs?=
 =?us-ascii?Q?yH78JnZUzzjitd8Nl5+n9MnzdnKDXX58AIpVym6MkdytCJ26JX8RoxxLqj7y?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CPaBwORkH5eDurSUqaeQqU5xB93cMydJ9JxVoMgrE0sz0cnGYydJgWMnUqOn?=
 =?us-ascii?Q?x2XyBxW/LhbVQLXRxKlgjLeKrLJGX/ZS8jYVsJtIHjgqXNs2YhgiXG8GJEO8?=
 =?us-ascii?Q?mYWZ+aii7y7E4gwfxrTXvEaQ5doXzvcmiS73H1eJR+kQpRj92sXmHU+ckxes?=
 =?us-ascii?Q?oxHwgJcuyGQiFeViky+V/TI9PmkBareRLjBbJ+oRaqVas4Maa8xAhR03gFux?=
 =?us-ascii?Q?jKxjcWbA6VwwRpibCrbIeokPH9/8gVgDbLxDLs++vyrjfEsoSVjMZnbHZsur?=
 =?us-ascii?Q?YX8sDnBlPAZnijk4rWpQXnopdxH9EsfnsnBghZR5wvVbpRgvwxx85jT6aTmH?=
 =?us-ascii?Q?/hhJCEKoIB/QsZlslIzboSDBT06MvU1x3IgPPQ47cI25lvAf9l2ZQD2ylljg?=
 =?us-ascii?Q?1msFy6VuF3pwoxB/fVey1Pjws8eUZ5C2aX30vXdCui+KbfOKfdAWpuCz8I7C?=
 =?us-ascii?Q?slAJJaRLQ20E0dW5531ATKn+QKxpaRSfB7ZkUl/g1DLYKjqLx7wHTI1OY1Mg?=
 =?us-ascii?Q?Uu4OFqCNUaVEgNuEPSq8hXtmKgJMWE/HpG2wJSnlXVgAc768wKw0G5yD/Dpt?=
 =?us-ascii?Q?AcftoC9WmlqEmCSrQzYt1PLizhNvVqt6FBRPtE0Wi15v7jRYJkyEqSyLJO9A?=
 =?us-ascii?Q?qJ5pV8RJK0DIRVY4cViUVYigUmQjP030LAIIWP4ZHAdr2v4L52nphKPUVX2r?=
 =?us-ascii?Q?uPTdvKoJHvqG35ANwdOE6Te5+Rb3NJmTPUE2GrnR/5JVTQTuo6ITPFctMJh9?=
 =?us-ascii?Q?N3xo7BMMQ+3QgJsML7jbPcPR0+u021rom0OrrZv37uBADxyg27DZYhfm3e/Z?=
 =?us-ascii?Q?VyDwhPLzz3NFUsQMYU4rxc7s1+kriuiVVlIHu9+2ymp6ugNhy7QpvqJfncXM?=
 =?us-ascii?Q?iXSrq3prjbkMDRPRXuMfAqrmC+Fo0cDFR8+pthTmN4aMsXdY0/l4jsOo3l2o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c274224-72b7-4269-1608-08db77226086
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 15:22:53.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jhxu5Ymx0iKf1VAloMrYZdnPX2VQgXabmVyTlq2m7W5tCLuyY/puZkIccrdUJtP9cc12+T84T11ZAcfixI1t2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=486 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270142
X-Proofpoint-GUID: mBvfnS0xtglP3ik-Oq9vysV64ArQ8S5e
X-Proofpoint-ORIG-GUID: mBvfnS0xtglP3ik-Oq9vysV64ArQ8S5e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230615 04:43]:
> Add fast paths for mas_wr_append() and mas_wr_slot_store() respectively.
> The newly added fast path of mas_wr_append() is used in fork() and how
> much it benefits fork() depends on how many VMAs are duplicated.
> 
> Changes since v2:
>  - Add test for expanding range in RCU mode. [2/4]

Apologies for the late review, other tasks had me held up.

Dropping the RCU flag from your test makes your test fail as expected.
It also fails if we alter the code to not check the rcu flag.  So your
test works and I'm happy with your changes.

Please remove the statement from the change log in patch 4 regarding
testing since you have fixed testing and add:

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

For the whole patch series.


> 
> v1: https://lore.kernel.org/lkml/20230602075353.5917-1-zhangpeng.00@bytedance.com/
> v2: https://lore.kernel.org/lkml/20230609120347.63936-1-zhangpeng.00@bytedance.com/
> 
> Peng Zhang (4):
>   maple_tree: add test for mas_wr_modify() fast path
>   maple_tree: add test for expanding range in RCU mode
>   maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
>   maple_tree: add a fast path case in mas_wr_slot_store()
> 
>  lib/maple_tree.c                 | 69 +++++++++++++++++++----------
>  lib/test_maple_tree.c            | 65 +++++++++++++++++++++++++++
>  tools/testing/radix-tree/maple.c | 75 ++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+), 23 deletions(-)
> 
> -- 
> 2.20.1
> 
> 
