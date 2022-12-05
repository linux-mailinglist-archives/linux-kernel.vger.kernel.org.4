Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17551642CD8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiLEQc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:32:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43B01E722;
        Mon,  5 Dec 2022 08:32:20 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fat9G017554;
        Mon, 5 Dec 2022 16:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=3FdYcS8Rizee8MV/9bdPzx/qqUk8WTxvY43Y3dI5Afk=;
 b=1Z5nVrWtQwSeBczhk5DW/5IrlVMffuDwy7ek7n4q4D30PGSUlT8fs7Iw0fzT6Cc/d70Y
 sTZcZCWoVzZm9ZeRMj3VqlzN+2l40sxrGWwGRKBwblNHjpBOD+lbeDZMStrvDWdpdObh
 DCodAdMzZ1CJKpmEcmb9x9gqWmTMjn+VCr+3CS0fhXafxKepGgqNS4Z9dCUNWV+g+7qk
 HGf4PRGfD0NdRuH8yvbdnG/gcuqpT5Su9E2KTmRIBYyN6K11yd9NkJp1L5hxzqDuQyYB
 ACB7h9LGLe01W2nXBUSv4C7+e8rkDLiLyD7z5ZgQzqkGYUuhmQ/YnXddoijo6lR3YO4X oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ycf4fqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQvRE018801;
        Mon, 5 Dec 2022 16:32:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u9y5723-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpH3mmYyshMqPV9VEXyWmmbJeZAGp8edB/raM4TAyXT5jvVp5BdfLb12NGJdeOKnseJkjeeUHOG1rnPhf7GDQxFcsoznulCAfkXV61J/Nwl5L1+k/GRPuig9N1fqvEaokx3HHm/KhUOHH6eF0rXl/niEYRHVRUqooCKkGzTYiO31GQGysrfo8AcIvgCkQWCk6u2NW0yu03Y+pgsVp5JJ8RVp+YxbUfcbHXt+0RWggsLyDcac59HiKLKfYXBYQq1CW7h/XZ/hRjM+xHkhuxbLNH5CFrn3Lw04ycJxqBySLo4j/OZRLq+52ll4/x//NcEtsarkDIXjZDed2XTBhbNrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FdYcS8Rizee8MV/9bdPzx/qqUk8WTxvY43Y3dI5Afk=;
 b=Z1D6wrIZemLt+PtIKpxkhmOYMjCbsxbq4bRgJ7tJKPht/HrRF4vt42kYuTSzOQ8/PY4obEIGWp1VCu8SkLAza1Y0JCQH++/AJZVLt2B1YqKFQdyBCHQkBtt9B+wA9cx2e3RIprtjlcMvg2DEb+r3Kw7RYgiNf3+JjZ1/h+gDbpBQXmztJpyJeMuV43aj4yqpxtMq3X5DBGod0X0gylWW5fBTHtHG742oJ8RXbBn0jyECLmwUsKeUlF8zsrZTShH3ibJm7IpjQgbtGRnwhE4WCzjP3+TBYnY5tSMBU5h4fb7ymAIA6BYgYWXHaYftmAluPGpN4UKaSqlqFlGJzXZIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FdYcS8Rizee8MV/9bdPzx/qqUk8WTxvY43Y3dI5Afk=;
 b=ZqWc05uXNEqdxySHEEMxmgGQpI/jSydIdAp4wrJX1qmOo1yj+FQSgO7MGKiRjC3+NrgpP2/MnWBbJVbsSE39RnE2TIznS5yxn46qyXAlkqMZj/BsqUqcWthvJ5otbortCRAnlC8NTkwNSp0XCn8K0hTbKOFwnq+GuyiS1Q6AI68=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH7PR10MB5721.namprd10.prod.outlook.com (2603:10b6:510:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 16:32:09 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:09 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH modules-next v10 00/13] kallsyms: reliable symbol->address lookup with /proc/kallmodsyms
Date:   Mon,  5 Dec 2022 16:31:44 +0000
Message-Id: <20221205163157.269335-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::12) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH7PR10MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b396d42-772a-48d3-e840-08dad6de4111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: el0MA6wqU3phic6kwXROXWrtNCX2kj04PiHMNH8RT9HGJ+/7bXgJtUmHwJVr9BXVx3QUw4cEapTqIMbnUlAS8Yko0IU2BWv731bERV7QrDLTmePVGyyAV+khFkebyf7N7ILILHtu8X/y7G0/gmkX/tcvyJkxAq2nfAbsTiGJME0VJOJ9h09uhxn0qmEr8BxDPizSqHcYUw7/0dwJ7nN0OevMBTZkNg0TztfbTuVqanzfhvg25HIVOZEL6lHx3uSA7sGqd21rtHzoooXLuTlzLKPaxYv/idgCsDlYnpDnNsTpFPzuvSvnY0ayLWlq27X34SHtF0VaryGyD3z/JAXXqoYU+2q1tiVIdhmdhygONBsjD1nhsgmMuz7Y77QM9ukZ15eoibdSs4dKfB4u/xOfWe7whh3vOuEHOL5RoJigJ0AOREZoi5g/L1drsj+Rsm5V53k8clY8/0lYVrj8gNcf10J1rNlhYKryGG6/tooBk9AyVLDgl5/OBHmnHfgzzQOBn2ZxJxH7YXUIOlJsy2bx4pcgluKzkZ/Iw/eaLwmTz5vM7I1IxPdQ7Ln849cTTEDNXZGwREuELyfd96zsCJ5s8vlbPj69VmrwOSX34sFp351peJlDCPBy3nhe2hFf7iHbSTN7O+DJDUdzSA6FKdEVAoqk3vjoV3O0Cj84rJ3J0VZ4jJ0FcnjMY/CHKiZgjZtILctcDFEj73n4EGGiDHOt1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(316002)(6486002)(107886003)(478600001)(6666004)(6506007)(6512007)(66946007)(8676002)(4326008)(66476007)(66556008)(966005)(83380400001)(30864003)(8936002)(5660300002)(44832011)(186003)(41300700001)(2906002)(1076003)(36756003)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8RGY2198F+GT87urVLYSA4lqwJu9jRQdk9TkyEPhXgLQy7ejBTMPjeqZXwF?=
 =?us-ascii?Q?5DbXZX1b20Q5Ow1fe9P7/D/jArd2DoUjEg7V9uekO72+nd8H+DzXn2/R/5hU?=
 =?us-ascii?Q?Ss2EaXz3js6E2H+Vm9jNAudiKfluFD9fYkWT9xvAfniVZeuraKgUOhAyiqGL?=
 =?us-ascii?Q?JilEng8AUuQZelO82H3CR+Awo6uPEvn0pTOeir6GLeRyftoJNCRBDByNOGkS?=
 =?us-ascii?Q?jGHXgeXexyaiiGywJ0GyeK5/Vod/9bAhfWClkfD49XgVsLIaosyJyz4ZZ4kR?=
 =?us-ascii?Q?DHLru1b1lfiHddCGP1FouhzZv7lMc3Wl6IHtrIxSNSG+P+ze6BnDN/GduqXk?=
 =?us-ascii?Q?EHlKWl1Tufua+VeJWY7wq7nkJY8vKN1wkpuf8EcqHlH6V0wKajDFUQg4ho16?=
 =?us-ascii?Q?Ho2ZzmkkiabJSbJWvnAKJWa6PvXhLrWnvHtMgQpZmMNMaJQW/JjFwbGZgGWS?=
 =?us-ascii?Q?QZ3w+O+iYcrQ4UvSiuAzACM2ocghJuIkY9bdRG+vxJdwFTGPiHBfoBsGbdtY?=
 =?us-ascii?Q?Lq/4rDVJ6TvCfy8tAdO/REq2PM3oImOMhkfhiVOyAbkHfNDdarHDLFmuv+G2?=
 =?us-ascii?Q?RcMS8ydS3yObEHE4yIqKmfBrCOeBBTZISH+GKk3b4yITMjjRmR3/qNTvsQlv?=
 =?us-ascii?Q?9gIy/oguVrG6CM51IKM0UTHiQkcpEQpJKdRjax2MWLK1CLIuY0Da5Razcam6?=
 =?us-ascii?Q?QGCHOD86bdcmHaHTJoHzPYw23B0y7px8Ha+kwaQhaS0RoFL8RMvSYrL7Kh+9?=
 =?us-ascii?Q?FwooRcXCRNPXlHiu+QXaH77BqV000a535oFm7b5Juj8Fwiu3ad1zO6MLn2Ka?=
 =?us-ascii?Q?x07NrvRUFEX74VnpbYJryXWWQP3LnzbsXGTyh10RsVIwkvqxhQM2l/AaPe/6?=
 =?us-ascii?Q?DJfOPVbbzIGeETwn9feczGoM6WWN2j4Ito59dNwew4zRx3kaY/8KVW9N5HZ4?=
 =?us-ascii?Q?0hHuNstvbMjz0iQdG1LqdOKoREM5kI4SLDZb5Lkj4rTEEdhvifM8xRSSrmfn?=
 =?us-ascii?Q?PmnRpWpGAw/9YIXheslvHq4gq5QGrbW7vmH0PcDVIociCq9fERm7tqwe6peX?=
 =?us-ascii?Q?76RZ3nFHBRqpNOFTDQQ7PbPi96SW7Deio4ivF2pOBwf8QzlTz1KFTg2e+ah+?=
 =?us-ascii?Q?jewU2RLX5PsVefrx8Se951Am/USjinNhCWY2QKCiOjhkQ7TOyEWsT6lSG5X4?=
 =?us-ascii?Q?0N/b6rQ3NRxGxuwylp1EFukgKMLh04yCu8fPCpMp2snCKfFm++SyVpE4cGHg?=
 =?us-ascii?Q?5BeTqXCCIh3SJsdZyCOWUFrRvVdKHZrzVDXAD0SQFoALQF1sBuiZd/lXVrPE?=
 =?us-ascii?Q?xzpJLMH0Cxg7hptJLyyPJ0RLIEcLFPHAJRkwGWRfY6gPG9D9Q+8qHIJ8VWhW?=
 =?us-ascii?Q?qO4czogI3mPRukwHtmcD8cEVIKpixodl8Jms4keex4bbvbVhWlywL1ubqfkF?=
 =?us-ascii?Q?ia8TKQq47Nid3d0CxVSdx4e4XRqhemnQkeEFGKa/te7fY84wZQ1Zpx/jdJQF?=
 =?us-ascii?Q?KVdaZ1YjE22XuQ48n89LTHBk9fEa3+z1X7kEn4h+jAjr2HmDErViUznOBa6E?=
 =?us-ascii?Q?fJOjI/DG/DRCfgamgcxLL1NxJ2Q3b0DuK8XSclc4hbaMT+LyJAcbCJu1tURl?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3j9ElFHxB1HI42wHs2OpKi78ZgL9EOXNb54gKScha7475FJR6xREqssHStug?=
 =?us-ascii?Q?vKksBTgzo45GCx/Sc7SLgL0QugFkcYDWy0E13i7NsrFA6uDyPyTqnpnLOz7X?=
 =?us-ascii?Q?JatwDK7D9nbvQp59eiXmXu2o6cS5GcT5DVYkU1CXni2x5QAtZR0EtlSq4ovV?=
 =?us-ascii?Q?x7wWgUqTmmMDva8vPCPO7pIC+Y93Ayp+48k8NqdX7u7QD3u2QNJ9shFfPGpO?=
 =?us-ascii?Q?H5GGWATwLty2Sp9r2dTw3Bj3eF5GR5gsy3aCzkBZfn1TL2O0VPLwLlYx4ReN?=
 =?us-ascii?Q?P4GQ09EOZ8bvWsuvmuPUPx9NVQhG41T3+WrfQ97UUAoHf1DEW8l6KUQGfAZR?=
 =?us-ascii?Q?BZP/r+M7TpMcAUJat/WuBdyqtlW6vqLK3O/1iyfNNZjrf9MO3XBwGuThymWL?=
 =?us-ascii?Q?QXx7NF/S/FP9DcXtQlX3AZFZ74WT2ls64XiErrlATy9FELjiAsm0XKPDa0iZ?=
 =?us-ascii?Q?RlHISWVTgNVGX43b5HHcS327ZohPeUu/glbaZqn+B1MEGPzc4ghyoFnJxWFn?=
 =?us-ascii?Q?XnKSH3+SOYb1AbcDw+4gsWSM4nMKqbTt0vqZYdFtEFomFXBHwjSrKmqUsxV/?=
 =?us-ascii?Q?YWddYni6RoPgQZvhn+zu7oymZRh6puHxEBIlZ74Xc4XLmPNAgKiBwowsd0Em?=
 =?us-ascii?Q?6KE0ThdyPhPLsuNEEpsbYNIfdb4OZ4v06v7/V+6mPzKZ6xx5OKgfVuE+dzCU?=
 =?us-ascii?Q?zm+b6sKQ7tE3zF9vNwwOX0LUHDihK2SeNYfNB+LslGZecHYcKuOlXMdnPFud?=
 =?us-ascii?Q?PZfAfHOJU5a84Zo7tbqGQr3BIUjMjxlfB0qtQoYzrvEG42imII/wvZcPQTs0?=
 =?us-ascii?Q?PS207d9Cfi6osZHwMGlexI77ChH1UFfzmskuIEpGf1SxMmYM4Ly2n+dokaTv?=
 =?us-ascii?Q?xLYgztKacFuFPCvVN//JI+zQRfyiYWXbLiOqmv5nDLCiCSHPdV0YftALKr63?=
 =?us-ascii?Q?WHxC3Jdl+9WhUU0qSY+4RovR2gVwSpgIvwFVn7Mx2r0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b396d42-772a-48d3-e840-08dad6de4111
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:09.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oq3/lUbSJKwAie5r0ConucRAzJgdql1Q/wfNr+jxKEpxvVdps9H+KvLn6NIoWhettdglN/lW1XNEvgZz2oUylA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050137
X-Proofpoint-ORIG-GUID: 8tZ7LORCBUnfg3hSvtt7H3r1T_BnE4-Z
X-Proofpoint-GUID: 8tZ7LORCBUnfg3hSvtt7H3r1T_BnE4-Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kallmodsyms patch series was originally posted in Nov 2019, and the thread
(https://lore.kernel.org/linux-kbuild/20191114223036.9359-1-eugene.loh@oracle.com/t/#u)
shows review comments, questions, and feedback from interested parties.
Most recent posting: <https://lore.kernel.org/linux-modules/20221109134132.9052-1-nick.alcock@oracle.com/T/#t>.

All review comments have been satisfied, as far as I know: in particular
Yamada's note about translation units that are shared between built-in
modules is satisfied with a better representation which is also much, much
smaller, and we are no longer using modules_thick.builtin but Luis's new
modules.builtin.objs.

A kernel tree containing this series alone:
   https://github.com/oracle/dtrace-linux-kernel kallmodsyms/6.1-rc4-modules-next


The whole point of symbols is that their names are unique: you can look up a
symbol and get back a unique address, and vice versa.  Alas, because
/proc/kallsyms (rightly) reports all symbols, even hidden ones, it does not
really satisfy this requirement.  Large numbers of symbols are duplicated
many times (just search for __list_del_entry!), and while usually these are
just out-of-lined things defined in header files and thus all have the same
implementation, it does make it needlessly hard to figure out which one is
which in stack dumps, when tracing, and such things.  Some configuration
options make things much worse: my test make allyesconfig runs introduced
thousands of text symbols named _sub_I_65535_1, one per compiler-generated
object file, and it was fairly easy to make them appear in ftrace output.

Right now the kernel has no way at all to tell such symbols apart, and nor
has the user: their address differs and that's all.  Which module did they
come from?  Which object file?  We don't know.  Figuring out which is which
when tracing needs a combination of guesswork and luck, and if there are
thousands of them that's not a pleasant prospect.  In discussions at LPC it
became clear that this is not just annoying me but Steve Rostedt and others,
so it's probably desirable to fix this.

It turns out that the linker, and the kernel build system, can be made to
give us everything we need to resolve this once and for all.  This series
provides a new /proc/kallmodsyms which is like /proc/kallsyms except that it
annotates every (textual) symbol which comes from a built-in kernel module
with the module's name, in square brackets: if a symbol is used by multiple
modules, it gets [multiple] [names]; if a symbol is still ambiguous it gets
a cut-down {object file name}; the combination of symbol, [module] [names]
and {object file name} is unique (with one minor exception: the arm64 nvhe
module is pre-linked with ld -r, causing all symbols in it to appear to come
from the same object file: if it was reworked to use thin archives this
problem would go away).

The object file names are cut down to save space: we store only the shortest
suffix needed to distinguish symbols from each other.  It's fairly rare even
to see two/level names, let alone three/level/ones.  We also save even more
space by annotating every symbol in a given object file with the object file
name if we annotate any of them.

We also add new fields that let you get at this new info in the kallsyms
iterator.

In brief we do this by mapping from address ranges to object files (with
assistance from the linker map file), then mapping from those object files
to built-in kernel modules and object file names.  Because the number of
object files is much smaller than the number of symbols, because we fuse
address range and object file entries together if possible, and because we
don't even store object file names unless we need to, this is a fairly
efficient representation, even with a bit of extra complexity to allow
object files to be in more than one module at once.

The size impact of all of this is minimal: in testing, vmlinux grew by 16632
bytes, and the compressed vmlinux only grew by 12544 bytes (about .1% of a
10MiB kernel): though this is very configuration-dependent, it seems likely
to scale roughly with the kernel as a whole.

This is all controlled by a new config parameter CONFIG_KALLMODSYMS, which when
set results in output in /proc/kallmodsyms that looks like this:

ffffffff97606e50 t not_visible
ffffffff97606e70 T perf_msr_probe
ffffffff97606f80 t test_msr     [rapl]
ffffffffa6007350 t rapl_pmu_event_stop  [rapl]
ffffffffa6007440 t rapl_pmu_event_del   [rapl]
ffffffffa6007460 t rapl_hrtimer_handle  [rapl]
ffffffffa6007500 t rapl_pmu_event_read  [rapl]
ffffffffa6007520 t rapl_pmu_event_init  [rapl]
ffffffffa6007630 t rapl_cpu_offline     [rapl]
ffffffffa6007710 t amd_pmu_event_map    {core.o}
ffffffffa6007750 t amd_pmu_add_event    {core.o}
ffffffffa6007760 t amd_put_event_constraints_f17h       {core.o}

The modular symbols are notated as [rapl] even if rapl is built into the
kernel.  Further, at least one symbol nottated as {core.o} would have been
ambiguous without that notation.  If we look a little further down, we see:

ffffffff97607a70 t cmask_show   {core.o}
ffffffff97607ab0 t inv_show     {core.o}
ffffffff97607ae0 t edge_show    {core.o}
ffffffff97607b10 t umask_show   {core.o}
ffffffff97607b40 t event_show   {core.o}

where event_show in particular is highly ambiguous and appears in many
object files, all of which are now notated with different {object file
names}.

Further down, we see what happens when object files are reused by multiple
modules, all of which are built in to the kernel, and some of which contain
symbols that are ambiguously-named even within that set of modules:

ffffffff97d7aed0 t liquidio_pcie_mmio_enabled   [liquidio]
ffffffff97d7aef0 t liquidio_pcie_resume [liquidio]
ffffffff97d7af00 t liquidio_ptp_adjtime [liquidio]
ffffffff97d7af50 t liquidio_ptp_enable  [liquidio]
ffffffff97d7af70 t liquidio_get_stats64 [liquidio]
ffffffff97d7b0f0 t liquidio_fix_features        [liquidio]
ffffffff97d7b1c0 t liquidio_get_port_parent_id  [liquidio]
[...]
ffffffff97d824c0 t lio_vf_rep_modinit   [liquidio]
ffffffff97d824f0 t lio_vf_rep_modexit   [liquidio]
ffffffff97d82520 t lio_ethtool_get_channels     [liquidio] [liquidio_vf]
ffffffff97d82600 t lio_ethtool_get_ringparam    [liquidio] [liquidio_vf]
ffffffff97d826a0 t lio_get_msglevel     [liquidio] [liquidio_vf]
ffffffff97d826c0 t lio_vf_set_msglevel  [liquidio] [liquidio_vf]
ffffffff97d826e0 t lio_get_pauseparam   [liquidio] [liquidio_vf]
ffffffff97d82710 t lio_get_ethtool_stats        [liquidio] [liquidio_vf]
ffffffff97d82e70 t lio_vf_get_ethtool_stats     [liquidio] [liquidio_vf]
[...]
ffffffff97d91a80 t cn23xx_vf_mbox_thread        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91aa0 t cpumask_weight.constprop.0   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91ac0 t cn23xx_vf_msix_interrupt_handler     [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91bd0 t cn23xx_vf_get_oq_ticks       [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c00 t cn23xx_vf_ask_pf_to_do_flr   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c70 t cn23xx_octeon_pfvf_handshake [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91e20 t cn23xx_setup_octeon_vf_device        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d92060 t octeon_mbox_read     [liquidio] [liquidio_vf]
ffffffff97d92230 t octeon_mbox_write    [liquidio] [liquidio_vf]
[...]
ffffffff97d946b0 t octeon_alloc_soft_command_resp       [liquidio] [liquidio_vf]
ffffffff97d947e0 t octnet_send_nic_data_pkt     [liquidio] [liquidio_vf]
ffffffff97d94820 t octnet_send_nic_ctrl_pkt     [liquidio] [liquidio_vf]
ffffffff97d94ab0 t liquidio_get_stats64 [liquidio_vf]
ffffffff97d94c10 t liquidio_fix_features        [liquidio_vf]
ffffffff97d94cd0 t wait_for_pending_requests    [liquidio_vf]

Like /proc/kallsyms, the output is sorted by address, so keeps the curious
property of /proc/kallsyms that symbols may appear repeatedly with different
addresses: but now, unlike in /proc/kallsyms, we can see that those symbols
appear repeatedly because they are *different symbols* that ultimately
belong to different modules or different object files, all of which are
built in to the kernel.

Note that kernel symbols for built-in modules will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation (though they might have an {object file
name}.

As with /proc/kallsyms, non-root usage produces addresses that are all zero.

Tested with a make allyesconfig and allmodconfig, and with and without
CONFIG_X86_KERNEL_IBT.

Limitations:

 - this approach only works for textual symbols (and weak ones).  I don't
   see any way to make it work for data symbols etc: except for initialized
   data they don't really have corresponding object files at all and they
   tend to get merged together anyway.

 - Compiling with clang LTO is untested.  Compiling with X86 IBT now works,
   but .cold-partitioned symbols are not attributed to any objfiles right
   now (currently, this results in no conflicts on a make allyesconfig
   build, so it's harmless).

 - Non-built-in modules can also have ambiguous symbols in them in different
   input object files: they aren't handled yet because kallsyms never runs
   over modules to create the necessary sections.  This is fixable, but it's
   probably best handled in another patch series.  (kallsyms would need to
   do much less work for modules: only the sections introduced by this patch
   series would need emission at all, and no [module] notations would be
   needed, only {objfile}.)

 - Section start/end symbols necessarily lie on the boundary between object
   files, so are sometimes misreported as being in the wrong object file or
   module.  This is unlikely to be too troublesome for these symbols in
   particular, but if anyone can figure out a way to fix this I'd be happy
   to do it.

 - There is no BPF iterator support yet (it's just a matter of adding it
   if needed).

The commits in this series all have reviewed-by tags: they're all from
internal reviews, so please ignore them.

Differences from v9, early November 2022:

 - Rework to use Luis Chamberlain's modules.builtin.objs rather than a
   tristate-generated "modules_thick.builtin".  Keep the iterator over
   modules_thick.builtin, but rename it to scripts/modules_builtin.c and
   make it more robust against strange lines in modules.builtin.objs,
   such as lines with no colon in.
 - Rework the old modules_thick.builtin stuff into a "tristate checker"
   which warns about source files that contain MODULE_LICENSE for which
   the corresponding Kconfig symbol is of type 'bool' rather than
   'tristate'.  It no longer runs unless requested, so doesn't slow
   the build down with a big recursion across the whole source tree.
 - Fix up a bunch of places where the tristate checker (and the old
   modules_thick.builtin and modules.builtin generators) gave the wrong
   answers, usually considering things to be modules that actually
   unconditionally built in.  (16 makefiles touched.)
 - Eliminate MODULE_LICENSE/AUTHOR/DESCRIPTION from a bunch of things
   that cannot actually be modules: aarch64 and x86_64 are now clean,
   other arches not checked. Verified with make allmodconfig on both
   arches. (189 not-actually-modules touched.)
 - Use the CONFIG_VMLINUX_MAP machinery rather than generating a whole
   second linker mapfile.
 - Add (in a separate commit since it is largely conceptually separate)
   support for the ld -r linking used by CONFIG_X86_KERNEL_IBT.
 - Add a special kallsyms build-time warning for ambiguous symbols that
   came from the same object file: note that they are probably the
   result of ld -r.
 - When lengthening shortened objfile names to resolve an ambiguity,
   always lengthen the name of the objfile with the longer (unshortened)
   length, fixing ambiguous objfiles with names which are substrings of
   other objfiles' names.
 - Fix a bug which could cause inflooping when outputting the
   .kallsyms_mod_objnames section.
 - Rebase atop modules-next.

Differences from v8, February 2022:

 - Add object file name handling, emitting only those object names needed to
   disambiguate symbols, shortening them as much as possible compatible with
   that.
 - Rename .kallsyms_module_names to .kallsyms_mod_objnames now that it
   contains object file names too.
 - Fix a bug in optimize_obj2mod that prevented proper reuse of module names
   for object files appearing in both multimodule modules and single-module
   modules: saves a few KiB more, often more than the space increase due to
   object file name handling.
 - Rebased atop v6.1-rc2: move modules_thick.builtin generation into
   the top-level Kbuild accordingly, and adjust to getopt_long use in
   scripts/kallsyms.
 - Significant revisions to the cover letter.
 - Add proof-of-concept kallmodsyms module support to perf.
 - (This ping) confirmed that series applies atop v6.1-rc4 without
   further changes.

Differences from v7, December 2021:

 - Adjust for changes in the v5.17 merge window.  Adjust a few commit
   messages and shrink the cover letter.
 - Drop the symbol-size patch, probably better done from userspace.

Differences from v6, November 2021:

 - Adjust for rewrite of confdata machinery in v5.16 (tristate.conf
   handling is now more of a rewrite than a reversion)

Differences from v5, October 2021:

 - Fix generation of mapfiles under UML

Differences from v4, September 2021:

 - Fix building of tristate.conf if missing (usually concealed by the
   syncconfig being run for other reasons, but not always: the kernel
   test robot spotted it).
 - Forward-port atop v5.15-rc3.

Differences from v3, August 2021:

 - Fix a kernel test robot warning in get_ksymbol_core (possible
   use of uninitialized variable if kallmodsyms was wanted but
   kallsyms_module_offsets was not present, which is most unlikely).

Differences from v2, June 2021:

 - Split the series up.  In particular, the size impact of the table
   optimizer is now quantified, and the symbol-size patch is split out and
   turned into an RFC patch, with the /proc/kallmodsyms format before that
   patch lacking a size column.  Some speculation on how to make the symbol
   sizes less space-wasteful is added (but not yet implemented).

 - Drop a couple of unnecessary #includes, one unnecessarily exported
   symbol, and a needless de-staticing.

Differences from v1, in 2019:

 - Move from a straight symbol->module name mapping to a mapping from
   address-range to TU to module name list, bringing major space savings
   over the previous approach and support for object files used by many
   built-in modules at the same time, at the cost of a slightly more complex
   approach (unavoidably so, I think, given that we have to merge three data
   sources together: the link map in .tmp_vmlinux.ranges, the nm output on
   stdin, and the mapping from TU name to module names in
   modules_thick.builtin).

   We do opportunistic merging of TUs if they cite the same modules and
   reuse module names where doing so is simple: see optimize_obj2mod below.
   I considered more extensive searches for mergeable entries and more
   intricate encodings of the module name list allowing TUs that are used by
   overlapping sets of modules to share their names, but such modules are
   rare enough (and such overlapping sharings are vanishingly rare) that it
   seemed likely to save only a few bytes at the cost of much more
   hard-to-test code.  This is doubly true now that the tables needed are
   only a few kilobytes in length.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>

Luis Chamberlain (1):
  kbuild: add modules.builtin.objs

Nick Alcock (12):
  kbuild: bring back tristate.conf
  kbuild: add tristate checker
  kbuild: fix up substitutions in makefiles to allow for tristate
    checker
  kbuild: remove MODULE_LICENSE/AUTHOR/DESCRIPTION in non-modules
  build: add a simple iterator over modules.builtin.objs
  kbuild: generate an address ranges map at vmlinux link time
  kbuild: make address ranges map work with IBT
  kallsyms: introduce sections needed to map symbols to built-in modules
  kallsyms: optimize .kallsyms_modules*
  kallsyms: distinguish text symbols fully using object file names
  kallsyms: add /proc/kallmodsyms for text symbol disambiguation
  perf: proof-of-concept kallmodsyms support

 .gitignore                                    |    3 +-
 Documentation/dontdiff                        |    4 +-
 Documentation/kbuild/kbuild.rst               |    5 +
 Documentation/kbuild/kconfig.rst              |    5 +
 Makefile                                      |   35 +-
 arch/x86/crypto/blake2s-glue.c                |    1 -
 arch/x86/mm/debug_pagetables.c                |    3 -
 crypto/asymmetric_keys/asymmetric_type.c      |    1 -
 drivers/Makefile                              |    2 +-
 .../accessibility/braille/braille_console.c   |    4 -
 drivers/amba/tegra-ahb.c                      |    3 -
 drivers/android/binder.c                      |    1 -
 drivers/bus/arm-cci.c                         |    2 -
 drivers/bus/arm-integrator-lm.c               |    3 -
 drivers/bus/bt1-apb.c                         |    3 -
 drivers/bus/bt1-axi.c                         |    3 -
 drivers/bus/imx-weim.c                        |    3 -
 drivers/bus/intel-ixp4xx-eb.c                 |    3 -
 drivers/bus/qcom-ebi2.c                       |    3 -
 drivers/bus/qcom-ssc-block-bus.c              |    3 -
 drivers/bus/simple-pm-bus.c                   |    3 -
 drivers/clk/bcm/clk-bcm2835-aux.c             |    3 -
 drivers/clk/bcm/clk-bcm2835.c                 |    3 -
 drivers/clk/clk-bm1880.c                      |    3 -
 drivers/clk/clk-fixed-mmio.c                  |    3 -
 drivers/clk/clk-fsl-sai.c                     |    3 -
 drivers/clk/hisilicon/clk-hi3559a.c           |    2 -
 drivers/clk/microchip/clk-mpfs-ccc.c          |    3 -
 drivers/clk/microchip/clk-mpfs.c              |    5 -
 drivers/clk/renesas/rcar-usb2-clock-sel.c     |    2 -
 drivers/clk/renesas/renesas-cpg-mssr.c        |    2 -
 drivers/clk/renesas/rzg2l-cpg.c               |    2 -
 drivers/clocksource/em_sti.c                  |    3 -
 drivers/clocksource/sh_cmt.c                  |    3 -
 drivers/clocksource/sh_mtu2.c                 |    3 -
 drivers/clocksource/sh_tmu.c                  |    3 -
 drivers/clocksource/timer-stm32-lp.c          |    2 -
 drivers/clocksource/timer-tegra186.c          |    3 -
 drivers/clocksource/timer-ti-dm.c             |    3 -
 drivers/cpufreq/freq_table.c                  |    3 -
 drivers/cpufreq/intel_pstate.c                |    3 -
 drivers/cpufreq/tegra124-cpufreq.c            |    3 -
 drivers/dma-buf/heaps/cma_heap.c              |    2 -
 drivers/dma-buf/heaps/system_heap.c           |    1 -
 drivers/dma-buf/udmabuf.c                     |    2 -
 drivers/dma/ep93xx_dma.c                      |    3 -
 drivers/dma/ipu/ipu_idmac.c                   |    3 -
 drivers/dma/mv_xor_v2.c                       |    2 -
 drivers/dma/s3c24xx-dma.c                     |    3 -
 drivers/dma/sh/shdma-base.c                   |    3 -
 drivers/dma/stm32-dmamux.c                    |    4 -
 drivers/dma/stm32-mdma.c                      |    4 -
 drivers/edac/altera_edac.c                    |    3 -
 drivers/firmware/broadcom/bcm47xx_nvram.c     |    1 -
 drivers/firmware/imx/imx-scu.c                |    3 -
 drivers/firmware/imx/scu-pd.c                 |    3 -
 drivers/gpio/gpio-aspeed-sgpio.c              |    2 -
 drivers/gpio/gpio-imx-scu.c                   |    3 -
 drivers/gpio/gpio-mxs.c                       |    6 -
 drivers/gpio/gpio-rda.c                       |    3 -
 drivers/gpu/drm/drm_mipi_dsi.c                |    3 -
 drivers/hv/Makefile                           |    2 +-
 drivers/hwspinlock/hwspinlock_core.c          |    3 -
 drivers/interconnect/core.c                   |    3 -
 drivers/iommu/sun50i-iommu.c                  |    4 -
 drivers/irqchip/irq-al-fic.c                  |    3 -
 drivers/irqchip/irq-ls-scfg-msi.c             |    3 -
 drivers/irqchip/irq-mbigen.c                  |    4 -
 drivers/irqchip/irq-mchp-eic.c                |    3 -
 drivers/irqchip/irq-mvebu-pic.c               |    3 -
 drivers/irqchip/irq-renesas-intc-irqpin.c     |    3 -
 drivers/irqchip/irq-renesas-irqc.c            |    3 -
 drivers/irqchip/irq-renesas-rza1.c            |    3 -
 drivers/irqchip/irq-renesas-rzg2l.c           |    3 -
 drivers/irqchip/irq-sl28cpld.c                |    3 -
 drivers/irqchip/irq-ti-sci-inta.c             |    3 -
 drivers/irqchip/irq-ti-sci-intr.c             |    3 -
 drivers/leds/leds-asic3.c                     |    3 -
 drivers/mailbox/rockchip-mailbox.c            |    4 -
 drivers/mailbox/zynqmp-ipi-mailbox.c          |    3 -
 drivers/memory/bt1-l2-ctl.c                   |    3 -
 drivers/memory/da8xx-ddrctl.c                 |    3 -
 drivers/memory/fsl_ifc.c                      |    3 -
 drivers/memory/mvebu-devbus.c                 |    3 -
 drivers/memory/tegra/mc.c                     |    3 -
 drivers/memory/tegra/tegra186-emc.c           |    3 -
 drivers/mfd/88pm860x-core.c                   |    3 -
 drivers/mfd/altera-sysmgr.c                   |    3 -
 drivers/mfd/bcm2835-pm.c                      |    3 -
 drivers/mfd/da903x.c                          |    4 -
 drivers/mfd/da9052-core.c                     |    3 -
 drivers/mfd/da9052-i2c.c                      |    3 -
 drivers/mfd/da9052-spi.c                      |    3 -
 drivers/mfd/da9055-core.c                     |    3 -
 drivers/mfd/da9055-i2c.c                      |    3 -
 drivers/mfd/ezx-pcap.c                        |    3 -
 drivers/mfd/intel_soc_pmic_crc.c              |    4 -
 drivers/mfd/lp8788.c                          |    3 -
 drivers/mfd/omap-usb-host.c                   |    4 -
 drivers/mfd/omap-usb-tll.c                    |    4 -
 drivers/mfd/palmas.c                          |    3 -
 drivers/mfd/stmpe-i2c.c                       |    3 -
 drivers/mfd/stmpe-spi.c                       |    3 -
 drivers/mfd/tc3589x.c                         |    3 -
 drivers/mfd/tps6586x.c                        |    3 -
 drivers/mfd/twl4030-audio.c                   |    3 -
 drivers/mfd/twl6040.c                         |    4 -
 drivers/mmc/Makefile                          |    2 +-
 drivers/mtd/parsers/bcm63xxpart.c             |    6 -
 drivers/net/wireless/silabs/wfx/Makefile      |    2 +-
 drivers/nvmem/core.c                          |    4 -
 drivers/nvmem/zynqmp_nvmem.c                  |    3 -
 drivers/pci/controller/dwc/pcie-histb.c       |    2 -
 .../controller/mobiveil/pcie-mobiveil-plat.c  |    3 -
 drivers/pci/controller/pci-tegra.c            |    1 -
 drivers/pci/controller/pci-versatile.c        |    2 -
 drivers/pci/controller/pcie-hisi-error.c      |    2 -
 drivers/pci/controller/pcie-microchip-host.c  |    3 -
 drivers/pci/endpoint/pci-ep-cfs.c             |    3 -
 drivers/pci/endpoint/pci-epc-core.c           |    3 -
 drivers/pci/endpoint/pci-epc-mem.c            |    3 -
 drivers/pci/endpoint/pci-epf-core.c           |    3 -
 drivers/pci/hotplug/acpiphp_core.c            |    3 -
 drivers/pci/hotplug/shpchp_core.c             |    3 -
 drivers/perf/apple_m1_cpu_pmu.c               |    1 -
 drivers/phy/intel/phy-intel-lgm-combo.c       |    2 -
 drivers/pinctrl/actions/pinctrl-s500.c        |    4 -
 drivers/pinctrl/actions/pinctrl-s700.c        |    3 -
 drivers/pinctrl/actions/pinctrl-s900.c        |    4 -
 drivers/pinctrl/bcm/pinctrl-ns.c              |    2 -
 drivers/pinctrl/mediatek/pinctrl-mt8188.c     |    2 -
 drivers/pinctrl/mediatek/pinctrl-mt8192.c     |    2 -
 drivers/pinctrl/mediatek/pinctrl-mt8365.c     |    3 -
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     |    4 -
 drivers/pinctrl/pinctrl-amd.c                 |    3 -
 drivers/pinctrl/renesas/pinctrl-rza1.c        |    3 -
 drivers/pinctrl/renesas/pinctrl-rza2.c        |    3 -
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |    3 -
 drivers/pinctrl/renesas/pinctrl-rzn1.c        |    3 -
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |    3 -
 drivers/power/reset/as3722-poweroff.c         |    3 -
 drivers/power/reset/gpio-poweroff.c           |    3 -
 drivers/power/reset/gpio-restart.c            |    3 -
 drivers/power/reset/keystone-reset.c          |    3 -
 drivers/power/reset/ltc2952-poweroff.c        |    3 -
 drivers/power/reset/mt6323-poweroff.c         |    3 -
 drivers/power/reset/regulator-poweroff.c      |    3 -
 drivers/power/reset/restart-poweroff.c        |    3 -
 drivers/power/reset/tps65086-restart.c        |    3 -
 drivers/power/supply/power_supply_core.c      |    6 -
 drivers/power/supply/wm97xx_battery.c         |    3 -
 drivers/powercap/powercap_sys.c               |    3 -
 drivers/regulator/stm32-pwr.c                 |    3 -
 drivers/remoteproc/remoteproc_core.c          |    2 -
 drivers/reset/reset-axs10x.c                  |    3 -
 drivers/reset/reset-hsdk.c                    |    3 -
 drivers/reset/reset-lantiq.c                  |    3 -
 drivers/reset/reset-microchip-sparx5.c        |    3 -
 drivers/reset/reset-mpfs.c                    |    3 -
 drivers/s390/char/Makefile                    |    2 +-
 drivers/s390/crypto/Makefile                  |    2 +-
 drivers/soc/apple/apple-pmgr-pwrstate.c       |    3 -
 drivers/soc/bcm/bcm2835-power.c               |    3 -
 drivers/soc/bcm/raspberrypi-power.c           |    4 -
 drivers/soc/fujitsu/a64fx-diag.c              |    3 -
 drivers/soc/sunxi/sunxi_sram.c                |    3 -
 drivers/soc/tegra/cbb/tegra194-cbb.c          |    3 -
 drivers/soc/tegra/cbb/tegra234-cbb.c          |    2 -
 drivers/tty/n_null.c                          |    3 -
 drivers/tty/serial/imx_earlycon.c             |    3 -
 drivers/tty/serial/rda-uart.c                 |    3 -
 drivers/video/console/vgacon.c                |    1 -
 drivers/video/fbdev/asiliantfb.c              |    1 -
 drivers/video/fbdev/gbefb.c                   |    1 -
 drivers/video/fbdev/imsttfb.c                 |    1 -
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c         |    3 -
 .../video/fbdev/mmp/panel/tpo_tj032md01bw.c   |    3 -
 drivers/video/fbdev/vesafb.c                  |    1 -
 drivers/video/fbdev/wm8505fb.c                |    3 -
 drivers/video/fbdev/wmt_ge_rops.c             |    4 -
 drivers/xen/grant-dma-ops.c                   |    3 -
 drivers/xen/xenbus/xenbus_probe.c             |    1 -
 fs/binfmt_elf.c                               |    1 -
 fs/nfs_common/nfs_ssc.c                       |    1 -
 fs/unicode/utf8-core.c                        |    1 -
 include/linux/module.h                        |    4 +-
 init/Kconfig                                  |   10 +
 kernel/dma/map_benchmark.c                    |    3 -
 kernel/events/hw_breakpoint_test.c            |    2 -
 kernel/kallsyms.c                             |  277 +++-
 kernel/kallsyms_internal.h                    |   14 +
 kernel/trace/rv/reactor_panic.c               |    3 -
 kernel/trace/rv/reactor_printk.c              |    3 -
 kernel/watch_queue.c                          |    3 -
 lib/btree.c                                   |    3 -
 lib/crypto/blake2s-generic.c                  |    3 -
 lib/crypto/blake2s.c                          |    3 -
 lib/glob.c                                    |    2 -
 lib/packing.c                                 |    2 -
 lib/pldmfw/pldmfw.c                           |    3 -
 lib/test_fprobe.c                             |    1 -
 mm/zpool.c                                    |    3 -
 mm/zswap.c                                    |    3 -
 net/8021q/Makefile                            |    2 +-
 net/Makefile                                  |    2 +-
 net/bridge/Makefile                           |    4 +-
 net/dccp/Makefile                             |    4 +-
 net/ipv6/Makefile                             |    2 +-
 net/l2tp/Makefile                             |   12 +-
 net/mctp/af_mctp.c                            |    3 -
 net/netfilter/Makefile                        |    2 +-
 net/netlabel/Makefile                         |    2 +-
 net/sctp/Makefile                             |    2 +-
 scripts/.gitignore                            |    1 +
 scripts/Kbuild.include                        |   21 +
 scripts/Makefile                              |    7 +
 scripts/Makefile.lib                          |   13 +-
 scripts/Makefile.vmlinux_o                    |   21 +-
 scripts/addaddrs.c                            |   28 +
 scripts/check-tristates.mk                    |   56 +
 scripts/kallsyms.c                            | 1223 ++++++++++++++++-
 scripts/kconfig/confdata.c                    |   41 +-
 scripts/link-vmlinux.sh                       |   38 +-
 scripts/modules_builtin.c                     |  200 +++
 scripts/modules_builtin.h                     |   48 +
 tools/perf/builtin-kallsyms.c                 |   35 +-
 tools/perf/util/event.c                       |   14 +-
 tools/perf/util/machine.c                     |    6 +-
 tools/perf/util/machine.h                     |    1 +
 tools/perf/util/symbol.c                      |  207 ++-
 tools/perf/util/symbol.h                      |   12 +-
 231 files changed, 2241 insertions(+), 671 deletions(-)
 create mode 100644 scripts/addaddrs.c
 create mode 100644 scripts/check-tristates.mk
 create mode 100644 scripts/modules_builtin.c
 create mode 100644 scripts/modules_builtin.h

-- 
2.38.0.266.g481848f278

