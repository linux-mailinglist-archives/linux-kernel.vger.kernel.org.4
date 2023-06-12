Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3344572CDA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjFLSQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbjFLSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:15:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A39E6B;
        Mon, 12 Jun 2023 11:15:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHjS8V014154;
        Mon, 12 Jun 2023 18:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NDywT6B40qarqdeybvgLyhEaw/94R+4a042iImpY9lo=;
 b=UV9QUe/m3lK0FYXcpZeFSeiqR73z/RL572ps6j24/Yyyu6csR8aeI/jzqD7NjoayIL/w
 oZEmiK3M1dONZWJo+5OAUGDum8tfYgQRFFdecFlu1a+r0l1n9alOz4Ixm7Kv6bRB36xY
 J7JMO3/tMgagsbluscb8zrF/BhU+0E1y9qlYsKOfuGyfXUiD1Uy9775BG9Enh47TrMbF
 jlzax1pYNj+OrWnsmj4wZz1ufM9BCpIuoyf8vBLWsy13ImkA6Sv1kqQhbfv2oO7q9AXL
 xXZ4ClN+pt6kpY1yTbzsie74CH3bG9R/2hJe7lAuG5avPdm9VHi93qFz9D/UNQYViuML Vw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqukkv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 18:15:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHqF6k016254;
        Mon, 12 Jun 2023 18:15:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm34p17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 18:15:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYEsR4M/Ho94jG13QEV8ytAV5ER0aPa1Yb0FiJJ3TqKe6z1nwJJxIszqQwyzdr3rQEV+sZFR0xldOOb/zwjOIZCzM+Pk2Rq+SdoU7VqZpF5OapRBygHKUUQkYoXA4XKwZl3DAc4anvRPcGkdUyRbwWdjxfpXoC9rJBIA7SUEWrC4AhnabFC2Q6Kbh5m5gUimDpXHsCG7znAix0BynRLloWIaSAaauFfZLB0cm9wiW7ji7qG/FbWSldOMBbm+knKs6XMPcw4lKXOJfzl8Rthnq45go3CLqBYvQxacNxEN9Yyg69Al9C1l2dJRgUbjEB5E+XRErrKKOUY3JFKbfct3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDywT6B40qarqdeybvgLyhEaw/94R+4a042iImpY9lo=;
 b=OAgj3M+MDbglvW9Efc1vulcRm0DaOv7ZdfCcwwDxojvHpzoAnHHJMRdhiG7AQQLEF+cAvOGSvSGi3P2I12Ehq8Y3QvSKcFbfzuqWuk7YoZeZKX20iYwnOqlfcUBjUzinLpZR6V9GeD8s6Kt/pejB0IqX6DOMFbn4rr0lOE9GXqYVKLB2HcYLFfkCa0kVaSgMAXaT6V+8c1nmtWYf3p3/wBsO7EEBKwJnb+8HbcdoGc4SV/vBO3aukh7Cu0+cg56CZpCj70skjd/k870wxlf9ewrdRUK0SMC7e06Zbv6cMxvFUfmjUS6nUqSg8R9fJnOFDggzHjTWFlaziKyHkDeIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDywT6B40qarqdeybvgLyhEaw/94R+4a042iImpY9lo=;
 b=s4KC6nOdMJkJFT/syET7aoa2GuS3HiYqWbRVvkzm1/nnPbI1qElMvWv5XbmFDxS8oFP4zFBfy5UBzT03LYY3yFxG8JrLoFPLcYEKBKCTnp9K9pfU44Gy3PCRFda6APN4ianAIx7NvWWiGQfslPkjK1Kwq+hgyrKam3wDEE7Gpl8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7346.namprd10.prod.outlook.com (2603:10b6:8:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 18:15:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 18:15:34 +0000
Message-ID: <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
Date:   Mon, 12 Jun 2023 19:15:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0577.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea8a573-9887-4340-b5a6-08db6b7103ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCIyPh+Tqx8c8nLTUGxU0HlfP/wapmwY2O5s4X5HH/BAGdpkVay71wv7OXROhDPxF//DCXMwtB0xNygPELEpyD5XxHGLpWFV6IVhd+FOe30w1aNLmQvjRxXOOGs4AZvizMBBjxG+RcjupR+XLRQTxlMt2o0VZZrjCop+8yjVlBPb6qm5rxHIXkGbNPxvA3IxkzbYmVRKES29of1WQyPst74ZqhTWHqr9fkRxmihR8gUlMy3zv1TAMZ03/hkJIIY/t+6DFqaaiEjI0wDftQBihYibhUygbQuaMAKO2LDcp3Y0kyznESBna8B8obgTUeSLLD2/pN2jg/3FKTgTWGa0QRAPYoPMXlpMn0RIVpYoO8rTn8fdGDYppGvU6P/mW5o0oRmUv01VUa9AnaqlNGY+zG79wKIN7/we6DRJz8bppBlFQzoDu9KT1O4res/tCLMsQrUmi0LXLrdpY/U1ZOfaAPM/PpQsbX6diXFPBhFv3PajsdxU5A7Ap/Bm3RSZOlVSv07RbJH48aMREPjRGwvjs9WKuEq/w15tK1dOL9JTzJc5LGMBvcEvTXYcjpyBlAZiNHPgQzz3BdxiPLhzHpPG39JgvGo/RKVQBaZ4X9EghSuS/gh+xCq0ga6DPuoKynY40LjMqS5QRzWhyBIqwZiAKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(6486002)(316002)(36916002)(41300700001)(31696002)(2616005)(7416002)(186003)(86362001)(26005)(6506007)(4744005)(6512007)(2906002)(38100700002)(53546011)(5660300002)(36756003)(8936002)(8676002)(66946007)(66556008)(66476007)(31686004)(478600001)(110136005)(54906003)(6666004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JnRDZIeHRqZU1vbU5KQm5UMFhSMUJZL3IwZVRXenVxSGhNc3o1Vm9tRGRC?=
 =?utf-8?B?c0FXZ0JlWUhPQzlZN0pYeVI4Z0VYMXNvVjFXNnVwWDFlVi9uTXVBb1U3ZUt3?=
 =?utf-8?B?NnMwbVZDOVhlT3lLQWtCOGhoTG5HS3BEUWR5aXRib2N6TmtscjR0NVpKaU52?=
 =?utf-8?B?L2NtQ0JEOEE3MlNSM3gxdm1PRUM3R21XY3B4dHhwbEc2YUZOWVptRkpyTFQ0?=
 =?utf-8?B?ZTdwZnFjdkVqNnpGaHhScXkzZXAzVVorSFBoRTZ4NDczenZXWldwdERLVEVU?=
 =?utf-8?B?K1lJemxzR0p1cnBUT2E0Y3FXbmZDZzUrcVhkOVZoaGFDaUxIQVpvQUE1TDV4?=
 =?utf-8?B?KzJiN0QvaEJOd2p3VTQ2cDU1eEpDWHZQR25YS0QzYWpvdUlTV3NrVWl3c2w4?=
 =?utf-8?B?SGFxN0owOEhPR0w0Qm9CM292WXpSaFhTRnlxLzBMU05mSjVxN3J4MUIvaGRz?=
 =?utf-8?B?LzJ4b1JkRnR6UlZsbkNBY0RKWk1rR2wrR0JMT2RTRldua0VCVFlrbXVKaHNZ?=
 =?utf-8?B?V0M3Q2RpZDFDczhNMjB2NmNOalFDV0M4cjBFZXZVRGpDRXJtWFFTMUtKWW9s?=
 =?utf-8?B?RXJVaHlwbldSVUMrUDVwVUpXVzZqRW0zUUZpNUZjRnRjUjBzZUs2aFk3c2tq?=
 =?utf-8?B?aWtRRXBaeHM1ZjNnckxuTDNUWnYyOEZBZlhBcllOQ21GWno0aU5ISnJvSStH?=
 =?utf-8?B?KzhycTBKc3NDejdYWm5sN0U1RUxOV0xTUTlETzFFZE1aOURFYUVRMlplalJj?=
 =?utf-8?B?ZG5BSDR6cWp1VUdJS1l2SHFaRVp3cXR1YlhGRnZsY2hiSFBiR3h1TFdra1Vw?=
 =?utf-8?B?NjB2VWRDbGdWa2kvTDRZMjVrUW16Q1V6RnRTVkNieUxkdGFRMWdDS0toamRo?=
 =?utf-8?B?MlJrenJKYjg4U3QxRmN1TmxVTVYyRFpKaXR1d3pzYVAyN1ZIbXZkMGVKbWpF?=
 =?utf-8?B?NzBkZkhma1NjdURLa0dhRzlWR1hCd2dGaTBvdEt3cDAvQmVpRGl5RCtvSUtY?=
 =?utf-8?B?YTZ5eXJ5WURJWEMwaDRNellYZzNXWHVkamZVZ1EyNHY0WVU5K1BLUk9WZ1pO?=
 =?utf-8?B?ZEtVdGkzUHk2QytKaytYVGk3UE52aW90cWZCUDMwa1E1eVlDTnl0R3BUUktx?=
 =?utf-8?B?QnlKUjBoeXVVM1dyS2FkbWFNcUJpSXR0amVSaGZnQXgvU0hELzhmdVl6dGNm?=
 =?utf-8?B?a0k4aERCSU8wc2laRHpldVIyNklTbWFmczlNcFptd215bVhISU5YTWxSUzUz?=
 =?utf-8?B?MTBodEFlRERYeWtiajgrQ3lYMXRjWGNPRGt2MzRqUGZBVXNtejN0NFovc0tJ?=
 =?utf-8?B?K001S1Zzait6SktNSzNubjcxa1A2bXBEcmEvS2N4dDRwRlRmV2gvdGlCZS9x?=
 =?utf-8?B?R2dvWUNkeUdIUFV3RWJ2eXpRRkxLZTFsdVhNRzF1eTkrcEtlZHhEVFFXVG1N?=
 =?utf-8?B?ZmoxdG9jbUhQY0IvZ3prcks0RUZzbkVqZnROb2xOeS9nK2s4TzVxcnZSVkUy?=
 =?utf-8?B?QVlyYmtVRUtORUdkM25TTE8zRkxLZCtRM09aaEtMYmlCeTAzaXc2UTYyZVBv?=
 =?utf-8?B?NVVWandJSkRrdlRRZGtmN0pMaU9PaXFUa0ZmU2pXM0MvZTY3ZSs2UGRoMTZ3?=
 =?utf-8?B?c2M1bXljYW5UMGtWSUpGNU5BZ2hOSjdydlNHY0RNZ1ZoK1ZPMWc0VUpBWVc5?=
 =?utf-8?B?VGdIZnFsZ2VnU3JhMDZHWHFmVVFsVUtWZmVlcmp6alZVcUtTMFRpSitsUkE4?=
 =?utf-8?B?bndSV2l1NTZrSjUzNlNVcnE3eG1Ya3NHa3NHbGtZSzR4Z3hTVkZtNGVzRnJP?=
 =?utf-8?B?akJyRzVPUHNONzkyVjA2WkZTcGY3V05GZTJHR01VRzBPRzZUY0dFZmkvTEV6?=
 =?utf-8?B?Tnh4a1kza2Rza0FjTk84Z0hOVm9XckZLS0tSSHRZSVpBOTFGaWxuTTAvN1A3?=
 =?utf-8?B?dEVvUVlWekt2Q3c5cHVWdEx3WlZKMmg1MVFUYm8zOUdEVTVyM09OYmo4QWtw?=
 =?utf-8?B?Nk95dzJPdTRkcVFzMFRPaE9EL0VXT3ZFUTFlWGd5TUQyWXp4UjJlSXNmZ1o4?=
 =?utf-8?B?RUhXelFqU2hnNVZqdTlzVUlTZlRGbVBoM05meWhGTlZwVXBnRjR4ek5jOVll?=
 =?utf-8?Q?Dz695haRdg/jZDzGuy5bj98WN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SlN1N3RBRTdFWUhSalBqUnEydkplUjc2elorWEQzMnJwelpxTjNqSDN4YUpF?=
 =?utf-8?B?anhGeUtkbmJ6enFkWnlJL05PSlRrak4rSXFHUWFtajR4OHVicTNaeVkrelps?=
 =?utf-8?B?VzMxY01sUDFCUElZSkllalVRd2RDaVF2Nktlc25XWExlMkFseXQrVGpMeHBn?=
 =?utf-8?B?VEZUMjFmcEwwWFJoUXhpNXdmSjBSRy9xTHhReVZoZEVlVUdiZkxhcWljMGdT?=
 =?utf-8?B?U1dldFRiUXNZb2VObUdLMDNQb2Nwb0EvdUYxeFdLRm81VEQ3QXRjemJrQSsy?=
 =?utf-8?B?SFhDcmZsaEZUV1dnUHJVQlgwcm0rYTk0YXVHK0hwMFYvaXV6MUFmYmcrVlN6?=
 =?utf-8?B?Z2s2cVNDR0pSYStwa0ZNUDNCSXJENEhsVkNtZ3IxWkYwRnlNdmdRYnhMRUVz?=
 =?utf-8?B?cDhhMVBpOHJVSUdIU0MrTDQ0RHc4SXdNazJ4Y2s0ZCs0YWJ5Qk96eWd4UUpk?=
 =?utf-8?B?cTJ0RWYwNk15Y3RSci96QVF5OGJvTU50WW1aSURGb2k3K3FnZXJTcExEakZY?=
 =?utf-8?B?cERCTkY4K1NpYWhlZmpxbHNjUzZNeTNtQmZLdElnNzVYeGswdGJSbEcwRDVL?=
 =?utf-8?B?ZVFrMFduNm1xaExLUHVZY0wwOWtmcmZVSVlEbngwSUVQSWMrMitSaXFJOVVY?=
 =?utf-8?B?MlVmcjRqT2lEZFZMbEZDVDhxcFNSdVJwcldYSEwyVXpGcVp4RkRpbFlVZmNY?=
 =?utf-8?B?T0dCcFIyU3hDclBueVZTaG5QdlJCbVNLSkwwVG9DSGVhdkdkRjRCUDZVZElT?=
 =?utf-8?B?bklKcU9vZGhSQ2JvQ3ZzcFdvUWNQbVNBcFNWVXlnQVlNdmRWZzdjNkVhT244?=
 =?utf-8?B?L3B2SlExNkhEc09hOHVqb1hYczJEc0hjYUpiYnJJU0NOcUNSWmUrV3ZXNGRq?=
 =?utf-8?B?NHVvdk94YUx0S2dkU05IUlFpRjdIejVCSHdvaXFyZkpOVzRzYmUzUGpvRy85?=
 =?utf-8?B?VFE3b01BcTFlemkyZ1NzbnRCYm85Q0RYc1MzVG5KblFjSUx6ZVFId0NpSXFt?=
 =?utf-8?B?L3NacFRhaVFGaFhEbFFqS3JmeVYwdnJ5KzBGMzdCMlBsSjYwem1VbmlBT2E3?=
 =?utf-8?B?Tk9Qb09qam1yY09QUzh6emJpa1Z4bmYrdVQyQmFvcGZ2dTRKUVk3TXZtMVJ2?=
 =?utf-8?B?bzBuNXVWTW4yc0JvVVVjeGVTZGlmR0lLVC9CZ21SUVFIMWRtU1NxaUpRZWEr?=
 =?utf-8?B?VnVUbEtoemdTMkc0bHlZZ0RMMlVuRTNIa3NkeDJTdGtnRDhxUmp2WkFrckp5?=
 =?utf-8?B?Sy93d3dNeFVucVg2a1orSDA1TG1LVDcxMXIrMVJtV3RNT2UwTkowVTF5dDFm?=
 =?utf-8?B?UlhLblF5MUVFaS9sam9vS0YrbDl5M1E0U2VwY0Noc0dpNFIxc1JINmdHbDk2?=
 =?utf-8?B?bk4wVkxVUS9kUllSNTN4WFlzck5ic1dtdmE1MW9NanZUSEc0TlhyaXNkd01R?=
 =?utf-8?B?OGYwYnBPL1l1bmI3cVVFalhQSk9IRURicEsvN2RuZGxsMTNUdVBLQ2E1VFp4?=
 =?utf-8?Q?r4OUMM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea8a573-9887-4340-b5a6-08db6b7103ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:15:34.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqKEn4ylQNLWRPErGvk3sJ4Oh4UffxCJ8cxOnePDSb0hnU9H9fwHPLBlHy+D8PCx33ZNCKND9eo9FZp8qBQi2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306120158
X-Proofpoint-ORIG-GUID: pXhfHKQxGauQA6pzQ9xpCMUZHooW-Oup
X-Proofpoint-GUID: pXhfHKQxGauQA6pzQ9xpCMUZHooW-Oup
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 10:44, Jing Zhang wrote:
>> Unit is the format of the event_source device name. We should match based on that as well as compat. I need to check the code again to understand how that is done... it has changed a good bit in 3 years.
>>
> This situation only happens on uncore metric. I happened to write wrong Unit, but the metric still matches.
> 

I'm just double checking this now. I think any possible fix should be 
easy enough for current code but may be tricky for backport with lots of 
metric code changes.

Thanks,
John
