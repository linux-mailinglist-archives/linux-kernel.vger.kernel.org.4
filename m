Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074FF69A392
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBQBre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjBQBrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:47:32 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704904CCBA;
        Thu, 16 Feb 2023 17:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676598450; x=1708134450;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RbNfSARDvLPJapxmmg3BxpzyzbRqno6KD685T0zOp+Y=;
  b=lSacXNljUjNyzS8xBjunE99DFbvquzd1RMBz8hDz4hpNhrjn9ZB/4YkQ
   G3VhRUz3Wd98epeQ3R/hVxf0tl1FIEGMh34Ocvc10Vrfb+wfnZoDANdBJ
   X5Jtn5oPYgS7rm/iu77F1A+dND9MTnZ1iqB/M/kS2zejyoiLfQtLXEFR5
   4zqG0tStOR4pLbe9dh/1J5Tajzufsb9gRfnrgHlSOUUyoURbpV8MWfu7A
   oXJqAyNjH3GW0uLu7/ORQ4uufTAxIiZ8kR7ei7zpZxNp/NehCCPfW9n9d
   9GzrBwho1EJW+1CVs5MMSUp9Wh/rGj/Pqmzr+Rxhgnyg2S9Dy9XLGoSH2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333246101"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="333246101"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 17:47:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="915919466"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="915919466"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.139]) ([10.238.232.139])
  by fmsmga006.fm.intel.com with ESMTP; 16 Feb 2023 17:47:26 -0800
Subject: Re: [PATCH v2 0/3] media: pci: intel: ivsc: Add driver of Intel
 Visual Sensing Controller(IVSC)
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wentong Wu <wentong.wu@intel.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, srinivas.pandruvada@intel.com,
        pierre-louis.bossart@linux.intel.com, zhifeng.wang@intel.com,
        xiang.ye@intel.com, tian.shu.qiu@intel.com, bingbu.cao@intel.com,
        linux-kernel@vger.kernel.org
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <Y+ypKYI4c6fHL4Eu@pendragon.ideasonboard.com>
 <00c5c16e-c94e-a328-06d9-5f09ad35258d@linux.intel.com>
 <Y+4rtSMArg5ow0Sh@kekkonen.localdomain>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <8022b9da-e033-b77b-914c-d35a31aac2e2@linux.intel.com>
Date:   Fri, 17 Feb 2023 09:43:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Y+4rtSMArg5ow0Sh@kekkonen.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sakari,

On 2/16/23 9:12 PM, Sakari Ailus wrote:
> Hi Bingbu, Wentong,
> 
> On Wed, Feb 15, 2023 at 08:09:50PM +0800, Bingbu Cao wrote:
>>
>> Hi, Wentong,
>>
>> On 2/15/23 5:43 PM, Laurent Pinchart wrote:
>>> Hello Wentong,
>>>
>>> On Mon, Feb 13, 2023 at 10:23:44AM +0800, Wentong Wu wrote:
>>>> Intel Visual Sensing Controller (IVSC), codenamed "Clover Falls", is a
>>>> companion chip designed to provide secure and low power vision capability
>>>> to IA platforms. IVSC is available in existing commercial platforms from
>>>> multiple OEMs.
>>>>
>>>> The primary use case of IVSC is to bring in context awareness. IVSC
>>>> interfaces directly with the platform main camera sensor via a CSI-2 link
>>>> and processes the image data with the embedded AI engine. The detected
>>>> events are sent over I2C to ISH (Intel Sensor Hub) for additional data
>>>> fusion from multiple sensors. The fusion results are used to implement
>>>> advanced use cases like:
>>>>  - Face detection to unlock screen
>>>>  - Detect user presence to manage backlight setting or waking up system
>>>
>>> Do you have plan to support these features in the ivsc driver in the
>>> future ?
>>>
>>>> Since the Image Processing Unit(IPU) used on the host processor needs to
>>>> configure the CSI-2 link in normal camera usages, the CSI-2 link and
>>>> camera sensor can only be used in mutually-exclusive ways by host IPU and
>>>> IVSC. By default the IVSC owns the CSI-2 link and camera sensor. The IPU
>>>> driver can take ownership of the CSI-2 link and camera sensor using
>>>> interfaces provided by this IVSC driver.
>>>>
>>>> Switching ownership requires an interface with two different hardware
>>>> modules inside IVSC. The software interface to these modules is via Intel
>>>> MEI (The Intel Management Engine) commands. These two hardware modules
>>>> have two different MEI UUIDs to enumerate. These hardware modules are:
>>>>  - ACE (Algorithm Context Engine): This module is for algorithm computing
>>>> when IVSC owns camera sensor. Also ACE module controls camera sensor's
>>>> ownership. This hardware module is used to set ownership of camera sensor.
>>>>  - CSI (Camera Serial Interface): This module is used to route camera
>>>> sensor data either to IVSC or to host for IPU driver and application.
>>>>
>>>> IVSC also provides a privacy mode. When privacy mode is turned on,
>>>> camera sensor can't be used. This means that both ACE and host IPU can't
>>>> get image data. And when this mode is turned on, host IPU driver is
>>>> informed via a registered callback, so that user can be notified.
>>>
>>> How does the privacy mode work, and how can the user trust that the
>>> closed-source IVSC and IME firmwares will honour the privacy settings ?

As I know, without IVSC, once user enable the privacy mode, the Intel
Converged Security Engine will configure the IPU camera mask (security
register), which will mask the specific CSI2 port and produce dummy
imaging data. For the case with IVSC, there is no final solution on Linux
so far I think.

Wentong, is IVSC trying to cut off the stream and then notify user and IPU?

>>>
>>
>> Continue with question from Laurent,
>>
>> How IVSC handle the privacy request from user? Is there some notification
>> mechanism to user-space? I'd have concern if IVSC driver need private callback
>> to request back-end(e.g. ISP driver) to handle stream cutting.
> 
> How does the privacy mode work, does it just pass zeroes (or other dummy
> data) towards the host or nothing?
> 
> A V4L2 control can be used for the purpose of passing the information to
> the user space at least.
> 

-- 
Best regards,
Bingbu Cao
