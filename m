Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599ED5BF02E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiITWbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiITWbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:31:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128225C6C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663713105; x=1695249105;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cqggcTAxb9N5aY8DgeDzOPQv8zguDUpPu7jYY0RpRGo=;
  b=CKx0S/3Pib1dxYbgouts1L2wpgi82XCr68QB8jNwcGYjp1dndRDh6yb3
   pklZ/HFC7nowqVCnxnQViElD6bdPd+aeWoMfQplQfolrvZbEV0/RG7XrT
   LRqofZMNcOxmi3TAw78m3WWfDWi/HqJQDl406swfoxn7EGdMMmgSRqJWu
   Ra4n8oy5PCp9v2OgLpj775BgBlrSBh3ul70iT/oroCcQ2zs1S2CTyYMav
   emZ8y9+DtsIck9kjbsB2IJv7U3qRjAVv5hGyJU0qKo511pNz9OKoVxULy
   KOdLVsP6slt/3Aa1rrh6jCaCllzRMvvq6MiCZx9lGwNC5atwInkCjZBHF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="280210214"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="280210214"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="652277126"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 15:31:42 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oalmH-00030j-38;
        Tue, 20 Sep 2022 22:31:41 +0000
Date:   Wed, 21 Sep 2022 06:31:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Valentin Korenblit <vkorenblit@sequans.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Message-ID: <202209210641.MziHAbW7-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
head:   63de24fccb6b831be1abfe07292449105b467731
commit: 7e7dc04774b18c0e42ce74aa3357021cda979674 [11/31] mtd: rawnand: cadence: support 64-bit slave dma interface
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220921/202209210641.MziHAbW7-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?id=7e7dc04774b18c0e42ce74aa3357021cda979674
        git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
        git fetch --no-tags mtd nand/next
        git checkout 7e7dc04774b18c0e42ce74aa3357021cda979674
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit declaration of function 'ioread64_rep' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           ioread64_rep(cdns_ctrl->io.virt, buf, len_in_words);
                           ^
>> drivers/mtd/nand/raw/cadence-nand-controller.c:1962:4: error: implicit declaration of function 'iowrite64_rep' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           iowrite64_rep(cdns_ctrl->io.virt, buf, len_in_words);
                           ^
   2 errors generated.


vim +/ioread64_rep +1893 drivers/mtd/nand/raw/cadence-nand-controller.c

  1871	
  1872	static int cadence_nand_read_buf(struct cdns_nand_ctrl *cdns_ctrl,
  1873					 u8 *buf, int len)
  1874	{
  1875		u8 thread_nr = 0;
  1876		u32 sdma_size;
  1877		int status;
  1878	
  1879		/* Wait until slave DMA interface is ready to data transfer. */
  1880		status = cadence_nand_wait_on_sdma(cdns_ctrl, &thread_nr, &sdma_size);
  1881		if (status)
  1882			return status;
  1883	
  1884		if (!cdns_ctrl->caps1->has_dma) {
  1885			u8 data_dma_width = cdns_ctrl->caps2.data_dma_width;
  1886	
  1887			int len_in_words = (data_dma_width == 4) ? len >> 2 : len >> 3;
  1888	
  1889			/* read alingment data */
  1890			if (data_dma_width == 4)
  1891				ioread32_rep(cdns_ctrl->io.virt, buf, len_in_words);
  1892			else
> 1893				ioread64_rep(cdns_ctrl->io.virt, buf, len_in_words);
  1894	
  1895			if (sdma_size > len) {
  1896				int read_bytes = (data_dma_width == 4) ?
  1897					len_in_words << 2 : len_in_words << 3;
  1898	
  1899				/* read rest data from slave DMA interface if any */
  1900				if (data_dma_width == 4)
  1901					ioread32_rep(cdns_ctrl->io.virt,
  1902						     cdns_ctrl->buf,
  1903						     sdma_size / 4 - len_in_words);
  1904				else
  1905					ioread64_rep(cdns_ctrl->io.virt,
  1906						     cdns_ctrl->buf,
  1907						     sdma_size / 8 - len_in_words);
  1908	
  1909				/* copy rest of data */
  1910				memcpy(buf + read_bytes, cdns_ctrl->buf,
  1911				       len - read_bytes);
  1912			}
  1913			return 0;
  1914		}
  1915	
  1916		if (cadence_nand_dma_buf_ok(cdns_ctrl, buf, len)) {
  1917			status = cadence_nand_slave_dma_transfer(cdns_ctrl, buf,
  1918								 cdns_ctrl->io.dma,
  1919								 len, DMA_FROM_DEVICE);
  1920			if (status == 0)
  1921				return 0;
  1922	
  1923			dev_warn(cdns_ctrl->dev,
  1924				 "Slave DMA transfer failed. Try again using bounce buffer.");
  1925		}
  1926	
  1927		/* If DMA transfer is not possible or failed then use bounce buffer. */
  1928		status = cadence_nand_slave_dma_transfer(cdns_ctrl, cdns_ctrl->buf,
  1929							 cdns_ctrl->io.dma,
  1930							 sdma_size, DMA_FROM_DEVICE);
  1931	
  1932		if (status) {
  1933			dev_err(cdns_ctrl->dev, "Slave DMA transfer failed");
  1934			return status;
  1935		}
  1936	
  1937		memcpy(buf, cdns_ctrl->buf, len);
  1938	
  1939		return 0;
  1940	}
  1941	
  1942	static int cadence_nand_write_buf(struct cdns_nand_ctrl *cdns_ctrl,
  1943					  const u8 *buf, int len)
  1944	{
  1945		u8 thread_nr = 0;
  1946		u32 sdma_size;
  1947		int status;
  1948	
  1949		/* Wait until slave DMA interface is ready to data transfer. */
  1950		status = cadence_nand_wait_on_sdma(cdns_ctrl, &thread_nr, &sdma_size);
  1951		if (status)
  1952			return status;
  1953	
  1954		if (!cdns_ctrl->caps1->has_dma) {
  1955			u8 data_dma_width = cdns_ctrl->caps2.data_dma_width;
  1956	
  1957			int len_in_words = (data_dma_width == 4) ? len >> 2 : len >> 3;
  1958	
  1959			if (data_dma_width == 4)
  1960				iowrite32_rep(cdns_ctrl->io.virt, buf, len_in_words);
  1961			else
> 1962				iowrite64_rep(cdns_ctrl->io.virt, buf, len_in_words);
  1963	
  1964			if (sdma_size > len) {
  1965				int written_bytes = (data_dma_width == 4) ?
  1966					len_in_words << 2 : len_in_words << 3;
  1967	
  1968				/* copy rest of data */
  1969				memcpy(cdns_ctrl->buf, buf + written_bytes,
  1970				       len - written_bytes);
  1971	
  1972				/* write all expected by nand controller data */
  1973				if (data_dma_width == 4)
  1974					iowrite32_rep(cdns_ctrl->io.virt,
  1975						      cdns_ctrl->buf,
  1976						      sdma_size / 4 - len_in_words);
  1977				else
  1978					iowrite64_rep(cdns_ctrl->io.virt,
  1979						      cdns_ctrl->buf,
  1980						      sdma_size / 8 - len_in_words);
  1981			}
  1982	
  1983			return 0;
  1984		}
  1985	
  1986		if (cadence_nand_dma_buf_ok(cdns_ctrl, buf, len)) {
  1987			status = cadence_nand_slave_dma_transfer(cdns_ctrl, (void *)buf,
  1988								 cdns_ctrl->io.dma,
  1989								 len, DMA_TO_DEVICE);
  1990			if (status == 0)
  1991				return 0;
  1992	
  1993			dev_warn(cdns_ctrl->dev,
  1994				 "Slave DMA transfer failed. Try again using bounce buffer.");
  1995		}
  1996	
  1997		/* If DMA transfer is not possible or failed then use bounce buffer. */
  1998		memcpy(cdns_ctrl->buf, buf, len);
  1999	
  2000		status = cadence_nand_slave_dma_transfer(cdns_ctrl, cdns_ctrl->buf,
  2001							 cdns_ctrl->io.dma,
  2002							 sdma_size, DMA_TO_DEVICE);
  2003	
  2004		if (status)
  2005			dev_err(cdns_ctrl->dev, "Slave DMA transfer failed");
  2006	
  2007		return status;
  2008	}
  2009	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
