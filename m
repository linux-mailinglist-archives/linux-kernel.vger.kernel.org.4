Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52058688DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjBCDSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjBCDSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:18:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90B23652;
        Thu,  2 Feb 2023 19:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675394311; x=1706930311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IAVrdyU7SUG1n2ySXvR3lW7L1iBU+Rd8/BYmuWxFtIk=;
  b=GvJhckVRt8PPJ/anCatFCxsH6/eEoN2ZAItcZ1fwmOiII/yrkkugjSCD
   PEkgrEmuNXRtPqxSUKIwFiENLAZSKjvfVWvY/vWoXtuyqfO6UbH0oRwXv
   WNMmMkcNgrWmkD01bV9cv1cYuqKNRtVxA81RsExirx+p+5+IRmJ3d7L74
   1o+sFjg2EXuWdoE0eeQ19ZqZC9hWCWLXF+mi0HYg4tENYmFiAtBE4/he4
   qpTGcR8g4a+oD+ikmrCAwdWIlmDCwoNp+KeM+JIywPPvd0sMGPraUwAwg
   PUuMHhsqPn/cu1qN5NYuuFr3Z7G4cKWDrrZ51CJQ8ex6fcYlJCMJK7aZr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="355985044"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="355985044"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 19:18:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="734167353"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="734167353"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2023 19:18:29 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNmaq-00001G-1e;
        Fri, 03 Feb 2023 03:18:28 +0000
Date:   Fri, 3 Feb 2023 11:18:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allen Ballway <ballway@chromium.org>, benjamin.tissoires@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, jikos@kernel.org,
        lukas.bulwahn@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Allen Ballway <ballway@chromium.org>
Subject: Re: [PATCH] HID: multitouch: Fix typo in config check
Message-ID: <202302031117.u6FdSXY2-lkp@intel.com>
References: <20230202144149.1.I7f213388b358718068c63acb698dc4937716cf35@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202144149.1.I7f213388b358718068c63acb698dc4937716cf35@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hid/for-next]
[also build test ERROR on next-20230202]
[cannot apply to linus/master v6.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Allen-Ballway/HID-multitouch-Fix-typo-in-config-check/20230202-224919
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230202144149.1.I7f213388b358718068c63acb698dc4937716cf35%40changeid
patch subject: [PATCH] HID: multitouch: Fix typo in config check
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20230203/202302031117.u6FdSXY2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a2331d08db1030f3e3f2e0d9c9232780c27d954a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Allen-Ballway/HID-multitouch-Fix-typo-in-config-check/20230202-224919
        git checkout a2331d08db1030f3e3f2e0d9c9232780c27d954a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `hid_lookup_quirk':
>> drivers/hid/hid-quirks.c:1305: undefined reference to `i2c_hid_get_dmi_quirks'


vim +1305 drivers/hid/hid-quirks.c

d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1258  
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1259  /**
0603616a5bf6cd Randy Dunlap       2021-01-19  1260   * hid_lookup_quirk - return any quirks associated with a HID device
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1261   * @hdev: the HID device to look for
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1262   *
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1263   * Description:
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1264   *     Given a HID device, return any quirks associated with that device.
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1265   *
0603616a5bf6cd Randy Dunlap       2021-01-19  1266   * Return: an unsigned long quirks value.
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1267   */
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1268  unsigned long hid_lookup_quirk(const struct hid_device *hdev)
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1269  {
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1270  	unsigned long quirks = 0;
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1271  	const struct hid_device_id *quirk_entry = NULL;
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1272  
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1273  	/* NCR devices must not be queried for reports */
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1274  	if (hdev->bus == BUS_USB &&
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1275  	    hdev->vendor == USB_VENDOR_ID_NCR &&
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1276  	    hdev->product >= USB_DEVICE_ID_NCR_FIRST &&
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1277  	    hdev->product <= USB_DEVICE_ID_NCR_LAST)
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1278  		return HID_QUIRK_NO_INIT_REPORTS;
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1279  
d5158e020c4593 Niels Skou Olsen   2017-10-04  1280  	/* These devices must be ignored if version (bcdDevice) is too old */
d5158e020c4593 Niels Skou Olsen   2017-10-04  1281  	if (hdev->bus == BUS_USB && hdev->vendor == USB_VENDOR_ID_JABRA) {
d5158e020c4593 Niels Skou Olsen   2017-10-04  1282  		switch (hdev->product) {
d5158e020c4593 Niels Skou Olsen   2017-10-04  1283  		case USB_DEVICE_ID_JABRA_SPEAK_410:
d5158e020c4593 Niels Skou Olsen   2017-10-04  1284  			if (hdev->version < 0x0111)
d5158e020c4593 Niels Skou Olsen   2017-10-04  1285  				return HID_QUIRK_IGNORE;
d5158e020c4593 Niels Skou Olsen   2017-10-04  1286  			break;
d5158e020c4593 Niels Skou Olsen   2017-10-04  1287  		case USB_DEVICE_ID_JABRA_SPEAK_510:
d5158e020c4593 Niels Skou Olsen   2017-10-04  1288  			if (hdev->version < 0x0214)
d5158e020c4593 Niels Skou Olsen   2017-10-04  1289  				return HID_QUIRK_IGNORE;
d5158e020c4593 Niels Skou Olsen   2017-10-04  1290  			break;
d5158e020c4593 Niels Skou Olsen   2017-10-04  1291  		}
d5158e020c4593 Niels Skou Olsen   2017-10-04  1292  	}
d5158e020c4593 Niels Skou Olsen   2017-10-04  1293  
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1294  	mutex_lock(&dquirks_lock);
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1295  	quirk_entry = hid_exists_dquirk(hdev);
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1296  	if (quirk_entry)
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1297  		quirks = quirk_entry->driver_data;
6e65d9d5492f37 Benjamin Tissoires 2017-11-20  1298  	else
6e65d9d5492f37 Benjamin Tissoires 2017-11-20  1299  		quirks = hid_gets_squirk(hdev);
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1300  	mutex_unlock(&dquirks_lock);
d5d3e202753cc0 Benjamin Tissoires 2017-11-20  1301  
a2f416bf062a38 Allen Ballway      2023-01-10  1302  	/* Get quirks specific to I2C devices */
a2331d08db1030 Allen Ballway      2023-02-02  1303  	if (IS_ENABLED(CONFIG_I2C_HID_CORE) && IS_ENABLED(CONFIG_DMI) &&
a2f416bf062a38 Allen Ballway      2023-01-10  1304  	    hdev->bus == BUS_I2C)
a2f416bf062a38 Allen Ballway      2023-01-10 @1305  		quirks |= i2c_hid_get_dmi_quirks(hdev->vendor, hdev->product);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
