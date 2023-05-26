Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E89712511
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbjEZKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEZKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:51:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF2112F;
        Fri, 26 May 2023 03:51:50 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.155.11.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D17536606E8C;
        Fri, 26 May 2023 11:51:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685098309;
        bh=25IdnsoBomm8pRGogc2Xz7W22mTw/rEiJsCH39mngqY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=jXnv2FLeQGGjLrTssH4ubFd/LbZYXgyLC05u/sRpVByDJEzolWTPNQKUjFDfzcHq+
         mSOlShqPqaVn2nv+wwXOj6Ls71t5DMysmVzHjhalFQrjB9S9xJlKXXryAuMR+r+LlW
         ZquflhOY5U++/7JyOQzfhXEUQfZ3UZTz6lX0cyQ5v2zOg1YP3Z4ZM97FOUGhN68EvR
         9whi7M5pC8z5x6X2bXma0cRx/Q2ApBME+UGL+io8eXkqARYy0xIoKRr0VTZdwhSnR5
         gkS0kf/HnkyvsJM6eJzxLdGabDtjKNZwg799sDzCyuXVHfSi/5dCMVXP2D1TWEaypE
         Bh3ajL8nIIv2Q==
Message-ID: <88033d6a-b1d6-a77d-cab7-1401d97ae8e2@collabora.com>
Date:   Fri, 26 May 2023 15:51:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com> <YvUaEDMbZD70x+hD@kroah.com>
 <Yyxd0BJw5syjVsvm@paasikivi.fi.intel.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Yyxd0BJw5syjVsvm@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 9/22/22 6:06 PM, Sakari Ailus wrote:
> Hi Greg, others,
> 
> On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
>> On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
>>> For the time being, I agree with your recommendation to not buy these
>>> devices if you care about camera support.
>>
>> I second this, don't buy these devices if the vendor is not willing to
>> get their drivers upstreamed properly.
> 
> I can now confirm that IPU6 driver upstreaming is now planned, with IPU6
> input system driver to be upstreamed first. The intent is that we would
> have patches for review on LMML around the end of the year.
Is there any update on IPU6 driver? Probably it hasn't been sent upstream yet?

> 
> The processing system driver will need more work to replace the custom
> interface. For a fully functional camera stack, also libcamera support for
> IPU6 will be needed.
> 
> I think I can say a major factor for why we're here is that the original
> intent was to use a different interface for upstream but as we don't have
> one yet and probably won't for quite some time, this doesn't really seem
> like a viable option anymore.
> 
> So I'm afraid I can't promise a quick fix but at the same time I can say
> work is being done to address this.
> 

-- 
BR,
Muhammad Usama Anjum
