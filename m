Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387F7050AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjEPO14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjEPO1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:27:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB5A10EF
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:27:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GERQ6x021073;
        Tue, 16 May 2023 09:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684247246;
        bh=lpX4f3FYDc/f2/ohxeOyjtIJE6ptK1Vg4huuCjKL5Tk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LuEwcE8dRqG+EZV8TY7G+mfWoiR7yvIz+8Fq/yWXWh5bdaG/RmUsqkxHZbayj8LmU
         5RuwDKIThnR/f+297rKP75x48G4Lov0fwnvtQvUKXIwZfE7KQBUqDZ1Kw50ddNoUHm
         u/E3YFo8eX7x0WAJ4yzHyzKogRlfrvXQ9THYfTXA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GERQUm055246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 09:27:26 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 09:27:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 09:27:25 -0500
Received: from [10.249.133.231] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GERAEw082338;
        Tue, 16 May 2023 09:27:11 -0500
Message-ID: <b2f4eed1-ba19-fc0e-3cf0-a0dfa2e0f2af@ti.com>
Date:   Tue, 16 May 2023 19:57:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/8] drm/bridge: tfp410: Set input_bus_flags in
 atomic_check
Content-Language: en-US
To:     <neil.armstrong@linaro.org>, Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230509093036.3303-1-a-bhatia1@ti.com>
 <20230509093036.3303-3-a-bhatia1@ti.com>
 <3045292e-5801-74c5-5a6b-6e4c5802a035@linaro.org>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <3045292e-5801-74c5-5a6b-6e4c5802a035@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 16-May-23 12:55, Neil Armstrong wrote:
> On 09/05/2023 11:30, Aradhya Bhatia wrote:
>> From: Nikhil Devshatwar <nikhil.nd@ti.com>
>>
>> input_bus_flags are specified in drm_bridge_timings (legacy) as well
>> as drm_bridge_state->input_bus_cfg.flags
>>
>> The flags from the timings will be deprecated. Bridges are supposed
>> to validate and set the bridge state flags from atomic_check.
>>
>> Implement atomic_check hook for the same.
>>
>> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
>> ---
>>
>> Notes:
>>      changes from v4:
>>      * fix a warning Reported-by: kernel test robot <lkp@intel.com>
>>
>>      changes from v5:
>>      * Moved the return statement here from patch 4 (where it was added
>>        by mistake).
>>
>>   drivers/gpu/drm/bridge/ti-tfp410.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c
>> b/drivers/gpu/drm/bridge/ti-tfp410.c
>> index 7dacc7e03eee..631ae8f11a77 100644
>> --- a/drivers/gpu/drm/bridge/ti-tfp410.c
>> +++ b/drivers/gpu/drm/bridge/ti-tfp410.c
>> @@ -228,6 +228,21 @@ static u32 *tfp410_get_input_bus_fmts(struct
>> drm_bridge *bridge,
>>       return input_fmts;
>>   }
>>   +static int tfp410_atomic_check(struct drm_bridge *bridge,
>> +                   struct drm_bridge_state *bridge_state,
>> +                   struct drm_crtc_state *crtc_state,
>> +                   struct drm_connector_state *conn_state)
>> +{
>> +    struct tfp410 *dvi = drm_bridge_to_tfp410(bridge);
>> +
>> +    /*
>> +     * There might be flags negotiation supported in future.
>> +     * Set the bus flags in atomic_check statically for now.
>> +     */
>> +    bridge_state->input_bus_cfg.flags = dvi->timings.input_bus_flags;
> 
> A newline here before return would look better
Yup! Will add one.

> 
>> +    return 0;
>> +}
>> +
>>   static const struct drm_bridge_funcs tfp410_bridge_funcs = {
>>       .attach        = tfp410_attach,
>>       .detach        = tfp410_detach,
>> @@ -238,6 +253,7 @@ static const struct drm_bridge_funcs
>> tfp410_bridge_funcs = {
>>       .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>>       .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>>       .atomic_get_input_bus_fmts = tfp410_get_input_bus_fmts,
>> +    .atomic_check = tfp410_atomic_check,
>>   };
>>     static const struct drm_bridge_timings tfp410_default_timings = {
> 
> With that fixed:
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thank you!


Regards
Aradhya
