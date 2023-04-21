Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B36EAB64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjDUNT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjDUNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:19:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE21BC673;
        Fri, 21 Apr 2023 06:19:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ec8da7aaf8so1687755e87.2;
        Fri, 21 Apr 2023 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682083162; x=1684675162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IRS7anluXydQHxja6o7heaiNzwN0suh6IrwOE+RxWvU=;
        b=EoMT80WOlRKsImBbG31qLbCV3f47BS7YQ3ysBgGsud01wLp99C3p8WMRILdvgnv3yI
         WCukJYKlZwN1lVesUabg4ZfcmUPv+E2NwxoXohOd8tx0KaQvG0o+TfiQpBSq908QJ0cQ
         B6Dza3OOkfGd1lUvvy1f590294edYbonDaLM00Q2O/q9WcLlgGBpkrYqw5WXWYl7YbPk
         wqqnyHme8I5A80Uzx5v+TJdzgWBTkCHzwnfRki8UX8omrWyS41c2pME+vYe3b1+eJZKv
         ZmSI9DyhHt7Rul1euecVSFqnCuoR7zrALVgKBUlOKAh/AJM++mE0VWMFxWGXPhE6mFk2
         ceYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682083162; x=1684675162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRS7anluXydQHxja6o7heaiNzwN0suh6IrwOE+RxWvU=;
        b=IWshCVBzghRAsadFiSatK45EXab3CLQpm3sT41aD9KXDL+YIs2ZGT1fPz9DtOun92P
         8z4djzdlyEJIksPN6p3yABHKl40q8A6OLmEyWAT6OeeDhsxxbcrkbm6sl+K8/8Zj5YB/
         M2RTQn+9ijL0YEKIssFKHVpa3HKtZL5J4kQTN0SgIaC37/qwOkNEvz80YLBnN17rhCkJ
         yewlPeIX+6foPh24mwqRyhDWRwmk9AJfB24jCnRFaiKKYmz6wqv9Dmex40s9wc+fBbQq
         Ws+aMQ/KsgkyMA8MhCnfO8TJjgOOM6cfOJTTWMsJKsbJEbVxLsQck8Fb2HDWO1bZtxk7
         3AdQ==
X-Gm-Message-State: AAQBX9cqgDHVTAOmLjMNSddZ1LvNl7y/3EAFImp6hwB02zhGJylLbEbP
        MSUOFmfQRdlyFmD++lrSerAa8NGGBiE=
X-Google-Smtp-Source: AKy350Z5mkQeZ07tFeLRvRbrfXcaVCylGPbN81BbX1r3vnBbDZ4bqkyYkasyKhvd4d59J/B8ZWsUwg==
X-Received: by 2002:ac2:4a8c:0:b0:4eb:982:adf with SMTP id l12-20020ac24a8c000000b004eb09820adfmr1315591lfp.26.1682083161761;
        Fri, 21 Apr 2023 06:19:21 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ec8b5891e2sm553403lfq.226.2023.04.21.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 06:19:21 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:19:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: Multiple undefined configuration options are dependent in
 Kconfig under the v6.3-rc4 drivers directory
Message-ID: <20230421131919.3yy4smvzcrtjbnbu@mobilestation>
References: <bc6c86d.11bb9.1872c5aa2cb.Coremail.sunying@nj.iscas.ac.cn>
 <18c3fbb4-59db-d508-ddd6-080cc8944b39@opensource.wdc.com>
 <20230410232725.zwbccyryboxj3bh5@mobilestation>
 <011B19A8-1276-4603-B4D8-4CA7E9F07B3D@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <011B19A8-1276-4603-B4D8-4CA7E9F07B3D@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 09:18:20AM +0100, Jiaxun Yang wrote:
> 
> 
> > 2023年4月11日 00:40，Serge Semin <fancer.lancer@gmail.com> 写道：
> > 
> > On Thu, Mar 30, 2023 at 07:34:58AM +0900, Damien Le Moal wrote:
> >> On 3/29/23 16:52, 孙滢 wrote:
> >>> It has been discovered that the following configuration options are undefined in the current latest version, v6.3-rc4, yet they are being relied upon by other configuration options in multiple Kconfig files:
> >>> 
> >>> MIPS_BAIKAL_T1 is undefined, used as a 'depends on' condition in multiple files such as drivers/ata/Kconfig, drivers/hwmon/Kconfig, drivers/bus/Kconfig, and drivers/memory/Kconfig.
> >>> MFD_MAX597X is undefined, used as a 'depends on' condition in Kconfig file drivers/regulator/Kconfig.
> >>> MFD_SM5703 is undefined, used as a 'depends on' condition in Kconfig file drivers/regulator/Kconfig.
> >>> ARCH_THUNDERBAY is undefined, used as a 'depends on' condition in Kconfig files drivers/pinctrl/Kconfig and drivers/phy/intel/Kconfig.
> >>> ARCH_BCM4908 is undefined, used as a 'depends on' condition in Kconfig file drivers/leds/blink/Kconfig.
> >>> MFD_TN48M_CPLD is undefined, used as a 'depends on' condition in Kconfig files drivers/gpio/Kconfig and drivers/reset/Kconfig. 
> >>> USB_HSIC_USB3613 is undefined, used as a 'depends on' condition in drivers/staging/greybus/Kconfig and drivers/staging/greybus/arche-platform.c.
> > 
> > Please, don't drop the MIPS_BAIKAL_T1 config. It will be defined and
> > thus utilized after I submit the SoC CSP support to the MIPS arch.
> 

> Hi Serge,
> 
> Is there any special support at MIPS arch level required by Baikal T1?
> 
> I think MIPS32R5 generic kernel should fit your purpose? You can easily add some “workaround”
> under generic kernel framework as well.

Alas there are multiple configs specific to our chip. So the MIPS
generic sub-module won't workout our needs at the current state. I'll
have a better look at it when time comes (whether it's possible to fix
it up somehow) but meanwhile it's better to retain the MIPS_BAIKAL_T1
config in the drivers.

-Serge(y)

> 
> Thanks
> Jiaxun
> 
> 
> 
> 
