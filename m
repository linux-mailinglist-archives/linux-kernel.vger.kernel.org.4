Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E197363EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjFTHCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFTHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:01:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52D9E;
        Tue, 20 Jun 2023 00:01:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNQcZp007483;
        Tue, 20 Jun 2023 07:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tgBKB//c3vlaog6rHyAe+umsk0KJhD+iCeC7mGH9Ld0=;
 b=t5BCIqQk99cnxljJQLQ5eHKms3JCnRDoYRYm7S7FdGinqGTB3K/Q2nG41MZ2kCQLmsk1
 KNNdt29eooRUKqx498m9jwoLpof4G8g048yduilIEJsix6aCgnMwdZBfWJOAWil5wTMk
 UU4pqSfFhl7MqHt0PD7+OZZ8DYtUPFCeJOF/r5GPRtz8UJ7QjXealRa/Q8ukEQJpSHvc
 CmAcgKPb2SjUR/rLLWTCxsBLOkCslaEA9XiXsVAzVCqhACCuFXaelWAskS48tGq7osbH
 XAD0tsmH7xszKoxFfkHLzzgOUGwerEYHksoHwtB52wXbPIdoFdBMMiWGTt2fswLbBDFQ vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3kynu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 07:01:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K5MdGg007194;
        Tue, 20 Jun 2023 07:01:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w14j0mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 07:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO4eAu/0s2d2nZLstlchtBoYfIWXdj/+xaGXn8yZn0/Qr5qeiYqfM1ngW0IJBwS6/vfVrRN3cfRbMfwQNyx5PYTAoTsrvysx+/c4O3fwmshDpgMCRrFT7vKZ7yijrm/cDxm9HnoF6IDpjqP+S04gjduLKdfV1Pj94QHaKlvSHbI8En1Doldx5/PAkcvgaE1HB9JrehA1itXVJ8wTVZUlyZOm0cvnJ8cNiDMTTig+vfcDxeRGnhFHjeXTtVdV7cRiy5Ux0HsbGZIjWggwK8qReS15xbJa3CkPxjIZbzYVfdgqfFIQHKTF5gx0bIkU4Swo8lHV/J7SNCunVbtIGweuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgBKB//c3vlaog6rHyAe+umsk0KJhD+iCeC7mGH9Ld0=;
 b=jwEflv0JHo6J2rVq0Xk64+HUlWeSC2kQU8+zqmviTrAk/YMGDwTYJTjI2DWygTTOD2w69XAtlo3c8kJ0bQlmgbnBqLo/EUxtvunLJgjGCZ8CBMNjXcRYBVOxp4wGLvgkr/lc9I9fjhxpelYqXoRWJ9YUS9iuOw1/Q8/jUpCucYDEB0KVZDBBUmfwZAfhAr2XOffBrAq99GEZzoEN2r7BgUqDNX1i4SeFgF+mE3aWEWMyZ019SyskrNvS6BqOBMt5qCH8r6LQytxFRVXy2qtsjc5wwPhER2L47/URUiFNqEspLm+PsLZAS0pldq4fWi2c5QWK6xPp2XGfsIev8vvz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgBKB//c3vlaog6rHyAe+umsk0KJhD+iCeC7mGH9Ld0=;
 b=br0jXf5nkP2yllW3ANiGZ/TCJ6SZ4hM8oN/NNdw+johOC+iAIKm/bi0KNApnH+SuaDiTWsa/LnP+gCDZEc6UVUtw6W++aiJZaF+tAyutZXM8XzeQRS4yWpQdAo83DUIcuXBTlywXlIWMMRIY9UHjQncJG7dVoPn1MXdw2d6Pz2U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6258.namprd10.prod.outlook.com (2603:10b6:208:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 07:01:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 07:01:27 +0000
Message-ID: <ae596b0c-e0bc-2b08-c348-0927acc0c8ef@oracle.com>
Date:   Tue, 20 Jun 2023 08:01:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
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
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
 <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
 <079d7920-2030-2e00-a833-5ec6d450f7dc@oracle.com>
 <552eebae-76bb-a2fe-ccdc-11e8a01717da@linux.alibaba.com>
 <045a49c9-b9ae-bf0e-c4be-858d905bcc55@oracle.com>
 <7c765e0f-ca76-d212-0496-f9c56369e389@linux.alibaba.com>
 <d1ab4947-6bdf-2b9c-5b26-52c572611ca6@oracle.com>
 <a6e1114c-b37c-6999-0668-039aa495db84@linux.alibaba.com>
 <71c4ef1e-0982-1ef4-5135-001303b43cd3@oracle.com>
 <777e06ae-fd9c-8fd3-6976-7b80594e1942@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <777e06ae-fd9c-8fd3-6976-7b80594e1942@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: e265b123-2481-4309-16fa-08db715c2b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xWmfDXzkV8Xke7i/tlvv9vuwI7Gc5l5Mv3a0PfbHbqHe1DvkdwjSk//OsW+L/1Y8+4olVQIO/LwPsdi2psjXQs++c6LwQ5M/TELpwil3QAKyiH3uxJNr9KLqG7bNToLXkZgZMSHoTzM4R5mROZ7IgyE7DrQjI1QqH1BFyb1xoiNLQy9WbHBPlPKtoSPcNm/0D5KSyiIlCuUqjL2wRl2hb7xKr+jXcxBb/jOSd96toKee61nTuuwN6sufoCPohTQQape6dNUHM6YgN15fqb/I/uGvR1O4ycmRSGUkZEI04FvjlVOe2bG8UsUQP0WgrRqGsKhFcBTkAHFnQq+sk6Gh4b8JRhvR5dRRs+Ag2VOyYf+nnKPEuXtjLlkJmGroYG5GMCEaJt/M81kl5oMMQwfdOnZ8HTNXVS17kfv+TMDWOIXYS9p47zQ4o+ame3Gn/JbgUYtBnBYvlBexvqc/mWqt6uWwdYpYphjWL78OfpA99vJWsd9SkXcj4l0WTUF8hd7W+DjtVjjrpDlY0hhUm3p4Gri5Zz1BD75Fq4rOdcJFO/DUt7jcZcxMmC8QqkU2sZThuhffP4J5so3TjMoSE9SSNBVqG3jIProU95rrvFCBW8uQDB8MLI4wUsLtNA9DGr6vnFVNHmlbZs1fjl4Zf0oQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(6666004)(6486002)(36916002)(478600001)(186003)(6512007)(6506007)(83380400001)(53546011)(26005)(2616005)(36756003)(38100700002)(86362001)(31696002)(8936002)(8676002)(5660300002)(31686004)(316002)(2906002)(4326008)(6916009)(66476007)(66556008)(66946007)(41300700001)(7416002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzVjWXAyQklQNzUxTFkyMEluTUkrdHdHY0tTVk9iRWp4VFlkdlZlSWdoWlF4?=
 =?utf-8?B?ZmlleTd3VUNVS0k2a212ODE5OERzK0Y2QnBYWG5mUzc4UEJ2V3lDQkdRRXVC?=
 =?utf-8?B?bXFialY5OEIzdEt3NGZBVTQ1NmQ0ZXJuUjFreWhNWjJlTUNUMVRnNHdER0VW?=
 =?utf-8?B?aFlmM3ZoV2UwMWxTZ1pja1AvVTc2Wk42RUpXN1g5SHFBRUUvazJ4Q1owV0RV?=
 =?utf-8?B?WFpDbmNnRzNMQ0JsMXoxZW5ITjN2WERZR01aL3FUNjFYdFM0eWNGZ3pqVlZ2?=
 =?utf-8?B?d21nZUxRNXRxc3Q4am5VRlg2UWJEeE1vbGQrWVlXTWZGZjFaTDZDVFNEbmZs?=
 =?utf-8?B?cEI1dzVOMzVkcCszK3UyNVBMRGdyOWVxb2k0MURZbjdXWGRXZzRhVURPT2lo?=
 =?utf-8?B?V0pSQUUyTzFYZXZhMUJLQnVSYXF1TUxXZ2U2UkJZcW9XVTJWQURCQWhqeTFY?=
 =?utf-8?B?bXMyYjVib2lBMnMrMjNBTCtGYm1IVFo3WVp2MjVnQ21zNkFlL3ByS0tiMEp5?=
 =?utf-8?B?RDJsV3Jwck5adnNYNXE5VzZOTDdXRDJKSS85dGp6bzYvOUYvMkRxRVZkVnBv?=
 =?utf-8?B?dmkyZjVudnpEMmlPVUNXS2ZkblA3Z2wxSHlObFRWbWFtYWxLRVMvMDVka1Jz?=
 =?utf-8?B?ek8yOVY1UnVxMGZHZWxHbDdvVUw3azIzMUtUNmNpbFlnNnhtcHMvOGh5RnAz?=
 =?utf-8?B?cTVsTlZFMkZYaFRLVGs5bjhWeThRQ1ErVTd5eDBreE1wb1lwRWNCUjlCcklW?=
 =?utf-8?B?LzNmRUhqUGxHZmhwOS8wZkRBNEFERHI2SjdQenQ5c3RhY0JwR2dUNVlzNDk2?=
 =?utf-8?B?V0lUNjJzRzk2cXFNR1hSbzV1d0UyaVdSdmpaOWRibTByUTdYMHgrMHFJNTZV?=
 =?utf-8?B?ckdFdno0eXdkUnlNVzZ3U1hLUDNSUG9pVWhpOWliSzZVYnJyNWFzemJPWHRH?=
 =?utf-8?B?ZW04NXhQczBKUXJEQk1hTThrUEl4bzNza1BKeksydks0cllheE5WRVRZU2xF?=
 =?utf-8?B?MW83RGdvR01OQmJlUlFFbkdtNjdkZlRiVHBCaTd1a3NJd1RTOGpzc0FaNE9F?=
 =?utf-8?B?eHh5S2VqZTBmelRZOEN5OU8yai95QjNpMkplRUM5QmNITTFGYXp1TTJqMnZ5?=
 =?utf-8?B?ajB1ODhTcDZPOFBON2xyYUNPNmd3R1NKRVVpTUdJSXRPK2QxOGthQk9jYy96?=
 =?utf-8?B?N1hTVW9jc1lFWGdZZTVLdVBQdTBCdmdDemxIcHUvM2V3WktkWWJIMHBXZDhD?=
 =?utf-8?B?WVFYa3libXdIcERKVEk1aWZjZ3RpTVZmc2tINjAwSjc4bXE3TWY2TmxaQzUz?=
 =?utf-8?B?cGVyM0VlUHRKMnZNYjczd1NLRmg2UmViL2pubk4yZjhDVVB1a0xQNTJ5aEdz?=
 =?utf-8?B?eG9kU0h1TTJBT29yakdYelVYTWtXWjl6L0FWVDEzZEEzVy9nSm1aZEliSUdC?=
 =?utf-8?B?dC9CQUM5RllvYS9Xb2ZHd0VCaU41UzVpMFErWEJHSzJhVXl0NjhEZDB3aDBC?=
 =?utf-8?B?N3hnNHBTdHk2NDFLZEhxMzNKYTA0R3JnZGtOems5NUEvd3JMalhyem82a0NP?=
 =?utf-8?B?ZTBlM2hsejZMaWpMUkRTdU1jdmVZZG5ob0dxY0ErUUZIaVM3eU5rdXpvTnBG?=
 =?utf-8?B?amV0dU1HTDEzLzZZTFJVb2oxS21vUU9xMGhYMWFHR3AzUlZTNnl0ZEVlVDhG?=
 =?utf-8?B?TGU3NXg3c2VwV1ZFd2paUnFkcld0eU53YUFTQzA2YXFJbE5JaDFZbUM3eXlr?=
 =?utf-8?B?enJvTFluUGNmR1d5YmdnNlR5TncvV1lsUzBhcXVScTdBaEJpeC9rOUl1M2tW?=
 =?utf-8?B?NnR1YVg4R0cyU2dBTFdxQXBDaVhrT2YxTGFSb1MxYzFiWENyUkE4Y1VWckto?=
 =?utf-8?B?YVI0YWRIaFphZnRNNHdPWWdVOVpIbWtiYlpxUFVCZnNWMDlwRUVmZzFPcUtw?=
 =?utf-8?B?eCtGT3JOc1hvcGx3d210di9tTFBBS01CRVRPQ21JT05nZllFTEI2dVh5bW5C?=
 =?utf-8?B?aXZjYUQrSFBjNENNSnNEbWhlWUcwTW5yeWJYbDRwTENPOEpZWFc5UWovOXY2?=
 =?utf-8?B?cS9CaHMwTEtFTHJxdHk1VmFnQ1U3bjQwczloYmhNckhWeFpxTGJZa2ZaTnMr?=
 =?utf-8?Q?zP7Tf/IOMUjRJlb6lALHvpOXx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?czV3cEYyT0pzOHNpYVBVMTNpdkh0ditteFJXSUhQVWcwOW9POUhDUXpWRFd6?=
 =?utf-8?B?MTAzczVzYzZ5c1JNNmlHaGxpMEdPZS9OczIvVVo4eWJxbXB4ZmU4dnVqbC9J?=
 =?utf-8?B?Vjg5WkxkTmJhSFpmT0t3OGtrUzQxeTI3VDdhMitxT2oyYVozRTV0TEp2cmFE?=
 =?utf-8?B?NUNFekJNaERwcU53bDhTZXpsUEs3YkhnaW85amtDSGJ0VndQaU9ab1ozWVNl?=
 =?utf-8?B?d3BNVGRYZzlsS1d0aXUyTXB5MSticTRpVjRmVk9VeXNETUhYZG5NZ3FvUm9I?=
 =?utf-8?B?R3lMVnVsZHRKdkhVaFlpQXpwYzNOeTN5QUtrTWZ1VDNaYXUwbTBPQ2lkYUt1?=
 =?utf-8?B?TlBnMnZMZHlpUjhFWEI1U0FGYmxPMExQK2tNNlArS2ZCUEhlSkxlMmlJM0RL?=
 =?utf-8?B?VlpBTGdjaFhnNk5RSXN5UUFtNkc3TDE5cWxPRjljTU1MYnF2UUxkVkdtSmZu?=
 =?utf-8?B?YWhLSHZDMGJDak1HNmt2SFplZmNrSW1hTFVnSXd6Y0dUNlZ4dTVvNDVTWjVP?=
 =?utf-8?B?N1Erb1dmY3dLUUlVTXZhRUVVdXJzVG1QdGtiNHhkcWM0WWtPSmg1eW0ySS9l?=
 =?utf-8?B?a2dnZTRVZHFRSmo1WmRJQlVWdXIycEI3N1RQVU5MZ3hKTlZZMWwwYmEvOUhz?=
 =?utf-8?B?ZHRINE5tcGI5d1kzQTUyUUw1VGVRdVZEZGpURHZKenFpNGNCeWJHbkpvbzNW?=
 =?utf-8?B?VHpxcWpTZWsySVpNWndQZmtVd2tjOVE5dGFWZmxoMThTMlpSdWlESmdaSTU3?=
 =?utf-8?B?VXQrNzMvQVZWMXBQWlAyZk9RT2c4Kyt1VitvemZUOXprVnAvVjlRdVpMYWpr?=
 =?utf-8?B?V3ZYbVlTU0pncUpLRldORndFMTZUWm9KSFJIWk5WZVY0Zk5mNE1vQm05L0xX?=
 =?utf-8?B?d09jYjJ4ejdGN3dxcEZ4T2lKWEJJa2xOams3Z2RZY3JwUURBbjllbnRibDB4?=
 =?utf-8?B?U3NOY3BKK3F4OUV0VDI0amZSSWIxMTJqY1dnVE5GUSs3eEw1K3pxbU5WVm5n?=
 =?utf-8?B?WG83MWFEWW95c1luT1dYZVNaSEZTSThvcWhpUHE2V3FvQi9Eb3laQXZFTk9F?=
 =?utf-8?B?Rk52MUttTm1tMDZwOHZQWVB5Q1BBVHhCajJseHR3RFVSN00xMDhoSEhqbkd5?=
 =?utf-8?B?VktOdjZyakhLY1BVaDlNbFdtNWdKSjlVRUlnY0pIZkwxN2RVNzk0dGVrVFE2?=
 =?utf-8?B?V2s0UlFyM3VGeXBQSWRBZW5WTFdJZjVkQTZBTlVnOU5ZSXpiclNWaHFndTZk?=
 =?utf-8?B?SWFRMFZTUjVvVzN6SmJzMkVtelNsYmxtRm8xK3F5ZGRITXpVb3ZRWUR3MGh2?=
 =?utf-8?B?YTVyaThHU3MyQ1pieExwVjZaN2FhL2diQ1BLU090TldrRzdPakFOMnRmU0VM?=
 =?utf-8?B?N0o3T01VTnZYSGxkM093c3JJOSs3b1VNcGU5azkwd1BaczkxekJIRzFUR0p5?=
 =?utf-8?B?aE5IK0gxS0xaNFE4bVlOMkxvQzdpcWltdW5LSkQ1OVdoekhaRlFlR1NKZXFN?=
 =?utf-8?Q?LC/9t0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e265b123-2481-4309-16fa-08db715c2b09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 07:01:27.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYvh9hXNirrXHu3cXVb5xRkfOY2+sj9FWVbWOZRecqncukOLxIn4i05dXMTYPfpr5IkLB2g1apZNj3mLSmGo+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200062
X-Proofpoint-GUID: FKug-RFKGr7OX_g6OQvMQ0hKj2aKkV0K
X-Proofpoint-ORIG-GUID: FKug-RFKGr7OX_g6OQvMQ0hKj2aKkV0K
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

On 20/06/2023 03:12, Jing Zhang wrote:
>> But that JSON is not in this series. Why is it not included?
>>
> Because the RFC version of the cmn.json file does not define the EventCode for each event, this will not take effect, so I temporarily removed it.
> The EventID of CMN events is different from other events. For example, hnf_slc_sf_cache_access corresponds to arm_cmn_0/type=0x5,eventid=0x2/.
> The current JSON format parsing does not support this EventID, and jevent.py needs to be extended.

So please do that then. I would suggest just to first support event 
aliasing, and then support metrics. JFYI, I am still reworking current 
perf tool metric code for sys events, which should take a few more days.

> 
>> The cmn kernel driver exposes event hnf_slc_sf_cache_access, but I did not think that perf tool metric code matches those events described in/bus/event_sourcs/devices/<PMU>/events
>>
> If there is no alias defined, other events with the same name may be matched, it is indeed necessary to define an alias for each event first,
> and I will add it in the next version. But first I need to extend jevent.py to support cmn EventID.

ok, please do this. I assume that you are talking about wildcard 
matching for cmn HW identifier. We would also need perf tool self-test 
expanded to cover this wildcard matching - see tests/pmu-events.c

Thanks,
John
