Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57E1723A87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjFFHwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbjFFHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE81739;
        Tue,  6 Jun 2023 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037570; x=1717573570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FZ5IRlOqTEgwsx24HbFgMIUGFww7wT7RtnV/hTA10f0=;
  b=VbXorEDTRcpZs61c8GHI8BaoNgz8XiHE1fIx8Fqywxs2xlc+OS/nu95y
   V8wkKFY9uKnw8yz0oeTS85CMN4dfPkrftA/D8nnev/j4Mqd32wIJGzFXz
   M+ND4+xBZOJ9mPAegFtMXFcUlqvtXuwuSigZlVpSUwIYRcahYI7yvqK5d
   bvS35QvVjywZ/YOG7LEQUiUGvtAuYKvkSHDUpdS2cjGV02uZYphy5zkvN
   PBtAAeexwCQyvbmuIJI/L59p5gyjGAz297LWCzpkXO4bbCgLGwH4jC9M3
   4wqGAvSjutViCweOA0L87ClO3alvljr3aAOF5L3T3TNkJ9HuV/cOE15tj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419270"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419270"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516625"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516625"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2023 00:44:04 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6RMJ-0004yz-38;
        Tue, 06 Jun 2023 07:44:03 +0000
Date:   Tue, 6 Jun 2023 15:43:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:614:36:
 warning: unused variable 'mtk_jpeg_enc_ioctl_ops'
Message-ID: <202306061523.AFZiNh4D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi oushixiong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8dba31b0a826e691949cd4fdfa5c30defaac8c5
commit: 4ae47770d57bff0193fbbf48d56c18759cad5f6e media: mtk-jpegenc: Fix a compilation issue
date:   3 months ago
config: hexagon-buildonly-randconfig-r003-20230606 (https://download.01.org/0day-ci/archive/20230606/202306061523.AFZiNh4D-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ae47770d57bff0193fbbf48d56c18759cad5f6e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4ae47770d57bff0193fbbf48d56c18759cad5f6e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash arch/hexagon/kernel/ drivers/media/platform/mediatek/jpeg/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306061523.AFZiNh4D-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:11:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:11:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:11:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:31:28: warning: unused variable 'mtk_jpeg_enc_formats' [-Wunused-variable]
      31 | static struct mtk_jpeg_fmt mtk_jpeg_enc_formats[] = {
         |                            ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:79:28: warning: unused variable 'mtk_jpeg_dec_formats' [-Wunused-variable]
      79 | static struct mtk_jpeg_fmt mtk_jpeg_dec_formats[] = {
         |                            ^
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:614:36: warning: unused variable 'mtk_jpeg_enc_ioctl_ops' [-Wunused-const-variable]
     614 | static const struct v4l2_ioctl_ops mtk_jpeg_enc_ioctl_ops = {
         |                                    ^
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:644:36: warning: unused variable 'mtk_jpeg_dec_ioctl_ops' [-Wunused-const-variable]
     644 | static const struct v4l2_ioctl_ops mtk_jpeg_dec_ioctl_ops = {
         |                                    ^
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:884:29: warning: unused variable 'mtk_jpeg_dec_qops' [-Wunused-const-variable]
     884 | static const struct vb2_ops mtk_jpeg_dec_qops = {
         |                             ^
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:893:29: warning: unused variable 'mtk_jpeg_enc_qops' [-Wunused-const-variable]
     893 | static const struct vb2_ops mtk_jpeg_enc_qops = {
         |                             ^
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1366:34: warning: unused variable 'mtk_jpeg_enc_m2m_ops' [-Wunused-const-variable]
    1366 | static const struct v4l2_m2m_ops mtk_jpeg_enc_m2m_ops = {
         |                                  ^
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1370:34: warning: unused variable 'mtk_jpeg_multicore_enc_m2m_ops' [-Wunused-const-variable]
    1370 | static const struct v4l2_m2m_ops mtk_jpeg_multicore_enc_m2m_ops = {
         |                                  ^
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1374:34: warning: unused variable 'mtk_jpeg_multicore_dec_m2m_ops' [-Wunused-const-variable]
    1374 | static const struct v4l2_m2m_ops mtk_jpeg_multicore_dec_m2m_ops = {
         |                                  ^
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1378:34: warning: unused variable 'mtk_jpeg_dec_m2m_ops' [-Wunused-const-variable]
    1378 | static const struct v4l2_m2m_ops mtk_jpeg_dec_m2m_ops = {
         |                                  ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1461:20: warning: unused function 'mtk_jpeg_enc_irq' [-Wunused-function]
    1461 | static irqreturn_t mtk_jpeg_enc_irq(int irq, void *priv)
         |                    ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1481:20: warning: unused function 'mtk_jpeg_dec_irq' [-Wunused-function]
    1481 | static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
         |                    ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1645:29: warning: unused variable 'mt8173_jpeg_dec_clocks' [-Wunused-variable]
    1645 | static struct clk_bulk_data mt8173_jpeg_dec_clocks[] = {
         |                             ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1650:29: warning: unused variable 'mtk_jpeg_clocks' [-Wunused-variable]
    1650 | static struct clk_bulk_data mtk_jpeg_clocks[] = {
         |                             ^
   20 warnings generated.


vim +/mtk_jpeg_enc_ioctl_ops +614 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c

52f68114857fe5 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c kyrie wu        2022-09-29  613  
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14 @614  static const struct v4l2_ioctl_ops mtk_jpeg_enc_ioctl_ops = {
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  615  	.vidioc_querycap                = mtk_jpeg_querycap,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  616  	.vidioc_enum_fmt_vid_cap	= mtk_jpeg_enum_fmt_vid_cap,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  617  	.vidioc_enum_fmt_vid_out	= mtk_jpeg_enum_fmt_vid_out,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  618  	.vidioc_try_fmt_vid_cap_mplane	= mtk_jpeg_try_fmt_vid_cap_mplane,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  619  	.vidioc_try_fmt_vid_out_mplane	= mtk_jpeg_try_fmt_vid_out_mplane,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  620  	.vidioc_g_fmt_vid_cap_mplane    = mtk_jpeg_g_fmt_vid_mplane,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  621  	.vidioc_g_fmt_vid_out_mplane    = mtk_jpeg_g_fmt_vid_mplane,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  622  	.vidioc_s_fmt_vid_cap_mplane    = mtk_jpeg_s_fmt_vid_cap_mplane,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  623  	.vidioc_s_fmt_vid_out_mplane    = mtk_jpeg_s_fmt_vid_out_mplane,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  624  	.vidioc_qbuf                    = v4l2_m2m_ioctl_qbuf,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  625  	.vidioc_subscribe_event         = mtk_jpeg_subscribe_event,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  626  	.vidioc_g_selection		= mtk_jpeg_enc_g_selection,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  627  	.vidioc_s_selection		= mtk_jpeg_enc_s_selection,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  628  
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  629  	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  630  	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  631  	.vidioc_reqbufs                 = v4l2_m2m_ioctl_reqbufs,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  632  	.vidioc_querybuf                = v4l2_m2m_ioctl_querybuf,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  633  	.vidioc_dqbuf                   = v4l2_m2m_ioctl_dqbuf,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  634  	.vidioc_expbuf                  = v4l2_m2m_ioctl_expbuf,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  635  	.vidioc_streamon                = v4l2_m2m_ioctl_streamon,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  636  	.vidioc_streamoff               = v4l2_m2m_ioctl_streamoff,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  637  
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  638  	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
8f1f08a6337efe drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c kyrie wu        2022-09-29  639  
8f1f08a6337efe drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c kyrie wu        2022-09-29  640  	.vidioc_encoder_cmd		= v4l2_m2m_ioctl_encoder_cmd,
8f1f08a6337efe drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c kyrie wu        2022-09-29  641  	.vidioc_try_encoder_cmd		= v4l2_m2m_ioctl_try_encoder_cmd,
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  642  };
45f13a57d81344 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  643  
2ac8015f156b55 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14 @644  static const struct v4l2_ioctl_ops mtk_jpeg_dec_ioctl_ops = {
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  645  	.vidioc_querycap                = mtk_jpeg_querycap,
7e98b7b542a456 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Boris Brezillon 2019-06-04  646  	.vidioc_enum_fmt_vid_cap	= mtk_jpeg_enum_fmt_vid_cap,
7e98b7b542a456 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Boris Brezillon 2019-06-04  647  	.vidioc_enum_fmt_vid_out	= mtk_jpeg_enum_fmt_vid_out,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  648  	.vidioc_try_fmt_vid_cap_mplane	= mtk_jpeg_try_fmt_vid_cap_mplane,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  649  	.vidioc_try_fmt_vid_out_mplane	= mtk_jpeg_try_fmt_vid_out_mplane,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  650  	.vidioc_g_fmt_vid_cap_mplane    = mtk_jpeg_g_fmt_vid_mplane,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  651  	.vidioc_g_fmt_vid_out_mplane    = mtk_jpeg_g_fmt_vid_mplane,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  652  	.vidioc_s_fmt_vid_cap_mplane    = mtk_jpeg_s_fmt_vid_cap_mplane,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  653  	.vidioc_s_fmt_vid_out_mplane    = mtk_jpeg_s_fmt_vid_out_mplane,
52f68114857fe5 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c kyrie wu        2022-09-29  654  	.vidioc_qbuf                    = mtk_jpeg_qbuf,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  655  	.vidioc_subscribe_event         = mtk_jpeg_subscribe_event,
2ac8015f156b55 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Xia Jiang       2020-08-14  656  	.vidioc_g_selection		= mtk_jpeg_dec_g_selection,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  657  
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  658  	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  659  	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  660  	.vidioc_reqbufs                 = v4l2_m2m_ioctl_reqbufs,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  661  	.vidioc_querybuf                = v4l2_m2m_ioctl_querybuf,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  662  	.vidioc_dqbuf                   = v4l2_m2m_ioctl_dqbuf,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  663  	.vidioc_expbuf                  = v4l2_m2m_ioctl_expbuf,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  664  	.vidioc_streamon                = v4l2_m2m_ioctl_streamon,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  665  	.vidioc_streamoff               = v4l2_m2m_ioctl_streamoff,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  666  
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  667  	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
bf8460d2f4e6a1 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c kyrie wu        2022-09-29  668  
bf8460d2f4e6a1 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c kyrie wu        2022-09-29  669  	.vidioc_decoder_cmd = v4l2_m2m_ioctl_decoder_cmd,
bf8460d2f4e6a1 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c kyrie wu        2022-09-29  670  	.vidioc_try_decoder_cmd = v4l2_m2m_ioctl_try_decoder_cmd,
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  671  };
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c      Rick Chang      2016-12-14  672  

:::::: The code at line 614 was first introduced by commit
:::::: 45f13a57d8134459f02fbee0b1711eddc3260af7 media: platform: Add jpeg enc feature

:::::: TO: Xia Jiang <xia.jiang@mediatek.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
