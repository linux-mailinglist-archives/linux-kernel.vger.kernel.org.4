Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB155F8415
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJHHmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJHHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:42:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC854CB9;
        Sat,  8 Oct 2022 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665214934; x=1696750934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1M19IrZ4xTILfMAp70C9Y4qf+AOJN3zmJP4Md3FiyYI=;
  b=cqg9IQwVVg21CNZ/XvIb/+1i2cDN816BjrulNA3w1iS3AYUERJZJFcH7
   wplounLOUi4HLA3KmD8ljWT0H8QMpctwLVQAc2oOBhxTxMuoXY5LZpWg+
   jCw01EVJT73+BfT2OYJfSTc58/VQNGFZj3fwCaUUqSfZExb6xPv/9Evdc
   9JHXBNNIHgy+CYiDP5Ws5J/n5qXTjJwRI7HEbyMURpEHOoUt9sbdgdHyK
   gvy9RZkwZNwepZw2CpRTNIrRTAYubKFivtIHiB3H0F806GeRlgYFf8Dga
   LYcZsrdLd63t34Nm3xVbxPwprepRdUgXvPqzjPoC8ViUUtmPoR4al8hQu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="305498125"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="scan'208";a="305498125"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 00:42:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="954338271"
X-IronPort-AV: E=Sophos;i="5.95,169,1661842800"; 
   d="scan'208";a="954338271"
Received: from zhoufuro-mobl.ccr.corp.intel.com (HELO [10.255.30.218]) ([10.255.30.218])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 00:41:55 -0700
Message-ID: <4cb5e7eb-1571-ed91-e1da-b4223a26f41c@linux.intel.com>
Date:   Sat, 8 Oct 2022 15:41:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
 <YzbePxTF8hRbWNRU@kroah.com>
From:   Zhou Furong <furong.zhou@linux.intel.com>
In-Reply-To: <YzbePxTF8hRbWNRU@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +
>> +/*
>> + * The Linux TTY code does not support dynamic addition of tty derived devices so we need to know
>> + * how many tty devices we might need when space is allocated for the tty device. Since VMs might be
>> + * added/removed dynamically, we need to make sure we have enough allocated.
> 
> Wrap comments at 80 columns please.
> 

checkpatch has extend LINE MAX to 100,do we still suggest wrap to 80?
