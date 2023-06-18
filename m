Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E48734821
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjFRURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFRURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:17:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC372B3;
        Sun, 18 Jun 2023 13:17:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35IJSCq4022791;
        Sun, 18 Jun 2023 20:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UfYtGlDCTCgd0y9e6sDlPxwcQt31+0whHb8lWZkcTdQ=;
 b=KkM2Ygal7N4o61YH3XQvG8EtKxkumExI42pVQWSCKYZnk7mGmyg8wxH4sQnqP/DTzfhU
 7pRr7ORoeLPCgK1WUHNW39NYXbf31EjzDLXzaJookT5piS/jnULE0F9QNKrqFsGU8DuL
 jWKroUcV8eLxI91uFTb9FsvZoNXz3KmqAXl/8bwwG45qL+9ZO34ED1GQLY7JTFOaXM/N
 fdn2lS6wWtGa/MMuM7W02SKVG9chyKjT76lwCLi7ODQkDarKJw/DFtKOO0Ifvv8GiAtK
 6yo9L+E0Yy3qwel4xI8z1etKIQ9UqM8DrUx77ej8wx6DK4YeCYBGwjaQVE/vwwIr35bm Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbhhkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jun 2023 20:14:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35IG1FLZ008538;
        Sun, 18 Jun 2023 20:14:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9392sy2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jun 2023 20:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQ2DF4iKotdvSw47F45f4453PbDuJDbWQb4dT/OW9EA9kFRtiLVty2DnFnVWkfwhtbUL95rqv4JRZNRztrVRblL1aA18h36BTxor81V532Ihy1CBsSy3elkW3NgQgr1rGwWmU/IEyMBxBR4y4U75LlXpCjLTmx5uxX+7fPB2b09aMgMlfr8Gs0eOCLXm6t6PAzBc086LDr1yX+yt5FRoeS3zhaT+d40fLn/YRvKGUjWcLdZEdavz3n7WSP6PZGz5/QSRRelT58TyVrCA/xNRRvBLbcj9rIdd/xB0d3NK0AVX84pLVwEyttOht+uGUriv0dk3bkPkAX25N0c041Yahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfYtGlDCTCgd0y9e6sDlPxwcQt31+0whHb8lWZkcTdQ=;
 b=lEsWscmfbrT+tCbW4DEYzBSEWSOpp65KwxBGGFuVmb+VrHRD1Ey5l6RkaABzu7n5s7LzSDP0Sp0nH/EWHpM2CDdIBwGxErAapmbozSJiJySgY3m2Ov1tcjM6/Ej6DGH/4eUFm3fePzi/BZewO/d09Xzss5ImoEhDxF2Wr0Gb7XhHBOtIRZHZskz6X3YdOGz7G/NIyztVpxIlJrl5IFK2QU5fhF+YanW3jpHXby0MWYXNXezH1WMDnomhN+C0tzTA23uXIy4motB2i/bCMadHHkVp2WXcwBcacioy5MiV+xiQwfoPHsot/Z90t+m3HseG7zvGs1DqMQargU6NW7HF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfYtGlDCTCgd0y9e6sDlPxwcQt31+0whHb8lWZkcTdQ=;
 b=awAxJSh0s4pjbREtZQiNM8XJeJcFawvA45Uq1TWojnelfM+NqAQzj1NjQ+FsjzwxLyJdw4B6bLhbKOTUSWKibAyrO28VdHYoERgG1hWYwxosr17P0lXrVK6xqxXa2J/+JQTifAb8DDDJ9mGSBhCIAa6zgKXED7s+ZfjeK/H5S18=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Sun, 18 Jun
 2023 20:14:43 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%4]) with mapi id 15.20.6500.031; Sun, 18 Jun 2023
 20:14:41 +0000
Message-ID: <6901166d-387f-24de-6ffd-1c8eea724718@oracle.com>
Date:   Mon, 19 Jun 2023 01:44:31 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/3] ASoC: Add support for Loongson I2S controller
Content-Language: en-US
To:     YingKun Meng <mengyingkun@loongson.cn>, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Dan Carpenter <error27@gmail.com>,
        kernel-janitors@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20230615122718.3412942-1-mengyingkun@loongson.cn>
 <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <cf2f3bc9-3141-8d7b-b57d-73eac70a21d2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: 46511d0e-1f61-448d-72a7-08db7038a5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgfG3NkRSEmNkZe5mv7pO7wM2F7lOYLJ4b5hf8t8Ia83dj0oKP8odHKWw+9+da+CCsNOsfd4FddK0JUFO43hlO4N7reZlR7cebnsahONpuyTCVadFly7QvS96F9ODD6l1104pFCjdKZtFzWGnHGpjxYz+kIBZmBWnYwMABKrxyAELSjpMfp17fgcKdMj4HW9mVi+idPKybef/sWyxuSR0O4gK4eEEqyw3OnsgNdVNa2WhoNOW05jeupTHpYUSPLTf1fvfKHf4GHJetQRppIiCGs8K/AZryi57yeVn0qOd3iwEZJH0xEzU7dRyvn7fB/gXgXcGV2p4auNprmXlUYihmEJ50tf5XUIB1CCy/wa+4DsZrwXvGgfM8PlRnC/ohU8VauyPPD0Ggbmr/ubq6fAd9r9+mOTkq5GCRaKLmtoAqhyjjD2iQylWXf/VorlAcVrmnD4X3uGGyEsJ1JNCt8czUwMYqxjgR6ziaaRrc+zevd9WxIPbUQB9P8XMECW9Yb1BwFWcVVEKaOPJ0pGhHMCkurkqI5F8adcOY5Faendwu312efvc0HPrjXwr2cLp5czNtvqJsv2Yy3iUvpg1pxiyoOxPQ1nlQcuXb9jiCTOKHQBMlvP0vb14zuiqL2uM4tg/Gsug2FZWh4nymSVyipF9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31696002)(36756003)(83380400001)(30864003)(2906002)(2616005)(54906003)(478600001)(26005)(186003)(38100700002)(6486002)(107886003)(5660300002)(6666004)(8936002)(8676002)(7416002)(316002)(66556008)(6506007)(6512007)(4326008)(66476007)(66946007)(53546011)(41300700001)(86362001)(31686004)(43740500002)(45980500001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0Z6K1k2bisrcm1xUXRJaTBTaTMrWmxRVzRCczFvNFFKTTZ4M3prOHhQNW5h?=
 =?utf-8?B?bDhidmdlNW9CY25Md1RoVkFlQi9wYlo5NXFSMFRydFBSRFExajgyWHBNRWkr?=
 =?utf-8?B?L1JTWWViT09jWjk5WmNvd3g5aU5IZzlBSkNVUG1tTkhVOTBaSXJIY01ZSWZx?=
 =?utf-8?B?V0dvOG5CMVZtS3BWVnJGSlcvbm1lWGtCRlVJeEtzb0NQRmhqNlV3dkxQOWZ6?=
 =?utf-8?B?c0VyTGFlSmEvNGFFdVNLQzBJbS8xd3oyN0hMRmpFdGdRbENCQ0FsaDh0YjdR?=
 =?utf-8?B?d0pWY3BLL2F6anFtWk9BVjFwWFRkNEtvc1VmQ3I3SkZJVGRFR3c3TlBwS2hO?=
 =?utf-8?B?NEFDQ0hURUZJcDAzMERNNXBJRVNxeGRnSHhTVktHcmEzRHR2bnYwbUIraFls?=
 =?utf-8?B?VkJDUlVCc05CZmJFdlhiUnNJVE9PQ3dYWmU3OGRMQWVMa2U2V2E3akZUd2NM?=
 =?utf-8?B?b0VYNUFDOGJnQW03MkQyVUpBZ2ZMSTJlemU0d01EdmNnL281QUs4MlR5NHF0?=
 =?utf-8?B?ODRMY0pIRFJqc2VEZ1RVeGNya2FtY0FnUWllNy9tK2hEZ2RzdVlZZTBVRU83?=
 =?utf-8?B?M3M2OU10eUVOL2VGc2M3K2FOL3lrUlhZZmorWmh4RVBrZFNaNEhOUjBydzNE?=
 =?utf-8?B?YUxrMnVqZERLRUpsSWlvUEhKWVNQaEVNWG85aWtnUTVCVmtIZzQ3RWE3ZGpv?=
 =?utf-8?B?d0hDdzhrVERnV3FVZlp1emlZN24wVkdnWWQrcXAzdHNKL3l5ME1HaFNxU2xV?=
 =?utf-8?B?bXpzdGt5RGFaZkNHTk9uS2lKczZSN1JqUmNOOVhZbnhBUzhVb1dTWGhFd0pp?=
 =?utf-8?B?dlRFRmZjZS8xRk51anBEVGtGblk2UWl0RXpJQUUyMXFzUVhsc0ptbmhvNmox?=
 =?utf-8?B?Mjd2SEt1Wi9QV1ZmNm1zandHWUZTRTJLWm5yRTh2Y1VLREpCWFdoQ0hBc1Nv?=
 =?utf-8?B?Q2ZjanpSWGFhRnFnbTZCMzgwbk5GeExXNnNKMUJZRllrL1Z2dEJxeHJGSXFK?=
 =?utf-8?B?K0dOWHFsZE51cEluekNMKzdoQnlmU3RFR1pvLy9GUWMvSXJRMDZucjFHMUpk?=
 =?utf-8?B?NXJ3ZFc3bTVaaXBQZEFxNkhXRVdwV2NkWEJXeXBDTHdCbFY3VTkwZlU2bVhH?=
 =?utf-8?B?TE5DUUtPNmRuczc4bXRwK1U1R2tiYTFyTEtDeGcxVXJod1c2Mm52bkM5dEY2?=
 =?utf-8?B?cGZPUGsyZ1c5TmcxQ2xnTm9kYVdrMXppRkZYVlBuNlRUTzJlUENiYkt3YWow?=
 =?utf-8?B?SjY1ZmYxd2JZV1NCdnEwVTZOVW9NTzhJbHJ4YjVXcmpGVWgwOFhmVndjWWhh?=
 =?utf-8?B?VXRIK01CV2J2TitIeDduK01JRWl3bUowQUcwcWk2SWlzaXlpN2h0azZ4dUdM?=
 =?utf-8?B?VXFPTW4yTnl2c3RLQlVMNW94bHhpb2gzVW9zWVlTV3R1RXhHR2xZRXpEWmQr?=
 =?utf-8?B?UGNSOHJJYUtRb2N1MkVMRHY2dlB2aDhkbHBJRzluSkJyZXJKVkVzcEg4aDUv?=
 =?utf-8?B?V3ZrMHBmb0hIRTVkZEpwYWlidnhBMzFNdUY1Qmd2N1VSSS84S3pQazFEWWE0?=
 =?utf-8?B?UnhNWFIvWHBiMlVFaUFRZ3FTVjBhY2V1QkVPdVZhZmorcit5aG82c2xqV1VF?=
 =?utf-8?B?NktydFF3bklXekxocU9XazNkTDRZY3VXTFNuNHFHZmdseUlOektaWU1xcUUy?=
 =?utf-8?B?Y2hRNEx2d3Y5anhSYiswM28vSEVtNnBBOFNnamUzQ0VlbTlaY090TFlNaVBJ?=
 =?utf-8?B?aDk3bUFkSEpQWnc1TzBqU2REZ3dvdU1ZazRRZzZpeGJYUTB3cHllWFIyaFQr?=
 =?utf-8?B?aVBmdkFPOTk2STlCTTJKWGw2TmE3SlQrN3htTU1PRUcwNE5uR3F2cytuWEE4?=
 =?utf-8?B?TmQva0I0TytxVm0xWSs2dkpnM0dGZGlLdGVvSlM1MkJNWDdoQmxKb3NmNXdO?=
 =?utf-8?B?RXBjT1lNS1BXM3pTbFQ5T3pCekZKRGpBOFAyMGI0eVZZaUUvbUg4NmR6YW5m?=
 =?utf-8?B?K1UybFQ1WVBlRnRaMEMyYnc2MFNnTUFiYTZaOTdOWUVCSzYyeDFtcEFaV1dn?=
 =?utf-8?B?Z0trOENVTWF6MnYrd1R4OEgyaWlEZ092YXJXUVRIUDJzempwT1VhZGpOQlVi?=
 =?utf-8?B?YnlnRnR0VFY0SFJBRStmMEphaGMzbG8yODk5VmxkWVlEZk5Pa1FMUTYwSlVW?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bitaNE1FQlplL2toLzZpbFhDckJBT0Z2amN4dnBwTjgvQm1OazlkUnNTeWxC?=
 =?utf-8?B?SHc4ZUh5TVZiL3U2VXh5Q29aaE4veU0yNCtURGV2SEU0YTlPano4TTNrYlc1?=
 =?utf-8?B?V0FLUTBDRDViL2NDbTh4bTdRKytSbXl3cGRNWG0xQkx4SzBSRXFRY0NWZzNy?=
 =?utf-8?B?cTRCL1B5eHN6aUVPREswb2lFRnJDN2xyVlc4OGg0S3dHQStTYXpKZmdMWUQ0?=
 =?utf-8?B?OFVBQ3R1ZjZJdDdiaUpFaHg0QXNXOTIvOFdjQVNJWTYwdkV0Zmt4bGF2VXhL?=
 =?utf-8?B?aFhYeXBaT3BRVnNSU1UvdEdRY0twakorNHJxYXRmMkdlODBhelhINFR6S1dx?=
 =?utf-8?B?S0ZOc3ZoNXg0aVNGWHZ1b2wxSUpwenAxZkJuUEVSdk5CT25uSmlNS0RFM2Fj?=
 =?utf-8?B?YkdUelN0M1h0VnNGYkxjMFpSdFVsV2xpVHFKVzF3ejYxUUk3QzArTWMzRW9X?=
 =?utf-8?B?aEhJcDVOclU2eXpZcnZvSDBPNVgrREF2OUxERVRpNnRwZVlDRW1sa2wyVG1i?=
 =?utf-8?B?N0IrUHVNWEFRR3hQSTBYM3FyKy8wNmpPSGdnZE96TG9uZ2xqK3lFelFObGd6?=
 =?utf-8?B?dVhtMnV3ZUxQQ2kzcE1QUTJPSTFqUE82SEorRHNMYU1QcVdZSGJmY2tYSFEz?=
 =?utf-8?B?dDNrQnFVQkhmWnR5VGk4TU9sNkh3cnNZUUlXbVZIMWUwVDVwOHJpcGtjckQw?=
 =?utf-8?B?bWx4ZVdPeTFrUUtoM3hjNWlHTDJib01XdmF0amRtOXNEYmhmZUpRTFFscUtj?=
 =?utf-8?B?bHpYaW9HTHZQeU5pM2ZmZDBTRXJkc2s1eW1xc3JxeU1iQ1BmNllqSm9GS2hn?=
 =?utf-8?B?RGZmczFNMnhSazNic1RLTTJMS2lqVEsxMldYdG9ZU3llUTk0Q0NWUDU3eDlX?=
 =?utf-8?B?alR0MlpYQkVlbmtSZ2toVDY0Q1V1WmdJcFQ4akZWNTFaWG1qa3p6eUFINTg2?=
 =?utf-8?B?UlB3K01zcUEwOTc0eDNwWWl4UkxaeVV0QVh2QXJGeUM2NHVuaDNHSGFBbTVv?=
 =?utf-8?B?eHFIYjY3bEJSb2tOcDJvVTZKbEFnY05VWEdWZ2xMeGd1YkswQnpaaDJyd1pp?=
 =?utf-8?B?RHo1SDN4QitzcVpUREs5dWFXZWZYYVdBYU9MZnpidlc3L3JuM1RscTFRZG5X?=
 =?utf-8?B?ZlJ0Y3J2Y1h0cmRibCtXdUx0ZUhZMm9ncUFKWWgvNnA3T1F6MXlVd2RrTjdy?=
 =?utf-8?B?UnkyNFBObGs2TmJqUTZ0QUlVaGRTbkh6NTVPRVZ1NnhIbTZnQUpPbVJTeDhB?=
 =?utf-8?B?TkhyZEFCV0kyYjlnQmRRUk1Qa0ZMcXlMWnlPNms0MjVVdGFvdFc3OTdVT1NJ?=
 =?utf-8?B?dy9PY3JGNVEyMGdDR1ZPZTJJMVd6MXZlY0dqZ0xrRTJhYnNJc1VFdy9uUVBq?=
 =?utf-8?B?UWVha0pCWHpScWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46511d0e-1f61-448d-72a7-08db7038a5e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 20:14:40.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjJJQUNMhtZ9p67+3D22LtkeGJm3gsZJTWEnvUltb3S4k/7aLoSa5A6XingqCPDotWsqSpnX/dHxybl4ujb+M9aoJVwm3CVNKm4PgngLALlZBijr1bo+t9gOBYZfX+74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-18_15,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306180193
X-Proofpoint-ORIG-GUID: w5n_zxE2qdlfZyFaEacYrzs2Riy2X35I
X-Proofpoint-GUID: w5n_zxE2qdlfZyFaEacYrzs2Riy2X35I
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/06/23 1:41 am, Harshit Mogalapalli wrote:
> Hi YingKun,
> 
> On 15/06/23 5:57 pm, YingKun Meng wrote:
>> From: Yingkun Meng <mengyingkun@loongson.cn>
>>
>> Loongson I2S controller is found on 7axxx/2kxxx chips from loongson,
>> it is a PCI device with two private DMA controllers, one for playback,
>> the other for capture.
>>
>> The driver supports the use of DTS or ACPI to describe device resources.
>>
>> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
>> ---
>> changes v3 -> v4
>>    Add __packed attribute for loongson_dma_desc struct.
>>
>> sound/soc/Kconfig                     |   1 +
>>   sound/soc/Makefile                    |   1 +
>>   sound/soc/loongson/Kconfig            |  16 ++
>>   sound/soc/loongson/Makefile           |   4 +
>>   sound/soc/loongson/loongson_dma.c     | 350 ++++++++++++++++++++++++++
>>   sound/soc/loongson/loongson_dma.h     |  16 ++
>>   sound/soc/loongson/loongson_i2s.c     | 269 ++++++++++++++++++++
>>   sound/soc/loongson/loongson_i2s.h     |  71 ++++++
>>   sound/soc/loongson/loongson_i2s_pci.c | 171 +++++++++++++
>>   9 files changed, 899 insertions(+)
>>   create mode 100644 sound/soc/loongson/Kconfig
>>   create mode 100644 sound/soc/loongson/Makefile
>>   create mode 100644 sound/soc/loongson/loongson_dma.c
>>   create mode 100644 sound/soc/loongson/loongson_dma.h
>>   create mode 100644 sound/soc/loongson/loongson_i2s.c
>>   create mode 100644 sound/soc/loongson/loongson_i2s.h
>>   create mode 100644 sound/soc/loongson/loongson_i2s_pci.c
>>
>> diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
>> index 4b6e5a802880..bfa9622e1ab1 100644
>> --- a/sound/soc/Kconfig
>> +++ b/sound/soc/Kconfig
>> @@ -79,6 +79,7 @@ source "sound/soc/google/Kconfig"
>>   source "sound/soc/hisilicon/Kconfig"
>>   source "sound/soc/jz4740/Kconfig"
>>   source "sound/soc/kirkwood/Kconfig"
>> +source "sound/soc/loongson/Kconfig"
>>   source "sound/soc/img/Kconfig"
>>   source "sound/soc/intel/Kconfig"
>>   source "sound/soc/mediatek/Kconfig"
>> diff --git a/sound/soc/Makefile b/sound/soc/Makefile
>> index 9d9b228e4508..8376fdb217ed 100644
>> --- a/sound/soc/Makefile
>> +++ b/sound/soc/Makefile
>> @@ -46,6 +46,7 @@ obj-$(CONFIG_SND_SOC)    += fsl/
>>   obj-$(CONFIG_SND_SOC)    += google/
>>   obj-$(CONFIG_SND_SOC)    += hisilicon/
>>   obj-$(CONFIG_SND_SOC)    += jz4740/
>> +obj-$(CONFIG_SND_SOC)    += loongson/
>>   obj-$(CONFIG_SND_SOC)    += img/
>>   obj-$(CONFIG_SND_SOC)    += intel/
>>   obj-$(CONFIG_SND_SOC)    += mediatek/
>> diff --git a/sound/soc/loongson/Kconfig b/sound/soc/loongson/Kconfig
>> new file mode 100644
>> index 000000000000..4478ac91e402
>> --- /dev/null
>> +++ b/sound/soc/loongson/Kconfig
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +menu "SoC Audio for Loongson CPUs"
>> +    depends on LOONGARCH || COMPILE_TEST
>> +
>> +config SND_SOC_LOONGSON_I2S_PCI
>> +    tristate "Loongson I2S-PCI Device Driver"
>> +    select REGMAP_MMIO
>> +    depends on PCI
>> +    help
>> +      Say Y or M if you want to add support for I2S driver for
>> +      Loongson I2S controller.
>> +
>> +      The controller is found in loongson bridge chips or SoCs,
>> +      and work as a PCI device.
>> +
>> +endmenu
>> diff --git a/sound/soc/loongson/Makefile b/sound/soc/loongson/Makefile
>> new file mode 100644
>> index 000000000000..099af7989103
>> --- /dev/null
>> +++ b/sound/soc/loongson/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#Platform Support
>> +snd-soc-loongson-i2s-pci-objs := loongson_i2s_pci.o loongson_i2s.o 
>> loongson_dma.o
>> +obj-$(CONFIG_SND_SOC_LOONGSON_I2S_PCI) += snd-soc-loongson-i2s-pci.o
>> diff --git a/sound/soc/loongson/loongson_dma.c 
>> b/sound/soc/loongson/loongson_dma.c
>> new file mode 100644
>> index 000000000000..65b6719e61c5
>> --- /dev/null
>> +++ b/sound/soc/loongson/loongson_dma.c
>> @@ -0,0 +1,350 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Loongson ALSA SoC Platform (DMA) driver
>> +//
>> +// Copyright (C) 2023 Loongson Technology Corporation Limited
>> +// Author: Yingkun Meng <mengyingkun@loongson.cn>
>> +//
>> +
>> +#include <linux/module.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <linux/delay.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/dma-mapping.h>
>> +#include <sound/soc.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include "loongson_i2s.h"
>> +
>> +/* DMA dma_order Register */
>> +#define DMA_ORDER_STOP          (1 << 4) /* DMA stop */
>> +#define DMA_ORDER_START         (1 << 3) /* DMA start */
>> +#define DMA_ORDER_ASK_VALID     (1 << 2) /* DMA ask valid flag */
>> +#define DMA_ORDER_AXI_UNCO      (1 << 1) /* Uncache access */
>> +#define DMA_ORDER_ADDR_64       (1 << 0) /* 64bits address support */
>> +
>> +#define DMA_ORDER_ASK_MASK      (~0x1fUL) /* Ask addr mask */
>> +#define DMA_ORDER_CTRL_MASK     (0x0fUL)  /* Control mask  */
>> +
>> +/*
>> + * DMA registers descriptor.
>> + */
>> +struct loongson_dma_desc {
>> +    u32 order;        /* Next descriptor address register */
>> +    u32 saddr;        /* Source address register */
>> +    u32 daddr;        /* Device address register */
>> +    u32 length;        /* Total length register */
>> +    u32 step_length;    /* Memory stride register */
>> +    u32 step_times;        /* Repeat time register */
>> +    u32 cmd;        /* Command register */
>> +    u32 stats;        /* Status register */
>> +    u32 order_hi;        /* Next descriptor high address register */
>> +    u32 saddr_hi;        /* High source address register */
>> +    u32 res[6];        /* Reserved */
>> +} __packed;
>> +
>> +struct loongson_runtime_data {
>> +    struct loongson_dma_data *dma_data;
>> +
>> +    struct loongson_dma_desc *dma_desc_arr;
>> +    dma_addr_t dma_desc_arr_phy;
>> +    int dma_desc_arr_size;
>> +
>> +    struct loongson_dma_desc *dma_pos_desc;
>> +    dma_addr_t dma_pos_desc_phy;
>> +};
>> +
>> +static const struct snd_pcm_hardware ls_pcm_hardware = {
>> +    .info = SNDRV_PCM_INFO_MMAP |
>> +        SNDRV_PCM_INFO_INTERLEAVED |
>> +        SNDRV_PCM_INFO_MMAP_VALID |
>> +        SNDRV_PCM_INFO_RESUME |
>> +        SNDRV_PCM_INFO_PAUSE,
>> +    .formats = (SNDRV_PCM_FMTBIT_S8 |
>> +        SNDRV_PCM_FMTBIT_S16_LE |
>> +        SNDRV_PCM_FMTBIT_S20_3LE |
>> +        SNDRV_PCM_FMTBIT_S24_LE),
>> +    .period_bytes_min = 128,
>> +    .period_bytes_max = 128 * 1024,
>> +    .periods_min = 1,
>> +    .periods_max = PAGE_SIZE / sizeof(struct loongson_dma_desc),
>> +    .buffer_bytes_max = 1024 * 1024,
>> +};
>> +
>> +static struct
>> +loongson_dma_desc *dma_desc_save(struct loongson_runtime_data *prtd)
>> +{
>> +    void __iomem *order_reg = prtd->dma_data->order_addr;
>> +    u64 val;
>> +
>> +    val = (u64)prtd->dma_pos_desc_phy & DMA_ORDER_ASK_MASK;
>> +    val |= (readq(order_reg) & DMA_ORDER_CTRL_MASK);
>> +    val |= DMA_ORDER_ASK_VALID;
>> +    writeq(val, order_reg);
>> +
>> +    while (readl(order_reg) & DMA_ORDER_ASK_VALID)
>> +        udelay(2);
>> +
>> +    return prtd->dma_pos_desc;
>> +}
>> +
>> +static int loongson_pcm_trigger(struct snd_soc_component *component,
>> +                struct snd_pcm_substream *substream, int cmd)
>> +{
>> +    struct loongson_runtime_data *prtd = 
>> substream->runtime->private_data;
>> +    struct device *dev = substream->pcm->card->dev;
>> +    void __iomem *order_reg = prtd->dma_data->order_addr;
>> +    u64 val;
>> +    int ret = 0;
>> +
>> +    switch (cmd) {
>> +    case SNDRV_PCM_TRIGGER_START:
>> +    case SNDRV_PCM_TRIGGER_RESUME:
>> +    case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +        val = prtd->dma_pos_desc_phy & DMA_ORDER_ASK_MASK;
>> +        if (dev->coherent_dma_mask == DMA_BIT_MASK(64))
>> +            val |= DMA_ORDER_ADDR_64;
>> +        else
>> +            val &= ~DMA_ORDER_ADDR_64;
>> +        val |= (readq(order_reg) & DMA_ORDER_CTRL_MASK);
>> +        val |= DMA_ORDER_START;
>> +        writeq(val, order_reg);
>> +
>> +        while ((readl(order_reg) & DMA_ORDER_START))
>> +            udelay(2);
>> +        break;
>> +    case SNDRV_PCM_TRIGGER_STOP:
>> +    case SNDRV_PCM_TRIGGER_SUSPEND:
>> +    case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +        dma_desc_save(prtd);
>> +
>> +        /* dma stop */
>> +        val = readq(order_reg) | DMA_ORDER_STOP;
>> +        writeq(val, order_reg);
>> +        udelay(1000);
>> +
>> +        break;
>> +    default:
>> +        dev_err(dev, "Invalid pcm trigger operation\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int loongson_pcm_hw_params(struct snd_soc_component *component,
>> +                  struct snd_pcm_substream *substream,
>> +                  struct snd_pcm_hw_params *params)
>> +{
>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>> +    struct device *dev = substream->pcm->card->dev;
>> +    struct loongson_runtime_data *prtd = runtime->private_data;
>> +    size_t buf_len = params_buffer_bytes(params);
>> +    size_t period_len = params_period_bytes(params);
>> +    dma_addr_t order_addr, mem_addr;
>> +    struct loongson_dma_desc *desc;
>> +    u32 num_periods;
>> +    int i;
>> +
>> +    if (buf_len % period_len) {
>> +        dev_err(dev, "buf len not multiply of period len\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    num_periods = buf_len / period_len;
>> +    if (!num_periods || num_periods > prtd->dma_desc_arr_size) {
>> +        dev_err(dev, "dma data too small or too big\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
>> +    runtime->dma_bytes = buf_len;
>> +
>> +    /* initialize dma descriptor array */
>> +    mem_addr = runtime->dma_addr;
>> +    order_addr = prtd->dma_desc_arr_phy;
>> +    for (i = 0; i < num_periods; i++) {
>> +        desc = &prtd->dma_desc_arr[i];
>> +
>> +        /* next descriptor physical address */
>> +        order_addr += sizeof(*desc);
>> +        desc->order = lower_32_bits(order_addr | BIT(0));
>> +        desc->order_hi = upper_32_bits(order_addr);
>> +
>> +        desc->saddr = lower_32_bits(mem_addr);
>> +        desc->saddr_hi = upper_32_bits(mem_addr);
>> +        desc->daddr = prtd->dma_data->dev_addr;
>> +
>> +        desc->cmd = BIT(0);
>> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +            desc->cmd |= BIT(12);
>> +
>> +        desc->length = period_len >> 2;
>> +        desc->step_length = 0;
>> +        desc->step_times = 1;
>> +
>> +        mem_addr += period_len;
>> +    }
>> +    desc = &prtd->dma_desc_arr[num_periods - 1];
>> +    desc->order = lower_32_bits(prtd->dma_desc_arr_phy | BIT(0));
>> +    desc->order_hi = upper_32_bits(prtd->dma_desc_arr_phy);
>> +
>> +    /* init position descriptor */
>> +    *prtd->dma_pos_desc = *prtd->dma_desc_arr;
>> +
>> +    return 0;
>> +}
>> +
>> +static snd_pcm_uframes_t
>> +loongson_pcm_pointer(struct snd_soc_component *component,
>> +             struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>> +    struct loongson_runtime_data *prtd = runtime->private_data;
>> +    struct loongson_dma_desc *desc;
>> +    snd_pcm_uframes_t x;
>> +    u64 addr;
>> +
>> +    desc = dma_desc_save(prtd);
>> +    addr = ((u64)desc->saddr_hi << 32) | desc->saddr;
>> +
>> +    x = bytes_to_frames(runtime, addr - runtime->dma_addr);
>> +    if (x == runtime->buffer_size)
>> +        x = 0;
>> +    return x;
>> +}
>> +
>> +static irqreturn_t loongson_pcm_dma_irq(int irq, void *devid)
>> +{
>> +    struct snd_pcm_substream *substream = devid;
>> +
>> +    snd_pcm_period_elapsed(substream);
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static int loongson_pcm_open(struct snd_soc_component *component,
>> +                 struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    struct snd_card *card = substream->pcm->card;
>> +    struct loongson_runtime_data *prtd;
>> +    struct loongson_dma_data *dma_data;
>> +    int ret;
>> +
>> +    /*
>> +     * For mysterious reasons (and despite what the manual says)
>> +     * playback samples are lost if the DMA count is not a multiple
>> +     * of the DMA burst size.  Let's add a rule to enforce that.
>> +     */
>> +    snd_pcm_hw_constraint_step(runtime, 0,
>> +                   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
>> +    snd_pcm_hw_constraint_step(runtime, 0,
>> +                   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 128);
>> +    snd_pcm_hw_constraint_integer(substream->runtime,
>> +                      SNDRV_PCM_HW_PARAM_PERIODS);
>> +    snd_soc_set_runtime_hwparams(substream, &ls_pcm_hardware);
>> +
>> +    prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
>> +    if (!prtd)
>> +        return -ENOMEM;
>> +
>> +    prtd->dma_desc_arr = dma_alloc_coherent(card->dev, PAGE_SIZE,
>> +                        &prtd->dma_desc_arr_phy,
>> +                        GFP_KERNEL);
>> +    if (!prtd->dma_desc_arr) {
>> +        ret = -ENOMEM;
>> +        goto desc_err;
>> +    }
>> +    prtd->dma_desc_arr_size = PAGE_SIZE / sizeof(*prtd->dma_desc_arr);
>> +
>> +    prtd->dma_pos_desc = dma_alloc_coherent(card->dev,
>> +                        sizeof(*prtd->dma_pos_desc),
>> +                        &prtd->dma_pos_desc_phy,
>> +                        GFP_KERNEL);
>> +    if (!prtd->dma_pos_desc) {
>> +        ret = -ENOMEM;
>> +        goto pos_err;
>> +    }
>> +
>> +    dma_data = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), 
>> substream);
>> +    prtd->dma_data = dma_data;
>> +
>> +    substream->runtime->private_data = prtd;
>> +
>> +    return 0;
>> +pos_err:
>> +    dma_free_coherent(card->dev, PAGE_SIZE, prtd->dma_desc_arr,
>> +              prtd->dma_desc_arr_phy);
>> +desc_err:
>> +    kfree(prtd);
>> +
>> +    return ret;
>> +}
>> +
>> +static int loongson_pcm_close(struct snd_soc_component *component,
>> +                  struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_card *card = substream->pcm->card;
>> +    struct loongson_runtime_data *prtd = 
>> substream->runtime->private_data;
>> +
>> +    dma_free_coherent(card->dev, PAGE_SIZE, prtd->dma_desc_arr,
>> +              prtd->dma_desc_arr_phy);
>> +
>> +    dma_free_coherent(card->dev, sizeof(*prtd->dma_pos_desc),
>> +              prtd->dma_pos_desc, prtd->dma_pos_desc_phy);
>> +
>> +    kfree(prtd);
>> +    return 0;
>> +}
>> +
>> +static int loongson_pcm_mmap(struct snd_soc_component *component,
>> +                 struct snd_pcm_substream *substream,
>> +                 struct vm_area_struct *vma)
>> +{
>> +    return remap_pfn_range(vma, vma->vm_start,
>> +            substream->dma_buffer.addr >> PAGE_SHIFT,
>> +            vma->vm_end - vma->vm_start, vma->vm_page_prot);
>> +}
>> +
>> +static int loongson_pcm_new(struct snd_soc_component *component,
>> +                struct snd_soc_pcm_runtime *rtd)
>> +{
>> +    struct snd_card *card = rtd->card->snd_card;
>> +    struct snd_pcm_substream *substream;
>> +    struct loongson_dma_data *dma_data;
>> +    unsigned int i;
>> +    int ret;
>> +
>> +    for_each_pcm_streams(i) {
>> +        substream = rtd->pcm->streams[i].substream;
>> +        if (!substream)
>> +            continue;
>> +
>> +        dma_data = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0),
>> +                            substream);
>> +        ret = devm_request_irq(card->dev, dma_data->irq,
>> +                       loongson_pcm_dma_irq,
>> +                       IRQF_TRIGGER_HIGH, LS_I2S_DRVNAME,
>> +                       substream);
>> +        if (ret < 0) {
>> +            dev_err(card->dev, "request irq for DMA failed\n");
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return snd_pcm_set_fixed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
>> +                        card->dev,
>> +                        ls_pcm_hardware.buffer_bytes_max);
>> +}
>> +
>> +const struct snd_soc_component_driver loongson_i2s_component = {
>> +    .name        = LS_I2S_DRVNAME,
>> +    .open        = loongson_pcm_open,
>> +    .close        = loongson_pcm_close,
>> +    .hw_params    = loongson_pcm_hw_params,
>> +    .trigger    = loongson_pcm_trigger,
>> +    .pointer    = loongson_pcm_pointer,
>> +    .mmap        = loongson_pcm_mmap,
>> +    .pcm_construct    = loongson_pcm_new,
>> +};
>> diff --git a/sound/soc/loongson/loongson_dma.h 
>> b/sound/soc/loongson/loongson_dma.h
>> new file mode 100644
>> index 000000000000..073ee8c0c046
>> --- /dev/null
>> +++ b/sound/soc/loongson/loongson_dma.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * ALSA ASoC interface for the Loongson platform
>> + *
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + * Author: Yingkun Meng <mengyingkun@loongson.cn>
>> + */
>> +
>> +#ifndef _LOONGSON_DMA_H
>> +#define _LOONGSON_DMA_H
>> +
>> +#include <sound/soc.h>
>> +
>> +extern const struct snd_soc_component_driver loongson_i2s_component;
>> +
>> +#endif
>> diff --git a/sound/soc/loongson/loongson_i2s.c 
>> b/sound/soc/loongson/loongson_i2s.c
>> new file mode 100644
>> index 000000000000..35d34568be79
>> --- /dev/null
>> +++ b/sound/soc/loongson/loongson_i2s.c
>> @@ -0,0 +1,269 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Common functions for loongson I2S controller driver
>> +//
>> +// Copyright (C) 2023 Loongson Technology Corporation Limited.
>> +// Author: Yingkun Meng <mengyingkun@loongson.cn>
>> +//
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/dma-mapping.h>
>> +#include <sound/soc.h>
>> +#include <linux/regmap.h>
>> +#include <sound/pcm_params.h>
>> +#include "loongson_i2s.h"
>> +
>> +#define LOONGSON_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | \
>> +            SNDRV_PCM_FMTBIT_S16_LE | \
>> +            SNDRV_PCM_FMTBIT_S20_3LE | \
>> +            SNDRV_PCM_FMTBIT_S24_LE)
>> +
>> +static int loongson_i2s_trigger(struct snd_pcm_substream *substream, 
>> int cmd,
>> +                struct snd_soc_dai *dai)
>> +{
>> +    struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +    int ret = 0;
>> +
>> +    switch (cmd) {
>> +    case SNDRV_PCM_TRIGGER_START:
>> +    case SNDRV_PCM_TRIGGER_RESUME:
>> +    case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>> +                       I2S_CTRL_TX_EN | I2S_CTRL_TX_DMA_EN,
>> +                       I2S_CTRL_TX_EN | I2S_CTRL_TX_DMA_EN);
>> +        else
>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>> +                       I2S_CTRL_RX_EN | I2S_CTRL_RX_DMA_EN,
>> +                       I2S_CTRL_RX_EN | I2S_CTRL_RX_DMA_EN);
>> +        break;
>> +    case SNDRV_PCM_TRIGGER_STOP:
>> +    case SNDRV_PCM_TRIGGER_SUSPEND:
>> +    case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>> +                    I2S_CTRL_TX_EN | I2S_CTRL_TX_DMA_EN, 0);
>> +        else
>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>> +                    I2S_CTRL_RX_EN | I2S_CTRL_RX_DMA_EN, 0);
>> +        break;
>> +    default:
>> +        ret = -EINVAL;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int loongson_i2s_hw_params(struct snd_pcm_substream *substream,
>> +                  struct snd_pcm_hw_params *params,
>> +                  struct snd_soc_dai *dai)
>> +{
>> +    struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +    u32 clk_rate = i2s->clk_rate;
>> +    u32 sysclk = i2s->sysclk;
>> +    u32 bits = params_width(params);
>> +    u32 chans = params_channels(params);
>> +    u32 fs = params_rate(params);
>> +    u32 bclk_ratio, mclk_ratio;
>> +    u32 mclk_ratio_frac;
>> +    u32 val = 0;
>> +
>> +    switch (i2s->rev_id) {
>> +    case 0:
>> +        bclk_ratio = DIV_ROUND_CLOSEST(clk_rate,
>> +                           (bits * chans * fs * 2)) - 1;
>> +        mclk_ratio = DIV_ROUND_CLOSEST(clk_rate, (sysclk * 2)) - 1;
>> +
>> +        /* According to 2k1000LA user manual, set bits == depth */
>> +        val |= (bits << 24);
>> +        val |= (bits << 16);
>> +        val |= (bclk_ratio << 8);
>> +        val |= mclk_ratio;
>> +        regmap_write(i2s->regmap, LS_I2S_CFG, val);
>> +
>> +        break;
>> +    case 1:
>> +        bclk_ratio = DIV_ROUND_CLOSEST(sysclk,
>> +                           (bits * chans * fs * 2)) - 1;
>> +        mclk_ratio = clk_rate / sysclk;
>> +        mclk_ratio_frac = DIV_ROUND_CLOSEST(((u64)clk_rate << 16),
>> +                            sysclk) - (mclk_ratio << 16);
>> +
>> +        regmap_read(i2s->regmap, LS_I2S_CFG, &val);
>> +        val |= (bits << 24);
>> +        val |= (bclk_ratio << 8);
>> +        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +            val |= (bits << 16);
>> +        else
>> +            val |= bits;
>> +        regmap_write(i2s->regmap, LS_I2S_CFG, val);
>> +
>> +        val = (mclk_ratio_frac << 16) | mclk_ratio;
>> +        regmap_write(i2s->regmap, LS_I2S_CFG1, val);
>> +
>> +        break;
>> +    default:
>> +        dev_err(i2s->dev, "I2S revision invalid\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int loongson_i2s_set_dai_sysclk(struct snd_soc_dai *dai, int 
>> clk_id,
>> +                       unsigned int freq, int dir)
>> +{
>> +    struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +
>> +    i2s->sysclk = freq;
>> +
>> +    return 0;
>> +}
>> +
>> +static int loongson_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int 
>> fmt)
>> +{
>> +    struct loongson_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +    u32 val;
>> +    int ret;
>> +
>> +    switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> +    case SND_SOC_DAIFMT_I2S:
>> +        break;
>> +    case SND_SOC_DAIFMT_RIGHT_J:
>> +        regmap_update_bits(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_MSB,
>> +                   I2S_CTRL_MSB);
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +
>> +    switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
>> +    case SND_SOC_DAIFMT_BC_FC:
>> +        break;
>> +    case SND_SOC_DAIFMT_BP_FC:
>> +        /* Enable master mode */
>> +        regmap_update_bits(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_MASTER,
>> +                   I2S_CTRL_MASTER);
>> +        if (i2s->rev_id == 1) {
>> +            ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>> +                        LS_I2S_CTRL, val,
>> +                        val & I2S_CTRL_CLK_READY,
>> +                        10, 500000);
>> +            if (ret < 0)
>> +                dev_warn(dai->dev, "wait BCLK ready timeout\n");
>> +        }
>> +        break;
>> +    case SND_SOC_DAIFMT_BC_FP:
>> +        /* Enable MCLK */
>> +        if (i2s->rev_id == 1) {
>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>> +                       I2S_CTRL_MCLK_EN,
>> +                       I2S_CTRL_MCLK_EN);
>> +            ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>> +                        LS_I2S_CTRL, val,
>> +                        val & I2S_CTRL_MCLK_READY,
>> +                        10, 500000);
>> +            if (ret < 0)
>> +                dev_warn(dai->dev, "wait MCLK ready timeout\n");
>> +        }
>> +        break;
>> +    case SND_SOC_DAIFMT_BP_FP:
>> +        /* Enable MCLK */
>> +        if (i2s->rev_id == 1) {
>> +            regmap_update_bits(i2s->regmap, LS_I2S_CTRL,
>> +                       I2S_CTRL_MCLK_EN,
>> +                       I2S_CTRL_MCLK_EN);
>> +            ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>> +                        LS_I2S_CTRL, val,
>> +                        val & I2S_CTRL_MCLK_READY,
>> +                        10, 500000);
>> +            if (ret < 0)
>> +                dev_warn(dai->dev, "wait MCLK ready timeout\n");
>> +        }
>> +
>> +        /* Enable master mode */
>> +        regmap_update_bits(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_MASTER,
>> +                   I2S_CTRL_MASTER);
>> +        if (i2s->rev_id == 1) {
>> +            ret = regmap_read_poll_timeout_atomic(i2s->regmap,
>> +                        LS_I2S_CTRL, val,
>> +                        val & I2S_CTRL_CLK_READY,
>> +                        10, 500000);
>> +            if (ret < 0)
>> +                dev_warn(dai->dev, "wait BCLK ready timeout\n");
>> +        }
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct snd_soc_dai_ops loongson_i2s_dai_ops = {
>> +    .trigger    = loongson_i2s_trigger,
>> +    .hw_params    = loongson_i2s_hw_params,
>> +    .set_sysclk    = loongson_i2s_set_dai_sysclk,
>> +    .set_fmt    = loongson_i2s_set_fmt,
>> +};
>> +
>> +static int loongson_i2s_dai_probe(struct snd_soc_dai *cpu_dai)
>> +{
>> +    struct loongson_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
>> +
>> +    snd_soc_dai_init_dma_data(cpu_dai, &i2s->playback_dma_data,
>> +                  &i2s->capture_dma_data);
>> +    snd_soc_dai_set_drvdata(cpu_dai, i2s);
>> +
>> +    return 0;
>> +}
>> +
>> +struct snd_soc_dai_driver loongson_i2s_dai = {
>> +    .name = "loongson-i2s",
>> +    .probe = loongson_i2s_dai_probe,
>> +    .playback = {
>> +        .stream_name = "CPU-Playback",
>> +        .channels_min = 1,
>> +        .channels_max = 2,
>> +        .rates = SNDRV_PCM_RATE_8000_96000,
>> +        .formats = LOONGSON_I2S_FORMATS,
>> +    },
>> +    .capture = {
>> +        .stream_name = "CPU-Capture",
>> +        .channels_min = 1,
>> +        .channels_max = 2,
>> +        .rates = SNDRV_PCM_RATE_8000_96000,
>> +        .formats = LOONGSON_I2S_FORMATS,
>> +    },
>> +    .ops = &loongson_i2s_dai_ops,
>> +    .symmetric_rate = 1,
>> +};
>> +
>> +static int i2s_suspend(struct device *dev)
>> +{
>> +    struct loongson_i2s *i2s = dev_get_drvdata(dev);
>> +
>> +    regcache_cache_only(i2s->regmap, true);
>> +
>> +    return 0;
>> +}
>> +
>> +static int i2s_resume(struct device *dev)
>> +{
>> +    struct loongson_i2s *i2s = dev_get_drvdata(dev);
>> +    int ret;
>> +
>> +    regcache_cache_only(i2s->regmap, false);
>> +    regcache_mark_dirty(i2s->regmap);
>> +    ret = regcache_sync(i2s->regmap);
>> +
>> +    return ret;
>> +}
>> +
>> +const struct dev_pm_ops loongson_i2s_pm = {
>> +    SET_SYSTEM_SLEEP_PM_OPS(i2s_suspend, i2s_resume)
>> +};
>> diff --git a/sound/soc/loongson/loongson_i2s.h 
>> b/sound/soc/loongson/loongson_i2s.h
>> new file mode 100644
>> index 000000000000..52788f6a94ad
>> --- /dev/null
>> +++ b/sound/soc/loongson/loongson_i2s.h
>> @@ -0,0 +1,71 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * ALSA I2S interface for the Loongson platform
>> + *
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + * Author: Yingkun Meng <mengyingkun@loongson.cn>
>> + */
>> +
>> +#ifndef _LOONGSON_I2S_H
>> +#define _LOONGSON_I2S_H
>> +
>> +#include <linux/regmap.h>
>> +#include <sound/dmaengine_pcm.h>
>> +
>> +/* I2S Common Registers */
>> +#define LS_I2S_VER    0x00 /* I2S Version */
>> +#define LS_I2S_CFG    0x04 /* I2S Config */
>> +#define LS_I2S_CTRL    0x08 /* I2S Control */
>> +#define LS_I2S_RX_DATA    0x0C /* I2S DMA RX Address */
>> +#define LS_I2S_TX_DATA    0x10 /* I2S DMA TX Address */
>> +
>> +/* 2K2000 I2S Specify Registers */
>> +#define LS_I2S_CFG1    0x14 /* I2S Config1 */
>> +
>> +/* 7A2000 I2S Specify Registers */
>> +#define LS_I2S_TX_ORDER    0x100 /* TX DMA Order */
>> +#define LS_I2S_RX_ORDER 0x110 /* RX DMA Order */
>> +
>> +/* Loongson I2S Control Register */
>> +#define I2S_CTRL_MCLK_READY    (1 << 16) /* MCLK ready */
>> +#define I2S_CTRL_MASTER        (1 << 15) /* Master mode */
>> +#define I2S_CTRL_MSB        (1 << 14) /* MSB bit order */
>> +#define I2S_CTRL_RX_EN        (1 << 13) /* RX enable */
>> +#define I2S_CTRL_TX_EN        (1 << 12) /* TX enable */
>> +#define I2S_CTRL_RX_DMA_EN    (1 << 11) /* DMA RX enable */
>> +#define I2S_CTRL_CLK_READY    (1 << 8)  /* BCLK ready */
>> +#define I2S_CTRL_TX_DMA_EN    (1 << 7)  /* DMA TX enable */
>> +#define I2S_CTRL_RESET        (1 << 4)  /* Controller soft reset */
>> +#define I2S_CTRL_MCLK_EN    (1 << 3)  /* Enable MCLK */
>> +#define I2S_CTRL_RX_INT_EN    (1 << 1)  /* RX interrupt enable */
>> +#define I2S_CTRL_TX_INT_EN    (1 << 0)  /* TX interrupt enable */
>> +
>> +#define LS_I2S_DRVNAME        "loongson-i2s"
>> +
>> +struct loongson_dma_data {
>> +    dma_addr_t dev_addr;        /* device physical address for DMA */
>> +    void __iomem *order_addr;    /* DMA order register */
>> +    u32 irq;            /* DMA irq */
>> +};
>> +
>> +struct loongson_i2s {
>> +    struct device *dev;
>> +    union {
>> +        struct snd_dmaengine_dai_dma_data playback_dma_data;
>> +        struct loongson_dma_data tx_dma_data;
>> +    };
>> +    union {
>> +        struct snd_dmaengine_dai_dma_data capture_dma_data;
>> +        struct loongson_dma_data rx_dma_data;
>> +    };
>> +    struct regmap *regmap;
>> +    void __iomem *reg_base;
>> +    u32 rev_id;
>> +    u32 clk_rate;
>> +    u32 sysclk;
>> +};
>> +
>> +extern const struct dev_pm_ops loongson_i2s_pm;
>> +extern struct snd_soc_dai_driver loongson_i2s_dai;
>> +
>> +#endif
>> diff --git a/sound/soc/loongson/loongson_i2s_pci.c 
>> b/sound/soc/loongson/loongson_i2s_pci.c
>> new file mode 100644
>> index 000000000000..6dcfb17d3276
>> --- /dev/null
>> +++ b/sound/soc/loongson/loongson_i2s_pci.c
>> @@ -0,0 +1,171 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// loongson_i2s_pci.c -- Loongson I2S controller driver
>> +//
>> +// Copyright (C) 2023 Loongson Technology Corporation Limited
>> +// Author: Yingkun Meng <mengyingkun@loongson.cn>
>> +//
>> +
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/acpi.h>
>> +#include <linux/pci.h>
>> +#include <sound/soc.h>
>> +#include "loongson_i2s.h"
>> +#include "loongson_dma.h"
>> +
>> +static bool loongson_i2s_wr_reg(struct device *dev, unsigned int reg)
>> +{
>> +    switch (reg) {
>> +    case LS_I2S_CFG:
>> +    case LS_I2S_CTRL:
>> +    case LS_I2S_RX_DATA:
>> +    case LS_I2S_TX_DATA:
>> +    case LS_I2S_CFG1:
>> +        return true;
>> +    default:
>> +        return false;
>> +    };
>> +}
>> +
>> +static bool loongson_i2s_rd_reg(struct device *dev, unsigned int reg)
>> +{
>> +    switch (reg) {
>> +    case LS_I2S_VER:
>> +    case LS_I2S_CFG:
>> +    case LS_I2S_CTRL:
>> +    case LS_I2S_RX_DATA:
>> +    case LS_I2S_TX_DATA:
>> +    case LS_I2S_CFG1:
>> +        return true;
>> +    default:
>> +        return false;
>> +    };
>> +}
>> +
>> +static bool loongson_i2s_volatile_reg(struct device *dev, unsigned 
>> int reg)
>> +{
>> +    switch (reg) {
>> +    case LS_I2S_CFG:
>> +    case LS_I2S_CTRL:
>> +    case LS_I2S_RX_DATA:
>> +    case LS_I2S_TX_DATA:
>> +    case LS_I2S_CFG1:
>> +        return true;
>> +    default:
>> +        return false;
>> +    };
>> +}
>> +
>> +static const struct regmap_config loongson_i2s_regmap_config = {
>> +    .reg_bits = 32,
>> +    .reg_stride = 4,
>> +    .val_bits = 32,
>> +    .max_register = LS_I2S_CFG1,
>> +    .writeable_reg = loongson_i2s_wr_reg,
>> +    .readable_reg = loongson_i2s_rd_reg,
>> +    .volatile_reg = loongson_i2s_volatile_reg,
>> +    .cache_type = REGCACHE_FLAT,
>> +};
>> +
>> +static int loongson_i2s_pci_probe(struct pci_dev *pdev,
>> +                  const struct pci_device_id *pid)
>> +{
>> +    const struct fwnode_handle *fwnode = pdev->dev.fwnode;
>> +    struct loongson_dma_data *tx_data, *rx_data;
>> +    struct loongson_i2s *i2s;
>> +    int ret;
>> +
>> +    if (pcim_enable_device(pdev)) {
>> +        dev_err(&pdev->dev, "pci_enable_device failed\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
>> +    if (!i2s)
>> +        return -ENOMEM;
>> +
>> +    i2s->rev_id = pdev->revision;
>> +    i2s->dev = &pdev->dev;
>> +    pci_set_drvdata(pdev, i2s);
>> +
>> +    ret = pcim_iomap_regions(pdev, 1 << 0, dev_name(&pdev->dev));
>> +    if (ret < 0) {
>> +        dev_err(&pdev->dev, "iomap_regions failed\n");
>> +        return ret;
>> +    }
>> +    i2s->reg_base = pcim_iomap_table(pdev)[0];
>> +    i2s->regmap = devm_regmap_init_mmio(&pdev->dev, i2s->reg_base,
>> +                        &loongson_i2s_regmap_config);
>> +    if (IS_ERR(i2s->regmap)) {
>> +        dev_err(&pdev->dev, "regmap_init_mmio failed\n");
>> +        return PTR_ERR(i2s->regmap);
>> +    }
>> +
>> +    tx_data = &i2s->tx_dma_data;
>> +    rx_data = &i2s->rx_dma_data;
>> +
>> +    tx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_TX_DATA;
>> +    tx_data->order_addr = i2s->reg_base + LS_I2S_TX_ORDER;
>> +
>> +    rx_data->dev_addr = (dma_addr_t)i2s->reg_base + LS_I2S_RX_DATA;
>> +    rx_data->order_addr = i2s->reg_base + LS_I2S_RX_ORDER;
>> +
>> +    tx_data->irq = fwnode_irq_get_byname(fwnode, "tx");
> 
> Smatch detects that tx_data->irq and rx_data->irq are of type 
> u32(unsigned) so they can never be negative.
> 
>> +    if (tx_data->irq < 0) {
>              ^^^^^^^^ This can never be true.
> 
> Should irq be of type 'int' instead?
> 
>> +        dev_err(&pdev->dev, "dma tx irq invalid\n");
>> +        return tx_data->irq;
>> +    }
>> +
>> +    rx_data->irq = fwnode_irq_get_byname(fwnode, "rx");
>> +    if (rx_data->irq < 0) {
>              ^^^ Same problem here.
> 
> Should irq

Should 'irq' be of type int instead?

As fwnode_irq_get_byname() returns a integer.

Thanks,
Harshit

>> +        dev_err(&pdev->dev, "dma rx irq invalid\n");
>> +        return rx_data->irq;
>> +    }
>> +
>> +    device_property_read_u32(&pdev->dev, "clock-frequency", 
>> &i2s->clk_rate);
>> +    if (!i2s->clk_rate) {
>> +        dev_err(&pdev->dev, "clock-frequency property invalid\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>> +
>> +    if (i2s->rev_id == 1) {
>> +        regmap_write(i2s->regmap, LS_I2S_CTRL, I2S_CTRL_RESET);
>> +        udelay(200);
>> +    }
>> +
>> +    ret = devm_snd_soc_register_component(&pdev->dev,
>> +                          &loongson_i2s_component,
>> +                          &loongson_i2s_dai, 1);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "register DAI failed %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct pci_device_id loongson_i2s_ids[] = {
>> +    { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a27) },
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(pci, loongson_i2s_ids);
>> +
>> +static struct pci_driver loongson_i2s_driver = {
>> +    .name = "loongson-i2s-pci",
>> +    .id_table = loongson_i2s_ids,
>> +    .probe = loongson_i2s_pci_probe,
>> +    .driver = {
>> +        .owner = THIS_MODULE,
>> +        .pm = pm_sleep_ptr(&loongson_i2s_pm),
>> +    },
>> +};
>> +module_pci_driver(loongson_i2s_driver);
>> +
>> +MODULE_DESCRIPTION("Loongson I2S Master Mode ASoC Driver");
>> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
>> +MODULE_LICENSE("GPL");
> 
> Thanks,
> Harshit
