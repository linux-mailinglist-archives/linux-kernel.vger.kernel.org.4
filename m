Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8A8674B60
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjATEx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjATExG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:53:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B561AE;
        Thu, 19 Jan 2023 20:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189897; x=1705725897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S201eruROP7eKPTKXbHcEhpKDU2DfgLuA341gnj3670=;
  b=Phc0v43dzjW5f/Ry4Y1bJ5baa4MyxOULvrWbWWZaDdHRlIHTRu+vePlQ
   7+3HJLLNxsXV0okeYtmtu/pxmgl7ZxFw6gW2LfZyyM5dNxAgR8Cl9V/Nj
   Oj59uOXKpB5GE9vcCxi8AtthSkHycsVAsERwHCLE5WzDiiJ2JZxr76uhr
   apZT/Sll8+zYG1AeTWVrrC4xPQSUDDE9xD4ofQuAuHMs/vy+H8VaUjieK
   7s1IpriIWgKy0od7i73DGnBISMxsBy5FpVGOpkUbermomvofTI/Wn3ouh
   YW35+a9DFuVme9SiUtVWno9XZzsH+GOI8Ev4wji92Nw6AvlxeU8AOijpB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387700170"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="387700170"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="690677479"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="690677479"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2023 08:21:59 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIXfr-0001cm-09;
        Thu, 19 Jan 2023 16:21:59 +0000
Date:   Fri, 20 Jan 2023 00:21:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     max.chou@realtek.com, marcel@holtmann.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, max.chou@realtek.com,
        allen_chen@realsil.com.cn
Subject: Re: [PATCH 1/1] Bluetooth: btrtl: Firmware format v2 support
Message-ID: <202301200026.jbRDhsXX-lkp@intel.com>
References: <20230119074714.156283-1-max.chou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119074714.156283-1-max.chou@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v6.2-rc4 next-20230119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/max-chou-realtek-com/Bluetooth-btrtl-Firmware-format-v2-support/20230119-155205
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20230119074714.156283-1-max.chou%40realtek.com
patch subject: [PATCH 1/1] Bluetooth: btrtl: Firmware format v2 support
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20230120/202301200026.jbRDhsXX-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ffdaef9bef66fbba642b544b0a1f35217dc17d6a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review max-chou-realtek-com/Bluetooth-btrtl-Firmware-format-v2-support/20230119-155205
        git checkout ffdaef9bef66fbba642b544b0a1f35217dc17d6a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btrtl.c:430:6: warning: variable 'dummy' set but not used [-Wunused-but-set-variable]
           int dummy = 0;
               ^
>> drivers/bluetooth/btrtl.c:429:6: warning: variable 'secure' set but not used [-Wunused-but-set-variable]
           int secure = 0;
               ^
   2 warnings generated.


vim +/dummy +430 drivers/bluetooth/btrtl.c

   413	
   414	static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
   415					   struct btrtl_device_info *btrtl_dev,
   416					   unsigned char **_buf)
   417	{
   418		struct rtl_epatch_header_v2 *hdr;
   419		int rc;
   420		u8 reg_val[2];
   421		u8 key_id;
   422		u32 num_sections;
   423		struct rtl_section *section;
   424		struct rtl_subsection *entry, *tmp;
   425		u32 section_len;
   426		u32 opcode;
   427		int len = 0;
   428		int i;
 > 429		int secure = 0;
 > 430		int dummy = 0;
   431		u8 *ptr;
   432		/* Cut the tail of the firmware. */
   433		u8 *end = btrtl_dev->fw_data + btrtl_dev->fw_len - 7;
   434	
   435		rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
   436		if (rc < 0)
   437			return -EIO;
   438	
   439		key_id = reg_val[0];
   440		rtl_dev_dbg(hdev, "%s: key id %u", __func__, key_id);
   441		btrtl_dev->key_id = key_id;
   442	
   443		hdr = (struct rtl_epatch_header_v2 *)btrtl_dev->fw_data;
   444		num_sections = le32_to_cpu(hdr->num_sections);
   445	
   446		rtl_dev_dbg(hdev, "FW version %08x-%08x", *((u32 *)hdr->fw_version),
   447			    *((u32 *)(hdr->fw_version + 4)));
   448	
   449		ptr = btrtl_dev->fw_data + sizeof(*hdr);
   450		for (i = 0; i < num_sections; i++) {
   451			section = (void *)ptr;
   452			if (ptr + sizeof(*section) > end)
   453				break;
   454			ptr += sizeof(*section);
   455	
   456			section_len = le32_to_cpu(section->len);
   457			if (ptr + section_len > end)
   458				break;
   459			ptr += section_len;
   460		}
   461	
   462		if (i < num_sections)
   463			return -EOVERFLOW;
   464	
   465		ptr = btrtl_dev->fw_data + sizeof(*hdr);
   466		for (i = 0; i < num_sections; i++) {
   467			section = (void *)ptr;
   468			rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
   469			ptr += sizeof(*section);
   470	
   471			section_len = le32_to_cpu(section->len);
   472			opcode      = le32_to_cpu(section->opcode);
   473			switch (opcode) {
   474			case RTL_PATCH_SNIPPETS:
   475				rc = btrtl_parse_section(hdev, btrtl_dev, opcode, ptr,
   476							 section_len);
   477				break;
   478			case RTL_PATCH_SECURITY_HEADER:
   479				/* If key_id from chip is zero, ignore all security
   480				 * headers.
   481				 */
   482				if (!key_id)
   483					break;
   484				rc = btrtl_parse_section(hdev, btrtl_dev, opcode, ptr,
   485							 section_len);
   486				if (rc > 0)
   487					secure += rc;
   488	
   489				break;
   490			case RTL_PATCH_DUMMY_HEADER:
   491				if (key_id)
   492					break;
   493				rc = btrtl_parse_section(hdev, btrtl_dev, opcode, ptr,
   494							 section_len);
   495				if (rc > 0)
   496					dummy += rc;
   497				break;
   498			default:
   499				rc = 0;
   500				break;
   501			}
   502			if (rc < 0) {
   503				rtl_dev_err(hdev, "RTL: Parse section (%u) err %d",
   504					    opcode, rc);
   505				return rc;
   506			}
   507			len += rc;
   508			ptr += section_len;
   509		}
   510	
   511		if (!len)
   512			return -ENODATA;
   513	
   514		bt_dev_info(hdev, "RTL: Patch (len %d) found", len);
   515	
   516		/* Allocate mem and copy all found subsecs. */
   517		ptr = kvmalloc(len, GFP_KERNEL);
   518		if (!ptr)
   519			return -ENOMEM;
   520	
   521		len = 0;
   522		list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, list) {
   523			rtl_dev_dbg(hdev, "RTL: len 0x%x", entry->len);
   524			memcpy(ptr + len, entry->data, entry->len);
   525			len += entry->len;
   526			list_del(&entry->list);
   527			kfree(entry);
   528		}
   529	
   530		*_buf = ptr;
   531		return len;
   532	}
   533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
