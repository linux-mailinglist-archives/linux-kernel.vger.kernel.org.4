Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A93660C3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJYGbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJYGbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:31:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AC410EE67;
        Mon, 24 Oct 2022 23:31:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29P0xnnu032293;
        Tue, 25 Oct 2022 06:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=5T4ify3WmvZgTrJ7n9ITzP6QA26izV7CC/MwWdD4vvw=;
 b=0NcHY+x096N81KatnKhM5bZPv0mHpyQnPnUei++7ijgaZEXUX3duwaC+akCXRcR+mRir
 RJnN5ZzR/u/hZf2j6DnGmxh6F+jKt/SNpIY0AhJzJykGBxBwuvogIq0OVpkvXJcf52hG
 30o0u6UwNJQEU1KkR4OpyDL3w9YKCwbeaz4OcHo3luzo6ZLr/zNlqjixS5E5kZuPzdE5
 sQ8g6x3PE4NBpf+lWTR8UaVCiU3tv31dE3e7z0ODlWd9XyvXzhuMfoXADmI4IY2LfIo4
 shN7wGHpuUmm8DQt/Wm2m6g89P2WF8l/+/JYPA6ZdzMcj6D5nA7CSXo7dqL/jIQBo7Qu vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc84t0v2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 06:30:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29P5tZcv032082;
        Tue, 25 Oct 2022 06:30:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yam0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 06:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj5mqgMksAwWIemOyaf1+NKx8hs0LuoYtRT1bZRtGiQqHRxnLcveQ4dm+xJ8aBWz931JMR1UCLu0ttv+wFQgzdi0W0Tkb/u277cPmXQE1qRM+7b5IB2mQ1Bs8hcVa91OXXJpcUybOImGe+sLqILYWSrLvmSNqxmYe5yWE+ErX0hZVzV13vku1bMObrCyAQhJl+vZvk8GwXySxKO4PM55XIZwj6G7nXTN8uNxWItwlxGRqGPCZn8Y+KaeMuca0VL731SN2NNlYGtkSVyS5Zf8oor3p/S8vlN4kc5uzdICcjIrx8q6ZF1ddd3egqW3f40EsBEjY91SNQTtvkfgLL5p+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T4ify3WmvZgTrJ7n9ITzP6QA26izV7CC/MwWdD4vvw=;
 b=NNpJEvc9Xe253pflvqVgniVGunmpbA71+KKRaJYmLJj4ECi/7N2OyY7vDz0BtcPWsSpMEW7VIbX7NmsCnO6SFpCbPNeCtE2R9e95nme7kC8ylxMd52IdlZIQFowyPxXj5Dfk7dHn9kRcE1OI2Vz2y0bzqO2SXe44oAVZuoleSAVP8+Q3eAMS+WCO7VvCuv47JBQ0+bHB65EHA2rad6cYPFE8VpcFedHvUj4100COS976m34ok6eVH1LmZfHdaveL+7DOxM6zhZl6JO0XHLuk0UWIOX01gVBdCB3T3IvRDkIZXC6INU64N13BgT9Q3EBT9s6oxtFbxP+K5cCSvALbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T4ify3WmvZgTrJ7n9ITzP6QA26izV7CC/MwWdD4vvw=;
 b=om2vjUj1BBu/Pz8z/VY6WjG4Ix8pizhhD2gH2u+NRWLS2aNxDUmJfsS/CJN52l5QIsNlC8ilT+M20Q7BMeoMkVRnpN1zQvNSDUyBpxXeHWt26rv0c0KFAun+zQRClmeScou6O9i9gtrV0+Kh1E8suXYTwMhczy+vLWOcB+uQGZk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6531.namprd10.prod.outlook.com
 (2603:10b6:510:202::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Tue, 25 Oct
 2022 06:30:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Tue, 25 Oct 2022
 06:30:43 +0000
Date:   Tue, 25 Oct 2022 09:30:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] media: cedrus: Add helper for checking capabilities
Message-ID: <Y1eChJS/0aEchtpH@kadam>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
 <20221024201515.34129-5-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024201515.34129-5-jernej.skrabec@gmail.com>
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH7PR10MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fd1c70-658a-4824-eabe-08dab6527179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdwAGerRuNGj3uybqxAsvlFAIka7gESjL2dgJ3I/GoKZc5dlbYYS8nf2k0R8z6ZoWh8Et/aeLhWGIGrjEFJvShE4eVdY5lUC6MNSQ7ZRrETVL/yeZf4LutcJh9cPnG+fTn86ufRv2hael4tqiKyxKJP0QG2LDa/LeZrvF8F9ysEpjSfNKHWAvac/lHcK0c825+Uz3qoikaXTbIvvFulAWOc6cX0p5Sb7yTETl80THbaPpUb7x8QGyL/e2q0J++pTFMBf4d69U81wrUkrPf/nSP+9Llosgeh4zcA/drA/nm45HueUrgCmYJnWLsirwsH9UnIaYVyeXFgcG703uIW2zRsv0WuDa+WWE4Z84AgWrFPcjU0VPyb98yj7hLyi9q+63J8ifDqr2V97X5IGdDEOua4X/qLDZR2a89g8SP4i6uv3IbB0b7er47UbCTaTC+oA95hf60REexdCm0r9h5cUg/VpEdeL0I1DhszlCZfuaseXSv82fFZLBmfWg2plg5wOIMoVvA4E9s9mUrtKPZQRiAG5mdgR84oIuIa6/PqUWvrYkqgUKvn+G2wjYCMOeRPe4+pLMXHyaYP2CLRSAHU2DP6ROCPxZQrw/6WEtYJ97r+Cm3YhZIaX39q9cnJOPxIGnbfVVx9UYmPqcEPh+p3qG34PpBQCcfCKqJMsEZib/0rapSt2DQA8KkZK0wMt2A0qs66acZrsf7H1yYMe64RTsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(478600001)(6666004)(6486002)(33716001)(9686003)(6506007)(6512007)(26005)(8676002)(4326008)(38100700002)(66476007)(66556008)(5660300002)(66946007)(41300700001)(8936002)(7416002)(186003)(44832011)(4744005)(86362001)(316002)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X7T9Hzptywp3UFpQW5WP0R4OYssWpleChV1ROVYoV7rL+/q5SZ0x6JD00lS+?=
 =?us-ascii?Q?t7IJxzV3vyzkOpJywvqkw4tlshGLv9M0zCMWqgOjxIivOMIiIBuC9mx8Ouha?=
 =?us-ascii?Q?z4ot/k3FJLFgMSD73vJubcQzzuxYZ/eE8LGq6gSOT0wx1z75CSntavbmw3G/?=
 =?us-ascii?Q?KIjG0/9p6Z6X5clTfcOy2ge/2bCnIxf0fSw/dHI01if9mnsUfU1h0cj4zqfn?=
 =?us-ascii?Q?CO1zOXGIFbfbOXjmypZuUP0TcaBBieFqSR4ZXy7UmOcRtEUwOg++nqolAwr9?=
 =?us-ascii?Q?SOxtOjRcuE8EGfZkyVXRBYschbPfOz/IkwuIHEKrTamOVsM3BQtwviRE8sBB?=
 =?us-ascii?Q?h0KRoa9qJib3JMBbh+bBD0BTzbx+RxWqLu5a/sJPRH+39TCqK3WVqYnEKihW?=
 =?us-ascii?Q?bT9/k9VcZxu3zV3KUFYH5ewAut9jfImpgeVYWK+AjU4LTNdyt4IyvbxaTBrx?=
 =?us-ascii?Q?OyZ32ZANnP4tr9m+rs60adDm8Qjkdcd+HryH/vP46OirQWj4o3FVh3RhYLXw?=
 =?us-ascii?Q?/D+zVbCG0indoAEFpB6D7nHNC5BMtvw4lRB2RIvMlVKezmHKxoQE3b+5E7EE?=
 =?us-ascii?Q?U5RJaOf7ZJZ2x7avry2pNlyQ2/rpIaiMvaR/cO63aH7S1B1JnGNAUkGo6yjj?=
 =?us-ascii?Q?ia6zWRr8aaF8y5PEZIM6goPK/XoHGfU8s3BaJIuE4iRbznA0QwZfbnQzQ/8N?=
 =?us-ascii?Q?gPGRqV7qEPmY9/3ZEIzjKWtVAcvBkagDP5qSmQG9cFoprsN03HD3reI/nm8S?=
 =?us-ascii?Q?FHUuVjNoPCOgjIjA/5qHUj6CaGJ+hwY0NwacODb4g6UHusKyeC50rmS1nhh1?=
 =?us-ascii?Q?JWgcjOU2gYZcgMITy60idhr4FdKWLhR0v1nVUtAIpwkwjLvnAGiApddDx1bi?=
 =?us-ascii?Q?WH/GHubh0xUbjxbotSrJoxYpFwaYbuX2nbymkmKdxcfHXSeNcUIZl/qnbPn/?=
 =?us-ascii?Q?rY0RQu/4rzJaDCtPU8Nn6EuikCC3pXpT5FQyGao73KUOw3+3IEknmP6rQ9vL?=
 =?us-ascii?Q?Krbg8QM452RTNqFqp1PwP/5AbrnPA0o/xg/06zZlgl+xr31v5ii4vniqNwLr?=
 =?us-ascii?Q?S4v7uVt+i8Do+dq6gOBMUueA/+WwwXxCossVcplIOcJdtbN67fbpmhBIc4Oa?=
 =?us-ascii?Q?3/wh62+yOHcigTLODbexHlCAFX2m0p4bvYA7F67ES0wiU2yZFHiYrjQ83PrQ?=
 =?us-ascii?Q?3k1Jf96cBaj8Pw3HFihyqNebG031Qun+9iPsPDzqBGc/nl0U9VHWBmsi/ZMT?=
 =?us-ascii?Q?Ma2OJIXVAWqVMdjDJo+tPKblGU+KbthzjvHRg3gfoBmCGEBkLJSmnxIbkY4Y?=
 =?us-ascii?Q?BBYlMuqiEibKZLWS6yHjQdq4FjeagvhvQfkkcjD3byOL75WodDv/Jmv+n9IF?=
 =?us-ascii?Q?WpKTOegU6L4fct0u7zmoSCO54bqgzhf+A3iHExY0w16mXhpgUXCz72tNhpem?=
 =?us-ascii?Q?sWWcn7zQVK+/lA62W4ncE2EbIwVfBGapY1fiI/rtEMsBVK4sXaheO0rX4Mjb?=
 =?us-ascii?Q?Oysy24pVcTtEiWlzs4tEC6IqUOiHr8w73Q2Bkhw6bSO3ap2buHqkR1Hc6W93?=
 =?us-ascii?Q?HMHup5WFMoVitkhGels9D+JqjAwnAvhyYAwZH+qEDLoQvMywvNUDTj3r9Uor?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fd1c70-658a-4824-eabe-08dab6527179
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:30:43.6391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/L5LBWd6IkwGsmwnAJLj1zvUw04RCyyxr5JxCYQvyZUzFIXa37Y9/KBzUAv0gOVCInJjUowJgZWUaJtP7JEcMzGolDSM5250Env3Ur5ciU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_01,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=907 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250036
X-Proofpoint-ORIG-GUID: vT1g5M8MwHKfbccVRQcjqyWGbLmdcFNR
X-Proofpoint-GUID: vT1g5M8MwHKfbccVRQcjqyWGbLmdcFNR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:15:08PM +0200, Jernej Skrabec wrote:
> There is several different Cedrus cores with varying capabilities, so
> some operations like listing formats depends on checks if feature is
> supported or not.
> 
> Currently check for capabilities is only in format enumeration helper,
> but it will be used also elsewhere later. Let's convert this check to
> helper and while at it, also simplify it. There is no need to check if
> capability mask is zero, condition will still work properly.

Sure.  That's true.  Out of curiousity, can cedrus_formats[i].capabilities
be zero?  Because it feels like that's what should be checked.

regards,
dan carpenter

