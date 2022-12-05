Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B985F642CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiLEQdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiLEQdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:33:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B41EED2;
        Mon,  5 Dec 2022 08:32:54 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Fat9X017554;
        Mon, 5 Dec 2022 16:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QXL/IKG7+T3FqHTBBoamSkfCy0bpbzeigaZlZ7VGoYg=;
 b=ofIps6qaV5jrv72V82Gltb4QHqnkmvi28jHXqgaYCaM/KZEVm/3NbbOoTDQ/8LzmuNMH
 CUT8w/UwyESuEJcMATgNkEon1aPCBJ3B5o4Fzn8JQClCdc1iwQg+/2IguEcWBf2rWA4m
 hF7vA9pSfaT/1nAQqYJY+8VTugvzkizOffPK8GDJHIdRB4p/rPsZCCNAQpEgHWYfGF+3
 J7JtJupzQuRo4h/QO/KTzT4JtA/3mgvtUzRjVdnTz+HlHg7GHD7/lef3VkK7xMX/CN5B
 ccC/J+8dhaJKMXuIwOEcU4tf8KNoPcizoG9ej9iWaWIlxfqKnAPNPGc+YZKzI8CB4vfu 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ycf4fsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5GQvl7005382;
        Mon, 5 Dec 2022 16:32:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8ucswawq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 16:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUsx7Ku0UXZdgWqqXwjul56nmR+zLfsRFhggY7ex7JHHrP4GIGv9elOKbT5UUjvO0heCe8kxDm+GdCsZ7dbRVhqiBZIZUfsWGwVfp+/6vf/gb6/7C3jDWF3+VMrPSbaW5e1Q6LghPqypxjMLazzmPhmhXm7Iu2VjW80gg/5SuP1zGt/azLNHeg5GuiT6LCBjlbrGFyYHoNDO3phSSU6yR8zfTdkwntaW16YFaYcfw2pypUP2PZCIPJBEiuKZyGI2dt6MDF85KEO/EdYScVNbDkOnur+mMZZMJvxfvdp+CYCLruQmmJBeocVAIlnFMUcxHEdPQbFBsPZATsEs+E05rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXL/IKG7+T3FqHTBBoamSkfCy0bpbzeigaZlZ7VGoYg=;
 b=eqC/g0U0XStU4zbmyuQFtvU922dZBM7q3tZ1HIYqhdaXA8sGayiRB0EF5ywi1ztTqlPrMJJDQ+q+ruj7ZOLRc2Z2Lbu32jZSZ7sxtAptoMoVMZm/u7mq1oZ+zsv2NNoXp9iGzW0Ml3LTxbV9NN15QGRZXlmzWJhR/JcHvheU9+lz4zMk3vk7uWSFEAYwqpEn18IyRPA5JF87JF1bnTNHHpJ4SkuswDNMlLRDeoX4mo5JRmeLjlhgEE3ycvFmpXihqtyH/EDeu1hKYdOoVK5Busgo2LWJoxLZtTcwkKGIM9khLy5jTXlLnSxBJ4ArHavstWZDAKOguQ56k5ULXb7cWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXL/IKG7+T3FqHTBBoamSkfCy0bpbzeigaZlZ7VGoYg=;
 b=YqbLW1oZqJiTLZUYZ0DlyV9VOnb6qukTQdKiNSCN0tQSdXVCVwdBkRccx+WgSn0KswMaI3LnK054XKrBCnH9FFQy8aAQV0ZhNXRd3Jc+3xa2FUeEd+tcARc4z+GZbDt6Bt9wbkAyARzxUEa+FVpWqzEBJ9hNmlXCEoL8JYehShQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 16:32:36 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6e94:e2a2:ca1f:2a7%9]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 16:32:36 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v10 05/13] kbuild: remove MODULE_LICENSE/AUTHOR/DESCRIPTION in non-modules
Date:   Mon,  5 Dec 2022 16:31:49 +0000
Message-Id: <20221205163157.269335-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221205163157.269335-1-nick.alcock@oracle.com>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc47e3b-87b6-4545-5279-08dad6de510f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOd0o73YCfsU6IMg95A+sW1Ro5YBE+EcPciuEf/oDqYjuiqzyUQRWs/DyoZZtKoZpPOYVFyuzCqi2U7wEjJC+k1slYLb5tZSc74ho9p0MeuhaLFqGcos3bPYKrLSmrCaw8ylcgFiGC/WJRay9GeUdVuFQpQUradbY5GVQ5EosLRqpG7P+aLWlysn0fcjZcACntOej3IIiGFHPOyI+rKmkSJdMYCJ4NgaNQm7O9fi/z3gK84r5YmhW8BdVP41OIc1rIxUk1afzI4vQQlET/3Yf1zv1UN6Es5gfTNH4vytAmxuAFtJq2GBwuc3D3phK+dwj7/vjT4THb4Un+vnDnYEc33jjZlGAL8Kek0VMvTAnPthW7HxyjA6e3wMWKFN2/HCaXdaktuILSrR8Ivb65YaqvUEPhaUKRbDDOt8vT+c4M5/7dJjgiCrmCpCIhzQRr/nwoFaDFF29fOMtpZPsIqa7NvGBYzT/JXkuDNkyQhZv1hdvhORSJ3YF4d+jJSndjXGe7jL6u5b7oatLSH60tY7Wk/nLwacw5IX8b3dmypVDhrG+efxUnvIzdUOaSNP8RV+lg69j8leX6UyOL8LCSzwp7rOYfz32bWsUB+eL6kJnItxwMa1CKZwzAMCZqBMEtin5XKnzRnzsXELwn4ODCk0KVGH4d9EL8jfAIaw53APRYcaJ3q0v21yput4lRcBGmvNkH1FbjA1AQMIljZJGvl5Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(86362001)(36756003)(1076003)(2616005)(41300700001)(66946007)(4326008)(66476007)(66556008)(8676002)(30864003)(44832011)(8936002)(5660300002)(66574015)(6506007)(6486002)(107886003)(478600001)(6666004)(316002)(186003)(6512007)(38100700002)(83380400001)(2906002)(504134003)(241875001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZGa2ZIeGkxa0Q4bm1uSWZ1NC9TUzMvNGtIVlNyQ3ZKZDd3M20xS25zOExF?=
 =?utf-8?B?UUpkREJVeWN6cEJ0ZVA1SFlWcnl5eTVKRmFCVndCNEsxM3VWQmVLZHNScXE0?=
 =?utf-8?B?Y1FYWGFrdFlPeHo5QlFmeGVKMWw0d2VnNnJXU3AyUmhtTWFqYzlweXF1WWE5?=
 =?utf-8?B?RGlkYlNTRnZxdWNabktWV3A2bE5rMno0UXo3VHFnc29sUEZ6Y3poRmQ0SGx1?=
 =?utf-8?B?cWt3aWpSZTUxN1Q2N0xZS2pTTGJpVjZudWJvd0d0WmwwTnUrdU9tbGxpSmw3?=
 =?utf-8?B?VnQ1OXFUZUVJS0NtclcwVE5ScHhrQUtTZzFKaDlONjhHbkhKOEx6bFRpVmZw?=
 =?utf-8?B?ekZ4bmRvMERuZENoVmNIRkNLeWpEQUo4MWxMc1dzMDBzY2o5STlCSFdpajVF?=
 =?utf-8?B?bFlvd3F0cWpkWHc1ZStrTVBtZWZiZjVTSmhsQityOGY3c1hoZ0QzeFVBd3B4?=
 =?utf-8?B?R2h5NE8yMlZYdHpxVFkvdkx5MGo0b2hsaEFVYTd2aERIT01scXlMQmdPMlFi?=
 =?utf-8?B?ZFl6RDM4N0hhN1JPOTdqZHNGQ0gzUERscUNXUzN3UDdQbm9kaUYxTmozK1gv?=
 =?utf-8?B?RFhHVGcxeCtyNEFNTGdZSFZhZnc3cnlsVU1zcHo0b3d2aVpZWC9MbEs3VEl6?=
 =?utf-8?B?c28xWXBOQTNGUTY5UEgrNzNUNElxb205K29aZ252cWdCQjVDRGZrNHJ1Ujhp?=
 =?utf-8?B?eWJSUVVLbGM1aVk0MkVPVHhNV3AwL2FVeUpMdmRMV0ZxQXV2VXhRUzVXT0Vm?=
 =?utf-8?B?ejVhSnlDc0pSY3ZXdiswVVJ0UHhBRDNCc0w2VWppak1uOFQwbzBheWdCUnAz?=
 =?utf-8?B?MUhDNDF4a0NrMG1PQzJVcU5nQzlzek5IZzlFUUhqVTRXRWhTWm92L2ZmUlpi?=
 =?utf-8?B?ZzExSVA2OVNrN05QMmVYSHRLZDVGVjBDQ0dKV1J3azA1NWxpMG1xdVZDTVIx?=
 =?utf-8?B?d3k3Z2I1b1ZENHZQejdPWGY1RGl4SGRGWkZodjhqUDhxeHFtcjF4Nmt2MkVT?=
 =?utf-8?B?MXYvRmVWS0FaTllPc0UrS04vazFaUGxrK0pzTGlScGF2TEIxamg0VDNEQWY0?=
 =?utf-8?B?aldDeStjeTd0MGd5Ymw1YkhINDRwSVl6dC9uaEZDTG5xYmx4dzRNSVB6akxx?=
 =?utf-8?B?aTF5cngyMVJqWFVYQnFaUXIvRmg4aXo3dTZpaDdHSjdHV3lSMkVHK1dqb3ov?=
 =?utf-8?B?amlvZ0p2eURNd21oUjR1K051Z0JYVmoxS0ZqUTdRZ1FGMVZ4eFdWUmZIL2ln?=
 =?utf-8?B?bTFKSENiQzlTT0hrMDdsMlZKaWZza1I1NnFLWnBZbldhbVVNaVZTVWs1ZnN0?=
 =?utf-8?B?aGRqV1pxY1gySTBJMnZNQVhDWm9yNllmZWNTQ3VBZWkrcysyNjltK3V5SmNy?=
 =?utf-8?B?cnpSNGZMRGlxRkxrMXpNK1grVG1waDVrRVZ6aXJhTmdhMHR4L1pJK25CQytP?=
 =?utf-8?B?aUMrZDBGSXdEZ2s2RXlVY0NUU3pXZlVNYmg0U0ZUK2hiR2NiMU9lV2dkWmoy?=
 =?utf-8?B?Tnh5OXB3TllsSkpaN3gwTGhlejVDZXRmTU9PMnhJek1kK3VDV0pKL2dya045?=
 =?utf-8?B?RWlWU3BZSWlJSGJUOHRQalUxaVcrb1ZSQW82TVprOVVYNEZFSlVtbmxTaTMv?=
 =?utf-8?B?a094bXlrZ0VpWE9kR09Na0loRzZ4akY2QUd0ZHMrcWlTK3BpL0c4Y0Y5Q3Jq?=
 =?utf-8?B?eTVGdEJyb1NmWUxOYUJuVTBqTVFLQmJodHFPWFN3YmFTcVI0NzRmU2ZueGw1?=
 =?utf-8?B?bGNlWExXbzBDbHoyVmtlVTdHTFhFdXgyVFhnemh1WVphdlZDRlQvM3UvVEJB?=
 =?utf-8?B?S1VJNzhBVmlpMWs2NFRrWFFrRmRSN0FSSjd2NFdrNVZ6aFBhWGZDSm9wVm5r?=
 =?utf-8?B?eTVuamJ0YWdZQVFyOXJCdzBhN2MzbFVDSkZDYndTRHJGODNlbUdTTjdyUmt2?=
 =?utf-8?B?YnJ2U3J4L2VRYWdJdmt3QzFNR1FBRTZvR0o2RE5EZEFSYlhSRldPNmg5T0RF?=
 =?utf-8?B?L3NweCtaaVIxRXdwalFLc1hUR1JPcEVwdGVtVmF6NnB3UExMK3hPS0xPRVFB?=
 =?utf-8?B?S0l2R2lNcHBLUWNuNHNiY0VjVjZHN3NlQm9XazlPU0k2MHZIS2ZNK01VUWFV?=
 =?utf-8?B?VHJNVWdDQ0p4eUlRV1o2VWdSL2licWRDN2dTTyt5RnBhaUxxUHlNNDJVS3p4?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dkFEKzB3MzF5M0JFQ1R6RXhqR0x5bWs3NnJHeEdDV1Z4cHpILzdtcUg3YXhO?=
 =?utf-8?B?OEdPNjdiZ0pzYVd5VnVXSTI1UWIzM3J5SG90eUh0eHNSSW9Ub3k2Tm5MdWVn?=
 =?utf-8?B?YUMzbTZYZisxaWJnN25IRUQ1ZWxpdkc4OGpwV1B4THhVcUtSR0hUc1ZRQlp2?=
 =?utf-8?B?YlhBaTZPc2xwUTdtczc0ZG9wQlhBZVZMbEFwTmR1R3RONFZCeXhDb3lRclNJ?=
 =?utf-8?B?a1BIRXh5YUF5WmlUcHRQUGFkdC9aaDFySS83dnBQWnJlRlhGdmlqNkJGRUhZ?=
 =?utf-8?B?RHBZSExrWFQ5TG5KVTVHZXB5MDBNSFg5MDBGZ2RDVXlxWENhUnpJREhFbS90?=
 =?utf-8?B?WVV3YzVQRXR6enUzdTZGdUF2MUIwRHV0OVgvQzJQK0dDc2ZaQlRPM0hzYTRl?=
 =?utf-8?B?VUg3WS81bFpFdHF6RjFPME5xUTBsdmx0d2lNZlVQVFNWd2IvT2F5eG9maC9l?=
 =?utf-8?B?eDYwZ01CdHpxM0x0UXpycGM1M0ppclhOQzQySUxleGo4RnNRSTJxalM2MnJQ?=
 =?utf-8?B?OW5MRmp6QVh2OXNKellzODFPTlVIUXBWdld5akNzRE8wekZNbGgrRW1pOUp3?=
 =?utf-8?B?enpmSDdra0RSZnpsNllyZDlHN1hlSHNYTTJGK1hUclR4Nk1Lbm1SQloyVDJ5?=
 =?utf-8?B?YzJ0YmNzZmRTU2NieFdiV1hQbGozSDNyaUdoSVhSSENiTVkrT0Z5Mk5wbnY2?=
 =?utf-8?B?dHN5cWxNOW1VSCt2QkNZSTcxQU84Y2tPcDg3YkVtWjVJZWg4cGlobkVnSUpk?=
 =?utf-8?B?b25rVkhMbUk0TWVlL2tPZXJYTVJiSjkzLzRNb0taeXBVMVhhRy9ZL2RhSDdQ?=
 =?utf-8?B?QlRacFd5VllmRE1nVzY1ZmZtaUF3bk13MlRuQjRHeFNCQUxPdmIzOFpRYlpu?=
 =?utf-8?B?K0lFdVVjbk02bHRNdUI3ekYyUE4rVUpnL0JhQTYvSG00NjZkbnFMU0I4VVRC?=
 =?utf-8?B?ZWxHQUg3SThmUENqR3p4OTlKNnoxZ09VM3hzWWhES0Q1YmJwQnE3UkY5L2pK?=
 =?utf-8?B?ZTI1VTlwVVJKeHFIdzh1VVBHYzhhWHJoVjZ0Qkl2SExJK1VtaWpETndGc1dW?=
 =?utf-8?B?UmdCZkpraFRMN0JJYmw2VVEwaUxWSDAydmN0YUJ5dzZJOE5hbDcyV2hxdEIz?=
 =?utf-8?B?Wm1TaFRBZGhubkRNczVqTXRoeEJOd2pPaWJ1TXVHeDlUaGZBbmpvWmNhM0JF?=
 =?utf-8?B?MWNCWG5JQlc2dUU1M1VXRWw1eUpjTjVXaW90eDJyUW9iUzVlK2VnN21XTjND?=
 =?utf-8?B?THBRalVqVWd0cUhtMlJ3UEpxcXhBZmdoK2pqMUV6WGZ1MGRYNkVSbVdjRlNw?=
 =?utf-8?Q?uDHgsJLgdjxew=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc47e3b-87b6-4545-5279-08dad6de510f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 16:32:36.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QWCzhdrLNz1Kx4LbUogOomfsc2GEIWaZw5dN2l2YIuRKIy21qVW3FHesIUtXO7X8xirrx/8tHnuKajggGT08Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050137
X-Proofpoint-ORIG-GUID: GTorPwPTkrtBUM2uX5SVu3I5ToxH8m7D
X-Proofpoint-GUID: GTorPwPTkrtBUM2uX5SVu3I5ToxH8m7D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations in
non-modules will cause modprobe to misidentify their containing object
file as a module when it is not, which might cause it to spuriously fail
when trying to load something that is built in to the kernel.  They
also cause misconstruction of modules.builtin.objs, leading to incorrect
output in kallmodsyms (notating things as being in modules when they
actually cannot be built as a module at all).

Automatically identified with the new tristate checker, and purged with
sed and a subsequent make allmodconfig to double-check.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---

Notes:
    v10: new.

 arch/x86/crypto/blake2s-glue.c                       | 1 -
 arch/x86/mm/debug_pagetables.c                       | 3 ---
 crypto/asymmetric_keys/asymmetric_type.c             | 1 -
 drivers/accessibility/braille/braille_console.c      | 4 ----
 drivers/amba/tegra-ahb.c                             | 3 ---
 drivers/android/binder.c                             | 1 -
 drivers/bus/arm-cci.c                                | 2 --
 drivers/bus/arm-integrator-lm.c                      | 3 ---
 drivers/bus/bt1-apb.c                                | 3 ---
 drivers/bus/bt1-axi.c                                | 3 ---
 drivers/bus/imx-weim.c                               | 3 ---
 drivers/bus/intel-ixp4xx-eb.c                        | 3 ---
 drivers/bus/qcom-ebi2.c                              | 3 ---
 drivers/bus/qcom-ssc-block-bus.c                     | 3 ---
 drivers/bus/simple-pm-bus.c                          | 3 ---
 drivers/clk/bcm/clk-bcm2835-aux.c                    | 3 ---
 drivers/clk/bcm/clk-bcm2835.c                        | 3 ---
 drivers/clk/clk-bm1880.c                             | 3 ---
 drivers/clk/clk-fixed-mmio.c                         | 3 ---
 drivers/clk/clk-fsl-sai.c                            | 3 ---
 drivers/clk/hisilicon/clk-hi3559a.c                  | 2 --
 drivers/clk/microchip/clk-mpfs-ccc.c                 | 3 ---
 drivers/clk/microchip/clk-mpfs.c                     | 5 -----
 drivers/clk/renesas/rcar-usb2-clock-sel.c            | 2 --
 drivers/clk/renesas/renesas-cpg-mssr.c               | 2 --
 drivers/clk/renesas/rzg2l-cpg.c                      | 2 --
 drivers/clocksource/em_sti.c                         | 3 ---
 drivers/clocksource/sh_cmt.c                         | 3 ---
 drivers/clocksource/sh_mtu2.c                        | 3 ---
 drivers/clocksource/sh_tmu.c                         | 3 ---
 drivers/clocksource/timer-stm32-lp.c                 | 2 --
 drivers/clocksource/timer-tegra186.c                 | 3 ---
 drivers/clocksource/timer-ti-dm.c                    | 3 ---
 drivers/cpufreq/freq_table.c                         | 3 ---
 drivers/cpufreq/intel_pstate.c                       | 3 ---
 drivers/cpufreq/tegra124-cpufreq.c                   | 3 ---
 drivers/dma-buf/heaps/cma_heap.c                     | 2 --
 drivers/dma-buf/heaps/system_heap.c                  | 1 -
 drivers/dma-buf/udmabuf.c                            | 2 --
 drivers/dma/ep93xx_dma.c                             | 3 ---
 drivers/dma/ipu/ipu_idmac.c                          | 3 ---
 drivers/dma/mv_xor_v2.c                              | 2 --
 drivers/dma/s3c24xx-dma.c                            | 3 ---
 drivers/dma/sh/shdma-base.c                          | 3 ---
 drivers/dma/stm32-dmamux.c                           | 4 ----
 drivers/dma/stm32-mdma.c                             | 4 ----
 drivers/edac/altera_edac.c                           | 3 ---
 drivers/firmware/broadcom/bcm47xx_nvram.c            | 1 -
 drivers/firmware/imx/imx-scu.c                       | 3 ---
 drivers/firmware/imx/scu-pd.c                        | 3 ---
 drivers/gpio/gpio-aspeed-sgpio.c                     | 2 --
 drivers/gpio/gpio-imx-scu.c                          | 3 ---
 drivers/gpio/gpio-mxs.c                              | 6 ------
 drivers/gpio/gpio-rda.c                              | 3 ---
 drivers/gpu/drm/drm_mipi_dsi.c                       | 3 ---
 drivers/hwspinlock/hwspinlock_core.c                 | 3 ---
 drivers/interconnect/core.c                          | 3 ---
 drivers/iommu/sun50i-iommu.c                         | 4 ----
 drivers/irqchip/irq-al-fic.c                         | 3 ---
 drivers/irqchip/irq-ls-scfg-msi.c                    | 3 ---
 drivers/irqchip/irq-mbigen.c                         | 4 ----
 drivers/irqchip/irq-mchp-eic.c                       | 3 ---
 drivers/irqchip/irq-mvebu-pic.c                      | 3 ---
 drivers/irqchip/irq-renesas-intc-irqpin.c            | 3 ---
 drivers/irqchip/irq-renesas-irqc.c                   | 3 ---
 drivers/irqchip/irq-renesas-rza1.c                   | 3 ---
 drivers/irqchip/irq-renesas-rzg2l.c                  | 3 ---
 drivers/irqchip/irq-sl28cpld.c                       | 3 ---
 drivers/irqchip/irq-ti-sci-inta.c                    | 3 ---
 drivers/irqchip/irq-ti-sci-intr.c                    | 3 ---
 drivers/leds/leds-asic3.c                            | 3 ---
 drivers/mailbox/rockchip-mailbox.c                   | 4 ----
 drivers/mailbox/zynqmp-ipi-mailbox.c                 | 3 ---
 drivers/memory/bt1-l2-ctl.c                          | 3 ---
 drivers/memory/da8xx-ddrctl.c                        | 3 ---
 drivers/memory/fsl_ifc.c                             | 3 ---
 drivers/memory/mvebu-devbus.c                        | 3 ---
 drivers/memory/tegra/mc.c                            | 3 ---
 drivers/memory/tegra/tegra186-emc.c                  | 3 ---
 drivers/mfd/88pm860x-core.c                          | 3 ---
 drivers/mfd/altera-sysmgr.c                          | 3 ---
 drivers/mfd/bcm2835-pm.c                             | 3 ---
 drivers/mfd/da903x.c                                 | 4 ----
 drivers/mfd/da9052-core.c                            | 3 ---
 drivers/mfd/da9052-i2c.c                             | 3 ---
 drivers/mfd/da9052-spi.c                             | 3 ---
 drivers/mfd/da9055-core.c                            | 3 ---
 drivers/mfd/da9055-i2c.c                             | 3 ---
 drivers/mfd/ezx-pcap.c                               | 3 ---
 drivers/mfd/intel_soc_pmic_crc.c                     | 4 ----
 drivers/mfd/lp8788.c                                 | 3 ---
 drivers/mfd/omap-usb-host.c                          | 4 ----
 drivers/mfd/omap-usb-tll.c                           | 4 ----
 drivers/mfd/palmas.c                                 | 3 ---
 drivers/mfd/stmpe-i2c.c                              | 3 ---
 drivers/mfd/stmpe-spi.c                              | 3 ---
 drivers/mfd/tc3589x.c                                | 3 ---
 drivers/mfd/tps6586x.c                               | 3 ---
 drivers/mfd/twl4030-audio.c                          | 3 ---
 drivers/mfd/twl6040.c                                | 4 ----
 drivers/mtd/parsers/bcm63xxpart.c                    | 6 ------
 drivers/nvmem/core.c                                 | 4 ----
 drivers/nvmem/zynqmp_nvmem.c                         | 3 ---
 drivers/pci/controller/dwc/pcie-histb.c              | 2 --
 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c | 3 ---
 drivers/pci/controller/pci-tegra.c                   | 1 -
 drivers/pci/controller/pci-versatile.c               | 2 --
 drivers/pci/controller/pcie-hisi-error.c             | 2 --
 drivers/pci/controller/pcie-microchip-host.c         | 3 ---
 drivers/pci/endpoint/pci-ep-cfs.c                    | 3 ---
 drivers/pci/endpoint/pci-epc-core.c                  | 3 ---
 drivers/pci/endpoint/pci-epc-mem.c                   | 3 ---
 drivers/pci/endpoint/pci-epf-core.c                  | 3 ---
 drivers/pci/hotplug/acpiphp_core.c                   | 3 ---
 drivers/pci/hotplug/shpchp_core.c                    | 3 ---
 drivers/perf/apple_m1_cpu_pmu.c                      | 1 -
 drivers/phy/intel/phy-intel-lgm-combo.c              | 2 --
 drivers/pinctrl/actions/pinctrl-s500.c               | 4 ----
 drivers/pinctrl/actions/pinctrl-s700.c               | 3 ---
 drivers/pinctrl/actions/pinctrl-s900.c               | 4 ----
 drivers/pinctrl/bcm/pinctrl-ns.c                     | 2 --
 drivers/pinctrl/mediatek/pinctrl-mt8188.c            | 2 --
 drivers/pinctrl/mediatek/pinctrl-mt8192.c            | 2 --
 drivers/pinctrl/mediatek/pinctrl-mt8365.c            | 3 ---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c            | 4 ----
 drivers/pinctrl/pinctrl-amd.c                        | 3 ---
 drivers/pinctrl/renesas/pinctrl-rza1.c               | 3 ---
 drivers/pinctrl/renesas/pinctrl-rza2.c               | 3 ---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c              | 3 ---
 drivers/pinctrl/renesas/pinctrl-rzn1.c               | 3 ---
 drivers/pinctrl/renesas/pinctrl-rzv2m.c              | 3 ---
 drivers/power/reset/as3722-poweroff.c                | 3 ---
 drivers/power/reset/gpio-poweroff.c                  | 3 ---
 drivers/power/reset/gpio-restart.c                   | 3 ---
 drivers/power/reset/keystone-reset.c                 | 3 ---
 drivers/power/reset/ltc2952-poweroff.c               | 3 ---
 drivers/power/reset/mt6323-poweroff.c                | 3 ---
 drivers/power/reset/regulator-poweroff.c             | 3 ---
 drivers/power/reset/restart-poweroff.c               | 3 ---
 drivers/power/reset/tps65086-restart.c               | 3 ---
 drivers/power/supply/power_supply_core.c             | 6 ------
 drivers/power/supply/wm97xx_battery.c                | 3 ---
 drivers/powercap/powercap_sys.c                      | 3 ---
 drivers/regulator/stm32-pwr.c                        | 3 ---
 drivers/remoteproc/remoteproc_core.c                 | 2 --
 drivers/reset/reset-axs10x.c                         | 3 ---
 drivers/reset/reset-hsdk.c                           | 3 ---
 drivers/reset/reset-lantiq.c                         | 3 ---
 drivers/reset/reset-microchip-sparx5.c               | 3 ---
 drivers/reset/reset-mpfs.c                           | 3 ---
 drivers/soc/apple/apple-pmgr-pwrstate.c              | 3 ---
 drivers/soc/bcm/bcm2835-power.c                      | 3 ---
 drivers/soc/bcm/raspberrypi-power.c                  | 4 ----
 drivers/soc/fujitsu/a64fx-diag.c                     | 3 ---
 drivers/soc/sunxi/sunxi_sram.c                       | 3 ---
 drivers/soc/tegra/cbb/tegra194-cbb.c                 | 3 ---
 drivers/soc/tegra/cbb/tegra234-cbb.c                 | 2 --
 drivers/tty/n_null.c                                 | 3 ---
 drivers/tty/serial/imx_earlycon.c                    | 3 ---
 drivers/tty/serial/rda-uart.c                        | 3 ---
 drivers/video/console/vgacon.c                       | 1 -
 drivers/video/fbdev/asiliantfb.c                     | 1 -
 drivers/video/fbdev/gbefb.c                          | 1 -
 drivers/video/fbdev/imsttfb.c                        | 1 -
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c                | 3 ---
 drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c      | 3 ---
 drivers/video/fbdev/vesafb.c                         | 1 -
 drivers/video/fbdev/wm8505fb.c                       | 3 ---
 drivers/video/fbdev/wmt_ge_rops.c                    | 4 ----
 drivers/xen/grant-dma-ops.c                          | 3 ---
 drivers/xen/xenbus/xenbus_probe.c                    | 1 -
 fs/binfmt_elf.c                                      | 1 -
 fs/nfs_common/nfs_ssc.c                              | 1 -
 fs/unicode/utf8-core.c                               | 1 -
 kernel/dma/map_benchmark.c                           | 3 ---
 kernel/events/hw_breakpoint_test.c                   | 2 --
 kernel/trace/rv/reactor_panic.c                      | 3 ---
 kernel/trace/rv/reactor_printk.c                     | 3 ---
 kernel/watch_queue.c                                 | 3 ---
 lib/btree.c                                          | 3 ---
 lib/crypto/blake2s-generic.c                         | 3 ---
 lib/crypto/blake2s.c                                 | 3 ---
 lib/glob.c                                           | 2 --
 lib/packing.c                                        | 2 --
 lib/pldmfw/pldmfw.c                                  | 3 ---
 lib/test_fprobe.c                                    | 1 -
 mm/zpool.c                                           | 3 ---
 mm/zswap.c                                           | 3 ---
 net/mctp/af_mctp.c                                   | 3 ---
 189 files changed, 539 deletions(-)

diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index aaba21230528..0df9ec15643a 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -74,4 +74,3 @@ static int __init blake2s_mod_init(void)
 
 module_init(blake2s_mod_init);
 
-MODULE_LICENSE("GPL v2");
diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index 092ea436c7e6..ad25ad29aa10 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -71,6 +71,3 @@ static void __exit pt_dump_debug_exit(void)
 
 module_init(pt_dump_debug_init);
 module_exit(pt_dump_debug_exit);
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Arjan van de Ven <arjan@linux.intel.com>");
-MODULE_DESCRIPTION("Kernel debugging helper that dumps pagetables");
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 41a2f0eb4ce4..a5da8ccd353e 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -17,7 +17,6 @@
 #include <keys/user-type.h>
 #include "asymmetric_keys.h"
 
-MODULE_LICENSE("GPL");
 
 const char *const key_being_used_for[NR__KEY_BEING_USED_FOR] = {
 	[VERIFYING_MODULE_SIGNATURE]		= "mod sig",
diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index c4d54a5326b1..4ea6893659af 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -22,10 +22,6 @@
 #include <linux/kbd_kern.h>
 #include <linux/input.h>
 
-MODULE_AUTHOR("samuel.thibault@ens-lyon.org");
-MODULE_DESCRIPTION("braille device");
-MODULE_LICENSE("GPL");
-
 /*
  * Braille device support part.
  */
diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 0b2c20fddb7c..084ac10c4286 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -283,7 +283,4 @@ static struct platform_driver tegra_ahb_driver = {
 };
 module_platform_driver(tegra_ahb_driver);
 
-MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
-MODULE_DESCRIPTION("Tegra AHB driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..e36164108da6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6597,4 +6597,3 @@ device_initcall(binder_init);
 #define CREATE_TRACE_POINTS
 #include "binder_trace.h"
 
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..6702bee4ca5c 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -583,5 +583,3 @@ EXPORT_SYMBOL_GPL(cci_probed);
 
 early_initcall(cci_init);
 core_initcall(cci_platform_init);
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("ARM CCI support");
diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index 2344d560b144..61a649acdfef 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -124,6 +124,3 @@ static struct platform_driver integrator_ap_lm_driver = {
 	},
 };
 module_platform_driver(integrator_ap_lm_driver);
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Integrator AP Logical Module driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index 63b1b4a76671..1d4e509b195b 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -414,6 +414,3 @@ static struct platform_driver bt1_apb_driver = {
 };
 module_platform_driver(bt1_apb_driver);
 
-MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
-MODULE_DESCRIPTION("Baikal-T1 APB-bus driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/bus/bt1-axi.c b/drivers/bus/bt1-axi.c
index 70e49a6e5374..9b4461ec8084 100644
--- a/drivers/bus/bt1-axi.c
+++ b/drivers/bus/bt1-axi.c
@@ -307,6 +307,3 @@ static struct platform_driver bt1_axi_driver = {
 };
 module_platform_driver(bt1_axi_driver);
 
-MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
-MODULE_DESCRIPTION("Baikal-T1 AXI-bus driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 828c66bbaa67..b8519526dd24 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -403,6 +403,3 @@ static void __exit weim_exit(void)
 }
 module_exit(weim_exit);
 
-MODULE_AUTHOR("Freescale Semiconductor Inc.");
-MODULE_DESCRIPTION("i.MX EIM Controller Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index a4388440aca7..6e02369aedeb 100644
--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -424,6 +424,3 @@ static struct platform_driver ixp4xx_exp_driver = {
 	},
 };
 module_platform_driver(ixp4xx_exp_driver);
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Intel IXP4xx external bus driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/bus/qcom-ebi2.c b/drivers/bus/qcom-ebi2.c
index 663c82749222..5846c2ffe99c 100644
--- a/drivers/bus/qcom-ebi2.c
+++ b/drivers/bus/qcom-ebi2.c
@@ -401,6 +401,3 @@ static struct platform_driver qcom_ebi2_driver = {
 	},
 };
 module_platform_driver(qcom_ebi2_driver);
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Qualcomm EBI2 driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/bus/qcom-ssc-block-bus.c b/drivers/bus/qcom-ssc-block-bus.c
index eedeb29a5ff3..040f3432b989 100644
--- a/drivers/bus/qcom-ssc-block-bus.c
+++ b/drivers/bus/qcom-ssc-block-bus.c
@@ -384,6 +384,3 @@ static struct platform_driver qcom_ssc_block_bus_driver = {
 
 module_platform_driver(qcom_ssc_block_bus_driver);
 
-MODULE_DESCRIPTION("A driver for handling the init sequence needed for accessing the SSC block on (some) qcom SoCs over AHB");
-MODULE_AUTHOR("Michael Srba <Michael.Srba@seznam.cz>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 6b8d6257ed8a..22fe6478e7b5 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -90,6 +90,3 @@ static struct platform_driver simple_pm_bus_driver = {
 
 module_platform_driver(simple_pm_bus_driver);
 
-MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
-MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
index 290a2846a86b..9aeeee6096a8 100644
--- a/drivers/clk/bcm/clk-bcm2835-aux.c
+++ b/drivers/clk/bcm/clk-bcm2835-aux.c
@@ -67,6 +67,3 @@ static struct platform_driver bcm2835_aux_clk_driver = {
 };
 builtin_platform_driver(bcm2835_aux_clk_driver);
 
-MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
-MODULE_DESCRIPTION("BCM2835 auxiliary peripheral clock driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index e74fe6219d14..eec7146b12a0 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -2348,6 +2348,3 @@ static struct platform_driver bcm2835_clk_driver = {
 
 builtin_platform_driver(bcm2835_clk_driver);
 
-MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
-MODULE_DESCRIPTION("BCM2835 clock driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
index fad78a22218e..67aace6d4e2a 100644
--- a/drivers/clk/clk-bm1880.c
+++ b/drivers/clk/clk-bm1880.c
@@ -947,6 +947,3 @@ static struct platform_driver bm1880_clk_driver = {
 };
 module_platform_driver(bm1880_clk_driver);
 
-MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
-MODULE_DESCRIPTION("Clock driver for Bitmain BM1880 SoC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/clk-fixed-mmio.c b/drivers/clk/clk-fixed-mmio.c
index 5225d17d6b3f..b4d51972357e 100644
--- a/drivers/clk/clk-fixed-mmio.c
+++ b/drivers/clk/clk-fixed-mmio.c
@@ -97,6 +97,3 @@ static struct platform_driver of_fixed_mmio_clk_driver = {
 };
 module_platform_driver(of_fixed_mmio_clk_driver);
 
-MODULE_AUTHOR("Jan Kotas <jank@cadence.com>");
-MODULE_DESCRIPTION("Memory Mapped IO Fixed clock driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
index 6238fcea0467..c2cb71d474d2 100644
--- a/drivers/clk/clk-fsl-sai.c
+++ b/drivers/clk/clk-fsl-sai.c
@@ -86,7 +86,4 @@ static struct platform_driver fsl_sai_clk_driver = {
 };
 module_platform_driver(fsl_sai_clk_driver);
 
-MODULE_DESCRIPTION("Freescale SAI bitclock-as-a-clock driver");
-MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
-MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:fsl-sai-clk");
diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 9ea1a80acbe8..f56c837811ae 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -841,5 +841,3 @@ static void __exit hi3559av100_crg_exit(void)
 module_exit(hi3559av100_crg_exit);
 
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("HiSilicon Hi3559AV100 CRG Driver");
diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip/clk-mpfs-ccc.c
index 7be028dced63..cce7d9689859 100644
--- a/drivers/clk/microchip/clk-mpfs-ccc.c
+++ b/drivers/clk/microchip/clk-mpfs-ccc.c
@@ -285,6 +285,3 @@ static void __exit clk_ccc_exit(void)
 }
 module_exit(clk_ccc_exit);
 
-MODULE_DESCRIPTION("Microchip PolarFire SoC Clock Conditioning Circuitry Driver");
-MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 4f0a19db7ed7..1433e467cab9 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -509,8 +509,3 @@ static void __exit clk_mpfs_exit(void)
 }
 module_exit(clk_mpfs_exit);
 
-MODULE_DESCRIPTION("Microchip PolarFire SoC Clock Driver");
-MODULE_AUTHOR("Padmarao Begari <padmarao.begari@microchip.com>");
-MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
-MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/clk/renesas/rcar-usb2-clock-sel.c b/drivers/clk/renesas/rcar-usb2-clock-sel.c
index 684d8937965e..2968c9b1aaa5 100644
--- a/drivers/clk/renesas/rcar-usb2-clock-sel.c
+++ b/drivers/clk/renesas/rcar-usb2-clock-sel.c
@@ -219,5 +219,3 @@ static struct platform_driver rcar_usb2_clock_sel_driver = {
 };
 builtin_platform_driver(rcar_usb2_clock_sel_driver);
 
-MODULE_DESCRIPTION("Renesas R-Car USB2 clock selector Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1a0cdf001b2f..a4f4f1fee9d3 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -1153,5 +1153,3 @@ void __init mssr_mod_reparent(struct mssr_mod_clk *mod_clks,
 		}
 }
 
-MODULE_DESCRIPTION("Renesas CPG/MSSR Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3ff6ecd61756..8f530972ccf7 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1430,5 +1430,3 @@ static int __init rzg2l_cpg_init(void)
 
 subsys_initcall(rzg2l_cpg_init);
 
-MODULE_DESCRIPTION("Renesas RZ/G2L CPG Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index ab190dffb1ed..6eaa6620a330 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -366,6 +366,3 @@ static void __exit em_sti_exit(void)
 subsys_initcall(em_sti_init);
 module_exit(em_sti_exit);
 
-MODULE_AUTHOR("Magnus Damm");
-MODULE_DESCRIPTION("Renesas Emma Mobile STI Timer Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 64dcb082d4cf..cec602c91499 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1155,6 +1155,3 @@ sh_early_platform_init("earlytimer", &sh_cmt_device_driver);
 subsys_initcall(sh_cmt_init);
 module_exit(sh_cmt_exit);
 
-MODULE_AUTHOR("Magnus Damm");
-MODULE_DESCRIPTION("SuperH CMT Timer Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 169a1fccc497..b71d634464c7 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -528,6 +528,3 @@ sh_early_platform_init("earlytimer", &sh_mtu2_device_driver);
 subsys_initcall(sh_mtu2_init);
 module_exit(sh_mtu2_exit);
 
-MODULE_AUTHOR("Magnus Damm");
-MODULE_DESCRIPTION("SuperH MTU2 Timer Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index b00dec0655cb..b92f1d3f53e9 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -677,6 +677,3 @@ sh_early_platform_init("earlytimer", &sh_tmu_device_driver);
 subsys_initcall(sh_tmu_init);
 module_exit(sh_tmu_exit);
 
-MODULE_AUTHOR("Magnus Damm");
-MODULE_DESCRIPTION("SuperH TMU Timer Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index db2841d0beb8..54ab3db7de55 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -217,5 +217,3 @@ static struct platform_driver stm32_clkevent_lp_driver = {
 module_platform_driver(stm32_clkevent_lp_driver);
 
 MODULE_ALIAS("platform:stm32-lptimer-timer");
-MODULE_DESCRIPTION("STMicroelectronics STM32 clockevent low power driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index ea742889ee06..d87e2ed2c5bf 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -509,6 +509,3 @@ static struct platform_driver tegra186_wdt_driver = {
 };
 module_platform_driver(tegra186_wdt_driver);
 
-MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
-MODULE_DESCRIPTION("NVIDIA Tegra186 timers driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index cad29ded3a48..85842520065f 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1265,6 +1265,3 @@ static struct platform_driver omap_dm_timer_driver = {
 
 module_platform_driver(omap_dm_timer_driver);
 
-MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 67e56cf638ef..c34d813e4687 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -365,6 +365,3 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 	return set_freq_table_sorted(policy);
 }
 
-MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION("CPUfreq frequency table helpers");
-MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 6ff73c30769f..518febe0c9f4 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3526,6 +3526,3 @@ static int __init intel_pstate_setup(char *str)
 }
 early_param("intel_pstate", intel_pstate_setup);
 
-MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie@intel.com>");
-MODULE_DESCRIPTION("'intel_pstate' - P state driver Intel Core processors");
-MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 7a1ea6fdcab6..d41292a87b14 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -219,6 +219,3 @@ static int __init tegra_cpufreq_init(void)
 }
 module_init(tegra_cpufreq_init);
 
-MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
-MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 28fb04eccdd0..6d6b92743613 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -403,5 +403,3 @@ static int add_default_cma_heap(void)
 	return ret;
 }
 module_init(add_default_cma_heap);
-MODULE_DESCRIPTION("DMA-BUF CMA Heap");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index fcf836ba9c1f..1b8d1db6ce23 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -437,4 +437,3 @@ static int system_heap_create(void)
 	return 0;
 }
 module_init(system_heap_create);
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2bcdb935a3ac..f3421e56c140 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -398,5 +398,3 @@ static void __exit udmabuf_dev_exit(void)
 module_init(udmabuf_dev_init)
 module_exit(udmabuf_dev_exit)
 
-MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index d19ea885c63e..26c38657a079 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1429,6 +1429,3 @@ static int __init ep93xx_dma_module_init(void)
 }
 subsys_initcall(ep93xx_dma_module_init);
 
-MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
-MODULE_DESCRIPTION("EP93xx DMA driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index baab1ca9f621..82a22ee145b1 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1796,7 +1796,4 @@ static int __init ipu_init(void)
 }
 subsys_initcall(ipu_init);
 
-MODULE_DESCRIPTION("IPU core driver");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Guennadi Liakhovetski <lg@denx.de>");
 MODULE_ALIAS("platform:ipu-core");
diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 113834e1167b..c10f9959b7dd 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -919,5 +919,3 @@ static struct platform_driver mv_xor_v2_driver = {
 
 module_platform_driver(mv_xor_v2_driver);
 
-MODULE_DESCRIPTION("DMA engine driver for Marvell's Version 2 of XOR engine");
-MODULE_LICENSE("GPL");
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index a09eeb545f7d..aa10b57560be 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1423,6 +1423,3 @@ bool s3c24xx_dma_filter(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL(s3c24xx_dma_filter);
 
-MODULE_DESCRIPTION("S3C24XX DMA Driver");
-MODULE_AUTHOR("Heiko Stuebner");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 158e5e7defae..8c3080997f07 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -1047,6 +1047,3 @@ static void __exit shdma_exit(void)
 }
 module_exit(shdma_exit);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("SH-DMA driver base library");
-MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32-dmamux.c
index ee3cbbf51006..67dafaf85c4b 100644
--- a/drivers/dma/stm32-dmamux.c
+++ b/drivers/dma/stm32-dmamux.c
@@ -397,7 +397,3 @@ static int __init stm32_dmamux_init(void)
 }
 arch_initcall(stm32_dmamux_init);
 
-MODULE_DESCRIPTION("DMA Router driver for STM32 DMA MUX");
-MODULE_AUTHOR("M'boumba Cedric Madianga <cedric.madianga@gmail.com>");
-MODULE_AUTHOR("Pierre-Yves Mordret <pierre-yves.mordret@st.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index b9d4c843635f..559576f197e3 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1813,7 +1813,3 @@ static int __init stm32_mdma_init(void)
 
 subsys_initcall(stm32_mdma_init);
 
-MODULE_DESCRIPTION("Driver for STM32 MDMA controller");
-MODULE_AUTHOR("M'boumba Cedric Madianga <cedric.madianga@gmail.com>");
-MODULE_AUTHOR("Pierre-Yves Mordret <pierre-yves.mordret@st.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..17e3f788bcf5 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2226,6 +2226,3 @@ static struct platform_driver altr_edac_a10_driver = {
 };
 module_platform_driver(altr_edac_a10_driver);
 
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Thor Thayer");
-MODULE_DESCRIPTION("EDAC Driver for Altera Memories");
diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index bd235833b687..2f70c8814b73 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -237,4 +237,3 @@ char *bcm47xx_nvram_get_contents(size_t *nvram_size)
 }
 EXPORT_SYMBOL(bcm47xx_nvram_get_contents);
 
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index dca79caccd01..93d57a3b64fa 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -356,6 +356,3 @@ static struct platform_driver imx_scu_driver = {
 };
 builtin_platform_driver(imx_scu_driver);
 
-MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
-MODULE_DESCRIPTION("IMX SCU firmware protocol driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index af3d057e6421..83f7274a3fe5 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -418,6 +418,3 @@ static struct platform_driver imx_sc_pd_driver = {
 };
 builtin_platform_driver(imx_sc_pd_driver);
 
-MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
-MODULE_DESCRIPTION("IMX SCU Power Domain driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 454cefbeecf0..e3f656945704 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -608,5 +608,3 @@ static struct platform_driver aspeed_sgpio_driver = {
 };
 
 module_platform_driver_probe(aspeed_sgpio_driver, aspeed_sgpio_probe);
-MODULE_DESCRIPTION("Aspeed Serial GPIO Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-imx-scu.c b/drivers/gpio/gpio-imx-scu.c
index 17be21b8f3b7..45ce2785d487 100644
--- a/drivers/gpio/gpio-imx-scu.c
+++ b/drivers/gpio/gpio-imx-scu.c
@@ -134,6 +134,3 @@ static int __init _imx_scu_gpio_init(void)
 
 subsys_initcall_sync(_imx_scu_gpio_init);
 
-MODULE_AUTHOR("Shenwei Wang <shenwei.wang@nxp.com>");
-MODULE_DESCRIPTION("NXP GPIO over IMX SCU API");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 7f59e5d936c2..cacee67c0f8f 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -359,9 +359,3 @@ static int __init mxs_gpio_init(void)
 	return platform_driver_register(&mxs_gpio_driver);
 }
 postcore_initcall(mxs_gpio_init);
-
-MODULE_AUTHOR("Freescale Semiconductor, "
-	      "Daniel Mack <danielncaiaq.de>, "
-	      "Juergen Beisert <kernel@pengutronix.de>");
-MODULE_DESCRIPTION("Freescale MXS GPIO");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-rda.c b/drivers/gpio/gpio-rda.c
index 62ba18b3a602..568ba1c3601f 100644
--- a/drivers/gpio/gpio-rda.c
+++ b/drivers/gpio/gpio-rda.c
@@ -284,6 +284,3 @@ static struct platform_driver rda_gpio_driver = {
 
 module_platform_driver_probe(rda_gpio_driver, rda_gpio_probe);
 
-MODULE_DESCRIPTION("RDA Micro GPIO driver");
-MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 3ec02748d56f..d5c0725045c8 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -1292,6 +1292,3 @@ static int __init mipi_dsi_bus_init(void)
 }
 postcore_initcall(mipi_dsi_bus_init);
 
-MODULE_AUTHOR("Andrzej Hajda <a.hajda@samsung.com>");
-MODULE_DESCRIPTION("MIPI DSI Bus");
-MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index fd5f5c5a5244..2f32e4706ca8 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -949,6 +949,3 @@ struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_hwspin_lock_request_specific);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Hardware spinlock interface");
-MODULE_AUTHOR("Ohad Ben-Cohen <ohad@wizery.com>");
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 25debded65a8..764c92a06e68 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1144,6 +1144,3 @@ static int __init icc_init(void)
 
 device_initcall(icc_init);
 
-MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
-MODULE_DESCRIPTION("Interconnect Driver Core");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index cd9b74ee24de..a06e9ec880fa 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -997,7 +997,3 @@ static struct platform_driver sun50i_iommu_driver = {
 };
 builtin_platform_driver_probe(sun50i_iommu_driver, sun50i_iommu_probe);
 
-MODULE_DESCRIPTION("Allwinner H6 IOMMU driver");
-MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
-MODULE_AUTHOR("zhuxianbin <zhuxianbin@allwinnertech.com>");
-MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index 886de028a901..0b11f4881afe 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -24,9 +24,6 @@
 
 #define NR_FIC_IRQS 32
 
-MODULE_AUTHOR("Talel Shenhar");
-MODULE_DESCRIPTION("Amazon's Annapurna Labs Interrupt Controller Driver");
-MODULE_LICENSE("GPL v2");
 
 enum al_fic_state {
 	AL_FIC_UNCONFIGURED = 0,
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 527c90e0920e..af9feb9beff3 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -428,6 +428,3 @@ static struct platform_driver ls_scfg_msi_driver = {
 
 module_platform_driver(ls_scfg_msi_driver);
 
-MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@nxp.com>");
-MODULE_DESCRIPTION("Freescale Layerscape SCFG MSI controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index f3faf5c99770..98496aa0311e 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -387,7 +387,3 @@ static struct platform_driver mbigen_platform_driver = {
 
 module_platform_driver(mbigen_platform_driver);
 
-MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
-MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("HiSilicon MBI Generator driver");
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index c726a19837d2..0aa28f4ae03b 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -275,6 +275,3 @@ IRQCHIP_PLATFORM_DRIVER_BEGIN(mchp_eic)
 IRQCHIP_MATCH("microchip,sama7g5-eic", mchp_eic_init)
 IRQCHIP_PLATFORM_DRIVER_END(mchp_eic)
 
-MODULE_DESCRIPTION("Microchip External Interrupt Controller");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea@microchip.com>");
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index ef3d3646ccc2..ea541b1fef5b 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -193,8 +193,5 @@ static struct platform_driver mvebu_pic_driver = {
 };
 module_platform_driver(mvebu_pic_driver);
 
-MODULE_AUTHOR("Yehuda Yitschak <yehuday@marvell.com>");
-MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:mvebu_pic");
 
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index e83756aca14e..5eacec89cdb4 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -606,6 +606,3 @@ static void __exit intc_irqpin_exit(void)
 }
 module_exit(intc_irqpin_exit);
 
-MODULE_AUTHOR("Magnus Damm");
-MODULE_DESCRIPTION("Renesas INTC External IRQ Pin Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 1ee5e9941f67..d3e1394dfaa7 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -268,6 +268,3 @@ static void __exit irqc_exit(void)
 }
 module_exit(irqc_exit);
 
-MODULE_AUTHOR("Magnus Damm");
-MODULE_DESCRIPTION("Renesas IRQC Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index 72c06e883d1c..7340868edd9f 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -279,6 +279,3 @@ static void __exit rza1_irqc_exit(void)
 }
 module_exit(rza1_irqc_exit);
 
-MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
-MODULE_DESCRIPTION("Renesas RZ/A1 IRQC Driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 25fd8ee66565..80079ac40384 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -388,6 +388,3 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
 IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
-MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
-MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
index fbb354413ffa..24a68af87e59 100644
--- a/drivers/irqchip/irq-sl28cpld.c
+++ b/drivers/irqchip/irq-sl28cpld.c
@@ -91,6 +91,3 @@ static struct platform_driver sl28cpld_intc_driver = {
 };
 module_platform_driver(sl28cpld_intc_driver);
 
-MODULE_DESCRIPTION("sl28cpld Interrupt Controller Driver");
-MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 5fdbb4358dd0..63f003d36f3e 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -741,6 +741,3 @@ static struct platform_driver ti_sci_inta_irq_domain_driver = {
 };
 module_platform_driver(ti_sci_inta_irq_domain_driver);
 
-MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
-MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index fe8fad22bcf9..2d014fe02530 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -300,6 +300,3 @@ static struct platform_driver ti_sci_intr_irq_domain_driver = {
 };
 module_platform_driver(ti_sci_intr_irq_domain_driver);
 
-MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
-MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/leds/leds-asic3.c b/drivers/leds/leds-asic3.c
index 8cbc1b8bafa5..5929f3b3f0cb 100644
--- a/drivers/leds/leds-asic3.c
+++ b/drivers/leds/leds-asic3.c
@@ -171,7 +171,4 @@ static struct platform_driver asic3_led_driver = {
 
 module_platform_driver(asic3_led_driver);
 
-MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
-MODULE_DESCRIPTION("HTC ASIC3 LED driver");
-MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:leds-asic3");
diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index 979acc810f30..c80b2b8a162d 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -256,7 +256,3 @@ static struct platform_driver rockchip_mbox_driver = {
 
 module_platform_driver(rockchip_mbox_driver);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Rockchip mailbox: communicate between CPU cores and MCU");
-MODULE_AUTHOR("Addy Ke <addy.ke@rock-chips.com>");
-MODULE_AUTHOR("Caesar Wang <wxt@rock-chips.com>");
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 31a0fa914274..68d44ff802b8 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -716,6 +716,3 @@ static void __exit zynqmp_ipi_exit(void)
 }
 module_exit(zynqmp_ipi_exit);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Xilinx ZynqMP IPI Mailbox driver");
-MODULE_AUTHOR("Xilinx Inc.");
diff --git a/drivers/memory/bt1-l2-ctl.c b/drivers/memory/bt1-l2-ctl.c
index 85965fa26e0b..ecba9881e446 100644
--- a/drivers/memory/bt1-l2-ctl.c
+++ b/drivers/memory/bt1-l2-ctl.c
@@ -319,6 +319,3 @@ static struct platform_driver l2_ctl_driver = {
 };
 module_platform_driver(l2_ctl_driver);
 
-MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
-MODULE_DESCRIPTION("Baikal-T1 L2-cache driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index b32005bf269c..13c086579932 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -162,6 +162,3 @@ static struct platform_driver da8xx_ddrctl_driver = {
 };
 module_platform_driver(da8xx_ddrctl_driver);
 
-MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
-MODULE_DESCRIPTION("TI da8xx DDR2/mDDR controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index e83b61c925a4..4716f344559a 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -327,6 +327,3 @@ static int __init fsl_ifc_init(void)
 }
 subsys_initcall(fsl_ifc_init);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Freescale Semiconductor");
-MODULE_DESCRIPTION("Freescale Integrated Flash Controller driver");
diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.c
index 8450638e8670..95ec816352dc 100644
--- a/drivers/memory/mvebu-devbus.c
+++ b/drivers/memory/mvebu-devbus.c
@@ -342,6 +342,3 @@ static int __init mvebu_devbus_init(void)
 }
 module_init(mvebu_devbus_init);
 
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Ezequiel Garcia <ezequiel.garcia@free-electrons.com>");
-MODULE_DESCRIPTION("Marvell EBU SoC Device Bus controller");
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 2f7a58a9df1a..9f02f72c2825 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -958,6 +958,3 @@ static int tegra_mc_init(void)
 }
 arch_initcall(tegra_mc_init);
 
-MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
-MODULE_DESCRIPTION("NVIDIA Tegra Memory Controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 54b47ca33483..139d01435ad1 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -291,6 +291,3 @@ static struct platform_driver tegra186_emc_driver = {
 };
 module_platform_driver(tegra186_emc_driver);
 
-MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
-MODULE_DESCRIPTION("NVIDIA Tegra186 External Memory Controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 5dc86dd66202..4997404ed4c6 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1276,6 +1276,3 @@ static void __exit pm860x_i2c_exit(void)
 }
 module_exit(pm860x_i2c_exit);
 
-MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM860x");
-MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 5d3715a28b28..41fdb1bda3d6 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -196,6 +196,3 @@ static void __exit altr_sysmgr_exit(void)
 }
 module_exit(altr_sysmgr_exit);
 
-MODULE_AUTHOR("Thor Thayer <>");
-MODULE_DESCRIPTION("SOCFPGA System Manager driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 49cd1f03884a..b277825be741 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -121,6 +121,3 @@ static struct platform_driver bcm2835_pm_driver = {
 };
 module_platform_driver(bcm2835_pm_driver);
 
-MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
-MODULE_DESCRIPTION("Driver for Broadcom BCM2835 PM MFD");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 3f8f6ad3a98c..34d6df2dd7ca 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -560,7 +560,3 @@ static void __exit da903x_exit(void)
 }
 module_exit(da903x_exit);
 
-MODULE_DESCRIPTION("PMIC Driver for Dialog Semiconductor DA9034");
-MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
-MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index 8b42d2f7024f..c7d6dcfd35a4 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -651,6 +651,3 @@ void da9052_device_exit(struct da9052 *da9052)
 	da9052_irq_exit(da9052);
 }
 
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-MODULE_DESCRIPTION("DA9052 MFD Core");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 5a74696c8704..d964f26698a5 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -207,6 +207,3 @@ static void __exit da9052_i2c_exit(void)
 }
 module_exit(da9052_i2c_exit);
 
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-MODULE_DESCRIPTION("I2C driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index b79a57b45c1e..4e18fa1db842 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -100,6 +100,3 @@ static void __exit da9052_spi_exit(void)
 }
 module_exit(da9052_spi_exit);
 
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-MODULE_DESCRIPTION("SPI driver for Dialog DA9052 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index c3bcbd8905c6..102a2c17fbfa 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -397,6 +397,3 @@ void da9055_device_exit(struct da9055 *da9055)
 	mfd_remove_devices(da9055->dev);
 }
 
-MODULE_DESCRIPTION("Core support for the DA9055 PMIC");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 276c7d1c509e..643dec98c9ac 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -96,6 +96,3 @@ static void __exit da9055_i2c_exit(void)
 }
 module_exit(da9055_i2c_exit);
 
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-MODULE_DESCRIPTION("I2C driver for Dialog DA9055 PMIC");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 3d5ce18aa9ae..13127d7b6598 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -528,7 +528,4 @@ static void __exit ezx_pcap_exit(void)
 subsys_initcall(ezx_pcap_init);
 module_exit(ezx_pcap_exit);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Daniel Ribeiro / Harald Welte");
-MODULE_DESCRIPTION("Motorola PCAP2 ASIC Driver");
 MODULE_ALIAS("spi:ezx-pcap");
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index b1548a933dc3..0cbb990d01bd 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -270,7 +270,3 @@ static struct i2c_driver crystal_cove_i2c_driver = {
 
 module_i2c_driver(crystal_cove_i2c_driver);
 
-MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Yang, Bin <bin.yang@intel.com>");
-MODULE_AUTHOR("Zhu, Lejun <lejun.zhu@linux.intel.com>");
diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index 724a5712b36b..4f85864b9511 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -242,6 +242,3 @@ static void __exit lp8788_exit(void)
 }
 module_exit(lp8788_exit);
 
-MODULE_DESCRIPTION("TI LP8788 MFD Driver");
-MODULE_AUTHOR("Milo Kim");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 787d2ae86375..1d423cb01337 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -850,11 +850,7 @@ static struct platform_driver usbhs_omap_driver = {
 	.remove		= usbhs_omap_remove,
 };
 
-MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
-MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
 
 static int omap_usbhs_drvinit(void)
 {
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 080d7970a377..5e5d077ac0c9 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -448,10 +448,6 @@ int omap_tll_disable(struct usbhs_omap_platform_data *pdata)
 }
 EXPORT_SYMBOL_GPL(omap_tll_disable);
 
-MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
-MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
 
 static int __init omap_usbtll_drvinit(void)
 {
diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index 8b7429bd2e3e..b677e38de7bb 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -750,6 +750,3 @@ static void __exit palmas_i2c_exit(void)
 }
 module_exit(palmas_i2c_exit);
 
-MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
-MODULE_DESCRIPTION("Palmas chip family multi-function driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 4d55494a97c4..51da3a632adb 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -136,6 +136,3 @@ static void __exit stmpe_exit(void)
 }
 module_exit(stmpe_exit);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("STMPE MFD I2C Interface Driver");
-MODULE_AUTHOR("Rabin Vincent <rabin.vincent@stericsson.com>");
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index ad8055a0e286..98ee83f90d1a 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -156,6 +156,3 @@ static void __exit stmpe_exit(void)
 }
 module_exit(stmpe_exit);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("STMPE MFD SPI Interface Driver");
-MODULE_AUTHOR("Viresh Kumar <vireshk@kernel.org>");
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index d5d0ec117acb..f425f7a6d169 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -503,6 +503,3 @@ static void __exit tc3589x_exit(void)
 }
 module_exit(tc3589x_exit);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("TC3589x MFD core driver");
-MODULE_AUTHOR("Hanumath Prasad, Rabin Vincent");
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index fb340da64bbc..97b32236ef15 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -641,6 +641,3 @@ static void __exit tps6586x_exit(void)
 }
 module_exit(tps6586x_exit);
 
-MODULE_DESCRIPTION("TPS6586X core driver");
-MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 4536d829b43e..ed96b52cd799 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -283,7 +283,4 @@ static struct platform_driver twl4030_audio_driver = {
 
 module_platform_driver(twl4030_audio_driver);
 
-MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
-MODULE_DESCRIPTION("TWL4030 audio block MFD driver");
-MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:twl4030-audio");
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index f429b8f00db6..5db429eafbb0 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -840,7 +840,3 @@ static struct i2c_driver twl6040_driver = {
 
 module_i2c_driver(twl6040_driver);
 
-MODULE_DESCRIPTION("TWL6040 MFD");
-MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
-MODULE_AUTHOR("Jorge Eduardo Candelaria <jorge.candelaria@ti.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/parsers/bcm63xxpart.c b/drivers/mtd/parsers/bcm63xxpart.c
index b15bdadaedb5..f252e3eb017f 100644
--- a/drivers/mtd/parsers/bcm63xxpart.c
+++ b/drivers/mtd/parsers/bcm63xxpart.c
@@ -164,9 +164,3 @@ static struct mtd_part_parser bcm63xx_cfe_parser = {
 };
 module_mtd_part_parser(bcm63xx_cfe_parser);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Daniel Dickinson <openwrt@cshore.neomailbox.net>");
-MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
-MODULE_AUTHOR("Mike Albon <malbon@openwrt.org>");
-MODULE_AUTHOR("Jonas Gorski <jonas.gorski@gmail.com");
-MODULE_DESCRIPTION("MTD partitioning for BCM63XX CFE bootloaders");
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..386d5efa1b27 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1952,7 +1952,3 @@ static void __exit nvmem_exit(void)
 subsys_initcall(nvmem_init);
 module_exit(nvmem_exit);
 
-MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("nvmem Driver Core");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index e28d7b133e11..d01d4fddf283 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -76,6 +76,3 @@ static struct platform_driver zynqmp_nvmem_driver = {
 
 module_platform_driver(zynqmp_nvmem_driver);
 
-MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
-MODULE_DESCRIPTION("ZynqMP NVMEM driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index e2b80f10030d..2db5bc06d1be 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -450,5 +450,3 @@ static struct platform_driver histb_pcie_platform_driver = {
 };
 module_platform_driver(histb_pcie_platform_driver);
 
-MODULE_DESCRIPTION("HiSilicon STB PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
index f6fcd95c2bf5..704bca668f76 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -56,6 +56,3 @@ static struct platform_driver mobiveil_pcie_driver = {
 
 builtin_platform_driver(mobiveil_pcie_driver);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
-MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 8e323e93be91..378e56e9d414 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2813,4 +2813,3 @@ static struct platform_driver tegra_pcie_driver = {
 	.remove = tegra_pcie_remove,
 };
 module_platform_driver(tegra_pcie_driver);
-MODULE_LICENSE("GPL");
diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index 7991d334e0f1..73ca239096cc 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -168,5 +168,3 @@ static struct platform_driver versatile_pci_driver = {
 };
 module_platform_driver(versatile_pci_driver);
 
-MODULE_DESCRIPTION("Versatile PCI driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
index 7959c9c8d2bc..6866bc42da1b 100644
--- a/drivers/pci/controller/pcie-hisi-error.c
+++ b/drivers/pci/controller/pcie-hisi-error.c
@@ -323,5 +323,3 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
 };
 module_platform_driver(hisi_pcie_error_handler_driver);
 
-MODULE_DESCRIPTION("HiSilicon HIP PCIe controller error handling driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 7263d175b5ad..b424bb1d13f5 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -1135,6 +1135,3 @@ static struct platform_driver mc_pcie_driver = {
 };
 
 builtin_platform_driver(mc_pcie_driver);
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Microchip PCIe host controller driver");
-MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d4850bdd837f..bb5c30cbdc2a 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -726,6 +726,3 @@ static void __exit pci_ep_cfs_exit(void)
 }
 module_exit(pci_ep_cfs_exit);
 
-MODULE_DESCRIPTION("PCI EP CONFIGFS");
-MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..e68c663a2072 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -854,6 +854,3 @@ static void __exit pci_epc_exit(void)
 }
 module_exit(pci_epc_exit);
 
-MODULE_DESCRIPTION("PCI EPC Library");
-MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
index a97b56a6d2db..2353249311ad 100644
--- a/drivers/pci/endpoint/pci-epc-mem.c
+++ b/drivers/pci/endpoint/pci-epc-mem.c
@@ -258,6 +258,3 @@ void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
 
-MODULE_DESCRIPTION("PCI EPC Address Space Management");
-MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 9ed556936f48..682a69be2040 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -566,6 +566,3 @@ static void __exit pci_epf_exit(void)
 }
 module_exit(pci_epf_exit);
 
-MODULE_DESCRIPTION("PCI EPF Library");
-MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
index 853e04ad272c..fd8b98c5641a 100644
--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -43,9 +43,6 @@ static struct acpiphp_attention_info *attention_info;
 #define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>, Matthew Wilcox <willy@infradead.org>"
 #define DRIVER_DESC	"ACPI Hot Plug PCI Controller Driver"
 
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(disable, "disable acpiphp driver");
 module_param_named(disable, acpiphp_disabled, bool, 0444);
 
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 53692b048301..7610a3f6fb5a 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -30,9 +30,6 @@ int shpchp_poll_time;
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
 #define DRIVER_DESC	"Standard Hot Plug PCI Controller Driver"
 
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
 
 module_param(shpchp_debug, bool, 0644);
 module_param(shpchp_poll_mode, bool, 0644);
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 979a7c2b4f56..7123beeb992f 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -581,4 +581,3 @@ static struct platform_driver m1_pmu_driver = {
 };
 
 module_platform_driver(m1_pmu_driver);
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/intel/phy-intel-lgm-combo.c b/drivers/phy/intel/phy-intel-lgm-combo.c
index 6010e246d52e..a15e73f5b1b2 100644
--- a/drivers/phy/intel/phy-intel-lgm-combo.c
+++ b/drivers/phy/intel/phy-intel-lgm-combo.c
@@ -615,5 +615,3 @@ static struct platform_driver intel_cbphy_driver = {
 
 module_platform_driver(intel_cbphy_driver);
 
-MODULE_DESCRIPTION("Intel Combo-phy driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/actions/pinctrl-s500.c b/drivers/pinctrl/actions/pinctrl-s500.c
index ced778079b76..c944c68f22a8 100644
--- a/drivers/pinctrl/actions/pinctrl-s500.c
+++ b/drivers/pinctrl/actions/pinctrl-s500.c
@@ -1721,7 +1721,3 @@ static void __exit s500_pinctrl_exit(void)
 }
 module_exit(s500_pinctrl_exit);
 
-MODULE_AUTHOR("Actions Semi Inc.");
-MODULE_AUTHOR("Cristian Ciocaltea <cristian.ciocaltea@gmail.com>");
-MODULE_DESCRIPTION("Actions Semi S500 SoC Pinctrl Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/actions/pinctrl-s700.c b/drivers/pinctrl/actions/pinctrl-s700.c
index fd00940a5799..391aaabdd527 100644
--- a/drivers/pinctrl/actions/pinctrl-s700.c
+++ b/drivers/pinctrl/actions/pinctrl-s700.c
@@ -1906,6 +1906,3 @@ static void __exit s700_pinctrl_exit(void)
 }
 module_exit(s700_pinctrl_exit);
 
-MODULE_AUTHOR("Actions Semi Inc.");
-MODULE_DESCRIPTION("Actions Semi S700 Soc Pinctrl Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/actions/pinctrl-s900.c b/drivers/pinctrl/actions/pinctrl-s900.c
index 811249a8011e..baddcf15005c 100644
--- a/drivers/pinctrl/actions/pinctrl-s900.c
+++ b/drivers/pinctrl/actions/pinctrl-s900.c
@@ -1824,7 +1824,3 @@ static void __exit s900_pinctrl_exit(void)
 }
 module_exit(s900_pinctrl_exit);
 
-MODULE_AUTHOR("Actions Semi Inc.");
-MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
-MODULE_DESCRIPTION("Actions Semi S900 SoC Pinctrl Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/bcm/pinctrl-ns.c b/drivers/pinctrl/bcm/pinctrl-ns.c
index 465cc96814a1..62879fadf2f0 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns.c
@@ -298,6 +298,4 @@ static struct platform_driver ns_pinctrl_driver = {
 
 module_platform_driver(ns_pinctrl_driver);
 
-MODULE_AUTHOR("Rafał Miłecki");
-MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(of, ns_pinctrl_of_match_table);
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8188.c b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
index d0e75c1b4417..3d811d83110a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8188.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
@@ -1669,5 +1669,3 @@ static int __init mt8188_pinctrl_init(void)
 
 arch_initcall(mt8188_pinctrl_init);
 
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MediaTek MT8188 Pinctrl Driver");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
index 78c02b7c81f0..5204d87de9d3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
@@ -1430,5 +1430,3 @@ static int __init mt8192_pinctrl_init(void)
 }
 arch_initcall(mt8192_pinctrl_init);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("MediaTek MT8192 Pinctrl Driver");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 57f37a294063..b591c54b5894 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -476,6 +476,3 @@ static int __init mtk_pinctrl_init(void)
 }
 arch_initcall(mtk_pinctrl_init);
 
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MediaTek MT8365 Pinctrl Driver");
-MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 1c4e89b046de..2d95765e3b54 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -2043,7 +2043,3 @@ static int __init npcm7xx_pinctrl_register(void)
 }
 arch_initcall(npcm7xx_pinctrl_register);
 
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("jordan_hargrave@dell.com");
-MODULE_AUTHOR("tomer.maimon@nuvoton.com");
-MODULE_DESCRIPTION("Nuvoton NPCM7XX Pinctrl and GPIO driver");
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 6be896871718..215a4aab1283 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -1203,6 +1203,3 @@ static struct platform_driver amd_gpio_driver = {
 
 module_platform_driver(amd_gpio_driver);
 
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Ken Xue <Ken.Xue@amd.com>, Jeff Wu <Jeff.Wu@amd.com>");
-MODULE_DESCRIPTION("AMD GPIO pinctrl driver");
diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index 529c0fc4ec06..111eaf8951f8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -1405,6 +1405,3 @@ static int __init rza1_pinctrl_init(void)
 }
 core_initcall(rza1_pinctrl_init);
 
-MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org");
-MODULE_DESCRIPTION("Pin and gpio controller driver for Reneas RZ/A1 SoC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index c0a04f1ee994..ab6b9cd4c6fa 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -512,6 +512,3 @@ static int __init rza2_pinctrl_init(void)
 }
 core_initcall(rza2_pinctrl_init);
 
-MODULE_AUTHOR("Chris Brandt <chris.brandt@renesas.com>");
-MODULE_DESCRIPTION("Pin and gpio controller driver for RZ/A2 SoC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index a43824fd9505..2f90c1fa52ee 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1557,6 +1557,3 @@ static int __init rzg2l_pinctrl_init(void)
 }
 core_initcall(rzg2l_pinctrl_init);
 
-MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
-MODULE_DESCRIPTION("Pin and gpio controller driver for RZ/G2L family");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
index 849d091205d4..bd60a640b6a3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -946,6 +946,3 @@ static int __init _pinctrl_drv_register(void)
 }
 subsys_initcall(_pinctrl_drv_register);
 
-MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
-MODULE_DESCRIPTION("Renesas RZ/N1 pinctrl driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index e8c18198bebd..dbd842edcce8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -1114,6 +1114,3 @@ static int __init rzv2m_pinctrl_init(void)
 }
 core_initcall(rzv2m_pinctrl_init);
 
-MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
-MODULE_DESCRIPTION("Pin and gpio controller driver for RZ/V2M");
-MODULE_LICENSE("GPL");
diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index 661e1c67f82e..a2182470a5e1 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -81,7 +81,4 @@ static struct platform_driver as3722_poweroff_driver = {
 
 module_platform_driver(as3722_poweroff_driver);
 
-MODULE_DESCRIPTION("Power off driver for ams AS3722 PMIC Device");
 MODULE_ALIAS("platform:as3722-power-off");
-MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 1c5af2fef142..b6c5cce9fe6c 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -103,7 +103,4 @@ static struct platform_driver gpio_poweroff_driver = {
 
 module_platform_driver(gpio_poweroff_driver);
 
-MODULE_AUTHOR("Jamie Lentin <jm@lentin.co.uk>");
-MODULE_DESCRIPTION("GPIO poweroff driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:poweroff-gpio");
diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpio-restart.c
index 5466eeea261c..ee6ba7313e0e 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -137,6 +137,3 @@ static struct platform_driver gpio_restart_driver = {
 
 module_platform_driver(gpio_restart_driver);
 
-MODULE_AUTHOR("David Riley <davidriley@chromium.org>");
-MODULE_DESCRIPTION("GPIO restart driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index c720112db704..cfacee839b10 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -167,7 +167,4 @@ static struct platform_driver rsctrl_driver = {
 };
 module_platform_driver(rsctrl_driver);
 
-MODULE_AUTHOR("Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>");
-MODULE_DESCRIPTION("Texas Instruments keystone reset driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" KBUILD_MODNAME);
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index 65d9528cc989..087533bfc752 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -315,6 +315,3 @@ static struct platform_driver ltc2952_poweroff_driver = {
 
 module_platform_driver(ltc2952_poweroff_driver);
 
-MODULE_AUTHOR("René Moll <rene.moll@xsens.com>");
-MODULE_DESCRIPTION("LTC PowerPath power-off driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/mt6323-poweroff.c
index d90e76fcb938..97e9de37bf07 100644
--- a/drivers/power/reset/mt6323-poweroff.c
+++ b/drivers/power/reset/mt6323-poweroff.c
@@ -95,6 +95,3 @@ static struct platform_driver mt6323_pwrc_driver = {
 
 module_platform_driver(mt6323_pwrc_driver);
 
-MODULE_DESCRIPTION("Poweroff driver for MT6323 PMIC");
-MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/reset/regulator-poweroff.c
index 20701203935f..4787829875d4 100644
--- a/drivers/power/reset/regulator-poweroff.c
+++ b/drivers/power/reset/regulator-poweroff.c
@@ -77,7 +77,4 @@ static struct platform_driver regulator_poweroff_driver = {
 
 module_platform_driver(regulator_poweroff_driver);
 
-MODULE_AUTHOR("Michael Klein <michael@fossekall.de>");
-MODULE_DESCRIPTION("Regulator poweroff driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:poweroff-regulator");
diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/restart-poweroff.c
index 04d4228119b2..7adc454658ff 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -57,7 +57,4 @@ static struct platform_driver restart_poweroff_driver = {
 };
 module_platform_driver(restart_poweroff_driver);
 
-MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
-MODULE_DESCRIPTION("restart poweroff driver");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:poweroff-restart");
diff --git a/drivers/power/reset/tps65086-restart.c b/drivers/power/reset/tps65086-restart.c
index 78b89f745a3d..866845a012c7 100644
--- a/drivers/power/reset/tps65086-restart.c
+++ b/drivers/power/reset/tps65086-restart.c
@@ -93,6 +93,3 @@ static struct platform_driver tps65086_restart_driver = {
 };
 module_platform_driver(tps65086_restart_driver);
 
-MODULE_AUTHOR("Emil Renner Berthing <kernel@esmil.dk>");
-MODULE_DESCRIPTION("TPS65086 restart driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 4b5fb172fa99..b253fc0e401f 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1569,9 +1569,3 @@ static void __exit power_supply_class_exit(void)
 
 subsys_initcall(power_supply_class_init);
 module_exit(power_supply_class_exit);
-
-MODULE_DESCRIPTION("Universal power supply monitor class");
-MODULE_AUTHOR("Ian Molton <spyro@f2s.com>, "
-	      "Szabolcs Gyurko, "
-	      "Anton Vorontsov <cbou@mail.ru>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/power/supply/wm97xx_battery.c b/drivers/power/supply/wm97xx_battery.c
index a0e1eaa25d93..73d9f7dc4945 100644
--- a/drivers/power/supply/wm97xx_battery.c
+++ b/drivers/power/supply/wm97xx_battery.c
@@ -271,6 +271,3 @@ static struct platform_driver wm97xx_bat_driver = {
 
 module_platform_driver(wm97xx_bat_driver);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
-MODULE_DESCRIPTION("WM97xx battery driver");
diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index f0654a932b37..73246663d614 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -672,6 +672,3 @@ static int __init powercap_init(void)
 
 fs_initcall(powercap_init);
 
-MODULE_DESCRIPTION("PowerCap sysfs Driver");
-MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 2a42acb7c24e..42e3a8860abc 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -181,6 +181,3 @@ static struct platform_driver stm32_pwr_driver = {
 };
 module_platform_driver(stm32_pwr_driver);
 
-MODULE_DESCRIPTION("STM32MP1 PWR voltage regulator driver");
-MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8768cb64f560..1e2dac5e54ea 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2752,5 +2752,3 @@ static void __exit remoteproc_exit(void)
 }
 module_exit(remoteproc_exit);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Generic Remote Processor Framework");
diff --git a/drivers/reset/reset-axs10x.c b/drivers/reset/reset-axs10x.c
index a854ef41364d..4f9bce547988 100644
--- a/drivers/reset/reset-axs10x.c
+++ b/drivers/reset/reset-axs10x.c
@@ -79,6 +79,3 @@ static struct platform_driver axs10x_reset_driver = {
 };
 builtin_platform_driver(axs10x_reset_driver);
 
-MODULE_AUTHOR("Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>");
-MODULE_DESCRIPTION("Synopsys AXS10x reset driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/reset/reset-hsdk.c b/drivers/reset/reset-hsdk.c
index 4c7b8647b49c..8b88aca4c4a4 100644
--- a/drivers/reset/reset-hsdk.c
+++ b/drivers/reset/reset-hsdk.c
@@ -133,6 +133,3 @@ static struct platform_driver hsdk_reset_driver = {
 };
 builtin_platform_driver(hsdk_reset_driver);
 
-MODULE_AUTHOR("Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>");
-MODULE_DESCRIPTION("Synopsys HSDK SDP reset driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
index b936cfe85641..2ca9bd5930b8 100644
--- a/drivers/reset/reset-lantiq.c
+++ b/drivers/reset/reset-lantiq.c
@@ -205,6 +205,3 @@ static struct platform_driver lantiq_rcu_reset_driver = {
 };
 module_platform_driver(lantiq_rcu_reset_driver);
 
-MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
-MODULE_DESCRIPTION("Lantiq XWAY RCU Reset Controller Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index f3528dd1d084..47b9b43470a0 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -177,6 +177,3 @@ static int __init mchp_sparx5_reset_init(void)
  */
 postcore_initcall(mchp_sparx5_reset_init);
 
-MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
-MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
-MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index e003e50590ec..0735076f3c84 100644
--- a/drivers/reset/reset-mpfs.c
+++ b/drivers/reset/reset-mpfs.c
@@ -151,7 +151,4 @@ static struct auxiliary_driver mpfs_reset_driver = {
 
 module_auxiliary_driver(mpfs_reset_driver);
 
-MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
-MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
-MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(MCHP_CLK_MPFS);
diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c b/drivers/soc/apple/apple-pmgr-pwrstate.c
index e1122288409a..968272e7a38a 100644
--- a/drivers/soc/apple/apple-pmgr-pwrstate.c
+++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
@@ -317,8 +317,5 @@ static struct platform_driver apple_pmgr_ps_driver = {
 	},
 };
 
-MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
-MODULE_DESCRIPTION("PMGR power state driver for Apple SoCs");
-MODULE_LICENSE("GPL v2");
 
 module_platform_driver(apple_pmgr_ps_driver);
diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 5bcd047768b6..6ff7a4612c18 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -715,6 +715,3 @@ static struct platform_driver bcm2835_power_driver = {
 };
 module_platform_driver(bcm2835_power_driver);
 
-MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
-MODULE_DESCRIPTION("Driver for Broadcom BCM2835 PM power domains and reset");
-MODULE_LICENSE("GPL");
diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspberrypi-power.c
index 068715d6e66d..40b05ea991a2 100644
--- a/drivers/soc/bcm/raspberrypi-power.c
+++ b/drivers/soc/bcm/raspberrypi-power.c
@@ -240,7 +240,3 @@ static struct platform_driver rpi_power_driver = {
 };
 builtin_platform_driver(rpi_power_driver);
 
-MODULE_AUTHOR("Alexander Aring <aar@pengutronix.de>");
-MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
-MODULE_DESCRIPTION("Raspberry Pi power domain driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/fujitsu/a64fx-diag.c b/drivers/soc/fujitsu/a64fx-diag.c
index d87f348427bf..84ee52116cdb 100644
--- a/drivers/soc/fujitsu/a64fx-diag.c
+++ b/drivers/soc/fujitsu/a64fx-diag.c
@@ -149,6 +149,3 @@ static struct platform_driver a64fx_diag_driver = {
 
 module_platform_driver(a64fx_diag_driver);
 
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>");
-MODULE_DESCRIPTION("A64FX diag driver");
diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 92f9186c1c42..d704c9d7eac6 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -419,6 +419,3 @@ static struct platform_driver sunxi_sram_driver = {
 };
 builtin_platform_driver_probe(sunxi_sram_driver, sunxi_sram_probe);
 
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-MODULE_DESCRIPTION("Allwinner sunXi SRAM Controller Driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/soc/tegra/cbb/tegra194-cbb.c b/drivers/soc/tegra/cbb/tegra194-cbb.c
index 1ae0bd9a1ac1..0fb96b72735d 100644
--- a/drivers/soc/tegra/cbb/tegra194-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra194-cbb.c
@@ -2359,6 +2359,3 @@ static void __exit tegra194_cbb_exit(void)
 }
 module_exit(tegra194_cbb_exit);
 
-MODULE_AUTHOR("Sumit Gupta <sumitg@nvidia.com>");
-MODULE_DESCRIPTION("Control Backbone error handling driver for Tegra194");
-MODULE_LICENSE("GPL");
diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 3528f9e15d5c..69fdd547eb3d 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -1109,5 +1109,3 @@ static void __exit tegra234_cbb_exit(void)
 }
 module_exit(tegra234_cbb_exit);
 
-MODULE_DESCRIPTION("Control Backbone 2.0 error handling driver for Tegra234");
-MODULE_LICENSE("GPL");
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index f913b665af72..d8719740bd11 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -63,7 +63,4 @@ static void __exit n_null_exit(void)
 module_init(n_null_init);
 module_exit(n_null_exit);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Alan Cox");
 MODULE_ALIAS_LDISC(N_NULL);
-MODULE_DESCRIPTION("Null ldisc driver");
diff --git a/drivers/tty/serial/imx_earlycon.c b/drivers/tty/serial/imx_earlycon.c
index 7aab38b2bd8c..e1f6e117c4c0 100644
--- a/drivers/tty/serial/imx_earlycon.c
+++ b/drivers/tty/serial/imx_earlycon.c
@@ -45,6 +45,3 @@ imx_console_early_setup(struct earlycon_device *dev, const char *opt)
 OF_EARLYCON_DECLARE(ec_imx6q, "fsl,imx6q-uart", imx_console_early_setup);
 OF_EARLYCON_DECLARE(ec_imx21, "fsl,imx21-uart", imx_console_early_setup);
 
-MODULE_AUTHOR("NXP");
-MODULE_DESCRIPTION("IMX earlycon driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 0e387e2144fa..2fe38d6e513c 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -824,6 +824,3 @@ static void __exit rda_uart_exit(void)
 module_init(rda_uart_init);
 module_exit(rda_uart_exit);
 
-MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
-MODULE_DESCRIPTION("RDA8810PL serial device driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index fcdf017e2665..8e13af1f9042 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1204,4 +1204,3 @@ const struct consw vga_con = {
 };
 EXPORT_SYMBOL(vga_con);
 
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/asiliantfb.c b/drivers/video/fbdev/asiliantfb.c
index 3818437a8f69..f1992da7e64e 100644
--- a/drivers/video/fbdev/asiliantfb.c
+++ b/drivers/video/fbdev/asiliantfb.c
@@ -629,4 +629,3 @@ static void __exit asiliantfb_exit(void)
 	pci_unregister_driver(&asiliantfb_driver);
 }
 
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 000b4aa44241..39e89b9f8dca 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1285,4 +1285,3 @@ static void __exit gbefb_exit(void)
 module_init(gbefb_init);
 module_exit(gbefb_exit);
 
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index d7edb9c5d3a3..39562b0449a0 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1631,7 +1631,6 @@ static void __exit imsttfb_exit(void)
 	pci_unregister_driver(&imsttfb_pci_driver);
 }
 
-MODULE_LICENSE("GPL");
 
 module_init(imsttfb_init);
 module_exit(imsttfb_exit);
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index a9df8ee79810..531db18df108 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -574,6 +574,3 @@ static int mmphw_init(void)
 }
 module_init(mmphw_init);
 
-MODULE_AUTHOR("Li Guoqing<ligq@marvell.com>");
-MODULE_DESCRIPTION("Framebuffer driver for mmp");
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c b/drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
index 34fae588e202..1b6bf02b1d70 100644
--- a/drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
+++ b/drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
@@ -167,6 +167,3 @@ static struct spi_driver panel_tpohvga_driver = {
 };
 module_spi_driver(panel_tpohvga_driver);
 
-MODULE_AUTHOR("Lisa Du<cldu@marvell.com>");
-MODULE_DESCRIPTION("Panel driver for tpohvga");
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index 929d4775cb4b..73b35fc67d8b 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -508,4 +508,3 @@ static struct platform_driver vesafb_driver = {
 };
 
 module_platform_driver(vesafb_driver);
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index 8f4d674fa0d0..373d6d35845d 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -405,7 +405,4 @@ static struct platform_driver wm8505fb_driver = {
 
 module_platform_driver(wm8505fb_driver);
 
-MODULE_AUTHOR("Ed Spiridonov <edo.rus@gmail.com>");
-MODULE_DESCRIPTION("Framebuffer driver for WMT WM8505");
-MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(of, wmt_dt_ids);
diff --git a/drivers/video/fbdev/wmt_ge_rops.c b/drivers/video/fbdev/wmt_ge_rops.c
index 42255d27a1db..922ec9b15da3 100644
--- a/drivers/video/fbdev/wmt_ge_rops.c
+++ b/drivers/video/fbdev/wmt_ge_rops.c
@@ -167,8 +167,4 @@ static struct platform_driver wmt_ge_rops_driver = {
 
 module_platform_driver(wmt_ge_rops_driver);
 
-MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
-MODULE_DESCRIPTION("Accelerators for raster operations using "
-		   "WonderMedia Graphics Engine");
-MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(of, wmt_dt_ids);
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index daa525df7bdc..92f0d3d16d96 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -400,6 +400,3 @@ bool xen_virtio_restricted_mem_acc(struct virtio_device *dev)
 	return ret;
 }
 
-MODULE_DESCRIPTION("Xen grant DMA-mapping layer");
-MODULE_AUTHOR("Juergen Gross <jgross@suse.com>");
-MODULE_LICENSE("GPL");
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 58b732dcbfb8..86c04f239e87 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -1066,4 +1066,3 @@ static int __init xenbus_init(void)
 
 postcore_initcall(xenbus_init);
 
-MODULE_LICENSE("GPL");
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6a11025e5850..4bc7efece674 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2344,7 +2344,6 @@ static void __exit exit_elf_binfmt(void)
 
 core_initcall(init_elf_binfmt);
 module_exit(exit_elf_binfmt);
-MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
 #include "binfmt_elf_test.c"
diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
index 7c1509e968c8..832246b22c51 100644
--- a/fs/nfs_common/nfs_ssc.c
+++ b/fs/nfs_common/nfs_ssc.c
@@ -12,7 +12,6 @@
 #include <linux/nfs_ssc.h>
 #include "../nfs/nfs4_fs.h"
 
-MODULE_LICENSE("GPL");
 
 struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
 EXPORT_SYMBOL_GPL(nfs_ssc_client_tbl);
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 67aaadc3ab07..8395066341a4 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -214,4 +214,3 @@ void utf8_unload(struct unicode_map *um)
 }
 EXPORT_SYMBOL(utf8_unload);
 
-MODULE_LICENSE("GPL v2");
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 0520a8f4fb1d..44fdbb0de1f3 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -354,6 +354,3 @@ static void __exit map_benchmark_cleanup(void)
 module_init(map_benchmark_init);
 module_exit(map_benchmark_cleanup);
 
-MODULE_AUTHOR("Barry Song <song.bao.hua@hisilicon.com>");
-MODULE_DESCRIPTION("dma_map benchmark driver");
-MODULE_LICENSE("GPL");
diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
index c57610f52bb4..692bfe95f067 100644
--- a/kernel/events/hw_breakpoint_test.c
+++ b/kernel/events/hw_breakpoint_test.c
@@ -329,5 +329,3 @@ static struct kunit_suite hw_breakpoint_test_suite = {
 
 kunit_test_suites(&hw_breakpoint_test_suite);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Marco Elver <elver@google.com>");
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index d65f6c25a87c..2ab57e6d12bd 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -38,6 +38,3 @@ static void __exit unregister_react_panic(void)
 module_init(register_react_panic);
 module_exit(unregister_react_panic);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Daniel Bristot de Oliveira");
-MODULE_DESCRIPTION("panic rv reactor: panic if an exception is found.");
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 4b6b7106a477..c8e1b3f8bb4e 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -37,6 +37,3 @@ static void __exit unregister_react_printk(void)
 module_init(register_react_printk);
 module_exit(unregister_react_printk);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Daniel Bristot de Oliveira");
-MODULE_DESCRIPTION("printk rv reactor: printk if an exception is hit.");
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a6f9bdd956c3..f1b4df16a63b 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -27,9 +27,6 @@
 #include <linux/watch_queue.h>
 #include <linux/pipe_fs_i.h>
 
-MODULE_DESCRIPTION("Watch queue");
-MODULE_AUTHOR("Red Hat, Inc.");
-MODULE_LICENSE("GPL");
 
 #define WATCH_QUEUE_NOTE_SIZE 128
 #define WATCH_QUEUE_NOTES_PER_PAGE (PAGE_SIZE / WATCH_QUEUE_NOTE_SIZE)
diff --git a/lib/btree.c b/lib/btree.c
index a82100c73b55..201de7eb1bbd 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -792,6 +792,3 @@ static void __exit btree_module_exit(void)
 module_init(btree_module_init);
 module_exit(btree_module_exit);
 
-MODULE_AUTHOR("Joern Engel <joern@logfs.org>");
-MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
-MODULE_LICENSE("GPL");
diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
index 75ccb3e633e6..d9483fb0da5b 100644
--- a/lib/crypto/blake2s-generic.c
+++ b/lib/crypto/blake2s-generic.c
@@ -110,6 +110,3 @@ void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
 
 EXPORT_SYMBOL(blake2s_compress_generic);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("BLAKE2s hash function");
-MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
diff --git a/lib/crypto/blake2s.c b/lib/crypto/blake2s.c
index 98e688c6d891..3a55fc138399 100644
--- a/lib/crypto/blake2s.c
+++ b/lib/crypto/blake2s.c
@@ -67,6 +67,3 @@ static int __init blake2s_mod_init(void)
 }
 
 module_init(blake2s_mod_init);
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("BLAKE2s hash function");
-MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
diff --git a/lib/glob.c b/lib/glob.c
index 15b73f490720..5cad078f0b4f 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -6,8 +6,6 @@
  * ATA code that depends on it can be as well.  In practice, they're
  * both usually compiled in and the module overhead goes away.
  */
-MODULE_DESCRIPTION("glob(7) matching");
-MODULE_LICENSE("Dual MIT/GPL");
 
 /**
  * glob_match - Shell-style pattern matching, like !fnmatch(pat, str, 0)
diff --git a/lib/packing.c b/lib/packing.c
index 9a72f4bbf0e2..cfa5167c84b1 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -210,5 +210,3 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 }
 EXPORT_SYMBOL(packing);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Generic bitfield packing and unpacking");
diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 6e77eb6d8e72..816c4c6f8a47 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -874,6 +874,3 @@ int pldmfw_flash_image(struct pldmfw *context, const struct firmware *fw)
 }
 EXPORT_SYMBOL(pldmfw_flash_image);
 
-MODULE_AUTHOR("Jacob Keller <jacob.e.keller@intel.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("PLDM firmware flash update library");
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index e0381b3ec410..692c1438ed58 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -171,4 +171,3 @@ static struct kunit_suite fprobe_test_suite = {
 
 kunit_test_suites(&fprobe_test_suite);
 
-MODULE_LICENSE("GPL");
diff --git a/mm/zpool.c b/mm/zpool.c
index 68facc193496..03bf00a404c8 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -394,6 +394,3 @@ bool zpool_can_sleep_mapped(struct zpool *zpool)
 	return zpool->can_sleep_mapped;
 }
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Dan Streetman <ddstreet@ieee.org>");
-MODULE_DESCRIPTION("Common API for compressed memory storage");
diff --git a/mm/zswap.c b/mm/zswap.c
index 2d48fd59cc7a..add3d5b55bd0 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1537,6 +1537,3 @@ static int __init init_zswap(void)
 /* must be late so crypto has time to come up */
 late_initcall(init_zswap);
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Seth Jennings <sjennings@variantweb.net>");
-MODULE_DESCRIPTION("Compressed cache for swap pages");
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index fc9e728b6333..597ddd40645c 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -693,8 +693,5 @@ static __exit void mctp_exit(void)
 subsys_initcall(mctp_init);
 module_exit(mctp_exit);
 
-MODULE_DESCRIPTION("MCTP core");
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Jeremy Kerr <jk@codeconstruct.com.au>");
 
 MODULE_ALIAS_NETPROTO(PF_MCTP);
-- 
2.38.0.266.g481848f278

