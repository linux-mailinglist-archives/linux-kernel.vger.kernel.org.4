Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545246F1EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346493AbjD1Tgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjD1Tgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:36:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A202D5A;
        Fri, 28 Apr 2023 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682710605; x=1714246605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FAJUUXf4d4aa3toRqRURR1Y0gLUmEA655XuauHpmeVo=;
  b=i2BkQWkwVlJlXi9Dmjce4WSZh+d3iFIISwVTmKCq+CsfMKZFGcQzRgry
   TAMjHbay1jekNI13QBkPun4z2C0ZIUggPIoKxv+rmGSpnHv4+bJFib7sC
   RzKx4y4T3DeOqSg7Do+ErRdSoRM+LKwf/OLksbuqwP/XCn9avE9AF3pVJ
   4vixQNQdCsx0L0Zv8OMXjB7ONR4TmAPJaW8omSmJao0q2mjCPdLDGkWl2
   1X5qdcyF27h120jJW7gYoglzyjxwZm//C8P8WL8qCCDBNplFoKBx+y6bb
   GsgPVeGMZmHqkMwkCG+DTVSkkd6cOhOA0WiuD/O2+CMhXHYy2A0HGTh9M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="375839463"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="375839463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 12:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="727654367"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="727654367"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2023 12:36:42 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psTtZ-0000dV-0H;
        Fri, 28 Apr 2023 19:36:41 +0000
Date:   Sat, 29 Apr 2023 03:36:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_bgodavar@quicinc.com, quic_rameshn@quicinc.com,
        jiangzp@google.com, mmandlik@google.com,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_qca: Add qcomm devcoredump sysfs
 support
Message-ID: <202304290337.5apzPPgA-lkp@intel.com>
References: <1682666213-7973-1-git-send-email-quic_saluvala@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682666213-7973-1-git-send-email-quic_saluvala@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.3 next-20230427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Teja-Aluvala/Bluetooth-hci_qca-Add-qcomm-devcoredump-support/20230428-152145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/1682666213-7973-1-git-send-email-quic_saluvala%40quicinc.com
patch subject: [PATCH v1 1/2] Bluetooth: hci_qca: Add qcomm devcoredump sysfs support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230429/202304290337.5apzPPgA-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/14f992843ff24a60f1eab6bb1024679f5f0aafae
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sai-Teja-Aluvala/Bluetooth-hci_qca-Add-qcomm-devcoredump-support/20230428-152145
        git checkout 14f992843ff24a60f1eab6bb1024679f5f0aafae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304290337.5apzPPgA-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/hci_qca.c: In function 'hciqca_coredump_enabled':
>> drivers/bluetooth/hci_qca.c:1705:32: error: 'struct device' has no member named 'coredump_disabled'
    1705 |         return !hu->serdev->dev.coredump_disabled;
         |                                ^
   drivers/bluetooth/hci_qca.c: In function 'qca_setup':
>> drivers/bluetooth/hci_qca.c:1785:25: error: 'struct hci_dev' has no member named 'dump'
    1785 |                 hu->hdev->dump.enabled = hciqca_coredump_enabled;
         |                         ^~
   drivers/bluetooth/hci_qca.c: In function 'hciqca_coredump':
   drivers/bluetooth/hci_qca.c:2374:17: error: 'struct device' has no member named 'coredump_disabled'
    2374 |         if (!dev->coredump_disabled && hdev->dump.coredump)
         |                 ^~
   drivers/bluetooth/hci_qca.c:2374:44: error: 'struct hci_dev' has no member named 'dump'
    2374 |         if (!dev->coredump_disabled && hdev->dump.coredump)
         |                                            ^~
   drivers/bluetooth/hci_qca.c:2375:21: error: 'struct hci_dev' has no member named 'dump'
    2375 |                 hdev->dump.coredump(hdev);
         |                     ^~


vim +1705 drivers/bluetooth/hci_qca.c

  1699	
  1700	#ifdef CONFIG_DEV_COREDUMP
  1701	static bool hciqca_coredump_enabled(struct hci_dev *hdev)
  1702	{
  1703		struct hci_uart *hu = hci_get_drvdata(hdev);
  1704	
> 1705		return !hu->serdev->dev.coredump_disabled;
  1706	}
  1707	#endif
  1708	
  1709	static int qca_setup(struct hci_uart *hu)
  1710	{
  1711		struct hci_dev *hdev = hu->hdev;
  1712		struct qca_data *qca = hu->priv;
  1713		unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
  1714		unsigned int retries = 0;
  1715		enum qca_btsoc_type soc_type = qca_soc_type(hu);
  1716		const char *firmware_name = qca_get_firmware_name(hu);
  1717		int ret;
  1718		struct qca_btsoc_version ver;
  1719	
  1720		ret = qca_check_speeds(hu);
  1721		if (ret)
  1722			return ret;
  1723	
  1724		clear_bit(QCA_ROM_FW, &qca->flags);
  1725		/* Patch downloading has to be done without IBS mode */
  1726		set_bit(QCA_IBS_DISABLED, &qca->flags);
  1727	
  1728		/* Enable controller to do both LE scan and BR/EDR inquiry
  1729		 * simultaneously.
  1730		 */
  1731		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
  1732	
  1733		bt_dev_info(hdev, "setting up %s",
  1734			qca_is_wcn399x(soc_type) ? "wcn399x" :
  1735			(soc_type == QCA_WCN6750) ? "wcn6750" : "ROME/QCA6390");
  1736	
  1737		qca->memdump_state = QCA_MEMDUMP_IDLE;
  1738	
  1739	retry:
  1740		ret = qca_power_on(hdev);
  1741		if (ret)
  1742			goto out;
  1743	
  1744		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
  1745	
  1746		if (qca_is_wcn399x(soc_type) ||
  1747		    qca_is_wcn6750(soc_type)) {
  1748			set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
  1749			hci_set_aosp_capable(hdev);
  1750	
  1751			ret = qca_read_soc_version(hdev, &ver, soc_type);
  1752			if (ret)
  1753				goto out;
  1754		} else {
  1755			qca_set_speed(hu, QCA_INIT_SPEED);
  1756		}
  1757	
  1758		/* Setup user speed if needed */
  1759		speed = qca_get_speed(hu, QCA_OPER_SPEED);
  1760		if (speed) {
  1761			ret = qca_set_speed(hu, QCA_OPER_SPEED);
  1762			if (ret)
  1763				goto out;
  1764	
  1765			qca_baudrate = qca_get_baudrate_value(speed);
  1766		}
  1767	
  1768		if (!(qca_is_wcn399x(soc_type) ||
  1769		     qca_is_wcn6750(soc_type))) {
  1770			/* Get QCA version information */
  1771			ret = qca_read_soc_version(hdev, &ver, soc_type);
  1772			if (ret)
  1773				goto out;
  1774		}
  1775	
  1776		/* Setup patch / NVM configurations */
  1777		ret = qca_uart_setup(hdev, qca_baudrate, soc_type, ver,
  1778				firmware_name);
  1779		if (!ret) {
  1780			clear_bit(QCA_IBS_DISABLED, &qca->flags);
  1781			qca_debugfs_init(hdev);
  1782			hu->hdev->hw_error = qca_hw_error;
  1783			hu->hdev->cmd_timeout = qca_cmd_timeout;
  1784	#ifdef CONFIG_DEV_COREDUMP
> 1785			hu->hdev->dump.enabled = hciqca_coredump_enabled;
  1786	#endif
  1787			if (device_can_wakeup(hu->serdev->ctrl->dev.parent))
  1788				hu->hdev->wakeup = qca_wakeup;
  1789		} else if (ret == -ENOENT) {
  1790			/* No patch/nvm-config found, run with original fw/config */
  1791			set_bit(QCA_ROM_FW, &qca->flags);
  1792			ret = 0;
  1793		} else if (ret == -EAGAIN) {
  1794			/*
  1795			 * Userspace firmware loader will return -EAGAIN in case no
  1796			 * patch/nvm-config is found, so run with original fw/config.
  1797			 */
  1798			set_bit(QCA_ROM_FW, &qca->flags);
  1799			ret = 0;
  1800		}
  1801	
  1802	out:
  1803		if (ret && retries < MAX_INIT_RETRIES) {
  1804			bt_dev_warn(hdev, "Retry BT power ON:%d", retries);
  1805			qca_power_shutdown(hu);
  1806			if (hu->serdev) {
  1807				serdev_device_close(hu->serdev);
  1808				ret = serdev_device_open(hu->serdev);
  1809				if (ret) {
  1810					bt_dev_err(hdev, "failed to open port");
  1811					return ret;
  1812				}
  1813			}
  1814			retries++;
  1815			goto retry;
  1816		}
  1817	
  1818		/* Setup bdaddr */
  1819		if (soc_type == QCA_ROME)
  1820			hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
  1821		else
  1822			hu->hdev->set_bdaddr = qca_set_bdaddr;
  1823	
  1824		return ret;
  1825	}
  1826	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
