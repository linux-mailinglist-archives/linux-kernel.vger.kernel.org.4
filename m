Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4311472E735
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbjFMP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbjFMPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:25:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C8171F;
        Tue, 13 Jun 2023 08:25:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DEYb3B028043;
        Tue, 13 Jun 2023 15:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wHknyQbYtLRxFm4fwtVSoeEo3auwa++onu05vm/z6VQ=;
 b=RpA7tS0O85oCjQLT7kypiQN7/720lHy91RaydL97N+v0ZfWHtr5ZAol4EhLh0UUTSqX3
 B8lfqinIzlKbhZsJaWpidS9YilG9bpNk1zPIV7MldLM6MXQi0pTg5H0unJhW0rVw3qVz
 GnvkWVxIZg75WYkkCWFBPDZMG4wi4I4UQCvWqdYWsgekHgDLw3yEEGd3H81LRz0plbMb
 IYbh7yrDb+lVc6F9al3c9lKmNVFWWh845oQL99ExnzQvIqfmrriSlkjXNfs4wxi+w17f
 OULRmzQUL5namNiHhjRhXAqCW+dgOGoPOuNuyr4+aYrYodC+ZXzKI20pqT+Z8cVOz4Q0 kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqunhr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 15:24:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DEFqAB008297;
        Tue, 13 Jun 2023 15:24:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmak6yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 15:24:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Klralosgy1i14I0KcYdpfrRiv3Dl+u5uDRHQpr3RSx9W+2T8pz6TbkmdKAI9P2GRNJMjddhB1FOwnGdcwksGHJwIDJPAJ3qvynRCsc4LGtUnkcodMjWmrmkpao+4TQTBdr+Dn8S2SUdc2DcOWtkCSieTTYf7a3jMvNo9UjC6nTJQyH7HEYFabUe0ZlfQLtoEplyvakcdNONFIlR8JFI8rHRcksdYes27XEge+epeqpzZolAga5tO0WuI6KapwAiXg1Rcas7MJ+0dP2CKByFYPBI7XVeIcNPO9jEYI5jybeiLjxQDYa2mxpCtrETC7wxEEqPvm8F8NNwKHH92Ag4m+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHknyQbYtLRxFm4fwtVSoeEo3auwa++onu05vm/z6VQ=;
 b=GgnfUfzgwTl1AcnOhdTolLEgAyL5GaJtiR2XctA3h/kc1mOqo5SuXscBB+V2FWSgdV6MV60jKfcxULlsUb3Xddkj5BMpkrN6/RKipNVxkaeorh5B94Ra5OPEcwb2J8HyTTwi+J9nkBhtukdvDHOFMj8QD/s9FptlFL2Eq2W9GgCI/mkcco/pVSTtJQ/FocTZP/LWJ4jElXqX7TpT5lpHgfPvXKHUoHA8mhboFkifqmlDtI92ji93Ec4OaM8K/H9qDEICHilCXb59d614S0ilE5UvN0dmxsmJxl5Hr5nBxFFEMo/UA7xPCS34gtz0d4zEzQiBZlLh+bKOHrXPBWAvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHknyQbYtLRxFm4fwtVSoeEo3auwa++onu05vm/z6VQ=;
 b=cK35qlzQecR6Mn3sOro/oZ1KUMebWQ5+NmS8bO0+qc4XWrJRATANaeZG4NfI7dprK3q2+czhYQDvfyVTVzwdmPTijuDNXpDYAa4iNyx5DzyBF8sEyGONfBitAsL4D951bh29JwTYQEnNo6v0k3YSYM5wkm7OdVnePJH5bbVayyo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 15:24:36 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 15:24:36 +0000
Message-ID: <13118eaa-6fae-7b45-9f3e-ab95e7d34729@oracle.com>
Date:   Tue, 13 Jun 2023 10:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v23 4/8] crash: memory and CPU hotplug sysfs attributes
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230612210712.683175-1-eric.devolder@oracle.com>
 <20230612210712.683175-5-eric.devolder@oracle.com>
 <2023061320-vindicate-usual-6643@gregkh>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <2023061320-vindicate-usual-6643@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0046.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::20) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9c7625-b475-488c-6ae5-08db6c224bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lIuY2ezt0pnxJSt83aF0NuLDIhN3m3lwtCm/KGcQkDfgTWUtejHpFRpUkTCFLZwRbI2XPD/C84uJesxwlewfoRtIAzMxUPqp6HBwIM2a7iBrlSvbsMyEQ+s5lD6gJhssYio62twZ+z8ks4Kc+g+le2diZ/mX5kuHrwPM2S5NIYn9bi1TLL6M6mDsg+15buylcNWgHgVxbMQmWZiIXnEbHRiaVX8SgxmRJLR2x7M/PxxTQFY81kr/ht8XFR0Q2dL9jbMy9t3JDg0QAh4aTKIJ1N/IVgUXn9eztPMeHuJx6iatR6bkaOz08U7rfMnXrG9LL/qRXDtqZKHZqGX4xiry1qukQy04rj/mzAc3yaOluCYYlzzlWyJWTMDTzNClcInoynpZkfJWdwuDEVDdzq/TWGaqHZE5jTKxUch+rXa5Mrm5r4XctwwVknmjOL4oTzBZ8Zj1E9oH6tsW2bYRAsuSPkXy7D9TI5nW2nVaytVJ33YOHv9OBJVRVRAcONFI1fEmJeMaYXICFvlhDDsVjd9RMtsI2iFgrBbJQirNO34mO4LWsKMmUKb1qwpURnS5/WX8eYm89AiY/xGND6AWmv48SweeMJQoII6TtG+TlkgJzUUlA5D/fJkBROwADaRf0oxnH24c/WQBdNk9uj36+utIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(66946007)(66476007)(66556008)(478600001)(8676002)(5660300002)(8936002)(36756003)(6916009)(6666004)(31686004)(4326008)(316002)(41300700001)(6486002)(38100700002)(83380400001)(6506007)(7416002)(7406005)(53546011)(107886003)(2906002)(26005)(31696002)(2616005)(86362001)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVc3SVQ4cVBUNnp5QnZwaXRyKytzZUNEVkpZOTBQaG5kd1piSytYeDFnek1E?=
 =?utf-8?B?V0hibHlPQzFHZE15MHMzS3c0V0VLVnBGSXlqVHZjbCtBL2l0TGFrNWRRdmZY?=
 =?utf-8?B?aytLczZuVDFvQlhsc2pRT2RtK0ZDUDh6T2RaWktReit2RjV4N2hianE5VGZk?=
 =?utf-8?B?bVhUZ0xSaldyVWNkdFdIanFsektONVJiT3lsSzBiV3h1N09NczVwUGN5TU5r?=
 =?utf-8?B?U2hFUWtQR2pKdmErVTdobHd4WnVrY2VENUNQNEFtMVBuU2QzblpEVFhaOWtH?=
 =?utf-8?B?VjRhdTBZcWI3U2d4WjlBMWkvTWtEKzdPaWZiU2ZOZGtNc0FqUWg4Vm1NcDJr?=
 =?utf-8?B?Ly9IbXB5VXdVUjV1b0R1cE9xU2ZyWGYzY25zQ1pXT09TMWZWTlhqM3FtREVl?=
 =?utf-8?B?QWx5bzdDWFBGa2drcVkwaFlpTi9YTUFIRVBoOFh4bkJnVmpuSWlGZ0pFT1lI?=
 =?utf-8?B?R05vdjVVTGtBZDdvTlFNK2hyMW03cldyRk1ENllSZlhtNWROVnlZc3Z3NWJw?=
 =?utf-8?B?QWN1M1c0VWMzSDNPUWovaGRXMGFNWUhBM3h0SS9kOHVmWTZLaTQ2QTkvVEhN?=
 =?utf-8?B?d0hERkY0bWRBVUFpREpadldxVGVYRzd3bmxwTHVEN3N0dGg2NkZHTVQ4OFBz?=
 =?utf-8?B?bmQyUDc5SmQzVnlaREhyeEtpaGZyUkVzMHh6bTd4NDVxNlNBS2tURGFpTG9I?=
 =?utf-8?B?S2J1UjBVK0FxdmdUY0diY2g0NUVMS3pyNnlWbVg0bERYSlhTR21BN0tIT3Yx?=
 =?utf-8?B?bDlBUmxWVjlEY1k3eHFoWEJTMW9wYXhJYThVYjQxU3FjMk40aTUvS0N0NHdN?=
 =?utf-8?B?c2UzM0hpbFV0cVlZVDM4Q0ZQeWthNkhEbisxQW0wWTFablpoTU4vd240VDlN?=
 =?utf-8?B?OUsyL0VMRzYvTXNrM0RRNFBWd21DVjc2NjhlOE9CZ05HR1BXSzMrUGt4emdh?=
 =?utf-8?B?anEwRTVUaXovMDZKQlRpRCtJQ05ES0IraTk1TUNEeXZqR2pyRVVRVUZtK0ZS?=
 =?utf-8?B?cTRlSGlsc1loUG52NGt2cDBwUFBNMVpIREN6UjdmUmx2bHRHZ1k5TFZ5dGJW?=
 =?utf-8?B?R2lxNTgva2FIc3lNb1JrLzF1ZEJacXd5YlpkaTI4NjdYbFlnUnNuOFR5eU5K?=
 =?utf-8?B?NWlsN25uMVY0aTF1RlJhYS9iRzFEMGRPK0g1OEtvUWdPNk5sZndIcWNIeHl6?=
 =?utf-8?B?aFRQOG5wQS9GWlF2NW1uMXFITjB1ZU1QeHdFaUpvVVBkTGJHdHo1NTNmNDdj?=
 =?utf-8?B?RTlEUi81emcwdTkzdkovREpWakJZQVdwcEw0aTF4T05jSkN0bUkrdTRVcWhB?=
 =?utf-8?B?Q20vSmFzbFc1dzBJazZlYVViYjlWRGt1QmhGK1k1a293UlExVzBWMkF6ZTZy?=
 =?utf-8?B?L3lSN2FRVi9XWEhYVTRJRFo1a3NvKzJiSTF2cDRRUzZoa0RySFA0TzJRRFFw?=
 =?utf-8?B?LzdGd3d2Vm5QNkY4WkJveHU0REpBeC9UR1RlUnBXTk85MGprM0kzZVRvTnFm?=
 =?utf-8?B?SG1XMS92UndiRzBkKzZwNzNrK1A5RmlyTTdrbUZ6R2x5bUN0VWhoNWt5RG5n?=
 =?utf-8?B?U25RdUtCdGtCNFB1ZEliWlhONHh4d1JBaTZ4dzFkZFRVNFI0T09ONVdubXRF?=
 =?utf-8?B?U1UrVGtJWERYaDFpMmNYdExrMm5QQ3dndE5YeVI0citSYmhPemNnSWdqemk0?=
 =?utf-8?B?SEtWNnJSa3lyZ3lPcjJoNUhXZjhTdDlpNDJxRHp1K002WklvWUVNUUhvVCth?=
 =?utf-8?B?THVlK3RwcS9ORnI4OTFRQkpPVWZ6enRBQXJUV0RhNDZlWkpZeTdmWktnVXFx?=
 =?utf-8?B?dTBENksyM0xHT3VTVEVIRnBOdTQ2MkwwZzg5UTRLQy9SWFhNNTE3SWNXamZS?=
 =?utf-8?B?Q25pcnQxU3F5TFpHMkowZyt6RGtudVo5d1pleFpoUVF1Q0dEWDRoMEFlUlZx?=
 =?utf-8?B?ZTl5ZVNtb0RvdWJhYndhUENDZ2pvSlg2T3RGT1ZiRzF5R0p4SVAyMkQ3c2NV?=
 =?utf-8?B?RkkwQUwrV0w1YWJkSmR1VFZndElnSlJXd3lIMVhCTTkwN1doK3NYQTZjc21y?=
 =?utf-8?B?Y0RyZWF3bWxTSmVmT2pHMU5QWFdGSzloWldaM0ZWVGlDVERvV3BBR0NvTlR5?=
 =?utf-8?B?cFNwNU4vMnNKVzhEdDJHOUJra3A1VURndThPZlozcmxOUzNKVWVlY0p3SHJB?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TC96UXRLQzcwcU5nWkVJTXFpMXlmUndVeWk0TGJaNit2dVVVdDcxeS9INHZC?=
 =?utf-8?B?Rmx0L0RmSXNET1RnVllTOFlXSk96bE5OcVR3UzBGVnk0aUczTzVvNHpuR3B5?=
 =?utf-8?B?NjhZTUlYTTY1ZHBXbHdmOUNCVThRcjZPOFI1VWIzQm1WU3lQa0VwY3BlR1BN?=
 =?utf-8?B?akJkd012alIrRFNiQTZJSEZJVjFyWW9rMWZoNzlLMWp6K3hxaDcrcEt6aUdj?=
 =?utf-8?B?MWgrOENaSFZQdG9xVzhKd3hoWkdnRFNzNGo0bXBSZzk2Y3lPQ2ZES1ZxUHlU?=
 =?utf-8?B?NUNMdmpTTktZRmtLc1RHY3BnQ29qVnVtSnVLVFJoTXJITElscU82MTB1MDJJ?=
 =?utf-8?B?ZlVJclBJSVduRFB6ZC9QVWhFU05CcEo2YVMwakRaUnJDckRjb3UwYnRnNEZE?=
 =?utf-8?B?R1Nhc3dQdnBHVTV2SUNQdGlRV01rei9KMndFNDhWK2FJRFhHVG5QamNJb1dr?=
 =?utf-8?B?ciszZVJSWjg1dzdsMmd6dEIzYmFFVDVLTktKTFRKWXJ6SlZYVUxkNlRhdmt2?=
 =?utf-8?B?dmYzdHJkd3NYZFNaQUNWdWpEVWZHUThhR3JwRHdwTFhzQUpxdTlvMUZiYnk1?=
 =?utf-8?B?eVRDRXpRWStXQkNWQ3IramxkUlJTTFdDcEFBVTIydTJEdEhoOFoxVitCYUVw?=
 =?utf-8?B?cVVlYzFhMHVETmRJVkZPM29HQkt0SnlIRjJ1VG82U05iQXF6UDFRTXRYWHJV?=
 =?utf-8?B?RkxKeW1vYStBSDdZRldKUnkvODgwaTk0REhMVXY2bXNRTTh5YWVCZVNGN2hI?=
 =?utf-8?B?eWJjVDcwK1dwV3VQYU0wRm1vcnkvd0czaFlDTHI0ZDd5SUROUC93OU8yNjZj?=
 =?utf-8?B?bk91TEZ6cE1ma0g0ZGpiUEJQZ3dnVGdOaHRaZG4yaXdyaUh6Q2p6RUxEeWhK?=
 =?utf-8?B?eUZROVc1Nmxid3E4R3RqYWhoVmJUazRwd2RTM1ROMTFqWmFLdlQ2UEltTDlB?=
 =?utf-8?B?TExLODA0cTM1dVNuOFRyNEE4bDR2MDQwV05GQkczZUtWV2FCcmk4cm9JN2Iy?=
 =?utf-8?B?Z1REcVhDWXFSRjJ2Ky81VnY2MUwyZGVnSXZ6V0NSR1lGZ1Y2cjFvdUtGR3Rj?=
 =?utf-8?B?bVIyNTBObkVJSHJ3TU5hbUhzVjJWTGRWOVZqTUZTbnNvTE1Db2pxNDY1czR2?=
 =?utf-8?B?VHhtQWlPeTZ3MFJDemVLSVVGSm56UGxaTGcvU0o2U0VrRzlGOW01czRac01H?=
 =?utf-8?B?Znp5RlBQS09xL0JtOUQxbzVYVnhuK0xWOXFDSDZvQzlmYU9LQUlZWEdRVm5u?=
 =?utf-8?B?RmdMT3F4eGNZVDZQbTIxVm5SY3RGaEticEVDcGFTNVhxb2ZNSXNPT2d6dmJS?=
 =?utf-8?B?TEFaUSsrTVlMQ2RXVXE2RHBqcHQyd2hGUzRiUWFjbjh1RXpPaXRVa1JYYWR2?=
 =?utf-8?B?bWZpZ2FhRFhXM1BsOGE5ZEg1YUJTbGRHV3MzN3d3VGQ2YmZ0RzVWZHo3eThh?=
 =?utf-8?B?N1pjQVZISGFmMGdxWWIrUWVEVXpIU1Y4RnJYRzJiZEpaSzQ0QXZiU1hpalZS?=
 =?utf-8?B?NUErRit6cHN1MzFuclF4bHJOMW5icUltTDgvODd0THJveFNobksvRFdDbG1Y?=
 =?utf-8?B?YzcwU0xxREk0eXRscWNqdUFVWkxOOExiUDlBTnRvd3FTMEZwYTVwQkJkMnZU?=
 =?utf-8?B?UU5yMkVodFNhUEE2Nkl0aHpaQlJhTXZ2cWNyMVZlSUJRVFpNbmtudXdBcStw?=
 =?utf-8?B?UFVKOVRRWGhFdXg2eVFyRHlqVVdwUld2clVzbGI0aWE5ZiszSWc0cm1LTkdW?=
 =?utf-8?B?b1JQNktOUnU1NEE0OWhlUDRUN0VrTTBScDhteTh3K0tITGszbkd2eGk5MzFV?=
 =?utf-8?B?VC81QUlRcmk5WWJtZVJWcmw5SjZVc2xBMjRCcG5kcHZPY3JjemJ0R0pZWXpm?=
 =?utf-8?B?aUZuUVcvaXcrVW1qdHo0NlQyaWhOT3o5a0d2aUt4K1c4WlE4bHg5SnZaL3FQ?=
 =?utf-8?Q?uRtf0M6Ox1w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9c7625-b475-488c-6ae5-08db6c224bbf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:24:36.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLXJ7Imoq0HjwCp26X6yHGcrBUsO70d0rMJylr7OqkY215sYzK6Wb5ua/yX2XrKqOxk2XS9y4ex0HwmSUPApS7pAn0Pg9+FJ3GgnJ2lDlGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130136
X-Proofpoint-ORIG-GUID: cgQFTKcgfbRT3pqDiPagsWZrd21qwGIl
X-Proofpoint-GUID: cgQFTKcgfbRT3pqDiPagsWZrd21qwGIl
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/23 03:03, Greg KH wrote:
> On Mon, Jun 12, 2023 at 05:07:08PM -0400, Eric DeVolder wrote:
>> Introduce the crash_hotplug attribute for memory and CPUs for
>> use by userspace.  These attributes directly facilitate the udev
>> rule for managing userspace re-loading of the crash kernel upon
>> hot un/plug changes.
>>
>> For memory, expose the crash_hotplug attribute to the
>> /sys/devices/system/memory directory. For example:
>>
>>   # udevadm info --attribute-walk /sys/devices/system/memory/memory81
>>    looking at device '/devices/system/memory/memory81':
>>      KERNEL=="memory81"
>>      SUBSYSTEM=="memory"
>>      DRIVER==""
>>      ATTR{online}=="1"
>>      ATTR{phys_device}=="0"
>>      ATTR{phys_index}=="00000051"
>>      ATTR{removable}=="1"
>>      ATTR{state}=="online"
>>      ATTR{valid_zones}=="Movable"
>>
>>    looking at parent device '/devices/system/memory':
>>      KERNELS=="memory"
>>      SUBSYSTEMS==""
>>      DRIVERS==""
>>      ATTRS{auto_online_blocks}=="offline"
>>      ATTRS{block_size_bytes}=="8000000"
>>      ATTRS{crash_hotplug}=="1"
>>
>> For CPUs, expose the crash_hotplug attribute to the
>> /sys/devices/system/cpu directory. For example:
>>
>>   # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
>>    looking at device '/devices/system/cpu/cpu0':
>>      KERNEL=="cpu0"
>>      SUBSYSTEM=="cpu"
>>      DRIVER=="processor"
>>      ATTR{crash_notes}=="277c38600"
>>      ATTR{crash_notes_size}=="368"
>>      ATTR{online}=="1"
>>
>>    looking at parent device '/devices/system/cpu':
>>      KERNELS=="cpu"
>>      SUBSYSTEMS==""
>>      DRIVERS==""
>>      ATTRS{crash_hotplug}=="1"
>>      ATTRS{isolated}==""
>>      ATTRS{kernel_max}=="8191"
>>      ATTRS{nohz_full}=="  (null)"
>>      ATTRS{offline}=="4-7"
>>      ATTRS{online}=="0-3"
>>      ATTRS{possible}=="0-7"
>>      ATTRS{present}=="0-3"
>>
>> With these sysfs attributes in place, it is possible to efficiently
>> instruct the udev rule to skip crash kernel reloading for kernels
>> configured with crash hotplug support.
>>
>> For example, the following is the proposed udev rule change for RHEL
>> system 98-kexec.rules (as the first lines of the rule file):
>>
>>   # The kernel updates the crash elfcorehdr for CPU and memory changes
>>   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>
>> When examined in the context of 98-kexec.rules, the above rules
>> test if crash_hotplug is set, and if so, the userspace initiated
>> unload-then-reload of the crash kernel is skipped.
>>
>> CPU and memory checks are separated in accordance with
>> CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
>> If an architecture supports, for example, memory hotplug but not
>> CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
>> attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
>> attribute file will NOT be present. Thus the udev rule skips
>> userspace processing of memory hot un/plug events, but the udev
>> rule will evaluate false for CPU events, thus allowing userspace to
>> process CPU hot un/plug events (ie the unload-then-reload of the kdump
>> capture kernel).
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>>   Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>>   drivers/base/cpu.c                             | 14 ++++++++++++++
>>   drivers/base/memory.c                          | 13 +++++++++++++
>>   include/linux/kexec.h                          |  8 ++++++++
>>   5 files changed, 61 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
>> index 1b02fe5807cc..eb99d79223a3 100644
>> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
>> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
>> @@ -291,6 +291,14 @@ The following files are currently defined:
>>   		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
>>   		       kernel configuration option.
>>   ``uevent``	       read-write: generic udev file for device subsystems.
>> +``crash_hotplug``      read-only: when changes to the system memory map
>> +		       occur due to hot un/plug of memory, this file contains
>> +		       '1' if the kernel updates the kdump capture kernel memory
>> +		       map itself (via elfcorehdr), or '0' if userspace must update
>> +		       the kdump capture kernel memory map.
>> +
>> +		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
>> +		       configuration option.
>>   ====================== =========================================================
>>   
>>   .. note::
>> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
>> index f75778d37488..0c8dc3fe5f94 100644
>> --- a/Documentation/core-api/cpu_hotplug.rst
>> +++ b/Documentation/core-api/cpu_hotplug.rst
>> @@ -750,6 +750,24 @@ will receive all events. A script like::
>>   
>>   can process the event further.
>>   
>> +When changes to the CPUs in the system occur, the sysfs file
>> +/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
>> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
>> +or '0' if userspace must update the kdump capture kernel list of CPUs.
>> +
>> +The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
>> +option.
>> +
>> +To skip userspace processing of CPU hot un/plug events for kdump
>> +(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
>> +file can be used in a udev rule as follows:
>> +
>> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>> +
>> +For a cpu hot un/plug event, if the architecture supports kernel updates
>> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
>> +the unload-then-reload of the kdump capture kernel.
>> +
>>   Kernel Inline Documentations Reference
>>   ======================================
>>   
>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>> index c1815b9dae68..06a0c22b37b8 100644
>> --- a/drivers/base/cpu.c
>> +++ b/drivers/base/cpu.c
>> @@ -282,6 +282,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
>>   static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
>>   #endif
>>   
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +#include <linux/kexec.h>
>> +static ssize_t crash_hotplug_show(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
>> +#endif
>> +
>>   static void cpu_device_release(struct device *dev)
>>   {
>>   	/*
>> @@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
>>   #ifdef CONFIG_NO_HZ_FULL
>>   	&dev_attr_nohz_full.attr,
>>   #endif
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	&dev_attr_crash_hotplug.attr,
>> +#endif
>>   #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>>   	&dev_attr_modalias.attr,
>>   #endif
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index b456ac213610..24b8ef4c830c 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>>   
>>   static DEVICE_ATTR_RW(auto_online_blocks);
>>   
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +#include <linux/kexec.h>
>> +static ssize_t crash_hotplug_show(struct device *dev,
>> +				       struct device_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
>> +}
> 
> This sysfs file has to be documented in Documentation/ABI/ right?

I will add these entries.

> 
> And did you use checkpatch?  It should have told you to use sysfs_emit()
> instead...
I did use checkpatch, and it did not reveal that.

[root@localhost linux]# ./scripts/checkpatch.pl --patch 
../v23/0004-crash-memory-and-CPU-hotplug-sysfs-attributes.patch
total: 0 errors, 0 warnings, 103 lines checked

../v23/0004-crash-memory-and-CPU-hotplug-sysfs-attributes.patch has no obvious style problems and is 
ready for submission.

This is not the first time it's been suggested to me that checkpatch should have caught a problem; 
is there a different invocation than what I'm doing?

> 
>> +static DEVICE_ATTR_RO(crash_hotplug);
>> +#endif
> 
> All of these #ifdefs should all be removed and instead use the
> is_visible() callback to determine if the attribute is shown or not,
> using the IS_ENABLED() test in the function.

ok, I'll correct this.

Thank you for looking at this!
eric

> 
> thanks,
> 
> greg k-h
