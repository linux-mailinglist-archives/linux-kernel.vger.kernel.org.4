Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868C55BBFFE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIRVQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIRVQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:16:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCE0120A6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663535809; x=1695071809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uj2kAVNZJs1aOPBqGd/YZsPq7gfkXgGJNJpctQHHwwg=;
  b=NXB+OiE2IkFKZ4Puq6+8ShLkLLInm5ss7hcsL8Md+bBEeUCeCus9u6F5
   rHxSmAk77ce5pfULP0p6dwlojsY9eigLDmaC1CeZWfAI0i11HBCygh+g3
   s54xEz7Mu6NeECr7Zi/C9wvedKxH2E/FLP+tm3lsAIQT21PyRFTwn9LRZ
   baxVFx/jLmaQ/MI1hEKbRrCzjF1KiuVJqJ3IbUaGOYQbiU5iiw2My5zWF
   r1UX9e+XY0UkvT+s6cAmfD+T0JLdxIFhGjybzp1CccnF/jtntk0RlD8+d
   QFnxbwybWtRfk3Xy+4s8phOvZceq67eTkPfsbeKEE80+XA+NZo10KaqAk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="286310145"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="286310145"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 14:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="651456728"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Sep 2022 14:16:47 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa1eg-0001Tl-22;
        Sun, 18 Sep 2022 21:16:46 +0000
Date:   Mon, 19 Sep 2022 05:16:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 17/22]
 drivers/hid/dockchannel-hid/dockchannel-hid.c:260:22: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202209190557.SAvGwkSQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   ecf1fb81499a2f1724cb90497ca3c1cec831c9b6
commit: 1ec80017a2d32191bbd419e7ee568127b4239c66 [17/22] hid: Add Apple DockChannel HID transport driver
config: arm64-randconfig-s052-20220918 (https://download.01.org/0day-ci/archive/20220919/202209190557.SAvGwkSQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/AsahiLinux/linux/commit/1ec80017a2d32191bbd419e7ee568127b4239c66
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout 1ec80017a2d32191bbd419e7ee568127b4239c66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hid/dockchannel-hid/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:260:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] length @@     got unsigned long @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:260:22: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:260:22: sparse:     got unsigned long
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:264:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] length @@     got unsigned long [usertype] size @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:264:22: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:264:22: sparse:     got unsigned long [usertype] size
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:407:16: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:407:42: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:408:20: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:408:54: sparse: sparse: restricted __le32 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:409:37: sparse: sparse: cast from restricted __le32
   drivers/hid/dockchannel-hid/dockchannel-hid.c:409:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:410:20: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:410:41: sparse: sparse: restricted __le32 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:417:65: sparse: sparse: restricted __le32 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:418:35: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le32 [usertype] data_length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:418:35: sparse:     expected unsigned long [usertype] len
   drivers/hid/dockchannel-hid/dockchannel-hid.c:418:35: sparse:     got restricted __le32 [usertype] data_length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:425:28: sparse: sparse: restricted __le32 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:428:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long [usertype] @@     got restricted __le32 [usertype] data_length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:428:15: sparse:     expected unsigned long [usertype]
   drivers/hid/dockchannel-hid/dockchannel-hid.c:428:15: sparse:     got restricted __le32 [usertype] data_length
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:600:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] vendor_id @@     got int @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:600:52: sparse:     expected restricted __le16 [usertype] vendor_id
   drivers/hid/dockchannel-hid/dockchannel-hid.c:600:52: sparse:     got int
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:627:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] vendor @@     got restricted __le16 [usertype] vendor_id @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:627:21: sparse:     expected unsigned int [usertype] vendor
   drivers/hid/dockchannel-hid/dockchannel-hid.c:627:21: sparse:     got restricted __le16 [usertype] vendor_id
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:628:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] product @@     got restricted __le16 [usertype] product_id @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:628:22: sparse:     expected unsigned int [usertype] product
   drivers/hid/dockchannel-hid/dockchannel-hid.c:628:22: sparse:     got restricted __le16 [usertype] product_id
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:629:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] version @@     got restricted __le16 [usertype] version_number @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:629:22: sparse:     expected unsigned int [usertype] version
   drivers/hid/dockchannel-hid/dockchannel-hid.c:629:22: sparse:     got restricted __le16 [usertype] version_number
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:712:24: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:716:65: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] desc_len @@     got restricted __le16 [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:716:65: sparse:     expected unsigned long [usertype] desc_len
   drivers/hid/dockchannel-hid/dockchannel-hid.c:716:65: sparse:     got restricted __le16 [usertype] length
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:724:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int id @@     got restricted __le16 [usertype] id @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:724:54: sparse:     expected int id
   drivers/hid/dockchannel-hid/dockchannel-hid.c:724:54: sparse:     got restricted __le16 [usertype] id
   drivers/hid/dockchannel-hid/dockchannel-hid.c:714:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:714:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:732:28: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:733:30: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:780:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] retcode @@     got unsigned int [assigned] [usertype] retcode @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:780:22: sparse:     expected restricted __le32 [usertype] retcode
   drivers/hid/dockchannel-hid/dockchannel-hid.c:780:22: sparse:     got unsigned int [assigned] [usertype] retcode
   drivers/hid/dockchannel-hid/dockchannel-hid.c:828:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:828:53: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:829:17: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:837:64: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] length @@     got restricted __le16 [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:837:64: sparse:     expected unsigned long [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:837:64: sparse:     got restricted __le16 [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:839:71: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] length @@     got restricted __le16 [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:839:71: sparse:     expected unsigned long [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:839:71: sparse:     got restricted __le16 [usertype] length
   drivers/hid/dockchannel-hid/dockchannel-hid.c:854:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:854:47: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:855:17: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:866:17: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:882:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:882:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:882:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:882:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:882:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:882:17: sparse: sparse: cast from restricted __le16
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:884:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long [usertype] resp_size @@     got restricted __le16 [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:884:26: sparse:     expected unsigned long [usertype] resp_size
   drivers/hid/dockchannel-hid/dockchannel-hid.c:884:26: sparse:     got restricted __le16 [usertype] length
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:886:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] retcode @@     got restricted __le32 [usertype] retcode @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:886:24: sparse:     expected unsigned int [usertype] retcode
   drivers/hid/dockchannel-hid/dockchannel-hid.c:886:24: sparse:     got restricted __le32 [usertype] retcode
   drivers/hid/dockchannel-hid/dockchannel-hid.c:908:60: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:908:80: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:914:55: sparse: sparse: restricted __le16 degrades to integer
   drivers/hid/dockchannel-hid/dockchannel-hid.c:954:43: sparse: sparse: restricted __le16 degrades to integer
>> drivers/hid/dockchannel-hid/dockchannel-hid.c:960:9: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] @@     got restricted __le16 [addressable] [usertype] length @@
   drivers/hid/dockchannel-hid/dockchannel-hid.c:960:9: sparse:     expected unsigned long [usertype]
   drivers/hid/dockchannel-hid/dockchannel-hid.c:960:9: sparse:     got restricted __le16 [addressable] [usertype] length

vim +260 drivers/hid/dockchannel-hid/dockchannel-hid.c

   245	
   246	static int dchid_send(struct dchid_iface *iface, u32 flags, void *msg, size_t size)
   247	{
   248		u32 checksum = 0xffffffff;
   249		size_t wsize = round_down(size, 4);
   250		size_t tsize = size - wsize;
   251		int ret;
   252		struct {
   253			struct dchid_hdr hdr;
   254			struct dchid_subhdr sub;
   255		} __packed h;
   256	
   257		memset(&h, 0, sizeof(h));
   258		h.hdr.hdr_len = sizeof(h.hdr);
   259		h.hdr.channel = DCHID_CHANNEL_CMD;
 > 260		h.hdr.length = round_up(size, 4) + sizeof(h.sub);
   261		h.hdr.seq = iface->tx_seq;
   262		h.hdr.iface = iface->index;
   263		h.sub.flags = flags;
 > 264		h.sub.length = size;
   265	
   266		ret = dockchannel_send(iface->dchid->dc, &h, sizeof(h));
   267		if (ret < 0)
   268			return ret;
   269		checksum -= dchid_checksum(&h, sizeof(h));
   270	
   271		ret = dockchannel_send(iface->dchid->dc, msg, wsize);
   272		if (ret < 0)
   273			return ret;
   274		checksum -= dchid_checksum(msg, wsize);
   275	
   276		if (tsize) {
   277			u8 tail[4] = {0, 0, 0, 0};
   278	
   279			memcpy(tail, msg + wsize, tsize);
   280			ret = dockchannel_send(iface->dchid->dc, tail, sizeof(tail));
   281			if (ret < 0)
   282				return ret;
   283			checksum -= dchid_checksum(tail, sizeof(tail));
   284		}
   285	
   286		ret = dockchannel_send(iface->dchid->dc, &checksum, sizeof(checksum));
   287		if (ret < 0)
   288			return ret;
   289	
   290		return 0;
   291	}
   292	
   293	static int dchid_cmd(struct dchid_iface *iface, u32 type, u32 req,
   294			     void *data, size_t size, void *resp_buf, size_t resp_size)
   295	{
   296		int ret;
   297		int report_id = *(u8*)data;
   298	
   299		mutex_lock(&iface->out_mutex);
   300	
   301		WARN_ON(iface->out_report != -1);
   302		iface->out_report = report_id;
   303		iface->out_flags = FIELD_PREP(FLAGS_GROUP, type) | FIELD_PREP(FLAGS_REQ, req);
   304		iface->resp_buf = resp_buf;
   305		iface->resp_size = resp_size;
   306		reinit_completion(&iface->out_complete);
   307	
   308		ret = dchid_send(iface, iface->out_flags, data, size);
   309		if (ret < 0)
   310			goto done;
   311	
   312		if (!wait_for_completion_timeout(&iface->out_complete, msecs_to_jiffies(1000))) {
   313			dev_err(iface->dchid->dev, "output report 0x%x to iface  %d (%s) timed out\n",
   314				report_id, iface->index, iface->name);
   315			ret = -ETIMEDOUT;
   316			goto done;
   317		}
   318	
   319		ret = iface->resp_size;
   320		if (iface->retcode) {
   321			dev_err(iface->dchid->dev,
   322				"output report 0x%x to iface %d (%s) failed with err 0x%x\n",
   323				report_id, iface->index, iface->name, iface->retcode);
   324			ret = -EIO;
   325		}
   326	
   327	done:
   328		iface->tx_seq++;
   329		iface->out_report = -1;
   330		iface->out_flags = 0;
   331		iface->resp_buf = NULL;
   332		iface->resp_size = 0;
   333		mutex_unlock(&iface->out_mutex);
   334		return ret;
   335	}
   336	
   337	static int dchid_comm_cmd(struct dockchannel_hid *dchid, void *cmd, size_t size)
   338	{
   339		return dchid_cmd(dchid->comm, GROUP_CMD, REQ_SET_REPORT, cmd, size, NULL, 0);
   340	}
   341	
   342	static int dchid_enable_interface(struct dchid_iface *iface)
   343	{
   344		u8 msg[] = { CMD_ENABLE_INTERFACE, iface->index };
   345	
   346		return dchid_comm_cmd(iface->dchid, msg, sizeof(msg));
   347	}
   348	
   349	static int dchid_reset_interface(struct dchid_iface *iface, int state)
   350	{
   351		u8 msg[] = { CMD_RESET_INTERFACE, 1, iface->index, state };
   352	
   353		return dchid_comm_cmd(iface->dchid, msg, sizeof(msg));
   354	}
   355	
   356	static int dchid_send_firmware(struct dchid_iface *iface, void *firmware, size_t size)
   357	{
   358		struct {
   359			u8 cmd;
   360			u8 unk1;
   361			u8 unk2;
   362			u8 iface;
   363			u64 addr;
   364			u32 size;
   365		} __packed msg = {
   366			.cmd = CMD_SEND_FIRMWARE,
   367			.unk1 = 2,
   368			.unk2 = 0,
   369			.iface = iface->index,
   370			.size = size,
   371		};
   372		dma_addr_t addr;
   373		void *buf = dmam_alloc_coherent(iface->dchid->dev, size, &addr, GFP_KERNEL);
   374	
   375		if (IS_ERR_OR_NULL(buf))
   376			return buf ? PTR_ERR(buf) : -ENOMEM;
   377	
   378		msg.addr = addr;
   379		memcpy(buf, firmware, size);
   380		wmb();
   381	
   382		return dchid_comm_cmd(iface->dchid, &msg, sizeof(msg));
   383	}
   384	
   385	static int dchid_get_firmware(struct dchid_iface *iface, void **firmware, size_t *size)
   386	{
   387		int ret;
   388		const char *fw_name;
   389		const struct firmware *fw;
   390		struct fw_header *hdr;
   391		u8 *fw_data;
   392	
   393		ret = of_property_read_string(iface->of_node, "firmware-name", &fw_name);
   394		if (ret) {
   395			/* Firmware is only for some devices */
   396			*firmware = NULL;
   397			*size = 0;
   398			return 0;
   399		}
   400	
   401		ret = request_firmware(&fw, fw_name, iface->dchid->dev);
   402		if (ret)
   403			return ret;
   404	
   405		hdr = (struct fw_header *)fw->data;
   406	
 > 407		if (hdr->magic != FW_MAGIC || hdr->version != FW_VER ||
   408			hdr->hdr_length < sizeof(*hdr) || hdr->hdr_length > fw->size ||
 > 409			(hdr->hdr_length + (size_t)hdr->data_length) > fw->size ||
   410			hdr->iface_offset >= hdr->data_length) {
   411			dev_warn(iface->dchid->dev, "%s: invalid firmware header\n",
   412				 fw_name);
   413			ret = -EINVAL;
   414			goto done;
   415		}
   416	
   417		fw_data = devm_kmemdup(iface->dchid->dev, fw->data + hdr->hdr_length,
 > 418				       hdr->data_length, GFP_KERNEL);
   419		if (!fw_data) {
   420			ret = -ENOMEM;
   421			goto done;
   422		}
   423	
   424		if (hdr->iface_offset)
   425			fw_data[hdr->iface_offset] = iface->index;
   426	
   427		*firmware = fw_data;
 > 428		*size = hdr->data_length;
   429	
   430	done:
   431		release_firmware(fw);
   432		return ret;
   433	}
   434	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
