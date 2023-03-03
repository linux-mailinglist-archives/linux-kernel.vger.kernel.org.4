Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984306A9ED5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjCCSaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjCCSat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:30:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBA14E82;
        Fri,  3 Mar 2023 10:30:25 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323INis9009419;
        Fri, 3 Mar 2023 18:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=RHtBYmbOj9DqG4v5R26KSbS0WcmGmIiZqOBtIrUIAqU=;
 b=ifYtyCLVdKHhwBYuKB81HLIDUQQU4uRywD0CtKVSj3Lb6fQY8ciDfdyrQIV+oOF2SqCB
 AInJFYpg96D9tFdB9LhO1p/O5tZdFgrw638SZSYGRjmYIihpFw3X3IZ4to5fJrz/4R+b
 IBnsEggNpcxKzR/b8TROUalP4akT0R8WJWVmq73ThpyF+NYmK3hP0SVBktkuC2hN+ihr
 INQzuu87FzUlHJBZVboOLngNwx0WqBbLIpeQiU3XaSLZN61caWN6ZIoNCvlu6lPdu9ae
 9U+WhKEbv/n1Qf/+zrNv/OKF/n+cOV/7TzDmVxQtx/2eNATpvDdme5OQm/SXwJSoCEgt nQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wy35c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 18:30:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 323HrbtZ000644;
        Fri, 3 Mar 2023 18:30:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sbu0dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 18:30:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqb6tBfmQuh3Lx/ZMPytEwgArf8USjRwbnA4ofArYDW8XmgtrW7L819glMWoDtP5CJPqGDy/VhXSswqShEClasJsIzYFakds7k0ZooMcjaeJszp6tAMNEdFDTi8XDG8JqfGMTpB4ncdE0a+EBR86u80aL+zTumWJWOTia13k0/JBak2hU/orT412wgOl4tDC5NZLNRuD522OuLgwCcYqyCDSp5zXzD2YpjZDOmOGz9dnM9DASRGffCWltG/84tjzx1ZPKPPh+/QMXSlwk9AWJLKBTsZsyK9gF5i7+BpVhV8T3HlikCGnvpAnt6WoPG/0Xi8P8DpqbyDeYKR2+7dfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHtBYmbOj9DqG4v5R26KSbS0WcmGmIiZqOBtIrUIAqU=;
 b=AO322UvHz1WokBp2X7EjWThVXSbhukhZCqPZb/nvAYyiIWhiB+Z6bmSRLqE6fXJICF0Cfv4O9PN701tZ7Zapkw5hR2tfAq2DtmfArASvGJvyoglk/UCjUHk0rWcmu6PsPb/yytvbANkg1qz/a4BIB6JWg0ZTP44mC8xN3VUeA0g1HshXI5Z3270JEY2HjFtIs7WRdbofyLalxR/IGgcuL9ph0g+z9w3F6iI/bwNPqhR12A9gX0fiDMn7vGyrVYiwokFm34ALGJBeQHDo3OdHWdS4U07ZKuHgJ9+ffKhl7AtOt/IiC1+iYDw30ZKRHQG2lzcdoiqM0Bxfv8p9zmMSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHtBYmbOj9DqG4v5R26KSbS0WcmGmIiZqOBtIrUIAqU=;
 b=TbqQt6cro8fHHGoFrsU0/z4+aFBlRO4swKG/k3xvrkyTt7nkVhS7FsHMDhsfjklsRTPjSY6t3iDZvaPeiAeoXE1wGVcXACxTbmQ4OHDrxLWtuK2tH1eGTo7gVlu4AaU6UdylNuZKm9fCh5HHp8V/7jVIuuHxGrIkzyV0yjKFoJw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB7470.namprd10.prod.outlook.com (2603:10b6:208:453::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Fri, 3 Mar
 2023 18:30:07 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 18:30:07 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 13/17] regulator: stm32-pwr: remove MODULE_LICENSE in
 non-modules
References: <20230302211759.30135-1-nick.alcock@oracle.com>
        <20230302211759.30135-14-nick.alcock@oracle.com>
        <ZAE//jJ0GHvLN1m2@sirena.org.uk>
Emacs:  it's not slow --- it's stately.
Date:   Fri, 03 Mar 2023 18:30:02 +0000
In-Reply-To: <ZAE//jJ0GHvLN1m2@sirena.org.uk> (Mark Brown's message of "Fri, 3
        Mar 2023 00:31:58 +0000")
Message-ID: <87fsalbsd1.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::31) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: dab222a5-c8c8-40a6-7f79-08db1c15502a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7lDgqITDG3nh9dyoSv47jf/5adwxg/aA3jrjo9wryei81pHg+fUQb43Et90s9zZ/u2AB0lIsWE4+0X3cDZO1/jlagSbrhKGHpv1Cwr6/lgkSwm90rmzZpnwF3m/0zEgwU6VnB196wrl9NK9EoGc9RrGlstIqB4htk6zqn+4k+nJHGTJA/FasumzPpRsgUnEYG2i3bDjNe9ktrnJJ0KDLRtLO8EA+CYC6vIXg3z0kS57gjb8gi4cRwQIcKnxpfsfnPUXnvH4KHykOXr0chauyqeWio5reMJayur+Drqnh6+Iw+2BSjOB9vexyt9rrImUSvRevP4s92ISz2nPOiBS5JZ55zVkZy1LbDQx5qWUw8pF3yc5B3sPMrP1v0qMo7sdQJSuMrwl/hJsLMq77NZ4dC9Z4f+ea8lY7RVQzwY2k7VJaxYLb8CNIuHrGdOAt8+jg6Kk07CueuGf3NkUgaKFrYyhPHanE++GRRTCS8ENbPEGc5jR/EGPrMOb9zgppoET52K3/vyBubCR8gZlphqtEjfMmxtNkfuaO1dUZcw9svVvjDIAbzJGYeNEkhNVU0WZs6v26sZjDL4F/kOnZIzHHET6AV09YPkjwW6HBrFwsA2uoWGJz3dnoPBr6weOEwLq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199018)(36756003)(186003)(66476007)(6506007)(8676002)(6666004)(6512007)(6486002)(9686003)(4326008)(54906003)(41300700001)(316002)(66556008)(7416002)(2906002)(6916009)(38100700002)(44832011)(478600001)(8936002)(86362001)(5660300002)(66946007)(83380400001)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oVA42tBWJFPRmWL/+K9m251I0RKUq+8NEbQH+MPCDJhz6AXr+hCJbhpHbZM9?=
 =?us-ascii?Q?A2b1yhghBzw8IZrEG4asCEPRqHT1StJf7vfHfb2DG437pgmwDCtHCB1hPEN+?=
 =?us-ascii?Q?ZOfsXUvM4Nvmt9u51M7bd+FwfPnsVVRzb6FlACtWqrn1sQ9hrmyJfhxExQGt?=
 =?us-ascii?Q?tbtrOXZQdUFTDiJkgd5Tv3NJpup3GG3zd0/kAWUdFviPhk3z3O3+lF9rhK8l?=
 =?us-ascii?Q?TCVzEycB1zWgTpW5EJnGfRsHwH9yFIy5MpsEhwmd22jXpdgRa11PQl13z2LT?=
 =?us-ascii?Q?p3KO/5JWPM7Kvezy6WYRc7gzYIa+WeycG78+EBOHSFy0vTpWhlTNFLdZT3B1?=
 =?us-ascii?Q?prbPGhlNGj0ae/a5qq6ryn+rzLaz+R4yK01nrb77jciQk5CcVBitdEqJAICp?=
 =?us-ascii?Q?EKYcjLJuCStE2BXxOdzw5sy5e3n1UfRKYIG/RAwbZmdgcTRYuv8xlupVSHi+?=
 =?us-ascii?Q?F8CPL972r6ZzAzQnduLLw8MgAYc1hTsY8mXTJ5omxFuZygwUl09kj67Yvl+S?=
 =?us-ascii?Q?KhHjsiUbrVkPhY8EFJn9e5wzIOgGcmygnVX0gz/47G5P2T//X18gJrGf9uRO?=
 =?us-ascii?Q?oa9uSOvBj0U4lgz5d3qMuscDqj/D40HnFaNrmYbyN8vyLUQPKxEhX+w3AN++?=
 =?us-ascii?Q?4dnXtWR1S/UDeueTIr8ZjX0NmyHEnopziL148Xb3tWrtgGEaPFA5nzYW9cAx?=
 =?us-ascii?Q?pu1zk/i0ePYzN7MUEq8209t8YdlDQXQiM4bcddYenWv6JpTnwz6wCuEVaH9L?=
 =?us-ascii?Q?Afm8hTu4KUbfKmLNLCbxGLITVjh9+1SUTg6wbau0zWx5RGwPHQwCkt2GADfX?=
 =?us-ascii?Q?8BJLBuUeyEUqhafS3k+NIaRbFdzFqJRZFlE9GIXF3HllMo+eSL2VF1ZwnZGc?=
 =?us-ascii?Q?wEU+LGT7nZLthT/SC8nbfoi4iBEwOYUE35BC5QGNYJSKuSr6SIu/2uUl41jl?=
 =?us-ascii?Q?BWEVZ4YoZ9osMdzzFAaaAoeGcnDYwdG4PSyT8sjGLOAiVXCLIj2ehbzD5DDt?=
 =?us-ascii?Q?bfibCWmovPNXlOZk93W1Sl9O4n/7Ke/ow2mG7+E2M2UI0VA+/kkWUU0DBByY?=
 =?us-ascii?Q?c1QMKhxgSUKZ2IaKy6L52c6/9vCWgnjG+sGYPOcJLooTxmnTcaslG99Vbf6q?=
 =?us-ascii?Q?ZozUr3L4uwmCg+KXSiLPeN+S6Nu5uEOq32WogqhLh1Dqb0NbCh7xH0t4tB4U?=
 =?us-ascii?Q?avUvxtNL+TUFKdZb3jkPkLbSTBq4g3NIcugkq8GQm4oXfR8vEXyj9o0b3Hmg?=
 =?us-ascii?Q?TqWakWJcr6OuSsLqWZPcruxWPohhkuBfXNUEry/WQik83OdNP+HBo6D0y8hg?=
 =?us-ascii?Q?wLmg4jSBTcgq6fUhwkhF17p0p9mk7lzG2uW+3y5nnoXSlpuUwUf9jTQq09i/?=
 =?us-ascii?Q?S2M9zha6FMpqMz581ybw1LzvaPMxt2f5Tzwke+sBk+wclDb1L0VG4YBORht0?=
 =?us-ascii?Q?EyKyF2QElIYhNZ6k+EJ4MI/zyaRh4MUdTWa7LTbLTRzqrPkABfz9Gb/bnghs?=
 =?us-ascii?Q?eYkcLNHfjxrm3eaAVY1RkThEuwOO+wKjo9YVSUvMX1VBtPA+eOHjOwHRjqJX?=
 =?us-ascii?Q?ae/BpNUPMWEmLtN3iIMuL7lXV+jC4ylMj0e9sCUno6efKcGs2i3Z6XtbGVOh?=
 =?us-ascii?Q?Vbzeg0Aou4WxMTXbSum9URY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HkgCROgNyZ3y0CPamiSZDM/aNccdu0bIGoIC4KB3GF8DtqN+Fz6bK6um+H6Q?=
 =?us-ascii?Q?hObXT0Cg1JNzsZr6TXNH8JYHvUQIWQm5cET6554Bvttshu0sHN6NFCvJpl3b?=
 =?us-ascii?Q?Zj6ZHWmScY5iYgSChC+9jBDHzt4DV8syhf+JIYXg6VEAS/lLyo5vlqHcH1zO?=
 =?us-ascii?Q?1naVhqcQwkGElYViY+a12B6xovLKmRa9qs1uVOrh1wFyYUjGnOwtPbudnsF3?=
 =?us-ascii?Q?sjAd5izJhnhHzxYUrB8BV5iFr1/kDtN8sR+B6m7umg/b77lX5N8iBFfOJiMt?=
 =?us-ascii?Q?lits/a1k/YeIcCD5QToUCiw8CtMn5FooflZVzkRQ8OMhruhzb46aPjDha/Nr?=
 =?us-ascii?Q?NC2CANuAOyWZWNP/O1We/kr2DA46WwEPGNVZO5TAJRlfl6ST0D30wbstVYtS?=
 =?us-ascii?Q?q3R9imYRczxnpvsK7zo7nZu8713dcL3Vs+lqZDUvAN3enTScZiPV/b2alHzA?=
 =?us-ascii?Q?kTBPPR3b33+g53CZFceSBgmPY+bYYKla6XJAHRln9wnL8WDoCRL9P0hCGBF1?=
 =?us-ascii?Q?WIQeYSIzYHlBiPxlQDS3xZRIlZd957Q859GBNJoBMBKFvxRBztHWj0iVNon4?=
 =?us-ascii?Q?Af1JKe4ymSs8tXUiS2KnIFdKjlnTKElJggiYCfkq1xNgXB0Hi3BGAGbnH3EN?=
 =?us-ascii?Q?4tqpi2r9uy4hBJTD45FEqTsAqPzGq8tTUrypsDIjV1qZC0TFFGLf24bE/QBB?=
 =?us-ascii?Q?7NSkzxsjO6klTdoSsTaO4NcT8OqDQPUKbK1pf4ZTKPnJ71bTva6xATItFZS3?=
 =?us-ascii?Q?tt9cY/9y8OW9wtHIThNs8JfvCFPDFESp1nBy/p0H+7Z6x9hvFajqDwEtfABU?=
 =?us-ascii?Q?a/JKPO1mbm+ZUOUKeMwW47zDct6QQ5/tGxtCn3c+MGTjyc8Vjp+lJ89gsK9Z?=
 =?us-ascii?Q?Lp071Ius+3QwSDgsIFcowBlMY98RPx+Zy4ShhzvUwiPgMJi037IEzl3JabOV?=
 =?us-ascii?Q?5v+FCKHuUFs16ITKLxeRo1wRudPZFWCGL6Wn9Fle5y3FVRHClj++pUdD+A+U?=
 =?us-ascii?Q?mtrf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab222a5-c8c8-40a6-7f79-08db1c15502a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 18:30:06.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU6KtgQsvvuxvqoxucJRloe9el4yqBljGMq7jJZc324PPZVMtzEiV5sbPLFroh92iCwCgs9h/N4FI3H1Spv3bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_04,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030159
X-Proofpoint-GUID: lmsT7tD-BQJZgZRpXGzx6Bv8lZrXJ-G_
X-Proofpoint-ORIG-GUID: lmsT7tD-BQJZgZRpXGzx6Bv8lZrXJ-G_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2023, Mark Brown outgrape:

> On Thu, Mar 02, 2023 at 09:17:55PM +0000, Nick Alcock wrote:
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>
> You've not copied me on the rest of the series so I'm not sure
> what's going on with dependencies.  What's the story here?

There are no interdependencies in this monster: it's just a pile of
individual tiny machine-generated patches, all doing the exact same
thing, and if and when they all make it in the invariant will finally
hold that all modules shown as 'tristate' in Kconfig will have .modinfo
in the resulting vmlinux when built in to the kernel, and
modules.builtin will report them as built-in; and nothing which is *not*
tristate will be reported in modules.builtin as a built-in module.
That's it.

(I don't expect them to all make it in in the first attempt, but I have
a checker which I'll run to figure out which ones didn't make it in and
try to deal with them, and run later at intervals to figure out if we
regress and fix any regressions. The only likely type of regression is
MODULE_LICENSE creeping into non-modules, because things that *can* be
built as modules that don't have a MODULE_LICENSE cause more fallout and
are spotted much faster.)

(This is clearing the way for a later patch which will have
interdependencies, but which is thankfully confined to a single
subsystem so everyone else can ignore it. It happens to need accurate
builtin module info at kallsyms-generation time, and this is the way
Luis wants that done.)

> When sending a patch series it is important to ensure that all
> the various maintainers understand what the relationship between
> the patches as the expecation is that there will be
> interdependencies.  Either copy everyone on the whole series or
> at least copy them on the cover letter and explain what's going
> on.  If there are no strong interdependencies then it's generally
> simplest to just send the patches separately to avoid any
> possible confusion.

The cover letter was sent to every related mailing list (or at least it
was for patch series 2 and 5+: scripting problems blocked 3 and 4,
sorry), which is what the LWN article on big patch series which I'm
following recommended: <https://lwn.net/Articles/585782/>. I didn't want
to spam actual maintainers with more info than that, since presumably
they follow related-according-to-maintainer.pl lists anyway.

As for copying everyone on a 121-patch monster like this... well, I
think everyone would have wanted to throttle me, and I'm not sure they'd
have been wrong.


Originally I did this whole thing as one massive patch, but I was asked
to split it up by subsystem. This yielded 121 tiny patches with distinct
subsystems and Cc: sets. Sending a 121-patch series was my original plan
but we talked to people first and they all said rough equivalents of
'god, no' and suggested splitting it up into a bunch of shorter
mini-series to reduce the load on people's mailboxes and brains.

I don't think anyone has previously suggested making it 121 individual
patches with no cover letter whatsoever. As it is, those series that
accidentally went out without cover letters properly Cc:ed confused some
maintainers because of the lack of the cover letter. My apologies.

It does seem this is an area where I can't please everyone. Some people
don't want to be Cc:ed, others want everyone Cc:ed on all of them: some
people want series, others want individual patches for everyone. I can't
do both. Sorry about that.
