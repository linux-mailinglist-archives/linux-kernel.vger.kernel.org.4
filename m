Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2582572DB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbjFMHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjFMHtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:49:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB67E7C;
        Tue, 13 Jun 2023 00:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz8CgyKAt7DV3A6uGtPNQRCzWnIbCBBe+MWeE/V/V/tLYZ8l5Xr4oTXiZVbAj8dwFIRjp12kRuDi3z3kH5iOgwMhlniuHj2By4m6fu1c031JGYf9lTAcdWS98+qn8QoNfxwKpd/at0phzWnAQXQ9jq1t6x2uguzajCAalhF7oi2XALMyVz5QMOwCspui2uXlGrC8oNfbJ3kH9U06wH7lwlgx2qzfNe9ShDkpK3pavDLRRCWi2edyw0nygnQmceOW8pfmAaA936JPD4sny/bi8CGuWZ/GngxHeU/DYuywAbYml6tpTrJaXtNZ759ySoM6ZKnns+F14mFEQYeXYzaMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIgo2LXlc3dalKkRxJh0QaZ8Azq8p/lOCZvJz4bJ57w=;
 b=I3czTkyWhVjzWpzu3olRQt/gbWrrmGZnDoJynuWOK7d4NZUVVSd4rzG2k4HbdQWl4i0V+g+crA+5zY0eYN1JxPL0Yy2duhGFdR30j3yllKgU8s8wgC+vEYonmar5hqAXqcCZ0fh4ubVBQLpYgoUyuN4//nMDTFjLTvOBLR9hlPCYwlEnyOH979ahypnxfoOmmn0nNmtznLvMbXCjPKXVQX4MXcte9EZjDAyXf+obLiNOTNeQmNF1fKe/AfIgQUm6ob7LZFeODvnnEwiJVGuJJsmCwErfUzeyMSuGRFa5FvJAlcUuwZEJNjHiOJ5rNvOiHgop1kKEen3StLOHQ6vn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIgo2LXlc3dalKkRxJh0QaZ8Azq8p/lOCZvJz4bJ57w=;
 b=TIJ/EStWdRBQVD50grylvSDUkwa9cu0RZYn5x3vBn6gnBRpUJlovxobi4LSaoi4F3WcFR5fwwRMIE1TV2GmO0vf415UrcsBtu+i25AYSGkYiGs43GMtqaPYDAiBDK+yv6A8C1mGM9SAZN7VCqIS6PH0NTPjwk0q8jLwitmJFBEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB9574.eurprd08.prod.outlook.com (2603:10a6:20b:61a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 07:49:43 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 07:49:42 +0000
Message-ID: <64902ea4-e934-2813-2dd2-cb568e1f8030@wolfvision.net>
Date:   Tue, 13 Jun 2023 09:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2 4/6] media: v4l2-ctrls: add lens group speed
 controls for zoom and focus
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        libcamera-devel@lists.libcamera.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-4-faa8ad2bc404@wolfvision.net>
 <20230607070759.GI14101@pendragon.ideasonboard.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20230607070759.GI14101@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0065.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::16) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f1f6eb-c367-41b6-26ee-08db6be2bfc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmcAxWP0dpKr2yrl0A0S24bKFtFXdCP0lF8Dkc7q+fcUAnj0GTDuoiOwo/CTjWYMi4NR/g86rXpxO/Ztn9ojTEI4HfqyAa7QbX3qHsrmmY4PKp158z1knnh+ZfW2I9wfKYYQi/Q6GLeV6CovB64aNrkyT68Xr6ln+8xFA4KdT4SdTFK5hoNbgeswCfk9AZ2J56tX5DME61UTi/Hv7lj4hRT8JgABtISa12DFUxrzGW2TTR87uhiI4rFOtmzrdsFkbh7j/f+Shni2+eEUWhVfJSXHNQE/IT2EWVYdG4Nx8eUmF1xWuyEcAg6KxEWbavFaRJ2rNs9ozjl9cyXQhUNPFqF/pUwJUmB7e5XmYN02AyTJYux+9iZpun+KzV8XZJSsQ5b8Nw+J+hPbZVEddwLIUUC3zJr9o7vCjCS8dKexadffn8MxFl1XzIdslZvLKy/Rxjx42fT9ofmTvwhgMdzyvVxpCW78TZvvMu0lm34nG7oklZSac70xfpPRkVzGAeLkgauQEZRMGjskITKaFXxrj9dSf1K49iwGAYM73F3MN77zG8Fp1dvwnaI+sm/vFr9UDVhp5uKZDHx0PVA/aq1VSvmMEfmHEVddS6Dblab5oP6hxJiLnn1rE1sXyXYe3Kg2sTA2kAqdygLt7Zfj7cQqog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(451199021)(31686004)(6512007)(6506007)(41300700001)(5660300002)(186003)(53546011)(36756003)(478600001)(44832011)(66476007)(83380400001)(66946007)(4326008)(8936002)(8676002)(2616005)(66556008)(54906003)(316002)(86362001)(6486002)(6916009)(31696002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29ZcS9DQmlIUkpibmtOQkl3ekZCb1VVRW00d2NZaU5HeFA5UWNIUUdXTCtw?=
 =?utf-8?B?T2t2T213NTdkUDNyRnIwQWUrTXVxdHpFSDhmRDFVVEhCcUprSDJmWEJaN3Ja?=
 =?utf-8?B?L1pydGt5NWZjT21CbDNiWEwzUnphNGdWUjF5NTgxbG5sVVo0RjhBN2VEaTFk?=
 =?utf-8?B?L3djay8yUGMxSmxxa2ZoTVlPWXIxM01LRkM5QzdtQmhvWWhHRzM1b3BDZi94?=
 =?utf-8?B?S0hnTmVrK1N6Z1o4eXM2SnNNRVBvSmdncGFDV1UrT1hkaUhscDlCQ00wRGhz?=
 =?utf-8?B?bU5PTFpLcVBXZG9nNDJtTGt1V2JhZURSNkxYV0d2U2RoV1NaSEI4YXJHRkVD?=
 =?utf-8?B?WmdIMEdxcTlCcWhrclNBNkRVbjZTVnUvQ1VmVEM2L1kzeWYzMlhQUmNZZHJq?=
 =?utf-8?B?eVpMSjIwSjJqdkszd1hVNlV5K3dxUm1JK3BPSnl6TFltRkQzVmZMQUJpQnFw?=
 =?utf-8?B?STFiaWw3Rmo2aTBmUVh2dEdESUdxYjdJUC9kR3JXTGQzcGw3aUtsc3AzZ0pY?=
 =?utf-8?B?MkFxYjE5bzlvUU5JVUoyQjNuSWhCQ2ZjS2w1Ylo3bERNNDRqSjRmZ0lwZHQv?=
 =?utf-8?B?bnpmcGlVdGhJK0pkTHVSNjlMZ0x2M2M3eVZJMDZaS1lzbEZvWFpxY1ZseTls?=
 =?utf-8?B?NzZUOXZLd2tmRXZFbXRCLzgxL1UvdmZxMHpSMzIzRG1IbkZ3cFdVSFNnMTBv?=
 =?utf-8?B?YlYyVnlUVjgvd3lMaDdybzNwdGwwa0ZiNVIranBOUUxzWUJFby91WllKUzNM?=
 =?utf-8?B?YSs5SmxjSUNLNjkyT29OclBBam02RWZtTGdaMzhxMXBQVG9Ec2xQY3VOVHNh?=
 =?utf-8?B?YnZ4SnpyTnBUZ2dSS3dWaTdGSWtNV1RQdUJYbjg2d3JyeU9JMTQ5ZDdyWjZN?=
 =?utf-8?B?d3VWV21Ec1NQTU5SdXFNV2dmdkZ5aWRueDRpWjFxVUJvaHhHeFVKdlE4R3Jq?=
 =?utf-8?B?MWRFdHpsd0FHaGdVT21qUC90di9ZMDd6NWc4cndVei9WM1Nmdi9hVk9KT2kr?=
 =?utf-8?B?b0hycHRWSHlqOHQ3dTBMeDBVb2tOdUYxMmVjbFdlRk9GcTJWVXdQZXlhYndJ?=
 =?utf-8?B?SytOMGgza3R2eDF0M2NlQ3FwU0czNzZvbVZVbStQWURXeVQ3enZOc2EvYjNG?=
 =?utf-8?B?cTVtSEd2cVMzZzh4aTJ2T3hRTVlpUE1lQ2oxb0FnZGsxa0lVa2M5Wk9oNG1u?=
 =?utf-8?B?SmE1S21xREdnR21ONWxxUjRqL2d2VEdEc0pzRVF6eUJYTi9qQmxlTnhuOHNY?=
 =?utf-8?B?d3Rhc1kxZmVsODRLYlhqd05Pc2o2NDUzUm1KdjJXY3NkOWxSWlkwMHZzNFRX?=
 =?utf-8?B?c3hOVFg0Yi9XbTBpbkRRSjVxaGlpVzZWTkM1M3E5eTVzVDFBSHUrL1NsRTI0?=
 =?utf-8?B?ZStJTXQ1TXNKYmVFS1EzNlJuOGNZWC9vaVJLR2s3cW9nbEp0azR3amdxd1pB?=
 =?utf-8?B?RUREZW5HLzZzMmxuTlJjV0FUNVlsZ3Vid1NCa3BYWFljOFRtaDhMdGFYTlBD?=
 =?utf-8?B?YU1MMVN2S1pEUGpZWTZwbUZERFF1OTNHNVlKMW42N2dwNExucDB1NFZBZlYz?=
 =?utf-8?B?Z0ovY2VaNk9jWFQwVXp6R3RybnI0czBrZmlzL1ZRbk1KM0QwQnhzb2JzQk8r?=
 =?utf-8?B?QWNaUjB0MHNQY2V4NkxyQTJBMFE3UG92TTV3WWQ2Z1NhRGo5YTVVZmFINExv?=
 =?utf-8?B?T20yZ1R3a0xUaWdsZEhObkh4aktsWXFjVUp6TTl6L1ZVcXorM1puRitsQlFW?=
 =?utf-8?B?M0NEcG5FcFJaTHIyYXRlWWFOaGVuQnRkVC9pSUQ2ZjdxYmpwYkZSQXlodnk0?=
 =?utf-8?B?Q3VCVzRGTVdITElQWHV0bGdqQXFHMTBsaHdXWXAyYjNsaG9NK2Q3eFlWOG9B?=
 =?utf-8?B?aWhXNmVPY0dBZ25pZ0d1WnhZNWJYcGF5SmlWdnZNOWRtQU9WT1ZYT3ZxWmtK?=
 =?utf-8?B?aytIQTh2d1JzclEvR0FpM0FZVlY5UHMrNUpWU0RqdW9kVTVpcHVpRmhPQ0hB?=
 =?utf-8?B?Z2ROK1B5UlpVRVV5U3JKMDRlZnh4VExqQmpsY3FSdWdBL2Z3QVZUQTc0Kzlk?=
 =?utf-8?B?RG43dC9XTFF5VEFEZHVwOG9qQkF6U1IwU29sVkErajRjSWdlSzg2eHEvY0VC?=
 =?utf-8?B?d3RNSGRtM05GRWhocDZnMU5QNnA4SWJrTDRIckFyV2R3NGV6Qlc4VldQbDFj?=
 =?utf-8?B?MnIySTFvcTVtSmp6cERjNEs4RWFwOVdMMldXTGNSMmZldG5acFlnKy9qeUVQ?=
 =?utf-8?Q?ZbFj372vR8HBf9OtgZhf2CzcdGgyLPds9CUjTFc+Ak=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f1f6eb-c367-41b6-26ee-08db6be2bfc5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 07:49:42.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJYXQAvw/RJdNygiVKyPFu9Q5u+gFr+XRORDcvwVl+Dp32RtCQbYFZztth+q9WwpeY3KiuiS0Bay30IDil9UIye+JW5B3cCNy5ann04/X1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9574
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 6/7/23 09:07, Laurent Pinchart wrote:
> Hi Michael,
> 
> Thank you for the patch.
> 
> On Tue, Apr 25, 2023 at 11:45:14AM +0200, Michael Riesch wrote:
>> Add the controls V4L2_CID_FOCUS_SPEED and V4L2_CID_ZOOM_SPEED that set
>> the speed of the zoom lens group and focus lens group, respectively.
> 
> Ah, now the UVC relative focus and zoom controls could be implemented
> ;-) They still don't match the definition of the corresponding V4L2
> controls, so I'm still tempted to deprecate both.

There is also V4L2_CID_ZOOM_CONTINUOUS that could be mapped to the UVC
relative zoom, if I am not mistaken. I had a similar
V4L2_CID_FOCUS_CONTINUOUS control in mind briefly, but for our use case
this would not be general enough.

>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 10 ++++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c                  |  2 ++
>>  include/uapi/linux/v4l2-controls.h                         |  2 ++
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> index 3ea4175f9619..a17620ab03b9 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> @@ -174,6 +174,11 @@ enum v4l2_exposure_metering -
>>  	will not transition from this state until another action is performed
>>  	by an application.
>>  
>> +``V4L2_CID_FOCUS_SPEED (integer)``
>> +    Set the speed with which the focus lens group of the camera is moved
>> +    (V4L2_CID_FOCUS_ABSOLUTE and V4L2_CID_FOCUS_RELATIVE). The unit is
>> +    driver-specific. The value should be a positive integer.
>> +
> 
> Could you explain your expected use cases for focus and zoom speed ?

As I outlined in the cover letter, the speed of the lenses can be
adjusted. This can be used e.g., in the autofocus algorithm, where a
coarse scan and a fine grained scan can be implemented using different
speeds.

The adjustable zoom speed control is simply there to give the user the
choice to zoom in/out fast or slow.

Should this go into the documentation?

Best regards,
Michael

> 
>>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>>      Enables continuous automatic focus adjustments. The effect of manual
>>      focus adjustments while this feature is enabled is undefined,
>> @@ -287,6 +292,11 @@ enum v4l2_auto_focus_range -
>>  	not transition from this state until another action is performed by an
>>  	application.
>>  
>> +``V4L2_CID_ZOOM_SPEED (integer)``
>> +    Set the speed with which the zoom lens group of the camera is moved
>> +    (V4L2_CID_ZOOM_ABSOLUTE and V4L2_CID_ZOOM_RELATIVE). The unit is
>> +    driver-specific. The value should be a positive integer.
>> +
>>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>>      This control sets the camera's aperture to the specified value. The
>>      unit is undefined. Larger values open the iris wider, smaller values
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> index 794ef3ab0c02..3ef465ba73bd 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> @@ -1048,6 +1048,8 @@ const char *v4l2_ctrl_get_name(u32 id)
>>  	case V4L2_CID_FOCUS_STATUS:		return "Focus, Status";
>>  	case V4L2_CID_ZOOM_CURRENT:		return "Zoom, Current";
>>  	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
>> +	case V4L2_CID_FOCUS_SPEED:		return "Focus, Speed";
>> +	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
>>  
>>  	/* FM Radio Modulator controls */
>>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 793ee8c65e87..8d84508d4db8 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -1001,6 +1001,8 @@ enum v4l2_auto_focus_range {
>>  #define V4L2_CID_FOCUS_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+38)
>>  #define V4L2_CID_ZOOM_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+39)
>>  #define V4L2_CID_ZOOM_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+40)
>> +#define V4L2_CID_FOCUS_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+41)
>> +#define V4L2_CID_ZOOM_SPEED			(V4L2_CID_CAMERA_CLASS_BASE+42)
>>  
>>  /* FM Modulator class control IDs */
>>  
> 
