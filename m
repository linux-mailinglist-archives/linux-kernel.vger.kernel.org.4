Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48746664E96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjAJWQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjAJWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:16:20 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1301333D6F;
        Tue, 10 Jan 2023 14:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673388979; x=1704924979;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=02/mtlONODBo5M9TTdVEHRM4g1koLObGdfJhbFlAXJ8=;
  b=j3cZcg66Id/Uajp2r9S8UrNuZSWz0rSftjqNDbLGzZ/A4RUMgzHELus0
   xtt8BvKxGLAdRUdvdvyWPEsIzhEVjVOTKjKq9ioj1NvflfBlTuhBNnLR5
   aEXAgtp1UbdJkTyLtLAnqjQnDZoXtRngoex/iCdsMJ4krvfutTF//bCb7
   hBS1W1CZPWkyLYAsJyqCPYMoReK7x7XKUJCbYpxo0k+yh6yp8q6E5NNj7
   FGi2v+/mrNOFgDkyeL6owFe9hf1uPAoU4pZq2mgydF/Q+Bc1lKnKJFd9A
   Zi4vTYQ7AhtodLIufrcoPpdD/CcusvE+w+m1hyZTuSYFx25pqsdwrfKFv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325278307"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="325278307"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 14:16:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="689566524"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="689566524"
Received: from amsaiyed-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.116.99])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 14:16:18 -0800
Message-ID: <74fbf0eb19ebdb964397d8f8d9b5fc12a06128cf.camel@linux.intel.com>
Subject: Re: [PATCH v2] HID: Recognize sensors with application collections
 too.
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Aditya Garg <gargaditya08@live.com>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     "orlandoch.dev@gmail.com" <orlandoch.dev@gmail.com>,
        "ronald@innovation.ch" <ronald@innovation.ch>
Date:   Tue, 10 Jan 2023 14:16:17 -0800
In-Reply-To: <EFCEA45A-C6F4-477A-B011-9C9E6E61E488@live.com>
References: <8DA00FF4-DB08-4CEC-A5B4-47A71DC09C13@live.com>
         <01D620E2-18CA-40F6-A330-454CBC20C542@live.com>
         <EFCEA45A-C6F4-477A-B011-9C9E6E61E488@live.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Don't add full stop at the end.

HID: Recognize sensors with application collection

On Tue, 2023-01-10 at 08:57 +0000, Aditya Garg wrote:
> From: Ronald Tschalär <ronald@innovation.ch>
> 
> According to HUTRR39 logical sensor devices may be nested inside
> physical collections or may be specified in multiple top-level
> application collections (see page 59, strategies 1 and 2). However,
> the current code was only recognizing those with physical
> collections.
> 
> This issue turned up in the T2 MacBook Pro's which define the ALS in
> a top-level application collection.
> 
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> —
> V2 :- Add missing signed-off-by
>  drivers/hid/hid-core.c       | 3 ++-
>  drivers/hid/hid-sensor-hub.c | 6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index b7f5566e338d..8fcd663b10e2 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -804,7 +804,8 @@ static void hid_scan_collection(struct hid_parser
> *parser, unsigned type)
>         int i;
>  
>         if (((parser->global.usage_page << 16) == HID_UP_SENSOR) &&
> -           type == HID_COLLECTION_PHYSICAL)
> +           (type == HID_COLLECTION_PHYSICAL ||
> +            type == HID_COLLECTION_APPLICATION))
>                 hid->group = HID_GROUP_SENSOR_HUB;
>  
>         if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 6abd3e2a9094..d03dc4ca095f 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -397,7 +397,8 @@ int sensor_hub_input_get_attribute_info(struct
> hid_sensor_hub_device *hsdev,
>                 for (i = 0; i < report->maxfield; ++i) {
>                         field = report->field[i];
>                         if (field->maxusage) {
> -                               if (field->physical == usage_id &&
> +                               if ((field->physical == usage_id ||
> +                                    field->application == usage_id)
> &&
>                                         (field->logical ==
> attr_usage_id ||
>                                         field->usage[0].hid ==
>                                                         attr_usage_id
> ) &&
> @@ -506,7 +507,8 @@ static int sensor_hub_raw_event(struct hid_device
> *hdev,
>                                         collection->usage);
>  
>                 callback = sensor_hub_get_callback(hdev,
> -                               report->field[i]->physical,
> +                               report->field[i]->physical ?:
> +                                       report->field[i]->application
Better not use language extensions. Simple to use

 report->field[i]->physical ?  report->field[i]->physical : report-
>field[i]->application

Otherwise patch is fine.

Thanks,
Srinivas

> ,
>                                 report->field[i]-
> >usage[0].collection_index,
>                                 &hsdev, &priv);
>                 if (!callback) {
> -- 
> 2.38.1
> 

