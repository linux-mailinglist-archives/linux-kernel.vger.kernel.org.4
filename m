Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3395E5F799A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJGOT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJGOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:19:55 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66902DFF5;
        Fri,  7 Oct 2022 07:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqsccWxvwjTdbpTSnAer/IlSAJdiFWhL0PLeOHQccGUxBnKUXIAanAYuK3Cph3WWfiOD964FpBDYNG2uqxXOulicJI6b0MpvCTUEq0n0/oSzqVgfyjI5zkwl52lat+17HhuD6awRiEpqic0rWFvMBRy4sTU3kW0JIrtKbjkfxr8G7zsUXM+h6iKqd0QsJdn6e37NnRN34xI/VLDqp/BDPVS/6kaPfDZu9H0uHsVMXCO8cQn0MM37x3h5akPZRTvJxpyioHT6FWkhF2Vq4L1tWTIzm3uyRAavk6kAgEOCPOj61U73NfrI2UobS1CccuhFPzWH2wO4gQxrF7N9pbEBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXjfp87XUL76K16M566QhmnVocCtAUOxRhONpfn6Z4A=;
 b=aAR39GuvdownvJso+PmNvJjpY0psfeuBr0y+5tjWFdyxlm11pHkBV/dfffqYeSRyjZGwXu4uoQ5miRVBI9FdJprUT/vitMUul4wMMo8HePNc7k1eoyQ14jAFjPDo4nWoG6zcTgIzhQfZgsLPX1DYXaNtrjiTKHEWOf2eLQsShpKmmQ2BtzyVarS5F607kukphShVydM6iQ6KTADwfWMa0JyUQ32F+mS9QipdWzJLML+z3W5/vy02iy4MfQx3hyGArdnrOtZpwaUWr7cfrQ6ky23nLRr4Rs4Ayfua8cdKXQL13Wga455XOe49J5cjHsvLQvxwopPe60m79DmN5TSIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXjfp87XUL76K16M566QhmnVocCtAUOxRhONpfn6Z4A=;
 b=f8p5at23XHaIfZBCL5HSBDLQAEFDz2OGj5p6YVJ/yifA/L9d6nM3Ma1BecHytXVHYKtw6wvaZKmiv3Ndyadjmxo5yoqnWQWHkr5QPfHA2rfWZOarBwXoBsVcJ2SkRxqjphxBt5fYuDloYi8LEWoE1zWN9bq74MgnT7Q81wvHSTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by AM8PR04MB7922.eurprd04.prod.outlook.com (2603:10a6:20b:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Fri, 7 Oct
 2022 14:19:43 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::21c0:915e:4429:33fe]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::21c0:915e:4429:33fe%3]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 14:19:43 +0000
Message-ID: <0047b375-e7b8-a67d-82dd-112f44836bb2@nxp.com>
Date:   Fri, 7 Oct 2022 19:49:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <YyHrT6q9fockgPjl@kroah.com>
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
In-Reply-To: <YyHrT6q9fockgPjl@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:EE_|AM8PR04MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 208f676a-b4a9-462f-0e34-08daa86efae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CK8b4ws2G6zYn3LcP8G/iBR+saC+z4DcXHbpTSnegO6h058UAk09v6mEvkI34KZw5NKtrY1pP17wAuJwNq7J4G8WgaxwVi936co/L8fSXfFNANtznU40plKv+i6EGSVTkKrqriD8joTqAnv5g2XnR+7vC8pSj2N+j+fbDa2NW7fkt9Ydigm6DpN5p1xLUdqUmSLbybmBWF8PjfaCkkFfSYGTn9ajWG3tTGPCXWUSiK1wXCYS1sN07p7Vvn1qeQPDSvwNAx2pkdqbZy4/YhsXvUARf6C3QXa6kQsVVocvewJD2n2/Xbfzj6f9eLlpmPz1q5Q/ogUjeLof+HJKV9/iqZEJVKYqtDtO49cuL1IwO3Xqez7sXvTxeyl7RE2e2E6X3Ly6jRFrQFs7saLi9T370se9BekkARewOej7rxaT9H1PK3rXy+e0Zxso2CGZVmgQyHYLOkxR0YZ7IvN3xPRuBGLi6s3QrcnSCX/D+cDg5BFqbK1+wFcykU4bGS8xc8o/WPuJ2y37uIP2Ob1rsQRY1KyuvlPncRLWHtRR4BZF0p6+2jQmzIr44Iw1djp9s0Wj9p8gFj6A2+0wweOXartMjhH9Hbbij+R3AWVKRlMoZ+aNPf0d8o8g6uv6vmhsfjyKLVTwh6hEXe6BkGuI85WjlAobbc77dTWW9NCjes6rId9XK5DR/1SJN5unGtbwdL9ksrW82xSLXReMSw4PJA++YNYaVe/B1GRVbJoibJTp19H3V3Ad+0TJqI1uxCZS5IlA0Uai/MbdOfiwyuQzt7312UDuIGq4Nnh7o7D9cX2f76DUHjvdvsMd8HPtPL8Zh5Ab+5lBsUcNz82gZcvDiodwqC+X156bmnjxXuKOXgtFGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199015)(6486002)(316002)(6916009)(6666004)(8676002)(4326008)(66946007)(478600001)(66476007)(31686004)(66556008)(8936002)(38100700002)(38350700002)(6506007)(26005)(41300700001)(7416002)(186003)(6512007)(2616005)(4744005)(2906002)(53546011)(44832011)(55236004)(52116002)(86362001)(5660300002)(83380400001)(36756003)(31696002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjZlUWZsQjB3OVBpV0VwUVcwOFRiSG5BTHFjL0p5cjlydjRDUWdqUWQ4YUlz?=
 =?utf-8?B?ZzI2MkF1RVk4M3pTVnNyV0RYa1RxMFZ0b2hadjQ1RkZPU3pWRHZTQmJRT2gw?=
 =?utf-8?B?T0tTUnVOdEJNbThzRlRtc0QzUEp2QTA1VDZOSjJOWE9XUDJPRHdkR1NXOVhX?=
 =?utf-8?B?TFdvclhXWE5HamxDd2duODRmeEhlTmpoNWVwdVVzOVl3bnl5eGtsWHZ0eExx?=
 =?utf-8?B?ZDFoakkzbnNKb0VoY1hnMi8yb3poMC9mRzBONjRJV0srMTBHSTBubnRsYy9C?=
 =?utf-8?B?ZTEyRHZyTTdHczljc1hKYis3c1Iwek93ZWk5RzR2QlkwZUplRXJHV3BucHF2?=
 =?utf-8?B?SDZPZEZMTHZCSzVmcFRsWmR2ZTNSRG5CS3FpMjZQR2dsa3pldWI1c1o0S1Bh?=
 =?utf-8?B?ZW1HM0h0WlVIUGNkK0w4bm0xQ1lKbE02czU3QndYbDl1TGZ4MmpsaEVLQzZw?=
 =?utf-8?B?SSs5VmFkOXlqaUlna3dmYnMxRVZWMTZWSzd0VnpNQzc0TWlpUlFBdlMxSVBz?=
 =?utf-8?B?U0wzQzB2VnhrQmFuemlCa0pEeHBIL0k1ai9RME00KzNPZzd6Q1pDNm5OT3Ra?=
 =?utf-8?B?NHhCajNPTmtSekprK3VqSXdUaFVQYVBJTXZWdWFLbkp6VHcxUmN2OFdzMGp1?=
 =?utf-8?B?VFRlMk9YRjB4Rzh6dExZOGNxWUprWkxXbzQvSjhnK3dhKyswd3pBTUNjSmNw?=
 =?utf-8?B?OHpiMGVNL1JnU0l2ajdLMDRWQ1p0SGpGQW1JK1IwN1J5SzBXV2E1Q215MmJJ?=
 =?utf-8?B?K3RPdDNzYk4xSHdRUnBGcjBCOVVzVEJwellRMTVVUjJHWDJjVnhwWUR4N0s0?=
 =?utf-8?B?aURXeVBLK2dGY0JhVmlTdTkwaVJBVzg2K0FEMTZhalZYcjJSaXpxYXBPeXJJ?=
 =?utf-8?B?Z3lxejN5QnZpWTk1KzRXRGNQNTJjWlNIQ1E2em9reFVWSFhON3BUTHYvcHd0?=
 =?utf-8?B?V29GczMxZm1CdUljRE92aEo3dDFzckQ2YTZGZiswOUt3Mlo4R2VNcFhqa2xx?=
 =?utf-8?B?c0k3dnFWUzlaZzV5K2VWaHVNZW5VUFNHZVVlTXVrOHhFUmlrSm9zTnVRSHNM?=
 =?utf-8?B?ZXBxcUJabUhwUDE5SXYwT2pTVW9YVWJ4dFdGdVh6WTdSUlZBVCtzR1A3aXVE?=
 =?utf-8?B?bXRNc2hGWjFOS1p4RVhwZGhqZkF4azBHMG91c1AwSnY1KzhaalkzQkJqV2Rq?=
 =?utf-8?B?a1FiaTB5eTJVeUgwYkFzSXQzWkZWQ0hldDQ5UkhGNnp6RllGbDlkelh6bzF1?=
 =?utf-8?B?cUZ2dUNldnZrTUpKT1d0M1NnQ0NMTWVmMXc5dDcrZFA3S1lKT2t2MkVrMjl3?=
 =?utf-8?B?WDZYenQ3WmJ2SE42TDNEUVZDWHhvRk5oKzZzb1ZtTzlscTJkTUFmdXU5K3ZN?=
 =?utf-8?B?QytYWHU1RWErVjI5ZmxyNnRoVkp1ZjhjdXVzd3RQeklkOGxLTXJQTWVuT2Mx?=
 =?utf-8?B?UVlxZkx0bStxeGVRdGJZQ0owdmpIalJ6MXJSVnloWDhpaXhsekYrckFNQUtF?=
 =?utf-8?B?QUlzOWlHcm12K2JDblVHYUdPMHlFN3Byb2Rib2Q5bkJ4aUVaUm93SVNjZ3BX?=
 =?utf-8?B?YmhVb2tLaFhDTE9IS0dqOWRWazNKbWlKajZYSk81bDl4Y0VTZXo4dHd2N0pN?=
 =?utf-8?B?QW9BNlZocDdzU0xYNTNkQlFUYTlwODZFWEkvV3dhUGxUK1dlVUpiTS9PQUd4?=
 =?utf-8?B?OXo2ZFczMmZQbXE4Q3ptQjhkOXplbHFxb1B3SXJLUS9GcVl0czB4cXJvUHhk?=
 =?utf-8?B?bm9lV0tNQlFQa04yRUJrTCswSTIzY3hKKzcvZ1pvMDNEM1B5eThmLytHS2dX?=
 =?utf-8?B?ZFdaNFUreEIvUGtIdW5NRG5WVjA2VnNvQk9rVW5QQzJFSDZaTkZYbGhmNVZM?=
 =?utf-8?B?bXdGaXM0bm5yYWplSXYrMDhnMTE2NDRQbDgyMm5OeGdNRHlGSGM0QkgyOXpx?=
 =?utf-8?B?NTBFWUI1bWtFanpxTE1tay9XTE9QQlBIRk5UR1kzVEhYRDdSL29xOFhxbUVE?=
 =?utf-8?B?dUw4TUJRY05BYTJGSFoyaDkzcUg0NTNBWENkQnBBWmxSMWZsTytUNVhMd3lN?=
 =?utf-8?B?T3I3SW9XdUFxV0pDbzdpWG1DcDJLaE5QTDFHVWNQNGxQVlJIUDFxU0xRSkEv?=
 =?utf-8?B?M1RDUVBaV2gxUTlYMzQ5T2lSVVVUenpNOHY1ZnpnblFMWmMrbGhSVW9PL1RG?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208f676a-b4a9-462f-0e34-08daa86efae4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 14:19:43.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qKMiqJc8CIcS7nNPCthgE7Ze9UXidP/O1xSJvM/gvSAMBq6ZqE8ZlBUyfAMWJj9H7UL3ZLJ513WxMpdYvV3LIYxm5C9xOONd2gsro0v5Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7922
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2022 8:25 PM, Greg KH wrote:
> Caution: EXT Email
>
> On Wed, Sep 14, 2022 at 07:59:44PM +0530, Manjunatha Venkatesh wrote:
>> +/**
>> + * sr1xx_dev_transceive
>> + * @op_mode indicates write/read operation
>> + *
>> + * Write and Read logic implemented under same api with
>> + * mutex lock protection so write and read synchronized
>> + *
>> + * During Uwb ranging sequence(read) need to block write sequence
>> + * in order to avoid some race condition scenarios.
>> + *
>> + * Returns     : Number of bytes write/read if read is success else (-1)
> I'm sure I mentioned this before, but NEVER use magic "-1" as an error
> value.  Use the real in-kernel -ERROR numbers for error codes please.
> This needs to be fixed in many places in this code.
Will fix this in the next patch submission.
> thanks,
>
> greg k-h
