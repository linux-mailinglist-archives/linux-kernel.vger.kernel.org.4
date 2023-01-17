Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979D866DC95
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjAQLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbjAQLez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:34:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5402D8A42;
        Tue, 17 Jan 2023 03:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673955289; x=1705491289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mH1LIiq7Ergf44/MXT40cMfHwTFQC5bpCpuGbuueu0A=;
  b=CQfvJ9syzf1GM8zdx6wBWCtQ1M+RXvS2SYLerJAp89h8hGfPWBb4E6oy
   UD4k2iRkAGaKHtTIPmEv3+xSsNf3tsQGEillKY3ms8MkjSrPUtktawp40
   pEANTqxrNs+Yg6fcfZBYZOp9HM/+ZnkfQXQvYu5QOoGrwect7Vl6lDvqb
   jA0aZbwrx+NwIwm30rQ/waywp/KzCdC9vAZ//LPndXYWovdaJgUCH04BE
   T2HzlJMW+egqNh2aV295l4veJEtmmKDd72kl+Ny/LEzQO7zu2/4M0RwlR
   zEfwbW5kGCSZCL0LNe/qwzVjP0+s9KMMWrxbHtfuVKWbpSReEezqjKIBH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="325947956"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="325947956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:34:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="652521320"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="652521320"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.10.213]) ([10.213.10.213])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:34:43 -0800
Message-ID: <28feeeb6-c9e1-eb67-caa8-b0d2e709fdf5@intel.com>
Date:   Tue, 17 Jan 2023 12:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 4/5] drm/bridge: cdns-dsi: Create a header file
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de, tomi.valkeinen@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, sjakhade@cadence.com, mparab@cadence.com,
        a-bhatia1@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com,
        lee.jones@linaro.org
References: <20230103101951.10963-1-r-ravikumar@ti.com>
 <20230103101951.10963-5-r-ravikumar@ti.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230103101951.10963-5-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.01.2023 11:19, Rahul T R wrote:
> Create a header file for cdns dsi and move structure definations to
> prepare for adding j721e wrapper support
>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

