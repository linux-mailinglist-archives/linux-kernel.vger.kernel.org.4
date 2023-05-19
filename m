Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82627096CA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjESLxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjESLxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:53:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F12191
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:53:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f475366522so20015405e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684497211; x=1687089211;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkRlnjVLLrCSiUvXAXLp50ZhpM/wimNPRci9+WoJKwE=;
        b=aVGHyhoTabdge7XwQDeqn47qag3FVMN61T3G7y1hP660HYt+PSnVXmQoOkGWl+jw/q
         oHitRzpNgagC4/3IIT6zI2zx6WIa0GujHjIcqzC8XQHO2XDstJD8lhTfOalbCITujpqQ
         Z0xZrmsj2o5VOLPhR8n0fazu8GJBPC/MBu1wjQjZtkmaAADnE9uAEyD4+ALceaTN9erp
         JrQE9Zlkeza1+8Z9nzmQDU/VBqSSlwiJiqX0wEdAiAcXBuwC5yNBHcCc+GEbZ+CedyJr
         oS78ep/Pv7CYBVcwl8+5lh13xqh75nxbT8aHlyL81/Zd/SLSuPxFkTeERQH2EyurjyPu
         u2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684497211; x=1687089211;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkRlnjVLLrCSiUvXAXLp50ZhpM/wimNPRci9+WoJKwE=;
        b=M6y781B/hV0+EJrnHPrAPxd/3Hq7i06Dwys1V6RB0yUt3BTSXolIqcARqvJ8E5yD2P
         QsUf46X87rdpq44USDykWNRiUrNV20r3lXSoAlcMv2OosuDtEgRgbYELpYlrYrho3WM6
         JYc6uo2Fgkbk+RIRYAI1mhNCfOEzx0XtW+NiGoW3JrvJU/BcgnDW7AXTZ3bOnLwY6c+k
         7OWMHkx70IHXx+Bk926mQ1PPGF1o775Q0r7HjlDHBfMU2gSoimtpGY00q0JM1xw/S/sM
         W0UzDLjbq1KLJBa6h/xBwHOyrbjRtIJC8/kQ1O8ljdhL4O+q+pWRDsKbwln1JSvi2eli
         lcpg==
X-Gm-Message-State: AC+VfDxhpnfcJFpqHexXy9PBnLn43lgnpdycsWLb5qgv+AqaAfXC07ti
        aubHFPqBeAHFq7WPutTWsK96ww==
X-Google-Smtp-Source: ACHHUZ7QNMG+g1oFmony9OdgLN1V4JinX4eEHbXzwc2Tom6y7jcmaiBDHivNGJ4k82wPUwm5+CkH+A==
X-Received: by 2002:a1c:7303:0:b0:3f1:9acf:8682 with SMTP id d3-20020a1c7303000000b003f19acf8682mr1020081wmb.17.1684497210786;
        Fri, 19 May 2023 04:53:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b003f1978bbcd6sm12076793wms.3.2023.05.19.04.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 04:53:28 -0700 (PDT)
Date:   Fri, 19 May 2023 14:53:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Alejandro Lucero <alejandro.lucero-palau@amd.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: drivers/net/ethernet/sfc/ef100_netdev.c:457 ef100_probe_netdev()
 warn: 'net_dev' from alloc_etherdev_mqs() not released on lines: 418.
Message-ID: <bf07d188-a904-4987-816f-3d4f164bf608@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d1bcbc6cd703e64caf8df314e3669b4786e008a
commit: 7e056e2360d9267a20509aa2cdb8905485499e95 sfc: obtain device mac address based on firmware handle for ef100
config: ia64-randconfig-m041-20230514 (https://download.01.org/0day-ci/archive/20230519/202305191859.O6KpRymX-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305191859.O6KpRymX-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/sfc/ef100_netdev.c:457 ef100_probe_netdev() warn: 'net_dev' from alloc_etherdev_mqs() not released on lines: 418.

Old smatch warnings:
drivers/net/ethernet/sfc/ef100_netdev.c:141 ef100_net_open() warn: missing unwind goto?

vim +/net_dev +457 drivers/net/ethernet/sfc/ef100_netdev.c

98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  358  int ef100_probe_netdev(struct efx_probe_data *probe_data)
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  359  {
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  360  	struct efx_nic *efx = &probe_data->efx;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  361  	struct efx_probe_data **probe_ptr;
7e056e2360d926 Alejandro Lucero 2023-02-15  362  	struct ef100_nic_data *nic_data;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  363  	struct net_device *net_dev;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  364  	int rc;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  365  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  366  	if (efx->mcdi->fn_flags &
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  367  			(1 << MC_CMD_DRV_ATTACH_EXT_OUT_FLAG_NO_ACTIVE_PORT)) {
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  368  		pci_info(efx->pci_dev, "No network port on this PCI function");
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  369  		return 0;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  370  	}
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  371  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  372  	/* Allocate and initialise a struct net_device */
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  373  	net_dev = alloc_etherdev_mq(sizeof(probe_data), EFX_MAX_CORE_TX_QUEUES);
                                                                  ^^^^^^^^^^^^^^^^^

98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  374  	if (!net_dev)
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  375  		return -ENOMEM;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  376  	probe_ptr = netdev_priv(net_dev);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  377  	*probe_ptr = probe_data;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  378  	efx->net_dev = net_dev;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  379  	SET_NETDEV_DEV(net_dev, &efx->pci_dev->dev);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  380  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  381  	net_dev->features |= efx->type->offload_features;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  382  	net_dev->hw_features |= efx->type->offload_features;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  383  	net_dev->hw_enc_features |= efx->type->offload_features;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  384  	net_dev->vlan_features |= NETIF_F_HW_CSUM | NETIF_F_SG |
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  385  				  NETIF_F_HIGHDMA | NETIF_F_ALL_TSO;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  386  	netif_set_tso_max_segs(net_dev,
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  387  			       ESE_EF100_DP_GZ_TSO_MAX_HDR_NUM_SEGS_DEFAULT);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  388  	efx->mdio.dev = net_dev;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  389  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  390  	rc = efx_ef100_init_datapath_caps(efx);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  391  	if (rc < 0)
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  392  		goto fail;

These goto fail paths will call efx_probe_devlink_unlock() when we have
not yet taken the lock.  This is a canonical bug for one err label style
error handling code.  I always try to discourage this style of error
handling.

https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  393  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  394  	rc = ef100_phy_probe(efx);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  395  	if (rc)
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  396  		goto fail;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  397  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  398  	rc = efx_init_channels(efx);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  399  	if (rc)
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  400  		goto fail;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  401  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  402  	down_write(&efx->filter_sem);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  403  	rc = ef100_filter_table_probe(efx);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  404  	up_write(&efx->filter_sem);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  405  	if (rc)
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  406  		goto fail;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  407  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  408  	netdev_rss_key_fill(efx->rss_context.rx_hash_key,
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  409  			    sizeof(efx->rss_context.rx_hash_key));
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  410  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  411  	/* Don't fail init if RSS setup doesn't work. */
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  412  	efx_mcdi_push_default_indir_table(efx, efx->n_rx_channels);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  413  
7e056e2360d926 Alejandro Lucero 2023-02-15  414  	nic_data = efx->nic_data;
7e056e2360d926 Alejandro Lucero 2023-02-15  415  	rc = ef100_get_mac_address(efx, net_dev->perm_addr, CLIENT_HANDLE_SELF,
7e056e2360d926 Alejandro Lucero 2023-02-15  416  				   efx->type->is_vf);
7e056e2360d926 Alejandro Lucero 2023-02-15  417  	if (rc)
7e056e2360d926 Alejandro Lucero 2023-02-15  418  		return rc;

Yep.  We need to do some clean up before returning.

7e056e2360d926 Alejandro Lucero 2023-02-15  419  	/* Assign MAC address */
7e056e2360d926 Alejandro Lucero 2023-02-15  420  	eth_hw_addr_set(net_dev, net_dev->perm_addr);
7e056e2360d926 Alejandro Lucero 2023-02-15  421  	ether_addr_copy(nic_data->port_id, net_dev->perm_addr);
7e056e2360d926 Alejandro Lucero 2023-02-15  422  
fa34a5140a8e8f Alejandro Lucero 2023-02-15  423  	/* devlink creation, registration and lock */
fa34a5140a8e8f Alejandro Lucero 2023-02-15  424  	rc = efx_probe_devlink_and_lock(efx);
fa34a5140a8e8f Alejandro Lucero 2023-02-15  425  	if (rc)
fa34a5140a8e8f Alejandro Lucero 2023-02-15  426  		pci_info(efx->pci_dev, "devlink registration failed");
fa34a5140a8e8f Alejandro Lucero 2023-02-15  427  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  428  	rc = ef100_register_netdev(efx);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  429  	if (rc)
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  430  		goto fail;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  431  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  432  	if (!efx->type->is_vf) {
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  433  		rc = ef100_probe_netdev_pf(efx);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  434  		if (rc)
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  435  			goto fail;
25414b2a64ae7e Alejandro Lucero 2023-02-15  436  #ifdef CONFIG_SFC_SRIOV
25414b2a64ae7e Alejandro Lucero 2023-02-15  437  		ef100_pf_set_devlink_port(efx);
25414b2a64ae7e Alejandro Lucero 2023-02-15  438  #endif
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  439  	}
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  440  
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  441  	efx->netdev_notifier.notifier_call = ef100_netdev_event;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  442  	rc = register_netdevice_notifier(&efx->netdev_notifier);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  443  	if (rc) {
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  444  		netif_err(efx, probe, efx->net_dev,
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  445  			  "Failed to register netdevice notifier, rc=%d\n", rc);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  446  		goto fail;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  447  	}
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  448  
25414b2a64ae7e Alejandro Lucero 2023-02-15  449  	efx_probe_devlink_unlock(efx);
25414b2a64ae7e Alejandro Lucero 2023-02-15  450  	return rc;
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28  451  fail:
25414b2a64ae7e Alejandro Lucero 2023-02-15  452  #ifdef CONFIG_SFC_SRIOV
25414b2a64ae7e Alejandro Lucero 2023-02-15  453  	/* remove devlink port if does exist */
25414b2a64ae7e Alejandro Lucero 2023-02-15  454  	ef100_pf_unset_devlink_port(efx);
25414b2a64ae7e Alejandro Lucero 2023-02-15  455  #endif
fa34a5140a8e8f Alejandro Lucero 2023-02-15  456  	efx_probe_devlink_unlock(efx);
98ff4c7c8ac7f5 Jonathan Cooper  2022-06-28 @457  	return rc;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

