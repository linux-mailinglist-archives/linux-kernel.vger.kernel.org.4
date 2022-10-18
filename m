Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6A602071
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJRB23 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Oct 2022 21:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJRB21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:28:27 -0400
Received: from ipmail06.adl3.internode.on.net (ipmail06.adl3.internode.on.net [150.101.137.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA5BF2D1E2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:28:23 -0700 (PDT)
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3AJNuO9KrrVYX6iPdh85D/Cixyz/deBmIBZBIvg?=
 =?us-ascii?q?KrLsJaIsI4StFCztgarIBmDbqmMZGukLop1Pdjj80JX6JOAyoQwHgQ//CE2F?=
 =?us-ascii?q?34R9JeYXN7JdE6rNHrOf5CeFBs6tcxEZ4TNc81pFCKD/0enG7Ww9nMUOYOgH?=
 =?us-ascii?q?+qkUrSYUsxSqa6IcMqS4P5as7ZRbrNA2LBVPSvd4bsenOWHULOV82Yc3lM8s?=
 =?us-ascii?q?8pvmjs21BjBkGtwUmgFWBx+lAS2e0/5rX4oDfrZw3PQGuG4FwMhLgrJ5OnRE?=
 =?us-ascii?q?mjxp3/BBj45+4sXfHHmQpaKVeSPokkPAffk2l4a4HUHuko5HKNaMB0KzW/Rx?=
 =?us-ascii?q?ZYrlIglWZ+YEG/FOoXFgvgdTgMeFihkJq1u+bnbLGK5tsCeiUrANX3h352CC?=
 =?us-ascii?q?WlqZtBAobwtXTsmGfswcmtTNnhvndmeyaimTPF2j9oiKo/zNYUSt2t7wDXHB?=
 =?us-ascii?q?PMOSJXPBa7N4Ldw1zcqh9tSHP/YIckeZDxuYzzJZhEJMVASYLo3nf2sh3TzW?=
 =?us-ascii?q?zJdoVOR46Ew5gD75Qh8wLHrPNfPPPCHWM5Vk1ywr2fKuW/+B3kyONWZyDeBt?=
 =?us-ascii?q?GyhmvPChwv1Vp0WEPuz9pZCjEeSg2AeFhASfV+6uuWizECkVt9TJlcX5i026?=
 =?us-ascii?q?68o+ySDStj7Qg39o3OeuBMYc8RfHvd86wyXzKfQpQGDCQAsUjlbdtUiuNQeQ?=
 =?us-ascii?q?T0sy0/MkdT0AzBmrLySTzSa7Lj8kN8YETxNeCpbPWlcWVJQu5+7tNtm1lSeE?=
 =?us-ascii?q?Y04BPXg1puoDW6l+zqOuHFm0u1X1dpjO76TpBae2W/q/MCTCFRpu23qsquex?=
 =?us-ascii?q?lsRTOaYi0aAsDA3Ncp9Ebs=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AOiHc66gyKbEQSI6kVafN6yiq1XBQXtYji2?=
 =?us-ascii?q?hC6mlwRA09TySZ//rDoB19726RtN9xYgBEpTnuAsK9qB/nn6KdpLNxAV7AZn?=
 =?us-ascii?q?iFhILLFvAA0WKK+VSJJ8S9zI5gPMxbHJSWZuecMbE3t6jH3DU=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DOAQA1AE5jAPXKfQENTR4BAQsSDEA?=
 =?us-ascii?q?JhkSEToJijjQDgROeBAsBUwQBAYUFAoRtJjgTAQIEFQEBBgEBAQEBBwQQATl?=
 =?us-ascii?q?SjDgBAQEDI1YQCw0LAgImAgJXBgENBYJ9rg16gTIaZ4gegWWBESyBZooPHYQ?=
 =?us-ascii?q?hN4FVRIEVJw8NgjA3PoQiAQEgg1c4gi4ElFiCHoNzOAMZKx1AAws7MwMVAxQ?=
 =?us-ascii?q?DBSEHAxkPIw0NBBYHDAMDBSUDAgIbBwICAwIGEwUCAhc2NAgECAQrJA8FAgc?=
 =?us-ascii?q?vBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbGQEFWQ4JIRYGDhoNBQY?=
 =?us-ascii?q?TAyBJJgUKOA8oL2krHBsHgQwqCR8VAwQEAwIGEwMiAg0pMRQEKRMPLQcjcQk?=
 =?us-ascii?q?CAyJlBQMDBCgsAwlAByUkPAdYEigBBAMCECI8BgMJAwIiWXYJJhEVBQMNFyU?=
 =?us-ascii?q?IBTcaBAg8AgUGUhICChEDEg8GJ0gPSj45FgYnRQE2Dw4aA50oN4EJL14Kgh0?=
 =?us-ascii?q?CwU40B4NjgUQGDJ5vIwuDdoxRhksDjASFdpcWIKlNgX4zGi5vAYI8UZ0rYjs?=
 =?us-ascii?q?CBgEKAQEDCYpXAQE?=
Received: from unknown (HELO [127.0.0.1]) ([1.125.202.245])
  by ipmail06.adl3.internode.on.net with ESMTP; 18 Oct 2022 11:58:20 +1030
Date:   Tue, 18 Oct 2022 11:58:06 +1030
From:   Arthur Marsh <arthur.marsh@internode.on.net>
To:     Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
        =?ISO-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@gmail.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [git pull] drm fixes for 6.1-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <f3a5b249-84d8-9ba3-9977-3557c82a7850@amd.com>
References: <CAPM=9ty3DGWa8vnfumgSrpSgWnixWjikb6C0Zk_5bW+deKLVQw@mail.gmail.com> <20221016080833.5503-1-user@am64> <CAPM=9txsBf5HJ97tAMOQ8PdiPciK-zqngERUm7hGJO8Zyyqb+w@mail.gmail.com> <C98B32CF-86B0-438D-BC8D-10FA255B3B4F@internode.on.net> <7c645fa8-bf29-4b30-bdc5-e61e6bb09927@amd.com> <f0110d36-a9c2-c1b9-b193-32da4f98a975@amd.com> <67e2904a-4b80-5173-2d8f-6a3d1f702fbb@amd.com> <CAPM=9tz8=iDye+vYai2NLLW-u3TfZ=DKdA_h2e+kk==ZO7q3PQ@mail.gmail.com> <50dcf794-e96f-24a3-5d40-6c64941b1bc0@amd.com> <f3a5b249-84d8-9ba3-9977-3557c82a7850@amd.com>
Message-ID: <EE5085BD-98AF-452E-9AE3-4EA81E2A55E1@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arunpravin, your patch applied to the 6.1-rc1 code built a kernel that loaded the amdgpu module on my pc with Cape Verde GPU card with no problems.

Regards,

Arthur. 

On 18 October 2022 7:10:45 am ACDT, Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com> wrote:
>Hi Christian,
>
>Looks like we have to exit the loop if there are no blocks to compare.
>May be that's why the function returns false.
>
>@Arthur Marsh Could you please test the attached patch.
>
>Thanks,
>Arun
>
>On 10/17/2022 1:39 PM, Christian König wrote:
>> Am 17.10.22 um 10:01 schrieb Dave Airlie:
>>> On Mon, 17 Oct 2022 at 17:07, Christian König <christian.koenig@amd.com> wrote:
>>>> Hi Arun,
>>>> 
>>>> the hw generation doesn't matter. This error message here:
>>>> 
>>>> amdgpu: Move buffer fallback to memcpy unavailable
>>>> 
>>>> indicates that the detection of linear buffers still doesn't work as
>>>> expected or that we have a bug somewhere else.
>>>> 
>>>> Maybe the limiting when SDMA moves are not available isn't working
>>>> correctly?
>>> It is a CAPE_VERDE, so maybe something with the SI UVD memory limitations?
>> 
>> Yeah, good point. Could be that we try to move something into the UVD memory window and that something isn't allocated linearly.
>> 
>> Arun can you trace the allocation and make sure that all kernel allocations have the CONTIGUOUS flag set?
>> 
>> Thanks,
>> Christian.
>> 
>>> 
>>> Dave.
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
