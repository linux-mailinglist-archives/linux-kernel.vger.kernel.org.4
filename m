Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA967EAB2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjA0QU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjA0QUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:20:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15849841B5;
        Fri, 27 Jan 2023 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674836415; x=1706372415;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U270CQoWlTfib2ccUnX91Q4dGBBbjD5E5gXGCup4EEQ=;
  b=Qn+RvgIesu0Cu+aqdHXGe3w+vWWMV5Wuloeit5gwz6E5U4yYilFGBnWp
   9VRK90jzgk7BwNyeLJ5jSmEoRIxxite/KdE2kWy5a0PyLKaGKljtX5gOj
   2TF0hL2GObgsNW+gn4FVE/DP4nAgG8Z2uv+pWJ93ZcdevHh1NV8Uaaa0c
   8M5nTkihPneLZRJlDHXGLu+7X+C1HgCduc0AuJhBrxv1noUxaTe8y6XnC
   oafPUKh96SmWaIhJw8IrJnr1gTtqrlY7xNFgwpDGIcuostyeP1Yo/PN8w
   qkKykKFhyFmjfp/kgWZsr8mvaOitT5eWkaou8coqplL1dREF/gVnMpFSi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="306770287"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="306770287"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 08:20:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="771630254"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="771630254"
Received: from dpbogia-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.18.51])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 08:20:14 -0800
Message-ID: <bcc22f45efbde7b7b075fe84a495a52b81e02b18.camel@linux.intel.com>
Subject: Re: [PATCH 10/35] Documentation: hid: correct spelling
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Date:   Fri, 27 Jan 2023 08:20:13 -0800
In-Reply-To: <20230127064005.1558-11-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
         <20230127064005.1558-11-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-26 at 22:39 -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/hid/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-input@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

For Documentation/hid/intel-ish-hid.rst

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> ---
>  Documentation/hid/hid-alps.rst      |    2 +-
>  Documentation/hid/hid-bpf.rst       |    2 +-
>  Documentation/hid/hiddev.rst        |    2 +-
>  Documentation/hid/hidraw.rst        |    2 +-
>  Documentation/hid/intel-ish-hid.rst |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff -- a/Documentation/hid/hid-alps.rst b/Documentation/hid/hid-
> alps.rst
> --- a/Documentation/hid/hid-alps.rst
> +++ b/Documentation/hid/hid-alps.rst
> @@ -9,7 +9,7 @@ Currently ALPS HID driver supports U1 To
>  U1 device basic information.
>  
>  ==========     ======
> -Vender ID      0x044E
> +Vendor ID      0x044E
>  Product ID     0x120B
>  Version ID     0x0121
>  ==========     ======
> diff -- a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-
> bpf.rst
> --- a/Documentation/hid/hid-bpf.rst
> +++ b/Documentation/hid/hid-bpf.rst
> @@ -307,7 +307,7 @@ sysfs path: ``/sys/bus/hid/devices/xxxx:
>  
>  We can not rely on hidraw to bind a BPF program to a HID device.
> hidraw is an
>  artefact of the processing of the HID device, and is not stable.
> Some drivers
> -even disable it, so that removes the tracing capabilies on those
> devices
> +even disable it, so that removes the tracing capabilities on those
> devices
>  (where it is interesting to get the non-hidraw traces).
>  
>  On the other hand, the ``hid_id`` is stable for the entire life of
> the HID device,
> diff -- a/Documentation/hid/hiddev.rst b/Documentation/hid/hiddev.rst
> --- a/Documentation/hid/hiddev.rst
> +++ b/Documentation/hid/hiddev.rst
> @@ -8,7 +8,7 @@ Introduction
>  In addition to the normal input type HID devices, USB also uses the
>  human interface device protocols for things that are not really
> human
>  interfaces, but have similar sorts of communication needs. The two
> big
> -examples for this are power devices (especially uninterruptable
> power
> +examples for this are power devices (especially uninterruptible
> power
>  supplies) and monitor control on higher end monitors.
>  
>  To support these disparate requirements, the Linux USB system
> provides
> diff -- a/Documentation/hid/hidraw.rst b/Documentation/hid/hidraw.rst
> --- a/Documentation/hid/hidraw.rst
> +++ b/Documentation/hid/hidraw.rst
> @@ -163,7 +163,7 @@ HIDIOCGOUTPUT(len):
>         Get an Output Report
>  
>  This ioctl will request an output report from the device using the
> control
> -endpoint.  Typically, this is used to retrive the initial state of
> +endpoint.  Typically, this is used to retrieve the initial state of
>  an output report of a device, before an application updates it as
> necessary either
>  via a HIDIOCSOUTPUT request, or the regular device write()
> interface.  The format
>  of the buffer issued with this report is identical to that of
> HIDIOCGFEATURE.
> diff -- a/Documentation/hid/intel-ish-hid.rst
> b/Documentation/hid/intel-ish-hid.rst
> --- a/Documentation/hid/intel-ish-hid.rst
> +++ b/Documentation/hid/intel-ish-hid.rst
> @@ -199,7 +199,7 @@ the sender that the memory region for th
>  DMA initialization is started with host sending DMA_ALLOC_NOTIFY bus
> message
>  (that includes RX buffer) and FW responds with DMA_ALLOC_NOTIFY_ACK.
>  Additionally to DMA address communication, this sequence checks
> capabilities:
> -if thw host doesn't support DMA, then it won't send DMA allocation,
> so FW can't
> +if the host doesn't support DMA, then it won't send DMA allocation,
> so FW can't
>  send DMA; if FW doesn't support DMA then it won't respond with
>  DMA_ALLOC_NOTIFY_ACK, in which case host will not use DMA transfers.
>  Here ISH acts as busmaster DMA controller. Hence when host sends
> DMA_XFER,

