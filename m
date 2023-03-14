Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21EF6B8DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCNIsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjCNIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:48:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A23C15;
        Tue, 14 Mar 2023 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678783714; x=1710319714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=60VgM0ZqtvUKEdzCA81b6vxDKOeBgKlL4EKaxFMBkWE=;
  b=cKfqRGSv0Z9nuTgjlWIQfU6/GLvk31anRL0IkEMjLEX1q4eIVkVd6p6Z
   9Y2eHhjah5UwNttp1cDFxj2bjzJKYVC3wv+P5RY/dgSgwX0xqSDIQjoTO
   CgTdPX4yAKRsHz4k9EDmmNwiXmPvDg9Kd+zu7s/sgN1wo8BB/7JPSO/9Q
   OxUPcwJ1Do5+/Tse6wBlMLSjjyDE4Q+vV9xab4Cpu9smSkmVZnUC75SdL
   kCCePPRuVxvw0NnTelnQcR4/Bd08o5SEDfdZciMqroQc6WR3hO5U5hrYH
   YHMw5JdUYT5x9c6zPY98LoFKNWoP1E0dt2yL6nfHM4YQNcC1hy+Op+I0a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317754227"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="317754227"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 01:48:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="822285848"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="822285848"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 14 Mar 2023 01:48:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Mar 2023 10:48:30 +0200
Date:   Tue, 14 Mar 2023 10:48:30 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Johan Hovold <johan@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 36/36] USB: mark all struct bus_type as const
Message-ID: <ZBA03vH2B+tPUVAP@kuha.fi.intel.com>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-36-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-36-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:29:18PM +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move all of the USB subsystem struct bus_type structures as const,
> placing them into read-only memory which can not be modified at runtime.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/common/ulpi.c     | 2 +-
>  drivers/usb/core/driver.c     | 2 +-
>  drivers/usb/core/usb.h        | 2 +-
>  drivers/usb/gadget/udc/core.c | 4 ++--
>  drivers/usb/serial/bus.c      | 2 +-
>  drivers/usb/typec/bus.c       | 2 +-
>  drivers/usb/typec/bus.h       | 2 +-
>  include/linux/usb/serial.h    | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index a98b2108376a..8305a5dfb910 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -90,7 +90,7 @@ static void ulpi_remove(struct device *dev)
>  		drv->remove(to_ulpi_dev(dev));
>  }
>  
> -static struct bus_type ulpi_bus = {
> +static const struct bus_type ulpi_bus = {
>  	.name = "ulpi",
>  	.match = ulpi_match,
>  	.uevent = ulpi_uevent,
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index a0e076c6f3a4..f58a0299fb3b 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -2025,7 +2025,7 @@ int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
>  
>  #endif /* CONFIG_PM */
>  
> -struct bus_type usb_bus_type = {
> +const struct bus_type usb_bus_type = {
>  	.name =		"usb",
>  	.match =	usb_device_match,
>  	.uevent =	usb_uevent,
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index 0eac7d4285d1..cd434af259c3 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -140,7 +140,7 @@ static inline int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
>  
>  #endif
>  
> -extern struct bus_type usb_bus_type;
> +extern const struct bus_type usb_bus_type;
>  extern struct mutex usb_port_peer_mutex;
>  extern struct device_type usb_device_type;
>  extern struct device_type usb_if_device_type;
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 23b0629a8774..61a9c231deb9 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -26,7 +26,7 @@
>  
>  static DEFINE_IDA(gadget_id_numbers);
>  
> -static struct bus_type gadget_bus_type;
> +static const struct bus_type gadget_bus_type;
>  
>  /**
>   * struct usb_udc - describes one usb device controller
> @@ -1747,7 +1747,7 @@ static int usb_udc_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> -static struct bus_type gadget_bus_type = {
> +static const struct bus_type gadget_bus_type = {
>  	.name = "gadget",
>  	.probe = gadget_bind_driver,
>  	.remove = gadget_unbind_driver,
> diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
> index 9e38142acd38..3eb8dc3a1a8f 100644
> --- a/drivers/usb/serial/bus.c
> +++ b/drivers/usb/serial/bus.c
> @@ -144,7 +144,7 @@ static void free_dynids(struct usb_serial_driver *drv)
>  	spin_unlock(&drv->dynids.lock);
>  }
>  
> -struct bus_type usb_serial_bus_type = {
> +const struct bus_type usb_serial_bus_type = {
>  	.name =		"usb-serial",
>  	.match =	usb_serial_device_match,
>  	.probe =	usb_serial_device_probe,
> diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> index 098f0efaa58d..fe5b9a2e61f5 100644
> --- a/drivers/usb/typec/bus.c
> +++ b/drivers/usb/typec/bus.c
> @@ -431,7 +431,7 @@ static void typec_remove(struct device *dev)
>  	adev->ops = NULL;
>  }
>  
> -struct bus_type typec_bus = {
> +const struct bus_type typec_bus = {
>  	.name = "typec",
>  	.dev_groups = typec_groups,
>  	.match = typec_match,
> diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
> index c89168857417..643b8c81786d 100644
> --- a/drivers/usb/typec/bus.h
> +++ b/drivers/usb/typec/bus.h
> @@ -28,7 +28,7 @@ struct altmode {
>  
>  #define to_altmode(d) container_of(d, struct altmode, adev)
>  
> -extern struct bus_type typec_bus;
> +extern const struct bus_type typec_bus;
>  extern const struct device_type typec_altmode_dev_type;
>  
>  #define is_typec_altmode(_dev_) (_dev_->type == &typec_altmode_dev_type)
> diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
> index f7bfedb740f5..7eeb5f9c4f0d 100644
> --- a/include/linux/usb/serial.h
> +++ b/include/linux/usb/serial.h
> @@ -378,7 +378,7 @@ void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
>  int usb_serial_bus_register(struct usb_serial_driver *device);
>  void usb_serial_bus_deregister(struct usb_serial_driver *device);
>  
> -extern struct bus_type usb_serial_bus_type;
> +extern const struct bus_type usb_serial_bus_type;
>  extern struct tty_driver *usb_serial_tty_driver;
>  
>  static inline void usb_serial_debug_data(struct device *dev,
> -- 
> 2.39.2

-- 
heikki
