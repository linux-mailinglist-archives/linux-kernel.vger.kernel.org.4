Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC267D193
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjAZQ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjAZQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:26:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A82721DA;
        Thu, 26 Jan 2023 08:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674750361; x=1706286361;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=VoCnjpuatxN+O2Dg71Cb0IcLA9Rb+BbQQjLiUoOMEUc=;
  b=TirGAkSHr/6dDg9L85HRt6QskQ+GWBmisXkj2RfjoMMYz0Hkl1h2ZRWC
   wVGnK249qxlP2jfe+8jS3aB+pVIdnK46qVvaNC3bCxhWzuhlvZiXAceCs
   e3DlVk0xn+UI0scWX5HnVUKQUe8ospQ+YKq+zxk/DLF27ukWhTXya9Ejp
   exd+B1k0NIdS1TNGUhYj3btE/h9w1ISmNyU8XOkechhdmGEYge0KfL0Pj
   mDKTl+FG6XMIBugkzyZUP+L8Sp/l2K4YDDE0vH1A9EhUg437YGLWiSmLj
   TixGhbLsarB57AeLDzj9Jsab2rQS5UKSgByqW8+pVKEM5ReXz+xei1uEw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354154739"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="354154739"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="612855103"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="612855103"
Received: from nmani1-mobl2.amr.corp.intel.com (HELO [10.209.167.178]) ([10.209.167.178])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 08:24:44 -0800
Message-ID: <ad9e375e-fe4f-b4bd-aebd-26f5f0a6317b@linux.intel.com>
Date:   Thu, 26 Jan 2023 10:22:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH v2 00/22] Introduce QC USB SND audio offloading
 support
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version has lots of improvements, but I am concerned
about hard-coded ops/callbacks that look racy and assume dependencies
between driver probes. How does this work if the probe is delayed on one
side for some reason? What happens is a driver is 'blacklisted' and
manually added later? The code has to deal with this sort of known unknowns.

I also still have a bit of heartburn with the notion that there would be
a completely separate card with all the control for volume/mute/etc
having to be duplicated.

It's still a lot of good work so thanks for sharing and pushing for this
capability.


