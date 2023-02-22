Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9281969F651
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjBVOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjBVOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:18:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEDE3771D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:18:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so1040243wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9AYv4MZ0PVdleCTLJmIdfXhLpHP301LVOycmvvAP8k=;
        b=MEZmwJwuozbgU2BGHEe6dTjKLaFjN2r0XVnwx90M1y0zW1HAbrl2S5ba/42kntuO5W
         FCOD3KcgaT7O/cKD3iymSEmo+42I0qpvzrv9oXrWZ+oyp1sa59hHKtydyN8RX8BLoIEq
         KqsfxbtvGIy1aF5AShWqaXdcwD4cCdQiTBV6CpFXXxKsGcWot5wBqMFtsSR6Je61wUGt
         Cct+Jxr4Pc3kQ+haKOXeS6hKijXyUmqIZNDg27K9MZ/46HRXicMlo7NtCpE1b84zeUor
         YwwTYN/qOPj+jitlxNBArAdZ2PBIRt7iC8mfl4wQgWWSn8wTz6GL++i2NWVcADmQgTrL
         U8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9AYv4MZ0PVdleCTLJmIdfXhLpHP301LVOycmvvAP8k=;
        b=OO9hdSwFCy+TPMs2RRRSEjw5KYq4mvlReQBFbkcxoqDaRkfjxncBGGRHWAM9MfKbR/
         10Ymn1XxSN8k40an90qu0+U4WlQKN2TxSEUS3ufhScSJB7VJEQxgny0u9mQbTqYukTXC
         nJZVn8n6IjkOx6Qg9UGx+l34Zas9bW9Jg96w2f1mL/HrkV93cLbI1/QYivJw9oV9h+ml
         VMkd3TGeliz4QzfqDVBPhM3FylmQTI2mRVWafTM7dB9kTQI1+whjz7ZfQZ6DX83pnWjB
         30VVWDhwsr+c92vOWykPAQOPEd6o/9xz+zFBeYd67seuuwR9KVezXOhMH6blGz23zpbH
         HEYw==
X-Gm-Message-State: AO0yUKXtMHRAsXW7TpM2WnZGsbi+gMC0fjtYJsBah3pJ0tz0lYQVDFZB
        9Sh9+jPsQB5lxg+PoIIXAcQwSZqNK19+XA==
X-Google-Smtp-Source: AK7set+CmRx93TMsiUA4vCV6SODXbE8jzm5WDn5sIGkpTrZ+gi3QeUMO7ui5hmhh8w0HklpUx/VN1A==
X-Received: by 2002:a05:600c:4b30:b0:3e2:147f:ac1a with SMTP id i48-20020a05600c4b3000b003e2147fac1amr4335527wmp.21.1677075497154;
        Wed, 22 Feb 2023 06:18:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d4f81000000b002c5526234d2sm7025740wru.8.2023.02.22.06.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 06:18:16 -0800 (PST)
Date:   Wed, 22 Feb 2023 17:18:13 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Vamsi Attunuru <vattunuru@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c:29
 rvu_mcs_set_lmac_bmap() error: uninitialized symbol 'lmac_bmap'.
Message-ID: <202302191621.sVquZwLz-lkp@intel.com>
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
head:   925cf0457d7e62ce08878ffb789189ac08ca8677
commit: ca7f49ff884677f97858c3934806e0e666425af0 octeontx2-af: cn10k: Introduce driver for macsec block.
config: s390-randconfig-m031-20230219 (https://download.01.org/0day-ci/archive/20230219/202302191621.sVquZwLz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302191621.sVquZwLz-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c:29 rvu_mcs_set_lmac_bmap() error: uninitialized symbol 'lmac_bmap'.

vim +/lmac_bmap +29 drivers/net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c

ca7f49ff884677 Geetha sowjanya 2022-10-01  16  static void rvu_mcs_set_lmac_bmap(struct rvu *rvu)
ca7f49ff884677 Geetha sowjanya 2022-10-01  17  {
ca7f49ff884677 Geetha sowjanya 2022-10-01  18  	struct mcs *mcs = mcs_get_pdata(0);
ca7f49ff884677 Geetha sowjanya 2022-10-01  19  	unsigned long lmac_bmap;
ca7f49ff884677 Geetha sowjanya 2022-10-01  20  	int cgx, lmac, port;
ca7f49ff884677 Geetha sowjanya 2022-10-01  21  
ca7f49ff884677 Geetha sowjanya 2022-10-01  22  	for (port = 0; port < mcs->hw->lmac_cnt; port++) {
ca7f49ff884677 Geetha sowjanya 2022-10-01  23  		cgx = port / rvu->hw->lmac_per_cgx;
ca7f49ff884677 Geetha sowjanya 2022-10-01  24  		lmac = port % rvu->hw->lmac_per_cgx;
ca7f49ff884677 Geetha sowjanya 2022-10-01  25  		if (!is_lmac_valid(rvu_cgx_pdata(cgx, rvu), lmac))
ca7f49ff884677 Geetha sowjanya 2022-10-01  26  			continue;
ca7f49ff884677 Geetha sowjanya 2022-10-01  27  		set_bit(port, &lmac_bmap);

This doesn't work.  lmac_bmap needs to be initialized to zero.

ca7f49ff884677 Geetha sowjanya 2022-10-01  28  	}
ca7f49ff884677 Geetha sowjanya 2022-10-01 @29  	mcs->hw->lmac_bmap = lmac_bmap;
ca7f49ff884677 Geetha sowjanya 2022-10-01  30  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

