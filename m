Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23C74608F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGCQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGCQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:16:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B728FE4E;
        Mon,  3 Jul 2023 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688400959; x=1719936959;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DRemAbyCfHOBhZ+tlssIsD3Ly0occMYgkFulsRkiiys=;
  b=d3HGPvXRG+wRcu6wmYAO+5PscJuwg9Dkj56oR4u3UsjHn9it+9mg+K5O
   9oYexm9RA4UVxuHIPw1sibOEaotS4vpMogKtSwU1cFOo7cjfs4vmtPBvj
   ZwXn/eOcOmaQ12cFJYSLs2OqOG0iV2vsci5VW5pUQT1CLq2Hr7AWea+eo
   TAY0zPGb5yCxXDS2t3Ob8/G6+VWat+Ujusvh1ugVqQaBFTfii8lVAxNdy
   jplyABrTpDf7Q1p9mjtuiFfvDeRzkMcNkymsSUzoJ0rots8B8OST7ZCCg
   NAvuhPAf/JFNPs+7ATZg0qvGyme5ywLrKXXRa81bwdzEcnE+I3BgqzsHO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="426606184"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="426606184"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 09:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831875148"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831875148"
Received: from vviswana-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.30.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 09:15:57 -0700
Message-ID: <74c232550c6787ef34ddac67a61339e6c028fb0d.camel@linux.intel.com>
Subject: Re: [PATCH 5/8] thermal/drivers/int3400: Use thermal zone device
 wrappers
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>, rafael@kernel.org
Date:   Mon, 03 Jul 2023 09:15:57 -0700
In-Reply-To: <ab892878-9c66-f94f-cf4c-9961723411d2@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
         <20230525140135.3589917-6-daniel.lezcano@linaro.org>
         <ab892878-9c66-f94f-cf4c-9961723411d2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, 2023-07-03 at 12:49 +0200, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> do you agree with the changes in patches 5 and 6 ?
> 
> Thanks
> 
>    -- Daniel
> 
> 
> On 25/05/2023 16:01, Daniel Lezcano wrote:
> > The driver is accessing the thermal zone device structure but the
> > accessors are already existing and we want to consolidate the
> > thermal
> > core code by preventing accesses to the internals from the drivers.
> > 
> > Let's use these accessors.
> > 
> > On the other side, the code is getting directly the temperature
> > from
> > tz->temperature, but the temperature is a faked on, so we can
> > replace
> > this access by the fake temp and remove the thermal zone device
> > structure access.
> > 
May be something simple description like this will be enough.

"
Use thermal core API to access thermal zone "type" field instead of
directly using the structure field.
While here, remove access to temperature field, as this driver is
reporting fake temperature, which can be replaced with
INT3400_FAKE_TEMP. Also replace hardcoded 20C with INT3400_FAKE_TEMP.
"

The change itself looks fine.

Thanks,
Srinivas

> > 

> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >   .../thermal/intel/int340x_thermal/int3400_thermal.c  | 12
> > ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index 810231b59dcd..66e34241b33a 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -15,6 +15,7 @@
> >   #define INT3400_THERMAL_TABLE_CHANGED 0x83
> >   #define INT3400_ODVP_CHANGED 0x88
> >   #define INT3400_KEEP_ALIVE 0xA0
> > +#define INT3400_FAKE_TEMP (20 * 1000) /* faked temp sensor with
> > 20C */
> >   
> >   enum int3400_thermal_uuid {
> >         INT3400_THERMAL_ACTIVE = 0,
> > @@ -453,6 +454,7 @@ static void int3400_notify(acpi_handle handle,
> >                         void *data)
> >   {
> >         struct int3400_thermal_priv *priv = data;
> > +       struct device *dev;
> >         char *thermal_prop[5];
> >         int therm_event;
> >   
> > @@ -475,12 +477,14 @@ static void int3400_notify(acpi_handle
> > handle,
> >                 return;
> >         }
> >   
> > -       thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", priv-
> > >thermal->type);
> > -       thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", priv-
> > >thermal->temperature);
> > +       dev = thermal_zone_device(priv->thermal);
> > +       
> > +       thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s",
> > thermal_zone_device_type(priv->thermal));
> > +       thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d",
> > INT3400_FAKE_TEMP);
> >         thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=");
> >         thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d",
> > therm_event);
> >         thermal_prop[4] = NULL;
> > -       kobject_uevent_env(&priv->thermal->device.kobj,
> > KOBJ_CHANGE, thermal_prop);
> > +       kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, thermal_prop);
> >         kfree(thermal_prop[0]);
> >         kfree(thermal_prop[1]);
> >         kfree(thermal_prop[2]);
> > @@ -490,7 +494,7 @@ static void int3400_notify(acpi_handle handle,
> >   static int int3400_thermal_get_temp(struct thermal_zone_device
> > *thermal,
> >                         int *temp)
> >   {
> > -       *temp = 20 * 1000; /* faked temp sensor with 20C */
> > +       *temp = INT3400_FAKE_TEMP;
> >         return 0;
> >   }
> >   
> 

