Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EF0742BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjF2SFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2SFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:05:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5241BC2;
        Thu, 29 Jun 2023 11:05:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b84c7a2716so5746065ad.3;
        Thu, 29 Jun 2023 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688061915; x=1690653915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0s7Y6s3ecqImGHBgNuM2Qg47pMrGrBaWPSXQdu9G88Q=;
        b=UmYxpupOmyq3QF3ZX/BsCUHU+ey9PJmzsYYl20OSKEH/P5cydGupQX+kaxbKEB51TH
         z/yFCCq1Z+8lvmFtmwkagJUeJo1ba80UNF6e3hyH65R6FT8HsoVktTcZsfeatlD+ADwV
         Uug+F8IGtDGmENg1RxcaWHMbi2qZRdiyWooxmaWOUra5QjfHudaApmzINizOCXl9yGsM
         hABTpJJP90m0b+vSZ0Ov9+xTYlNbGb2T2qFG8hBQIsP+TyLpiWNoi1OlUD7Kjg5H6VsA
         i0UDju70IGtVB+f6Xn79gojPK1rSdTwDncGRgW7i8MhBiMqln0rjTidST6oOuFt6pa7b
         V3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688061915; x=1690653915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0s7Y6s3ecqImGHBgNuM2Qg47pMrGrBaWPSXQdu9G88Q=;
        b=KM07IEfDiYQaMueiaoUMd1Q2z2e4xkDvmJu3awiQf7AcEhda9rnam0qqOMsgOmjnuE
         HmOWSswaJcOo355jSY+HNHzpN/PsLIYKWiHhWZieeq7q1N+7NH71+QpSuMZ3Ukzg1xDf
         qqOKtd5qXgAb4xRtH2vCFUim85mfFBsaWaVHn/GZo0SDMz0tTDUEWnQXsgHKmAJq1YOr
         SnNXEy3LRG4Zt+C0XkxXgsp2NU/R1rZMQ6Vi/EtBkapksTZksd685wEvNSgsw2fMwm1f
         cHkt0AnQRcSGjSWHE3etr9lH4DqIRhCCptx+IrkSKQ6My+H5EbF+SuOQxmjUBa3oK7kh
         LpPA==
X-Gm-Message-State: ABy/qLa3ugPFgNoO5Gu5Mw/r72WW27Vgs+nNN77Oh80ohs8QrpL+qNb2
        KIyCHdVwtrUGDprw4o4eOCoewnLClUE=
X-Google-Smtp-Source: APBJJlEnHYi3SaAC4olf8cGsmuAbGyTsl1ngy3VD/Xca6MDa41a4QVr7zh7WaykkzBsS1xw748Bj5A==
X-Received: by 2002:a17:902:f547:b0:1b8:5406:a34 with SMTP id h7-20020a170902f54700b001b854060a34mr2759621plf.24.1688061915293;
        Thu, 29 Jun 2023 11:05:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001b3d4d74749sm9435115plq.7.2023.06.29.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 11:05:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4959a591-609d-6b94-69a6-ccb92246b0f0@roeck-us.net>
Date:   Thu, 29 Jun 2023 11:05:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs
 attribute
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, Eddie James <eajames@linux.ibm.com>,
        linux-hwmon@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        lakshmiy@us.ibm.com
References: <b12935a2-a8b7-4d70-8c7d-6fd1e92037c2@kadam.mountain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <b12935a2-a8b7-4d70-8c7d-6fd1e92037c2@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 23:53, Dan Carpenter wrote:
> Hi Eddie,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/hwmon-pmbus-acbel-fsg032-Add-firmware-version-debugfs-attribute/20230628-030615
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
> patch link:    https://lore.kernel.org/r/20230627184027.16343-1-eajames%40linux.ibm.com
> patch subject: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs attribute
> config: x86_64-randconfig-m001-20230627 (https://download.01.org/0day-ci/archive/20230628/202306281205.NFXmu7xb-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230628/202306281205.NFXmu7xb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202306281205.NFXmu7xb-lkp@intel.com/
> 
> smatch warnings:
> drivers/hwmon/pmbus/acbel-fsg032.c:36 acbel_fsg032_debugfs_read() warn: argument 4 to %02X specifier has type 'char'
> 
> vim +/char +36 drivers/hwmon/pmbus/acbel-fsg032.c
> 
> d2c6444389b625 Eddie James 2023-06-27  17  static ssize_t acbel_fsg032_debugfs_read(struct file *file, char __user *buf, size_t count,
> d2c6444389b625 Eddie James 2023-06-27  18  					 loff_t *ppos)
> d2c6444389b625 Eddie James 2023-06-27  19  {
> d2c6444389b625 Eddie James 2023-06-27  20  	struct i2c_client *client = file->private_data;
> d2c6444389b625 Eddie James 2023-06-27  21  	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> 
> data should probably be a u8.
> 
> d2c6444389b625 Eddie James 2023-06-27  22  	char out[8];
> d2c6444389b625 Eddie James 2023-06-27  23  	int rc;
> d2c6444389b625 Eddie James 2023-06-27  24  	int i;
> d2c6444389b625 Eddie James 2023-06-27  25
> d2c6444389b625 Eddie James 2023-06-27  26  	rc = pmbus_lock_interruptible(client);
> d2c6444389b625 Eddie James 2023-06-27  27  	if (rc)
> d2c6444389b625 Eddie James 2023-06-27  28  		return rc;
> d2c6444389b625 Eddie James 2023-06-27  29
> d2c6444389b625 Eddie James 2023-06-27  30  	rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, data);
> d2c6444389b625 Eddie James 2023-06-27  31  	pmbus_unlock(client);
> d2c6444389b625 Eddie James 2023-06-27  32  	if (rc < 0)
> d2c6444389b625 Eddie James 2023-06-27  33  		return rc;
> d2c6444389b625 Eddie James 2023-06-27  34
> d2c6444389b625 Eddie James 2023-06-27  35  	for (i = 0; i < rc && i < 3; ++i)
> d2c6444389b625 Eddie James 2023-06-27 @36  		snprintf(&out[i * 2], 3, "%02X", data[i]);
> 
> If data[i] is negative this will print FFFFFFF1 etc.  (This is an x86
> config...  Did we ever merge that patch to make char signed by default?)
> 

That makes me wonder what "%*phN\n" in the updated patch does, as it only passes
'data' as pointer argument.

Either case, no need to resend. I fixed this up when applying it by
declaring data[] as u8. I also dropped the unused variable.

Thanks,
Guenter

