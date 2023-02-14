Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F308B695CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBNI12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBNI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:27:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42D52724
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:27:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so10904654wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3SNzD1D/+G7EoWbroYbrElrYQ8bt6MSn6iygZYJlsA=;
        b=iaLkJwRNrJ7fg1h6X9TBxfMRyjoxwBSFuUWtN8RynawGcpGtOZpVZ9jgk0YaD2tvL4
         yBCWhoXbvYoj95luW8olOSFw2WNPXFTX7L3KbrVlaBGYslSUXl0C7uufc4e6Xstf5TVk
         v89l57dWaRaGbFshFENq7IQa8IFASuM5c96hEJnU/V+cBaNCEfdoWlymxE9L9yk5ZfuW
         V88aG2NZ1UhDyElTiSDNY+bi2lMxOWmx7JIryFjB12cT1e0Rz8aVCjfpaalwa8xw0Sim
         FXh2NdHlaUHjJ2IQ+8YfHeUhSi6P52V+4UkRutpYOQ70daEX/d9vTzrhRIhv1TYCZRQy
         IY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3SNzD1D/+G7EoWbroYbrElrYQ8bt6MSn6iygZYJlsA=;
        b=25fUv0WHo0KCChBkWetMrNQEofyldI7buITVkBkKc3hDEUY8Ovo8V9nv/67euUtcBI
         ba6AQ2NYEkXed5SOo+RrYJgcWXiOKJ/FZIDdCL621raGCK2sqqqCDWA1rza8eIxS7v+5
         bNoz00m/9iDlbn4RRywI2cpiJfqjN3BqzJKZtOy9uxhsDW9TvZA9zfSoYdmaGDxARIp6
         lgW7+r7MuCxXB8gLVwD9mv5V7QOtDa0987pFHZMs9UE/CrFiD5dL067OKPq0gtbk1ZPA
         Esn0b3lRO3JCN0bB11nZVxixyiiP6jSKT+TBHTMfAlflXLTHS/S96IdJkjbnEeMi8quu
         Fe0w==
X-Gm-Message-State: AO0yUKVNNG1cIdg50J84TBz+3Gt7AFZFeSN8qcDwD3owW57G7x0Etcvi
        8pkeXZWdEj4ZO6sCIT+2llg=
X-Google-Smtp-Source: AK7set/PQGgEB4IJvIh0aW4sBsNUXDmoFU8fm/dDk4eB8lGJl3JfOc/5hiQKbUbK+BcjxlX/8ShgYA==
X-Received: by 2002:a05:600c:a39e:b0:3dc:4c4f:6dc5 with SMTP id hn30-20020a05600ca39e00b003dc4c4f6dc5mr1302498wmb.9.1676363242267;
        Tue, 14 Feb 2023 00:27:22 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b003dcc82ce53fsm18110172wmq.38.2023.02.14.00.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:27:21 -0800 (PST)
Date:   Tue, 14 Feb 2023 11:27:18 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        "Haim, Dreyfuss" <haim.dreyfuss@intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2789
 iwl_mvm_resume_firmware() error: uninitialized symbol 'd3_status'.
Message-ID: <202302140947.nQROevUz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f6feea56f66d34259c4222fa02e8171c4f2673d1
commit: b75dac847c9453d017d463a97e253416abf93d36 wifi: iwlwifi: mvm: trigger resume flow before wait for notifications
config: x86_64-randconfig-m001-20230213 (https://download.01.org/0day-ci/archive/20230214/202302140947.nQROevUz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302140947.nQROevUz-lkp@intel.com/

smatch warnings:
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2789 iwl_mvm_resume_firmware() error: uninitialized symbol 'd3_status'.

vim +/d3_status +2789 drivers/net/wireless/intel/iwlwifi/mvm/d3.c

4da46a06d4430a Haim Dreyfuss  2022-09-06  2773  
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2774  static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm, bool test)
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2775  {
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2776  	int ret;
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2777  	enum iwl_d3_status d3_status;
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2778  	struct iwl_host_cmd cmd = {
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2779  			.id = D0I3_END_CMD,
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2780  			.flags = CMD_WANT_SKB | CMD_SEND_IN_D3,
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2781  		};
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2782  	bool reset = fw_has_capa(&mvm->fw->ucode_capa,
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2783  				 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2784  
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2785  	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test, !reset);
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2786  	if (ret)
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2787  		return ret;
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2788  
b75dac847c9453 Haim, Dreyfuss 2022-09-06 @2789  	if (d3_status != IWL_D3_STATUS_ALIVE) {

The iwl_trans_d3_resume() function does not initialize d3_status if
trans->ops->d3_resume is NULL.

b75dac847c9453 Haim, Dreyfuss 2022-09-06  2790  		IWL_INFO(mvm, "Device was reset during suspend\n");
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2791  		return -ENOENT;
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2792  	}
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2793  
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2794  	/*
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2795  	 * We should trigger resume flow using command only for 22000 family
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2796  	 * AX210 and above don't need the command since they have
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2797  	 * the doorbell interrupt.
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2798  	 */
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2799  	if (mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_22000 &&
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2800  	    fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_D0I3_END_FIRST)) {
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2801  		ret = iwl_mvm_send_cmd(mvm, &cmd);
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2802  		if (ret < 0)
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2803  			IWL_ERR(mvm, "Failed to send D0I3_END_CMD first (%d)\n",
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2804  				ret);
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2805  	}
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2806  
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2807  	return ret;
b75dac847c9453 Haim, Dreyfuss 2022-09-06  2808  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

