Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D293464EDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiLPPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiLPPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:22:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117A9537F6;
        Fri, 16 Dec 2022 07:21:59 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGF6YQI003780;
        Fri, 16 Dec 2022 15:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=CDRDa1sXDUKp0YcdVNJqTugRxEPCrC73GgC3GGuhe/Y=;
 b=wKzcx+pn4sJrc7Jp57sg7L9Q2P6N8rnboR1oDazFytnFd0FD3OO3wJBqz+1TGipdbs3T
 MlCqyVdWEISaqcTLFvclxwKOcoedvPR/cVl95gq9WnSEw1Oi19FJZdEXiQzUXVjhD9Al
 o5wpADXRgYFmBIGLg95vHLroEMW+xXJlnefSUzRt38t79yizCYbSUlLB/IjEDjy7Bs+x
 vDFmtwDPisi98qG8cU8Kp/flPpwmB90kRR9OCyH/En71TLh89UtWEMFyQbGuN+gnZcN9
 3c9pcDD6didw6i+84MyyHbUWrGTWZoekTE7Y7CPUHi1n4b28+4e/Ji0PNQyuyRvZ4ubS fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeufq1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 15:21:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BGDau3W034926;
        Fri, 16 Dec 2022 15:21:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyeqn1jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 15:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnQx8Z73NS0tbiqqrPsgGmWsPpBcxQx3n9tBxrDC7hhX7+O4AQmlPKiHbboYlKWxxKlrqSjitFoZkaf4Ppmw7p8N4szRQk6q27swVGrkTlvFLDLFiGnXSY6o1VHQt+76Iqx8/ahprV7oirs24yg7ViDO1B+aR+mFFLz9TMiag4FR+xliuwSg0O67BX/WiHgssXldk5A8INWFdrydr3H+Ef9EkKGMqsl4VjM1mVrJmcUpQnsvBk3xOg5bjBO1RwAbPzLkXfgdPSsa67+aTElALQNqmBKz+X+qVuOh/SugjtsOC8GAhLfTOZbxqvEXkU657oqOCMPPD5N8ekpaLfZhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDRDa1sXDUKp0YcdVNJqTugRxEPCrC73GgC3GGuhe/Y=;
 b=LO1DfR8zom3G3L4b2aqN9VxXwn0UBWadT409dgS9K4F5WKuvRckw5uZr+DZBy5vfcXjwpFwVdZID8s5rwIkbN47xEkqH0zYSndBwiETWapo5xwGN/nXEiEpDMO3iVrXH1FGp4JEHHASLzcotgENKl3Wbls+rhkHZ4Gg3vZSTt4nvxg8kCB4ES5wekVGfdImLtLTfo1LCLbdyIo5K06cG7VlECEYd5k0xEF/pmsqmiJ37KntCNraAClDNXIr0ypomdslUuIAa+gjW8vG/8T+aHeid8bSvoh3oxYWHPMnO3jRSi2YktOv59v0LXjfzESM0yRAMAcB2lIhwkuJ9sTLnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDRDa1sXDUKp0YcdVNJqTugRxEPCrC73GgC3GGuhe/Y=;
 b=e/mys5Fw4y5K/MU4FC08jayCy+lPH0+in0XoRl409raz1741oD6FotHq4G/rW4jyfKQ/aDY3vD6YbIyyJxY7b4H6aqkwb2Fm1mjq05dJc7GqJEqbwPJ7p1f9w5Orw3O5BPWVuX78gk5fMgOJ/OcZ32+Pvy8Q7Hetb9wgZU6G0bI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB7214.namprd10.prod.outlook.com (2603:10b6:208:3f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 15:21:49 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 15:21:49 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PING] [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
References: <20221205163157.269335-1-nick.alcock@oracle.com>
In-reply-to: <20221205163157.269335-1-nick.alcock@oracle.com>
Emacs:  the only text editor known to get indigestion.
Date:   Fri, 16 Dec 2022 15:21:45 +0000
Message-ID: <87a63ncr1y.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0307.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: d7899980-760d-4509-3648-08dadf79407e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTVI7ELVa79VnypQmqhxrnJjQ1AKlVYTx7BkbXYJd/pRnK7Uo36fpBgeIAP05YNvMxysTwATScIFFipxDL6PgdkjKMErYFPG9xKaFmXcHVixHI6pOh/3Z4OzAjOx0PHblqoJiUOBJWI+hdVMZ9Qjnqx4kfGs6l6x0e7xd373P/Um5q3EpyVzOZ8eK4K/AiVnG5QQGVu047bdRU4ZTLsQz0L88T+68QoP6UgL3Kr1VbDszGbJcYc74k+pxClCvWvIu27VxRlGmBOdsBvJ7fOnrgn1Cah5l79l1XZWZdFgFmHk/lo1MbbgRQ3rm1Uvpx4NlnoedmITUJQ5aarS7FlyKh5Zf4ueQWwKz1SC1bqc0kENAjYqQPUdKISSq6BUsFiYFlNSHZPHJvhqlXwCldn0WfBRLkbsfEdTOpcCN+DlcFpPRHJCLBW+0L7P3uXVnU91NV4K8XWvGQYJusYOk6syfcJeFtliiVl9jTUp3sk9uZPvSFZXNi9bst+pxZjA748JYC741U5tDv8QpnUbImzqcwQXNWiptGXaE62t4JPRnn8QU29BF/e2O3AZLWT1hsjYCsYbNYqc91aXNXygGvzESdqOzyD0yc73tBu3Gsq4uOUpEI3pLdBoLdmRMg4sizKf4MMSyaAnGlt4uhs0kFh5WlQmguWeACUZz+be9C4ht6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(44832011)(2906002)(5660300002)(316002)(8936002)(4326008)(66946007)(107886003)(66556008)(66476007)(8676002)(36756003)(41300700001)(966005)(478600001)(6486002)(6506007)(9686003)(186003)(6512007)(86362001)(38100700002)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vW5UdLW2riNHPYjcblQwvPERYYAQIsnby+jtYXNpwDAaKPUpj0U/D2DL26t7?=
 =?us-ascii?Q?eXZ1PjVSdS3nyEypyFqfd+ZmWnItC9bUsUo7wJZ746jXXc0Kg0b8t1amqRrG?=
 =?us-ascii?Q?Db+wmN4Dtp2fOpu6VYSfxN4eyH7Jqm2VDMB9xJSK5pYzNgiI3N8zhoo0ueq+?=
 =?us-ascii?Q?sL8DTcWpR79QpVguLkppZWdm58GfVeVYQ0nMA9azNRMhJ0vChnXW+I2Z2gFa?=
 =?us-ascii?Q?PcxlxTAADeoiLcMvMYujJm7Ty9LUAp1SKEmhMPL0tqQ/m1+KpOmDT//SZGGO?=
 =?us-ascii?Q?zSkChCvy5MFP9KY6glQYn0z8ZI7BxhCkZEdz0vWFY/+TjzMI3oZ+ea/UBZwf?=
 =?us-ascii?Q?XWVrJmAa0ol163EDxOZPhKXNvcyElLzabpBRbbV1K1jhO3T9RMsuVN9vgV6J?=
 =?us-ascii?Q?24tX/6FL0dUUNB6VMC0D+6QYmTVqL8fy61QV3TFKDIrEEe9Cy4YaVycYbrEP?=
 =?us-ascii?Q?lT6cDkBwRR7BebK3nr05ccVAJ+KPENIuiGNI2y+IqN/8lit06Lx8zTy1smdg?=
 =?us-ascii?Q?/sfOza34Gg2sd69OKUO/f5mitHTncOkDEvCJsMo/e5wjoeSqSrKuAS7l5Li3?=
 =?us-ascii?Q?oepSx/zTWqHrqIr+ACaYfk8Laqu3oevjzdInga8sdcMHYTkt/bZwIeKvo0p/?=
 =?us-ascii?Q?db22zt0ujaNjpCbyG4ZsE1xcHY405kTR+EihK/otfIazfTWM1tnLZFm1P/gF?=
 =?us-ascii?Q?OjrEJ6uMvFe4Ibks8X0MqUuO5Ys+4y3o141wPQbfIok+giwiSTdEUzPoyWfd?=
 =?us-ascii?Q?RHAFqC5jKIxNwll/VFrBqHDgET1Q2uuug3Qudk+Vo0SuHRAxoJ2AtOiroxjV?=
 =?us-ascii?Q?CryRrK2H+YlmOeF+DXGW4vv4F9NY0Sgu+SrCmCKOgyw726KgPZjq5Cc/cHWB?=
 =?us-ascii?Q?XqDtidvwPb7ScCz0kwha1m0BIxiJFfQ9j8Ea3blvx4XtHUpYNEvchSmeJlY7?=
 =?us-ascii?Q?rjrPI4lF4Ri+vSG2DbNy1l8KcGbxegzqgewZq/1aF1kSef3uF5VN7s5v5LYJ?=
 =?us-ascii?Q?z6aR8Me+wvJXFx8IgjLCTwP7oBEcaflJZmiqTBOdk0ou8knwYwVn5gAglW6m?=
 =?us-ascii?Q?J2uwvaFFJint/INBtI0PAkKK4zZY7c3XG+6fMZssddFgV4CuE7wPkBvQKk+K?=
 =?us-ascii?Q?fI2FHM4TP3jed2lWxxSz86iDTSKavidMw4UQrkqNC52EDKnF2ceP3C/eDHBV?=
 =?us-ascii?Q?3tYKDhCQuB/M9LnpUeYZpmFt9avgSDIK2+9PrbA5cvdLwsnT4bUG6hOKnC/2?=
 =?us-ascii?Q?tCIE0D6DuJwKxQQBJ9UKabaFXkJufGhRxsWHlUqts1/FCKDr9hpxE1U0qXuS?=
 =?us-ascii?Q?dnjGXQMj0d37GAauPVg2xMVgg1wuhZcTFFbhr48T2qju+er4UAo4YPURFPha?=
 =?us-ascii?Q?qHZlc/GMaBwRZLAyoe/nQAYbW1O2Mzr1CPl172/7WidL144GN3/Y5gvLnDui?=
 =?us-ascii?Q?kuAcmGbi3EOKxhL38vXpSaf/G3iILsYFAoE/qIFFBpiiQo+kJt09pnE5NN8M?=
 =?us-ascii?Q?4DpocIgSaLLbisolvEwnmcYN948KBgFM+AzSJfxpeNR3j5MqE5fSs6Gl0wzv?=
 =?us-ascii?Q?GNb/JMxiOg+qcsGYLq1oxinFG2Z3PotCvQ7GiRjP67sYiTF1xYXedc8pYQ8X?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7899980-760d-4509-3648-08dadf79407e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 15:21:49.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0Fc+9odWUHfpxqKhNQueqPKmqbwZFa3jKmCpbRE/DArBI3Y+8acFf/Boti49wW4M/YFn6ZlQO2Q9rJPTF0+wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_10,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212160132
X-Proofpoint-ORIG-GUID: jpIdZ2XlD18IHyawAant6SOnlyPwwmeQ
X-Proofpoint-GUID: jpIdZ2XlD18IHyawAant6SOnlyPwwmeQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(hand-hacked reply: hope it threads properly)

[...]
> A kernel tree containing this series alone:
>    https://github.com/oracle/dtrace-linux-kernel kallmodsyms/6.1-rc4-modules-next
[...]
> Nick Alcock (12):
>   kbuild: bring back tristate.conf
>   kbuild: add tristate checker
>   kbuild: fix up substitutions in makefiles to allow for tristate
>     checker
>   kbuild: remove MODULE_LICENSE/AUTHOR/DESCRIPTION in non-modules
>   build: add a simple iterator over modules.builtin.objs
>   kbuild: generate an address ranges map at vmlinux link time
>   kbuild: make address ranges map work with IBT
>   kallsyms: introduce sections needed to map symbols to built-in modules
>   kallsyms: optimize .kallsyms_modules*
>   kallsyms: distinguish text symbols fully using object file names
>   kallsyms: add /proc/kallmodsyms for text symbol disambiguation
>   perf: proof-of-concept kallmodsyms support

It's been a couple of weeks, so a gentle ping seems in order :) (I can
resend if people need it, but I suspect everyone interested has it
already.)
