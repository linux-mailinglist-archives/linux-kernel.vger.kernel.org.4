Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0B46D6C34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjDDSeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbjDDSeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:34:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E884C27
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:31:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DxCj2023754;
        Tue, 4 Apr 2023 17:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dbApGOrYWa7mfDuoxc6AkG1hJLb+F948BK/KeDOGaJ0=;
 b=ih/i+YwHXIMG9X00gO2LL5yv3b1RugETP4V2w1gwBY9iW+I1MtHWMFIInDxrdO67ebP9
 LzasBDBxuVppvaRdvCR/5gt2c37bKamN+WroTY8iaJzVK4QkSE5HbUIvazlijl4uCNJi
 Xwa1EOTmrET7nvy8mL9dtMPRtLNlOlLY4lMscK0gMoIv078vFXV96yDlz1U8J8z0gI48
 MoncP4Yml7QpCYaBCO8pe1qkvXlaxy3LHtgHjCWf8af4rv/HBRIdsvq72QvMnO/t/3br
 wxOebNbz6ICUD9HL46xKZ1RK7PmzZsLT0FYBUTa4MRNqW9YYD8pYkT1wl/LUTj8e/bc+ /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7txcwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 17:25:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334Fu0iD039465;
        Tue, 4 Apr 2023 17:25:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt26q1f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 17:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+7np9ZNhbFIKhT1P7vRIL/t+ey2kH6zU4Eaoz0VW7JHDPlr+JNCAK+VqFpZhXmmRRske+dq53jSpwgFBs/MYKn/zAuJV3aJSbwY7qiU8KvQahhElhOImSY9pBW7IBNxiYGoElEUNREUL16a/GHogtKuhs98BpWKIV1zDCDozluKgsKapD12Hx3TSVfgom6WpMzKUKbb2sAugCMuiAgFWVCW9+ZK9gyiFJB/0iB9ZFrRGKTWo4oMSAa5KyJ1kHFoiiPHJmKcePMetUoE/VP6Ag8s6mZTmzp54dDiYmRyb+n3EhMwD8Vuq6oYaFwN7vusXKEUByivP+nbDh4kwMbzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbApGOrYWa7mfDuoxc6AkG1hJLb+F948BK/KeDOGaJ0=;
 b=n2xGc+/TAQeeLhGwUj4o/H6WH7pigyrPU19IOYv0x/JRqe+b5QeeZkPn0d8oKGDaqBkUr+zZw/+bhPqM4dqf3ECS2D13AqwurnL69WmkFC5btlufXAviHDPW2wZEYIPPGNkGJWobdlwRoItcQqsHTojmQs3AEdw2zzFHIXNRwONdMoC0elJCO2dFUs1+AzYCHE+k8W2IDPWwha9BmCR3WsDMWWt6bF4uVbRmBuOMeSdOaEY3lOrrxqpQs+EyyR8RATVOf2KCvlE6T6+76iqJ2btTRmK0u8d4YWfePJITJsbdRJXz0QN9vnapiWkDFdRPV1CEwoO80EIQ1LIBIq0sKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbApGOrYWa7mfDuoxc6AkG1hJLb+F948BK/KeDOGaJ0=;
 b=fGXHC3TBAj6bYlnK4M1335V3ddyCngggNMXOjWe+hz6p4ANc8RsTQY04BRgGDuElDbLU2cFBUyohwRTe+9WzYMol0Dk/Eg3pfb0f1yNecEysUjj9HvoD8s8Cg2F3AEM1S5+Xukl1eOwZK4Y53+QTZSAl9nCv+jFGE9D8Bp5S8fQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5347.namprd10.prod.outlook.com (2603:10b6:208:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 17:25:03 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::fb63:990:eeef:ec00]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::fb63:990:eeef:ec00%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 17:25:03 +0000
Message-ID: <fb1b1f30-cf9b-3044-d573-00a7e108d943@oracle.com>
Date:   Tue, 4 Apr 2023 22:54:53 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH next] ASoC: cs35l56: Fix unsigned 'rv' comparison with
 zero in cs35l56_irq()
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     error27@gmail.com, James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20230323165825.1588629-1-harshit.m.mogalapalli@oracle.com>
 <f6e99383-4054-4f14-8cf6-8a9cdd792265@sirena.org.uk>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <f6e99383-4054-4f14-8cf6-8a9cdd792265@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0081.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::7) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6c7d3e-650f-448d-c440-08db35318689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EW3Elb2UDpKH0LIz8pYcYJMX4HTm9eaEDyLrwejoZZARPuc0/amPsjEGXmkemjXwk3/G6wQUHvQOKch3ih6WVlOrP2n2giz0RyxA0EehfAN2k+VHbwa62TDR39RisqVJW8Ki5Ba/2/HYwagxClLoX7FFEL2ISH2Og9ZS62FF6nY04rGvLIj0kP1wWTOmZugeTRcXRVpGioy+8NZEQFnMCk/vm3xvkHjNHUYFPxylMD7A0eaeeCv/g1+QpXCx/hsRv+11/eKTJBdG8dwVTPWdviiLfENoJ0OZBty+2/Xu9Rh+dAJClMLpFsq6QVrnModMT0w7vFp7ZO+MYRGA8s8GhZuEBce7bPQtR7KMQX341gqZT8DgMIkM+jc1J18k1dJk8EZExo7uERPCEjQK2m16QOoBQtppF2cy7pCwfpM1IFSSsB75UhIOzY4jtCNKV8b2mqHEXQsRESAJUbu59RjcmLq7wvOyvfUxbaXL0TCsbWmTR9XdZyQaE44J5yvmHrhbn7VK0rqVEpjwHyaUyHvQU2iox6tHIoolUIOhC7y3yx/MTB6QHyXr9TLuzg2qUasEf0YV6W8N7zDj9UO5IjYSDPScIG+KehItDeFiZL9w88mHdPiq3EnQW9S6cncTzChb9GBXaJGkb9G5QY9LaKiIlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(6486002)(966005)(6512007)(53546011)(38100700002)(2616005)(6506007)(6666004)(186003)(8936002)(26005)(4744005)(2906002)(7416002)(5660300002)(31696002)(36756003)(478600001)(4326008)(66946007)(66556008)(66476007)(54906003)(6916009)(8676002)(41300700001)(86362001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW1lS1dPRlB0N21FaXZTRlU0SjFtN0FkL2lnVWo3L2p0OW9UdnR2UVZKVmFN?=
 =?utf-8?B?Ty9uYkNMVERvb1M3SU0yczJlT3ZBNzNhKzRMRFErNWlpTlA1VUkwVks2OCtR?=
 =?utf-8?B?M3JLZjJhZzMwR2RJSEdIVnJmcWx1anRkWTdOVURlRWRDRWk5UzdBWU1WS2pn?=
 =?utf-8?B?MVZPWks4Ym5kWm5TQnpuTTk2enY4aCs5MGFHQlluMzl4NXhqTjMxbGZzUDBm?=
 =?utf-8?B?WHlFa2dFdUdCZ3hFbjNrN2V2R1paTDk5UXQ3NTg0Q2MvVmxVaHRDOWZJODlE?=
 =?utf-8?B?NXIvbmlBRVpKZDljdVc3TFVmTTFGdW5ZY1llcVNQWmM0T3FQM3o2KzQzcGRh?=
 =?utf-8?B?NG1GaXcwVGhpWk5XRkZmOW9HbzdBdDFUdXFJOVJXbUtoSThVVE9rRCt3YnhD?=
 =?utf-8?B?UWNnV2l3eFBkb2pnT3FOcmZSS1M1Z2daZk81dXBqVjFQZFEvT003am5kV24r?=
 =?utf-8?B?VWtoaSsvb0FwZVUyT0lUNXBPcUNEUkZQd1RwNkl6RUdjOFNnVVZvK0YxcEFV?=
 =?utf-8?B?SlYxdllkckszNzB6ZVBIUEFNc29OZFZQOFVXNDQremRsVjJVVmcza2I5dTdz?=
 =?utf-8?B?SHdiOTRIUXVlOERiaW5ycE94SkNhd2FZU1BjZDlWOXRPRkQvL1FDdmNjQjkx?=
 =?utf-8?B?OGFiVVpudkxBclZhZjIvdW9kR0hXd2tMTXpqQk1iUlZ3N2VqRXBwcWl1VHJz?=
 =?utf-8?B?b2JGNC9PRHBPQUFFejZPOERSSm4zVFFnTUNDNWdkdmlKbHhMT1EyT05idzJT?=
 =?utf-8?B?Rjc5bTRXcjlGaVNLOE5vYUZEUlh6VVllZXVWQXFrWXQ1VTloU1B3ZWtnYngr?=
 =?utf-8?B?K0V2dVJnbW0yV1BLWHVsb3pWaWsyRjNCVGhUdzBJcEZiZ0dJR0w0eTNvb2hR?=
 =?utf-8?B?QWZ6YmRIZUROdmErMXRkS1NvSkR2QXFIYnVRR2lvNEsxcEZUSVdsL0w3WlVF?=
 =?utf-8?B?NHJOejJvS2d6UXU1bjYzWmY1T2tTMGFab2JNQjJ6NWE1empBMFhMNU92cXZS?=
 =?utf-8?B?ckFYVU1wbFFnTFlibFlQLzlYYzhKYkI5WVN4aTE0RWpIOXFVMjNxbGRhVndN?=
 =?utf-8?B?d0tKdzZ6dTRiRWFHUEtSWWs1NUU0bDAyek5zQnpoOHM5QWc0VHdsN2V0Rnoy?=
 =?utf-8?B?RTBjanFnVkpDeE5oc0FrbDdWK250aHVQeHVIc21MdXJpdVhobUtzTDBLK29J?=
 =?utf-8?B?ZXdUamFYczUrZHB5OUx0Z3pFTXJTWVlaUTcxSjhHeFBsWWVpeVMxam44d3NS?=
 =?utf-8?B?ZEFoWTJkOGw3Wk1oMUVNdHdFaXFDbnpCSjlxUEgxVVZGRzhBR0VaVlRlOWRw?=
 =?utf-8?B?d09aS0cvWVh2dE1aemttUjY2OTNVaE9aeXQyQ0VJSzRHZXI0MkZjbGJZMmt2?=
 =?utf-8?B?TkFwN0d5bkFjaTlDanNiZW9jT05zSjlpbUxrZmhKdlZuZ2hjM1RJNlNyK1Q5?=
 =?utf-8?B?UzhUSTlhRTZyRXVwRDg4akVUbDZ3elNMZFJDZVljQ1BNTktDZGROczFEYUw1?=
 =?utf-8?B?T3VlTWU4QUd0ekRmd3hTY1lFdjJCNjdUaTJoem4vTTlYWTBuQTlLM3FBT1ho?=
 =?utf-8?B?ejRFNTU3TTVGQjVjYWhQWVpNL04zbkZvRW0vODJYTXVUNWlkeFROK3U1VW5I?=
 =?utf-8?B?UUxqWEFNTlZLU0xIcTQyUEVpZkYwTCtlL3lEM1VRQllJZkh2QTRyaFV5V1Zo?=
 =?utf-8?B?NVg4MUdpeDdzL3FXeXJYVm42N2VLSm9rdCt0WThEUmlZblhIYTZ4cHp5bTc3?=
 =?utf-8?B?a1Ric3MrOEpEbVFFNFdXTHlSTHNRWUo5MktKWUhUM1ZxRDI3SC9NbG11cXJx?=
 =?utf-8?B?MERENk9aZWQ2L092Y1ZTVTBZaWNyTVpkK3loajIvOVEyejFOaGdDN1dhdC9I?=
 =?utf-8?B?QWxJckQ2VmVKVHlFUkxsUk9EUWUvQWJtaTQyWWRVU3hlQU5jVjNnOG9aQVJq?=
 =?utf-8?B?NEhKekJ2UmVENnRzUG9MV1VZaGhGajJrS1NvTkl3bXZ6aFBOWGFiRDNobmdi?=
 =?utf-8?B?QTF4NWVvd2lwK0tjMVBmd1lQdmd6MnlnVUZNM0tnUExNVkdEOWUxMWpPL2Vo?=
 =?utf-8?B?cSthc0ViZXpOdW5IT0lPT244YlhiUUhKUVQ3M2Vsc2YrMkF1VkNwVWNQdUFF?=
 =?utf-8?B?UzVSUm1kdEwxRDgzc0JGVEplTGpma0FxcGc4bWg4cEQvOGJTQnU5SFBHbUFW?=
 =?utf-8?Q?8HwpwlY4+X13BleN2Noby+U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cVNrdkczcmgyRzJBOER4aWI1My9Nc2JGbE9WeGxKTjNtRzgyd0dQREV5UWE0?=
 =?utf-8?B?YTJNWUZIM1BFbEhGMGlRRUFwQkQ3R3M0TUxVREQ2bkR3M0Fqc2hVNndFQjFn?=
 =?utf-8?B?QWVISGtFNzk0T0M2ZFVhRVY3Qzd4cXYwZzlUUENobUMrdDYxd25EakgxaWx2?=
 =?utf-8?B?bTlIeStVT0RDeG5UNlNIazhXQ2c3N08zTmliQlhxUzBKUjVjZlVBU0Q5Q2NT?=
 =?utf-8?B?eE0rcDhVZm5zMjFlcmcvZUNTS0NpbE5ybWdEVmZPb3orNnllbHNTYTltR1VS?=
 =?utf-8?B?SHFXK1p5VXlaeXBZcjlVbng5dm9KSGFaY2N4WnJxZkloYjkyTEZZZVZxa0Zy?=
 =?utf-8?B?ZWl1WUNiWUdOSWNYYlc2V2YxaERvNW1QNjJZNHF1SW5GQlNmNkNDU2dUNWZP?=
 =?utf-8?B?dm5NWDIrZ0kyTU9pd3dxVGJxbWNYZlpEZkU5cmdKVjU1S0QzZ1JHVUg0cW1v?=
 =?utf-8?B?c3BKaWFPOC9xSkRnSVZhWmJVU3drdk9xdjhrK2tvL1prSTNqTEt2aGc4emF2?=
 =?utf-8?B?Nk5pTitOZEtrVFRnUHFUOWdQSmEyNEdjeDBuY1BnQ1JWa3UyZUlrM2NFdXlo?=
 =?utf-8?B?QWdLbDRSY2lqcVo3bmhIcmZUd0ozTGdlOWhNeE5uOHAvYVdZRHU3ejB6WmFZ?=
 =?utf-8?B?VlgyWnRLaDliTUp4RnlOM1pmaXdwOVFqQkU1bDYrTWVYR0s2WTBDMmRQK3d0?=
 =?utf-8?B?dkRUTUFzOHpvemphaUZpd3Q3UjNOUzVlYVd3N3pERkpyYzczR3pwVGJKRE5Q?=
 =?utf-8?B?Zkd4d2p0YUxUb045Nitka2NEalFoQ2ZEUCtORVlCWTdBRDN2UE9ydlFUOEpt?=
 =?utf-8?B?dDQxdnRxNDlMTVp5aDRMUlpuUnBhL016YjlrK0JRVXNuM0RPWUsyTkJMei9k?=
 =?utf-8?B?M0NJRVBtQUM0ZEtHUUU1MDBMbG4zY1hxWHBYZWlNV3JVZUFPZnc3QlkrNFZ6?=
 =?utf-8?B?elRGOExPb2thdUV2WlU2VjVGamtBc3ovVXpXbDlSOVovRmxncThFYzFnaitK?=
 =?utf-8?B?QXZzM1g1RjVjUnJZZnJ4a1FkZllqVE15RGY3UkFHbHNtQTBxY04rMGVvRElI?=
 =?utf-8?B?VzZWQWE1Y1FiRnVKSGxnamY2RXVUc1lUeU9tK0JtcXc3M3p4b0luYUh0RmpQ?=
 =?utf-8?B?Y1F4ZTZBdVZBTUxqWUFvMG1HQ3R4ZXhnL05YQ2VQcnROVDVNUy96aVp0UlFO?=
 =?utf-8?B?YUxyY3NqTEhsTmR5TTMxU3lsNGtZdlM0Q2dVZEkzUXgzRE9HdWZVeGp0cS9P?=
 =?utf-8?B?VjJXWkhXM2NCMXNRQXVFbkNabXdaV1dMdWhDRjBkL1dBZDRIeFBqNUw2VmFO?=
 =?utf-8?Q?iIREO5/6fAav7FaSh+dY7ZbBLonp/Et7+C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6c7d3e-650f-448d-c440-08db35318689
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:25:03.3001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAG6IKDl4vIjCzdMR7RDiTenvDChF1hX5XbOj1LtqjeRrWkqhsuhC5WzHA94mhdJr1iNSaXqqfqNmaP+7YOW97gohOf6VWpzQpfqNxZQAmJ+HIZnr6hELR6dUr18ZUTK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_08,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=906 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040161
X-Proofpoint-ORIG-GUID: COETNzdGpCqVg2jCV114p8Z7_Yzy2rHD
X-Proofpoint-GUID: COETNzdGpCqVg2jCV114p8Z7_Yzy2rHD
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 04/04/23 5:15 pm, Mark Brown wrote:
> On Thu, Mar 23, 2023 at 09:58:25AM -0700, Harshit Mogalapalli wrote:
>> 'rv' is of type unsigned int, which can never be less than zero.
> 
> This doesn't apply against current code, please check and resend.

The reason for the above is that someone else sent a patch next day 
fixing the same bug which got merged in linux-next.

Ref: 
https://lore.kernel.org/all/20230324022303.121485-1-jiapeng.chong@linux.alibaba.com/

So my patch will not apply and is not needed anymore.

Thanks,
Harshit
