Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A202C5BC169
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiISCfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiISCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:35:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DECE0A7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663554900; x=1695090900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pJzFrJkB0Nbc1le4nGOD3AFN3IqIbiIZgq+xh3eakkA=;
  b=ipNalxceKEMpRMiPfozMg5A+d+yqeZIcq1ofC1Z3HoIpKcRzE+xcbDXO
   OgVduCqTsIea1iYFo4gwfTGjKM+8K9wEOaY35TyMVEEAg4/uyJtYhSrP3
   jYOqowEyruvz3A7PM4SpMrQi7MXwjF6AiibjVBowkN0LXlK6Q/IS2PJ4H
   rFLUaAR6fC/N6QS29vo68SUD24gFUpmbEtSo64mtqeIlo+EU4kQPReomO
   QgwCpyAG/ENIRtwh0P1IoetJNmzv0ruPToGB+vy7HrzroVH2SIORxMzeR
   M/k/71myv7A6ObfU7b2v8BwJKra+gC63zJ8s+pFpFpEpNQlrbSwjx3JFh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="298018225"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="298018225"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 19:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="569470662"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 19:34:58 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa6cb-0001ej-1y;
        Mon, 19 Sep 2022 02:34:57 +0000
Date:   Mon, 19 Sep 2022 10:34:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:linux-5.4.y 5317/5387] htmldocs:
 ./drivers/usb/core/hub.c:5926: WARNING: Unknown target name: "pre".
Message-ID: <202209191053.0TKOOfdN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   ba0de553122f5be5dde3102746a1060fd2737e63
commit: df1875084898b15cbc42f712e93d7f113ae6271b [5317/5387] USB: core: Prevent nested device-reset calls
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=df1875084898b15cbc42f712e93d7f113ae6271b
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout df1875084898b15cbc42f712e93d7f113ae6271b
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> ./drivers/usb/core/hub.c:5926: WARNING: Unknown target name: "pre".

vim +/pre +5926 ./drivers/usb/core/hub.c

  5916	
  5917	/**
  5918	 * usb_reset_device - warn interface drivers and perform a USB port reset
  5919	 * @udev: device to reset (not in NOTATTACHED state)
  5920	 *
  5921	 * Warns all drivers bound to registered interfaces (using their pre_reset
  5922	 * method), performs the port reset, and then lets the drivers know that
  5923	 * the reset is over (using their post_reset method).
  5924	 *
  5925	 * Return: The same as for usb_reset_and_verify_device().
> 5926	 * However, if a reset is already in progress (for instance, if a
  5927	 * driver doesn't have pre_ or post_reset() callbacks, and while
  5928	 * being unbound or re-bound during the ongoing reset its disconnect()
  5929	 * or probe() routine tries to perform a second, nested reset), the
  5930	 * routine returns -EINPROGRESS.
  5931	 *
  5932	 * Note:
  5933	 * The caller must own the device lock.  For example, it's safe to use
  5934	 * this from a driver probe() routine after downloading new firmware.
  5935	 * For calls that might not occur during probe(), drivers should lock
  5936	 * the device using usb_lock_device_for_reset().
  5937	 *
  5938	 * If an interface is currently being probed or disconnected, we assume
  5939	 * its driver knows how to handle resets.  For all other interfaces,
  5940	 * if the driver doesn't have pre_reset and post_reset methods then
  5941	 * we attempt to unbind it and rebind afterward.
  5942	 */
  5943	int usb_reset_device(struct usb_device *udev)
  5944	{
  5945		int ret;
  5946		int i;
  5947		unsigned int noio_flag;
  5948		struct usb_port *port_dev;
  5949		struct usb_host_config *config = udev->actconfig;
  5950		struct usb_hub *hub = usb_hub_to_struct_hub(udev->parent);
  5951	
  5952		if (udev->state == USB_STATE_NOTATTACHED) {
  5953			dev_dbg(&udev->dev, "device reset not allowed in state %d\n",
  5954					udev->state);
  5955			return -EINVAL;
  5956		}
  5957	
  5958		if (!udev->parent) {
  5959			/* this requires hcd-specific logic; see ohci_restart() */
  5960			dev_dbg(&udev->dev, "%s for root hub!\n", __func__);
  5961			return -EISDIR;
  5962		}
  5963	
  5964		if (udev->reset_in_progress)
  5965			return -EINPROGRESS;
  5966		udev->reset_in_progress = 1;
  5967	
  5968		port_dev = hub->ports[udev->portnum - 1];
  5969	
  5970		/*
  5971		 * Don't allocate memory with GFP_KERNEL in current
  5972		 * context to avoid possible deadlock if usb mass
  5973		 * storage interface or usbnet interface(iSCSI case)
  5974		 * is included in current configuration. The easist
  5975		 * approach is to do it for every device reset,
  5976		 * because the device 'memalloc_noio' flag may have
  5977		 * not been set before reseting the usb device.
  5978		 */
  5979		noio_flag = memalloc_noio_save();
  5980	
  5981		/* Prevent autosuspend during the reset */
  5982		usb_autoresume_device(udev);
  5983	
  5984		if (config) {
  5985			for (i = 0; i < config->desc.bNumInterfaces; ++i) {
  5986				struct usb_interface *cintf = config->interface[i];
  5987				struct usb_driver *drv;
  5988				int unbind = 0;
  5989	
  5990				if (cintf->dev.driver) {
  5991					drv = to_usb_driver(cintf->dev.driver);
  5992					if (drv->pre_reset && drv->post_reset)
  5993						unbind = (drv->pre_reset)(cintf);
  5994					else if (cintf->condition ==
  5995							USB_INTERFACE_BOUND)
  5996						unbind = 1;
  5997					if (unbind)
  5998						usb_forced_unbind_intf(cintf);
  5999				}
  6000			}
  6001		}
  6002	
  6003		usb_lock_port(port_dev);
  6004		ret = usb_reset_and_verify_device(udev);
  6005		usb_unlock_port(port_dev);
  6006	
  6007		if (config) {
  6008			for (i = config->desc.bNumInterfaces - 1; i >= 0; --i) {
  6009				struct usb_interface *cintf = config->interface[i];
  6010				struct usb_driver *drv;
  6011				int rebind = cintf->needs_binding;
  6012	
  6013				if (!rebind && cintf->dev.driver) {
  6014					drv = to_usb_driver(cintf->dev.driver);
  6015					if (drv->post_reset)
  6016						rebind = (drv->post_reset)(cintf);
  6017					else if (cintf->condition ==
  6018							USB_INTERFACE_BOUND)
  6019						rebind = 1;
  6020					if (rebind)
  6021						cintf->needs_binding = 1;
  6022				}
  6023			}
  6024	
  6025			/* If the reset failed, hub_wq will unbind drivers later */
  6026			if (ret == 0)
  6027				usb_unbind_and_rebind_marked_interfaces(udev);
  6028		}
  6029	
  6030		usb_autosuspend_device(udev);
  6031		memalloc_noio_restore(noio_flag);
  6032		udev->reset_in_progress = 0;
  6033		return ret;
  6034	}
  6035	EXPORT_SYMBOL_GPL(usb_reset_device);
  6036	
  6037	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
