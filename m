Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3998622B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKIMRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiKIMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:17:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7EE15A23
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:17:11 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9CEnJw005795;
        Wed, 9 Nov 2022 12:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nzkxn2W77qbhcuUhvvMTYr2c6ix0cRjnSE6X692H+YU=;
 b=l4QZOqdlCMVpB8wAAOmv7IIdslnrvdZjlJiATDuTJG3mLT4ih/sqKUfsyA/2DIsaairy
 afcSIGgUKbbc5DcMF5Kxo3VxupdSOehA7WLeWpLpCeLxT9ZBkxN0uJC0oF85pD9H4XBW
 DomrLrqDHVuiFbamQeAnvk4DYw3ny4pBR0XruLuEBfD14hfsPGp0v90+htEvT1OA3ap3
 Negwa2+KLj4c8TOuTLMMx3RCB3KBbDadj8ccxG8hXNMiPxuKIGzhl1rmhLyU4oz03RC+
 tdGgJMhPg+LuaXQDoI0NeHcXz2YXi8vNm1X5yeeZC57O2LXim9O7UnYh9XmJmxAjkdp4 Ww== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kratp05px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 12:16:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9AI3kr036371;
        Wed, 9 Nov 2022 12:16:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcyq6b85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 12:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdne199FEvp/ePm73Ckm9BgOpDuWQ7Dq1PEXXdSXq9C/+aREQ0DDAp5AJEScm4WacLDb89kvcY2PFgrfRVVA5oMRK0aBQ2DxKAdwBSJq3yc/ZELUuRj/lVHWxDISPeEBXKG4wCPLOamDkmDwl9yLIE1IwZ19tGd4O08UpVtMIBHyVn+AhD34DR3D1axKyLDsDjrfkiebKvQ1qNf52Y88Y2V2HchVh36Oo7kDD2o+YzR/jg98+3QshIfp1t0qdquG4NDWn4XX94A6yGKRdTw7bdoBhZQvfdQBOCAprbdCs2RCB3y6TWFkmXYkM7+MJmZkCMs1nAVTfVo1xGIV6qEFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzkxn2W77qbhcuUhvvMTYr2c6ix0cRjnSE6X692H+YU=;
 b=NECN082QHrMkeTW1W350YyOosTZDNIAn/PEKhtzzyEhbNsx8OrhLod4YJx9mnyUTtr81BrTiydVL4/XLKTnOE996yarJQPAwGmR2aTlnCcHBKYnNJBNiluxO99hmPWlsdaLmZSPc7DoDonYzklSQGOjwqWlSX1SmPFIg0ozH/+BDzmu0A4dRaZu6bsF+FsNNsw22OfuXI9NrF/vi6hfqWAsV7n/XhdUv2NNy0i1uVIbvVh8Jbzd4cUYmoGV4CZl3sbB7d9m4W36ls3+eFju+Le1ufKs+KE3YiN1N4h1F1fFaFJTSJUTSMDDIHZibW+vgeizULt8hOCyV9jrPgdKgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzkxn2W77qbhcuUhvvMTYr2c6ix0cRjnSE6X692H+YU=;
 b=fOCpR2ugBzYNCDjis8z476CUE9RdDTfOVx/D5DurQvVEwYc+rtN2L12x9mt20SzHmzx1Gu+vlD8+5c87QLb6ei1PxO6aRxaG1bFpB6DID8SOp8mdFJx4Bk2G+JE7s0M10OeqH5LOtR9me6FQ8AsdQuiNx+YRO6hIQ7nEFQxSO/w=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB5360.namprd10.prod.outlook.com (2603:10b6:5:3a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 12:16:19 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::8068:ac8:217c:a891]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::8068:ac8:217c:a891%7]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 12:16:19 +0000
Message-ID: <76cbad17-ab5e-3dd9-cf94-df2b26748167@oracle.com>
Date:   Wed, 9 Nov 2022 17:46:06 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [RFC] iommu/vt-d: set default value of INTEL_IOMMU_FLOPPY_WA to n
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     konrad.wilk@oracle.com, harshit.m.mogalapalli@gmail.com,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Darren Kenny <darren.kenny@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20221108125855.2984751-1-harshit.m.mogalapalli@oracle.com>
 <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <dc463b3e-2875-8aac-aca1-edacb90e5650@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0143.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB5360:EE_
X-MS-Office365-Filtering-Correlation-Id: 98905e82-e08e-40a8-9354-08dac24c3545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3PEYrRhiyYjbKU3tntxhx+yp9+DKrcu10om+q0GuvgNELqRd1J6yAiQLofnNZ46veLwV5vbZ/2NfI+BNivuAoy0fBQaYCdzkBEq9mPAORr/onn9/x9Oe+KEebDLQN2NT9RJWzULvz9BiRXTWYzTY5bQgqJ2Sz0Xme6wJ/zZZOKxd1uRlvy7tcIa/wm2W8tdvVh3xYdufMDx9d8X40U265SqqjkauKTz39Z/vZAx1wh7+dbyiMGaOxuefxrhFQhiGSIhufMjZ3+PvYBbhvtgxtbaHWxcWKarrIUSubdAvC7LfVdSaclK9B90R6bsvxXXv2sYjGv2/EiW+/B3ldDS655fLbPQfjm1Jfh51XRdPgkVMegCJnSYuEU+wKB7mXLcn+53jluno02luoDB5tzACc21VOYgbqSgy7nODAJe0HjemOFwPrGmkJpvOn8Aohcgc3kJ9dLFg4RfszySNfta1gNUYv1hPa/HX6gfbFGtqQwNktKazRAsvGBXowpk0h52UbA8AiqMbXomwodZoXfRJewqYPclTXVnTkmbjbEBWklPcH9h9wYX4KAKmyKbZU4n663iCciqq4yzavi7XiYmVDVwnkQzavvomZxkT8H27ia32DpVDG9BD0ovNlz4sQeH6CCDpcJ6+TiDfqaEYUqHc9RmM49TpCpiULs4mggG5jvDgy2hdO/RUy7TrUmLAuU+E+aUymNV/RIEYm3e3TJdZk8hEOIFfRqEF5aBX6UOhK4JqjFPwpfEalThqQTFB2rcZPuvdBehk+lecbv4a+6RyEL+HAXQ66SvDDLKpuXbMyCx79iGnulkYG3go/Fkx/0T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(31686004)(83380400001)(2906002)(66946007)(36756003)(66556008)(8676002)(4326008)(41300700001)(66476007)(31696002)(86362001)(54906003)(6916009)(38100700002)(316002)(2616005)(26005)(6512007)(8936002)(5660300002)(186003)(107886003)(6506007)(53546011)(478600001)(6486002)(6666004)(129723003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTdzRU01Y3dZclQyNGIxQ2hDbVh2QnA0VDN1VzlGSDNWQ0tqa0l4NHdaYWhV?=
 =?utf-8?B?UnZHK0dpR1BGOTZCRmJUaWRpYmZ1M1RZdkUxMzVldGYyZkQvNU5TTHkzb09Y?=
 =?utf-8?B?d0Z2ZzkweE51S1plNWFwOXZqd2l6ZER3M29hdXhDTWlzS0paN2xsZ0hGbDUy?=
 =?utf-8?B?WG45aHhxbUI0a0o0RllpKzU0UkwvMVZKaDdnRHdOamkyNW9hM0xoS1REZlBx?=
 =?utf-8?B?LzIwR21rUkd6N1pBMm5UVHN0QVUydGRFRklDL244aFVoSkRxMDFxTGU5aENW?=
 =?utf-8?B?M2MvTFJBNnRWamZqN1Q3aGhjd2NkZldMOENlTTJ5SzFKa0kvSDBncmJaOUlP?=
 =?utf-8?B?cElDbXR0S2RLaWlMVXRJNFhuNzh4aXNDa2RTYUVuVDJtUWFOSnBtR3NoY0Ev?=
 =?utf-8?B?d3ZucnBjQ3oxOEcwaDh1ZTA3TzlYOVZ3VWkyYWE4bDBSQVdoVlFCaGh5UE53?=
 =?utf-8?B?ZlM4UXMyd3FJV1hJUkw1eDhRcy9NQ1hEbFE4R3RlTVl1cDZKc1VIL2xVSGNI?=
 =?utf-8?B?dmRYTVZibkx4RDdXZFhadEQ1eG5tYWUyTFVuL2JSbzJvNGxNb3Nad1FQbmRT?=
 =?utf-8?B?RTBrejRwWFBoVXZHcWJsSXNiUGl0R3lxM0VqNnE0dVcyWHhCbmpsL2tSUlF3?=
 =?utf-8?B?RHhkanJrYlNvU1FwT1BKc29oTjUzWXpMNGhsU1hyWlYyMkxvN2ZEbW1GeHlF?=
 =?utf-8?B?bUZEUC8zMDk1VTBZaElEbXJlTGh1elJJMnB1ZmIyNjV3cGczV3pFMFVna1VR?=
 =?utf-8?B?NDI1TFRyNk1McEViektVbC9Ga3hOM3VmNnRhNzhEbzhXbVdVNkJBdUUyaUN3?=
 =?utf-8?B?ZEg3clRHM2s4U2h0d1duK09SellNak1zMWNVaHdxNnlGcjIzMkYxOHdZZ3dZ?=
 =?utf-8?B?V1RXQnhTQ0pVbXdlVTc5TzJEbmtKc3RKYnVDWTA3a1JQeGlPUzc0T1c3WGww?=
 =?utf-8?B?SnFMVGY2Rkg2eE5XK3ZxRXJDY1ltSncvY01oaWpEeEZFL3RUWFJ5SENFTFVy?=
 =?utf-8?B?UHM1ODh0Q0dKZU5PQkVETG5GRmUwZzZnMmpQbVZzdGNOTGd4OUhFOHdVakNL?=
 =?utf-8?B?OVdpRVpqenVoMG1ya2tCbUZBM1VzNml1akVEVGJ3cGtveUQ4RnNSZlpNK0NF?=
 =?utf-8?B?OXgySG9ZT1BEWVZNZHYvNkw0elZWY1FrekZZb3dTbVl1MklWcHdGVWQ1cXBq?=
 =?utf-8?B?QXFteUoyb1A2N1N6OTh4RklQMXRrUzRCeDZvMUlKMS9ZdUs0azhmclhHYjVX?=
 =?utf-8?B?blBHd0VjM2lha2p4Z3VUYUQrS0NjT1JSU1JlQUJnYmVCTzVFQklLSnF2L2ds?=
 =?utf-8?B?eWlVeVZaUU5RWkp6YlNpS3JnVy93bXBLOUYwLzR3WDRiejdCM3lIV0tTTlR1?=
 =?utf-8?B?VGY0MWlWRE5OTDJJTDNxKzNYOFlhZWQrU3lUcDd2RXVEWTJ5SFc3bTlwTXU4?=
 =?utf-8?B?c2xTYk0yd1hyVCtta2o1U3BsTnIram94QmNsdzExWlhsdzI2dysycUh1YUFy?=
 =?utf-8?B?M0VvZTNJVE14MDRNSEZxd0ZyWW1CMHBBUTIyN3VYTERMcjZiVE9GVnU2bFlX?=
 =?utf-8?B?czhOdFpsT0FLc3pEUWFUOFhqQVk3d3FSV3NXL0o1M0cyTEZKZjFFSVZNUmF1?=
 =?utf-8?B?YnJoN0NuVURKUyt5RlBpNjdjSnd6ZDlMcEVEbUR2N3l1bVVyLzkwWW12cm1w?=
 =?utf-8?B?ZnNkUFFrcEdYMS9pTS8yK1lCV3lZcXlnclJ6T0hHMW9EaktQUHUyS2QvNVBy?=
 =?utf-8?B?eFZFUWYwNFRyQWhFVU9XaWRSbXNiYmFONUs0QVBod0MvOGRFS0ZvRVpFS3BM?=
 =?utf-8?B?OUtxRXVmVDNNMkZYbXVkbXdVbjZva3JmZXJkRHljRkhSYk5CY3hkMDEyTVJo?=
 =?utf-8?B?RlR5NUtSSlFqSjBVcjQ4YUdjV09tdnBmL0ZydUxZNjVhMWM5cWdLRERqenVG?=
 =?utf-8?B?RUNHdWZEMDk3NUxsQmh4anBYWnVXQ1RaOVdSQ0tTRDFEYlFKQmRlbm1paEp5?=
 =?utf-8?B?RnV0YzBzSUlLN1hHUXZYZWVmK082QWllMFc5ZFpCL0V0N3YyaDJuL1pOamN6?=
 =?utf-8?B?MEVtMjVoTlQrRGNOejRGZ01LZU82U09wNWNlczBhR0xPejFOLzhsbGx6U1JN?=
 =?utf-8?B?MEFmUW5EZXVnYmdVby9SM20zblMvajl1L0xaZjdGQlRSRVUySHpLcjVVa0hh?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98905e82-e08e-40a8-9354-08dac24c3545
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 12:16:19.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Hka1Ke1e2synppRYlBKfcI8u21U+Bt9ZZhCL4NFGpL5silZr2sw2kjYWs48RAu3FOt9I63empIf+Vg2kdTCwvooPfVgoTJfMF1ElnoPTC4gqwjDI4NBT8rZjaI/tz6L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_05,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090094
X-Proofpoint-GUID: cGBUo_my4fzLmzv-mpkn9hFpkr0MDs6h
X-Proofpoint-ORIG-GUID: cGBUo_my4fzLmzv-mpkn9hFpkr0MDs6h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/22 12:35 pm, Baolu Lu wrote:
> On 2022/11/8 20:58, Harshit Mogalapalli wrote:
>> It is likely that modern intel motherboard will not ship with a
>> floppy connection anymore, so let us disable it by default, as it
>> gets turned on when we do a make defconfig.
>>
>> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>>   drivers/iommu/intel/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index b7dff5092fd2..c783ae85ca9b 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -76,7 +76,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>>         option is removed in the 2.6.32 kernel.
>>   config INTEL_IOMMU_FLOPPY_WA
>> -    def_bool y
>> +    def_bool n
>>       depends on X86
>>       help
>>         Floppy disk drivers are known to bypass DMA API calls
> 
> Nobody selects or depends on this. How about removing this bool? Only
> less than 10 lines of code are impacted and are not in any performance
> path.
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index b7dff5092fd2..5e077d1c5f5d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
>         to use physical addresses for DMA, at least until this
>         option is removed in the 2.6.32 kernel.
> 
> -config INTEL_IOMMU_FLOPPY_WA
> -    def_bool y
> -    depends on X86
> -    help
> -      Floppy disk drivers are known to bypass DMA API calls
> -      thereby failing to work when IOMMU is enabled. This
> -      workaround will setup a 1:1 mapping for the first
> -      16MiB to make floppy (an ISA device) work.
> -
>   config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>       bool "Enable Intel IOMMU scalable mode by default"
>       default y
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 48cdcd0a5cf3..22801850f339 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4567,7 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
> device *device,
>       }
>       rcu_read_unlock();
> 
> -#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>       if (dev_is_pci(device)) {
>           struct pci_dev *pdev = to_pci_dev(device);
> 
> @@ -4579,7 +4578,6 @@ static void intel_iommu_get_resv_regions(struct 
> device *device,
>                   list_add_tail(&reg->list, head);
>           }
>       }
> -#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
> 
>       reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>                         IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
> 

Hi Baolu,

I have a question:
Shouldn't we remove the code between ifdef-endif statements?

I mean something like this:

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index b7dff5092fd2..5e077d1c5f5d 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -75,15 +75,6 @@ config INTEL_IOMMU_BROKEN_GFX_WA
           to use physical addresses for DMA, at least until this
           option is removed in the 2.6.32 kernel.

-config INTEL_IOMMU_FLOPPY_WA
-       def_bool y
-       depends on X86
-       help
-         Floppy disk drivers are known to bypass DMA API calls
-         thereby failing to work when IOMMU is enabled. This
-         workaround will setup a 1:1 mapping for the first
-         16MiB to make floppy (an ISA device) work.
-
  config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
         bool "Enable Intel IOMMU scalable mode by default"
         default y
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 48cdcd0a5cf3..2c416ad3204e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4567,20 +4567,6 @@ static void intel_iommu_get_resv_regions(struct 
device *device,
         }
         rcu_read_unlock();

-#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
-       if (dev_is_pci(device)) {
-               struct pci_dev *pdev = to_pci_dev(device);
-
-               if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
-                       reg = iommu_alloc_resv_region(0, 1UL << 24, prot,
-                                       IOMMU_RESV_DIRECT_RELAXABLE,
-                                       GFP_KERNEL);
-                       if (reg)
-                               list_add_tail(&reg->list, head);
-               }
-       }
-#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
-
         reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
                                       IOAPIC_RANGE_END - 
IOAPIC_RANGE_START + 1,
                                       0, IOMMU_RESV_MSI, GFP_KERNEL);

This code is introduced in Commit d850c2ee5fe2 ("iommu/vt-d: Expose ISA 
direct mapping region via iommu_get_resv_regions")

If others don't have an objection I can send a patch with the above diff.

Note: I am unsure about the code internals.

Thanks,
Harshit


> Best regards,
> baolu
