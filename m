Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10CC67E4C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjA0MML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjA0MLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:11:48 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4238B04C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674821164; x=1706357164;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xWA00fIMSfcvZiXIfI1PpYEPmzZlgTqe/5W+qqJNn0Y=;
  b=bdC5DJ9ANyWeMcXLw7pLBbDLqnla2l45A6TCdhlFW0GHp007uxHWyQcp
   tczMCMOaL1a7Sd9fWkqbmqUoMhdgTeQzPJXVaMB9wcDD2ow2i5AlGIcIL
   a0y7EPJzL2fjwZYqemhUs5PzugFRGPhErWwqDSII6dLLubhioaw7HZNvY
   L6x0IPIdmqRr46usuoOjbLAOSjBXk7qYYfhcOVTFlKe12wpC8rweXk80W
   I4pX8SoisgYu1wLY/5uSV1BT6w1S+yZb6Nd4kaefgOsUIe2eleRHnSYLd
   Cxaj0rlU7jR37TGcUg89bZyXSg7btkVIsKktgzm2CvJ68oxaAYCW66VhB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="310693285"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="310693285"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 04:04:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="693686975"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="693686975"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2023 04:04:53 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v1 4/6] virtio console: Harden control message handling
In-Reply-To: <20230127055514-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
 <Y8lgIS+jygB7SGrn@kroah.com>
 <20230120074120-mutt-send-email-mst@kernel.org>
 <87y1pxp39k.fsf@ubik.fi.intel.com>
 <20230127055514-mutt-send-email-mst@kernel.org>
Date:   Fri, 27 Jan 2023 14:04:52 +0200
Message-ID: <87h6wcp4ij.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> At this point I will drop this series and pls post new series
> with just the stuff you want included. Include acks if patches
> are unchanged.

Will do, thanks for the review!

Regards,
--
Alex
