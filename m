Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD5706F86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjEQRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEQReo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:34:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75F613E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:34:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso10667435e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684344882; x=1686936882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45ckMM3KNq9UeTwXKcdVUueEtIZIan+RBbBzBSqyF0c=;
        b=qQNzdv/V5iU4YCHC8hZOWE72gHmYGwyGnu9f665Z5OH3jCh0zjv5KWENiTIPALsUPF
         JgcXbwnIoHYsMWrhBNG3Aw93917rhdG6lGA5mfW9B3LnyXMsXqYNnAt4POUkDXTVN8wM
         GjmpQTaUYkCdmUl1K1WXXJdC99uvNCvq3sISXSdTVXE4xl/J9ncNyUayNEax/AMBOxmD
         kcNr4/vgUwpp1R3a/S+ncEe3B3T83xRrJYCQ4BYBHABD+i7JhUgDl36Exl6quQtbn3uU
         h0WJEjp+275rC3xdyniCWE0pCYjMF6Vas9Eqc+QIBaJ1+28P42CaCvf86Y3ODRUh5Si0
         u5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684344882; x=1686936882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45ckMM3KNq9UeTwXKcdVUueEtIZIan+RBbBzBSqyF0c=;
        b=MBtK0ytgnJ33rdTjaEenfLNOxKtAYhvUa9OYreHxeaN0V/CxXeYasTgC1+FQ8yjwe1
         RDWTdBuCC+HZm75A10Qr9t5GSPHsv1DJ4badPLaGZPf/xibDVvvCWmoZX3x7G7vZz8Vq
         YSDZ9SNvjMM9AzkJPHJ+z/t/nz1FJxOZXYflAA4Na53GrLouM26uo2jpzIQxQLtOaoz8
         4XDY3qT6NBtZQ+opdyBJL2gEWfn7LFZYNTHW0N5K266jIwFafVhPTXlR4Nr/PBZZZ+FD
         cP1XfVpekXNWNp+mpnZcSfO2nmPDcFwXb8HpMOn+Ktrl5tE3gWtMowDDcVAvNFFFZHVG
         CV3w==
X-Gm-Message-State: AC+VfDxnDipwwa+X+9oNXisTDQ3QJOdgG0gYi15jSHaghYYnlc5t0jrt
        +yRb8Rkop8yK1KUfJ1MlaLdm3g==
X-Google-Smtp-Source: ACHHUZ5mOfD64msDRSYPeroW5IbEzOp+QER3sRmrxIjX+IMK/isTilhVxkRBB40HND5Y1ez601Iy0w==
X-Received: by 2002:adf:f108:0:b0:306:45ff:b527 with SMTP id r8-20020adff108000000b0030645ffb527mr1244713wro.45.1684344882209;
        Wed, 17 May 2023 10:34:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e5-20020adffc45000000b0030630de6fbdsm3719871wrs.13.2023.05.17.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:34:40 -0700 (PDT)
Date:   Wed, 17 May 2023 20:34:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Mia Lin <mimi05633@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: drivers/rtc/rtc-nct3018y.c:112 nct3018y_get_alarm_mode() error: we
 previously assumed 'alarm_enable' could be null (see line 96)
Message-ID: <6ac4b277-b8ff-4ffa-8786-80f7709155e2@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: 5adbaed16cc63542057627642d2414f603f2db69 rtc: Add NCT3018Y real time clock driver
config: microblaze-randconfig-m031-20230517
compiler: microblaze-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305180042.DEzW1pSd-lkp@intel.com/

smatch warnings:
drivers/rtc/rtc-nct3018y.c:112 nct3018y_get_alarm_mode() error: we previously assumed 'alarm_enable' could be null (see line 96)
drivers/rtc/rtc-nct3018y.c:112 nct3018y_get_alarm_mode() error: we previously assumed 'alarm_flag' could be null (see line 104)

vim +/alarm_enable +112 drivers/rtc/rtc-nct3018y.c

5adbaed16cc635 Mia Lin 2022-07-13   91  static int nct3018y_get_alarm_mode(struct i2c_client *client, unsigned char *alarm_enable,
5adbaed16cc635 Mia Lin 2022-07-13   92  				   unsigned char *alarm_flag)
5adbaed16cc635 Mia Lin 2022-07-13   93  {
5adbaed16cc635 Mia Lin 2022-07-13   94  	int flags;
5adbaed16cc635 Mia Lin 2022-07-13   95  
5adbaed16cc635 Mia Lin 2022-07-13  @96  	if (alarm_enable) {
                                                    ^^^^^^^^^^^^
If these are NULL

5adbaed16cc635 Mia Lin 2022-07-13   97  		dev_dbg(&client->dev, "%s:NCT3018Y_REG_CTRL\n", __func__);
5adbaed16cc635 Mia Lin 2022-07-13   98  		flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
5adbaed16cc635 Mia Lin 2022-07-13   99  		if (flags < 0)
5adbaed16cc635 Mia Lin 2022-07-13  100  			return flags;
5adbaed16cc635 Mia Lin 2022-07-13  101  		*alarm_enable = flags & NCT3018Y_BIT_AIE;
5adbaed16cc635 Mia Lin 2022-07-13  102  	}
5adbaed16cc635 Mia Lin 2022-07-13  103  
5adbaed16cc635 Mia Lin 2022-07-13 @104  	if (alarm_flag) {
                                                    ^^^^^^^^^^

5adbaed16cc635 Mia Lin 2022-07-13  105  		dev_dbg(&client->dev, "%s:NCT3018Y_REG_ST\n", __func__);
5adbaed16cc635 Mia Lin 2022-07-13  106  		flags =  i2c_smbus_read_byte_data(client, NCT3018Y_REG_ST);
5adbaed16cc635 Mia Lin 2022-07-13  107  		if (flags < 0)
5adbaed16cc635 Mia Lin 2022-07-13  108  			return flags;
5adbaed16cc635 Mia Lin 2022-07-13  109  		*alarm_flag = flags & NCT3018Y_BIT_AF;
5adbaed16cc635 Mia Lin 2022-07-13  110  	}
5adbaed16cc635 Mia Lin 2022-07-13  111  
5adbaed16cc635 Mia Lin 2022-07-13 @112  	dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
5adbaed16cc635 Mia Lin 2022-07-13  113  		__func__, *alarm_enable, *alarm_flag);
                                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^
The debug code will crash.

5adbaed16cc635 Mia Lin 2022-07-13  114  
5adbaed16cc635 Mia Lin 2022-07-13  115  	return 0;
5adbaed16cc635 Mia Lin 2022-07-13  116  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

