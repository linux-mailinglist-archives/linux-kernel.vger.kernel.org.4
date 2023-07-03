Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497827459AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGCKIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGCKIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:08:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2469B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688378884; x=1719914884;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+W/Oo8uEx5Jy607+onGcqwW+067ifBhqXdC6qIpcSMY=;
  b=DuKY+4O5Fky0hyCmsTG+BPXTS2Edm9elTIzM6XtvJ23X68n4126/R1l2
   wCiqpkp3OIWHXYF5BM/k0dv+4TO5eRYFI2X/x5Js7jBCPXM1y11aVImBQ
   pT4z7IAXgCm9a8BfsudlmCwrfsCcdyG/hLoHNcwt9zjbVW5+S/lZlX3Ea
   2qLK9/Jk/oUPlh785gvvMc/XkWH/djekDd1IGjJECCO6aOPOD72/qBP9/
   3XBTlAyWhtzjiv/sbk7igv2IEgX1qEjJmKEsjDS2Uz5LiHb/+Ltf6U6gn
   pFxEcTUdyMaSqI9DlWHTUxweL/97pd0VA4o5JkCayQIMe6NiqYz5nbSDK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="343177498"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="343177498"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="808513424"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="808513424"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2023 03:08:02 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGGTR-000HJr-2n;
        Mon, 03 Jul 2023 10:08:01 +0000
Date:   Mon, 3 Jul 2023 18:07:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Airlie <airlied@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: drivers/video/fbdev/nvidia/nvidia.c:1429:17: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
Message-ID: <202307031845.mKhIIAwz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
commit: 04119ab1a49fc41cb70f0472be5455af268fa260 nvidiafb: detect the hardware support before removing console.
date:   5 months ago
config: m68k-randconfig-r093-20230703 (https://download.01.org/0day-ci/archive/20230703/202307031845.mKhIIAwz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307031845.mKhIIAwz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307031845.mKhIIAwz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/nvidia/nvidia.c:1429:17: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *[assigned] REGS @@
   drivers/video/fbdev/nvidia/nvidia.c:1429:17: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/nvidia/nvidia.c:1429:17: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *[assigned] REGS
   drivers/video/fbdev/nvidia/nvidia.c:1447:20: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *REGS @@
   drivers/video/fbdev/nvidia/nvidia.c:1447:20: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/nvidia/nvidia.c:1447:20: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *REGS

vim +1429 drivers/video/fbdev/nvidia/nvidia.c

  1273	
  1274	static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
  1275	{
  1276		struct nvidia_par *par;
  1277		struct fb_info *info;
  1278		unsigned short cmd;
  1279		int ret;
  1280		volatile u32 __iomem *REGS;
  1281		int Chipset;
  1282		u32 Architecture;
  1283	
  1284		NVTRACE_ENTER();
  1285		assert(pd != NULL);
  1286	
  1287		if (pci_enable_device(pd)) {
  1288			printk(KERN_ERR PFX "cannot enable PCI device\n");
  1289			return -ENODEV;
  1290		}
  1291	
  1292		/* enable IO and mem if not already done */
  1293		pci_read_config_word(pd, PCI_COMMAND, &cmd);
  1294		cmd |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
  1295		pci_write_config_word(pd, PCI_COMMAND, cmd);
  1296	
  1297		nvidiafb_fix.mmio_start = pci_resource_start(pd, 0);
  1298		nvidiafb_fix.mmio_len = pci_resource_len(pd, 0);
  1299	
  1300		REGS = ioremap(nvidiafb_fix.mmio_start, nvidiafb_fix.mmio_len);
  1301		if (!REGS) {
  1302			printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
  1303			return -ENODEV;
  1304		}
  1305	
  1306		Chipset = nvidia_get_chipset(pd, REGS);
  1307		Architecture = nvidia_get_arch(Chipset);
  1308		if (Architecture == 0) {
  1309			printk(KERN_ERR PFX "unknown NV_ARCH\n");
  1310			goto err_out;
  1311		}
  1312	
  1313		ret = aperture_remove_conflicting_pci_devices(pd, "nvidiafb");
  1314		if (ret)
  1315			goto err_out;
  1316	
  1317		info = framebuffer_alloc(sizeof(struct nvidia_par), &pd->dev);
  1318		if (!info)
  1319			goto err_out;
  1320	
  1321		par = info->par;
  1322		par->pci_dev = pd;
  1323		info->pixmap.addr = kzalloc(8 * 1024, GFP_KERNEL);
  1324	
  1325		if (info->pixmap.addr == NULL)
  1326			goto err_out_kfree;
  1327	
  1328		if (pci_request_regions(pd, "nvidiafb")) {
  1329			printk(KERN_ERR PFX "cannot request PCI regions\n");
  1330			goto err_out_enable;
  1331		}
  1332	
  1333		par->FlatPanel = flatpanel;
  1334		if (flatpanel == 1)
  1335			printk(KERN_INFO PFX "flatpanel support enabled\n");
  1336		par->FPDither = fpdither;
  1337	
  1338		par->CRTCnumber = forceCRTC;
  1339		par->FpScale = (!noscale);
  1340		par->paneltweak = paneltweak;
  1341		par->reverse_i2c = reverse_i2c;
  1342	
  1343		nvidiafb_fix.smem_start = pci_resource_start(pd, 1);
  1344	
  1345		par->REGS = REGS;
  1346	
  1347		par->Chipset = Chipset;
  1348		par->Architecture = Architecture;
  1349	
  1350		sprintf(nvidiafb_fix.id, "NV%x", (pd->device & 0x0ff0) >> 4);
  1351	
  1352		if (NVCommonSetup(info))
  1353			goto err_out_free_base0;
  1354	
  1355		par->FbAddress = nvidiafb_fix.smem_start;
  1356		par->FbMapSize = par->RamAmountKBytes * 1024;
  1357		if (vram && vram * 1024 * 1024 < par->FbMapSize)
  1358			par->FbMapSize = vram * 1024 * 1024;
  1359	
  1360		/* Limit amount of vram to 64 MB */
  1361		if (par->FbMapSize > 64 * 1024 * 1024)
  1362			par->FbMapSize = 64 * 1024 * 1024;
  1363	
  1364		if(par->Architecture >= NV_ARCH_40)
  1365	  	        par->FbUsableSize = par->FbMapSize - (560 * 1024);
  1366		else
  1367			par->FbUsableSize = par->FbMapSize - (128 * 1024);
  1368		par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :
  1369		    16 * 1024;
  1370		par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
  1371		par->CursorStart = par->FbUsableSize + (32 * 1024);
  1372	
  1373		info->screen_base = ioremap_wc(nvidiafb_fix.smem_start,
  1374					       par->FbMapSize);
  1375		info->screen_size = par->FbUsableSize;
  1376		nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
  1377	
  1378		if (!info->screen_base) {
  1379			printk(KERN_ERR PFX "cannot ioremap FB base\n");
  1380			goto err_out_free_base1;
  1381		}
  1382	
  1383		par->FbStart = info->screen_base;
  1384	
  1385		if (!nomtrr)
  1386			par->wc_cookie = arch_phys_wc_add(nvidiafb_fix.smem_start,
  1387							  par->RamAmountKBytes * 1024);
  1388	
  1389		info->fbops = &nvidia_fb_ops;
  1390		info->fix = nvidiafb_fix;
  1391	
  1392		if (nvidia_set_fbinfo(info) < 0) {
  1393			printk(KERN_ERR PFX "error setting initial video mode\n");
  1394			goto err_out_iounmap_fb;
  1395		}
  1396	
  1397		nvidia_save_vga(par, &par->SavedReg);
  1398	
  1399		pci_set_drvdata(pd, info);
  1400	
  1401		if (backlight)
  1402			nvidia_bl_init(par);
  1403	
  1404		if (register_framebuffer(info) < 0) {
  1405			printk(KERN_ERR PFX "error registering nVidia framebuffer\n");
  1406			goto err_out_iounmap_fb;
  1407		}
  1408	
  1409		printk(KERN_INFO PFX
  1410		       "PCI nVidia %s framebuffer (%dMB @ 0x%lX)\n",
  1411		       info->fix.id,
  1412		       par->FbMapSize / (1024 * 1024), info->fix.smem_start);
  1413	
  1414		NVTRACE_LEAVE();
  1415		return 0;
  1416	
  1417	err_out_iounmap_fb:
  1418		iounmap(info->screen_base);
  1419	err_out_free_base1:
  1420		fb_destroy_modedb(info->monspecs.modedb);
  1421		nvidia_delete_i2c_busses(par);
  1422	err_out_free_base0:
  1423		pci_release_regions(pd);
  1424	err_out_enable:
  1425		kfree(info->pixmap.addr);
  1426	err_out_kfree:
  1427		framebuffer_release(info);
  1428	err_out:
> 1429		iounmap(REGS);
  1430		return -ENODEV;
  1431	}
  1432	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
