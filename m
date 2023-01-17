Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4105266DC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjAQLb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbjAQLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:31:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E634576;
        Tue, 17 Jan 2023 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673955036; x=1705491036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i3BuCS+pJ4oTm89xGBP/zNyMeh4Xwhz1HQ+sE6hvKJk=;
  b=QBdLyISQYjMmpbkrNJZ0FbehE0L80WY9IVHYKC34ad5ZeK4erkGmj1ai
   5OlgvQxAQwDZCBW3VlXPYsyUXGbzss/oUOZoX2n01Pay/VbOmJWuSuaty
   gKYTA99frlzQwxaVF91cxkQZ/MEmQEH5NGuz3STcbgAHvaQvnriRlN5gz
   4Y4K5VJoRhbqwFKuce6mkQevVRC0upKR/mAOVImGlUCvD7ERwPokB5J1N
   IkCKSwqJd5iCu9Ha2XnOVbZwgpnxjdwRvV6Xzs+SzrbYxMU1RKyHu1YN4
   GhpMUeYoydVFZ721LXnNZJShjClb/TO1UIFAh5Y06k3ZiSKvIcFvtWZo8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323369006"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="323369006"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:30:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="904615098"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="904615098"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.10.213]) ([10.213.10.213])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:30:29 -0800
Message-ID: <309b58d6-3b4f-36ec-d68e-f0fc60790118@intel.com>
Date:   Tue, 17 Jan 2023 12:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 1/5] dt-bindings: display: bridge: Convert
 cdns,dsi.txt to yaml
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de, tomi.valkeinen@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, sjakhade@cadence.com, mparab@cadence.com,
        a-bhatia1@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com,
        lee.jones@linaro.org, Rob Herring <robh@kernel.org>
References: <20230103101951.10963-1-r-ravikumar@ti.com>
 <20230103101951.10963-2-r-ravikumar@ti.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230103101951.10963-2-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.01.2023 11:19, Rahul T R wrote:
> Convert cdns,dsi.txt binding to yaml format
>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

