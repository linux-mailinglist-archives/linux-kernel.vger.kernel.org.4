Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5204672DB11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbjFMHg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbjFMHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:36:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B304AA;
        Tue, 13 Jun 2023 00:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvFw4NasQS1XtvUi/KGDhSxqh4kPIYmOErGsWUOY5ZbMo0wqWbvaPmd86HhTVMQLHbHNEoxqTJWd2AAuSpC2B0QZXLikfHKpahSDt+EPXBeJdCnjy0gPXptcuIHaIhO9iGRHHKRJiXsLOPsTVQ3WMxb3kDdZpESp5KZW9u+k3ZdY9M+PtJ9hUFcnnRP3hpczd1QzYijr3hLhBnWeZOLRKM09KuvgJAfx28yj63xNjKTx8MMZAC+OYs6eP74XxkMRjPsY/lCWBBqLm9u0x71plvjmMzC98Zriwl0IdzGB3+Dl7SCTmtreH4TSyeDLXZHQszpBes8R96S+fB690BoX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaG4GjPrV8roDzx+6ekz6hfNO29A/16JsdYquwdq7Xc=;
 b=TEpan9xLaPjhmPMsn7UJmNkiecgry6BOPtf8Ox5APiWJiy1OUu8kywInh+jHdhwjEZPYa4cLnJ0EymKYaKrmLZ0bDXmN5GBo27aLuws0/l87eU2eqia9ZAKwVYqhMrzce9GAj9WBtzfXzPsglMxCZfDldaQOMjM875ga5iggjyE1rN311YzBk08SWToqm8WtF1BFj05VNi4HcS4L7Uq8c92dI+S2HgEL0Z67hBX4M5aVZFyZhN5Mvmai5UwEJw3lJabgvPRygk99avlsRZL0GamrawpGZsVc3cxR2heSGB5DR9lzbtDFoJVsWsSIrmWr2yiTLpylP8fo0xLODRpCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaG4GjPrV8roDzx+6ekz6hfNO29A/16JsdYquwdq7Xc=;
 b=KYQtzTnSsR7Q/TNbDRE7aAFW4Az/5TQz57DCtEBJefuF1rcsNFqO9SFFVaaFdND1GCt3qy4MkhlDb/qf0bNGOlLnS2LKS804tWjRd1puovvVhv8nfcUaTGzFKsYx7cAacDMV5xXvSzqdWClu73TsLE8lfkCJPEenI4+h89UNXaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GVXPR08MB7752.eurprd08.prod.outlook.com (2603:10a6:150:6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 07:36:15 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 07:36:14 +0000
Message-ID: <0718981e-a433-0119-ba34-7e28ebbf4a2b@wolfvision.net>
Date:   Tue, 13 Jun 2023 09:36:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2 3/6] media: v4l2-ctrls: add lens group status
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
 <20230406-feature-controls-lens-v2-3-faa8ad2bc404@wolfvision.net>
 <20230607070345.GH14101@pendragon.ideasonboard.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20230607070345.GH14101@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::14) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GVXPR08MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 5514908c-0cd2-4493-59bd-08db6be0dddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ivnd0efCjNA1dt43zGRbwnG+ccN1S2KXtH9QfqnH0tXfevL3a9+J4lZB32xICkNw94SOUkpWDJ80FV62SwIT+InbBmSFI+gXpKYMrPKuAzUzXuT5Thl3WLOF3QUl1N66K9NHSBCnJGznaHcdkLujYXelvBgIHHkT4qiDjddMI2FClCsmjqO24p31NI5h5eYe1gDJavx1RFxfX43d65iHIfjDINpQYW8p8gPQIVm9Nfk2ZaWhQfgCvzub+1hL7GBOqg6T00tkkFvgUz8z+mksmMblEChRvyRTf1J3aHSDbUiXKHINIATfmzBYFbRLdAWv0RMItvS4eyXUGY9jDGkrSS0tgPpLndfqm5jYLGtpOlY17+TQYjl/FZ70vNbA8BMvwCcFUEoV/sa5+5dXTSbNOykT3EqcMP3G6pdnpIoGmCuc08XiOBVLATgG7UlRJZUFrckwhJcEuMaDr1iUY3kgvyDL6lUgEQU0b6yEh9blK9HK2sN0sMft7PQjGih8m1NoGBx4feprfI4hHwEKTNUTpJigD7naD089KKU1gsv5q3KosDQ3lawYKAN2JURZAckck+sa4cE7MFt7EjFnP5LSfCiIyC9ajnzOdEQ6KeIldrn8AwqVtkHYIJ9WRnR15zGnLFYBavLos0Y7MzjVdpG0Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39850400004)(346002)(136003)(451199021)(5660300002)(8676002)(8936002)(2906002)(31686004)(66476007)(66946007)(66556008)(54906003)(44832011)(6486002)(4326008)(6506007)(6512007)(53546011)(6916009)(41300700001)(316002)(66899021)(186003)(478600001)(83380400001)(2616005)(86362001)(36756003)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpwMUFQUXRHUU4yMDBGaEsxZXVtbGxwOVQyeHFWVmNPNzVMS1RTYmxsdDBQ?=
 =?utf-8?B?SHU2UGxpSDlReHRDcVJ2Mjh3OERHRE9MYXB4VkZGYWJKMTNVWEZacWlYNnZw?=
 =?utf-8?B?amdBaW9jcXpIZlM0QnpjT3hKdzdGZG1SWHUwdFI2Tlh0WGE0dk5iY1doNnhi?=
 =?utf-8?B?OWsyQ3NWUEw5L3I2aDIwcWN3OXpVZHJKWFAvc1J5WHB3d0lpdno5ZXh3bjRh?=
 =?utf-8?B?NExHZ3JlekRqcElzZEowOU5qTUFzTzRyNytyaytoaUJtYXFNVUdvb0VoS0g1?=
 =?utf-8?B?UmlPYU1rYnZrTHhWZVhVakt3dnllZ1ZDRnlDTm03WS8wOWY3ais5cXhnYUU0?=
 =?utf-8?B?MU50L2V1RndTamxDTGNaQjlFMW1UUkY2TDgrcEFKcUpnWWNBSlVnRTU3a1Vu?=
 =?utf-8?B?VnNmOXNjTlZmUVN3WTU3MDlvYVkvRE1GT1dlcGg0SGF1RE12WitueTVNZS9X?=
 =?utf-8?B?cklWcXkvelBxZ282YlB1NXZzRnl2MDltbk1NNEhadXpqa1pSNng1U3hGRnd6?=
 =?utf-8?B?RExZZ3pEUE5yZC8yZ1JvdDlKWmpqTGE3VCtwRXhiRXZYQ2U5VDNDb3pHdDZo?=
 =?utf-8?B?aGtJSER2cHhMRDM2ZTNKZmk3SEYxTGFwV2R6RTdMR1pCd1hlbnc2VDdmOTdZ?=
 =?utf-8?B?bE1YN3VRTytNa1JtdklzOEVkdWI3QTlOUm9OeFlEY1FKWWJuNS9UN2d2R1Zn?=
 =?utf-8?B?S1BST3NEQ2w2MUhsS0tHSkpERFlEZXBpK0RBbGp2WERmQ3NNeWdLU1VuYUQ4?=
 =?utf-8?B?bnhIU2J5U1FFSDA0Z3BoREhMZ3M1Zk02QmZXL21XeFVkbWZQQzBOeUZhK05B?=
 =?utf-8?B?a1BpQS9NTmsxZW8wTm9BeWlnSlRyZTRuME9hSkR6c0ZsSHVtOS80R1J1NVdK?=
 =?utf-8?B?S2haekpsaGZQYU5EVS9JUDg4MWhWN1VxUlUxM3BrT2dPOVR4UjdEb3IzdzRU?=
 =?utf-8?B?Qk9JRUh4RDZlcGV6UW0yeFdabTErcU84MzE3ZDdlUUpOMTlORWM3MnlBeHgz?=
 =?utf-8?B?YjNibFlhNTNNOTZvSy9lVGFEQUREV2tDYkxJa0NLaVhXc0o0eXpoK0hSeXRk?=
 =?utf-8?B?K1ZmbzZQRjM5SmlaYUJrYkpIT1VWWDBDUDMyZU9jTjNlNXVsMjg3YkNrWGhT?=
 =?utf-8?B?UHYxRlJmeE54aDU4bXgwWWdUNFpMcWFsZkVsMmZPZHMrZ29uT1FTQitMVE5Q?=
 =?utf-8?B?ZWc4RWVSeXZDYTFTTUFrSWoyRVhBQVBWTG4wQzR3YTI4V1RST3p5eC8vVmVO?=
 =?utf-8?B?RzFMalVLY0g0OVNPcWJzR0xNU3pLN2V0K0NiMUhlU043RUF5eGxKeEduVkdt?=
 =?utf-8?B?MU1rdnl2M0xzK0pscEk3QkprNGpodUcrRzhGWndtZndLWGJUZGZWLzJ3a0pI?=
 =?utf-8?B?enpLTGI5UnBtNXV1YldEY0UzZC9pNFRWMHEzcDRKZVRsaUJsZ3RtTEhHQlRQ?=
 =?utf-8?B?dGY1TlNUSVZCZzM2T3RxUzdSMGorbFV4b2JacXIwQTRYT1VYQ3A3RjNRbk5K?=
 =?utf-8?B?WmdwM2JxeDJiQ1FyeVl2VjNSdTFiUlk2aFpWTlVlSjlVdEtIcldzUTE5UHk0?=
 =?utf-8?B?azV4T24zclhlNzhSRWt5UHRCSFJXOUFoQXgzdmV4bExZWTkyVWVleHhmVUky?=
 =?utf-8?B?MWN2NDh5NVZLZzY3bTZualdwb0VMQldHS0dXUW5ZV1VaSDEyUnRIdEZJMmND?=
 =?utf-8?B?b1Z0MWlaSTQyOWRqemFOZ0dTTVpsZE9SUG5JNUV4NXE5aHRUcGxpQVNGdnhE?=
 =?utf-8?B?YjRoZ0hmVmorZGJRWXgrbmtoNVoxeXRobFFTVVNOeElRaTdtK1hJZEQvcmZi?=
 =?utf-8?B?K0tlNkNweTljc1ZiaG5CV3VzMFY1N04rcTdnTUtwSHdFeXFycHpqOWdIYnAv?=
 =?utf-8?B?WGFXSk9HNkUvb0NqdHR1OFRVTFlDRjUyUWhDVzJXYll0aWZOMWc4TUhoSjdl?=
 =?utf-8?B?ZFMvVmJmUW5LUkRZS0c0SklTZDRCY0RHR05kNy9GWjBDVlZST1pWSzJwOGc0?=
 =?utf-8?B?b2N0bmFtdjBGcnRNMVlIbXR3TDQwVkdUaVRYTDZZbjNyVDQ4SHFiak5aRVRm?=
 =?utf-8?B?dW9MbytoeDNvL0JCenJvS2lJRjh3d1l6MFJxWS9wdHVnRjZUN2hLaXFTd1hF?=
 =?utf-8?B?ZXpwMmF2eGoyNkZVSG8rNEpZOHQ1ZG9saGhWVnorYWM5cHNzeHFHRG16Ui9D?=
 =?utf-8?B?ekZXdnZhbGY3bS9Bdk9jbzNoMlI2MXdVSzFsUmV6czdCZGJua3UrMjhJZHo3?=
 =?utf-8?Q?N4hFWykFtezUIJ7gJlpl7cEqdSwe/tJZzxkGRQ1mjY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5514908c-0cd2-4493-59bd-08db6be0dddf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 07:36:14.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aw4EZLtQkXJwE17xDjqPDrhyaFCJ3tMd9NUVcP3jogSAf4OB8qRgVBU8ipYAqacFh1NEIfN2AXXtM5kJQWeO58/vN3m97/lUucpTnpQCCnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7752
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

Thanks for the review. I'll address your comments in the next iteration,
but please be aware that it may take some time due to other things
needing my attention.

On 6/7/23 09:03, Laurent Pinchart wrote:
> Hi Michael,
> 
> Thank you for the patch.
> 
> On Tue, Apr 25, 2023 at 11:45:13AM +0200, Michael Riesch wrote:
>> Add the controls V4L2_CID_{FOCUS,ZOOM}_{CURRENT,STATUS} that report the
>> current position and status, respectively, of the zoom lens group and
>> the focus lens group.
>>
>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>> ---
>>  .../userspace-api/media/v4l/ext-ctrls-camera.rst   | 46 ++++++++++++++++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c          | 10 +++++
>>  include/uapi/linux/v4l2-controls.h                 |  9 +++++
>>  3 files changed, 65 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> index 42cf4c3cda0c..3ea4175f9619 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
>> @@ -150,6 +150,29 @@ enum v4l2_exposure_metering -
>>      write-only control. It should be implemented only if the device cannot
>>      handle absolute values.
>>  
>> +``V4L2_CID_FOCUS_CURRENT (integer)``
>> +    The current position of the focal point. The unit is undefined. Larger
>> +    values indicate that the focus is closer to the camera, smaller values
>> +    indicate that the focus is closer to infinity. This is a read-only control.
> 
> I think you should also update the definition of the
> V4L2_CID_FOCUS_ABSOLUTE control to indicate the reading the control back
> will return the focus *target*, not the current focus position. This
> control should also refer to V4L2_CID_FOCUS_ABSOLUTE.
> 
> I think we should also require the V4L2_CID_FOCUS_CURRENT and
> V4L2_CID_FOCUS_ABSOLUTE controls to have the same unit.
> 
> Is this control expected to generate events, when the lens reaches its
> target position, or during movement ?

Although I can't rule it out completely, it wouldn't expect that the
current position of a lens triggers events. I would say that this is a
continuous movement (well, in case of a stepper motor a quasi-continuous
one), so when exactly should the controller generate in interrupt/event?

I expect that the current position is polled instead, e.g., once per
frame in the scope of an autofocus algorithm.

When the lens reaches its target, an event could be generated, but this
would be related to the _STATUS control below.

> How should we deal with the drivers that implement
> V4L2_CID_FOCUS_ABSOLUTE, do any of them implement reading
> V4L2_CID_FOCUS_ABSOLUTE with the semantics of the V4L2_CID_FOCUS_CURRENT
> control, instead of returning the focus target ?

Not sure whether I understand your question correctly, but drivers that
implement V4L2_CID_FOCUS_ABSOLUTE are mostly VCMs where I believe it is
assumed that target always equals the current position due to their fast
response.

But then there is the UVC driver of course. Only had a quick look, but
it seems to me that Focus (Absolute) does not support GET_CUR. I would
guess that GET_CUR could return the current value in the sense of
V4L2_CID_FOCUS_CURRENT.

>> +
>> +``V4L2_CID_FOCUS_STATUS (bitmask)``
>> +    The status of the focus lens group. The possible flags are described in
>> +    the table below. This is a read-only control.
> 
> Is this control expected to generate events ?

Yes, one could think of events when the lens reached its target or a
collision prevented exactly that.

>> +
>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>> +
>> +.. flat-table::
>> +    :header-rows:  0
>> +    :stub-columns: 0
>> +
>> +    * - ``V4L2_LENS_STATUS_IDLE``
>> +      - Focus lens group is at rest.
>> +    * - ``V4L2_LENS_STATUS_BUSY``
>> +      - Focus lens group is moving.
> 
> V4L2_LENS_STATUS_MOVING would be a better name if it's defined as "is
> moving".
> 
>> +    * - ``V4L2_LENS_STATUS_FAILED``
>> +      - Focus lens group has failed to reach its target position. The driver
> 
> What are the expected reasons for this ?

Variable focal length optics are complex beasts. It could happen, for
instance, that the range of the focus lens depends on the position of
the zoom lens(es). A smart controller could handle such situations
properly and the failure will never occur, but there might be
not-so-smart controllers as well.

In our case the status of the individual lenses is very important for
the initial calibration. Here, we need to be informed when a
collision/failure happened. Once the calibration is complete, this
should not occur anymore.

Best regards,
Michael

>> +	will not transition from this state until another action is performed
>> +	by an application.
> 
> You're talking about transitions here, I think you should document the
> state machine for the other states too. I expect the control to
> transition from IDLE to MOVING when the V4L2_CID_FOCUS_ABSOLUTE control
> is set, and transition from MOVING to IDLE or FAILED at the end of the
> motion. What happens if the user sets V4L2_CID_FOCUS_ABSOLUTE while the
> status is MOVING also needs to be documented.
> 
> It sounds we need helper functions to implement this state machine and
> generate events, leaving it to drivers would open the door to different
> behaviours for different devices.
> 
> All these comments apply to zoom too.
> 
>>  
>>  ``V4L2_CID_FOCUS_AUTO (boolean)``
>>      Enables continuous automatic focus adjustments. The effect of manual
>> @@ -241,6 +264,29 @@ enum v4l2_auto_focus_range -
>>      movement. A negative value moves the zoom lens group towards the
>>      wide-angle direction. The zoom speed unit is driver-specific.
>>  
>> +``V4L2_CID_ZOOM_CURRENT (integer)``
>> +    The current objective lens focal length. The unit is undefined and
>> +    its value should be a positive integer. This is a read-only control.
>> +
>> +``V4L2_CID_ZOOM_STATUS (bitmask)``
>> +    The status of the zoom lens group. The possible flags are described in
>> +    the table below. This is a read-only control.
>> +
>> +.. tabularcolumns:: |p{6.8cm}|p{10.7cm}|
>> +
>> +.. flat-table::
>> +    :header-rows:  0
>> +    :stub-columns: 0
>> +
>> +    * - ``V4L2_LENS_STATUS_IDLE``
>> +      - Zoom lens group is at rest.
>> +    * - ``V4L2_LENS_STATUS_BUSY``
>> +      - Zoom lens group is moving.
>> +    * - ``V4L2_LENS_STATUS_FAILED``
>> +      - Zoom lens group has failed to reach its target position. The driver will
>> +	not transition from this state until another action is performed by an
>> +	application.
>> +
>>  ``V4L2_CID_IRIS_ABSOLUTE (integer)``
>>      This control sets the camera's aperture to the specified value. The
>>      unit is undefined. Larger values open the iris wider, smaller values
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> index 564fedee2c88..794ef3ab0c02 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> @@ -1044,6 +1044,10 @@ const char *v4l2_ctrl_get_name(u32 id)
>>  	case V4L2_CID_CAMERA_ORIENTATION:	return "Camera Orientation";
>>  	case V4L2_CID_CAMERA_SENSOR_ROTATION:	return "Camera Sensor Rotation";
>>  	case V4L2_CID_HDR_SENSOR_MODE:		return "HDR Sensor Mode";
>> +	case V4L2_CID_FOCUS_CURRENT:		return "Focus, Current";
>> +	case V4L2_CID_FOCUS_STATUS:		return "Focus, Status";
>> +	case V4L2_CID_ZOOM_CURRENT:		return "Zoom, Current";
>> +	case V4L2_CID_ZOOM_STATUS:		return "Zoom, Status";
>>  
>>  	/* FM Radio Modulator controls */
>>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
>> @@ -1593,6 +1597,12 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>  		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
>>  			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
>>  		break;
>> +	case V4L2_CID_FOCUS_CURRENT:
>> +	case V4L2_CID_FOCUS_STATUS:
>> +	case V4L2_CID_ZOOM_CURRENT:
>> +	case V4L2_CID_ZOOM_STATUS:
>> +		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_VOLATILE;
>> +		break;
>>  	case V4L2_CID_FLASH_STROBE_STATUS:
>>  	case V4L2_CID_AUTO_FOCUS_STATUS:
>>  	case V4L2_CID_FLASH_READY:
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 5e80daa4ffe0..793ee8c65e87 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -993,6 +993,15 @@ enum v4l2_auto_focus_range {
>>  
>>  #define V4L2_CID_HDR_SENSOR_MODE		(V4L2_CID_CAMERA_CLASS_BASE+36)
>>  
>> +#define V4L2_LENS_STATUS_IDLE			(0 << 0)
>> +#define V4L2_LENS_STATUS_BUSY			(1 << 0)
>> +#define V4L2_LENS_STATUS_FAILED			(1 << 2)
>> +
>> +#define V4L2_CID_FOCUS_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+37)
>> +#define V4L2_CID_FOCUS_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+38)
>> +#define V4L2_CID_ZOOM_CURRENT			(V4L2_CID_CAMERA_CLASS_BASE+39)
>> +#define V4L2_CID_ZOOM_STATUS			(V4L2_CID_CAMERA_CLASS_BASE+40)
>> +
>>  /* FM Modulator class control IDs */
>>  
>>  #define V4L2_CID_FM_TX_CLASS_BASE		(V4L2_CTRL_CLASS_FM_TX | 0x900)
>>
> 
