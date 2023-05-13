Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FDD70164B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbjEMLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjEMLJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1421FF7
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 04:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2788A60B73
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9866C433D2;
        Sat, 13 May 2023 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683976144;
        bh=eZU2toRUsCc05ABHU0WOvkAv0LyPZ4e+alp6zVRLq+4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fXxWU+Dn0+wO2MS66K2cmaXblBkpIeuo8uDydSnSg61pnIqKuZ9a53JssEa0fTtCH
         WzGKH/LnFI9r7aCyOiBX+vv9S+Oh4RrFLtX8hASKP8FuosIKScWZdLHmJXFAZEAX9w
         ouiIvVVVYYK5ZBtF59ZBjuJqA03NQcUSe0aS9nuEIIbRO5hQwbM2JrEB9Rtq/I87il
         NTCZV/DS0JdYk3V0hUmmEyKUj88AShuULxCp5Wcwnaj3npJfPx5ogsDzAeu/Bimgcs
         rfD5LDdsmKA6DyOA/AVOtEMenrw7H5ghx4UG+A807rZ30tKHO6Y9Yi1w6Il9kDv5Dx
         EWxqY6Ny1tAiw==
Message-ID: <168b52bc-830e-f827-10ed-33d5732f4f43@kernel.org>
Date:   Sat, 13 May 2023 13:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: drivers/soc/qcom/icc-bwmon.c:360 bwmon_probe() warn: passing zero
 to 'dev_err_probe'
To:     Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <98e45455-7d5d-48e1-a87e-e0b3a05f1bb0@kili.mountain>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <98e45455-7d5d-48e1-a87e-e0b3a05f1bb0@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 12:14, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9a48d604672220545d209e9996c2a1edbb5637f6
> commit: b9c2ae6cac403dee3195fda9eb28d8ee733b225b soc: qcom: icc-bwmon: Add bandwidth monitoring driver
> config: openrisc-randconfig-m031-20230509 (https://download.01.org/0day-ci/archive/20230513/202305131657.76XeHDjF-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202305131657.76XeHDjF-lkp@intel.com/
> 
> New smatch warnings:
> drivers/soc/qcom/icc-bwmon.c:360 bwmon_probe() warn: passing zero to 'dev_err_probe'
> 
> Old smatch warnings:
> drivers/soc/qcom/icc-bwmon.c:365 bwmon_probe() warn: passing zero to 'dev_err_probe'
> 

Thanks, I'll fix it.

Best regards,
Krzysztof

