Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A51764671F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLHCkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiLHCjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:39:47 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B11D1057D;
        Wed,  7 Dec 2022 18:39:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bma9SrO/TKMIZ4JHCwwcydnVXTwTi461z4L8RzrBeTo9NLbt3XYHPgkCQHKDPllpvA1iyHpeihpSmlQyJeICqwzzSKgWlabwXrCLCqKJBlc1n9dfosW8VN4MfIqK1KaTaMC5YGQhTT4ugLdp9XL2H0ueEqWL3cU4A4puaEiykgFrwnZqPWRWJnvA6wsZU6ZoHEJz3i6JA8JKc3K3Yg3VGJU92JOsroPP32kE7lyxcXRpS7LZWlPJsgVgoM7JFkz0Wl0wtRy8RljtJsjQFvHkOSES1H6Yiq8a12/JR1Kfv+s4WZ4y8rKzoY7GFOx51eiCMJXKfuM255d5t52kY4+n/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6Ir52J3YnX5369mkZ1RI/YV5/shDGoEwiQzC2/DSB0=;
 b=EHfBmAE99/xeamJdVACgG6cPaRilellqKwhQhQWybsayM28fwMgETSfab9SC6cRN4YlmU7tUTf0XW82svUE5SgZkLvLzgJmgd1e40FMDkJZkCCWt8x/3xG6btXrsC7CnTLqM8njW2De4j48Ym7M9J+KJ/uotLMp0ozMGCRHdxaTw3QnBJwkMEzSzprQ5Hzv5VsiTRqsU4MbcIdXA4P1WKkq+4KlR/85rfzWsHAMEUcdqFUe49uiS15NzcPFle1OGdqIssZPgPWp+NqAOJuPJNhd7G8yEiluRYzp5i5HbKpeNyJNHOVO5/yDxP+tU47dxwdqGucRUWqnyfZnwBaStkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6Ir52J3YnX5369mkZ1RI/YV5/shDGoEwiQzC2/DSB0=;
 b=V9FSsQLbsOXCReCHvdrUehYhLKPR/LS9JQLjNd/atcdt22XqMaoCNApbVxwc8cEW4T/MU9TalQYYLRNT7LOQCVfXyDXb9uKhq0OI+q74yAhv7Xk1bONiV8Q2lJtvLD5KtrcLZfbVYkDTtXN2ilANY/uKysh8LqSu3w00scZX7+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CH0PR03MB5969.namprd03.prod.outlook.com (2603:10b6:610:e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 02:39:44 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 02:39:44 +0000
Message-ID: <1480f5a3-700d-9c1a-7e05-b64abc94c9e1@synaptics.com>
Date:   Thu, 8 Dec 2022 10:39:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
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
 <3c634dc4-1b37-1062-203d-f3466d106ad9@synaptics.com>
 <76febfd703c3eaf312f001a9e952d9cd89449fa7.camel@ndufresne.ca>
 <07385baa-9e82-9fc8-5cc1-cc1089e87fdb@synaptics.com>
 <a85a5c817cd2a29d6ba592fae75bf9e065d93124.camel@ndufresne.ca>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <a85a5c817cd2a29d6ba592fae75bf9e065d93124.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:40::40) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CH0PR03MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 11331797-7827-44b5-0f9b-08dad8c576b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rR51JbTGxRnAKfGHJUrqW+DlfaKqUQYgqgDX6IU3S4khKTuIar9nyqUwtwKo4wsQ0aEEr4PGMjOGygpdbdAHH4oQF/51W2XR9C3WY0oNM7bob+ZS+YCgz6PYR4IbwFjM9G3ED6YQ7P9xSNOr0k15JhiNK62gcOgKxd5vnnL+khlL8MC/gAj8nbe6C0h5GQGD60QH3A2cWNee1Nv1WIMe629/nY5n4u/rU1RH3hfby7niOeFD7erF3sA1rOeYdG+vkEuJK7jg6Xq+l9RfaRDSN+YcnKr4MWjU71O1w6GtXXoZ8aQWwoDq+I7IHqlEtP8SLRBxj7bUfpEsOtjHmigWaj5mJJkGNKQRjqSpaSrTBEzjy9hFAQh6eT+wJg2kdOEj67AOjrHv+6Y7/Uq1VuJgxJReSe7FpSNgrgN5buf0tbPymC75xZYSUjaBXYkjwBdnq1Woun3Y3yAKMqVGQ05hSZqQVepwxxUgqP1mTjM9rwVyC5lNd0+r1PVePvFoqSKYUZGwPRmO3zhSr/9RSMKN9UZAYKZ+fBV7By5uPtL5ZqIwLllsr3fZ/5UAPZjxoHRBG11tIx5O5Iow1q+YIChlQPt62Y+d3g3r5U9q20w07K9oshF32Xm1sKfSUClMU5Qa85JRCHEYbm0uZv8THJcPJlL+upTwjcD59A4i1gez8Q+5IVsAhA8m964XkTl40PiLV9c6tToBOkeKOFFb4p+2iW8soHO9KFFNd+BBwNLabmDT1K3VoCjxHp+18IinZag9SIBmKd/XynbFs11jAxGt+z8tJqFytc1oLDRcg1O92mY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(83380400001)(8936002)(86362001)(38350700002)(31696002)(2906002)(5660300002)(7416002)(30864003)(66574015)(41300700001)(4326008)(31686004)(478600001)(186003)(53546011)(26005)(6506007)(52116002)(6666004)(6512007)(66946007)(2616005)(8676002)(38100700002)(6916009)(66556008)(6486002)(66476007)(966005)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNrdnF6bGs2enh2cmNxcGtoM3JTRGpGS0Q5YzEvZm9JaHVEb0l4Tmx6TURB?=
 =?utf-8?B?Y1h1bjVtUnY4cVlBK3Fra2RXRDhUVkFOZ1hMMlJod0wwQit4bTkvYlBSNlZu?=
 =?utf-8?B?QngvTXJSRzVtQUpYODRjMGpFT1NLY3lxYjAvaVBFaHBXUnFWVGJnSlpJdDZE?=
 =?utf-8?B?ZjRzY3NsV2tqbUFBZzgwZko3aVdsSm9lRzExOXREamtpOENaRXlGTGM2d1Y5?=
 =?utf-8?B?Qm9tbzVQV2RJb3FsZ2YwS3crVWRoT05UVmlXSVZZTHNvSmk4R05ReXhicXFl?=
 =?utf-8?B?WW1WRWFvUlJMemt5VWRwYWRIOXR1RUxJRENoOW8vbExmVzNxZHlGdWxibm5h?=
 =?utf-8?B?Y291djFPQ3pPUkFraHR5VXprZzhNTjhrUjFVTFNLRUtTOVYzWjh1THd6NEsz?=
 =?utf-8?B?UFUvTkptT2kycnJJbUU1dzBjKzl2UTBEZUVIMzJpMXI5VzVpTFNhSWRxU0F1?=
 =?utf-8?B?Z0FjbUJkVEhrcElHbDJQZVAyckV2RnR0cHJSUWJ1RzVsZDdYQWdNekE2ZW5p?=
 =?utf-8?B?OTlSa3RrVXB1N3p2RlFSOVJqZ3RYY3FQOHZzZ3hqdVpXa1BkZkxHNHR2N3E5?=
 =?utf-8?B?TGFFVGlDeUR4VlVtS1NpR2tPT2ZyMm1GcjZqTHVkQzR1Mmxqd0JlN1d4UHFm?=
 =?utf-8?B?SXh2Q2tVUVI1K0VVTGtFczBMTDdoTE8wTFlQZWNBUEc0Szg1c1NDL1VJN3By?=
 =?utf-8?B?K1lXL2Y3Tm5KTk15a2Ywd3VJYUcxUm5nWDFJczY1U2lLemRkZ1M3dW9wYWdL?=
 =?utf-8?B?Z0JXK0pGdk9RUEZaOXdRUFpiYnRoaVZpRmhYdVlVL3VBK05SN292NUM1YUtY?=
 =?utf-8?B?ZnpuQm1QeERzWVVvanNRY1UzQTZqNVdmRnIvZGdTQmE3TGsycmszb2llUWRC?=
 =?utf-8?B?QTBRV2FjUWR1ZWt5dmRZc2JSOFhpVklHMS8vSGZEbHNDQy9QemZZRStZTFpm?=
 =?utf-8?B?REYzbzRDTnYwWnhCL2ljOGV0Z04vZmNCM2pQdGVLdWtRbkpTc1FsTDFUcnRi?=
 =?utf-8?B?Vi81ZjZOcVQwemIydEpzdC95SXFjSURrUUM3R2MyUm94STU1UzdNeXlCSzdN?=
 =?utf-8?B?dTFwcGxQT2FGNEt6Rk9QYVZsZ3I3U05ham5iSkYxT0VVWlNDYThlbmU2Z1ow?=
 =?utf-8?B?a1VXTlFZeTFXNWUvSk1UQVVpYlpVa0NMZnY4SldJMEphOEQwKzFLZndTZ3du?=
 =?utf-8?B?Q3BtTGcrNThzZ05HeEVPNkVvMzY4Uk1KUGo0YVg0aU11Z1pYKzByTUZNaTNq?=
 =?utf-8?B?TTFsSWNlRXo1T1hkeU1Ub01pWVN1MFMxV2t5OVlvalFXcHcyazdjOWMzd3lo?=
 =?utf-8?B?dnZ0S0JqUFlpOUI4akI5RmFtWVR1SzJTMUROUjd0T3RwMGs1U2QwMTBsK3c5?=
 =?utf-8?B?MjgvZnhUVVpySE9ERVdkTE5mRTRZcys3Nk91dWZmdC9kSG53TVNQcFAzWGRX?=
 =?utf-8?B?cjNVZDcyWmZsN1VuUVJTeTVaMVFUN0tac1FXQ011cnVkTVBLKy9oa0d1aUdO?=
 =?utf-8?B?Q2lVRmZjRVRPWXBGRGFhUzZkTVQrYTQzTHBBbW1oc0drdFg5clU2TCs1K2di?=
 =?utf-8?B?Zm00aGpnalZ3SnBoRmNueWdQRTNYNlE5dzBpVURKdTdMRjhKRkhJN1AyN2dt?=
 =?utf-8?B?RzFzTHhsRmZFbGJRMFBhdVJTTHBCUFN0SVdGaUJXanhNeG9scmpzUU9YU1NI?=
 =?utf-8?B?eFJxY05vbk9hWkFYU1ZQRnRPajdJbTdiZmRuL1BNZXg5eFNVZkZVK3lORC9j?=
 =?utf-8?B?VVFQaGVSMDNOaUI1K01lbGRiWVk2Q3dvMzZuN3Y0dVRKL2M4ckp6YU1sMmNN?=
 =?utf-8?B?Q0VEVGFYK2o0OEF3aW9KUDc3ZFYzUjloV1lHdDlBeHpjcHdyNFRMOVo4S0pV?=
 =?utf-8?B?cnFEYlM3K21tNUJLSHcxMUNkSFV3SG1SUFllODc5SFlVa3N4ZmE0UjZnS3hx?=
 =?utf-8?B?bEg4SExoUVRnNm9YdlZvNlFHMGpDZjE5cituOHEzL1V0Z2VCNVpuM0g1UWpa?=
 =?utf-8?B?VmlRdDltdE0zWlQraVNXTUl2SUNtSHVmQlpxSTI4bjJKVU1JOXFKV3pScUE2?=
 =?utf-8?B?Mk5ER2E4OGNQenNwWEZjeUlYWnRLdVdNVGd2dFpNYUJNMjRzNWpyT3VlaEF1?=
 =?utf-8?Q?uW4gVofJoOKEqNs4dMJX2t7F6?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11331797-7827-44b5-0f9b-08dad8c576b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 02:39:43.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0xuTjCetfdmKrJ8Wa38UglmcBj+n/k+ZnU/n9g7cHKjTi/7Od+7Z7BUX0z7PDj4/8QBIY3KQwsN/xWWS7Zl1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5969
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/22 01:16, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le mercredi 07 décembre 2022 à 15:18 +0800, Hsia-Jun Li a écrit :
>>
>> On 12/7/22 02:03, Nicolas Dufresne wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> Le mardi 29 novembre 2022 à 18:32 +0800, Hsia-Jun Li a écrit :
>>>> Hello
>>>>
>>>> I think we need to add an extra event for VP9 and AV1 which support
>>>> frame scaling, which means its frame width and height could be different
>>>> to the previous frame or reference frame.
>>>>
>>>> That would be more possible for the VP9 as there is not a sequence
>>>> header for VP9.
>>>
>>> The solution is unlikely in the form of an event, but yes, to complete VP9
>>> support (and improve AV1 support) a mechanism need to be designed and specified
>>> to handle inter-frame resolution changes.
>>>
>>> Why I say improve AV1, this is because VP9 bitstream does not signal SVC spatial
>>> streams (the most common use of inter-frame resolution changes). With SVC
>>> streams, the smaller images are alway decode-only (never displayed). This can be

We expect to get all the result from different layers of a SVC stream. 
Which layer would be displayed is a user's decision.

1. golden frame usually would be higher resolution or better quality. 
But we would only display frames which are lower resolution.

2. Higher resolution or quality layer would have longer interval, user 
may just display a lower layer in real time case (like video conference).

>>> at least partially supported as long as the maximum image dimension is signalled
>>> by the bitstream. This is the case for AV1, but not VP9.
>>>
>>> Stateless decoders are not affected, because userspace is aware of frames being
>>> decoded, but not displayed. It is also aware that these frames are reference
>>> frames. While on stateless decoder, userspace usually does not have this
>>> knowledge. I think one way to solve this, would be for drivers to be able to
>>> mark a buffer done, with a flag telling userspace that its not to be displayed.
>>> For the SVC case, the dimensions and stride are irrelevant.
>>>
>>> For true inter-resolution changes, like VP9 supports (though rarely used), this
>>> needs more APIs. It was suggested to extend CREATE_BUFS, which allow allocation
>>> with different FMT, with a DELETE_BUFS ioctl, so that userspace can smoothly
>>> handle the allocation transition.
>> This could only solve the problem of never display graphics buffers
>> likes golden frame or alternative reference frame.
>>
>> About the topic timestamp tracking problem in v4l2, maybe we could start
>> a new thread or move them to Gstreamer.
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.freedesktop.org_gstreamer_gstreamer_-2D_issues_1619&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=GL3Q2_6ERpT94we1vI-sUNajRV_t3-lcd8F6DAbXt5EimufjPEa-yTi1-p3EhsCM&s=KbTA0L42trYmxvVphaiUeDsgUS4e-vm64epfaSgAYH8&e=
>>
>> My idea here is event attached to buffer or just using the new request
>> supported in CAPTURE side. I know you worry about the v4l2 event, it is
>> out of band, more event could lead to the problem we suffer from
>> OpenMAX. If we could have an order between event and buffer, it won't be
>> a problem.
>> For VP9 also, it might be required to support
>>> super-frame, VP9 supper frames are the ancestor of AV1 TU, and only the last
>>> frame of a super-frame is every to be displayed. A newly introduced AV1 format
>>> might also requires complete TU, rather then frames, this needs strict
>>> documentation.
>> I don't think the temporal unit is a good idea here.
>> Most of hardware could only decode a frame once or less likes a
>> tile(likes slice in ITU codecs).
>>
>> Considering the MPEG-TS case,
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__aomediacodec.github.io_av1-2Dmpeg2-2Dts_&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=GL3Q2_6ERpT94we1vI-sUNajRV_t3-lcd8F6DAbXt5EimufjPEa-yTi1-p3EhsCM&s=f7qIYhe94ooCIv1awccCfSmI-Gq0raAXHRogkCBTB4M&e=
>> Decodable Frame Group could be more a better idea.
>> Temporal Unit would lead to larger delay.
> 
> This is off topic for the tread, but this one could be fixed by setting a flag
> on the capture buffer, something like:
> 
>    V4L2_BUF_FLAG_DECODE_ONLY
> 
> That's similar to how it works with other CODEC API. The down side is that the
> driver needs to remember if this is a reference frame when userspace queue back
> that decode-only frame, so its not overwritten. Userspace is not aware of the
> reference state, hence can't be made responsible. I suspect a lot of the drivers
> out there uses secondary buffer, meaning the reference are not the CAPTURE
> buffer. 
Drivers certainly could allocate its internal buffers. But I believe 
Android won't like this idea. They would like you allocate it from 
somewhere then import into driver.

Besides, when you decode a secure(DRM) stream, you won't want to leak 
any data from it. While for those normal stream, you don't want occupt 
that limitted amount secure memory zone. I would like to let the 
userspace control the allocation of those internal buffers.

This use case needs to be thought thought too. Perhaps other driver uses
> internally allocated memory whenever its about to produce a decode only, but
> that seems to require some firmware feature that is likely uncommon. Please,
> make your research, compare various drivers, and propose an API in the form of
> an RFC so we can discuss that independently from this AV1 pixel format thread.
My proposal for solving tracking the timestamp issue is making v4l2 
event have order relevant to buffer.

It would come after I refresh the v4l2 pix format extend API.
> 
>>
>>    Decoding frames would mean that un-display and frame of different
>>> sizes get delivered, and we don't have a method to communicate these frame
>>> dimension and strides at the moment.
>>>
>>> Nicolas
>>>
>>>
>>>
>>>>
>>>> On 9/12/22 23:45, Nicolas Dufresne wrote:
>>>>> Hi Shi,
>>>>>
>>>>> thanks for the patches, check inline for some comments. Generally speaking, we
>>>>> don't usually add formats ahead of time unless we have a good rationale to do
>>>>> so. Should be expect a companion series against the amlogic decoder driver that
>>>>> enables this ?
>>>>>
>>>>> Le mardi 30 août 2022 à 09:40 +0800, Shi Hao a écrit :
>>>>>> From: "hao.shi" <hao.shi@amlogic.com>
>>>>>>
>>>>>> Add AV1 compressed pixel format. It is the more common format.
>>>>>>
>>>>>> Signed-off-by: Hao Shi <hao.shi@amlogic.com>
>>>>>> ---
>>>>>>     .../userspace-api/media/v4l/pixfmt-compressed.rst        | 9 +++++++++
>>>>>>     drivers/media/v4l2-core/v4l2-ioctl.c                     | 1 +
>>>>>>     include/uapi/linux/videodev2.h                           | 1 +
>>>>>>     3 files changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>>>> index 506dd3c98884..5bdeeebdf9f5 100644
>>>>>> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>>>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>>>> @@ -232,6 +232,15 @@ Compressed Formats
>>>>>>             Metadata associated with the frame to decode is required to be passed
>>>>>>             through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>>>>>>             See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
>>>>>> +    * .. _V4L2-PIX-FMT-AV1:
>>>>>> +
>>>>>> +      - ``V4L2_PIX_FMT_AV1``
>>>>>> +      - 'AV1'
>>>>>> +      - AV1 Access Unit. The decoder expects one Access Unit per buffer.
>>>>>
>>>>> I believe this is using a MPEG LA terminology. Did you mean a Temporal Unit (TU)
>>>>> ? In AV1 a TU represent 1 displayable picture, just like AU in H.264 (if you
>>>>> ignore interlaced video).
>>>> I think it should be a complete tile group obu. From the spec, we have
>>>> the term 'frame'.
>>>>
>>>> Currently, AV1 doesn't support interlace.
>>>>>
>>>>>> +        The encoder generates one Access Unit per buffer. This format is
>>>>>> +        adapted for stateful video decoders. AV1 (AOMedia Video 1) is an
>>>>>> +        open video coding format. It was developed as a successor to VP9
>>>>>> +        by the Alliance for Open Media (AOMedia).
>>>>>>
>>>>>>     .. raw:: latex
>>>>>>
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> index c314025d977e..fc0f43228546 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>>>>>                     case V4L2_PIX_FMT_MT21C:        descr = "Mediatek Compressed Format"; break;
>>>>>>                     case V4L2_PIX_FMT_QC08C:        descr = "QCOM Compressed 8-bit Format"; break;
>>>>>>                     case V4L2_PIX_FMT_QC10C:        descr = "QCOM Compressed 10-bit Format"; break;
>>>>>> +         case V4L2_PIX_FMT_AV1:          descr = "AV1"; break;
>>>>>>                     default:
>>>>>>                             if (fmt->description[0])
>>>>>>                                     return;
>>>>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>>>>> index 01e630f2ec78..c5ea9f38d807 100644
>>>>>> --- a/include/uapi/linux/videodev2.h
>>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>>> @@ -738,6 +738,7 @@ struct v4l2_pix_format {
>>>>>>     #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
>>>>>>     #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>>>>>     #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>>>>>> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
>>>>>>
>>>>>>     /*  Vendor-specific formats   */
>>>>>>     #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
>>>>>>
>>>>>> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>>>>>
>>>>>
>>>>
>>>
>>
> 

-- 
Hsia-Jun(Randy) Li
