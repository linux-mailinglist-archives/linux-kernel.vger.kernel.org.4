Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689716A69EB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCAJjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:38:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8130B311ED;
        Wed,  1 Mar 2023 01:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677663537; x=1709199537;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mwzi1nOCe5KSvSMHkgAMvU654fpFvrxwhFKDR1Q+JbA=;
  b=PbMlW8vADZ0lLS0VNAyI1ZWY50EHPR9lSRvw/2wKAfHFLl2x2IGwhdqF
   xf72k4+CrSSLJ7gdtgfo/Rc+ERhmWfniIT5f2FKr0p8gbfWvFl+LnvcJx
   64c94cy+eVwrmhB/8y3p1M8IusosQ5N5Zq9jJ2ppCIDW4Xvn4FGoEqvUf
   kC0QieS/mmUfARfVZnbzkmqWW0Ec2PYwBE0dUoW6U15OZTzXtDMy/lDeo
   FdyFP3uVpGo8nKd9nUM97IgYVWR7kpTYFYPgyPUClXCKnQe+4iXJQt9Ou
   EuBHsPsNP+xqbVt58sLvszjuIlbsBqc9ghp6zNom/wAM3O48WKF16CLjm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="322627023"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="322627023"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 01:38:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="624418784"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="624418784"
Received: from dsvarnas-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.46.249])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 01:38:51 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>, ojeda@kernel.org
Cc:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@sberdevices.ru, linux-leds@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: AUXdisplay for LED arrays, keyboards with per-key LEDs -- was
 Re: [PATCH v2 2/2] leds: add aw20xx driver
In-Reply-To: <Y/50tKxpNVZO4Hfb@duo.ucw.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
 <20230228211046.109693-3-mmkurbanov@sberdevices.ru>
 <Y/5xBGFC3b9Chdtb@duo.ucw.cz> <Y/50tKxpNVZO4Hfb@duo.ucw.cz>
Date:   Wed, 01 Mar 2023 11:38:49 +0200
Message-ID: <87h6v4x13q.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > +config LEDS_AW200XX
>> > +	tristate "LED support for Awinic AW20036/AW20054/AW20072"
>> > +	depends on LEDS_CLASS
>> > +	depends on I2C
>> > +	help
>> > +	  This option enables support for the AW20036/AW20054/AW20072 LED driver.
>> > +	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
>> > +	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
>> > +	  3 pattern controllers for auto breathing or group dimming control.
>> 
>> I'm afraid this should be handled as a display, not as an array of
>> individual LEDs.
>
> You probably want to see
>
> AUXILIARY DISPLAY DRIVERS
> M:      Miguel Ojeda <ojeda@kernel.org>
> S:      Maintained
> F:      Documentation/devicetree/bindings/auxdisplay/
> F:      drivers/auxdisplay/
> F:      include/linux/cfag12864b.h
>
> And this brings another question...
>
> ...sooner or later we'll see LED displays with around 100 pixels in
> almost rectangular grid. Minority of the pixels will have funny
> shapes. How will we handle those? Pretend it is regular display with
> some pixels missing? How do we handle cellphone displays with rounded
> corners and holes for front camera?
>
> And yes, such crazy displays are being manufactured -- it is called
> keyboard with per-key backlight... 
>
> https://www.reddit.com/r/MechanicalKeyboards/comments/8dtvgo/keyboard_with_individually_programmable_leds/

But... is that a display or a HID?

Only half-joking, really. This somewhat reminds me of using input system
force feedback stuff for touch screen vibrations.

Cc: Dmitry & linux-input.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
