Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E10A6A3A26
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjB0EbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0EbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:31:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12111EBC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:31:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p16so3391307wmq.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nWXThMyntgQC2vaXxzGqflN0E53HdUGqETRp0fNNDI=;
        b=YLmEtQu8tXOoN7pb1/o2lo+ceTJ2Zc4UW7ifEgy0sZGpGIAyu2MCE3ZBlE+VlbDCdo
         AeDK1pg7hlUBwHa7Q0n/57/hXhMkEODq2nKWJTO1UYXIZ3k75qprALUfujkJ9u5JDOeQ
         RUofWHmmcOKiWl8/KQiU5m1qXkFPHtMG36U8GnK4hlDhokaszDQz33PNqvWIG4n8rtjq
         OlymhKx3PcZiWw6kO3A0jll4F11ZataTP1KkHG4xZAPa46Uilu0BcgODnFKqmVGi2279
         wmZbw5YenjaHD5k/rpbOv0tl5O8JSUaUsCWQ60lpRsOCxnMFGTgWCoh0Rd8cPGSKJlrv
         xCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nWXThMyntgQC2vaXxzGqflN0E53HdUGqETRp0fNNDI=;
        b=ODSDQa3iMwOd4DE8OrIsv52grQr47/r3DlBd9KdTMymvjVJm2Nou2hEaXFb8xWADLw
         92OojkrrKWllFSYFaqxSl9wXgEzpnZtGJMIa6atsHlb/lWLe0UQZYqu9ndNTpFYPHyBn
         7xAdqAXEz3V9oQTM+v3vwu8PRstnc33jbmTqmv89WmzerikXDCHnCMsEfzMoNC7GUWqy
         Oq/ZSoHsDJqPI1W7gn1TsOxu/duznhqj504lV9Dqp+jy6D4j6WpGuIOuQA3HV5q0EW30
         GL7OXPnBN2dSp5WTc9dfufel2MK9NKugDVSUhsGCzB51LMX82larmXflSqvLC3qhwBva
         M8iQ==
X-Gm-Message-State: AO0yUKUSBT0qoPTa76aR+mp6aQgA3R2SH8slp0YVoofri1P147Aoocgf
        R5lRWWIDpH9rEXUlWRgsZSk=
X-Google-Smtp-Source: AK7set+R4ajGY6eMxmTFIQiqgVZm1aR8Le6A9D+3/4ZoQL++6+MxuIvy73S/5XOhYL9XyQcIHEjU9g==
X-Received: by 2002:a05:600c:3d9b:b0:3ea:f6c4:5f28 with SMTP id bi27-20020a05600c3d9b00b003eaf6c45f28mr7938892wmb.36.1677472270859;
        Sun, 26 Feb 2023 20:31:10 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hn6-20020a05600ca38600b003e21f01c426sm7928143wmb.9.2023.02.26.20.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:31:10 -0800 (PST)
Date:   Mon, 27 Feb 2023 07:31:07 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Neal Liu <neal_liu@aspeedtech.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: drivers/crypto/aspeed/aspeed-acry.c:295 aspeed_acry_rsa_ctx_copy()
 error: uninitialized symbol 'idx'.
Message-ID: <202302261052.CVFRyq6F-lkp@intel.com>
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
head:   1ec35eadc3b448c91a6b763371a7073444e95f9d
commit: 2f1cf4e50c956f882c9fc209c7cded832b67b8a3 crypto: aspeed - Add ACRY RSA driver
config: m68k-randconfig-m031-20230226 (https://download.01.org/0day-ci/archive/20230226/202302261052.CVFRyq6F-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302261052.CVFRyq6F-lkp@intel.com/

smatch warnings:
drivers/crypto/aspeed/aspeed-acry.c:295 aspeed_acry_rsa_ctx_copy() error: uninitialized symbol 'idx'.

vim +/idx +295 drivers/crypto/aspeed/aspeed-acry.c

2f1cf4e50c956f Neal Liu 2023-01-04  250  static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
2f1cf4e50c956f Neal Liu 2023-01-04  251  				    const void *xbuf, size_t nbytes,
2f1cf4e50c956f Neal Liu 2023-01-04  252  				    enum aspeed_rsa_key_mode mode)
2f1cf4e50c956f Neal Liu 2023-01-04  253  {
2f1cf4e50c956f Neal Liu 2023-01-04  254  	const u8 *src = xbuf;
2f1cf4e50c956f Neal Liu 2023-01-04  255  	u32 *dw_buf = (u32 *)buf;
2f1cf4e50c956f Neal Liu 2023-01-04  256  	int nbits, ndw;
2f1cf4e50c956f Neal Liu 2023-01-04  257  	int i, j, idx;
2f1cf4e50c956f Neal Liu 2023-01-04  258  	u32 data = 0;
2f1cf4e50c956f Neal Liu 2023-01-04  259  
2f1cf4e50c956f Neal Liu 2023-01-04  260  	ACRY_DBG(acry_dev, "nbytes:%zu, mode:%d\n", nbytes, mode);
2f1cf4e50c956f Neal Liu 2023-01-04  261  
2f1cf4e50c956f Neal Liu 2023-01-04  262  	if (nbytes > ASPEED_ACRY_RSA_MAX_KEY_LEN)
2f1cf4e50c956f Neal Liu 2023-01-04  263  		return -ENOMEM;
2f1cf4e50c956f Neal Liu 2023-01-04  264  
2f1cf4e50c956f Neal Liu 2023-01-04  265  	/* Remove the leading zeros */
2f1cf4e50c956f Neal Liu 2023-01-04  266  	while (nbytes > 0 && src[0] == 0) {
2f1cf4e50c956f Neal Liu 2023-01-04  267  		src++;
2f1cf4e50c956f Neal Liu 2023-01-04  268  		nbytes--;
2f1cf4e50c956f Neal Liu 2023-01-04  269  	}
2f1cf4e50c956f Neal Liu 2023-01-04  270  
2f1cf4e50c956f Neal Liu 2023-01-04  271  	nbits = nbytes * 8;
2f1cf4e50c956f Neal Liu 2023-01-04  272  	if (nbytes > 0)
2f1cf4e50c956f Neal Liu 2023-01-04  273  		nbits -= count_leading_zeros(src[0]) - (BITS_PER_LONG - 8);
2f1cf4e50c956f Neal Liu 2023-01-04  274  
2f1cf4e50c956f Neal Liu 2023-01-04  275  	/* double-world alignment */
2f1cf4e50c956f Neal Liu 2023-01-04  276  	ndw = DIV_ROUND_UP(nbytes, BYTES_PER_DWORD);
2f1cf4e50c956f Neal Liu 2023-01-04  277  
2f1cf4e50c956f Neal Liu 2023-01-04  278  	if (nbytes > 0) {
2f1cf4e50c956f Neal Liu 2023-01-04  279  		i = BYTES_PER_DWORD - nbytes % BYTES_PER_DWORD;
2f1cf4e50c956f Neal Liu 2023-01-04  280  		i %= BYTES_PER_DWORD;
2f1cf4e50c956f Neal Liu 2023-01-04  281  
2f1cf4e50c956f Neal Liu 2023-01-04  282  		for (j = ndw; j > 0; j--) {
2f1cf4e50c956f Neal Liu 2023-01-04  283  			for (; i < BYTES_PER_DWORD; i++) {
2f1cf4e50c956f Neal Liu 2023-01-04  284  				data <<= 8;
2f1cf4e50c956f Neal Liu 2023-01-04  285  				data |= *src++;
2f1cf4e50c956f Neal Liu 2023-01-04  286  			}
2f1cf4e50c956f Neal Liu 2023-01-04  287  
2f1cf4e50c956f Neal Liu 2023-01-04  288  			i = 0;
2f1cf4e50c956f Neal Liu 2023-01-04  289  
2f1cf4e50c956f Neal Liu 2023-01-04  290  			if (mode == ASPEED_RSA_EXP_MODE)
2f1cf4e50c956f Neal Liu 2023-01-04  291  				idx = acry_dev->exp_dw_mapping[j - 1];
2f1cf4e50c956f Neal Liu 2023-01-04  292  			else if (mode == ASPEED_RSA_MOD_MODE)
2f1cf4e50c956f Neal Liu 2023-01-04  293  				idx = acry_dev->mod_dw_mapping[j - 1];

idx not initialized for if it's not EXPR and not MOD.  Just do:
	} else { /* mode == ASPEED_RSA_MOD_MODE */
		idx = acry_dev->mod_dw_mapping[j - 1];
	}

2f1cf4e50c956f Neal Liu 2023-01-04  294  
2f1cf4e50c956f Neal Liu 2023-01-04 @295  			dw_buf[idx] = cpu_to_le32(data);
2f1cf4e50c956f Neal Liu 2023-01-04  296  		}
2f1cf4e50c956f Neal Liu 2023-01-04  297  	}
2f1cf4e50c956f Neal Liu 2023-01-04  298  
2f1cf4e50c956f Neal Liu 2023-01-04  299  	return nbits;
2f1cf4e50c956f Neal Liu 2023-01-04  300  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

