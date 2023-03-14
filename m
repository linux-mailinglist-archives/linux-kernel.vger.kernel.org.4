Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4998C6B9667
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCNNfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjCNNep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:34:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2CA218C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:30:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ECns4H013557;
        Tue, 14 Mar 2023 13:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vxRvw4Z84mc8mi+gLIBKbNZiMPwDsuBw5+qUZPm405o=;
 b=PBYumF3b2XrdhdH+bojRNgNrBmZ1VeutCPTz61wZ0i5hrSZ0jG3B3usUGevB/0piNtj7
 ppSyvMTZzRFPh03d5p2NpHvLAeFWo/afxfmdwGzkkJ3QXof/veOZpentTKSKTeh5jUdI
 DVuMSFeBMeIipiV0EBTP3DeCTD9ArJuSA8TmYct0rCEnHgSYIQR3P6R6F4UpT0Ul7l7K
 e6MeDSM9W1GSpt7sc/DNkcsR0HAwADtwye5ZMhqQ2mAw9zcLv7vaDX2tmGADXgeOo3Ja
 eP8fXUUaqC3McGPRYrgYnUByM5TwXTJY9H5WyRG4CAW8ZdQVx93l+Bi0Z6teEaB2fldS zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hhaebwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 13:29:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32EBvr5P015281;
        Tue, 14 Mar 2023 13:29:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g36myrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 13:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9BYJE8uTBuigsaUoc9inG2xMgcRSATDLdGma27WzPP4QdmH3R1z8Tn3myAnPpOR/yQ7dnkWh4x7e99my5iPu8KcYYxSxr4Y94ANejb323yhP5yQnpoF676BDVRf/xieZy5WtwFWSIjcGfEDRb/B8Z97dWGr2c9Aoe8nE+RzDT1JyRgumXE+LMpWTFrT3IgWx8X4KR98QPff+w5PpzVUfX2VLh1TNHaWCJLy3KkLR6XTX1KckVBSBcMsR3BbWUlTsgF6fT4GsSd/PRe4RKAdgFjgUCiwbCMSg8I8gAvPH8h/5g+ULO2Oxw1YNjjVO8jnLbOYdJFGgV++w0snoFe5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxRvw4Z84mc8mi+gLIBKbNZiMPwDsuBw5+qUZPm405o=;
 b=Fp3fIttGSOYdpr4oJnm0RrWzKkS8u3hppepVdhu8w02HnAUetE97pOHcEWTN3jN/KZvxZeEmVhemtSLwHJbRLJrAl1g+h0z8yZPrXzGfz1idhV4MSRQFwnXMb0t4eqDk8oDOlh1xWgNVIEQ5NJjwLtzDS0gUzoMyPrnk1WHllf6tlEpP4ah1Y75YRoG9Y9BIWMkePWS2ZZOch5dKq95AhaQG1Hol6B9IH2lqqVSW4trVaOz3hjHtM+y3fPK3Om0ky3qE77JRVSMfsjaLx3Dzpd0kCG51/B0ZOYNrLhUIoIwDMy/qlTfVhVqrQRGNfmBgiOZU4Pg5fvf6Jr5DEmB86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxRvw4Z84mc8mi+gLIBKbNZiMPwDsuBw5+qUZPm405o=;
 b=qKDaGUEQ9AjuTuWaOnQ52+RylNj1y3bOHw5Y4oQNbIVqLmteC3dwlkzULG+DeAlykQqpLKvprPamE9DYMN7XSV8q46AfwPDonwZ4Zd3ZkgyOG9WKtBikEc2XQBg5Uwj/hX+Vo6iF0NfCn582h2fuwiKLPTEU+eD0d/XLXNQv9RA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ2PR10MB7013.namprd10.prod.outlook.com (2603:10b6:a03:4c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 13:29:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 13:29:08 +0000
Message-ID: <2fd31764-b341-638a-f70e-43dc0d5b0092@oracle.com>
Date:   Tue, 14 Mar 2023 08:28:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
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
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBBPzKBTuzGZe4OC@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <ZBBPzKBTuzGZe4OC@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ2PR10MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e725955-f923-4f11-feee-08db249016d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42JFuqK4Q6u0hOyp1pTfrJtOY2iZ1t9nLAKVakoLDnuR3wxw/znYOQZwCaG6keIC256WwgrnVs3r4Sbi1y33D1Rdm4n7lcbeATLhch8LlJ0zXcRDbu/pr/02DrVwC9V8z872NPneKX6fpRLf9l7XcyTla/opm+sL8mIlCW8giMyOavLh9+Z9xmKQPSNFGDcSEmY3JCRkeWaURghA6V8CHCe94g7mknzY2CGuwPPRhPs4JHCZay77Qkk2xXriWCXENVL2ydD5ku+FCGmOeEZQY5zEjXgl//0qhTdK/k0es0gIllWfDVCHHW5VeQhHXUVENDn71WRg+yioQZphOVnpZfAa4TOIj23Pj9e9crnGG6MBIRdqagrnMO7Hue5xtNFmcXf13Qtn+iyXQP5oet0qnOPVur05+Z2sX7qLFsJle+o0paXmLW8xvRFW+fYbS9IUeyZPQV9HiPsWK8It4vwPMWnWCYikFpBT9lFWWSwsomlwLYnstOI9x67vUhFi9WDKkv2NXDmaf95TChw/FfZvO5Kd76F80xLJpAfnCL+G3KuehS6fP5iTdM/qXW8NR4XSN2zCYlIgJDDDOp3HI5IQ2brNMKXyB0gYiD8+O9ybE6KjXoqdcsUwxitC8QZr6a641F0Wgx7AwMqle/sJuIfOC3jIvuB7EUbNGxKMAD8WBlJpyyWobHr973NNcO+e8bh7wotetGXwf6o/J/ZeVtG3SiK8GL3Nupds+wRg0EO0KlsQXyM61rWMlNDPH2GW9B1X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199018)(31686004)(36756003)(7416002)(5660300002)(41300700001)(8936002)(2906002)(38100700002)(31696002)(86362001)(66556008)(6486002)(478600001)(6666004)(66476007)(8676002)(66946007)(4326008)(6916009)(107886003)(83380400001)(316002)(186003)(2616005)(6512007)(6506007)(53546011)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lYeTBWVVBEYzY0UEg4ZXluUHJ5Mm96eVdHSEtQQ1lqOXBOci9rSVhQekx3?=
 =?utf-8?B?c2Fmb1o4UHN1SVdMcE1ZOCtnZzYxcXN1Y1pYVkJWSHNPY08vcXI1UHY3VnJQ?=
 =?utf-8?B?TEI0QnJ4NG1iSnRiZW4zOGpqN09oUGQ5S0hYYUpIbVp3MzR6dVR6UEdYOFJw?=
 =?utf-8?B?aTlMdFQ3WnZnVFJlYUwwTGYzVkg2d0Y0bDUzeU02c2E2WjNLM0lOWWdDcUln?=
 =?utf-8?B?K3ZiUFFSUGVnTVVSc205T29xUjJ0SEdPV2JZMzRLSkV1Z2taa1k0Mkp2cDZ5?=
 =?utf-8?B?N2czZ2ZGZGlsN1cxcmJ5cHVMV3doQWNsdG5FRVRrdUVZMURJczQ5WGViQytT?=
 =?utf-8?B?M1FrSEdBeGZZY2RXemhKUm5kZ09GNmFaS2NpR2ZQenNFSm5mN0U3WmNlenhx?=
 =?utf-8?B?b1gyTllXZElOdmF1YlZzdE1XbCt0emRmby82NEo1ZGxxbU9uNGhxU3AvdHBu?=
 =?utf-8?B?aVFhSG1rYXhQalZISVR5MUZJV3cyRk5qODRVVWtXekpwS2xnZWNrQVo1Ni91?=
 =?utf-8?B?cmxjMzV2SGFDbTJNL1FzbmRhNXpRYU1jbFNHeGduMm5YSGNLRnEzL2l5RDVo?=
 =?utf-8?B?Q3Zqa29CSmVSL1BMUUxzRHc3R2MrVzRCd2QzbDVjelRwdXJnamhJV0pMMkhV?=
 =?utf-8?B?dEpqQjc3OGY0WXlrRlFDdHZidkVmYWo3MWlFSlRwQUx4YTJEY09yekhUWjhk?=
 =?utf-8?B?QmN0K0ZlTnE4WWRJUnZiTndOOVl4OTBLczBEQ1RuY2xQZ1Jud2JvbGowMGgy?=
 =?utf-8?B?dXNCMEhqVHpJN1Z2U2lkWUpmdGlFNXJ4L0J0QTdNLzVNdnhuN01VTUs1VGVt?=
 =?utf-8?B?TmZtZDhJQlI2VmVqaWdpQW9KQUN5R2FMSWVxc05XVWhCa2JoYlVDQTByVHd6?=
 =?utf-8?B?eW0rSkc3Z1FjL2syZEsyNW1IQWNZMEdCVHhqRU9oQVR1NlMwVCttaUdSQjln?=
 =?utf-8?B?RmJ2ek8vZExpc1ZjTWlnMkZqb1Jxei9RNDIyR2xvckh2Nkx3OTlycEtxTzZn?=
 =?utf-8?B?ZklsL3pwaEpJeXRNb3gwUDJQMU0yOVN1R0NnMFRzQkFNVXBhUkF3MjFROCtN?=
 =?utf-8?B?Z3pDRU1DUm9tTGxVM0ZZY2ZqUnAyb1ZxQnRTRXIxN3BPczQydFJNdHZxb1Zx?=
 =?utf-8?B?Vmk2VXlpZDhoUXFybVZldGRlWDFVK3lKLzhKbG5QWFI1MkZESzJOdGg5bmh4?=
 =?utf-8?B?S1FFR3V0WjJudXd1UjFOK2FueG5mSWo3YmpOaG1YSERVV1ZBRVF6dG45U3dO?=
 =?utf-8?B?RWVESWhUNzE3dmk2WWgrakFFUkpSSjVVR0Q5eitJUWIrS1J1ZzBldmFpTFk2?=
 =?utf-8?B?YzFyWktDbXlQNlBpYmtpY1E4dHZsVWdyV3NpNUtaSHVybGFPZ2VIdjEwUG5N?=
 =?utf-8?B?UkJTV1Jrb2ZYN1V1ZElBT3kxWHo0YnQyT2hUUjBISVk4YTBZMVVJOXhiZXlX?=
 =?utf-8?B?bDVuZG92bjRsZHAyemoremh5Y29JeWljMVlRTkFCWHB4V2pza294bXcyQ05x?=
 =?utf-8?B?WVljOG5JWlo5cWtlUVIrWGduMllGSWhpN3N2NDJWZ04rMjMrK3hZUVZSbUpO?=
 =?utf-8?B?Y3A5WmpKbkJXYW5FLzN0cGJYQzZsTzA2RURlRmxycEVxdmdCdU9HNlRDV1ZN?=
 =?utf-8?B?OGthUlZHaVVVWWJJQUJqdm1WZG4xSUc0YjNIYTR0dU5LeXdyY2Q5b1F1MmJI?=
 =?utf-8?B?WWJqVG5iWUp6NERjK0xoR2RiYnYzc2lDUUo4VFN6L3ZaQXVHVnJZT2RHQVg1?=
 =?utf-8?B?S3p1cE1ocU5VSjcrSDduS2RxSHJmUStyUU5FUFNUNjFaMEVYNVFhNXlkV3RQ?=
 =?utf-8?B?bTZmd1liY0xhQVExTGRLT3hBVERQYjZGN1oyWTlmUkY5TlhaKytwdlhwajIw?=
 =?utf-8?B?WFM5RC9xN2F2aWQxaWJBWWtPTFJFSm1heVhNS3NLYm82eGhKYjRlSHBUUlRR?=
 =?utf-8?B?eUd1N3B3b3RWNnVaaURTekhEZERSZkJ5Z3lhem5tcnBReFloN1FkNWw2bU5q?=
 =?utf-8?B?dnRxZ1luZ05KaWtxd2NodDdVUUNGVGlTd0ZqTWxVdzVkMDVFQUZFL1AxQlor?=
 =?utf-8?B?aUYreVVxNDBRaUw2dTJ2ajd1R2wvSmNpc3ZhTlFEYitBa3RUN3VMTHhQZmxY?=
 =?utf-8?B?YWJQOHhLbm0wZGd4anpxWmNtVTBialZoajhEVE1YUC9TdjdSUGprR0JzMFdB?=
 =?utf-8?Q?aaaS1TSgnmJ02A6frH1Tc2U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aDgxSWpiSjkxZ2VwdDB2RkV0dlpBSE8rUXhVQStZamNIQU5oWGFoWFBNVWIr?=
 =?utf-8?B?OXZWVkNsa3BUQVZHa1RrKzZsOGhSZXZrUnRTWXlnSm9meU5LekpyWTFDNnNy?=
 =?utf-8?B?cjZob1VDdEJtTzAvb1B1SlM0YU1UOXRWcEtqU1VJNDhPbjl1ajV0S3ErVzB1?=
 =?utf-8?B?RVNzUnJZMU81b0RiYUcrcUNPRmdscGNXR1NNcFNQajFLYWhNUkVYcHh0MGIr?=
 =?utf-8?B?UFRKd3NLMmpQLzNPSGgyNkdNWFErd2duVzFrR0k5ZWYrMHJtdmdvR2NKWHBV?=
 =?utf-8?B?b2x4RnFUQjlBWjdyMmdEVDdRQTIxS2lTZlRGWGgxMjd5RUVjMlhUQ2xzV09Y?=
 =?utf-8?B?L1V5TkdJalVXNmQ2S3ZEc01SbGwrVjIxR0tUeWlFMXFzNG9wRCtNT1V2dVRZ?=
 =?utf-8?B?b1NZZGRHbFRkbzg0WmpSUEVDaG1zVXlFTUpoTmZjVnYxUTJvK2czT3RIc3N6?=
 =?utf-8?B?Q0RLNXM2d2RaL05mNmNlU2VKdlh2N2YxM25NSy92RW9HWk1lSXVjZllaeWRa?=
 =?utf-8?B?Rys5TkFKdjFvTXBOejI2Rk1SZitKclc5NjFtSW00cHR2TXcxSGUxVEMwVEJl?=
 =?utf-8?B?bERLRzF6MkxWZWF6cVN4TERmSm9WVThMc2FYOTNhSytTZWVTZE9wR3Y5WDcz?=
 =?utf-8?B?SHV6YU9HMUJRenlzL2gwVDFCM0hyRWlzeXdLWnpYbjMya0dCQ1ZFaUY0bzI5?=
 =?utf-8?B?bVE0citVeE9tUFN4UlpNL3pGUURxNUpWdTVJS3lrN0FlbHB1ODVkWm5qN2V0?=
 =?utf-8?B?N0xNUitPejNzcHFkWERWM1N2WjBiVFJteUJHcG5EYnBUaGlEeVh4dXhDSElz?=
 =?utf-8?B?WEh2UFJpQ1pmNTJqMVNuV1EzaVdPZzdDV2xBc3dYVzh1MndzRWFLWjBHdWFm?=
 =?utf-8?B?TnJ3elQxL3czNHpiOGE5L0hrRGdqTDZYQnhpa0EwbXIrQTAzU25WaGtsU1FB?=
 =?utf-8?B?eVBuVnNhOXhZM1I1Y3R1OUFFeGhMaXNKUzJDOVU0NHpqYTIxcFZXaFAybmFK?=
 =?utf-8?B?NWh0amhqRkd6bHdzd0h3NTUwR2tKMFJqWnJIWmI5bHRnd2ZXQnAzVmZBd1hC?=
 =?utf-8?B?dmI4cE1wRVRld2cyT28xRUFqOTZGcFZRNmo1NHg2Rko5ZnNnVnJjTkJrclJB?=
 =?utf-8?B?L1BVc0pVNmZHVWtiZ1FDVVNVSmh5M0txVFVhYTNXTGErQWgzTGlNeDRHUVF1?=
 =?utf-8?B?N3VoTnZLYkx6K1lYMFhMTnFySW1HNG9Jc09FZkNmK0ZzNHN4SlFxUzBQM0Uz?=
 =?utf-8?B?cVl0WmJGY1FMdVpGSGQ3RW5ja050cFZHWkl3T054Z2trSi9EM2VjaHdyb0hR?=
 =?utf-8?B?a1g4ZXRpY0FrZ0lKSU5wMlFEeDZuc3dnMC9LYWN3dEd0V0VzME5KY0lhV0ZD?=
 =?utf-8?B?VjlMcnlBYUFxalU4UkVndXhtcm1QcVRDQjA4NGtIc3c2NzFTREUxR1R3bFhw?=
 =?utf-8?B?UUU3TWdtRXFjQXFvaEZMem5heFQyOUNBMjloUjZCMlZYcUNYU1ZhSzBwQVdl?=
 =?utf-8?B?K21JTlRzSjg0eE5JWGhWSHdzdDdZV3d4cExKSmd4eHFDRW13QU1yMkV0UFpV?=
 =?utf-8?Q?6/1iVPTRSZKKlhIQtPfIbWy2Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e725955-f923-4f11-feee-08db249016d3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 13:29:08.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TCpWNwhpkZGH8zMHJ0ZEMx1Qz56sAxGkOC2G+C+ha5IdwYmztDzclklXqUVJbvwReeMFlhGyeXsjgzVdaw3Ce2rRrDsKARQaetQY41VM3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140115
X-Proofpoint-GUID: iuQmFPb1UyLU_YuFXljrZ2MDB5uWoO2P
X-Proofpoint-ORIG-GUID: iuQmFPb1UyLU_YuFXljrZ2MDB5uWoO2P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/23 05:43, Baoquan He wrote:
> On 03/06/23 at 11:22am, Eric DeVolder wrote:
> ......
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "crash hp: " fmt
>> +/*
>> + * To accurately reflect hot un/plug changes of cpu and memory resources
>> + * (including onling and offlining of those resources), the elfcorehdr
>> + * (which is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories.
>> + *
>> + * In order to make changes to elfcorehdr, two conditions are needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources; the elfcorehdr memory size
>> + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + */
>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (kexec_trylock()) {
>> +
>> +		/* Check kdump is loaded */
>> +		if (kexec_crash_image) {
> 
> If the above check failed, I would directly return or jump out becuase
> one indentation can be reduced.

Baoquan, ok, I'll change that in next version.

> 
>> +			struct kimage *image = kexec_crash_image;
>> +
>> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>> +			else
>> +				pr_debug("hp_action %u\n", hp_action);
>> +
>> +			/*
>> +			 * When the struct kimage is allocated, the elfcorehdr_index
>> +			 * is set to -1. Find the segment containing the elfcorehdr,
>> +			 * if not already found. This works for both the kexec_load
>> +			 * and kexec_file_load paths.
>> +			 */
>> +			if (image->elfcorehdr_index < 0) {
>> +				unsigned long mem;
>> +				unsigned char *ptr;
>> +				unsigned int n;
>> +
>> +				for (n = 0; n < image->nr_segments; n++) {
>> +					mem = image->segment[n].mem;
>> +					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>> +					if (ptr) {
>> +						/* The segment containing elfcorehdr */
>> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +							image->elfcorehdr_index = (int)n;
>> +						}
>> +						kunmap_local(ptr);
>> +					}
>> +				}
>> +			}
>> +
>> +			if (image->elfcorehdr_index < 0) {
>> +				pr_err("unable to locate elfcorehdr segment");
>> +				goto out;
>> +			}
>> +
>> +			/* Needed in order for the segments to be updated */
>> +			arch_kexec_unprotect_crashkres();
>> +
>> +			/* Differentiate between normal load and hotplug update */
>> +			image->hp_action = hp_action;
>> +
>> +			/* Now invoke arch-specific update handler */
>> +			arch_crash_handle_hotplug_event(image);
>> +
>> +			/* No longer handling a hotplug event */
>> +			image->hp_action = KEXEC_CRASH_HP_NONE;
>> +			image->elfcorehdr_updated = true;
>> +
>> +			/* Change back to read-only */
>> +			arch_kexec_protect_crashkres();
>> +		}
>> +
>> +out:
>> +		/* Release lock now that update complete */
>> +		kexec_unlock();
>> +	}
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
>> +			KEXEC_CRASH_HP_INVALID_CPU);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
>> +			KEXEC_CRASH_HP_INVALID_CPU);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +
> 
> Because for_each_possible_cpu() is taken in
> crash_prepare_elf64_headers(), x86 doesn't need to respond to cpu
> hotplug or doesn't do anything with this patchset. This cpu part in
> infrastructure is only for the later powerpc usage, right?

That is true, yes.

> 
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		register_memory_notifier(&crash_memhp_nb);
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
>> +		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
>> +			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
>> +	}
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index 969e8f52f7da..f2f9d41ce5df 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -276,6 +276,11 @@ struct kimage *do_kimage_alloc_init(void)
>>   	/* Initialize the list of unusable pages */
>>   	INIT_LIST_HEAD(&image->unusable_pages);
>>   
>> +#ifdef CONFIG_CRASH_HOTPLUG
>> +    image->elfcorehdr_index = -1;
>> +    image->elfcorehdr_updated = false;
>> +#endif
>> +
>>   	return image;
>>   }
>>   
>> -- 
>> 2.31.1
>>
> 
