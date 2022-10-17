Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0006008A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJQIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJQIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:30:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C4D1DA51
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665995408; x=1697531408;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=UYv22Dlz3EwgVQe5spVgsHxye85g1iZlrD3DJAxLV08=;
  b=KWEjdfUuVT+/JN7dBGFNXG3KeVV5v4zVTDu9PSMTufoAdaLMoEcSo5SQ
   UkQrFHb/jXNpIl6rDD6IfFZQduVP3OJU0J0LTZqH3/M52oyHgeA9/JEf9
   xkoP+CZLylbhO/eY303HfybJkxhBBT2C20H94E+Eca12Xm3vR2nHmZZ4E
   sx5cH7H9YXqj/KlrXul4sqWHBplkMlGtqRY6DRz+bIS/pN7z6qGFhifAP
   tV44VuDVeK3NubuaM2SZ/zIQQvNYIqC1jvQeUkGrreisaLKgNqShsVesr
   iXm0Kx62CYGOBrTFevbfsGjw+4YEwDIrAuNdTPc4j6jTQifQSB69KoKfy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="307398512"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="307398512"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 01:30:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="696970402"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="696970402"
Received: from cgarnier-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.44.27])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 01:30:06 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
In-Reply-To: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
Date:   Mon, 17 Oct 2022 11:30:45 +0300
Message-ID: <87a65usvgq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> With 6.0 the following WARN triggers:
> drivers/gpu/drm/i915/display/intel_bios.c:477:
>
>         drm_WARN(&i915->drm, min_size == 0,
>                  "Block %d min_size is zero\n", section_id);

What's the value of section_id that gets printed?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
