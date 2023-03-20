Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76816C0F14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjCTKiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCTKht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:37:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6128925965;
        Mon, 20 Mar 2023 03:37:02 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K979EM015385;
        Mon, 20 Mar 2023 10:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=F+JHSuoWzOwjk47TxsPmO0wWTIIQ4wdRr81TPfl+5rs=;
 b=HR4oPrst8c0KEw8VYRc92rIZ0eLubee9jSGl50ubo6pknfCCvmiQJaHzE5+tAgVyCkIA
 bUuY1b5guVJX3vUs4CwpB3p6+hJyqewipGpuu7wzIh/mvLLkBoL87iriVzuBJl0pmOu3
 SA7HAetAz1csaG3vXLBCZhyg7O88DRRfPLLtXLbcMo5RpoEwuACMF44PpZMwzMHONOS4
 4ET4dxxNn8Qna/BRiXWJ6xfzza5M9Vuen9AdvPBwic9Ar8cHgfrBoY9nk8MpflPAXpgo
 e79Niep+F9bS6t9D8UrhfksDuWjqm3yznAjwvx7g+NOWrDf3wbWhd1G/1tzmfRdRvs7B /w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bcb354-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 10:36:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32K8tZK8002966;
        Mon, 20 Mar 2023 10:36:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3peg5n3sr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 10:36:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtauZ9fJAkx2pG2F2P8ucCXCcRKt+3uwDINjoGDg9DchCpq67YuvxsTggHKiFzlk4UXyw0oViTo1ZtUysEbJRclkjJaDKzVOQ+FqEbV8nQPNeMEhAgjXm1F3bb0KRsvxoLrNpmQWJZw9LeOCsXgBIXOueK+q892gY6i2qorVfZtP0p8gzQAHl1z9W9skXN1ZlRSCDd2AhWeoia6XbOvCisk/s+WSSnVf77VdUeLs1IEXxrj+QlsYWyNsTH+xEGq0DD3mYbclRpgEFUQDGLX8d5WVaN6teZKvZ/3b76XNBI8PyUtubCwrjDhBegCal+xR7G4T7CaAONhjCaxkUvPkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+JHSuoWzOwjk47TxsPmO0wWTIIQ4wdRr81TPfl+5rs=;
 b=cK3DhSM4t5MYzWWVyClOHNQbI8bI0tg+sogwwJPzpvAsaHoJ3+h7ucferVeGQ3nlbOBBBQHb5ovLfxd1OWjN5K6HMzoR9ozjVk0IBkdwT4EjfKPEjLkRrC15EKRiGuaMJ6MNPYUdUfOYJ1IMHP/e6BOkkr8FYe5IvE2brUoUvVCwL9i9w1Zx2WM9jz3cQzySax6Rj+OBtVAo2wQlG2UyyukUYkvu2L/k+3bd81sN6hg6DErGDFMFpqiqILUBAn+fXz4IGZGrVWHLpetg0Mhz0o/XsNoLz1dcPYjUs+CcL5CxbfdfaBTdH55jyL6m9Ef5BpELCbf78qbYl7OrEPBe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+JHSuoWzOwjk47TxsPmO0wWTIIQ4wdRr81TPfl+5rs=;
 b=yJJ0puY7YiMkMIboLzMGWA90JoXNG7Cbd/szUZun8Fplkn4uVPGd5TwqDW2eDPQKmEjfsbu6mCj6mv1Ex3dPI3Pj6rQSUNVVq5rlcIqCDEiTsZCsiuE+zbqPVyI7mzuf/h/jqRXr1/0Q73JMcRhsfJCgt0EHCnwyDkz3usCgvJM=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SN4PR10MB5592.namprd10.prod.outlook.com (2603:10b6:806:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 10:36:16 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 10:36:16 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 14/24] kbuild, firmware: imx: remove MODULE_LICENSE in
 non-modules
References: <20230217141059.392471-1-nick.alcock@oracle.com>
        <20230217141059.392471-15-nick.alcock@oracle.com>
        <20230314013539.GA143566@dragon>
Emacs:  the only text editor known to get indigestion.
Date:   Mon, 20 Mar 2023 10:36:15 +0000
In-Reply-To: <20230314013539.GA143566@dragon> (Shawn Guo's message of "Tue, 14
        Mar 2023 09:35:39 +0800")
Message-ID: <874jqfvheo.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SN4PR10MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: d0179012-659f-4cb7-d15c-08db292eef7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxKOZsosUxDZBJOo/Im02VhsjdcwOtIeBW0w8AoN6zz5mYbSQX+9KsTGesiK6CB3LVwsYhAAo//xA5avc+JPTRLlRFLQAlV+UTgiQg5RMsRczYjnrx1uf0FrBC5q1ADPVKB/QUOP9tf+NGWTkekE1yf5fB16eprgr/ItyAj6iYKPXAcvtIWuKURz3oVc+My1hqulyV8Eq9QWRhYcdPqI1fzXFkXDm8JatjBbKASZvPwKfaY10JJtbVZkgWxKAJFVIl01zRzxTssCSxOflxzRCJMic2BtK3/liirAyTDEGo3dZ7ZpjHMn/+w6isgKkC+a/nejzCaodMecHrmPtnPWKa2PuOlztKpxzRMumLy6xMaMioFnwUo5CQeN1H6N+LcENer23qrto1LV3I/pxwXlvy6rmaM1/SQ1jDlTMDjO/jUewtLaJ65AH8ciEqs2C7wbokpOmJkKeuhl3KBL2Plmcg7FSOrumFOpoj9KFtHqibieTiLjO9HU8S+uV3DQ+hcj5TumDuqpBj7RAAaJ264dMBeLAeW0QpCLBP2mdThjp/A8Ob8jBnj1J1wK+KTV+cn5bIjuuOtIHWnRVR9qa4JJTIMMe6TDUyzUdF23dV/S+YOQOiH85r9CmIMf6ZAsUPQvLwH5jqoBdbJZYnQBNnJzHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199018)(41300700001)(44832011)(8936002)(6486002)(5660300002)(186003)(2906002)(478600001)(38100700002)(316002)(6506007)(86362001)(4326008)(54906003)(6512007)(9686003)(83380400001)(36756003)(66556008)(66476007)(66946007)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zrh3iXQadEhN7R9SGNNAQzZC2OAGBN/0zLZD+2xZX9NPD6pK5GuGf54te3vN?=
 =?us-ascii?Q?pnDUK6HcZBDekwHbhHnwkQMHl2dpDAQoTSpA2by+bNKiG3s5uOVwduGtdUuV?=
 =?us-ascii?Q?rXiMP4l2kSVv2taqLSYj/v2rWW73/Ty86q6Ocfd2tocLIR4WTWK0lCnbvUQ2?=
 =?us-ascii?Q?xI6yY93/cxHV0aRYLdhZN4pihNGoU5nSQrbYToopQN+zmkYvPGYHNqxHATY4?=
 =?us-ascii?Q?CWeKWLqlaun9tQ2i/ACsMNC7Pgg6zS5Py/Yj91iM99cHuZ/U3kpaOu8r4Bp4?=
 =?us-ascii?Q?L+VvUMgwPMpb6wZcDxqZU/HfPrVtoKLpZZ8XgF6jksbjxIvJ1CbR+qjqCUuI?=
 =?us-ascii?Q?OvDaFYiqIrrxNzj+FO+aWM3TvI7oltKgEwNIsnfenasaPA04pEcvyUIC9aIr?=
 =?us-ascii?Q?5Yl/r9t4V2VtDSTeD9R3YmT9da6gR2d8FPHPCG87AecGrAWHfeKT4AjdM7XU?=
 =?us-ascii?Q?ezdpiEguGLaDUPTtQVMCjESPJFc59ba/5HWD+KfJ2maQZ/2y/+cUSL/VOweq?=
 =?us-ascii?Q?EeiXqexkdhAE1k2xbrg2A8Oqt0KneaJzzlfwkV7GTIPLL859Q8voGtIybkzr?=
 =?us-ascii?Q?QvQeJgsP29QYsOi53YSt7xEL75xHSMbTmLn99w8HZQ37H6e2j1TbkeNNPoYz?=
 =?us-ascii?Q?/pEqsZhbJTVFrLdHO/xQVKGs0/OKLCXJkL7E/Jwru8No5QHjujdm1HClsrei?=
 =?us-ascii?Q?gP28h89WQG/VOIv+hJBpu87UrD3lia9Jw56y3N0F9vdUPORsbN22ODlnsL7M?=
 =?us-ascii?Q?Fn77fw3I1r1QmiHB2EBsyi+3CWxLC6DeKyvoR7ondWAAawn5wWVTlODTuPMr?=
 =?us-ascii?Q?eJwlJrvCreIQboIVnoneOHPTgCQgfJbrgFVSYseEtKqX6zMg1ISFUMSJgDeB?=
 =?us-ascii?Q?9SBN4D9u+fv77tJhjv7dULjbDgjejAffybnZEMKlovRQ0OWaT8o2Zg/i9HKv?=
 =?us-ascii?Q?R4ijg23tY1hRY3/TCqt7NT8pKeeqHj/tHIrVZ5tolhVjRZMB3TRfq8D8OAXr?=
 =?us-ascii?Q?WjnKMIRZjqvskl/t4KisDP2KEVekuDYHEr0M8N+BPirb4UpSyXT71bRh5jM1?=
 =?us-ascii?Q?Olu6puVCPshxMt2an6JG857PwbJqscWZIhB5iITNFT9Rn7w7gVr2v8vxoaZp?=
 =?us-ascii?Q?CAQHKiZowWNUBl7dNrlYA3osowogf/ZiwdvuRu4+hHhnrtupAe2y/6y1WFR7?=
 =?us-ascii?Q?IROJlgtMPzEw1/kAgsPHa6sZzrNJfXRau2+QBgVPQdfk0tzC2f86QlXcTC8L?=
 =?us-ascii?Q?1qO5Q9DxzWrtWlBZQ6G4OCYGO9kJlP+if19EGtU7FhFlJR7BqImo4DHVVUud?=
 =?us-ascii?Q?xnkX8a2g7RHx+KfU2LlodX8izUTcXCPJRvsoCTG37SI76QmindeFu0/Vd7sZ?=
 =?us-ascii?Q?/3MZdlc7mQB4vPqaXNDOCyyE6E0HYOBml6IniH5HyuUSzIuo7XaNo3YGQqar?=
 =?us-ascii?Q?jmrmFS/tfPExso3spXgQVeYiARmeKprCS4QvknVrSkSbgQ0mP6256cobNSGy?=
 =?us-ascii?Q?sqw6q0LkklZz6fbPi1zNgmWxlsRc+CtfR6Rm7/6glkzzhPrewD1ucK9plU83?=
 =?us-ascii?Q?AXNTujQpn4JusectN7jsD9y8VAQWPPSbWFi44SvX4MRC45GAQRpcgV5XiJ8d?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QkfbwmeV5xNzpUY4LlZ+aP0lT2NV7EJTlLBWqe+j074mdm4dtNZGT1dYdhVU/KnPEGO2HgKWC1xQGXo/uJZQ7ckr/m6ub0FncvOvqPBmV/ZMcQ8MrHsO6RNSiryd4Qavs0UGV+DYgUKhDL03WG/ICBOfm6HMBewBauKJo6pZwLsaXgW/6H95eTvgQ6wJDKAyR4C7t6ISmZnjFj5ZHpJiEk3txdP8sOgJDGcbwLU7pph232TPEXPZ2DrG9zkPRS5cK2KjwcSWQsudSDWGBYsgBaSHihvCpeRY4TNn0SuWBVaGC8mOqXDDwJWpiVS4h2D2oh7jXJqM61PgkYIndWzmpBqivZ2CjMo6TGpi5/gN34SjIPAHJhrsyle8jGn4N/BM1om0bdaatpPq1kDOe9cOi0gjfzHHNxu7C50eeS5XoMkVIGn8g7odM8eSvUTFO170qeb7OVcdAA6FYB1gz7gfWO1bx+iSUtu452J34hJzjk5DTxALO0dGoS0NuzaButotRjJ9LeS3xiOpxu6m6/Dq3p5CHidjry7fvGG5pIGooxas7Yc5WRarNStjwJsfl76J+DwjdbKDdDW8ZNWrR7jrNQoPKuQRmTRFAhvB3ywvvxIEdtEfJ0SIXBhUHZ+DZN3l1JuKmO2BN7o3/4y2M0ImyI1nwDnRTgrC+k3ARDwPwbDJtSo8sycY8wwCNLmKPJnVxjWK2ZOdRC+Arg8Y1B+5erg5hqHAYjUyuxwk5D7mU6WILaAE25fWBZk0MGhEx5TPSj1+M2RRh2rJ1kzwljizGy9N4zQoUv4Qcn/TO4y9zQqkMgVxat4agBkbtWlg45OQCTkFop30Thid2JdMQ3cI/KbfDQENg0EBat9twgikvEikY0nCCzo5RTFkKoxOOYrNmA9BO/EPhr/BQDIxPoO4VRGbD/G05rPxqpWlQdy+knM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0179012-659f-4cb7-d15c-08db292eef7a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 10:36:16.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7i3OLJH66BL5cp4Bp+YVONR7VtkWabWH8VVAUps7SnO+Sk1O0hdcn8Xd1aczXzna9uSno+Td0RgDvaNi+taOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_06,2023-03-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200089
X-Proofpoint-ORIG-GUID: ZlcPMnowmP6UhhP3dES4cZWDUEioij5q
X-Proofpoint-GUID: ZlcPMnowmP6UhhP3dES4cZWDUEioij5q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Mar 2023, Shawn Guo verbalised:

> On Fri, Feb 17, 2023 at 02:10:49PM +0000, Nick Alcock wrote:
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>> in non-modules will cause modprobe to misidentify their containing
>> object file as a module when it is not (false positives), and modprobe
>> might succeed rather than failing with a suitable error message.
>> 
>> So remove it in the files in this commit, none of which can be built as
>> modules.
>> 
>> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
>> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
>
> Should I apply it as a fix for 6.3-rc with Cc stable tag, or can it be
> a material for -next?

This is currently built against -next, but Luis has indicated an intent
to pull the lot in via -rc3 (hence my scrambling to get the series
polished up for him, tags attached etc now). So, er... yes? :)

-- 
NULL && (void)
