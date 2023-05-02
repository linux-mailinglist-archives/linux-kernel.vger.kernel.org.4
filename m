Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA356F45CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjEBOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjEBOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:11:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331821BF0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:11:18 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342AKdp6019140;
        Tue, 2 May 2023 14:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=+CIC5913oe9SMcWFmq6AAFCLs96VKE/WvzDdcJt3DlQ=;
 b=EJZ1GHCT1DDTn/UzLwZPU/qsES5IEM4zFDKVkuokWZuFWMKHHDWUDhmuf5yUgFfOXDL/
 p5vkaL201ujaaiNWRAi5Y+eDKST9HZLQOT2029F1D8p2yOJIXgQpbTTPpgj9zs+O+aVF
 pkinC6lIXFKyqMlToXuQ7/YVXCXQfItbFhnfqc80yZEv8zk7zx5bDlcR3HQADaAEGGVM
 YHjs6phe09GiCd/w61bAbDacvwYMQR6L8dX/cgIU+eQq2FNgtUEz6MMmvkfBx+SCc3TB
 RrLvdd6CTNWrY7ePOtWI6PrR+xovPtKPfmTxp9vnsn3WoLDwRNtFtgd2HK3Euf5DGRey XA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1mury-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 14:09:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342Ci5jf009869;
        Tue, 2 May 2023 14:09:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp69v7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 May 2023 14:09:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fau9YH/EeuoYiLGLKTuPnEP4GjLQYuVvK87Jx/fSg6K9KWc8k7zPAGJX+ACRr0k6uknB/Cq4TQY9KZ1JBf0UP9SqaBt4Jzu9rHvekVjN7HGYJ4hO7LJbHMMAPKqz1WKCbFD2MJdU4vFrNfZyQhN1lJjiN0iLeZ8CcfdHeViYLhrfB5jM4Hv6+SrXajEJCtkoaxFTu/KBWj+kAue1+X/6MUSbbzlqBzVfO0+qraLV7u8ryep+MjUVLL+0D8cMH1U/3lQ/5Or1pp8WQUo0GwnBiborveSTc3TtSd8ZtLibhtUfer0zHUkt92p4lJKGMb8HsvymPTVbu6yQ9xXvH2gBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CIC5913oe9SMcWFmq6AAFCLs96VKE/WvzDdcJt3DlQ=;
 b=CEmntsJW1YHkw7J6UYGR4Ir1un9zS/TXKWe7XAzlG9AcIAUomAOCFiHVt7Z44SfCgI6ylQRIM+7Asah4b+dewaZd8Cr5i90uZh2P7qrVJwIQq8YDrfnv+hrREzLKmU8zdI5J/PhKlRl/ebjNHiC1dsYN/bUFCpO0yylirz4YPjL9D2SMiI4pF9fv1tCK4oNaTzEEW0VTeuLGjfGazboQvNlOS1LbgkquaNgnxp2ZLBoE2daVVZgxajdTHV/mrvfCnG/HmjmnhJ/g5D+AGAmd9Uuk1pmj/Sf9m7Ayff3bdyeyrPIpYfE46OpZaYnErYc38d2bjld0k1GY3ernquTgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CIC5913oe9SMcWFmq6AAFCLs96VKE/WvzDdcJt3DlQ=;
 b=ej2ZqKqbGaxDc2Z8hUTW9z4fM3OdhnImByE68tvwQ9dh0bYiL8CWgDYb+vwXa/yMSKOlnOXW+3K3o5N1RnlAUYwfVtOI4UjQ5Ow3hZfWtm3Mbp5BPW3p2tcU0TR4GCksCx/53QlY5ABFZQuLEC2tE2L5mEK0unm/CK5D2V3HfRs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7431.namprd10.prod.outlook.com (2603:10b6:8:15a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 14:09:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 14:09:09 +0000
Date:   Tue, 2 May 2023 10:09:07 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Michael Keyes <mgkeyes@vigovproductions.net>,
        Tad <support@spotco.us>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rick.p.edgecombe@intel.com
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v2] mm/mmap: Regression fix for unmapped_area{_topdown}
Message-ID: <20230502140907.o7fznev4jthtgp4i@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        Tad <support@spotco.us>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rick.p.edgecombe@intel.com
References: <e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us>
 <90777046-a420-b19f-1847-d353b9938131@vigovproductions.net>
 <20230502140828.hilf3myxj6kpiunz@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230502140828.hilf3myxj6kpiunz@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0056.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: f06a3850-aa8c-4e00-4804-08db4b16cc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNE7RzrZiVsoJJ6nvDq0mu97EAWbMvWajr/l4qdBa3jvqvniLEiNbThlyWtetd4Hsm9+O/SbDaj1Fe6jFz0P3IWksFCq5k5LxEfYD0l93+jS5l3BeCXxi1zBfO5xQkuhWxyxD0NTSYVjv563asS4kX5dGA0m+QT/UBc096zVuixa/N1d1hAbQw4aPWSPhos51T6ubJ7BCYvEGKUSRSekUwUaymd9dCxWyInD2eJLwbtVzEol+Pqle45l9aq9iqok2Ssp+ihN5if/nu+juqtee0+WepiWeFBngb/odm9p7cFXMq6eyF7UyaESoZuzM5PeZVIdkbt8+SB7+cZYUIE1Y2+lxwJDrUDPe986s4NVXI/ksRz9CFeyM8rr1Usz9Rfeld1yFXf/1Qu76oaZJXU7evu0wIZalmai5Nb9pQZKq7vN4EkKwlGtrtNzWCzWCYAU+USmManR7V2glD0mYUWrlMlL8zKlN68GUaxGzLb5YpT16UByBchg9Tgw4lU8zYy9iWCCix6BU/1yjpsyimEzzRHHMsEdHEhxPZ0jiZHEHP9aCLV6PIqO8b/f95vZpQ2oh2xlYkdHMwijMOuGMGoWsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(86362001)(38100700002)(8676002)(66946007)(66476007)(5660300002)(8936002)(4326008)(41300700001)(316002)(66556008)(2906002)(6486002)(966005)(110136005)(478600001)(6506007)(186003)(9686003)(6512007)(83380400001)(53546011)(1076003)(26005)(66899021)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE0yclJ3OTlCK0w4cHRydEFlbVFVZUV6N25hZkVMVmdZcXpEVU11UFcvZDBU?=
 =?utf-8?B?aVV4QXlva09BTXFQb2RocGg1TE1LV0xxaHlNM1pDVVZPMlB3ejJhNGZNbDQ5?=
 =?utf-8?B?bVE1WnVnbXpPSTU5TytwMFkvQzVPaXN3YXNkTElDNXdzMmJSODhnMStuQndl?=
 =?utf-8?B?N1hDZ1Q5SjFhb2ZhbXkrNHF0L1hlaFBtK2NoY2lDYUZGYlNobXp1Mk4vTnNk?=
 =?utf-8?B?U0E1czV1YkY1aWFDNU96RW9TNEdFMjBjYWpKdnkzQmkwWUlTZE5NSUlVTlV6?=
 =?utf-8?B?R2hvdjBIb3d6TVhETXJkajYwTm9rUkJpUVhHMnBCeWF1TUUrYXRCTjRDMDBQ?=
 =?utf-8?B?SkxDRU1hT0J4Z0JucjhWbnVBUm5mak5IUDVIV1A3QWJKcXR1NGo1bERsTDY0?=
 =?utf-8?B?TXI0TGhLaHdrNytCWUlLWlRJQ3lESEVoVFVQT0J6SU9jVk1aY0Z4NFF0V3Nw?=
 =?utf-8?B?STJoZ1QyWFh5TExSUktkRXJTOEtjcEdsQWVFNDJnd1NHaGY0STFnRUVXMjY2?=
 =?utf-8?B?Zkwxck1GQWhyci9UOHB3SUlEMUtiR1ZxamhYUnNwMm5ubkkySGN4LzhhU0t5?=
 =?utf-8?B?RFdiQk9zK1Q0YW9sQnc1N2N0VHdzN0FCeXRWNWhzL091SkFQMVhCRlMzS3pv?=
 =?utf-8?B?YS9jZFl5RWMyL2VQak5PeGlzY25GMVNpWW1KZW0yMEk5RjRsZy9PeDAySTll?=
 =?utf-8?B?OTdiV01GNzNRYXE0a2VOWVNCb0JaVjZtMnVyNzA5a2pnYzlRaENQNzlYWld5?=
 =?utf-8?B?QUpRZkljTGtXVDlKNEhNVkN6cDdNUXRhV0orOTRGaE9Oc2gzS2xVRklVQWdS?=
 =?utf-8?B?TUMvMlprdnk4N1hoMWpZS05zTmlid0xhRGRzZzM4V3ZPS0VjRzFkMTJwdVNp?=
 =?utf-8?B?b3FTditnbVFSZHpnMnJQa0FUeGx3M1RFNWpvZi9zT1lwaVJNejdwU2NsVWtm?=
 =?utf-8?B?a3RadUErVEJRNTMxVHRHS2VyaHFsVUNZUHJtTThvYjFDWUZrT2pEOXU2YkFJ?=
 =?utf-8?B?UkQyUmh2UXNrSk5pNzV3RUNFMmxhWnYrSnRKKzNDK1lLZkxXSHNnMWlpbnBI?=
 =?utf-8?B?TytKc0Q2MjlkVUd0SGdJcGJoTDRvQ25FbnhUNmVsYytQTitLWjJ0bVB2dmlD?=
 =?utf-8?B?T2IyRGFuQXAzM25ZdXVGb04reWNUYnpzQ2VwblU5NWl6Z1VyS0ZTS2g4dnlT?=
 =?utf-8?B?MEgzZ042VHpLWlU4MDR5Y2xjakhLeVBwbHh6U1JBMElmQkx2VWFmSTlUNUVJ?=
 =?utf-8?B?MUVWbTV5anMzUWFlRzNQbDVJdHRSeU1JcjJVcWNycVJaOGFocGwyNXhTRXcx?=
 =?utf-8?B?c2NLWW9ieE44dGVEcUp5c3ZLWXFVWUpXb1VlR2pmQnJlbCtFK2FDYlRQUFBn?=
 =?utf-8?B?V2lGZTBtTnRpd3ZBRXVmWjlFck9jZmFCQ0tZMXBOMDBYbXRCVmM0bUgyaGNX?=
 =?utf-8?B?MjhibE5vRGlzYy8yZThYdEtManZBV1kzUGhNZFhFM2tkTUdpR0ZmM2dTb2tZ?=
 =?utf-8?B?MnU1bEJBVkdUSGljOE1vMTgyWVpkdURYMGdWQk4yNkZlTlc4YTJ0VFlnck5r?=
 =?utf-8?B?MjYzZlo5NFJtdW9mbjVuUlVQWWpvVzdrcXhsN0RWcENlMW5KL3ByKzV3Kzk1?=
 =?utf-8?B?U3JKMnB4ajNvVDVlalpZanBYdmpqNlRWWGIxclZSODFUVDhabWUwUVB3dlZa?=
 =?utf-8?B?MDJYWWF1RFFBQnNUR0Mzd1dGblR1eEhxd201dmM0cFNiQkh6ckhVSHk3Zmlm?=
 =?utf-8?B?SE1LSUVLRHZod250ZE5LZzNZcWxrRVFOZzZtTzNmdXVabHJZMDFyYXpRRTJ0?=
 =?utf-8?B?WnZrK1orTE1Sd05FTFl2YnBJRU1tWVdxWTlvcE5oYlBSRG92ZXV3NURISW9U?=
 =?utf-8?B?bnNRR1hKUHgzYmgzeW5XV0FEdUUyN3A5NmVjamxrbDh4UGVwcGs0N2xsbnYw?=
 =?utf-8?B?NlNuQkJWUzdGZ1hCWGx1c0s0TXhnVHhFMmc2QmtCVHYzWVl4dHZWWU9xMGUz?=
 =?utf-8?B?YzJYcVpySEdidzJDVXFUQnp1U1lraGhSRUt6MGlhV2E4YXlxT1ZEN3RSVjRo?=
 =?utf-8?B?NkNJMVJGbFNXUU9zMGt5U1oydHR3dSthU3lLWFVaSExSRzkwUDNTaFdRM1dh?=
 =?utf-8?B?OTF0YmVPMUdtYTJnNHF0NnNZaGpBbnBRNUE0ZE04Q2tzSVFOekZ4eDdWZDZP?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z2dFQ3B1S2ZzQU1WQ0ZJazc4U2cwWW5QNDNkV3VSdTBCZTBUQVlSR251NWxL?=
 =?utf-8?B?QmpHM3NoYWp4NVo2NHMrSjAwQUFtRHRmbFRMcGlTc1ZCdG1Bcjl6WTBQSXUy?=
 =?utf-8?B?MXVMeVN2bUc3VFlKeGZFMW5qVnVWYWkwRk93Zyt6ckpHeGVsL0FGNkxKOGp2?=
 =?utf-8?B?TVl0YlNoZ1IvWWlPRisyMVMvOGpBaVVMWHR0YWRYaGhFM1NOL1dkTEhhcGVR?=
 =?utf-8?B?aHZjYU9YWHExNUI0YW5tVEZTZ1hIYUZ1Zk9ZczdpVkQ3N2ZHQ2l3MkYwSU1o?=
 =?utf-8?B?Uk5MdzBHMGE2eWRGemRMbkwyL0xabzdhdVFZSThxckt1REtTWmdXcXhKWExx?=
 =?utf-8?B?Qjl6VUhmaVJtYXNPZE1YVk9IRVI4bDF0VG5JQ2NrbDd0Z29oQ2JCYW1XRis2?=
 =?utf-8?B?M1lhcjVHbDI3R0NpY2VnZ1d1bXRRRnJTWWhscWx5QmtuTFRJUCtraE9hRkVq?=
 =?utf-8?B?b09QM1I4N0ZWUmVqcXJRYVpGakFxdGJxUGlVaDEzS2w3VklhU0xyUFRvV21l?=
 =?utf-8?B?dnJiUWVZVlI3STd0bldaM2ZXRVNxcTdQUXVIMU10a3gvcDQ3Yms3RnppcE1L?=
 =?utf-8?B?bVhUbjVzZ3VPRnVsSGZZU2tzMGhmNE11a3BqWmNtRjBuUUJJSWhoQjZqQWpE?=
 =?utf-8?B?Q1FlRDNSM0IwL1pyNm9ZT25WT1BNRkFFUHczOFA1Qk5Hb2ZObm5JWEVSWGlk?=
 =?utf-8?B?Y0RiYVZER3hXQSs2T3I4TUZWZHBxNlhxcWpqRU9ZVDBkVFVJbERSNDdHUXVi?=
 =?utf-8?B?M2pCNHREMGl2TVNtUnFnZGM2QVZQckQ0R0llQkI0SkdKa05yMC9ESDRSSWgx?=
 =?utf-8?B?a3BJaE96a0V1QkdsWXFpdkM0dVVrTVVkNkhFQy9pNndqZmRIaHhpNDZVQnlD?=
 =?utf-8?B?S1R4U2ZyMlRRb3lvRlBybEJQb3lmdlpHUFlobWdZK0h3TkxwcnlzRzlsTnhW?=
 =?utf-8?B?NFhVTFErWkpqT2JFblArLzcwR3NaZlF6Z0pobUVtU0JWZHZ3SDBPa0xCTjZt?=
 =?utf-8?B?dXV6UllTMDJiTFJ0VGV0aitDOWUxRUFYSU9XelZTeCtHN3ZkSkowU0xpczJB?=
 =?utf-8?B?VHBBVTlLTzRxNDh1YklFRWdZdVBvNkJsbm00a0txOGJ4VGJ0ME1SenNPRkpi?=
 =?utf-8?B?ZUx2V1d4UEpWendrVFNPTkQ3UGhod1pMSlpzbEpmNkYvdEMrUlJaR1dYSTBZ?=
 =?utf-8?B?c09CVHJvUHRQSlVoc05tMC9ON0pqMmJaemgrZXdoWG1aY0xpZnRFWFlNWE5H?=
 =?utf-8?Q?fu6emrqdcdFpq2q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06a3850-aa8c-4e00-4804-08db4b16cc87
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 14:09:09.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU2t2tgbZtUClRT9y938NaR9vAqv0yxZGFMch2ao76+5zB6IH+6zSmZtJ4XK/Zk/sYN+CAxWOe5th2ltsQy9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020120
X-Proofpoint-GUID: jrf7dAlq4cAgonbQBQaQSNxMzoEu0LbY
X-Proofpoint-ORIG-GUID: jrf7dAlq4cAgonbQBQaQSNxMzoEu0LbY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...Adding Rick to the Cc this time.

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230502 10:08]:
> * Michael Keyes <mgkeyes@vigovproductions.net> [230430 18:41]:
> > On 29.04.23 15:32, Tad wrote:
> > > This reintroduces the issue described in
> > > https://lore.kernel.org/linux-mm/cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a=
@sony.com/
> > Yes, I also ran into this (even though I'd somehow missed it the
> > previous time).
>=20
> Rick Edgecombe reported something similar [1].
>=20
> This is probably to do with my stack guard checks I recently added.
>=20
> >=20
> > Apparently the issue arises at mm/mmap.c:1582, where low_limit is set t=
o
> > vm_end_gap(tmp). Occasionally, this returns a 64-bit address (e.g.
> > 0x7fedea581000), which is obviously greater than high_limit for a 32-bi=
t
> > mmap, and causes the next call to mas_empty_area() to fail.
> >=20
> > I'm not sure why vm_end_gap(tmp) occasionally returns a 64-bit address,
> > or if the best solution is to just check for this and skip the retry if
> > it occurs=E2=80=A6
> >=20
>=20
> Thanks for the debugging.  I will look into it.
>=20
> I am currently trying to revise how the iterators, prev/next deal with
> shifting outside the requested limits.  I suspect it's something to do
> with hitting the limit and what someone would assume the next operation
> means.
>=20
> [1] https://lore.kernel.org/linux-mm/32f156ba80010fd97dbaf0a0cdfc84366608=
624d.camel@intel.com/
