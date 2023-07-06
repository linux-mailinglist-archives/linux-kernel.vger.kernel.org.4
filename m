Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BD57499C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGFKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGFKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:50:50 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5231F1FED;
        Thu,  6 Jul 2023 03:50:47 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="103028920"
X-IronPort-AV: E=Sophos;i="6.01,185,1684767600"; 
   d="scan'208";a="103028920"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 19:50:44 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id DC349D29E1;
        Thu,  6 Jul 2023 19:50:42 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1A1D0D9482;
        Thu,  6 Jul 2023 19:50:42 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BEBCC70BD9;
        Thu,  6 Jul 2023 19:50:39 +0900 (JST)
Message-ID: <7816e721-d0be-a146-4ab3-981a0619311e@fujitsu.com>
Date:   Thu, 6 Jul 2023 18:50:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] cxl: fix CONFIG_FW_LOADER dependency
To:     Arnd Bergmann <arnd@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230703112928.332321-1-arnd@kernel.org>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20230703112928.332321-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27734.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27734.005
X-TMASE-Result: 10-0.799300-10.000000
X-TMASE-MatchedRID: hwtUKlde9zGPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizwzOk0/RiyBuak4
        lLAFOnmC/Pc8drndASe+tYGi9QLNmq5eIDD1ppIU0QlBRwJqtSMbbhhV65kaY9uEAkFobdWZo8W
        MkQWv6iUD0yuKrQIMCCAtDqHg/4Qmv79FIUygvZzZs3HUcS/scCq2rl3dzGQ1+hga1eR27pK58k
        oA2iD482k6ZMp6CQdf0mnT/JDrtEpKDrTZjLnbCY2I6ly/IS1oILTEvFaCkR4CqAzD4rdFIwZjb
        HmFoHt/5KURsc/QZz6F2JJaIjBHcl5/kgk8Ja9wMsqIZ2nIuPT3Bu44zcQFvQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/3 19:29, Arnd Bergmann wrote:
> From: Arnd Bergmann<arnd@arndb.de>
> 
> When FW_LOADER is disabled, cxl fails to link:
> 
> arm-linux-gnueabi-ld: drivers/cxl/core/memdev.o: in function `cxl_memdev_setup_fw_upload':
> memdev.c:(.text+0x90e): undefined reference to `firmware_upload_register'
> memdev.c:(.text+0x93c): undefined reference to `firmware_upload_unregister'
> 
> In order to use the firmware_upload_register() function, both FW_LOADER
> and FW_UPLOAD have to be enabled, which is a bit confusing. In addition,
> the dependency is on the wrong symbol, as the caller is part of the
> cxl_core.ko module, not the cxl_mem.ko module.
> 
> Fixes: 9521875bbe005 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
> Signed-off-by: Arnd Bergmann<arnd@arndb.de>

Hi Arnd,

It makes sense.

Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang
