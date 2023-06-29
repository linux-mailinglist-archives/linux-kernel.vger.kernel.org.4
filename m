Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF2B742D82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjF2TXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjF2TWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D2A3A94;
        Thu, 29 Jun 2023 12:22:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ47hX020741;
        Thu, 29 Jun 2023 19:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wvktzrp4ADI2Sb1KaXQf3XL32mNVn5LLn1H+a7D4wH4=;
 b=EkFt/LLhmhQbiCJSYJas34RWBsdy7cFGLGOPhmSur7d4xSGrjyLAS13dsJlIr/MGSWNM
 lhRG0g/XmVgBQ32S1ExHBhDNADyVT4YN/EdB8WewptmLZoVkEEkod2MIAlijWsHHkq1q
 fZpNbsSPgZc2koI8c2czCvKRg1iQwktHuM+MwMhJMH6aoFuzMlwiQqW9kfCjPgNRWl/Z
 LTu2GxKg/GUw50EnF1i9+pEuSQUk2cWnrVNgaTKG1eW1BRuSeg6P3gCHA1WTSUDRvEEv
 D9GJ1sJ3drx64x0X52zEl0/vHiIyOUfh2yfXrFoXoYRqE60AlgnyLZ3DJfAGJZU6oj7O xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93dp9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TI3MbU013057;
        Thu, 29 Jun 2023 19:21:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx82gqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNgJ/bFvO18ME2IcwSgANxwfD1bn6+AzgGEybHTnUcimqigIvjzV+lJ9B7tPKPj/ttPbpz+P7cEkUN00XncW1Yb5EPv8HpADuqfmL6xpzT/eMr+rjhTcKhU6MLzmicli4eiAtXdYxLej2juEMH0NRMVTTlOnHH19WB7dpffitvSP8NNqRaIbRe+nKVyFumK7HIGSp1EG+JPrevbOnRpqeV/ab3MGU2IC08yQV4jaCIuSwN488BkGj7xqGiDZSUg2CmFCKG4sT4uIHwEZLwR23z5d+iE9UjPqtMI+lSTf05cedlTfsL2urPG3rUYnaRLpEhkdICI3qlCb5H9G/TFXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvktzrp4ADI2Sb1KaXQf3XL32mNVn5LLn1H+a7D4wH4=;
 b=Q8NOIvBy2ooVelOtzP5pgtnKcMk7XwI5ryVQdZyfS+CBok12JAa8ygsJJ96li20VGL0Pt88hupqG5llayjVvz4+hNdMds5xQqj5YABe++OwrSfsGxyNt5VIFIf3XMQ2QjvYAgb+vXpFPXMFrYxlXFk+9TKwTS/Ew7kIjvIxTv1I8is96eIzNMO3R5RbMa//3Q8ejmDHvcMcdEgvirfbpxWbq0SL9IwUv7XaynUAW/EQWbYcicOCpAUA17U3ROB6vv0HoGLGyWGgWI2ZMx2UVQYPbKnqZhHbcy2Juq1ImVVzPcXMAAUFklDIP7m3SyYiIGnrUBomuw05+ay6eWUn9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvktzrp4ADI2Sb1KaXQf3XL32mNVn5LLn1H+a7D4wH4=;
 b=sGLWvVUlmmxhSNx8lokZffMTK+zIlR9YRV4EPMw9AFvNqV6becUCJgnBrnBOcJhvOqiyEXCDkXyufDlS8X1gCwjR1lOKyp3op43HB8Nov0sMcQ4G7b9pZQ+vnv1B3PWqE8X+v5fFXbhPoweFQGAxwLE8Afsu0bYxNcn+Zi8VLdw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:44 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:43 +0000
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
Subject: [PATCH v25 06/10] crash: memory and CPU hotplug sysfs attributes
Date:   Thu, 29 Jun 2023 15:21:15 -0400
Message-Id: <20230629192119.6613-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:8:2a::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: ff73759c-e872-4650-94a1-08db78d612ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8NOb2P5+yylh4zNq/EvaknSi3i/IebOieKonb3tdVC24bHea4N5B+hmp5OiupqDOrMRJy6kub4L2Dk6XdDQuQ/ObuMK/2ypKj0FD28auYnt3KkaG0eliV97r1srIaQFKDFtHrp10Il+17byEWR3Y4HwXXBAp1LlC7YfO+p3LO16E7rlzIp3sk7WL+X4jzkdtnX6GO3agAmZ02CSwQa1lecmIlHjL2F3mUKv24v6tF0Eog59Yuno0GnkkbOYcp3bQl4uh/dR1z609Wyse6cTnmvZwj+2Rmnli7tpSi2sPLRwdqMg0qlf2e6Ql3CP60Fw1eKO6JEmQAzIYRbx5QtwMM8r8smvN8CwrZ/L70RS20mhBYHfJgC6J1gQsF2GalLk2EBxXTd/4Ijc2vHP29843QKJ8udGnRL6+PUQ3b994p/t1m3n9OEDzwUm3c3KsfC6WyLkSmGNcwQw8EkdvtSXWDjcIJKRm9LrUS1zhgeHe7qFBlBDmKdLf3g8nm5QUZVDuQ2gwukX6DWYcDCSNSUa58qclwXC3JHob88EHJdHigIiRl/WS8yB4ZaxMBVx5u6J4FeiTYr+Tx9piLALezQKKCo6Jv5CIo0i88C3ewY5VzEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(30864003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6ZHZMnDwCxEB2DZ2SeQMHWMTPZ/EkoVA81z3breZb4GFLb31JlXnNENEPZ1?=
 =?us-ascii?Q?/bp22hJX+j73d/69QTryYzwNjt4QnwDKJP1g725Ro/REsqnwYkLL6d03xW8k?=
 =?us-ascii?Q?C5HtWrZ7LPV4H+rIlVvpZD4t/OYuu1uSE/gQAUJuKYyy9JbEyrOj/BtcCY+A?=
 =?us-ascii?Q?eHsulCbs4N/CekHSOwn3pB9x75CYMhBa+rZlzauth5NpdOwYfYLAT9uGfnaO?=
 =?us-ascii?Q?5T9AL+Di2+zGRg3nMndTER9dtIkGi9B6MoQfrE8NIApvYFR3bpeD/dQOQApy?=
 =?us-ascii?Q?hO8YlyX8QvQ6b5Xj1NKX12Edzq7RlsPVrp9T7b96s60wRb/D15hExDZni2KL?=
 =?us-ascii?Q?nlPr9p7KkS090My7lhLf7Y/LCSwojpIIJ9XGgZEjv25EWTZ394+0QgUikYDb?=
 =?us-ascii?Q?HDbxeXLkqotlnnnsLNPKhecJ5gsnTGSyuEwISMhyet/obdrj1NRwlGXfB0G0?=
 =?us-ascii?Q?EP2o0upAGHAskG4nw3cOA5wAzSj1o2tII8OiVrTZhx7E24TWYe91lsHpXk+v?=
 =?us-ascii?Q?3aK2f9FYssiSL9g55ZZxlb0HC6pvs71I0zGUSDtRucAnGcS7CS+WAPUS3Rgd?=
 =?us-ascii?Q?z/coamNdDG9rLUDj077+2F4Gf0qPad91UpYzOsWDY2q0b2wAoHDc2T7/JBtp?=
 =?us-ascii?Q?fbzjeiMjdkjqLAVaf3JQBw3s35sT2EdW0dHnJ+t3jT5X+q8COngHTTfhuBOv?=
 =?us-ascii?Q?J1BjcPbaOV50ySUw0+X8+CszHldyzGUcvcYIiusMAoHxvQCJIClBK37BXkGH?=
 =?us-ascii?Q?VwfsjLAG7sF3XeK25kWbfUzObDXMGo1AD7LhLXDZzQfql1/w3LwHWpVmQCJF?=
 =?us-ascii?Q?PZvcILxGXxIbZDbnOjPg7DMFIHiIwJhG+HPfu8qNQfDkP8Es/i9mjZp8gyKp?=
 =?us-ascii?Q?Y4sF5I33BeMT5dc3l3F0d5Q1I9V2QSvWrTi/qH+/+jRcBp3SKkLEc/fQAQ/W?=
 =?us-ascii?Q?hQEHxnTxt3/ni01XQkgUAxh7gW6TmhK6dzMkmuL3ZvYc1sxXH90/wGgh16dk?=
 =?us-ascii?Q?FTed/4N9rRibhBR+XvC1Ybx6uUl7PIaf5CbvH66JPZ8u6tPXM+J/k9ILfmgQ?=
 =?us-ascii?Q?bHnSkmnEF3Wha+/erzZGgBeCGHLZ2VX2DCFxWWNPbPmi4wQ5oa+QdzAqQMjP?=
 =?us-ascii?Q?d7OG767+o7HaLPG+iHtxqmr+0tkM4fcBg5GR+kASp3wrJ6hf4qSFSh1Oe2Ef?=
 =?us-ascii?Q?Ux5oyT35CpBVacBe3YUE+0iRrMYUWcCk6U3DPREy5obqMGAtNF7hu123R83B?=
 =?us-ascii?Q?NDzGiPVOztuA5XEGLF3CTIQFJ352lRdl7WpbzVwpnQ/d781lh0N7NhLVV1eW?=
 =?us-ascii?Q?VN3oduSf2zEuIinBybMkaMiV/vr1B1/OK/XQhKpG2zsd5VZP65TFuCcRhVcB?=
 =?us-ascii?Q?MdTf8riL+ZK0SAY43r30AexBcAZw5E0WOfdYZgQmnd7t6cPMucO/22bPzgFw?=
 =?us-ascii?Q?weMmh8GhL6ecZq95FoBeO7AzXWS2gWAK25D8X0SG0s//kRVoLPoD+XbtPXAD?=
 =?us-ascii?Q?tT9q+TWpUh0lh5GsISLTvjjguVbJAGYAJUoVTJBe7p/u6SlVVZbb/b0OznOt?=
 =?us-ascii?Q?LNCr6OEFdBjeIkxj5goHxErTkkuVhYfE88faLHdsfrEIRGd92R3yqqVv1Z0U?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZZzr0HadkE7rStBygqWe9mObrcoG6ROhIiijlP0t2acQryzFhXyIk1gVXmRy?=
 =?us-ascii?Q?a4pDyGZHPBPKhaKFhZuZcGmMCFmgCSyUk2JZXloUTw5ZBo/JfS6XApYrqItk?=
 =?us-ascii?Q?LzrHqtwCtpRYZmPEvQaJdxl12WaHmHOy23eBnpodJL6qShCKyhgkRQMdD4qU?=
 =?us-ascii?Q?Ez+3EG9DaRkdQJvLD4ZtooS14q75luzXstsaWdhU6dXVvEie18meLTpgT9wl?=
 =?us-ascii?Q?zMS38nEPQGo2Tys8CZ6MYBCRirmzDdYJ8tZxZuxu0BykyHHQ3p23D+SZTR8j?=
 =?us-ascii?Q?54P9Z1MR+05BsTTqRV+IgjzdWQ6YVuIVqdV3dvUmDR1rrqVdtLg2AWwTbOwI?=
 =?us-ascii?Q?qnbXQWR1FLycU1bHpgrcTN0iIgBiVpA76bZzGAgLWR8Z8lZHGTyzo2mhHYGQ?=
 =?us-ascii?Q?hL3vsNhNwV1FrA2UzPXwbKPiBW+2a0rzh5SjaUpii/zqkZlI/MAuJ86KeZ5l?=
 =?us-ascii?Q?ISLtiiQMuRBTy75xAkyQDmgDqJDVHkQlc0fjchmGZ2PvHJIo1l3x0IcldzIj?=
 =?us-ascii?Q?BeerrnCltjNcVdQlZIMsCMVIhYVZdhvTt5U3sOnPtOCuUFE9fl5FxpYMDlQF?=
 =?us-ascii?Q?BJDt3LKHR98CYRQ6U5zOZjeXn+qKYdmuZhp3DCm9GXxDtDDcexI9a86LXAf4?=
 =?us-ascii?Q?wamwU9zkumNUT/sgklANdCO3rj9/WbYFHVsfCyC8A9JO6ScemrllkULwo4rO?=
 =?us-ascii?Q?lIyu+6CUrF+huaV3SkHnD6crUKoyDH8DQbWLR9CQPMrTSDTAsj1wD1AB8cyY?=
 =?us-ascii?Q?mxWvTiFhlu0pFqO0C+WJevjsUiC7xMBjulYLfjGrXBMFlol1j44cMiE4LMRd?=
 =?us-ascii?Q?6nnZk9X5nVgbv6YPWMlodmSGbKbqCSPkkkpHMbWO/LOHGeNNFFD6NX0Q6jwr?=
 =?us-ascii?Q?EUX4dN3vdj9UWkWfrd0q2XzTFtmBZdV5qMABPDzHsalMZCKdDD1JhUzWreUF?=
 =?us-ascii?Q?7dkHASEJYOC+jWshNes7pfcSR75fIS8LbfVaUB4N5qETD9caGHdihyv3SdGO?=
 =?us-ascii?Q?JR38U4PuGGuZn6C48lFqrA2slpSqTOQd9IE755OeL1TkodUbQZu02TantHsf?=
 =?us-ascii?Q?cvFU9QGZUuh0JZauNdBEKkkiLhp8zC1MoXNQtSux6cqCc5Bfdt49muBD6Z2r?=
 =?us-ascii?Q?L4g9vRg0qBGTVWSe8nEwze4+WvKtOXlrIkrbTM7QmvuOldzzi82CRLnuY3uj?=
 =?us-ascii?Q?SW5PcYGmZ+unR2SVm+muv7sYEFOA7nAoOHopKr3tpfD4nKQf5Geq3ctuQc9e?=
 =?us-ascii?Q?9MxSHjk5nuYoNV1AQNM0qcx9bOSP92m/FaS2z8cb9bg9Q1qaG+MHiOQfGA3f?=
 =?us-ascii?Q?rOCya5NwH6u6Rc2ML/1xdIlx1/XOYxj3TZXXZOsiskYsCZCvzOd0CdqMzOg/?=
 =?us-ascii?Q?ePRtI+GPKgHQrbnF0eZtcgEQ5uYwFJcWPZj2qWrSUQ7XFYeLlkMQQy5mMsNG?=
 =?us-ascii?Q?AmoNK7KM1w8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff73759c-e872-4650-94a1-08db78d612ca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:43.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNP0nPLpXwAEYZM9N2AwKWG1A42vbAsDkxHYaTwbOot9oKOYD0VPRZZpDaowKgGQBIrYdEsjprqpHKvicLST93LWo+t0B0miNoo3fIF+mqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290174
X-Proofpoint-ORIG-GUID: mGDalQwyYpfaMvd1a9YR0hICtum942GP
X-Proofpoint-GUID: mGDalQwyYpfaMvd1a9YR0hICtum942GP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the crash_hotplug attribute for memory and CPUs for
use by userspace.  These attributes directly facilitate the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, expose the crash_hotplug attribute to the
/sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, expose the crash_hotplug attribute to the
/sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading for kernels
configured with crash hotplug support.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel updates the crash elfcorehdr for CPU and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above rules
test if crash_hotplug is set, and if so, the userspace initiated
unload-then-reload of the crash kernel is skipped.

CPU and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule skips
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process CPU hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/ABI/testing/sysfs-devices-memory |  8 ++++++++
 .../ABI/testing/sysfs-devices-system-cpu       |  8 ++++++++
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 16 ++++++++++++++--
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 7 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index d8b0f80b9e33..c50725ebebb7 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -110,3 +110,11 @@ Description:
 		link is created for memory section 9 on node0.
 
 		/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
+
+What:		/sys/devices/system/cpu/crash_hotplug
+Date:		Jun 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for memory hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ecd585ca2d50..598b0fa67481 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -686,3 +686,11 @@ Description:
 		(RO) the list of CPUs that are isolated and don't
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
+
+What:		/sys/devices/system/cpu/crash_hotplug
+Date:		Jun 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for CPU hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 1b02fe5807cc..eb99d79223a3 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -291,6 +291,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index e6f5bc39cf5c..54581c501562 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -741,6 +741,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a cpu hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 2455cbcebc87..7637cd1dd480 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
 #include <linux/sched/isolation.h>
+#include <linux/kexec.h>
 
 #include "base.h"
 
@@ -130,8 +131,6 @@ static DEVICE_ATTR(probe, S_IWUSR, NULL, cpu_probe_store);
 static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
 
 #ifdef CONFIG_KEXEC
-#include <linux/kexec.h>
-
 static ssize_t crash_notes_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -286,6 +285,14 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -470,6 +477,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&dev_attr_isolated.attr,
 	&dev_attr_nohz_full.attr,
 	&dev_attr_modalias.attr,
+	&dev_attr_crash_hotplug.attr,
 	NULL
 };
 
@@ -505,6 +513,10 @@ cpu_root_attr_is_visible(struct kobject *kobj,
 		if (attr == &dev_attr_modalias.attr)
 			return mode;
 	}
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		if (attr == &dev_attr_crash_hotplug.attr)
+			return mode;
+	}
 
 	return 0;
 }
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 7294112fe646..a0b0862871ef 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -25,6 +25,7 @@
 
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
+#include <linux/kexec.h>
 
 #define MEMORY_CLASS_NAME	"memory"
 
@@ -494,6 +495,13 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -915,6 +923,7 @@ static struct attribute *memory_root_attrs[] = {
 	&dev_attr_hard_offline_page.attr,
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+	&dev_attr_crash_hotplug.attr,
 	NULL
 };
 
@@ -938,6 +947,10 @@ memory_root_attr_is_visible(struct kobject *kobj,
 		return mode;
 	if (attr == &dev_attr_auto_online_blocks.attr)
 		return mode;
+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+		if (attr == &dev_attr_crash_hotplug.attr)
+			return mode;
+	}
 
 	return 0;
 }
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9903dd48e24..6a8a724ac638 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -501,6 +501,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

