Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6C6C4717
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCVJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCVJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:57:19 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2137.outbound.protection.outlook.com [40.107.8.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB21B327
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAOzu3GselkJxVMn6haAGBr5WOr6KR4Nt5rOfRCws4IY3GOXic2X8jaZrBxgfOszIYXaTGP1PdG8aUpOkvT93MoRBp5LtegCNf0NEk4ve1WquyoXhke6d/3SN3HfdDX5ihDUrSVYpWQAzJd/dk7qSse12U9b/zKHncnfqERDny+3O4KJ4+qZjW/RhdOPEQUjIstO18pFb/FY75v8HMgYtOp6OZWVtqs18mMa2gdn2F/r237XWFnhyCYk+q0WbQx7L0KiZglA//ujy9oVoPsDDffBxh1/IlbKORuO9OhpOfhsZyRsLMwjtDlSD91WevbVxWrN81VtfdKjdQ5h6DgI1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVI8LlK1BRvqHHqKkZx8WnYgSOZGtB3gMBw24Hh2dVg=;
 b=i5OJsDOydpb2Z6thSkbtiqMcxJaU/Xd9zjh7U3M3mJtz4FTrwQfNi2uFxl8fYSskRn28AvJ91ggOr4uORfCS2MAeWA9tbM5gL6S9HI+wcxXLVnPsuw8KYjGy+IiEdzPZwhfGeUw5vwvNmW4gyhmVaVUWgBdoLKOHzXcx1tD/BF4zdMXVVrlnRopFXMrESMz76Ty49+XI+DIQo1hglEczAtlJZL66+h3sqYfi+/0ZuA5O4xuH5MIZO1YpSInpzZXBHAZiEvB5IiGKQqCDvdhuBSFCjWTowiFD+go31eXnI+Zie40tef0nsKE4VJZMg359rnYHx1l9q4rnSQgIvGq33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVI8LlK1BRvqHHqKkZx8WnYgSOZGtB3gMBw24Hh2dVg=;
 b=Ef8YGaJlsG/HHjI3FmoCDQQkl1za70GCgJC4YAAtUJl662WCfeFZjhoOH4oUbwyVZPN9lAwtwrIrz3PAs/raHoVhfo/6m7SdBziLM7kA4i8smFex/czR6BIxAgog4vifTTjBiEWJi7JXB+GdTHS9VqCyxdpe0zF/9KKdBhU3fXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB7565.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 22 Mar
 2023 09:57:14 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2%3]) with mapi id 15.20.6222.010; Wed, 22 Mar 2023
 09:57:14 +0000
Message-ID: <07bdb54a-d5c8-ed3b-a1a4-8d43c27cac3b@kontron.de>
Date:   Wed, 22 Mar 2023 10:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Starting app on i.MX8MM M4 core from DDR via remoteproc
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
References: <0dcfbc49-d3db-cc4b-b5e1-8341dda672ec@kontron.de>
In-Reply-To: <0dcfbc49-d3db-cc4b-b5e1-8341dda672ec@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::39) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3255441c-8f48-4450-687a-08db2abbd024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpN2VkuyBNqRpYgSjfNPggOHmWH1tYdPh/YD9JCiBIvUbaya9zeqsFTIJzpqsmr9lYJVaXBYioJ40luC5L8tjZ5Klti1K9LkHupcMxY5wiX+lI/VU4BpZzhBYHlkGUYKpHqXJXoF82DCZRGfnsnl2a1TX8SuchgjQeDLDE+/fRfh/oidZ5MfYcWNrDsK4mvhpmCV8L5fUy3N4FVze5JkQUUu+WG2AkxjYvb0akHWu+oY/WZWycRXFoVH+eyXMs8LIN1k/WFpHgAO04zF/ek/OuyVSCIVhj/Qr6WxS8IZrSpahmXRPtwWazg7X1lIY/0UvhjTCO5PZ5fjb0giVif2QGZ/U4M4G77kWA5aXo7ecJOU9MC3N4Zty4YICw1hZ8lCVT2fw0JnnrJlpJIBxxcnTRMHfEM87+aiy+rvye6F83RBcJ+xHOjrND9AdNBHbQPCCp3lmwm7T49V9FYQg3kQZQ/WDf2Kc8PPcN7fGPrb6REUAgWKgNwoOD/Xp99N4XK4vAhYDh9b223cGkrl0JnwUwOLq9ISnuSu77WMvdJXE3p9jNU2Gd7nr/y9TempDgO3+bBde/9Pa1wckf61i2+YGk/sZpF2IzAgeqjcmcUcUloe19JBbbKXSopBRfvU96Q5O3aNIFp+Y73t+pGTSPvM9wFbMdiRB8zZl1CCvK8vasAcyylSk4hMFGhIEc7eTiLGG/yIhfhz2V28+Dv7Ky45H3bQX2Un93z09omMAJmzwag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199018)(31686004)(38100700002)(31696002)(86362001)(8936002)(5660300002)(66946007)(36756003)(66476007)(66556008)(8676002)(41300700001)(316002)(6506007)(53546011)(6512007)(110136005)(478600001)(966005)(2616005)(6486002)(4744005)(2906002)(44832011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2RuM1RGcHduSTBGRUNPeTQzRkZvVzVQaFBxSEVIYnBqZEt6YTBiK0xXV3pM?=
 =?utf-8?B?YldNL01PSzBtOC9QNFFBQjM3QWxaa2hNL2ttd3VWaVlsdEhTRk5yMERyeHcz?=
 =?utf-8?B?cmtjNC9VQ0tqWVZyM1JsdkM5eDB1NitxcmpqSHF2WUd0ZUJKL0xOY0kwUTBI?=
 =?utf-8?B?bzA0Y1FyRDJrL21PM3d3QmtBdExJZS9ETzNwU0ZDK0JJYXorVTJocUpLWU9M?=
 =?utf-8?B?YmMwT2pmSGxoQTRjMjR4dU1uZ2RmRnk2elByTGZkR3l0UHZ3cE9CNU5qR3ha?=
 =?utf-8?B?bUxYZ0dOZEJkRTJON2xxVVJXYWtRWG04NmxtdDdjRnRUMFV6ZEw1d0NGZkt6?=
 =?utf-8?B?Z1lndDFDckJBR3Q5QlBoSnQxZ3pRaFFtR0VTd3B5UmQ1aUxqQkFuS2dFaGs3?=
 =?utf-8?B?OUh6K1V3QXRlMDlWY3VXbGk1cytVb29JWnc2dWN2UGZRbHhMSklGci92cklW?=
 =?utf-8?B?ZEdxUm5aSUg0MmtxUjM0S3F4MDJPUXBaZXR6YmpOVUVCZUliZmEyOEFSMEtu?=
 =?utf-8?B?MkJ0ME44QjBLMzg1NzB1a2hURHdDeGtuYzVXUG5lR2JPbkc0YUVXRUh3TTEw?=
 =?utf-8?B?K1VvZm9JS2VOVUZCdGdlTm1hOG9QbWRGUEFibnFNcXppY1BCc1JNQTlmUVVQ?=
 =?utf-8?B?TDY2ZWpkMjBNUEtpREYraE96NWZIMHRsc0NtTmVsN2dOUjNueXBsN0prU0tI?=
 =?utf-8?B?ak5GbXFCSzNJK0RoaUlWbTBySDdOaWcxVVhCUUUyM3ZqSG5rcXlQbDN3MHZH?=
 =?utf-8?B?aDJ2M09Nc3Bhd1FLQ0pxemJuRVdlWjFkbGRSS29sSGptd2R2cksvQnBHQlRz?=
 =?utf-8?B?dE5hMUd4SGM0WHNLb2lBZlZSNXV0dlQvcXA3R1A3c002V0tHZmtjNXB4b3NZ?=
 =?utf-8?B?c2c5K2c1M2psVjBjNWVsK2w3ZUZnUTI1NFZGY3VNY3RxenU5YXI0ZWdOTmlr?=
 =?utf-8?B?enBCYVFFYTRFRUhzL0pMSElyMFlaOVlCdU13cGd6Ym56bVNpN0JsdUhUZEt3?=
 =?utf-8?B?MUZSUWV5TjgxUi8vb2xlQ3ZPOWE5YlMzL2UrSll6QWNaVXAwTjlJZmkrb1Fo?=
 =?utf-8?B?QTVoSUp6QVp6ODg0NnFEbkxBenE2RHo1SEhyMGZlbnBZWDV4RkZwS3ZqVFJ1?=
 =?utf-8?B?ajlRYzVNbk44VVFPZHcvMkZXamZJcG9aa3lXQ3VBVHd3R3FTSlZZQ3JBeERU?=
 =?utf-8?B?dndWMjZuSEM1WFBqRGVlRDZPN25oNjhWMlhMNXpITHpVUWJWU3hvYVYrcTcr?=
 =?utf-8?B?aDNubDRvYVVBdEVCb0gxdUdkaXVSd3p6RzV4OXJPc3oveDR5alAvbWxYOGpD?=
 =?utf-8?B?YWZyUjIrOXNhU2xGUDNkbUpJQmJRK0txYzVPNmRCU0tFaVU0TTIxU3hQUDRL?=
 =?utf-8?B?eDNIdWlRbG1Nd2tWVmNtVkZqVS84TnJ2MUEwYnZLaFNrZkxJSytQdmRGMUZo?=
 =?utf-8?B?WFZmRkNVTUt2eWgwSWJnb3FqWndWcmtTdTdodGo1WFFqTlJuOUV6MjlmbXhz?=
 =?utf-8?B?MkdpTG9RRU5YeDA4dndxWXlLN1ZsRXhaSWxWWVVNd2hQbnZ1RGptQmZIN2l2?=
 =?utf-8?B?ZWdQVHR5QzloL0pQa29YYmFLanVoV3dZTm1GSjdCUndyMWEvN2g2Y2E5TDNG?=
 =?utf-8?B?VHpUeGQrTFhseWZGUkhEaXZpWTYzaGk4bUx6dHBNT1pEZkp4VTN2emRldGVl?=
 =?utf-8?B?Qm5GRjJMc1hmMlBRc2Q4T2ZxVHF1eVRFM3kyWFF1a0o3em5IdGh6US91V1FR?=
 =?utf-8?B?SklUYitma0tqcDl1YkpyMjJSNENzdWt1NndMREFFcmx6UGIveEx6WEZMcUp3?=
 =?utf-8?B?SlY4OFBCaGkvUlphUUVCQUpYNkxicS81eHQ4V2xkT0VwL21TUFRObUsxbFRi?=
 =?utf-8?B?dGNNOWhZS2hpOTk0ZkZrOEZ4ZUpqNnIvUjRyUFFQbDcwZy9FY1hQbjlBM1o3?=
 =?utf-8?B?YTRJeGIvRVJrbEVvZDExenVxUGxwTVpDNERURmxsNzlFTE14UjJIb3JEVGZx?=
 =?utf-8?B?RFU3SW1yWlFlV3hpdG85aWlGRytQR2lTQWxYR2EyVlJiTFBZdVIwNkdrM2J3?=
 =?utf-8?B?SUc5bHhTN3hMVmsvWU8xeEIzVjRlSDZoMFB3Q2gwY3pETWFIMG14dFNKUXRE?=
 =?utf-8?B?YzhROUhPL3UrU05CWUp6Ylk3U3FqOEhVYmpwdmJiaFlaTkJONXVZODZ4RkNn?=
 =?utf-8?Q?JbCJ+6qoA3AqsbVZbb0MRcwpI+d5dTuVoBiaQELhq2ul?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3255441c-8f48-4450-687a-08db2abbd024
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 09:57:14.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMErJTEkTsW+QAnWTVqxJ97w4qQX98A60rtVPsydD2Rraf21x0E2ujl3Np1VN7MeB36OQ3MSqbloj6Ao3Sd2Ka8Ieu527NlsQ5aCVv50WVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7565
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.23 09:46, Frieder Schrempf wrote:
> Hello,
> 
> I'm having problems with running an application from DDR memory on the
> M4 core of an i.MX8MM using remoteproc in Linux.
> 
> * starting the app compiled for internal RAM from Linux works fine
> * starting the app compiled for DDR from U-Boot works fine
> * starting the app compiled for DDR from Linux doesn't show any output
> on the M4 debug UART
> 
> Below there is some more information on my setup. If anyone has an idea
> for debugging this, please let me know.

I just came across Peng's patches [1] that add support for firmware in
DDR. With this applied it seems to work now!

[1]
https://patchwork.kernel.org/project/linux-remoteproc/cover/20230209063816.2782206-1-peng.fan@oss.nxp.com/
