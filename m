Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E205F8ED1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 23:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiJIVKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 17:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiJIVKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 17:10:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241238697;
        Sun,  9 Oct 2022 14:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665349471; x=1696885471;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YEYGFGEhRUF1GvIBQpFpZ4vv7/I8t1gr51UudbUv544=;
  b=Bs7jzHJRIvuHHpNEGGD1xeqCUt9TOTEHsqX+75/607+77Vnmzr5KzyMF
   8JJmog56YXTl1O9mnCwoFOykHY6lmiYkCbUT9ErTAspZbZtOUngjoyn8V
   1ZszqJJKBBsdQ+5uA2j+ZhKp89G/9qgZ0HRvLYOuCKV6zxeqhomYFMXIk
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Oct 2022 13:59:23 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 13:59:23 -0700
Received: from [10.110.10.240] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 9 Oct 2022
 13:59:22 -0700
Message-ID: <615493a8-449d-b105-709e-0642dfb5359b@quicinc.com>
Date:   Sun, 9 Oct 2022 13:59:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v4 14/14] tty: gunyah: Add tty console driver for RM
 Console Services
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-15-quic_eberman@quicinc.com>
 <YzbePxTF8hRbWNRU@kroah.com>
 <14d0ff9f-60f3-71cc-ea42-ceee389298ac@quicinc.com>
 <Yz/YBDqqwBUlswgX@kroah.com>
Content-Language: en-US
In-Reply-To: <Yz/YBDqqwBUlswgX@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2022 12:40 AM, Greg Kroah-Hartman wrote:
> On Thu, Oct 06, 2022 at 10:59:51PM -0700, Elliot Berman wrote:
>>
>> "GH" is the shorthand we've been using for "Gunyah". I didn't find
>> documentation for dynamically assigned char devices, but if it exists, I can
>> add entry for ttyGH.
> 
> Why use a new name at all?  Why not stick with the existing tty names
> and device numbers?
> 

I can use hvc framework, although driver-level buffering is needed on
both the get_chars/put_chars paths because:

  - get_chars wants to poll for characters, but Gunyah will push
    characters to Linux
  - put_chars can be called in atomic context in the printk console path.
    Gunyah RM calls can sleep, so we add to buffer and queue work to
    write the characters.

I also chose to use new tty driver because the Gunyah hypervisor call to 
open the console (gh_rm_console_open) can only be done after starting 
the VM. Gunyah will only forward characters sent from the other VM to 
Linux after the gh_rm_console_open call is made. When launching a VM, 
users would want to open console before VM starts so they can get 
startup messages from the VM. I planned to use the carrier_raised() to 
hold tty_port_block_until_ready until the VM is started and the 
gh_rm_console_open() happens.

Thanks,
Elliot
