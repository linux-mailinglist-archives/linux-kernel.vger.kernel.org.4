Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436886329C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKUQkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKUQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:39:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32901179
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:39:58 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGCmwc003639;
        Mon, 21 Nov 2022 16:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pYtw/sMtAxRQ+oWycpWkP/sh1iVQyBsOFY3BgPmJ3vw=;
 b=h3yQZ9/UXIzNJGN9Rt9klOkO6ac2EsgxuRnQ43Rgc8xHc4lOnP3yER1iFeXL7kCMvmZJ
 XBeRM2kMfk3a71P8VI4L9+jM939iOIcqcYI57wG9JyOkleR3XmDRyO/gFRMSSM1yYEik
 xsQpVvMm3KGiiJMzbTZic+Z5g9XzecY/zejnmSmViKU9G6k5KonfDX0j7hsLC2w4mN8R
 9Du4Oz/bH+Mfuavb3fTid+NhuK+uVHx4f2MLASyEBahBC379L8QsyeCfKf24yDgP/b10
 qBXh/4trySFpTbIelsF0FzRw6ZgRwjNHsQ9CiqublsqPujtVwRLBoreZpXHKqo83l+Rm pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxrd7vu1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:39:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALFS3fN029058;
        Mon, 21 Nov 2022 16:34:38 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnk9r369-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 16:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm8x3c31Hg6tjNK08FcaRXHS9gc2wmm8YZHErfvywQf8dMWw6/shTKepgZmdzT0IOECMHoFJ9lZok4SZuOuhM1FvAHAJ0NI1f6uCqON64jrYzafTnm4SIIfO4lOAxe2NPRapR7JmtGKTOQNQGuE++MnkNbh29YxfErmaTBKHy7cjcbH8ApT7YW6pMTQSxh2Bm/W03tvD3QWpdWyvvE5tcKPXARiDHjNVYzbj8s/h/y/SVlGWCWVuvTCCPOAhGuxD35PEIdVGA5taqi4CjdVn8slfKzHb5mnPE4hhUAvhkUTXq4zfSDp7O7dMqN2BC4yNaMXK3kB8ADQsW6Xv/C7akQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYtw/sMtAxRQ+oWycpWkP/sh1iVQyBsOFY3BgPmJ3vw=;
 b=dE74TFMaoE3z4VAeM2g869ABVEYo1QZmOSJHvfcsaDtqDIU7lStY/VaWLeXyfjNNoXNJS6WLQr98gZ9eV0egxhni96xAj7MiZWVe3B07HBq1I/cmPSj5qy0jow4Lk3kOlBGC4fIOdTN0PFUmGEcbDnAjNBqyQRNaT1TUC6/CZsRzj8dEK5teHGJ2GVoIGPnFGnG7KxbUUONooOn9+153naiQNjD0r/HxeRI1o3sOuj4sokul+LEFrJ9+7e97rATd2gIQQdXPF+i+in7SzW6HJlfv/3kYTzAduMKKmIE4VLHAJlWcFjsOA+QKKH+EKT3p9Bgb8Im6f7PpwK960/3kTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYtw/sMtAxRQ+oWycpWkP/sh1iVQyBsOFY3BgPmJ3vw=;
 b=PLSuLPX6UqEeHQWMD1t3gGY2WsdkPp6v2XHN5jrpVJGFszg1M2kuWS1jRQXL8w6ku34lCub35dRJ6HnLyOTDDdEMTvy+kYD4ZO/aXQBY8+fXf1Brmzm5tSV7XnndEw/9DfqMZ1W5RZw+R37292BkpVvl3Gri70oZOGeqxtlQgPY=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6649.namprd10.prod.outlook.com (2603:10b6:510:208::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:34:36 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%6]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 16:34:36 +0000
Message-ID: <927dbea2-fc14-0105-8ead-d9e15eb3fd83@oracle.com>
Date:   Mon, 21 Nov 2022 08:34:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 alloc_buddy_hugetlb_folio
Content-Language: en-US
To:     Wei Chen <harperchen1110@gmail.com>, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, John Hubbard <jhubbard@nvidia.com>
References: <CAO4mrffy+Zby8Lqt=gsPVxpmnfw7hbwZsdtMG-ryntBaEy1Nqg@mail.gmail.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <CAO4mrffy+Zby8Lqt=gsPVxpmnfw7hbwZsdtMG-ryntBaEy1Nqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d231d9-2ccb-4309-5772-08dacbde4665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwcoTK9+lNTV6LwlxbCJlMeJJZ69NyIA9krtz1phPbb31XcHod2rrzSaw9ozxVYMtHQlxjTO1P0S+nin3nTUm3IUh5JZbN/+jNT1fjD3feo0mdFiuLjlmyTBjCdUl6NkjQRaYDdoAI1pSKIHaDNU1JLWfBGkVwTbzkcc3xVdue0TjxQ7olBe7C91yIVFmZG6mNiTNj0Wz0F2VeiHqwohANbledQ+gC/5F9HFUuOy8Qa5z24WYICaXSa89iNCC4y96Kcsrr3D5a7I8SUeZyzUjo4zBUAO6LH3y2vnRhQ2TpMD68Ppu5KftCDuvpiURjToKPF5+nbH4F9muD6M7O95EUxV9RF4fsPf96UywNFQp9Pc1ul/vdUnlNJ1KnmSxzMKShVUHhY8ok8SC5eVtNowvakMDZtKr/GNMYZmCGJXeAp9J0X9zbEpiVHialoAKK3V29Mz6InreH+amZDYXF/+V1scAlD38vGLddOs94kihflkio5lYilmN5pSRmimEck4Tc1wTuGpemjAbv76pxzRNDrWikf8921MRev6pss60Ob7uSLCb2gXrl4cd+kvjM+Pp4UXEfN3uepaZiz5t9CbrmbUmyG2A4wXph1NNTgAu7s2ez4QqC1SMJYGQfdAc3XahzHU21HWSTCZnHHjdC7ffof6+CHot28ZxyCivI5l32hlTeNlfn0Q0kXEDtr99yGAeG/739Yo62gmhDPy7VV2yIj1nQuY/IVzds/uQXnvVSHcrlFE+ueoTPoZI/1dswvfwNQxfBuSlrIg5AzHo6493fsWnJsha4LhJnmuM/fJqrFgExnSuz6c8crm7SHZXHIRRkckA0KFVUJVaO6P4i0OSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199015)(44832011)(53546011)(5660300002)(7416002)(6506007)(316002)(110136005)(8676002)(36756003)(6512007)(66556008)(41300700001)(2616005)(186003)(8936002)(921005)(38100700002)(83380400001)(2906002)(66946007)(66476007)(26005)(86362001)(31696002)(6486002)(6666004)(966005)(5930299009)(31686004)(45080400002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG9pZkpwYk9vTHBVNVo5SmJWUVdmSjNDK1dzZWRMVCs2eUt3SnpQU3lrYzhh?=
 =?utf-8?B?TzExVG9iN3p4Y0tjaHFzMHVtZDZXQjlvN3ppSmhCcGswN0JOUHJIeGl3c3dy?=
 =?utf-8?B?Q0RDMExyRVNSaHVsWFhqZEdqalRBNktsOXhRNFBPOHF1TUdxTGp5dzVaK2Mx?=
 =?utf-8?B?VElMbTA5UVJHNFVOYkliRnhKaFJ1L2JTU1grYU43QjluM3FxaGcrb1BGOHh3?=
 =?utf-8?B?eE1TUUJ6dEN3cy9OMUZWUXdMWFhRWEN4RWJndm5YenRwUUhOOE9FbTRhVGVB?=
 =?utf-8?B?Zk5xOXpRdW4yQlpBWlVzSnJxdEhXZmpGRW44S1dxNHdGdTZxNmtHQ1FDUmNt?=
 =?utf-8?B?SGFsc3R6eW5TYll3bHJLVjl6TmNOajhldTM3bUh1ZEpTR0s4bEt0enBwOXRo?=
 =?utf-8?B?ZkhicktGWkwrRVBQZ2cwVUpSV0d2YkJTOUEyNG55S0NkVDF2NDFqMUpMNHpM?=
 =?utf-8?B?VXZ1aUdyT3cyc21tbVRQMnB0cHF5bXlIQWZKeXNWWWphNEN6UG9lTSthOGcw?=
 =?utf-8?B?YnBpM3B1STY2Y0tVdzRpT0NSNTRybnNaY2pUT2NBZlgrTUhIdHlSM0hUbWtZ?=
 =?utf-8?B?MUtVOXNUNTRYWXZrUXd5dkZ6WGVXZy9nNU0yd2JjZldSSnVtQ1lIaVUxNEow?=
 =?utf-8?B?TXluVDdtRC82ais3U05NeDNORjIxNlZ6ODFIRkthWm00NnZ4R0dncnhzd2hs?=
 =?utf-8?B?RGplakwrRThBUW16TEdBYkR1TFQvOEE3SFplSW0wRDZJdUJVQTgrcHBSRG81?=
 =?utf-8?B?WEVFcjlhRnRaREIxbG1HWkxtaHNqcGg1eUpLTmMvR1RiMjk3ek4xWDE0dUdK?=
 =?utf-8?B?aGlIa1NGY1lQUHA4K2lveTk0U2NqTTBKVDRqbGdXb2NuRHVGbzFEQXIzM01h?=
 =?utf-8?B?WHhlby8zRTUrNEptTHpBL1IyMUkrODZaZlo2UUN5eGh0QnhEaTY1QnR1VGhr?=
 =?utf-8?B?M1JFNmF2R2JRTjQxQXRQckZ4QW5TaXp3L29aVmxkR0NzWHJteHIzd1BwVG5o?=
 =?utf-8?B?TXJlcndCeWltamtXV0VPUHM4SURZMHlxcGt0YVBPZEJIQkl5cmk2cmthR2gz?=
 =?utf-8?B?WUZSNHF5TXd0R0dtekxNZ1NvcWRiWEVzVE5HUndYY1BvZzRQT2tIbFRQWGFx?=
 =?utf-8?B?KzVrd1U2S0tLdlVKQnd5UUFBclBHTFpMR1RtUWVrVDZaMGovaGlha1VpTm1K?=
 =?utf-8?B?SDVHUDFJY0NxWkhadThlZks3WlhVaWtscEtGYzBrU1Avc3VYMHNxcjdWZlVs?=
 =?utf-8?B?RTMwc3dFZnRuekg0OXdvNXN4VzNKM29EeGs4UFl3VU8zL3RCdk5Pd2R6RTFU?=
 =?utf-8?B?c3ZEcVlVbXU1K0FmcDNvVkVDd21XK25CNWF1cFZCZ2VlT3pSZEY4bHQ4dW13?=
 =?utf-8?B?ajBhMWJTQlF3TUY2Wk1DVEZQSnEwU2tUNzVlbHg4eHNTNnFmWkg0TVFuL1ZW?=
 =?utf-8?B?b0R4WHJSUDJYblFJbSsyTkl4Q1kyTTNIdzhBMThHSW05L3lCVm5Qb3VPWDd0?=
 =?utf-8?B?Wi9DRUd4OGZJaVFHSlcyWDkyc2djZ3JjZXlLaWFVR0FtWndNRmRLVnhNUW9j?=
 =?utf-8?B?b1REZDdCUndudlJQZy9KWmREUzMwNDBwUHAzVFBQZ0M3OXJjWWxGbzg0T1Fh?=
 =?utf-8?B?UkU5NjRWMVlyTldVTlNEQSsyTnpCR3hXVmtJcmJDYWNjRlVqcDFteTlra0RD?=
 =?utf-8?B?YVEwVVVTampZS1pua3VRUGFMbzVqZ2pFZnp2dzZXL1BOalpGS0trWkYxcC9w?=
 =?utf-8?B?cFhFTnlkbjFIWVQ4YkFROWxQV3h0YXdvbmxTTGt1bG0wcTdlQ0EyaEhGRkth?=
 =?utf-8?B?dk94NlVoSTNMSjNZMnNBRkZOMUV5QnBhS1cxQklNWWMzSFFsQ1N0djBvc2Nz?=
 =?utf-8?B?d0lyR0hqbmF5eDFNVmRobkVod1RPckswQmJ0V1Y5RXUxdHphSTlZK0U3OHFh?=
 =?utf-8?B?UWNWbTZvbGFOZDBRb0MrNTZHY05mQ2dEek5WajQrK09GY1ZaK21Va2NiNmd5?=
 =?utf-8?B?eGxCVEhtUlN0VVYzWXFkRjlFKytKU1ZjM2xFY0NydGI5OVFSaTMyV284cU05?=
 =?utf-8?B?OUNwZkEzZnlrMExPWWt3RlZCa3NTelB4U0JFZEpqcTRYTU44bWJvaENBNTNh?=
 =?utf-8?B?UXlRSkIrelQrMHVucVAxV3F2RGtIanVaeTFBVGFMRHlPUkhLTk0xMGhQc3Ri?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d1p0bDVzMnlJNkNiN3cySm42TGF5b3A5cGVBYW5Da1RTNmExWmRaeUxVSWMy?=
 =?utf-8?B?bzg5cE5HVkZUYzNQS1pveXlKUjRvcWtkNVUxcFE3U2NRaG1PZVhuK1NZZXV3?=
 =?utf-8?B?dE5hc2dReTJHN0xpdkdwdWxvcnlTR0hPWkZ2QlVVdlFXa1pPdnAreXBuVmoz?=
 =?utf-8?B?M043ZmVWQm05ZnR2UFFTWFhGcjJJNExuZXJ6N0RwaC9LWG9MWDZaeHdaSWgy?=
 =?utf-8?B?d1NiOVBtU0JUNG94OTZ5UVc1UzMvNlgzOUJOa0d4ZjZBcUY1eWF3UkpQenVE?=
 =?utf-8?B?YUpRck9sY2lkOHdBZ29kQXUvRURBSEo3ZGtxYWJOOGw1KzBpUHBQNmVObFRv?=
 =?utf-8?B?RkR5T3drRDRVU09FaWk4Wm45WW4xSFh4d1AxRnRsR3BjdXFlQkw3eGdYYy82?=
 =?utf-8?B?YmpxRnloWEZQUDg1R3JZMXV1V3pDOXQrbk9tUjRWeWw0aVNiSHJIaENmNnh4?=
 =?utf-8?B?cWt3WjIvYnBnTHZBQlNSazNXUGdhMzZ3NEZIcGs5R1RUODFXT2F0dDNNT1ZF?=
 =?utf-8?B?THM4SWpEc1FQREZzZEQzd1ZUN2V2R2srRE1wZnNMSmtITkExOUVNYkhRbTRI?=
 =?utf-8?B?Y1ZkQ3BweFV0QWVFSWF5c0xiYVFFakQzVDVYN3JNbzQwMHd0YW96V2tLbVRz?=
 =?utf-8?B?a0gxQnF5U2piaUM2Z0NLczBHM3YwemM1UnJpVzREM1B5VjAzaEQxOXA3b1lE?=
 =?utf-8?B?RDRJYjlNaVFUaUlvSzRRcE1iUmVBQzh0eW9HYVNEQWpTUjNxUVpMM3NwWHNt?=
 =?utf-8?B?R1dHeEtqNDlZb0FXQTFyWDV0YXhGQ2VUK3VVcU1RTFpWUzF4bHIzb2h5cG9m?=
 =?utf-8?B?SzZXUTdpbWdqU1BQekYwUFBSMGlPQitwTVdtQ3RxU0laSXZtWDN5b1E4QWVY?=
 =?utf-8?B?dXhRQmNoNmt2bzhlMFFKQzdxeHdlRGY0NUx6T0ZTQlJnZVBIWktDc1pSSW9a?=
 =?utf-8?B?TzRkYVBXL09QZHNaZzFjWGdTdHZGWHlrSkxFR2VRdjVpQVI0c29WSW9kZ3RD?=
 =?utf-8?B?VFY5MFBFQ2xiemhPWXkyZEdUVlpDeFQxSDVvTU5NRDUwUkQyQ1lMQzN2clB1?=
 =?utf-8?B?eXFrNDg5ajUwYm1FK24zRXNDRlpHNU9vZzVzMjRKOXZiam5UQWR4VlZrSDNq?=
 =?utf-8?B?UjRHc3dZUWpkTGlZVm55dUZFK2tqMlJtMDI0cVpSRXErdUpnN2QvWngwNjRJ?=
 =?utf-8?B?WVFuNTVtRjA3RDV0WCt2ZStMbXFNeFozWGdGZ2ZzODJmSyt0em5ZSDBXYVR4?=
 =?utf-8?B?bUdmRGZkOW5kc0JNQjExVW9KaHRlT0JQSGZweUg1OGo0cCtDa1BNOCt5dVBU?=
 =?utf-8?B?NDhxOC9tK3dMbnl3Wm15MFVCVU1Eek9mQXdpYkF0RjFTcW1JQ0VRN2VRSG15?=
 =?utf-8?B?Q3h5ZTVwbDhvc21rV1J2amFkQ2FiandEVWFLai9NWDJNM0EyczZ5ejR2citK?=
 =?utf-8?Q?Pe/j28PK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d231d9-2ccb-4309-5772-08dacbde4665
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:34:36.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHbH+/ZXFBZnCAobrQUP4Ca/rJeN/TWraqDwRh5Due3Tn87TB0CFtLuqZLHeR32ufq7mJEsvXPz8oUvwX9+YhSrXHZwX7SniqeODArPTiZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210128
X-Proofpoint-GUID: Hay-oX7_6GD62-h9LC1KA5CxlNa0kqeu
X-Proofpoint-ORIG-GUID: Hay-oX7_6GD62-h9LC1KA5CxlNa0kqeu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/22 6:21 AM, Wei Chen wrote:
> Dear Linux Developer,
>
> Recently when using our tool to fuzz kernel, the following crash was triggered.
>
> HEAD commit: 147307c69ba
> git tree: upstream
> compiler: clang 12.0.0
> console output:
> https://drive.google.com/file/d/1b2z08RYnxoR5I8UiwqaMpG9E-dYgDTcL/view?usp=share_link
> kernel config: https://drive.google.com/file/d/1NAf4S43d9VOKD52xbrqw-PUP1Mbj8z-S/view?usp=share_link
> Syz reproducer:
> https://drive.google.com/file/d/18vNqAHwkVoyx5Db2qnswcaiT-prLx_rx/view?usp=share_link
>
> Unfortunately, if we transform the syz reproducer to C reproducer with
> syz-prog2c, the crash would not happen. Please consider to use
> syz-execprog and syz-executor to reproduce the crash.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: Wei Chen <harperchen1110@gmail.com>
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008

It looks like this is caused by what John mentioned here[1]. I will send 
out a new version of this patch with the fix.

Thanks,

Sidhartha Kumar

[1] 
https://lore.kernel.org/linux-mm/03ca2e41-28d3-c546-4347-5dee7b7dca9b@oracle.com/T/#m6312d55610697df44d00c41d60fa8af9d3239891

> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD a9b2067 P4D a9b2067 PUD ab02067 PMD 0
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 0 PID: 30461 Comm: syz-executor.0 Not tainted 6.1.0-rc5-next-20221118 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> RIP: 0010:_compound_head include/linux/page-flags.h:250 [inline]
> RIP: 0010:alloc_buddy_hugetlb_folio+0x1bd/0x2b0 mm/hugetlb.c:2009
> Code: ff 74 16 8b 04 24 34 01 75 0f e8 ae 04 d8 ff 49 63 c5 3e 49 0f
> ab 07 eb 05 e8 9f 04 d8 ff 45 31 f6 49 8d 7e 08 e8 23 84 eb ff <49> 8b
> 5e 08 48 89 de 48 83 e6 01 31 ff e8 31 09 d8 ff 48 89 d8 48
> RSP: 0018:ffffc90002823bd0 EFLAGS: 00010246
> RAX: ffffffff814fad41 RBX: 0000000000000009 RCX: 0000000000040000
> RDX: ffffc90000afd000 RSI: 0000000000000ab3 RDI: 0000000000000008
> RBP: 0000000000146cca R08: 0001ffffffffffff R09: 0000000000000000
> R10: 0001ffffffffffff R11: ffff88812663a000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f7190641700(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000000ab00000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   alloc_fresh_hugetlb_folio+0x73/0x370 mm/hugetlb.c:2030
>   alloc_surplus_huge_page+0xb6/0x1a0 mm/hugetlb.c:2245
>   alloc_buddy_huge_page_with_mpol mm/hugetlb.c:2321 [inline]
>   alloc_huge_page+0x9d6/0x1620 mm/hugetlb.c:2937
>   hugetlbfs_fallocate+0x57f/0xd70 fs/hugetlbfs/inode.c:865
>   vfs_fallocate+0x486/0x710 fs/open.c:323
>   ksys_fallocate fs/open.c:346 [inline]
>   __do_sys_fallocate fs/open.c:354 [inline]
>   __se_sys_fallocate fs/open.c:352 [inline]
>   __x64_sys_fallocate+0x75/0xc0 fs/open.c:352
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x4697f9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7190640c48 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
> RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007f7190640c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000005
> R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffcccf17d70
>   </TASK>
> Modules linked in:
> CR2: 0000000000000008
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:_compound_head include/linux/page-flags.h:250 [inline]
> RIP: 0010:alloc_buddy_hugetlb_folio+0x1bd/0x2b0 mm/hugetlb.c:2009
> Code: ff 74 16 8b 04 24 34 01 75 0f e8 ae 04 d8 ff 49 63 c5 3e 49 0f
> ab 07 eb 05 e8 9f 04 d8 ff 45 31 f6 49 8d 7e 08 e8 23 84 eb ff <49> 8b
> 5e 08 48 89 de 48 83 e6 01 31 ff e8 31 09 d8 ff 48 89 d8 48
> RSP: 0018:ffffc90002823bd0 EFLAGS: 00010246
> RAX: ffffffff814fad41 RBX: 0000000000000009 RCX: 0000000000040000
> RDX: ffffc90000afd000 RSI: 0000000000000ab3 RDI: 0000000000000008
> RBP: 0000000000146cca R08: 0001ffffffffffff R09: 0000000000000000
> R10: 0001ffffffffffff R11: ffff88812663a000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f7190641700(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000000ab00000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>     0: ff 74 16 8b          pushq  -0x75(%rsi,%rdx,1)
>     4: 04 24                add    $0x24,%al
>     6: 34 01                xor    $0x1,%al
>     8: 75 0f                jne    0x19
>     a: e8 ae 04 d8 ff        callq  0xffd804bd
>     f: 49 63 c5              movslq %r13d,%rax
>    12: 3e 49 0f ab 07        bts    %rax,%ds:(%r15)
>    17: eb 05                jmp    0x1e
>    19: e8 9f 04 d8 ff        callq  0xffd804bd
>    1e: 45 31 f6              xor    %r14d,%r14d
>    21: 49 8d 7e 08          lea    0x8(%r14),%rdi
>    25: e8 23 84 eb ff        callq  0xffeb844d
> * 2a: 49 8b 5e 08          mov    0x8(%r14),%rbx <-- trapping instruction
>    2e: 48 89 de              mov    %rbx,%rsi
>    31: 48 83 e6 01          and    $0x1,%rsi
>    35: 31 ff                xor    %edi,%edi
>    37: e8 31 09 d8 ff        callq  0xffd8096d
>    3c: 48 89 d8              mov    %rbx,%rax
>    3f: 48                    rex.W
>
> Best,
> Wei
>
