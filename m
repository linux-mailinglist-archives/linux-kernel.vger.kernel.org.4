Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02F76DA932
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbjDGHDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbjDGHC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:02:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B99743
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680850967; x=1712386967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RpeddnkgOglW0cqyrivk5LaIXkhzsZ2FkrbBBAcTbSg=;
  b=N3//QhOiE+6D3rYZv/4D21tEvzfBm4NJDQSDT4fpqMgZCLbTVZc//Fla
   vq1Ti8tEzFrwSeOW13TKVjth9usdABmGK76qVdJhzvrXl7kI1RYzredLs
   wZb7j+WxunvXIddHOgffA88eG+4pAzCUfW6GtUKrL14uTTbiXR5x9vOFU
   +6gkHEVvbvhIThwqILnNsdxyRzQoXi0p29LZ3/B0EN7rmh6b/59JPDwfn
   cNj1kVJ1Lxsq+3yTFdB+pVLS1SnaO+ITFYZWKaElAbwacxqaH+CNFotec
   3cxBA107qdGIOw/jIDGSpsaX1iLkM+Mq+6ZS3dtP05VjTvMSWKCYwTK9U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="340429464"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="340429464"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 00:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="776761559"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="776761559"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2023 00:02:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkg7D-000SDq-2Z;
        Fri, 07 Apr 2023 07:02:31 +0000
Date:   Fri, 7 Apr 2023 15:02:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound
 6 equals destination size
Message-ID: <202304071552.CeeIBr5P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2afccfefe7be1f7346564fe619277110d341f9b
commit: 8f9e0a52810dd83406c768972d022c37e7a18f1f ACPI: Don't build ACPICA with '-Os'
date:   2 months ago
config: x86_64-sof-customedconfig-fuzz-defconfig (https://download.01.org/0day-ci/archive/20230407/202304071552.CeeIBr5P-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f9e0a52810dd83406c768972d022c37e7a18f1f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f9e0a52810dd83406c768972d022c37e7a18f1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304071552.CeeIBr5P-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
>> drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
      60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
      61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/strncpy +60 drivers/acpi/acpica/tbfind.c

f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  16  
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  17  /*******************************************************************************
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  18   *
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  19   * FUNCTION:    acpi_tb_find_table
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  20   *
ba494beeaa69bc drivers/acpi/acpica/tbfind.c Bob Moore 2012-07-12  21   * PARAMETERS:  signature           - String with ACPI table signature
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  22   *              oem_id              - String with the table OEM ID
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  23   *              oem_table_id        - String with the OEM Table ID
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  24   *              table_index         - Where the table index is returned
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  25   *
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  26   * RETURN:      Status and table index
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  27   *
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  28   * DESCRIPTION: Find an ACPI table (in the RSDT/XSDT) that matches the
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  29   *              Signature, OEM ID and OEM Table ID. Returns an index that can
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  30   *              be used to get the table header or entire table.
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  31   *
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  32   ******************************************************************************/
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  33  acpi_status
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  34  acpi_tb_find_table(char *signature,
67a119f990063f drivers/acpi/tables/tbfind.c Bob Moore 2008-06-10  35  		   char *oem_id, char *oem_table_id, u32 *table_index)
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  36  {
ac0f06ebb815da drivers/acpi/acpica/tbfind.c Lv Zheng  2016-09-07  37  	acpi_status status = AE_OK;
47c08729bf1c60 drivers/acpi/tables/tbfind.c Lin Ming  2008-04-10  38  	struct acpi_table_header header;
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  39  	u32 i;
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  40  
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  41  	ACPI_FUNCTION_TRACE(tb_find_table);
f3d2e7865c8162 drivers/acpi/tables/tbfind.c Bob Moore 2007-02-02  42  
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  43  	/* Validate the input table signature */
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  44  
6a0df32c22fdfc drivers/acpi/acpica/tbfind.c Bob Moore 2016-05-05  45  	if (!acpi_ut_valid_nameseg(signature)) {
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  46  		return_ACPI_STATUS(AE_BAD_SIGNATURE);
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  47  	}
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  48  
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  49  	/* Don't allow the OEM strings to be too long */
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  50  
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  51  	if ((strlen(oem_id) > ACPI_OEM_ID_SIZE) ||
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  52  	    (strlen(oem_table_id) > ACPI_OEM_TABLE_ID_SIZE)) {
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  53  		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  54  	}
9f41fd8a175ff8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-08-25  55  
47c08729bf1c60 drivers/acpi/tables/tbfind.c Lin Ming  2008-04-10  56  	/* Normalize the input strings */
47c08729bf1c60 drivers/acpi/tables/tbfind.c Lin Ming  2008-04-10  57  
4fa4616e279df8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-07-01  58  	memset(&header, 0, sizeof(struct acpi_table_header));
a3ce7a8e0dd9ba drivers/acpi/acpica/tbfind.c Bob Moore 2019-04-08  59  	ACPI_COPY_NAMESEG(header.signature, signature);
4fa4616e279df8 drivers/acpi/acpica/tbfind.c Bob Moore 2015-07-01 @60  	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);

:::::: The code at line 60 was first introduced by commit
:::::: 4fa4616e279df89baeb36287bbee83ab272edaed ACPICA: De-macroize calls to standard C library functions

:::::: TO: Bob Moore <robert.moore@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
