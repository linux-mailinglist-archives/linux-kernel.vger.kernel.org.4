Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6285272D302
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjFLVOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbjFLVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:14:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0C32718;
        Mon, 12 Jun 2023 14:08:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNkNM016715;
        Mon, 12 Jun 2023 21:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=OXvUFcLXYppKUDsSCd/D8qJnaO4xdUa0FGerwwAsEaE=;
 b=uMxt8udtD9QaqHMUJ0SAtQ4WrV7molU8V0Naru6gs1VWOLV+apFKGVUy9JREjZm4ARQf
 13oJ4nWEdx6AlvaVwBIl+7qf727bVnjqw87GnCxA91RpEnirMOsnVEKRFArawv8FdFxj
 +BfiFSej2TrjYz4e/tnGjMyTpv5oHiJJ4strQL1yWaYNx95ZeXxlzXdjFkCONG6JKtYP
 zmVw99zjg1P/MkCnDKHqrYcmcCPh/vZ9zpE4oQFmmmoU+gmsh4aBWJIepp9C2t8Yzy5n
 PJyZjyUkwpzRnYgNBosLG6R3wyhxCrLJKKEGXj2S8N4WIuZ5azeF0rnUoXyNmHglDyHY eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3bwad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKrK2X008928;
        Mon, 12 Jun 2023 21:07:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3jc5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPntUsCv/0/8no8hvqPFGma5GJ9I0QIdhZ6cxWKTusKgONmZQmRpYt9FL9YnsWkm+PD/c88nEHa4feQh8Mpun/66IITpo/rqk4mnqlPeX4poNiUDvGRAOYLFhqAL2OkMpdMY7w7j/5p9ACOXCr4uJUVcGJC1Zl2Sg0jysybRz0OcQ1l2LFru4VkWuSoO/OE7Q/qEB0oH/wP8GQpe8aqGDL8jzZ8SugM1foOcPHhp6daEPUZ79QDaIr5a1B6dTpcvt7YE94g8aV6kpFEpHQGzVrzK58SwUgB1p4/l0rozdy6OgtXYrM9/IlSqKawZLif9L1siUta/sN14YlDjyfXXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXvUFcLXYppKUDsSCd/D8qJnaO4xdUa0FGerwwAsEaE=;
 b=SCQcMlgZFsTmvvZ0IyGC4Ase8tk4S89/IQwyHgwWATxXNfGucSlPodiql4bw2Qna25hiTNoE25DTV0O0oIn09xzedtDQ1NteXTCAoha+xgwhFrfohpXgoVb/6EoB/YdfjSkGWKNXm3ixmaFJf6TKKXqJjPQnEXbfS8Yhdpt4ryTB4ytQodojXor79x8/sKj22qC7sc/dNwjX/hEWlb3vqAZhTkNGlSqZs7SxIQ70RC1lrTDHA1P86D0TssbBax6ZdeeBMKgzmuIYNa477kCQfldMY9m0z4ehlQZDRoAEUKqOgt1Nl8Mi8qovetr5B+IY+6jAg9dzKJOL6Iqzt5QA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXvUFcLXYppKUDsSCd/D8qJnaO4xdUa0FGerwwAsEaE=;
 b=MKdOV+7wUcWUt+LxDg3iTqonY+EoNj+BeOvCQOn6hbVbMWaflqCts/WkG8z1iQqNdJ8hhQ3A4Qozd8brbiHDujBRYqoMFV2UzwBIhbl7TLTYkpHbkLlsvDkaI38e2zFDyb82QW0/KhIsaQ+dyyYGIZPJDkQ9xMIcx/MJ0q7t9dY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 21:07:24 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:24 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v23 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Mon, 12 Jun 2023 17:07:04 -0400
Message-Id: <20230612210712.683175-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0638.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 72afd034-bef2-4d27-6411-08db6b890512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0w58UICMLJa+PR73icjhy18KVH4/ZyjIoR5EsDMbmaNkmabed0xtQ7tclHqp0gf06AXVOBa2s8ipxrCdXNOyn1LGsDDN9+/zN5JzHOmAMZ4WAouPqwFKhyiZqdnu5igwxLCdaEmbPmJP4vMpsHh9Tq+IkhAZF1j4L3pRhysqkvEaTX+G1vOGF/NHRNZ6qkV3PSZ9VeKd42fkx+krae/ceSF/MLuIeKb03mWJDy97vlop8Ujk6XvWp/BWjj4xK8ZEJySraxC8J5zBc/QljBng+WvC/jxvk+BvDiAO+I1DJMw8M/ra2byKWMLqZWTugwDH/Uzt2/0RSJNCzxXkrg6RFTKHURum1RS0PPBKUUkxOKnsiAOn+rLM4LukPyNoCbeFNWmDicVDmxogqdF03q+nd/Q1HP7bfOZanic6BWpx9981YAeFoDtkRPtcMLVD0uWlebKzrJdq8nZA8wCV5HJ+kzMSGNO6bS74JdMw6Qs40RG6U8JO+C/kWMU5JvS91cRmpB90Qgxg6JkEMoWVNXAcv++BNsiEbAYhKG/lffXhaVjUFgcWfMGvHf8Dhr77mfnrQaMY1zEQUEcZkhTXed33YOmCvSA7ew0pZn87lg18iZkhjXkJGMUNVY4TcKBKJqH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(86362001)(66899021)(36756003)(30864003)(2906002)(26005)(6512007)(1076003)(6506007)(186003)(107886003)(7416002)(7406005)(41300700001)(83380400001)(478600001)(6666004)(8676002)(5660300002)(8936002)(4326008)(2616005)(66476007)(966005)(316002)(6486002)(66946007)(66556008)(38100700002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CWePXg6oVG1uscTHA/i11d0AHSxcxOX9tDmKnMYKz5lIote2h6D14WqRm1np?=
 =?us-ascii?Q?+BzD0MKHdT2McDXGice+JuLIudH5pgYp02od9TDsQArEotOZmiTWw6XD5EYv?=
 =?us-ascii?Q?cxR749R34GqcBNF4BeIgu+NiaaAfeRLJS3KAC/1gpm4yLw7CDk2Epst8PVL3?=
 =?us-ascii?Q?SL6qN083ZfWKRE9f93+FSNcZdZUpgMcTPEY946MeTVAg5dNPe4K90Tha/ZmU?=
 =?us-ascii?Q?A6oajiEHv0uYXFUzOICEIJyuOD/8IU/ejgDaloa0AcQrHS3hNqOyaiT7+Roz?=
 =?us-ascii?Q?7vMcWVu+nOhhu/jf0mfDe+hWopRPyVLTiJwuPKmQa/43rSI91SeUvCm395Ie?=
 =?us-ascii?Q?Dpt53ekO+r+W7ItGXn4QCHuQtswWy+DYdco5kVpnL7HjvNXM27Y7ynJD92ij?=
 =?us-ascii?Q?BBFA4ab1Z/0LyXB0Vyx26dbSArKxZuW3tsAYG640UlbbR9X9pR+tZ4FK/Kwk?=
 =?us-ascii?Q?wcmdJPvyCKHzW/srJxcd5oHbAPMeYwZ04hIGtTAInt/xgaB/p1CaC3x5ckba?=
 =?us-ascii?Q?VvISEbagV/D60/oGO8iX53Mm0senqR440splePr8+qOvfM9yirgDgRV+0/NL?=
 =?us-ascii?Q?V9hMavZUN6dcO3pBYKc5gj+qsExeyZOwuKT70WcYWqYhCxxi2P/5g2P+FX1R?=
 =?us-ascii?Q?WiSt+jify0zfM0jTsQ0hj4Q1fUSJymO2xfB7FbW8Iztd9+osTOjCUoXTqnt8?=
 =?us-ascii?Q?FbSepBzHPthCn/ItG8KzhEK6SQyVjD8htAF8FBTH7G+HB486M3T83JFVTT91?=
 =?us-ascii?Q?BudHkXKLv+wNo44ZB1TChgev3woPUEprpXlziaPMbyRFEIw3cFgReyWq9WeU?=
 =?us-ascii?Q?6z4xF6gG9/7RlFgBK9riAee08O8LfkM7vOUJyV1HjztuhA1SkvGFGppP6sYB?=
 =?us-ascii?Q?7NPIrMHVx8hq8gZaLD3uuGI3TQzDo0CVn0yd3hzFEANNAgT6JR++tEmZCYwY?=
 =?us-ascii?Q?FIcPohgjvgeXh/7iYbmLmoOv2AVmJH1xxj3VwcZZ0rgcy2XRO+U+BLj0DGMl?=
 =?us-ascii?Q?UiBVa9TpegzVGxzC8N7uQJjrtvUcd5ffg6eTfi7h+uKOamWGPe9iYuosyrIv?=
 =?us-ascii?Q?I+kAp1Hd5efC6UyCuNAGQro+YtVgPdXftFU6u7iBPUShZPtuzvBERsZIUMN9?=
 =?us-ascii?Q?edY1N64b4mnvGjiTIoPXlnPCNv4sN28fcl/244R4rgM0KF7iobb2/skI1EKE?=
 =?us-ascii?Q?vV9+hTrT///qAY3SiVV7GnjpBOA91r1AsN13o4cDciGmefafCGGXg3Azxshv?=
 =?us-ascii?Q?h8XRysAvbXUgsrN8irvLOrkCX0LC7OkH3QfJ9q0a/k5DNUofPSoxae8vCpJj?=
 =?us-ascii?Q?2C5vjcAaAhlDbYJs9sQcVW7SOX79OglRgwrelRBf1inzJtm/TbpthIwPD3Vt?=
 =?us-ascii?Q?l92YB8/p/VLqx0H/Oje29jbiOCpI8HPk6JGTZ4w9YLPRo/6bd9/ergRBPDuY?=
 =?us-ascii?Q?B2tzL8xDHToigktximi0bBN3xxwrJlxRa62ixFvqZbSQyAGqbLTva4ZLeLnC?=
 =?us-ascii?Q?CQ0hp03X0kKupo3ZsCfYGq2KyBO4o21DR/d1aTXDdUXVW5L1NmnlydUNRZc+?=
 =?us-ascii?Q?PV9xwWvAE3t3pE/EpMwBsBX37bi67YVNBBhbSeFBXLK8RQNNRogu0e8MT7Bc?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CRBtzbxxgVZ37roemh7c8C8qwsIMLZwPkxuK4bLZP6o5MkxIohMnC81QnIZf?=
 =?us-ascii?Q?wElRv8iCBPnBsZMcZwYvLneDobmuIa0QyxsUnFpunC491g8jORlkgsf9lB9T?=
 =?us-ascii?Q?vqAVRD+BW/OI/k67+exCznKIR/B5EDqL2Ub4B7V8MKBLy5E3oE9QFROv3Ii/?=
 =?us-ascii?Q?MWRiWafHshg+tyro52J0hztjg8qaJbPX8yucRV8zO+atVYS4HU6uPrH0aMca?=
 =?us-ascii?Q?l6Yq3osRGZAk0wwCAzWe0aXss28u/VK+xd0Nf/iHF8d9etbRI64Rnk7IKlMB?=
 =?us-ascii?Q?yFnFofpXstz+bkvTf+KOawUdOT/6PooTfWeyJ0Ahgbo7kK2p4Eh3VT3dOPvq?=
 =?us-ascii?Q?qfsjO0OuzSDK+qpNUN6vT1PggEzrF1z9eOmhfytqm4hGOXFTiKauuwP5dK5i?=
 =?us-ascii?Q?jlf4XXjhzTIWGcPLTcy0iYGYID8BGSmsNiEyFy65T9QqS4Qgqg058RCZlHip?=
 =?us-ascii?Q?2sv1n2F4y/PjXlTriqp4dpwrnOYQLLTeJrCpiJgA3uR+Kc+DVDmqKCC1+TaF?=
 =?us-ascii?Q?yYYxtjXycZAV+llB6NxTTh6pNsq3JqvG9CPdqfXvPV5/9T25NCVnPNXcqNGt?=
 =?us-ascii?Q?eyKs2ETJ/BWsRnl9N9jz+z8/+ODq1di5wwnep3GlWAAQXYUA/iUDD/Cqm6+y?=
 =?us-ascii?Q?FWMH4d0z6rQxzJ10UpRus0xHBu+NLFvSnx2s0Uqp1FFKEAWt5/cGPugfLBhs?=
 =?us-ascii?Q?xkEcEhxenhpS5BYNDKvsU1eTpkkPp4cha0YazOoKYyIzvt3vLvTiBZYOSfE1?=
 =?us-ascii?Q?OdSpU3qDv4D2g77pfT5QeKzt+7F8P71ljuPtYOBEmp+zsDpipiVeG2xNgwzC?=
 =?us-ascii?Q?UjIYoKFcEj0oZ0tIJAXn7njqxnFQbnYZlirmZIWwZxwNYG3MAYz+fzA+9sHJ?=
 =?us-ascii?Q?KQhowiuq+okfUFrmQ/meSY/EzfQUg93EgmDkTh215BXNsV99m9QkFgyV1/c1?=
 =?us-ascii?Q?4Ddwuw9oa3zWPXNjnQzKV+AgiFG2CXjfib5kgd1LT+9FBLphYRGJKN/7sAxT?=
 =?us-ascii?Q?R4g3hd5We4/TlY0h8IbBA9QDYPIYDJzzq7aDJXqLACSgFQ5m4yIxXAuHTdVm?=
 =?us-ascii?Q?XuN8WTPJOPM/um0slWzUmFHOrJ0BXgia+zzF8MlRwDm58qsIdI0D3SUeHXcG?=
 =?us-ascii?Q?jhDR6nYA8JFU1UYgv5tHWxSZpPV1RB51EbawdURNgvCL7D2FQ6qffWaNuBjB?=
 =?us-ascii?Q?m42xyxCXiGPpU9aDJixHW1EchBPUmkFsCd+GM+H0zo7sO5YXhPzhwd9tbPJB?=
 =?us-ascii?Q?TGn/wbstCbbZC8V/yxf5lewwCg8FEucEfm+ldiU6GAnnHiM4MB0Nv23zhsaq?=
 =?us-ascii?Q?OEHowfcfpAfxU4nAQZ7NmQcZbTxPFPSqLshRW6IyiuRfpuAckM+m5NToOyZ/?=
 =?us-ascii?Q?jFmVH3p20RT0n6jylocTUDA6+IxuTFwzo/LW3JB22uOKJO6MbU5CvTZkk7P1?=
 =?us-ascii?Q?L+1gD3v9wT0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72afd034-bef2-4d27-6411-08db6b890512
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:24.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBX9RlHOylFmVYYkM7EfquryR2nsO1BPBtDLHR8v4qKamUQgvA3b7O+7qloxW5DvVn3hMhnLSkg83qsTPLdg+Q3KjIM0v1Ytm7ZPug0/bmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120180
X-Proofpoint-GUID: P9DDJA4UXUMBQa83ZRhza0hr3mmZUKIB
X-Proofpoint-ORIG-GUID: P9DDJA4UXUMBQa83ZRhza0hr3mmZUKIB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is dependent upon "refactor Kconfig to consolidate
KEXEC and CRASH options".
 https://lore.kernel.org/lkml/20230612172805.681179-1-eric.devolder@oracle.com/

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, purgatory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   CPU and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2023-May/027049.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v23: 12jun2023
 - Rebased onto 6.4.0-rc6
 - Refactored Kconfig, per Thomas. See series:
   https://lore.kernel.org/lkml/20230612172805.681179-1-eric.devolder@oracle.com/
 - Reworked commit messages to conform to style, per Thomas.
 - Applied Baoquan He Acked-by to kexec_load() patch.
 - Applied Hari Bathini Acked-by for the series.
 - No code changes.

v22: 3may2023
 https://lore.kernel.org/lkml/20230503224145.7405-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0
 - Improved support for kexec_load(), per Hari Bathini. See
   "crash: hotplug support for kexec_load()" which is the only
   change to this series.
 - Applied Baoquan He's Acked-by for all other patches.

v21: 4apr2023
 https://lkml.org/lkml/2023/4/4/1136
 https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc5
 - Additional simplification of indentation in crash_handle_hotplug_event(),
   per Baoquan.

v20: 17mar2023
 https://lkml.org/lkml/2023/3/17/1169
 https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (8):
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and CPU hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: hotplug support for kexec_load()
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize CPU changes

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/include/asm/kexec.h                  |  18 +
 arch/x86/kernel/crash.c                       | 140 ++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  63 +++-
 include/uapi/linux/kexec.h                    |   1 +
 kernel/Kconfig.kexec                          |  31 ++
 kernel/crash_core.c                           | 355 ++++++++++++++++++
 kernel/kexec.c                                |   5 +
 kernel/kexec_core.c                           |   6 +
 kernel/kexec_file.c                           | 187 +--------
 kernel/ksysfs.c                               |  15 +
 16 files changed, 681 insertions(+), 205 deletions(-)

-- 
2.31.1

