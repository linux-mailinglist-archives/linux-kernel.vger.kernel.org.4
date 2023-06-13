Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F872DD89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbjFMJTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbjFMJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:19:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A0BEE;
        Tue, 13 Jun 2023 02:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3AwUYK/EuqDbOXr+PcyE6IgiYSl/MNSESuQPqTgyq/6t+NfarY2mtpato3rmM65ePkeBUYZcV96DJKpR6gxjwgSaF6nY+4jKMkU6wihfafCaninCVcXyLkaf6kltUw2Cfmd2tyNns7JOQ9CLqEHdJ8hi+zkODHC8b3XEu1y8mXqMiVFeVE0huWm6fqV1Cr1V/apTriokwXxZZUUFDNLQPKKpliQtMgb8qHgR2QmG1Kzy9UB04GYdKWCCt/tan4hNhO340yyHB6Qj46X2iKgiwU18L2s/STtNpcWD1a98Q9h6ObcSPu44FqcRAJ4asKZGBTj0KhesSGv7qbFhbVkaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTnVTph5vTo8JGaiuFDXULcRl+HtIqY0UahxVpc5CtE=;
 b=Flb3ij+qsDK3WWxmK1Elgqa7TamgHVS3/SIVS+rO+Fty1nfUVP7qMbIxerPvVzizctyWpPaGbsA7/PBaacyvszvpZVAz3eObmJLWWa7yxpZ2rmXOi6NLlDL8miajQXOEiEQtXvz4ZXCEOKTkJ/CMYlEFEoA+NOY0dIkv2EXD5P3nKLz+OKMJzoAOT8NBSasQoJYiYwiller5F6bUPt4CNlFemTDqL/IVQKytDhRk/wi6Wg0GKWgz/u9mLsU0pTnw5mES9+T653aYGHrizkdFyWULHbLj4vkFwpUMtOtOkeXt5PiT0VuzR+FdwXWZRFeRz5CrmhXS+OKku0wPXT0c4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTnVTph5vTo8JGaiuFDXULcRl+HtIqY0UahxVpc5CtE=;
 b=Y8Ibw5loLvEQLYnuSDKGc4Fj7o3SNUL/+vLVULle0Nm4pGnWYMzE6EsTcNzewZySDWl3Dtf5iGkL3PB2Omm8Fe7GqEktE6/omEMi0NrPCYMgqbho0eKKQdym66Vy8U5tvl5jIB1c++m0IYoUxr+tnbKxZZaUnVxxBgcB6Kx7PPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DBBPR08MB6268.eurprd08.prod.outlook.com (2603:10a6:10:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 13 Jun
 2023 09:19:26 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 09:19:26 +0000
Message-ID: <6ec4a2d2-3777-afcd-fda5-0eb6d9245042@wolfvision.net>
Date:   Tue, 13 Jun 2023 11:19:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2 6/6] media: v4l2-ctrls: add controls for individual
 zoom lenses
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     libcamera-devel@lists.libcamera.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthias Fend <Matthias.Fend@wolfvision.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406-feature-controls-lens-v2-0-faa8ad2bc404@wolfvision.net>
 <20230406-feature-controls-lens-v2-6-faa8ad2bc404@wolfvision.net>
 <1fd2e387-4f9c-b016-3d7a-f03c6bffc8f6@xs4all.nl>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <1fd2e387-4f9c-b016-3d7a-f03c6bffc8f6@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DBBPR08MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c3dd84-4fd6-4be8-1f35-08db6bef48b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ixdb5YB/OtO7tHwVBxnVIBwEI2SfYF5nxdveuiTFipmLKjbSqFpv0kGRBY4AP2mBimk7npNwxIDKllV1/0XKkUHs3O7dkDEsvGpkoRg48oOvxzvB60ASB3DhUiJYmmGvXWfDB/GuHIeVxW+3FcPyxj9NICmw0xURZq9DHjLgl1qYnbg1TIVIawpXsyTNteyoEcgvqMKafYH5wIZpheuAi/QBiAqbmyYv+qNaIPeuenZ6rMaS1gyS3ewnDDlFLTDuZ4PRUd/Vjfn3OhGW3ABaa2Lv1wPclQ1gwxf6PA10xw+CZAn+Q+AiXKuGnsOUWziNQqNYgnN8AY3R2LCRbGWK4kbJsCzUG9YfFkWl624xPDKWKwOzoQ/p93Z8zFRyX44sxqEaFFHOSbs1TPxZHczT3tuTsKptHg7T4io9vnLFv2flFJ9TCI/agcWDA9RTcadqfow/31vaXuCHYx1xqN7Tt+68ak0C96pvG6/eUHU7Jd/Lsrt64bsSrBbFeNF80Uar4QYp8XHXdcPcN/Yi7Z7z48iUIpg/MUnqI9f1nDlS6KSksz2RCBWa+IHHTgkGfQzYOSZjUUqo4U7iQ89wTCFY5rkmom4xEcGm/0ezGRf99pW9m61mtFKgRrEJdixBCE4T6P9x0tRsp0pgLl/pyHjubQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(39850400004)(396003)(136003)(451199021)(6506007)(186003)(6512007)(31686004)(2616005)(53546011)(83380400001)(41300700001)(36756003)(44832011)(2906002)(54906003)(8676002)(8936002)(6486002)(110136005)(478600001)(5660300002)(316002)(38100700002)(4326008)(86362001)(66476007)(66556008)(66946007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZzS3RGNFJkRENVNTEvaHBsQSswWERtcm5pZEJRUG9YdEc5TXA2WWtUQVNK?=
 =?utf-8?B?Y29adE0wNHFGZmxSTjNiUGh2UXU5Q0RMK1NJaXlqQWVxeDErS1lpS2I5T0tn?=
 =?utf-8?B?N0JUR0dTK2RPRkp3QnBXbmpJOVppNklza2ptR1hzdlJTRXJDUEtScUtpdlJk?=
 =?utf-8?B?T3FxRFFHRjJVc3lhemlUdkJNbTNZL3l2Z0JDczA1VUFFZTdjejNOUFV0akk5?=
 =?utf-8?B?WnAvM3VSWFNaYWN1UmdOS2RnVG9XSXZPdGFqWWMxZUpBOUxTdmx3bmNFTDFo?=
 =?utf-8?B?YnFxeW1qUmwxOXhhMGlQaDl6dHFsSDZNMm1tdENuVFNLTktKU0dKZTVCTVFN?=
 =?utf-8?B?b1h6R01RYlNBcDhFNkU5bm5PMzJ3RStxakZDTkg5cGZCTVQzcjRyNXo5anhq?=
 =?utf-8?B?WmhFdWFNem52T3JocFl6WHpTWU1paHBkZXp2THdkQmE0YWtJd2tpWTgrQmpI?=
 =?utf-8?B?RVUydE0yR3ZFZEdFV0R2VzVjcEExclNLN0E5bk9ieFFlcmJXSEM2K3lyVGg3?=
 =?utf-8?B?TEhMQk80TDY3UzRUUmlReDhoS1MwTlR3REpqMEo4bkorZDVWUGFndFRwdUpR?=
 =?utf-8?B?VjFOMXdCd0Yrckh0U2dBdHdnVW9uQlFwY25pYXlaY2hOR3Z6OTYrZGNoQzFU?=
 =?utf-8?B?Nm0ySmZyUGlGdEVRZ0NNeC9McG41Yk83WHJkWlJQcUlzRDY1Sk9Ub2REKzdD?=
 =?utf-8?B?ekRRUkthR0ZnWU5UWTBoK3lESkpUQmZZRTM1d2wzT1hvQU1oK1c5N1REZzVF?=
 =?utf-8?B?TDlzcEtLbUdWZWdZYUhZWjAwSy9jTENTNXRDN2FNcWdqUzRZK0l4T3lveUJm?=
 =?utf-8?B?S1RucVh4d0xxQ25SeDNKRHFiZUdyeU9lZjRtSUlaK1Q0QjdzT21UcGZzZDlQ?=
 =?utf-8?B?MHhJQWFzTUNOd1I5ekZhYnVWdGEybFRLVmdVS0NzNzVMWUF1UjBvb21XOHFq?=
 =?utf-8?B?UHg4QU5vREFXSmtJMzJPbWJkWjJ0TTZlOVVkMVFCVHNXdzY5dmUzY0k3aEhm?=
 =?utf-8?B?UXF4eWpWYmRVT1VHTXF6VjdLRURySVRxY1JYUDVaREptcFlXRTBjWWM1VEdX?=
 =?utf-8?B?TTc3eVZlUUp4bk1IdkNXaWhRbGVhc1JHN05NcGlORDBVNGs1UmxrMnVrZjhk?=
 =?utf-8?B?amdDZVZLYXhVWk54b09xWVdMa1FwdTNaQnBRZ2YybjlCeElkY3c1VWZINVcx?=
 =?utf-8?B?RDIwZTc4ZmFlOStmWEpBd0VBSTY5SlZ1WjE3WlhZQXJKdnBXNHFKa0MvYTc0?=
 =?utf-8?B?ZzFNQnhESENsWEtCYVlJM3BDZ2VCbEdyTDJ5N0pFNWpWR1VLbHZhK2JVaEpy?=
 =?utf-8?B?eHNZblZsczZtYktsdFRpWmJkMmdkQmQrRDEzMnVZR09BaW5nbnJxSzZOOFNL?=
 =?utf-8?B?ZlgvdUs0Qjg0QThHZ1YwQ1V0YUQ5Z2NQTG4zU2VQTXBZMlJpaTUvanpoUmRU?=
 =?utf-8?B?RHFQWHh2bXpPNVdqUWRMSEsrRWwwb3djbHBoNGVkTm1XUmtSbm1vdk95c3ZL?=
 =?utf-8?B?RGV0TUVVenlQelNodndqa0ZjT3h0VmdoYmYvMTdVYVU0aVJHaEx5dTU5T0w5?=
 =?utf-8?B?YW9OcXh0TG1iMGhMbEQwSGlGQ09CRHdFZlBCL3hWSkFoWlVJYzlNNDcwQWRy?=
 =?utf-8?B?VHJNTCs2aVQ1WHZCNGdtRkR4Wi9PTkRmV1VOSzM2SE5McEs1dmhSck54ODFM?=
 =?utf-8?B?Q051VlB4WU1mL0VGTUtJRW50RThuRkJzMWpPdEtmVkZhbjUwc3NZMUNIWjE1?=
 =?utf-8?B?Z0syQnNlR0V6NXBqd05Jb2hQYmpJOGs0OWNmZndEZmFqb3BSOTVvc3NhRkFI?=
 =?utf-8?B?UXh5dnY0NHR4Zjdtd0RxdEltM09ZaXZ4dFB5VElsZllWUFhraEhIa0ZNVjF5?=
 =?utf-8?B?SHdUQkMrYXFLNmdIZXROYlg0cGlBbmdIOEhXVmpyeG5yTFo5d3JKNXBzWUlX?=
 =?utf-8?B?VWgyRWhtT1hEN3FWeDQ5aURXTFB6QTRsMmxtNlNXVThnVnp3RzAreUhwRnM4?=
 =?utf-8?B?empZSk8xQnE5c3FzcGVOU0hMUmY4VVlGbXhKMndlTHd4SGN3aDJWRngxRTVU?=
 =?utf-8?B?SUFQVGxlRDVPQmJrMmEwdVdjZ0xZb1JzdS9RMVA5amJSeUJleDZLWi9IeDB0?=
 =?utf-8?B?VDNRdHhZR3QyckhoMnlLeW5WNmtvWkVwM3A0QXF1MTA5SVkzY1dTMEtqVk9j?=
 =?utf-8?B?UG1QeTlITS91SEhRTmVtbkpNKzRmaGo2RXd0MGc1WmF6ZDZ5Z3VYYTZhRWRx?=
 =?utf-8?Q?PNptE2d/ygc124lDQm02uD+Q1p0hW2zHOXVVH+whWs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c3dd84-4fd6-4be8-1f35-08db6bef48b2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 09:19:26.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVnBPnnm64Mt+ZAlC5nDeuz828MJ5zxW64p7LpdaynlzcRvtftCa4CjUh9DLFdqktsNVbsg1h3w28XC0W0eGFudmkpXWusGbkKjyOsm+AoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6268
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 6/6/23 12:29, Hans Verkuil wrote:
> On 25/04/2023 11:45, Michael Riesch wrote:
>> A zoom lens group may consist of several lenses, and in a calibration
>> context it may be necessary to position the lenses individually. Add a
>> tuple of V4L2_CID_LENS_CALIB_ZOOMx_{ABSOLUTE,CURRENT,STATUS} controls
>> for each individual lens, where x = {1...5}.
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 30 ++++++++++++++++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          | 25 ++++++++++++++++++
>>  include/uapi/linux/v4l2-controls.h                 | 18 +++++++++++++
>>  3 files changed, 73 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> index 8b54a0f3a617..21391f076971 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> @@ -332,6 +332,36 @@ enum v4l2_auto_focus_range -
>>      * - ``V4L2_LENS_CALIB_FAILED``
>>        - Lens calibration procedure has failed.
>>  
>> +``V4L2_CID_LENS_CALIB_ZOOM{1...5}_ABSOLUTE`` (integer)
>> +    Set the absolute position of the individual lens of the zoom lens group.
>> +    Most likely, this is done in a calibration context. The unit is
>> +    driver-specific.
>> +
>> +``V4L2_CID_LENS_CALIB_ZOOM{1...5}_CURRENT`` (integer)
>> +    The current absolute position of the individual lens of the zoom lens group.
>> +    Most likely, this is done in a calibration context. The unit is
>> +    driver-specific. This is a read-only control.
>> +
>> +``V4L2_CID_LENS_CALIB_ZOOM{1...5}_STATUS`` (bitmask)
>> +    The current status of the individual lens of the zoom lens group.
>> +    Most likely, this is done in a calibration context. The possible flags are
>> +    described in the table below. This is a read-only control.
> 
> Wouldn't it be better to have this as an array control? That way the number of
> lenses is set by the driver and can be easily read by userspace.

Are you referring to the _STATUS controls exclusively or is this a
suggestion for _CURRENT and _ABSOLUTE as well?

This would mean that the user space can read out e.g., the status of all
lenses in one batch, right? This would make sense to me.

I am not sure about setting all target positions at the same time ->
I'll have to think about that one a bit.

Best regards,
Michael

> 
>> +
>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>> +
>> +.. flat-table::
>> +    :header-rows:  0
>> +    :stub-columns: 0
>> +
>> +    * - ``V4L2_LENS_STATUS_IDLE``
>> +      - Zoom lens is at rest.
>> +    * - ``V4L2_LENS_STATUS_BUSY``
>> +      - Zoom lens is moving.
>> +    * - ``V4L2_LENS_STATUS_FAILED``
>> +      - Zoom lens has failed to reach its target position. The driver will
>> +	not transition from this state until another action is performed by an
>> +	application.
>> +
>>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>>      This control sets the camera's aperture to the specified value. The
>>      unit is undefined. Larger values open the iris wider, smaller values
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> index faddfecba6d9..8a78cffcd3e8 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> @@ -1052,6 +1052,21 @@ const char *v4l2_ctrl_get_name(u32 id)
>>  	case V4L2_CID_ZOOM_SPEED:		return "Zoom, Speed";
>>  	case V4L2_CID_LENS_CALIB_CONTROL:	return "Lens Calibration, Control";
>>  	case V4L2_CID_LENS_CALIB_STATUS:	return "Lens Calibration, Status";
>> +	case V4L2_CID_LENS_CALIB_ZOOM1_ABSOLUTE:	return "Zoom1, Absolute";
>> +	case V4L2_CID_LENS_CALIB_ZOOM2_ABSOLUTE:	return "Zoom2, Absolute";
>> +	case V4L2_CID_LENS_CALIB_ZOOM3_ABSOLUTE:	return "Zoom3, Absolute";
>> +	case V4L2_CID_LENS_CALIB_ZOOM4_ABSOLUTE:	return "Zoom4, Absolute";
>> +	case V4L2_CID_LENS_CALIB_ZOOM5_ABSOLUTE:	return "Zoom5, Absolute";
>> +	case V4L2_CID_LENS_CALIB_ZOOM1_CURRENT:	return "Zoom1, Current";
>> +	case V4L2_CID_LENS_CALIB_ZOOM2_CURRENT:	return "Zoom1, Current";
>> +	case V4L2_CID_LENS_CALIB_ZOOM3_CURRENT:	return "Zoom1, Current";
>> +	case V4L2_CID_LENS_CALIB_ZOOM4_CURRENT:	return "Zoom1, Current";
>> +	case V4L2_CID_LENS_CALIB_ZOOM5_CURRENT:	return "Zoom1, Current";
> 
> You forget to update the number, it's all Zoom1 here.
> 
>> +	case V4L2_CID_LENS_CALIB_ZOOM1_STATUS:	return "Zoom1, Status";
>> +	case V4L2_CID_LENS_CALIB_ZOOM2_STATUS:	return "Zoom2, Status";
>> +	case V4L2_CID_LENS_CALIB_ZOOM3_STATUS:	return "Zoom3, Status";
>> +	case V4L2_CID_LENS_CALIB_ZOOM4_STATUS:	return "Zoom4, Status";
>> +	case V4L2_CID_LENS_CALIB_ZOOM5_STATUS:	return "Zoom5, Status";
>>  
>>  	/* FM Radio Modulator controls */
>>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
>> @@ -1607,6 +1622,16 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>  	case V4L2_CID_ZOOM_CURRENT:
>>  	case V4L2_CID_ZOOM_STATUS:
>>  	case V4L2_CID_LENS_CALIB_STATUS:
>> +	case V4L2_CID_LENS_CALIB_ZOOM1_CURRENT:
>> +	case V4L2_CID_LENS_CALIB_ZOOM2_CURRENT:
>> +	case V4L2_CID_LENS_CALIB_ZOOM3_CURRENT:
>> +	case V4L2_CID_LENS_CALIB_ZOOM4_CURRENT:
>> +	case V4L2_CID_LENS_CALIB_ZOOM5_CURRENT:
>> +	case V4L2_CID_LENS_CALIB_ZOOM1_STATUS:
>> +	case V4L2_CID_LENS_CALIB_ZOOM2_STATUS:
>> +	case V4L2_CID_LENS_CALIB_ZOOM3_STATUS:
>> +	case V4L2_CID_LENS_CALIB_ZOOM4_STATUS:
>> +	case V4L2_CID_LENS_CALIB_ZOOM5_STATUS:
>>  		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
> 
> Same issue as for patch 3 w.r.t. VOLATILE.
> 
>>  		break;
>>  	case V4L2_CID_FLASH_STROBE_STATUS:
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 24c0eb5f4d29..7c49c0ba23d4 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -1016,6 +1016,24 @@ enum v4l2_auto_focus_range {
>>  
>>  #define V4L2_CID_LENS_CALIB_STATUS		(V4L2_CID_CAMERA_CLASS_BASE+44)
>>  
>> +#define V4L2_CID_LENS_CALIB_ZOOM1_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+45)
>> +#define V4L2_CID_LENS_CALIB_ZOOM2_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+46)
>> +#define V4L2_CID_LENS_CALIB_ZOOM3_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+47)
>> +#define V4L2_CID_LENS_CALIB_ZOOM4_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+48)
>> +#define V4L2_CID_LENS_CALIB_ZOOM5_ABSOLUTE	(V4L2_CID_CAMERA_CLASS_BASE+49)
>> +
>> +#define V4L2_CID_LENS_CALIB_ZOOM1_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+50)
>> +#define V4L2_CID_LENS_CALIB_ZOOM2_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+51)
>> +#define V4L2_CID_LENS_CALIB_ZOOM3_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+52)
>> +#define V4L2_CID_LENS_CALIB_ZOOM4_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+53)
>> +#define V4L2_CID_LENS_CALIB_ZOOM5_CURRENT	(V4L2_CID_CAMERA_CLASS_BASE+54)
>> +
>> +#define V4L2_CID_LENS_CALIB_ZOOM1_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+55)
>> +#define V4L2_CID_LENS_CALIB_ZOOM2_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+56)
>> +#define V4L2_CID_LENS_CALIB_ZOOM3_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+57)
>> +#define V4L2_CID_LENS_CALIB_ZOOM4_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+58)
>> +#define V4L2_CID_LENS_CALIB_ZOOM5_STATUS	(V4L2_CID_CAMERA_CLASS_BASE+59)
>> +
>>  /* FM Modulator class control IDs */
>>  
>>  #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)
>>
> 
> Disclaimer: I do not have enough domain knowledge to comment on if this is the
> right solution or not. I can only comment on the control framework specifics.
> 
> Regards,
> 
> 	Hans
