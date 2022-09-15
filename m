Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C55B5BA30A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 01:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIOXMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 19:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIOXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 19:11:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4EE3AE74
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663283517; x=1694819517;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XrRnG0hfQp/qwhGT2IWiMN2DiU49o3jLqAwbAJrFDhM=;
  b=F4b1IJoRcjLcW0vQacDtYE+/2Cc5zg7C900Ws0oGAd5UTK3sbs791pIe
   /MT7BtLX0NN+rjxKS5QV9vl7auS0c2EFfdf6pcGbOvQPfBixNCG81T2KU
   DJs7gKFahtOTRgxEMgTG8+qHw1GkDT7ctW3Fp9aY7w58FtZfdDOVFIo5o
   WPagZCcZy1U8NR+AEJlT8iPDBPAZV22vsLWKlC5ehS5C8jyt9slN+yaEA
   u+PylN2DRL9aBC5Q5bkleCH0btjquEbmUaDtGq5Wfa5GbCc7KvJWe894S
   E3+mkbVJhTmxSHJAhr360qzCJzWLpKQBQXYSqqygoPn4k49lGx4Y7NEpw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="362827681"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="362827681"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 16:11:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="595025627"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2022 16:11:53 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYy1R-00019S-0M;
        Thu, 15 Sep 2022 23:11:53 +0000
Date:   Fri, 16 Sep 2022 07:11:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 6415/9999]
 drivers/media/usb/pulse8-cec/pulse8-cec.c:569:17: warning: 'strncpy' output
 may be truncated copying 13 bytes from a string of length 14
Message-ID: <202209160742.fJ525xdG-lkp@intel.com>
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

Hi Miguel,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 872c91b9b3e71479285202070e518727735257e8 [6415/9999] UPSTREAM: Compiler Attributes: enable -Wstringop-truncation on W=1 (gcc >= 8)
config: s390-randconfig-r044-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160742.fJ525xdG-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/872c91b9b3e71479285202070e518727735257e8
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 872c91b9b3e71479285202070e518727735257e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/usb/pulse8-cec/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/media/usb/pulse8-cec/pulse8-cec.c: In function 'pulse8_cec_adap_log_addr':
>> drivers/media/usb/pulse8-cec/pulse8-cec.c:569:17: warning: 'strncpy' output may be truncated copying 13 bytes from a string of length 14 [-Wstringop-truncation]
     569 |                 strncpy(cmd + 1, adap->log_addrs.osd_name, 13);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +569 drivers/media/usb/pulse8-cec/pulse8-cec.c

3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  471  
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  472  static int pulse8_cec_adap_log_addr(struct cec_adapter *adap, u8 log_addr)
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  473  {
bb25db504771d3 drivers/media/usb/pulse8-cec/pulse8-cec.c     Jose Abreu            2017-03-24  474  	struct pulse8 *pulse8 = cec_get_drvdata(adap);
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  475  	u16 mask = 0;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  476  	u16 pa = adap->phys_addr;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  477  	u8 cmd[16];
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  478  	int err = 0;
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  479  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  480  	mutex_lock(&pulse8->config_lock);
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  481  	if (log_addr != CEC_LOG_ADDR_INVALID)
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  482  		mask = 1 << log_addr;
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  483  	cmd[0] = MSGCODE_SET_ACK_MASK;
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  484  	cmd[1] = mask >> 8;
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  485  	cmd[2] = mask & 0xff;
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  486  	err = pulse8_send_and_wait(pulse8, cmd, 3,
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  487  				   MSGCODE_COMMAND_ACCEPTED, 0);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  488  	if ((err && mask != 0) || pulse8->restoring_config)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  489  		goto unlock;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  490  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  491  	cmd[0] = MSGCODE_SET_AUTO_ENABLED;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  492  	cmd[1] = log_addr == CEC_LOG_ADDR_INVALID ? 0 : 1;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  493  	err = pulse8_send_and_wait(pulse8, cmd, 2,
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  494  				   MSGCODE_COMMAND_ACCEPTED, 0);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  495  	if (err)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  496  		goto unlock;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  497  	pulse8->autonomous = cmd[1];
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  498  	if (log_addr == CEC_LOG_ADDR_INVALID)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  499  		goto unlock;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  500  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  501  	cmd[0] = MSGCODE_SET_DEVICE_TYPE;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  502  	cmd[1] = adap->log_addrs.primary_device_type[0];
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  503  	err = pulse8_send_and_wait(pulse8, cmd, 2,
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  504  				   MSGCODE_COMMAND_ACCEPTED, 0);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  505  	if (err)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  506  		goto unlock;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  507  
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  508  	switch (adap->log_addrs.primary_device_type[0]) {
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  509  	case CEC_OP_PRIM_DEVTYPE_TV:
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  510  		mask = CEC_LOG_ADDR_MASK_TV;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  511  		break;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  512  	case CEC_OP_PRIM_DEVTYPE_RECORD:
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  513  		mask = CEC_LOG_ADDR_MASK_RECORD;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  514  		break;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  515  	case CEC_OP_PRIM_DEVTYPE_TUNER:
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  516  		mask = CEC_LOG_ADDR_MASK_TUNER;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  517  		break;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  518  	case CEC_OP_PRIM_DEVTYPE_PLAYBACK:
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  519  		mask = CEC_LOG_ADDR_MASK_PLAYBACK;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  520  		break;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  521  	case CEC_OP_PRIM_DEVTYPE_AUDIOSYSTEM:
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  522  		mask = CEC_LOG_ADDR_MASK_AUDIOSYSTEM;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  523  		break;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  524  	case CEC_OP_PRIM_DEVTYPE_SWITCH:
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  525  		mask = CEC_LOG_ADDR_MASK_UNREGISTERED;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  526  		break;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  527  	case CEC_OP_PRIM_DEVTYPE_PROCESSOR:
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  528  		mask = CEC_LOG_ADDR_MASK_SPECIFIC;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  529  		break;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  530  	default:
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  531  		mask = 0;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  532  		break;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  533  	}
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  534  	cmd[0] = MSGCODE_SET_LOGICAL_ADDRESS_MASK;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  535  	cmd[1] = mask >> 8;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  536  	cmd[2] = mask & 0xff;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  537  	err = pulse8_send_and_wait(pulse8, cmd, 3,
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  538  				   MSGCODE_COMMAND_ACCEPTED, 0);
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  539  	if (err)
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  540  		goto unlock;
58584b28a8e57f drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-09-07  541  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  542  	cmd[0] = MSGCODE_SET_DEFAULT_LOGICAL_ADDRESS;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  543  	cmd[1] = log_addr;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  544  	err = pulse8_send_and_wait(pulse8, cmd, 2,
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  545  				   MSGCODE_COMMAND_ACCEPTED, 0);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  546  	if (err)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  547  		goto unlock;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  548  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  549  	cmd[0] = MSGCODE_SET_PHYSICAL_ADDRESS;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  550  	cmd[1] = pa >> 8;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  551  	cmd[2] = pa & 0xff;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  552  	err = pulse8_send_and_wait(pulse8, cmd, 3,
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  553  				   MSGCODE_COMMAND_ACCEPTED, 0);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  554  	if (err)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  555  		goto unlock;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  556  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  557  	cmd[0] = MSGCODE_SET_HDMI_VERSION;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  558  	cmd[1] = adap->log_addrs.cec_version;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  559  	err = pulse8_send_and_wait(pulse8, cmd, 2,
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  560  				   MSGCODE_COMMAND_ACCEPTED, 0);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  561  	if (err)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  562  		goto unlock;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  563  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  564  	if (adap->log_addrs.osd_name[0]) {
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  565  		size_t osd_len = strlen(adap->log_addrs.osd_name);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  566  		char *osd_str = cmd + 1;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  567  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  568  		cmd[0] = MSGCODE_SET_OSD_NAME;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22 @569  		strncpy(cmd + 1, adap->log_addrs.osd_name, 13);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  570  		if (osd_len < 4) {
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  571  			memset(osd_str + osd_len, ' ', 4 - osd_len);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  572  			osd_len = 4;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  573  			osd_str[osd_len] = '\0';
3fd8dc1d0faf3a drivers/media/usb/pulse8-cec/pulse8-cec.c     Mauro Carvalho Chehab 2018-09-10  574  			strscpy(adap->log_addrs.osd_name, osd_str,
3fd8dc1d0faf3a drivers/media/usb/pulse8-cec/pulse8-cec.c     Mauro Carvalho Chehab 2018-09-10  575  				sizeof(adap->log_addrs.osd_name));
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  576  		}
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  577  		err = pulse8_send_and_wait(pulse8, cmd, 1 + osd_len,
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  578  					   MSGCODE_COMMAND_ACCEPTED, 0);
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  579  		if (err)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  580  			goto unlock;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  581  	}
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  582  
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  583  unlock:
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  584  	if (pulse8->restoring_config)
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  585  		pulse8->restoring_config = false;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  586  	else
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  587  		pulse8->config_pending = true;
e28a6c8b3fcc16 drivers/staging/media/pulse8-cec/pulse8-cec.c Johan Fjeldtvedt      2016-08-22  588  	mutex_unlock(&pulse8->config_lock);
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  589  	return err;
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  590  }
3dff3106fd7992 drivers/staging/media/pulse8-cec/pulse8-cec.c Hans Verkuil          2016-07-10  591  

:::::: The code at line 569 was first introduced by commit
:::::: e28a6c8b3fcc166254596bbbf9ebe45facfa48eb [media] pulse8-cec: sync configuration with adapter

:::::: TO: Johan Fjeldtvedt <jaffe1@gmail.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
