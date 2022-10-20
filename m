Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB23606861
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJTSpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJTSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:45:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA0133852
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:45:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KGwujn020010;
        Thu, 20 Oct 2022 17:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/ZWYIC87U4q9SvWUzFlM7DWudYp9MAoZiFUlCiZunzY=;
 b=vdbgE9v69MMGHHWPGAOIy8OjhidRltMYnq2PfUCSgjtfthhnNWTJ3JrFYB6j6jk4cZee
 o5riHgjicoWicT/q21BDDMJEbeSHGv3l630Oa3fENp52nd8Qqq4H7jhCxM68q9ZIr7TZ
 UNEFV3doIsq9nKuvNrit5kwfXA3VT4nY2MZuVZvax8asIYPrDvchioGP8iwILPjv6MTL
 LC0Edik/q34jwx51EId9uxeQU4kbTcWfbgqnm/79tGiDyHlvHPPkX6JX9FHRDmJ0c67t
 O0S6+6hYpxYG0VOBGcMj5s41f+mgI6g55d9x9HBPbwVIIbR/bx2LMCKUki2f3RVoiOBX Gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3p250-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 17:43:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KFVScu018212;
        Thu, 20 Oct 2022 17:43:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0t6nw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 17:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ0T/A0sS9LoAijUDA1C48Jrc49B5EhNtXmpQb+xY7RukCBOO4PTX7R+SW0oUOEq7QnTdER5/tX604Kxfngnaj+aeePK4AMqMLZOlGgCh3Tf/BnSo55mvPafIiCLQp/1PRVGO5He/RPvxFYCMvsD38nyUYWKGL5nfSOUJr66lZWSMo5mOivEXzDY7oUfg6Z02ZL5EL2jUHpl1klWFhI3zzmfDAReKtIW+9T1Aqj8KVtSZSysHHfxZkaj5mVQxkXHmQ8At8UQ2ok+DhcR77dLaRsKkXXEmWx+LcR6TqsjRqbfybsZ7XB2zWSijteJbW62dQ00rRmW9GVcT2g+9yb2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZWYIC87U4q9SvWUzFlM7DWudYp9MAoZiFUlCiZunzY=;
 b=Q+3hoZX8X8KjdgywvdqR6svU0aLMnu5UaAe10pSiFcCzLCH2FWO/W7iRmuSl0BZnWVHFMlnzwHkpcxSvjmJ4vp/Cm72Er6YSPDPmTT1KHG7PwQsmy6Ql2iuCEQ0pty5WozJeXCQ62u5za1f9swCWXpb6tQASD8swDn8AyGKrzPNGbNAAkdbeVEaCqvYgFVnQgK7Moh1hRipN4cmKOY17Gl6vmIuIcpB4PpCB6tf45Hw3wVM4uPqVTXUuLo/zz/NFQ6xG4m79F220FMFRSMZwPyaam8PeDwZtU18Z6OydLsz6JydVLXfNn2+AOPO/+U2En5xEfUcNn9wn5vVXqrHgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZWYIC87U4q9SvWUzFlM7DWudYp9MAoZiFUlCiZunzY=;
 b=HmWjwFnRGGy3ukaiKZcNeAiPvBi7ONqeP9crmQeGNBr1XWjvhfOnEWRrFXFUiaRkdy9FYlHmDPb9XOvVtj1fBRcwVHkf1U0ROMCCpOgODYD6rThlX3XLL3i3uVQoGXm+YsR11P/ktZqZwd+C05gNRR8Kef0CSGXD/dFdquvIf2o=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN0PR10MB5983.namprd10.prod.outlook.com (2603:10b6:208:3c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 17:42:54 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 17:42:54 +0000
Message-ID: <68312622-0206-f456-146e-e242e36be04d@oracle.com>
Date:   Thu, 20 Oct 2022 10:42:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/4] vdpa: pass initial config to
 _vdpa_register_device()
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuT7O1xLrB9=eYHAtuHYdwbNXxqtC+Mh4qkWSkLM+QTjg@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuT7O1xLrB9=eYHAtuHYdwbNXxqtC+Mh4qkWSkLM+QTjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN0PR10MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 8178d179-d474-4520-00a4-08dab2c28431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pv/+Ktb3c78rg1TXt/zQqJb7OiX8lGJwqthO47JO6uu86ePqDGpjr+HMmE2e5a01tN2UEv0z4UC/CXAqtQTkIjEDDnzj7JZCXsTyt7++bESuAR+2/fqe9FIOBvByqxcdPjY28Ia8Chjc8BFsTkamxLJvcfxLhQCMHSTBnOZyyZFfXYuhF/xRT0gTqBseSEaKlh6CVkKFryN8oRjn4Y7GG2v35iYf6i1K95Makep4p2ostRvEAmCxvDv1wImtt3l3VItakCXKig3Xmaz8mv1Y16FPXUYCyNbUPrrqXz0X/ZhfjQmgrnfNZG9aJwKPatouR2hilweLClDYV/R4fVPNSLyb2ZopjYV4AZDRDyWsnexFB0ahV5Mp+UcwmesoSL3esB5Hpisg1btMzBPu/SEHt7J8CeS3XZRZ1hmfyTB1xVdgaQMjkXDzvIBESLzhxkuv+DHCt5V0CVwDUlpSujXKIxfOxWgySkM1OIl1rkpirHAJy/AW12Co045BGsug0MgD/nxZDFg2D4qo10xzGEaBg+d15cdDNRcJpjy/Cpp4F81gn+GHg66D9jAbh3HP4dAts3IZG8JDBtgYDBb8k9ssHB6pvCj48d/knrxu+hJeSNsssxsMEKxQF/NWtBqZ4uumhEjdc0lZ8xT51yFxuvMzKa7duJe8dJQAnSQKi+Riq0P/CP1SvrN92kKLo+uMDrMffvpcMormnINr9B+EaA+SDSDRJU6OdRpwK5n07zT3NiEFSjpR2G0R01C/XtXRIuuRS2TmDELh2W3h3nD/qBzJ0gmp5FzmHngS7xADhA+cLnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(6666004)(8676002)(36756003)(66476007)(6486002)(66946007)(66556008)(4326008)(316002)(186003)(38100700002)(478600001)(83380400001)(2906002)(2616005)(8936002)(6512007)(36916002)(41300700001)(53546011)(31696002)(6506007)(86362001)(5660300002)(26005)(31686004)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZRMVU0dUJqQnB1RWhXM29VUTlCWUM2MHk1QU1ER2srMTB6TVZTbWJOMEJu?=
 =?utf-8?B?cVpNU3QwcTJVRUtFWXZnRUQ4QTYzOFVab3ZWMzVJMG5nNUNvK3BGNmh5RmZC?=
 =?utf-8?B?LzVPMHJXNTdmeUFnUTdMaTV1VHN2VlZjWUhpNElVNnpINjVjdlpkZXF4SWJT?=
 =?utf-8?B?d3YyY0hhWVh2MGRZb0dkczFCZVYxQmRhWG0wazl1RGRUS08xeHhkUmN1UVpz?=
 =?utf-8?B?RlBxK3ZtcWpHTG16T0U4WVFRNU5KQkhoNTdZWkZ5SWpZNXd3QkJMSHg1Z2p3?=
 =?utf-8?B?Um41MGNJQTEyU3dyYmI3Y21QSm9TU2QyOFJqZU54cUZwdk9rK0YxbDNkaDNo?=
 =?utf-8?B?WmU5Sm8xK2NrdkplRi9EemRpbE0wWGV5bkVHYTdidUpMRHMrNmZhd2hFZmZp?=
 =?utf-8?B?UTJucWZVTEYzeWxSbGorekYweEl6TElzaDFYaG1HUVBTb3UxS0VNODEyL0RU?=
 =?utf-8?B?MVBjNlVPTUpzUURPL2hzU0x3ZnFjcFByanlJb0FTK1U4VXVCQ0d3aE8yZzJi?=
 =?utf-8?B?R1kycWFRSmU0R05BWlNkYlN3bkxqSncyRGF0V0I2aWx6dlVpdG5BcFdwSTg3?=
 =?utf-8?B?WVNxdVM3M2ZqTkhiNGYrQlV3aUdoSkRTR21GelBXZ3lZRHR4dkZOZFc2dExx?=
 =?utf-8?B?cnRYdklLQWMvTUR3d3kxb1AvWXVUZC9HUmsyNXhtNnhCS0NDMDh0MTVvSzBB?=
 =?utf-8?B?VUY1ajVIVDhjeW9WM1ZvY1V4UjJ5VEM3VDBnMlF2aVhDN1FSVzQ5VXhoa2Rq?=
 =?utf-8?B?TG1jeStSUUpTai8yYUU5Qi9zZE9zd2cyYmdmUzU1enYwd3VUSlVQQmxZcFRD?=
 =?utf-8?B?RER0ZGRjemtTcEJsUndHRms3Z1hUNDlTQTVSWHVQRjdmVEl3Y0oyMmJhN0Y1?=
 =?utf-8?B?MUNNSFhJZVRiSVl1MzJWMGFpQnpMN3lwTnF0d1pPanZ5cURuSHRiUk0xSElm?=
 =?utf-8?B?SFNkdDRwRnAwTlJ0U3pLZXZpeEJPK0ppNHlVVHkzT2MvcVZTZW1tNmxGUTZ1?=
 =?utf-8?B?U1J3dFpRWjJkVDZ5UFU2WEovZkpaeXVaUEhRU0ZJbEcrWExCdVRNUmZoMi9B?=
 =?utf-8?B?RlhYVDU0b2xMdmQxRmhFSnRDdU1xMU9UNkd3T0ZxNXNIM0NBOVFYNFNmaEZJ?=
 =?utf-8?B?Slh2MEZ5L095YmRQR3RBMnY5cXZ1YWIxRFdCTk5BZTNUUmhZSTMrTUVoZXhR?=
 =?utf-8?B?ejljK3puKzBCWjRHcmJpbFBBb2Q1TnZISkpKeGViM1JTaGlscm9ibmRzNEdD?=
 =?utf-8?B?bVZLK0lQN0lLdE9KK1JwSVNGRkI1eDAxWnJFQW5OMUkyUk5mYk9DRncyd0FR?=
 =?utf-8?B?Mmhhd3RNQ3lQZU5ISmFaOFlZcUhqWktGM0xJTUYwZGpQZlJaam9KN0ZnWS9V?=
 =?utf-8?B?dEJBV3o5cG54Zlo4U3BCcjBIZjdVSTlOaTh2bm1Yc0hDUS9WcmZ5b2tIN3h3?=
 =?utf-8?B?Ym85eENONEFrczFudEFDSWpnRDYyOEVZdE1lV3dQakZBWjRkQTAzL0RUT1Jr?=
 =?utf-8?B?dGVkc1FEWXQ1WDFnWk5WRUVGb1dBcGpsUDlzMTJ6bWx5Y0w3bFdPa0ZjS1ds?=
 =?utf-8?B?Y0sxTmNQUkQ4UzBUdDhWMm1xazhBaGFZWklTM1NOWjV1S2hTMVZlZEwvZkgy?=
 =?utf-8?B?S3FtNDRiQWVzRmRzM1k4STJFVTBpdEhQREQ1dGF3azVxY09ZUmxITk1PclF2?=
 =?utf-8?B?Zm9BVjV5UmJEYUNYNjlwUDhtcUZWZVBRQzNyVnhVU3BPZmN3ZDVETlBPa2NU?=
 =?utf-8?B?WnBsbW1TVldYT1M3V3FhMU9Ka0Z0cTJITnFTWlZoeWx3WEpNODZvaFZUdVVz?=
 =?utf-8?B?OEllN0NrZFh3NTdoM05GSTFZR21ydEY3SThPaUdqTkx5OTczblRjc2d5NlZ5?=
 =?utf-8?B?dzdienhyeUI1bDFiZ2JhUjdyZTI3NFpmTVlJQlZTV1N6MVlUV3l5RWk4aFhw?=
 =?utf-8?B?dGt0WHZOdTRoMC9SSzFFOGtOZENuODlQUmxuenNGSzMvNnRBekhsRkx3eG1p?=
 =?utf-8?B?UGo1ZjMyZlJjY0FaR3VQejRBd3Z2bXFrV1UxNWhiYjJYcjZaUGtBbDIzcm52?=
 =?utf-8?B?dUNuK3M5NlAySGdQclVicDZyVUczc2JEYjkxYldMU3ZncGpJZGFhUkcrSjhw?=
 =?utf-8?Q?ry2wERSF0MdLdxJ1wRSuSZrRm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8178d179-d474-4520-00a4-08dab2c28431
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 17:42:54.4111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UogaEl1YvHa+HIkCgtTw2+KF8jKKy2MHNvwFBX6J8SpPq+mWkQbwUxibfQLypMi0p6dynpaB3hG3CFqnGzUG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5983
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_09,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210200106
X-Proofpoint-ORIG-GUID: JRM_4OJSqNQQhjPEaU-hni0ohoYf3Fo5
X-Proofpoint-GUID: JRM_4OJSqNQQhjPEaU-hni0ohoYf3Fo5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2022 10:20 PM, Jason Wang wrote:
> On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Just as _vdpa_register_device taking @nvqs as the number of queues
> I wonder if it's better to embed nvqs in the config structure.
Hmmm, the config structure is mostly for containing the configurables 
specified in the 'vdpa dev add' command, while each field is 
conditionally set and guarded by a corresponding mask bit. If @nvqs 
needs to be folded into a structure, I feel it might be better to use 
another struct for holding the informational fields (i.e. those are 
read-only and always exist). But doing this would make @nvqs a weird 
solo member in that struct with no extra benefit, and all the other 
informational fields shown in the 'vdpa dev show' command would be 
gotten from the device through config_ops directly. Maybe do this until 
another read-only field comes around?

>
>> to feed userspace inquery via vdpa_dev_fill(), we can follow the
>> same to stash config attributes in struct vdpa_device at the time
>> of vdpa registration.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>>   drivers/vdpa/vdpa.c                  | 15 +++++++++++----
>>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>>   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 ++-
>>   include/linux/vdpa.h                 |  3 ++-
>>   8 files changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index f9c0044..c54ab2c 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -771,7 +771,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>>          else
>>                  ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
>>
>> -       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
>> +       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring, config);
>>          if (ret) {
>>                  put_device(&adapter->vdpa.dev);
>>                  IFCVF_ERR(pdev, "Failed to register to vDPA bus");
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 9091336..376082e 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -3206,7 +3206,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>          mlx5_notifier_register(mdev, &ndev->nb);
>>          ndev->nb_registered = true;
>>          mvdev->vdev.mdev = &mgtdev->mgtdev;
>> -       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
>> +       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1, add_config);
>>          if (err)
>>                  goto err_reg;
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index febdc99..566c1c6 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -215,11 +215,16 @@ static int vdpa_name_match(struct device *dev, const void *data)
>>          return (strcmp(dev_name(&vdev->dev), data) == 0);
>>   }
>>
>> -static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>> +static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
>> +                                 const struct vdpa_dev_set_config *cfg)
>>   {
>>          struct device *dev;
>>
>>          vdev->nvqs = nvqs;
>> +       if (cfg)
>> +               vdev->vdev_cfg = *cfg;
>> +       else
>> +               vdev->vdev_cfg.mask = 0ULL;
> I think it would be nice if we can convert eni to use netlink then we
> don't need any workaround like this.
Yes, Alibaba ENI is the only consumer of the old vdpa_register_device() 
API without being ported to the netlink API. Not sure what is needed but 
it seems another work to make netlink API committed to support a legacy 
compatible model?

-Siwei

>
> Thanks
>

