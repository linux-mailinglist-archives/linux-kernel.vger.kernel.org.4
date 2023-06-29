Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034107430DE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF2XIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2XIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:08:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA1D30C4;
        Thu, 29 Jun 2023 16:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688080088; x=1719616088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iznXYZ4xH3Nv8gWM89HiaGceomxOh3Ta2hE5jZaVkOM=;
  b=hf7R9BmpUHb+H+KPeikLPY/F62jOVX+vZ2xUi4+cFoSMP3goXwN4sSm2
   aphqsQE1NiP8vsP15kkpfIUNX/iXiT86U73biMPyopXHsqRoCcIoo16Dx
   2qHRGo9G5QbxQxWAPKQQGz7EWJjuZrw8WvS6D02NfDmyRvkhk9ewuF8Cm
   6SNKwaZ9qmzA8TXwn1nMoj5qLZO1Ro0P6NW5/1Gv29cy3oKug/eAPsHKd
   UnEzk/N1WXQzu/b5gsDbPZh1vBMYeP+MM/eGwePrbcr/fULZznmVvz0Nz
   QVvsP945RMWs3vqxPRzCWx5fwzSgi/vHIoizYl/s8mqbccP+MVDnk9Kqk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="352077264"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="352077264"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 16:08:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807531156"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="807531156"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 16:08:02 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qF0k5-000ETx-1u;
        Thu, 29 Jun 2023 23:08:01 +0000
Date:   Fri, 30 Jun 2023 07:07:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 2/4] regulator: Introduce Qualcomm REFGEN regulator
 driver
Message-ID: <202306300643.LHN1fbOT-lkp@intel.com>
References: <20230628-topic-refgen-v2-2-6136487c78c5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628-topic-refgen-v2-2-6136487c78c5@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5c875096d59010cee4e00da1f9c7bdb07a025dc2]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/dt-bindings-regulator-Describe-Qualcomm-REFGEN-regulator/20230630-043835
base:   5c875096d59010cee4e00da1f9c7bdb07a025dc2
patch link:    https://lore.kernel.org/r/20230628-topic-refgen-v2-2-6136487c78c5%40linaro.org
patch subject: [PATCH v2 2/4] regulator: Introduce Qualcomm REFGEN regulator driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230630/202306300643.LHN1fbOT-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306300643.LHN1fbOT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306300643.LHN1fbOT-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in net/netfilter/ipvs/ip_vs_sed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netfilter/ipvs/ip_vs_nq.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netfilter/ipvs/ip_vs_twos.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netfilter/ipvs/ip_vs_ftp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/netfilter/ipvs/ip_vs_pe_sip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/netfilter/nf_defrag_ipv4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/netfilter/nf_reject_ipv4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/netfilter/iptable_nat.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/netfilter/iptable_raw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ipip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_gre.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/udp_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_vti.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ah4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/xfrm4_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/tunnel4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/inet_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/tcp_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/udp_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/raw_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_algo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_user.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/unix/unix_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/netfilter/ip6table_raw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/netfilter/ip6table_nat.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/netfilter/nf_defrag_ipv6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/netfilter/nf_reject_ipv6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/ah6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/esp6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/xfrm6_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/tunnel6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/mip6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/sit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/ip6_udp_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ar9331.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_brcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_dsa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_gswip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_hellcreek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ksz.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_lan9303.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_mtk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_none.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ocelot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ocelot_8021q.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_qca.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_rtl4_a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_rtl8_4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_rzn1_a5psw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_sja1105.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_trailer.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_xrs700x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/8021q/8021q.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xdp/xsk_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/mptcp/mptcp_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/mptcp/mptcp_crypto_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/mptcp/mptcp_token_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/packet/af_packet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/packet/af_packet_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/key/af_key.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/netfilter/nf_conntrack_bridge.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/netfilter/ebtables.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/netfilter/ebtable_broute.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/netfilter/ebtable_filter.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/netfilter/ebtable_nat.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/bridge.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sunrpc/sunrpc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sunrpc/auth_gss/auth_rpcgss.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sunrpc/auth_gss/rpcsec_gss_krb5.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/kcm/kcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/atm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/lec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/mpoa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sctp/sctp_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/tipc/diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/chnl_net.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif_usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/6lowpan/6lowpan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ieee802154/6lowpan/ieee802154_6lowpan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ieee802154/ieee802154_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nfc_digital.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/vmw_vsock/vsock_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/hsr/hsr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/cio/ccwgroup.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/cio/vfio_ccw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_diag_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_eckd_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dasd_fba_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/block/dcssblk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/raw3270.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/con3270.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/char/fs3270.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/s390/net/lcs.o
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/fsl-edma.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/dma/idma64.ko] undefined!
>> ERROR: modpost: "devm_platform_ioremap_resource" [drivers/regulator/qcom-refgen-regulator.ko] undefined!
ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
ERROR: modpost: "devm_memremap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "devm_memunmap" [drivers/misc/open-dice.ko] undefined!
ERROR: modpost: "iounmap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
ERROR: modpost: "ioremap" [drivers/net/ethernet/8390/pcnet_cs.ko] undefined!
WARNING: modpost: suppressed 13 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
