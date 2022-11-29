Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D895663BE03
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiK2KdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiK2Kct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:32:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB213F87;
        Tue, 29 Nov 2022 02:32:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDO0SrKCCGs4kjKr5CksP26/cDJMrHjCUOiQ2il5uK+TFEdBZ2M6PpRlqgAWXt6zGHu/TyXR2FTaai1YNMxgUehbSZYHHxmhcpIgMXjl4g7UD7/cSjcpCyFn/qLYrhGvC0j05OOhDS37omh9Qt++ip3pc9/+3/94xPbw2uvhCo+qsKs9gtc20QBYQ5qMgu7bNWkUhQm+a5/Wo4Jx20Eh/QLx5JQhD4m/R6kGT223OzyHguPDX84qbaFifVneflehGWwRFjrnQVj44cgSd8aQTxDob7WBbfMiRoB62W5UMyOr2bF9yS4orKScWOzLDvsG2KKOVKokLfw2QVQuSvlS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWa8DcUUfF2hqr/VJY6nyYunJXbNvY0uJEmdxH1nkrU=;
 b=PGb9YMIcJs0tAUPNOiG4FO+dEyWCz2YlsTmKF5tgb1ykLHR65YJn54995Gizl5kQiRkX0sz/Y1XAfXuNW4zdQYe0Nfe6kpAxrHB1CKDwuOnrXCTU7UKYheCv+4WHo3gZJFU8fMBiHcjnQH+oDwUb+DBELmb8Ew0vv1CkjBQVITVPxnktSiah3wi1EJraeUbjHy0ZtZmfqhb8Xx7PrQTUrRdrW8CfwMCGNYP8LJ+Zcb0tDQO15BgR7UVZZSny6t3MozQDCZXkxabzxzXNCYp7V/fJrU4BtNh7B4QVPjjJ0RFPy6hfh+UsVJuGUISRK3NU5YMoCrf8y4xX2mTpILv4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWa8DcUUfF2hqr/VJY6nyYunJXbNvY0uJEmdxH1nkrU=;
 b=TgUsy8s7Lzu5OYXylFB22ibQA3ykWMzcFovLEuMBWMCmKLzu7VPTogOrJO9LkE2m7cDaQD8KASpEjR58c659AL4E3On3eQLjk+P/EqvtuhuSzZck0FAYKopAfB+CrhznIJblVNQXRpupD8KDPLvkuVHHBvkE/Sgwi1p9m1iEUDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by DS7PR03MB5655.namprd03.prod.outlook.com (2603:10b6:5:2c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 10:32:40 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%5]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 10:32:40 +0000
Message-ID: <3c634dc4-1b37-1062-203d-f3466d106ad9@synaptics.com>
Date:   Tue, 29 Nov 2022 18:32:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V2] [media] v4l2: Add AV1 pixel format
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, hans.verkuil@cisco.com,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        stanimir.varbanov@linaro.org, hui.zhang@amlogic.com,
        lele.xiang@amlogic.com, Shi Hao <hao.shi@amlogic.com>,
        laurent.pinchart@ideasonboard.com, nanxin.qin@amlogic.com
References: <20220830014032.1245359-1-hao.shi@amlogic.com>
 <b5f4e1cc04ba35d92839932d431726fd42f24320.camel@ndufresne.ca>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <b5f4e1cc04ba35d92839932d431726fd42f24320.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|DS7PR03MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cb049d-49e3-4d30-77d9-08dad1f50ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IC04+9+zCQjXmMFFUdEmFsb9TFuaE6CnBCgE7vAVishxDFEXLJYLlzoj/Q6Cucwnk5dMEgYfCxa8TrBJ8DZmy0qjHjo+7w1ywc1cCt+Ezgxmn8gfYWfbKKCNmte4iFSKOZbscgKtwDXLFXtjlG6K5KxN85H9Tldr4V23iMS0lh7kJvJszCYUAOJ1v1E/BO7UBkrFD5Um/zd84UFemPdtcRopcFgYUTMcBf2n8Y8a6XcxjPdY/5N2Nw0e4fM5fLoDXn+SEH1JwKpLSVW13d/Fnqt0gj9jvSwiWjsb+aGwZrWC3mckH45ezSerEyg3rv1beRbdNU5QhKuuA6G7kVY7aDF2X/QP2oR3vSU2SMIdvsOSVVoFVCYZB1NU1t83yLHX/i7KUmm/GcN4Iz5aVeCTlVGjMTOP+RgqPG1ovFetxN+O6rxLIkNKpWTPUNtMhMXxW+4ZA15HXOvCTbaUHLf996mNstTIHZ7e7KsJhaPMUIoa5llhZjaLBiJ+IaGyD85QAdwEMBZqnsW9yxldG2iDj8iNQHFHoye0dlaHSF0PDizvUVtAk1dhJRjGPplfSDMmD6sdJf8pRIEY7qLVmD+W9wUcb+gPYjZehGe5dCG2MmNrLiVvcJ28FzglRbXg2NWMFm2mSjJL6KEsDYuWMR5SGmKbzjauJpDacoSXedS9F+4sV6T1KdOBBbu+QteHkNuEC5cFRf7Uy7g65kQF/fMQaQhH8YMLrO2/Sajsx1d8zxwru5iAB3qW7Sd+UWmQxtsR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199015)(53546011)(52116002)(6506007)(6666004)(6486002)(478600001)(2906002)(2616005)(66946007)(8936002)(4326008)(8676002)(66476007)(186003)(66556008)(66574015)(5660300002)(7416002)(41300700001)(83380400001)(86362001)(38350700002)(38100700002)(26005)(6512007)(31686004)(6916009)(316002)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHFCZFYvbGN2K0kvbXQyZEhMZjdZVEZ2UGM3M0hhQnhyMHo5QlFQWE9KcTYw?=
 =?utf-8?B?KzZvRTVMRjllbTBsSUhHMGdlNjBWS3kvREdHTER3aEY0RkROanZsdHpaeWVO?=
 =?utf-8?B?WVZUV3RoWEZIV1ZVQjlPVkxTYWdQOXp0elNoTFZGMjNJanMrQlNGN25rRU5D?=
 =?utf-8?B?Wmc4RThMZ2ZLeTVrcDFsdVZabjMyWmkrNCswdFpBWThUcktidnJDb05YOEQ3?=
 =?utf-8?B?RERldFRCMjZRN3JTaSsyYWdCZ3Z2bUw0L1lOUnc2MXdHOFJ6NG1VNDZxVk1q?=
 =?utf-8?B?L2RmL0JuQThzY1pqeEV5bnd3Z1l3Kzd3Qk9xdkhjVUR3Tk5yMCtMZWlmNWFo?=
 =?utf-8?B?NEhIbllKcElNTzRwWFZLRUxubVdwa3drSWZhMHQ5ZitzRVJ1NkJ3UWhUa3Zt?=
 =?utf-8?B?MGdhMkJnYVBtaVlJcXZTbzdVRDBMM2lESnlLK28xMHNzRzkvTFkvM3d2S3Ux?=
 =?utf-8?B?eDhFM3NaNXM5SWpHMTQ1a3NTQ0toM2FZMnhVYTNtVGsxM2tBbFNQSnVhaGY0?=
 =?utf-8?B?QU95Qlpkc1IxS21uTkhwRVl5QUlIbzQzVG1PRVRVSXJDNFVvUHkybFo1WkZR?=
 =?utf-8?B?TjVxUUlrTGJtR05tT3J6aWp1Nm5waG43ekZKUEpWMyttcXNsdjZ1U3FuUGpu?=
 =?utf-8?B?RDI5cTJENGJoNksraEV3enIzenhBd3B4NTBSRzIxNDN2cFVJQ1BlZ1JQUVFZ?=
 =?utf-8?B?d0R6ZDltWnFMQTNqcHdCSm4xVDFkUzFEaDRLdFNVc2hXaUNiZ0luUCtnRkxh?=
 =?utf-8?B?ekJnQ25uNjlMK2FBSHN3cDZXc25EUWlvRzRBQWRYRzVwVnpNT1grb3RyV3NN?=
 =?utf-8?B?K2RtaklMZUlqU2ZsOU1GVjB2WDhlV3pBZVRKWWhkb3hlSjI0eFFNWVVjNHZW?=
 =?utf-8?B?UU9KRzkvc0xVVTd4Q0N5cTlGcGswejJ6djh5TERsMUprb3BsNk1VWVJYZDRw?=
 =?utf-8?B?ZHlDYUJTdXFLL2h4a2diYXpkVnVOVktUWDZHMVVESzBQM1gySDFBLzQzM1Ni?=
 =?utf-8?B?amsxN202aitCTDhnWVB1NGpuR1RaQUJBeHF2Z3dld01UbzROeGozWlNyaGRa?=
 =?utf-8?B?NU54REVTcHJSbUxGY1FLVzdPMUV5Q0g2azFWYjVya3krQjNDSnJGUmMwMVNp?=
 =?utf-8?B?amFyRjErYXBKeUVhQWY3cjA0bzZ1NlhlNVBjSW0wb09JbGc0eDdaVGw2L3ZL?=
 =?utf-8?B?NnpXTVg5UVJIZnFUeUhMZVE4NFFwK2x6Qzl5MWxlOFJlT2lWMjhrZUtSSUtq?=
 =?utf-8?B?aWJ0NmUxWEgyZE9lYjdSWUs4MjVISDllUlYwa1B4cFNoNjJPRmxDdzBaMC9W?=
 =?utf-8?B?YzA4Q2JLMlhGMGk1bzNML3dCQ2Z0YXVpZFBTTk1qOFk3L09pQ3dLZUNkSHpi?=
 =?utf-8?B?QVZuVDlmQnFOa1RKUmZBUmt1cWhBakRNRHFKeitIRG9uYWNmOGRHYTFyRWQ5?=
 =?utf-8?B?c3JDZHZlTlMwc0xaYytlaFE0UlF6MHdNQktpYVk0RmFzOUJSanZNZnJwVS9B?=
 =?utf-8?B?MHhNdlE3V0ZXczRnN1FQNVlkajVpK2FGVThTV0JRSHp1VmVlVzNHcExGMmhu?=
 =?utf-8?B?ZjAxejJkTUc0MjJaVjBQZzE0dTg1eWZJd1crVldmRUMzQmlhbmdjODdhRS81?=
 =?utf-8?B?bkRWYkRLZXhzU2Z4M1NFV29xclNJazNRY1ZaZDlRcHlsWVpoaWRTOWdnSkx2?=
 =?utf-8?B?OTBLQ0Q4M0FlR0tramFQL1RmTTZFK2xIRURsenZtUDUweGFoUnlvRmdmMjg1?=
 =?utf-8?B?K3JXSmtQWGVFVHZXcmhXVWs0VFViWXZmWE9ubWxVb09OU1V0dlRpbFYzeUpx?=
 =?utf-8?B?NHdEaEpuak1MQ1JxNnNyK3dhV3UyUGpPMDZtYlE2Y09vWGcyMVg5U2FoQ2lJ?=
 =?utf-8?B?cUxuWFBhMGYweW5LNU9uK2s0cW5QWkhsSjA5TklpNHVMUmhQSWdiNEUvREQv?=
 =?utf-8?B?MndMNzZ6WVE4OTgvQ1lWc1hQRnJpcHlwQjVVVDd4U2ttOTJxY0dMNVk3K210?=
 =?utf-8?B?RXNDdVZ4c3J6ZU82blFVOGRjbWRYcjFYQ3JHc280WlJVaFlJcWFwY25RamVt?=
 =?utf-8?B?NUd3UStFYXZFTklZVHBjY1VXWEJrRnRiUFd6cGZCNStjeTBXeTBUNlRBSHpr?=
 =?utf-8?Q?T1GvRCBZpO5GpBjffp9QAeEef?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cb049d-49e3-4d30-77d9-08dad1f50ab4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 10:32:40.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMrN8L0ehkJLbbMT9wcTMkOZIFVGaNbTwyrOwWbtIfD4bDAHoG50chBMG/43qXMIq3g1JiIDnlO3at2SoXjWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5655
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I think we need to add an extra event for VP9 and AV1 which support 
frame scaling, which means its frame width and height could be different 
to the previous frame or reference frame.

That would be more possible for the VP9 as there is not a sequence 
header for VP9.

On 9/12/22 23:45, Nicolas Dufresne wrote:
> Hi Shi,
> 
> thanks for the patches, check inline for some comments. Generally speaking, we
> don't usually add formats ahead of time unless we have a good rationale to do
> so. Should be expect a companion series against the amlogic decoder driver that
> enables this ?
> 
> Le mardi 30 août 2022 à 09:40 +0800, Shi Hao a écrit :
>> From: "hao.shi" <hao.shi@amlogic.com>
>>
>> Add AV1 compressed pixel format. It is the more common format.
>>
>> Signed-off-by: Hao Shi <hao.shi@amlogic.com>
>> ---
>>   .../userspace-api/media/v4l/pixfmt-compressed.rst        | 9 +++++++++
>>   drivers/media/v4l2-core/v4l2-ioctl.c                     | 1 +
>>   include/uapi/linux/videodev2.h                           | 1 +
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> index 506dd3c98884..5bdeeebdf9f5 100644
>> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> @@ -232,6 +232,15 @@ Compressed Formats
>>           Metadata associated with the frame to decode is required to be passed
>>           through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>>   	See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
>> +    * .. _V4L2-PIX-FMT-AV1:
>> +
>> +      - ``V4L2_PIX_FMT_AV1``
>> +      - 'AV1'
>> +      - AV1 Access Unit. The decoder expects one Access Unit per buffer.
> 
> I believe this is using a MPEG LA terminology. Did you mean a Temporal Unit (TU)
> ? In AV1 a TU represent 1 displayable picture, just like AU in H.264 (if you
> ignore interlaced video).
I think it should be a complete tile group obu. From the spec, we have 
the term 'frame'.

Currently, AV1 doesn't support interlace.
> 
>> +        The encoder generates one Access Unit per buffer. This format is
>> +        adapted for stateful video decoders. AV1 (AOMedia Video 1) is an
>> +        open video coding format. It was developed as a successor to VP9
>> +        by the Alliance for Open Media (AOMedia).
>>   
>>   .. raw:: latex
>>   
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>> index c314025d977e..fc0f43228546 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>   		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
>>   		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
>>   		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
>> +		case V4L2_PIX_FMT_AV1:		descr = "AV1"; break;
>>   		default:
>>   			if (fmt->description[0])
>>   				return;
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 01e630f2ec78..c5ea9f38d807 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -738,6 +738,7 @@ struct v4l2_pix_format {
>>   #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
>>   #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>   #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
>>   
>>   /*  Vendor-specific formats   */
>>   #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
>>
>> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> 
> 

-- 
Hsia-Jun(Randy) Li
