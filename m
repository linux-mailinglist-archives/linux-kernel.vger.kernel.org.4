Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C5603894
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJSDYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJSDYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:24:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6AD93
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 20:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666149864; x=1697685864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zdn6t+OjxRFLwvJ7gkAq99eaaeW5Rj313jvQMq6NkUY=;
  b=HBmH977JzWaXOG6zu7ze6CifNVUQkY52/BwX8ge0KUn6E/sG2phdVRei
   dahgU92gUsCT9tpYY8xZMrJbvgul6kudaejV9lqdKAU69sEZ6fhlnHBxI
   1fCPUr/xq3kR0zr0vuWklK0dKtYPnJRNfNQGzvwo7dfSD/4Vo18miblRD
   mp/rXfHsUElw7B7aYbsXbpuSHOWfe4hlnWYkQJkbLUJKOC8A/Es4zIYK5
   niivRVi/+7/nNADIQNNhGz9de1ec+SFDaK2UzsvqM8i8aYHGv6gz8zJEB
   0ftl96n5xMPCSShtZ/IF5HofNNh1lpdq2l98Skc+muX0FrQ9euU8Vq3+G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="370514378"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="370514378"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 20:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771552113"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="771552113"
Received: from lkp-server01.sh.intel.com (HELO 8381f64adc98) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 20:24:23 -0700
Received: from kbuild by 8381f64adc98 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1okzgs-0002O0-16;
        Wed, 19 Oct 2022 03:24:22 +0000
Date:   Wed, 19 Oct 2022 11:23:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/sun/sunhme.c:3067:6: warning: Local variable
 'addr' shadows outer variable [shadowVariable]
Message-ID: <202210191135.jhsf1Fa4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aae703b02f92bde9264366c545e87cec451de471
commit: a7639279c93c1e07a703c0f86f0831d4ea2314f0 ethernet: sun: remove direct netdev->dev_addr writes
date:   1 year ago
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout a7639279c93c1e07a703c0f86f0831d4ea2314f0
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/sun/sunhme.c:3067:6: warning: Local variable 'addr' shadows outer variable [shadowVariable]
     u8 addr[ETH_ALEN];
        ^
   drivers/net/ethernet/sun/sunhme.c:2974:5: note: Shadowed declaration
    u8 addr[ETH_ALEN];
       ^
   drivers/net/ethernet/sun/sunhme.c:3067:6: note: Shadow variable
     u8 addr[ETH_ALEN];
        ^
>> drivers/net/ethernet/sun/sunhme.c:3159:8: warning: Local variable 'i' shadows outer variable [shadowVariable]
      int i = simple_strtoul(dev->name + 3, NULL, 10);
          ^
   drivers/net/ethernet/sun/sunhme.c:2972:6: note: Shadowed declaration
    int i, qfe_slot = -1;
        ^
   drivers/net/ethernet/sun/sunhme.c:3159:8: note: Shadow variable
      int i = simple_strtoul(dev->name + 3, NULL, 10);
          ^
   drivers/net/ethernet/sun/sunhme.c:2706:24: warning: Local variable 'addr' shadows outer variable [shadowVariable]
     const unsigned char *addr;
                          ^
   drivers/net/ethernet/sun/sunhme.c:2664:5: note: Shadowed declaration
    u8 addr[ETH_ALEN];
       ^
   drivers/net/ethernet/sun/sunhme.c:2706:24: note: Shadow variable
     const unsigned char *addr;
                          ^
   drivers/net/ethernet/sun/sunhme.c:3055:24: warning: Local variable 'addr' shadows outer variable [shadowVariable]
     const unsigned char *addr;
                          ^
   drivers/net/ethernet/sun/sunhme.c:2974:5: note: Shadowed declaration
    u8 addr[ETH_ALEN];
       ^
   drivers/net/ethernet/sun/sunhme.c:3055:24: note: Shadow variable
     const unsigned char *addr;
                          ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/tty/serial/msm_serial.c:1087:29: warning: Expression is always true because 'else if' condition is opposite to previous condition at line 1074. [multiCondition]
     } else if (entry->divisor > divisor) {
                               ^
   drivers/tty/serial/msm_serial.c:1074:22: note: first condition
     if (entry->divisor <= divisor) {
                        ^
   drivers/tty/serial/msm_serial.c:1087:29: note: else if condition is opposite to first condition
     } else if (entry->divisor > divisor) {
                               ^

vim +/addr +3067 drivers/net/ethernet/sun/sunhme.c

  2987	
  2988		err = -ENODEV;
  2989	
  2990		if (pci_enable_device(pdev))
  2991			goto err_out;
  2992		pci_set_master(pdev);
  2993	
  2994		if (!strcmp(prom_name, "SUNW,qfe") || !strcmp(prom_name, "qfe")) {
  2995			qp = quattro_pci_find(pdev);
  2996			if (qp == NULL)
  2997				goto err_out;
  2998			for (qfe_slot = 0; qfe_slot < 4; qfe_slot++)
  2999				if (qp->happy_meals[qfe_slot] == NULL)
  3000					break;
  3001			if (qfe_slot == 4)
  3002				goto err_out;
  3003		}
  3004	
  3005		dev = alloc_etherdev(sizeof(struct happy_meal));
  3006		err = -ENOMEM;
  3007		if (!dev)
  3008			goto err_out;
  3009		SET_NETDEV_DEV(dev, &pdev->dev);
  3010	
  3011		if (hme_version_printed++ == 0)
  3012			printk(KERN_INFO "%s", version);
  3013	
  3014		hp = netdev_priv(dev);
  3015	
  3016		hp->happy_dev = pdev;
  3017		hp->dma_dev = &pdev->dev;
  3018	
  3019		spin_lock_init(&hp->happy_lock);
  3020	
  3021		if (qp != NULL) {
  3022			hp->qfe_parent = qp;
  3023			hp->qfe_ent = qfe_slot;
  3024			qp->happy_meals[qfe_slot] = dev;
  3025		}
  3026	
  3027		hpreg_res = pci_resource_start(pdev, 0);
  3028		err = -ENODEV;
  3029		if ((pci_resource_flags(pdev, 0) & IORESOURCE_IO) != 0) {
  3030			printk(KERN_ERR "happymeal(PCI): Cannot find proper PCI device base address.\n");
  3031			goto err_out_clear_quattro;
  3032		}
  3033		if (pci_request_regions(pdev, DRV_NAME)) {
  3034			printk(KERN_ERR "happymeal(PCI): Cannot obtain PCI resources, "
  3035			       "aborting.\n");
  3036			goto err_out_clear_quattro;
  3037		}
  3038	
  3039		if ((hpreg_base = ioremap(hpreg_res, 0x8000)) == NULL) {
  3040			printk(KERN_ERR "happymeal(PCI): Unable to remap card memory.\n");
  3041			goto err_out_free_res;
  3042		}
  3043	
  3044		for (i = 0; i < 6; i++) {
  3045			if (macaddr[i] != 0)
  3046				break;
  3047		}
  3048		if (i < 6) { /* a mac address was given */
  3049			for (i = 0; i < 6; i++)
  3050				addr[i] = macaddr[i];
  3051			eth_hw_addr_set(dev, addr);
  3052			macaddr[5]++;
  3053		} else {
  3054	#ifdef CONFIG_SPARC
  3055			const unsigned char *addr;
  3056			int len;
  3057	
  3058			if (qfe_slot != -1 &&
  3059			    (addr = of_get_property(dp, "local-mac-address", &len))
  3060				!= NULL &&
  3061			    len == 6) {
  3062				eth_hw_addr_set(dev, addr);
  3063			} else {
  3064				eth_hw_addr_set(dev, idprom->id_ethaddr);
  3065			}
  3066	#else
> 3067			u8 addr[ETH_ALEN];
  3068	
  3069			get_hme_mac_nonsparc(pdev, addr);
  3070			eth_hw_addr_set(dev, addr);
  3071	#endif
  3072		}
  3073	
  3074		/* Layout registers. */
  3075		hp->gregs      = (hpreg_base + 0x0000UL);
  3076		hp->etxregs    = (hpreg_base + 0x2000UL);
  3077		hp->erxregs    = (hpreg_base + 0x4000UL);
  3078		hp->bigmacregs = (hpreg_base + 0x6000UL);
  3079		hp->tcvregs    = (hpreg_base + 0x7000UL);
  3080	
  3081	#ifdef CONFIG_SPARC
  3082		hp->hm_revision = of_getintprop_default(dp, "hm-rev", 0xff);
  3083		if (hp->hm_revision == 0xff)
  3084			hp->hm_revision = 0xc0 | (pdev->revision & 0x0f);
  3085	#else
  3086		/* works with this on non-sparc hosts */
  3087		hp->hm_revision = 0x20;
  3088	#endif
  3089	
  3090		/* Now enable the feature flags we can. */
  3091		if (hp->hm_revision == 0x20 || hp->hm_revision == 0x21)
  3092			hp->happy_flags = HFLAG_20_21;
  3093		else if (hp->hm_revision != 0xa0 && hp->hm_revision != 0xc0)
  3094			hp->happy_flags = HFLAG_NOT_A0;
  3095	
  3096		if (qp != NULL)
  3097			hp->happy_flags |= HFLAG_QUATTRO;
  3098	
  3099		/* And of course, indicate this is PCI. */
  3100		hp->happy_flags |= HFLAG_PCI;
  3101	
  3102	#ifdef CONFIG_SPARC
  3103		/* Assume PCI happy meals can handle all burst sizes. */
  3104		hp->happy_bursts = DMA_BURSTBITS;
  3105	#endif
  3106	
  3107		hp->happy_block = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
  3108						     &hp->hblock_dvma, GFP_KERNEL);
  3109		err = -ENODEV;
  3110		if (!hp->happy_block)
  3111			goto err_out_iounmap;
  3112	
  3113		hp->linkcheck = 0;
  3114		hp->timer_state = asleep;
  3115		hp->timer_ticks = 0;
  3116	
  3117		timer_setup(&hp->happy_timer, happy_meal_timer, 0);
  3118	
  3119		hp->irq = pdev->irq;
  3120		hp->dev = dev;
  3121		dev->netdev_ops = &hme_netdev_ops;
  3122		dev->watchdog_timeo = 5*HZ;
  3123		dev->ethtool_ops = &hme_ethtool_ops;
  3124	
  3125		/* Happy Meal can do it all... */
  3126		dev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM;
  3127		dev->features |= dev->hw_features | NETIF_F_RXCSUM;
  3128	
  3129	#if defined(CONFIG_SBUS) && defined(CONFIG_PCI)
  3130		/* Hook up PCI register/descriptor accessors. */
  3131		hp->read_desc32 = pci_hme_read_desc32;
  3132		hp->write_txd = pci_hme_write_txd;
  3133		hp->write_rxd = pci_hme_write_rxd;
  3134		hp->read32 = pci_hme_read32;
  3135		hp->write32 = pci_hme_write32;
  3136	#endif
  3137	
  3138		/* Grrr, Happy Meal comes up by default not advertising
  3139		 * full duplex 100baseT capabilities, fix this.
  3140		 */
  3141		spin_lock_irq(&hp->happy_lock);
  3142		happy_meal_set_initial_advertisement(hp);
  3143		spin_unlock_irq(&hp->happy_lock);
  3144	
  3145		err = register_netdev(hp->dev);
  3146		if (err) {
  3147			printk(KERN_ERR "happymeal(PCI): Cannot register net device, "
  3148			       "aborting.\n");
  3149			goto err_out_iounmap;
  3150		}
  3151	
  3152		pci_set_drvdata(pdev, hp);
  3153	
  3154		if (!qfe_slot) {
  3155			struct pci_dev *qpdev = qp->quattro_dev;
  3156	
  3157			prom_name[0] = 0;
  3158			if (!strncmp(dev->name, "eth", 3)) {
> 3159				int i = simple_strtoul(dev->name + 3, NULL, 10);
  3160				sprintf(prom_name, "-%d", i + 3);
  3161			}
  3162			printk(KERN_INFO "%s%s: Quattro HME (PCI/CheerIO) 10/100baseT Ethernet ", dev->name, prom_name);
  3163			if (qpdev->vendor == PCI_VENDOR_ID_DEC &&
  3164			    qpdev->device == PCI_DEVICE_ID_DEC_21153)
  3165				printk("DEC 21153 PCI Bridge\n");
  3166			else
  3167				printk("unknown bridge %04x.%04x\n",
  3168					qpdev->vendor, qpdev->device);
  3169		}
  3170	
  3171		if (qfe_slot != -1)
  3172			printk(KERN_INFO "%s: Quattro HME slot %d (PCI/CheerIO) 10/100baseT Ethernet ",
  3173			       dev->name, qfe_slot);
  3174		else
  3175			printk(KERN_INFO "%s: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet ",
  3176			       dev->name);
  3177	
  3178		printk("%pM\n", dev->dev_addr);
  3179	
  3180		return 0;
  3181	
  3182	err_out_iounmap:
  3183		iounmap(hp->gregs);
  3184	
  3185	err_out_free_res:
  3186		pci_release_regions(pdev);
  3187	
  3188	err_out_clear_quattro:
  3189		if (qp != NULL)
  3190			qp->happy_meals[qfe_slot] = NULL;
  3191	
  3192		free_netdev(dev);
  3193	
  3194	err_out:
  3195		return err;
  3196	}
  3197	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
