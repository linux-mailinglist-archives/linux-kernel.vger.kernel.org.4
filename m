Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3986E666D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjDRN4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDRN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:56:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F6D2698
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:56:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ICXJYE020315;
        Tue, 18 Apr 2023 13:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zuzHXePu5xdyoiM6/rX6Mzd1qstwEq2bf+2GjsKkBeM=;
 b=rrxTAHIey1qfYNpPO25FrEU8jOhJdu8bve1u1aNgRf8UYl+/Rh9BoKH5UrGsWHFpC2Pu
 7/jNWoOErZKevRWtNgE/4msqmIELrMhwFdv8lBe+w72nptxNGIJ6oCLELtrDLkgihfuO
 y6R667ZVnsBRVFsZbUVO+9B1JuidhtkTFaGOR+pfyWf69O/EnuQ51dOu+VTumL8G3kRR
 x0JJcJ9LIcALu2BKNv+cAsmAgrCywXJYckuwPaPwWBdee8DRZmodDR5eQgAp6eHA9533
 iQD6IPEsq1uW5GoXW3Sf+ns9zfN0SXfHiadEu8+YNKYhK+hRQMPFEY4n/dYCBt8RUR1z SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyktannpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 13:56:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33ICVdDx011451;
        Tue, 18 Apr 2023 13:56:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc593q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 13:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8fCDs4rWVScZFalVVlPbLn6UmK/i2L1cPkvisZ9TtGSVBCEzuf/AQBTBCSGxGqoSrnsN/sbqGvbMT63CbUfjUr8toA31jTnHCZ1r+UdnSO9FqS1zBqS8q91FmcAtapQismKGfZkrR7sbaVBOA+t72h1hanBiQh0Djs4plm9QPkPOiv+G0/zaSNAw7hk5w2tqOUlrzkRYjz22RqRFo9LRjbH3SpV9H/We9V25oDW0/FnEvotavxBzLFuOMcW709VWQcKKDa7GrU6eBCIXEv5YOyQiSw/SOajvNkmz/S38FqQIha5nrKNrOetJ8FhfrzFqfZS5TbOKoUu2oVnavRtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuzHXePu5xdyoiM6/rX6Mzd1qstwEq2bf+2GjsKkBeM=;
 b=fQpD1rBTvalYKYtVdLP2l9ZxsvP+RQXwQbdWAAeIX2sB3qAeGEuYv9977Gc7R/4MtT/wwbv36RqwDOZGjgynslIk1JSy7SMhThACLBMrCo4Nr12+2zBl9WZk6i9a5Wjfx3kJSwPYRjzJmXeBkgMs1V7xF0V59vhsI4JaDoJuFMc7HQHpNwb5LeIBLRZiWvIW2GSY5c9+3p9qOTt/LDUzTG1teXq+mqr3NyKT64VfCgQ8J+AV5tLHAhJnhxyt5qlB8SsM3Rmpa2rehDaxyHsMlp8ijNwTolMo7jA6D5XnbTgUy2KPNbSOfHKAFpQhsQ/N7Qin2XBHHHZ64tg4uivdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuzHXePu5xdyoiM6/rX6Mzd1qstwEq2bf+2GjsKkBeM=;
 b=RAiAGBdGgJ26IX8irGZQs8CPPqiumkGz3NtjMqn2Q6L9QfbbpCxSd/5s/X7jTt/ere8ZMdz9izPcwg3/3mCHYfid1ConjGF8w5B8VGW6rjkCqzzMvpuIv7nasC8QorHTy4GPRC86HJYpF9U6ldZMYJKhR+dC8FL3TEi1ES9au8Y=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Tue, 18 Apr
 2023 13:56:07 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::ad42:b11a:662:9466]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::ad42:b11a:662:9466%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 13:56:07 +0000
Message-ID: <7b25449b-72e9-3eca-73a9-592d7400b746@oracle.com>
Date:   Tue, 18 Apr 2023 08:55:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v21 2/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-3-eric.devolder@oracle.com>
 <ZC6nWzPuIWOxmvv2@MiWiFi-R3L-srv>
 <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
 <ZC9cp5RLyNNx0DMG@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZC9cp5RLyNNx0DMG@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::10) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: d086b3f4-0639-4e06-67e2-08db4014a831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZmjSkYNwEn52YQAYgdVND7Il3kJlnAyna6F0oo3Ur7+PDpGMMMjYVwCYq3HBChLenP64b7Y0eF3peuI5deBuiU6tFd+EHvtXC7pV+fAJFQjpsOJPkaenemhZ5qRwv5YnXkRoN4RkozNlgsvMUCvRe6z6KdnOl+34fI+Lt9kj2A6Qp8o08mYrv98VFCPpft/AGOi7ADFb4CeVBDHseUehOHu20Uemf1YhdXLxVSSLUSV4/pnXGYR4PDvMMnG9GpXACI1AZAi86JkwHpghhM1bl8RTdSB2Fs/OBfBJoNJXatNV2bbg/koTsYFSefmb0e1QyXQQqxs2M0IjlodKaIXIOTriOpcAnJdNHGJPdVMsbteBdGDFXIPf0SVa0LA+XvNTCSngQJH15hWhyhiXAgk7/XRPsLGoA3kXCnlqZRVQvqTNB/Vlmr/RwwAIrQ8PXKrTCm2t4rwSgx6lMQOZbDQVUZoum95nsKIgQkRM6CEg2ICbLOQeUP1zIdScuyUv3BMijTZfm1qAoTpgYf1cYx13v8DenUUvaRYVC/jkZrJshB/XSWop9oxZ5cLX3WRLKP4HsVwztxXIXkIBwEdgSxmZLlC2OnhbyTczhwhl0Jsd24/Yga38e/BVilU4jv9BUMl+V0kIoMKqe/ER+mlti9G0Ndc6BMpKc7yob7gcAYZ9rPNiNJqWfofjw5qliBeliOgnrqG5T/8JqRMzf4gM6tSRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(5660300002)(6486002)(6916009)(66556008)(66476007)(2906002)(66946007)(4326008)(36756003)(7416002)(86362001)(8936002)(41300700001)(6666004)(38100700002)(478600001)(316002)(8676002)(31696002)(6512007)(6506007)(31686004)(53546011)(2616005)(107886003)(66899021)(186003)(83380400001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdjaldmS1hldUQ1TVpLYlVzNnB2VGNSald6TFBFTnU5ZGE4MGh6Uk5kOFho?=
 =?utf-8?B?eVUxanVkTGRlVjRBTzhnK3o2MDFKdElqVUxCbEJYdlRxNXhQRDVMd3E2QXpq?=
 =?utf-8?B?SXVGay85NkRHYTl5MFdLMUZYYzBsMGxnMVhxWkZTQmtIMTBNWEk0cFBFQkpY?=
 =?utf-8?B?dU4xOEtSZys3L0MzR2NYd3J5TDEwdXN6d0Vqa3QrNFRLK3Q2N0RDUXFEb1pB?=
 =?utf-8?B?dW1JbVJkQXFoSG05MzdOdUtpZTUyQWowZkhyQzBqRnVpb0J6TThTWDE5d0FI?=
 =?utf-8?B?V2dQZmZFV2w1QUhJdnF6MnJTUVRRVjFRM28wbEJncUcxVWYycnR5ejNYUW5E?=
 =?utf-8?B?V3JQZW4zZjI3NUE5Mjh2S215RDBleDRCUlE0R3E3djVFTW12cHlBQ0VFVjRJ?=
 =?utf-8?B?ejArR0MzeWZpeElMWUJFYzBSNTRQTnBodHc2OEdjZWp5Sm0wTXNRVTNjWW9V?=
 =?utf-8?B?NkhqQ1FkazJVUVFzSi9BdXBMRHBTNi9EN1RXLzNIL2IxOEUra1BqR0RuRGkw?=
 =?utf-8?B?QTA3a3ZuNEozbDEvanY5cjI2N1E1cHpRTVdvL3BZWUNzT01hMzNuU2JFZVU3?=
 =?utf-8?B?SW5lKytxUFVZVkR5eFlMcVQvUVFxdmN6MGNabUswd2hIKzFGRkJUWUtMaDla?=
 =?utf-8?B?RlNXanhnNkJFZllLc05DM0JkV3VPQnJuZkZ3M0pkK0lxTHlRamJyZnFaei9R?=
 =?utf-8?B?RXd1bDdhbUhqL2ttWWN2d1lGTTMzMEF5SHVqaStaNEYvOGpwSUxDR2ZwUHp4?=
 =?utf-8?B?cXk2YTIzYlg3RG9Ua05jZzdkaytGK1U4eHBtTldoemR3ZjdBdFhWUE83SWt0?=
 =?utf-8?B?T1ZRdDFLZ29pRzFwcjJNS2RmYmZmUStENlNzVG1vQzhQVG5nbXRaQVprWW9n?=
 =?utf-8?B?bVdHQU5Sc3BDSHpzVE1nUUZINVdEUDNzMmlrdnRMcm8rQkVxQVorNXBHRXMy?=
 =?utf-8?B?L0pINjFxUFB0dEJxdm9rVXlaVVZnU2hMdzNXTFZ1U2hNUGJKTVM1S1RvY3Q0?=
 =?utf-8?B?dklPNHpYaDBOSXl3c0d1QTRMMHo0SDZqZFZIRzVnOHVXb2FXRTdrTjNzNTVE?=
 =?utf-8?B?MFR3OE9yclByVmRHUjdiL1Q0UXAzZUVyRWdiN2FhYWw2L3NiR1ZzVzR0RnRw?=
 =?utf-8?B?aFAyWG15V1FGckxBbllka05ZQ2JXcVBLY1ZEWVRuWkxocU9lMkJ5ckZONkJk?=
 =?utf-8?B?RWNnUTY4a0FUNFN4UGtOa2dUbzlUeVNHS1Nsc1RSV25WbXorNkR5aDlIeHhx?=
 =?utf-8?B?YkpTVWczUGtNZVZqL3ZGaHlkWFl6YTRjRXYrUi91TVJyblhoMXVuWFNucGRO?=
 =?utf-8?B?S0lLY1RKbzdMS3hBNERFZ1B0eVhkc2JjQ3Y5U2RkWDJwbnZpb0VLK2t2UVhJ?=
 =?utf-8?B?YWwxWGFCYlp5TEZkL2haL0s1N2dxTHAvaDl2YWF4NVd3bVRPa29mSFF6OTlW?=
 =?utf-8?B?T0s2MUo2a1Y3MFdTakx6SnRRVnVvdEM0cDRaa0RXZTdzNlIweFdWZ01tcDFP?=
 =?utf-8?B?SjJlSzl3L0s5UGloN1o3QWVTbTBibmFzM2Z5L1V4T1NSbHNyeU9YRTN4WkQy?=
 =?utf-8?B?MVQ1QTJGdVI3SHFNVHg3TERnNjFBeVI4VEloWXRQWWgwdDlKSWpqYXJGL0wv?=
 =?utf-8?B?WGRqYjhKVjJyQ2ZnUC9rNGsxUjZXRlF1bCtSa1lQR05OZnV4S29vK0J6bDg0?=
 =?utf-8?B?azVNbkZWaU9RRW1mbTJmWDR2Z29nc2V5ZThuQnJ1RGRSQ3oyUGlobjZlSXdH?=
 =?utf-8?B?a0l0aVlZVExqT0FTWWZjbzJXNWRJdG13QVltQzZiWldQVVV4TkJKMUk2a1Nr?=
 =?utf-8?B?cytSSWVpb0l0NUprbURGTFlsb3J3WFNsQjFxN1NtcUxHZnk1MXl0Q01rMnVV?=
 =?utf-8?B?amFkVXhBMjF4VC9LOFRDRmdzVXZIVFBhNU5SWEduV0tPNDZmQTNqNzBWWHo2?=
 =?utf-8?B?MFdyQ3p5eURZNGhKTEFySXFmeHFRL3Rualp3SVM3bCs2eTRubzNQWDlRTFlj?=
 =?utf-8?B?dHAxOVFSczlBWmpaZ1ZCcTI1Y242WUNadENteWplMWFZclJ1eFBYdGhscWd0?=
 =?utf-8?B?U25BVzBtSzlHa3pjdk9YM3Z3d3BJUzdRelFEZys5VjQ4T04xeHNXU01DSWVZ?=
 =?utf-8?B?V3FCRjNQZUphQllnQjNuc21ZUE5Nam91SlVWcjByMUZlWWUwcXhtQWt2dE9U?=
 =?utf-8?Q?Wq8lErx8lYoVSVhwsEOxaVo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U3lreE1qdUNReG9wSUNEMzR3bnNaZmRMMEN4TzJ0V0lSZ2NPZy96VzJNZnRQ?=
 =?utf-8?B?RlpSWk5WOWExYUpyb3RGMFNnNXI1NHIxRjNXVU5KTnFoM3VpMU13M29PdTdQ?=
 =?utf-8?B?cnRNVTVoZmNNVkRmSGJzUDZvdUNEWUZ1V1l4Vk1uZXB2YkE1cUVXdUtZRHEz?=
 =?utf-8?B?bmlCZTluNXhIR2tnblpXbmQvZ045bGQzS1VMaEc5Wkt1WFppNGlvK0U5Wlpx?=
 =?utf-8?B?OFNPQUdDUzJhbkFKRFVqQmR1ZUhoNUlYM2c5R2dHZ3g1TWMrTHRUM3Ezd054?=
 =?utf-8?B?cm1HczBxMUxtUnZEZjhQSXdYT201OGNzU3cxSVQ2cmU1bW1oWS9DMDhZQ0hi?=
 =?utf-8?B?WHVLcXJIS2RLVDd5YnVsai9WOUV0cXFHRzJlV1l0SUVQZlpDZUJWV1cvTjNV?=
 =?utf-8?B?bU5YOVh0MjJiQzk2ZVVLMjROT0xzSWdIa0VacVo2VEVxT0lOMWdaN1crNEVn?=
 =?utf-8?B?Um9JVGFEdldWSXlWWllFc0VET0hWLzhhNi9aRzBGRGZidHBUNjVpNjVEQXRj?=
 =?utf-8?B?Q2dDMUVDS0tNM2RBY2ZzS0pvWHNoMFljZTNXS09KemoxbzYveCtSRWpJb01X?=
 =?utf-8?B?dTF2VWpnSHBZYUs3cURTZVlCaG9xYTdiSzYvZ1dHNUNZckNRcWtzR3JoNzkr?=
 =?utf-8?B?NzVnYnRyVlp6QmhjR2o4ODhPam9iV1FpSTU3aitSQTJleGZNVnA3SmNVdXNo?=
 =?utf-8?B?cXdSRytvOWZrejJ5cmxZUUxtWVBFVHdETkg3U0JzM1hRSmo3YndzbHNTcTF5?=
 =?utf-8?B?MmlmOHhXNEtvb1ZRMUo4QTd6Wkp5N1lmWlV0amNyZHcza3RoUlpwckVVZTYv?=
 =?utf-8?B?U0hLNzRTUjc5cEZ0Z2pvUkxBeGVuaWFXbzVwci9qNlNYTjVWYldISUpwRkRO?=
 =?utf-8?B?bnQvVjR1YlRKN1JJYk43MVU2Ri9VNXVYSG50cDdnWUowRHdBVWZ1NXFGOGRz?=
 =?utf-8?B?TzlyZnRjVFZhZFRqN1c2TkVySWVGMUJVYnZRYzYyay81a2YzMnd0L1ROWVAr?=
 =?utf-8?B?Ynk0TlFUNm5lakF1RnNWL0kyTndhQW1UOThUS2traWZWK3hpZ2xCZWltR2R4?=
 =?utf-8?B?UlU3cnFlMmhMQmJhSEN6bWIyU1Bkb2w0OHJ4Uy8rYko4VU5PVFFNZ0xwV2Fn?=
 =?utf-8?B?cFNkZmMvaTVacW40R2l0RmoxQ0xJTzVhYzZxdUpWalFvZ3krZHFFc09pNkpS?=
 =?utf-8?B?M0ZqbGJ5ZFpGU0h6SXBqTWVZUHJnalNMeGpGdStiY1JjeHBPbzZQc1N4a05t?=
 =?utf-8?B?dHBFM1lTRlBqTkRGNE1WeTV6bGpLZ1VlL0VUZ1lqRXlLaExsRmlQeTQxa0lG?=
 =?utf-8?B?UTduNTZacmFXdnlzKzd0RUcwejJ2M0V6VzFYaEFxMEVkNWFielF6RitaUVdo?=
 =?utf-8?B?YlFWVDRXYlh1akllR2crWWZleVNiaU1raHN5VHQ1dE9Wb0UrdUpEWitPbjJZ?=
 =?utf-8?B?cVIxenJ6OXdpakxlRXA4ZWxDNU9JZDZoVERGNzh0OTVleE42WjY2ME5lWmt3?=
 =?utf-8?B?Smt2QUsvSTRUT3YyZzVwbDlMNUE0NTFVbTlrMlg5MXRPTFZWZW54RG5SSVA4?=
 =?utf-8?Q?d70nx7BFTTUmrNp8oxMRSFMx4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d086b3f4-0639-4e06-67e2-08db4014a831
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 13:56:07.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mwblCyh1nJ2ecwWgr4ELsR8ttra1iTOOT9X6YQwPfNZXyFlbZ8xhJ6EyX1JYzzJ7QjayOo09Md2trEY8Vf58uW1LTg/tmQwIqoy4IGYtIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_10,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180121
X-Proofpoint-ORIG-GUID: BGMqpPJmvT-Ea8R-Im-1hMhyUjQUNTTQ
X-Proofpoint-GUID: BGMqpPJmvT-Ea8R-Im-1hMhyUjQUNTTQ
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/23 18:58, Baoquan He wrote:
> On 04/06/23 at 11:10am, Eric DeVolder wrote:
>>
>>
>> On 4/6/23 06:04, Baoquan He wrote:
>>> On 04/04/23 at 02:03pm, Eric DeVolder wrote:
>>> ......
>>>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>>>> +{
>>>> +	struct kimage *image;
>>>> +
>>>> +	/* Obtain lock while changing crash information */
>>>> +	if (!kexec_trylock()) {
>>>> +		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/* Check kdump is not loaded */
>>>> +	if (!kexec_crash_image)
>>>> +		goto out;
>>>> +
>>>> +	image = kexec_crash_image;
>>>> +
>>>> +	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>>> +		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>>> +		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>>>> +	else
>>>> +		pr_debug("hp_action %u\n", hp_action);
>>>
>>> Seems we passed in the cpu number just for printing here. Wondering why
>>> we don't print out hot added/removed memory ranges. Is the cpu number
>>> printing necessary?
>>>
>> Baoquan,
>>
>> Ah, actually until recently it was used to track the 'offlinecpu' in this
>> function, but tglx pointed out that was un-necessary. That resulted in
>> dropping the code in this function dealing with offlinecpu, leaving this as
>> its only use in this function.
>>
>> The printing of cpu number is not necessary, but helpful; I use it for debugging.
> 
> OK, I see. I am not requesting memory range printing, just try to prove
> cpu number printing is not so justified. If it's helpful, I am OK with
> it. Let's see if other people have concern about this.
> 

I do not plan on adding the memory range printing.

>>
>> The printing of memory range is also not necessary, but in order to do that,
>> should we choose to do so, requires passing in the memory range to this
>> function. This patch series did do this early on, and by v7 I dropped it at
>> your urging (https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/).
>> At the time, I provided it since I considered this generic infrastructure,
>> but I could not defend it since x86 didn't need it. However, PPC now needs
>> this, and is now carrying this as part of PPC support of CRASH_HOTPLUG (https://lore.kernel.org/linuxppc-dev/20230312181154.278900-6-sourabhjain@linux.ibm.com/T/#u).
>>
>> If you'd rather I pickup the memory range handling again, I can do that. I
>> think I'd likely change this function to be:
>>
>>    void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>>       struct memory_notify *mhp);
>>
>> where on a CPU op the 'cpu' parameter would be valid and 'mhp' NULL, and on a memory op,
>> the 'mhp' would be valid and 'cpu' parameter invalid(0).
>>
>> I'd likely then stuff these two parameters into struct kimage so that it can
>> be utilized by arch-specific handler, if needed.
>>
>> And of course, would print out the memory range for debug purposes.
>>
>> Let me know what you think.
> 

I do not plan on adding the memory range handling; I'll let Sourabh do that as he has a use case for it.

As such, I don't see any other request for changes.

Thanks!
eric
