Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB06772441B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbjFFNPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbjFFNPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:15:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC323118;
        Tue,  6 Jun 2023 06:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvvnnelk/5L387+FYZiy8wF4RG0M+WV9IigfQxNh+lt3ZdAd3yBbug2IPY/x8oPIaK4AJgFKaX1XfCrcbBLH25MpKRs7Gg+GMxggfB9e+stv7Mb8zTclfvrprgXLrdZ4M4iK42xFNP9njw9yb/FRcHEZkHBd2pGbZa9T5+DetCTdMK3PUuRl6sOJoYXV3BM0giOfdNaR7/IqHGTWQf/bpDy1vajpp2YSbrrer7M1/MWjcXFbVwjq7JvqwnH5jXZmDNV5Uo3Dambkl4JI/EKhEdMwwE3nCaVE0oORlE4kEHiIqic4rMUWR2/gGKAXjI6dqTmLxOgR8s8Ub7NqUxItsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te8/71s4BXBxZKGPWeA9lpFtRxclWjHoZaaAxG9xZWA=;
 b=MaworRIC/n9EaQiFu8RoXEv5IEAads6LpSE98JFMpYLSjR0BAPkR5sFJgBbAnYUqb53VwgPKYizDmXZ0spCSCPmm4KChcPmqo0jQXPfqnYTONbviCvTPMFFOeuKDSOP7krPmmy5sH1SwypODQrs0ystrvoOWot1MJ3wMyycLYJSMNitNk5rtdKoNViS+J9iUqyyTENetEL0I0KH7O+KEJGBSoPG++gTehQnwUPih2U0iaOwFv0BeB1ZjJLFYrSxOg2S/oLjdUc4kPn6MSEmJN3X/2tWN5bnP+S2u+BHFGctXvG2hXXGlKbekMmLzcgQDldXyB/xdW5GTT0wSAK9bzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=te8/71s4BXBxZKGPWeA9lpFtRxclWjHoZaaAxG9xZWA=;
 b=UluTwkk01vs7PFPGilZPuyRfm8ojciQLYnYBg59TPXM1lbRmIq1pDjFesGofF+CtSnz7uffIfgXruVkW72dUtTfPc+cznwZ9wWfxWbzf7mLn4EWXIQ1Rmvd7UYoAM/0OulO6Yl3z8Bu6Q/45Q1HVj8D6oI5yBDJWGWDRfvkGvts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV2PR08MB8461.eurprd08.prod.outlook.com (2603:10a6:150:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 13:15:36 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 13:15:36 +0000
Message-ID: <46e0aac3-e238-1f32-264c-eed8a849d156@wolfvision.net>
Date:   Tue, 6 Jun 2023 15:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2 2/6] media: v4l2-ctrls: clarify documentation of
 V4L2_CID_FOCUS_RELATIVE
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
 <20230406-feature-controls-lens-v2-2-faa8ad2bc404@wolfvision.net>
 <20230606103618.GB25774@pendragon.ideasonboard.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20230606103618.GB25774@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0152.eurprd07.prod.outlook.com
 (2603:10a6:802:16::39) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV2PR08MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb6d506-5a0d-496a-49df-08db66901d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2c7V0EUpJ5+XW8xUnf1Wtsu4/ujFw0sUWEaFDwo6Q1QzIMiSdOOTvWErGAdjMADuogEoF1XkJwZ2bpk6wGwrEMAcyxsX4096agVC/sGUi0D/5NpDbRovoeZd/4lk78EAvrIJHGfH7tUHLOn3CCTTSluhvGVjb/CDKS6vbXMamGjvPeJmo+0IkINICVB2NbwN7K1G5uR+5MHZkf4voO5DJ5jZBSupUZc/aNzUkjUqcbZxdzs/Jq3LcMc/Weofoo9TUY5Q5Wktr3FsZvBLwfRQe6R3j/KykVS2GJpmS6WFHpbz/JuRYwl9VR91qYJ/zbeQ5PbuSiptT+7ywccguCftu3LMR7Vi6DcgSP6djaBBwB91Wp8icBBCmff46rxI3B9CyUsuyzMVRWyuX+l//OLMNE8Nsn51orD2ACnLm9bQYunwbPMUTjSkR0sQdmieZph7U09iJZLHJZSA5+H1xh4D9H8N6MN50OFQ50RZqeVyUtuwGi4VK+15QbYsyLhKkVKkmHJFVR79AgaL6FMSK7W/WMegbPLGiTGn7JsQoW6Q0qaRpmen0GS1Vk3MN/bxxi9FvZm2s+etSnb+Vk2nwf1yC7pmIZn079q3LhDqYlpA+ppBE4/4KAceSbtCaOUiLvfsaDCYGoEwhlLqo54nsvHDMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(451199021)(2906002)(478600001)(66946007)(6916009)(8936002)(4326008)(316002)(31686004)(8676002)(41300700001)(5660300002)(54906003)(44832011)(66556008)(36916002)(6666004)(66476007)(6486002)(53546011)(6512007)(6506007)(26005)(966005)(38100700002)(2616005)(186003)(83380400001)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW5IRGlGck5KMytmQmZEbVhjc1ZCT2YzUlZhZXcwbi9oRmJTVnJHaE5HRTZ6?=
 =?utf-8?B?NHBzME1IVjBNUGRLQVNrekVPeDlSUjBJaGVrOUJXZTdtMk1HRVVHZjlTd0FW?=
 =?utf-8?B?UlJNRWpoYk04Q3gxYThXd1djeCtOT3U1R3pGSDhaUHhBd1dVUzQxbm5BMG1I?=
 =?utf-8?B?ZXk2RzN1cDYxN21waitkQ2Q0MHhIeXVZMjZKNkJjVU41V0pXbE9wVS9kZjNi?=
 =?utf-8?B?TG5KQ3AvUS9YZ2RvUDl1cE5zNG1kdlBIZ0llekFROVlYOGJDZmV3dVB3YmFz?=
 =?utf-8?B?NjhndXpVeEs0ejBDMHR0UWRRMUFENUJIL2FkRFR2aHdvWHpjRzAvTWNDdGEz?=
 =?utf-8?B?S3VaSWIwRG5FVFBCSVJBQ21XdlFqSVoxdmVJTWFHSVp0S0o5YUlZWVBBa2Uz?=
 =?utf-8?B?VmxjWkF3RFhHQWlRK2luRE1wQnYybWNwWjFHSHllL2RwR0FpM1VlYW5uMVlT?=
 =?utf-8?B?bVhjVE1FRElRUEltK29DYXVpTWJzVFNzOWtTbnl4ZFFDdmhEMHRxOHNQaEQv?=
 =?utf-8?B?OERESlBDYjN4SjlZL1lnMjRZUG41K0FwdGZ2MEdzb0JzN1Z1ZE1HYmxncHRL?=
 =?utf-8?B?a1FWVWRpYTg0bjJjWG5ST1ZpdTk5L0xhNHhlNElvTkwyRmJlYisxL1ZxYzdu?=
 =?utf-8?B?RkMxQko5ZmRwTEpWZHo2aGplMmpiVC9IOVlBMEx0bkFvYnQ3cnFWMWpzZkFr?=
 =?utf-8?B?QjYzMzlDZzB6MGJRK1Ivc2xNeWI1TVVDS0JLcTRqREkrd01VSlFUMHhSWFR4?=
 =?utf-8?B?YzgyQlJHdk1Jak9jOFhlMU9vcklNY1psR0tDOWRRSCsyN2x4WXYyUGJjZ0hE?=
 =?utf-8?B?c2xJcmJjOXZzZDNFcWx3U0pRVXRYUDJGMmF0aUw1U0JJcld4K2d0YUltVlVT?=
 =?utf-8?B?NEZEZ0IyTmd6VW1rWkUvbC81Q3hjM2kvdXFEV2p4MmVGdUJCSUxLZ3E5SUla?=
 =?utf-8?B?dXN0RHNoVW1vQ0ZqU3NqNkdIOHNIandTVTBRS2hQUFBGN0lLbjh2Yzl0RnR5?=
 =?utf-8?B?U1JsMHhQQWpPK2hOcUtPc2pXaitNd2xRZnNwOHdZdDd5TXlPUjRmWkdNcWRP?=
 =?utf-8?B?cGxseWZuRENLOUdlcXhnanZxNzBXbUV1WjdhWlRpY0ZqSDZRUVRFL2g0ZEdz?=
 =?utf-8?B?ZDVDRithc3psSkcydUlRYnpmSmsybUtKTVllSzY4bDBOclcybjdGQkZUQjht?=
 =?utf-8?B?RkRObVJJY2RZWHNta2dwK3BYNTZYa1Q3Y0I0ZXF0b3NBR0loZnBtUkJuc1RM?=
 =?utf-8?B?NnVJZHRPa1BBbVlUWWNwZ0EyY0d2dXc3NTNOdUVCbTdpWUVQVmRmR1FiUDZB?=
 =?utf-8?B?NVFSWTVJNm1iU284TVI1S1NBa0F4NS9LZkxjUFFEVm5CZXpybU9XdmNSQUpo?=
 =?utf-8?B?SlhpR0VzRTlLeWhBd3I3dXlxQ3R3WUp5Q1JvZTI1UnZaclhkUnVSSzRaRU9U?=
 =?utf-8?B?OEhEWGtDbnphQ2h5ZzVMcUcrZlZsZGlJeWtXWUJSUll4aXBsdmVqak5XNWVl?=
 =?utf-8?B?TmNZQVkySnFub3BIZ0dhaXlwRUNZanlWSWExUnp6MmZSSUdpYUV3S09DQ3JJ?=
 =?utf-8?B?L0VDMWszSVRpQ3ZjREcrYUI5NzAzVEdCZVVvZ01INk5YeGVJWXFaV2RNVnRE?=
 =?utf-8?B?UUhZQ0VZS3VKRDFLM0ZTWlBTblJNOWc4VnI5ODd0eXdIQWg5NERZMkd4UE5D?=
 =?utf-8?B?R2FKMGxhQ1lyK1ZySHg0ckJhNDF0a3BycHpUOFl0dERwYzRVZ3pHMXlTUmM5?=
 =?utf-8?B?NWdLYjFuSDlqUnRzdjVrMThmT2RxbWtLWXJ2aXQ0SXpkNG0zVFdSYVhTTEpB?=
 =?utf-8?B?bHE0R0pGTndLNTFxQTZ0Q0liVGxqa242aXA1V1g4RnNjcVVlZXFtWERyRzMx?=
 =?utf-8?B?SGFBRzRtZC9iUVBJcHNucjZJUWNKczIzbFNjMlF0dVFyOFIwZXZhZ3I5Tkhl?=
 =?utf-8?B?R3lPeElyWUR3YkR1NGRLWitMaFk5dFVGeGRiT25YU01iQ1F3MkRMdndUUkx4?=
 =?utf-8?B?YTBQQkNIdjRIbzBZaEZJMVdSWHB4SU9nV0VtZXR0dzIxSmtDdFRvYkYvL3Nl?=
 =?utf-8?B?czNRVlB1OGVTK0ZtN1N3MXFZSEVneXcyZEtzL2dOaVRkdHBHcDBHTlRDREZV?=
 =?utf-8?B?RTQrY2tPT3I1dERYWlhQTkdrYkFEY1JOZms2a1JoS2VYVXp3dE9HMGpUNjJr?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb6d506-5a0d-496a-49df-08db66901d97
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 13:15:36.2399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b4/YbK+mC5keGT5yc1MY2hsqXrl+pQ4eQUNRdr7fhFO3+6F92bBXe5bj6KlnLu4kpxXK4pY9FGo8631uIS3VyYa38Qe2KaukSx0fx1HHiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8461
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

On 6/6/23 12:36, Laurent Pinchart wrote:
> Hi Michael,
> 
> Thank you for the patch.
> 
> On Tue, Apr 25, 2023 at 11:45:12AM +0200, Michael Riesch wrote:
>> The control V4L2_CID_FOCUS_RELATIVE only makes sense if the device cannot
>> handle absolute focal point positioning with V4L2_CID_FOCUS_ABSOLUTE.
>> Clarify this in the documentation.
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> index df29150dce7b..42cf4c3cda0c 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> @@ -147,7 +147,9 @@ enum v4l2_exposure_metering -
>>      This control moves the focal point of the camera by the specified
>>      amount. The unit is undefined. Positive values move the focus closer
>>      to the camera, negative values towards infinity. This is a
>> -    write-only control.
>> +    write-only control. It should be implemented only if the device cannot
>> +    handle absolute values.
>> +
> 
> Extra blank line.

Will fix that.

> I don't think this is right. The control was added for the UVC driver,
> and there are devices that implement both absolute and relative focus.

I am by no means an expert here and just following Sakari's suggestion
here (see [0]). I can drop the patch, leave it as-is, or modify it.
Whatever makes sense to you guys. But maybe I should leave this to
someone more knowledgeable in this area and drop the patch from my
series. The changes above are completely orthogonal to my work.

Best regards,
Michael

> 
>>  
>>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>>      Enables continuous automatic focus adjustments. The effect of manual
>>
> 

[0] https://lore.kernel.org/all/ZDbChgZJHVaaX3%2Fx@kekkonen.localdomain/
