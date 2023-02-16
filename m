Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996606992D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjBPLKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjBPLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:10:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D66956ECC;
        Thu, 16 Feb 2023 03:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676545833; x=1708081833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J6BNHHswTkDcX5jOI5ShWTSFAJ7P3SXfiqTD8tl74ZA=;
  b=HclVVJpJ1L8+UNiq0TyJU+4RP4WTMDaTFv1KPej9mxZMT/PeaUTbB8ex
   V3HzSv0M+aWvD2mznhj4IGllgpIZ66Od4XBzgbR09kDpweHTPJJ/pf/Nx
   O0wVGaZIVDeE+s8LM63BW8i2fLCb4Qd+n+t6SDfP7V/6DAL5QdvWH6qy+
   ofJo7fPT669r/BvPs9WwYHt7pRF/socml9GzPCxeWHars3G9VD9LvhAVh
   ztFYVFHNllLoFZ5qAayXK/4tgfsULMP1vnhgjD1y9IvF0ouwNzyAB5TmY
   Gnp29YKF8jM6aGkMlbSnwyCkoyOfioKm7nYvBqL7l4kyPJqq5ieIF7BN3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="417913088"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="417913088"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 03:10:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="670089954"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="670089954"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2023 03:10:25 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSc9g-000ADR-1N;
        Thu, 16 Feb 2023 11:10:24 +0000
Date:   Thu, 16 Feb 2023 19:09:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Elliot Berman <quic_eberman@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 16/26] firmware: qcom_scm: Register Gunyah platform
 ops
Message-ID: <202302161942.xItsHIi1-lkp@intel.com>
References: <20230214212457.3319814-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214212457.3319814-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb]

url:    https://github.com/intel-lab-lkp/linux/commits/Elliot-Berman/docs-gunyah-Introduce-Gunyah-Hypervisor/20230215-055721
base:   3ebb0ac55efaf1d0fb1b106f852c114e5021f7eb
patch link:    https://lore.kernel.org/r/20230214212457.3319814-1-quic_eberman%40quicinc.com
patch subject: [PATCH v10 16/26] firmware: qcom_scm: Register Gunyah platform ops
config: hexagon-randconfig-r041-20230212 (https://download.01.org/0day-ci/archive/20230216/202302161942.xItsHIi1-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/33f0c4b130c7b249a1524da8076dd12333aa7cde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elliot-Berman/docs-gunyah-Introduce-Gunyah-Hypervisor/20230215-055721
        git checkout 33f0c4b130c7b249a1524da8076dd12333aa7cde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302161942.xItsHIi1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/firmware/qcom_scm.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/firmware/qcom_scm.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/firmware/qcom_scm.c:7:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/firmware/qcom_scm.c:1335:7: error: incompatible pointer types passing 'u64 *' (aka 'unsigned long long *') to parameter of type 'unsigned int *' [-Werror,-Wincompatible-pointer-types]
                                                   &src_cpy, new_perms, mem_parcel->n_acl_entries);
                                                   ^~~~~~~~
   drivers/firmware/qcom_scm.c:912:18: note: passing argument to parameter 'srcvm' here
                           unsigned int *srcvm,
                                         ^
   drivers/firmware/qcom_scm.c:1353:7: error: incompatible pointer types passing 'u64 *' (aka 'unsigned long long *') to parameter of type 'unsigned int *' [-Werror,-Wincompatible-pointer-types]
                                                   &src_cpy, new_perms, 1));
                                                   ^~~~~~~~
   include/asm-generic/bug.h:147:18: note: expanded from macro 'WARN_ON_ONCE'
           DO_ONCE_LITE_IF(condition, WARN_ON, 1)
                           ^~~~~~~~~
   include/linux/once_lite.h:28:27: note: expanded from macro 'DO_ONCE_LITE_IF'
                   bool __ret_do_once = !!(condition);                     \
                                           ^~~~~~~~~
   drivers/firmware/qcom_scm.c:912:18: note: passing argument to parameter 'srcvm' here
                           unsigned int *srcvm,
                                         ^
   drivers/firmware/qcom_scm.c:1385:7: error: incompatible pointer types passing 'u64 *' (aka 'unsigned long long *') to parameter of type 'unsigned int *' [-Werror,-Wincompatible-pointer-types]
                                                   &src_cpy, &new_perms, 1);
                                                   ^~~~~~~~
   drivers/firmware/qcom_scm.c:912:18: note: passing argument to parameter 'srcvm' here
                           unsigned int *srcvm,
                                         ^
   6 warnings and 3 errors generated.


vim +1335 drivers/firmware/qcom_scm.c

  1303	
  1304	static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
  1305	{
  1306		struct qcom_scm_vmperm *new_perms;
  1307		u64 src, src_cpy;
  1308		int ret = 0, i, n;
  1309		u16 vmid;
  1310	
  1311		new_perms = kcalloc(mem_parcel->n_acl_entries, sizeof(*new_perms), GFP_KERNEL);
  1312		if (!new_perms)
  1313			return -ENOMEM;
  1314	
  1315		for (n = 0; n < mem_parcel->n_acl_entries; n++) {
  1316			vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
  1317			if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
  1318				new_perms[n].vmid = vmid;
  1319			else
  1320				new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
  1321			if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
  1322				new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
  1323			if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
  1324				new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
  1325			if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
  1326				new_perms[n].perm |= QCOM_SCM_PERM_READ;
  1327		}
  1328	
  1329		src = (1ull << QCOM_SCM_VMID_HLOS);
  1330	
  1331		for (i = 0; i < mem_parcel->n_mem_entries; i++) {
  1332			src_cpy = src;
  1333			ret = qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
  1334							le64_to_cpu(mem_parcel->mem_entries[i].size),
> 1335							&src_cpy, new_perms, mem_parcel->n_acl_entries);
  1336			if (ret) {
  1337				src = 0;
  1338				for (n = 0; n < mem_parcel->n_acl_entries; n++) {
  1339					vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
  1340					if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
  1341						src |= (1ull << vmid);
  1342					else
  1343						src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
  1344				}
  1345	
  1346				new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
  1347	
  1348				for (i--; i >= 0; i--) {
  1349					src_cpy = src;
  1350					WARN_ON_ONCE(qcom_scm_assign_mem(
  1351							le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
  1352							le64_to_cpu(mem_parcel->mem_entries[i].size),
  1353							&src_cpy, new_perms, 1));
  1354				}
  1355				break;
  1356			}
  1357		}
  1358	
  1359		kfree(new_perms);
  1360		return ret;
  1361	}
  1362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
