Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4026C7531
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCXBr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:47:26 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36271A672;
        Thu, 23 Mar 2023 18:47:24 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:f9da:eb9b:68ce:6472] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32O1keId026079-32O1keIe026079
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 24 Mar 2023 09:46:40 +0800
Message-ID: <8271c37c-4995-445c-89b7-90848f7ef3cc@hust.edu.cn>
Date:   Fri, 24 Mar 2023 09:46:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mingxuan Xiang <mx_xiang@hust.edu.cn>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <ZBxy9LYz+JyNW6GY@kroah.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <ZBxy9LYz+JyNW6GY@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/23 23:40, Greg Kroah-Hartman wrote:
> On Thu, Mar 23, 2023 at 05:53:10PM +0800, Mingxuan Xiang wrote:
>> platform_get_irq() no longer returns 0, so there is no
>> need to check whether the return value is 0.
> How did you find this issue?
>
> How was it tested?

Hi Greg,

We found this issue by Smatch. Our team is trying fix some true bugs 
found by Smatch, with the help of Dan.

Since this is a dead code removal, we only do compilation testing.

>
> thanks,
>
> greg k-h
