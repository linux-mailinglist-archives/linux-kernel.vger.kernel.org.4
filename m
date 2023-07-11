Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA074E913
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGKI2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjGKI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:28:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFF170B;
        Tue, 11 Jul 2023 01:27:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AJtPvj005688;
        Tue, 11 Jul 2023 08:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9yVTEEvTvJRvi0MbjAVaZ0aBLgfjTE2BBxqbGtMICoI=;
 b=yN19p0d8rqPmH17BAJPRCQZ5YfjGNiE6Ap6rKl0WVEmqx1X9JCYFVLpShVhMdkiLlDlT
 M9nNOF4f5dnJ7Ja/1fLSld25IT4iCfXbZ+UrorviN86MiofyAs4/jYEs+GPoHqD+jNOo
 UJcMA+EexlzxCfyfbwTMHf1nsgqMySPY7irwFFGwLGLPfI+nmM5YdKY64BQXEKEkEkeo
 H8Ep/rIfyDeWH8Afg+CHuxxhXee4UBGG2NXniOn2oCTvENma4IGaerzwT7BpgwLSciEi
 W81xR62X2V4pJAjdDBB4ltS5QIy1cLgL+V1Ip8DhYPAm5Blc22d7UGlcEcIOz02mH/bJ kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrjmh9ugh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 08:26:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36B7rRIM022470;
        Tue, 11 Jul 2023 08:26:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx851shr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 08:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKOpn4K1alCt3dqZNVzreORCJN06c9OD960oKQRltNnCZe0UrucPPMAq2O1b5iqPOZfgHSFsGr9bZWIszknTXTiGxbIxPhkjNbE+rB/rBRJ5LNV5FmvbaPQdkbhGqDBe59x2QaLjOaFbh8NWER2lqXPSgcMaA35ScTEUT1RoM7vN/N02akyTRb63kd9N50VSJJTqSZcv5LYGjUnBUiqyYPi3poTpPNbXsBOsLZpbDAj/a3CF7UroMiobjiITywKzofY08PZi2NRxUIyOaH4eU37Xlal6ceiDp7LiDsdDWMk6wW0Z3Amdh1aAWR1LrMVIL7Hd9nUZDz76dThptsz8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yVTEEvTvJRvi0MbjAVaZ0aBLgfjTE2BBxqbGtMICoI=;
 b=JKKLJPrKzvgsGy/c2eb/U9bN60haJ3RM+89wA6ZLCFIhp6i4v8AFfxd77BAU3M2x8dCrbBxm0jUGoyv+F4UuwOB22e2zUySZoaKT0ppqfnsC7bcC0pPtdt7gjwmbd41wMw+v+0zErGH+li25d+WQ+vjXvKKwL9VZHAPeqm+fVRgCxdV6m9/83fVV+MZb89oLeZq0563dG8JrF0Fvw/WJEbIp8/h6QFcPvbxv6qZFA7eUVr3EEnIH5F7D4vLdmXN+94goPVHdTqurIJ7olwrii+qBjPf+iY7aN0bih87SQrVk6qRIXHk7Wtz0g/24q5To9KbEmN4bAeisOWRKnD2YTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yVTEEvTvJRvi0MbjAVaZ0aBLgfjTE2BBxqbGtMICoI=;
 b=a+ZUCusfeya25p+uUEyODXEhzYCrBSKzYpLTIeT0+YeCBcPHXZ1MncVkEOP6BBAWB1eDCgs2CJAUnBNu28ixu8W+6yprCeQ/VzEDWj6ndSduzSat23u/0w+k6Tbo7dOvsZCfIyn+E4deD5AD1vJIYewk+jIjcsqtDH22Gr7LnbM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4185.namprd10.prod.outlook.com (2603:10b6:5:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 08:26:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:26:35 +0000
Message-ID: <182675ca-0905-0ed2-de94-0f7d4a256082@oracle.com>
Date:   Tue, 11 Jul 2023 09:26:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/3] perf list: Remove duplicate PMUs
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711055859.1242497-1-irogers@google.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230711055859.1242497-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f504caa-4ce1-4037-51b2-08db81e88a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RakJru6/OWV5XFtZI4YH67Q8KxLy7LtgBip4SO4GryEIpRTpT+DZAyjOLomGg7uYO29WsVMzDRv72dWrIl+HRor4Mwl3Dej6dBjVgUJxGkeijNlvJ3+eV4hxqCb066ufiUuspFsZu20RViRlzozRcDhCg2FjqKa7Bc4JrORfIzU8ayjrjjo1KQCVlkcAyfbl+X3ayVnF4lSgC9ep5Pi0x452PwckTgu6aSi044rPzWoJRASTAGytRScxFcn4YO0JonBqF+Q8kBD3LibpiKgfvEDy/N7lhv87t47aSzuL3uBXjU9HvWNUuj3POgJX+hiEeeUXSirIv0QMx4eva8Vh1cpK34AFlJLMSb6FCLAMLu0jmCd77cplpcD5BE39i2IURGla3dtugHJabg5Wc/42H5IEf5UHWSCyMrcB9kI3cZi6AHQFHym9kRRrLjur+APzI3LjJdlbg9MggDA7rVpISehIXuuCodhPKX/REh7dP9MNICcsXfsFHugr296fGZvk2INAay78jiOKjcXx8OyDFB/aelNTlFFEDlNZxukBln/ONhBRxcuyR8oOYjyFE/Nw4Aal2xdSqoTf0T3aIKci1KEfqjJP0TlVzXeRRM3DAYG7mmcV5ouS2dNUQMkPQzYop77v3JZyaqZ62xaFT2An1SWWiNXgbMC7Q0iLmyuve8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199021)(6486002)(6666004)(478600001)(83380400001)(26005)(2616005)(6506007)(186003)(36756003)(53546011)(6512007)(36916002)(316002)(2906002)(41300700001)(38100700002)(921005)(66476007)(66946007)(66556008)(86362001)(7416002)(31696002)(8936002)(8676002)(31686004)(5660300002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDB4K2t5Ym45L1pWS256T3FRRjVLeTFUVWt1SnBLNU5oOTN4emhsUVhwYzJj?=
 =?utf-8?B?SlZic1pnRlZUVmZJMnNLZmdNY0xJc3ZUQlVYSDdUaWdEalhSYXJ4ekM0Tjhl?=
 =?utf-8?B?OU1BQ1k4NzdGNnhndjFoUmpqZkxsemc1bDNIcm1tb1F2dThqRmxsZXB6MHFP?=
 =?utf-8?B?OHNSbVpxMmVZdGxUdExWTlgreWdaWVVIZCtHczEra1lHMXlQREM5eFNaM244?=
 =?utf-8?B?bXF4TTNLQkxTeWNvT3V6TUFkTkJka2NzQ3VLWCtQMzVDUUdzclVvVTF1dWRO?=
 =?utf-8?B?dFkvTFpCRytGUDZZOHNuWU9zbDhieUpiVmNaM2RtZVJtZ2VKWVVjbm9QYjc4?=
 =?utf-8?B?a2NiOGh6MmZSSzBIWGZiT2RmZjNXcnZpa2djcjdpN2YxdzRwbGorb1ZRbGF6?=
 =?utf-8?B?a2NmclRwUmxxK0EvMEswUEJ5SjNCK3lFa0ROUzFHd0p4aFpKK2hEMVB2MDV4?=
 =?utf-8?B?THhMZ1EvclZ2aEg5eW1ERnJnSFhieDRTUTY2cGtSRHRJQVZBb1haSVhjSXBL?=
 =?utf-8?B?K2E4ZVdSTkgvZ3E0OWwwMk5BdUR3TkJ6cDJteVhpMlNnbXZkc2VmTk5GclFZ?=
 =?utf-8?B?UGZRSjJJUHJJSVpkd1p2T0FqZkFSWGkrbmRSMnNVcXRTRlZaS0dzKzl4S3NY?=
 =?utf-8?B?STQrc3JiVitrSjQ2aG9ET1pNZ1ltYmgrZkEvaTVTdW5lYXQ2Q0ptVStrcWZL?=
 =?utf-8?B?K0NraEd4MElJb21TS3E3WlJkYmxPUFNzUGF0WVBIVWg1cGlrdEFMeVp1cWho?=
 =?utf-8?B?NnE5L3R3ZUNYLzlVQWlqUnNBRGZORld2VmhLbXg4bHJmdHNYeVlzcDRrdVY4?=
 =?utf-8?B?R3VZRHduQ0xmcjd0cnNCeEhrcTB3SlB6VGJ1QjFaT0Z2SlhqUVRFeG42RkFm?=
 =?utf-8?B?MXJVOE41c0hoVGhBUSs3MEpRWks5dkg3aDJkYmRKV1NHeUwzMXRDeDkvcUdX?=
 =?utf-8?B?NERGNG1icTN5c2hRUzdnc2prSGtxNkk2T3JxY0JiWVVVeGNEK3I2MGNCbWxQ?=
 =?utf-8?B?SkV0Qk9LWkRQemF6WUltVkRWNVRhcGdVK1RaNWhBdE4wbGdHZ1NTdFdTRElo?=
 =?utf-8?B?UGxxVUFGZlp4bUsrbkVneU1Ub281dlJFRUhnWW5veXVNKzU0TTk1bnJRUnJh?=
 =?utf-8?B?eW4wRHI3RmlldHE0R0dsMjYyOG5xbmlkai9jM25oR0p2aUZiMW56SDlPeG5S?=
 =?utf-8?B?ZHJxL3dXVjd5bi9WODBiTFJmbkNGUlNDNkhJenNzbmszYUllanJaKzNzR1Fz?=
 =?utf-8?B?ZDZqY1VZNjV1dGtubjJnWGNUY0JDR2Y1T1gvL3BWOTlvelhIbm52RzVDSi8x?=
 =?utf-8?B?MVRtMWswT3RFb3BucllSKy9kKzZqNkI1UnZMNVhrT0dydTZQelBmUW91RHN1?=
 =?utf-8?B?Mzc4QXlodmZOaEFWWnVMRktZSGl1RFl0dE1tdllkTEg3cnJjYkVkd2lLbHd0?=
 =?utf-8?B?cEVGckxvbkthTmZUa0NlNEF2eEtsRStMSlZPbGt2S2tLbk5taW5XcDFZcTUx?=
 =?utf-8?B?TWJueUlka3U4SWlXRXVnM3o4b2VsT2Y2VVBwVDVkRlZJL21FTlBSNEx4TEpH?=
 =?utf-8?B?am1nRWxveEp1U3htVFB0Q2tsRDVJaHhqSlRXd3dQd2hSMEltV2RJdnh5c0Fa?=
 =?utf-8?B?WjJRVE5jNitlb3lkb3J6bVZyWnEvN2pyYnhDdEtERC9obFFjTUZjODN5OWtI?=
 =?utf-8?B?TkxNeVhXTUZGY1Ivb0VrWUZyNlVoeUVUM0ZUM294K29LQ1pLVkZJWVJFMGJV?=
 =?utf-8?B?cWkwdEh0c3N1VGZJUlRibytlNklHYmVPdk10cHVNOVBsd0hxbHJWbGU0R2kw?=
 =?utf-8?B?cFZTSDA3VzExQzNkaklFcUN3VUE0NThINmxWQnBoNUJaYXVuVDZCcXVzdjNi?=
 =?utf-8?B?ZUJMT3VwbzZ6NTd4YmJSaUx6WDBhUzk1NWZJQzJ1R1NVSkYra2paeG9ESjN4?=
 =?utf-8?B?VFZ2QVNMQkFROWpBeTE4RVNnOEIrWmJ3bTE0WGpDYzl4ZUxySEVZa2J4aERx?=
 =?utf-8?B?UXovOHJGTGIvY01vdDExYTNOU05DVWdkRzhFTVFjTWt4U2JjemRuL242cGVv?=
 =?utf-8?B?c3p0Q0xnOExUOFI5dmlxeE9uTzdSTXI0L2tDZ0w2VDlDTkhlQ01RbzRaU3hv?=
 =?utf-8?Q?zrdyO9CMSEtZbZVXzhsr6u4gk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a2JTbldBQU42UnlxanhHdGpwM0dvb1dpTmZNaSs0M2lieHl0RDFtLzByYzk2?=
 =?utf-8?B?QnhlZ1kvQmcwTVgxb01ydzk3dWh4NHgrelZ4VFFnend6aHVGQXY3bjVsYndC?=
 =?utf-8?B?YjBnb2tHd2JJZVBWcW9vUlM3OHNPZjlNblYwelZUaWVFdXF1Mzc1MmI0eTBC?=
 =?utf-8?B?K2pwS0tpTnBNZDk4cVJrYkdGV010d1RVTWpZRU5sN054Vk9XM3FSVmxjbmRo?=
 =?utf-8?B?TlB4WVNrRVR5T0hkRnlQTmI1TVNYNDNjbGpMOWdQdG80Q1BqclpwSGJXMW5k?=
 =?utf-8?B?NlZsWmZZbDJqT1dqMENsNEp4MXR4eFFyN0JZUjE0aE5GdG9nVTduZ2VUMUhy?=
 =?utf-8?B?YVVyZldXQ3R3Lyt5aUFxS0hvM1Q2aTBFYUhXalk5VUNabE1tZEMwa0wxN3Br?=
 =?utf-8?B?b3V2cWE4SEp6VW82eFdxbFlPY2FNVDRlNnZ5SmxFV0k0Z2pNQWsxUlFUdEJp?=
 =?utf-8?B?cTk2cEo0MGlYZXQ3TmMvVHFzQnY4eHB1U2Jua09UMWplanVna2VkRTBOMTZJ?=
 =?utf-8?B?RTg1bExZV1lhM3RXMUhsNW84VHI1THBUejBEVk1OeVlnRVRyYVB2aG9LMTJZ?=
 =?utf-8?B?WCtyMmNxRUhIc25PaWlYcGx4V1ozY2NqYjNxWFVhY0laZ0hYSkdnQjlvTUtB?=
 =?utf-8?B?YnJ5UFhVb2h3Tjk4VUFwdzNWbysyL24wQUdvdFFCOXhhUGMzUGp6andPc2M1?=
 =?utf-8?B?UEI5SXBYNEFNZkNJUUYxOG5Pck84dW9XZDR5cWVIMjNhMzVtNmdaR3d4alc4?=
 =?utf-8?B?YnBHYTZUZWNqa09Od0lvcU9jUnYwV3RHeTV5RmpEOE50V0sySm9VN3VZZXlw?=
 =?utf-8?B?L2tvQTEvYXRRZ3JMa0I5cWlZNFk1M00zR25BVE12cGVkeU9ia1hCNmFIUUlF?=
 =?utf-8?B?elluUkozeEU2Y3JYZlkyWnFNVDIzZDBTSHpoa2xHZ1k5OHBaZWFra1BJUFFk?=
 =?utf-8?B?SThFZW5UY2JpQmVHMEpROXhZakJiWFhJbGdVQ1hRNm50bm1COStFb2g3K3VL?=
 =?utf-8?B?Rm1PSmdCL2hybU5WYnREU0ZIdW5UUUhQOVY2M1FiaHYrM1ZmTGEvTEtIakRs?=
 =?utf-8?B?dmloSjdaSlphNURNK3lWcFlWMG9vK2ZrR040Rm9DRnBOdncyamhGKzdtY2hL?=
 =?utf-8?B?Tjhkekg3VVN3bWorWGNlekhJNTlLT3pLZ09VRkx1OXhCMU50T25CUFNmazNJ?=
 =?utf-8?B?emZzR1dpWC9IaUp4MkFDSXNwV3BOdmtIYy90ZGdUNEdXV3R4RXFUamVXZy9W?=
 =?utf-8?B?eUh0MlNXSXVTVVREL0VmWlFnQ1dua2xPdzA5WlY0bGZoTnI4LzE2dDBlVWV6?=
 =?utf-8?Q?8MN3RpG9w8K825rH8HWeC5I/VorVaQIG9P?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f504caa-4ce1-4037-51b2-08db81e88a0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 08:26:35.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exoSjqGLF4BUKQxpAwVxoUgYOmeLUYLfkwphEFUPbdk6UnSF9311QAY2AMKVr6J5wT/+C7aerywg/kJFiR/ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110074
X-Proofpoint-ORIG-GUID: cxuPmgYqA2SFdvO-SvVrmL0NW5Uzoe7v
X-Proofpoint-GUID: cxuPmgYqA2SFdvO-SvVrmL0NW5Uzoe7v
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 06:58, Ian Rogers wrote:
> When there are multiple PMUs differing by ordered suffixes only
> display one. This avoids repeated listing of events, in particular
> when there are 10s of uncore PMUs. This also helps speed the all PMU
> event tests.
> 
> Before:
> ```
> $ perf list
> ...
>    uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>    uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>    uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>    uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>    uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>    uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> ```
> 
> After:
> ```
> $ perf list
> ...
>    uncore_imc_free_running/data_read/                 [Kernel PMU event]
>    uncore_imc_free_running/data_total/                [Kernel PMU event]
>    uncore_imc_free_running/data_write/                [Kernel PMU event]

So with this change can we run something like:

perf stat -e uncore_imc_free_running/data_read/

?

If so, does that match all PMUs whose name beings with 
"uncore_imc_free_running" (and give aggregate result for those PMUs)?

Thanks,
John

> ```
> 
> The PMUs are sorted by name then suffix as a part of this change.
> 
> Ian Rogers (3):
>    perf pmus: Sort pmus by name then suffix
>    perf pmus: Add scan that ignores duplicates, use for perf list
>    perf pmus: Don't print PMU suffix in list
> 
>   tools/perf/util/pmus.c | 107 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 102 insertions(+), 5 deletions(-)
> 

