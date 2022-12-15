Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2164DC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiLON0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLON0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:26:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C2E16487;
        Thu, 15 Dec 2022 05:26:35 -0800 (PST)
Received: from [IPV6:2401:4900:1f3e:7d24:3f0:3e81:fb16:ab4d] (unknown [IPv6:2401:4900:1f3e:7d24:3f0:3e81:fb16:ab4d])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8CA6F327;
        Thu, 15 Dec 2022 14:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671110794;
        bh=HnKrMknUHi+HOs7MEYvKhXwHku+eB8f9y8CAAYYGjKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lZI889/NbJHCxunwbjm8X/mClzS5rHT8R7Hor5toEc9vMbVD3uNTySZjaQ3UycrpQ
         SjhL5m4vfmHv8VZefATVChzIm2mZqWAir/PSJLx4ZN4vfjRMiype6kF9u2qVULY4iB
         L2qFr67Md1uMn8819/pE7LClnFhZLyYWHx1S3Uu4=
Message-ID: <c20996aa-5c12-4af1-ae0d-838610cfee42@ideasonboard.com>
Date:   Thu, 15 Dec 2022 18:56:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/7] staging: vc04_services: Drop VCHIQ_ERROR usage
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221215065853.34477-1-umang.jain@ideasonboard.com>
 <20221215065853.34477-4-umang.jain@ideasonboard.com>
 <5c963fd9-97c9-d513-a8ae-5d3f22ef57cc@i2se.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <5c963fd9-97c9-d513-a8ae-5d3f22ef57cc@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 12/15/22 5:00 PM, Stefan Wahren wrote:
> Hi Umang,
>
> thanks for taking care of this.
>
> Am 15.12.22 um 07:58 schrieb Umang Jain:
>> Drop the usage of VCHIQ_ERROR vchiq_status enum type. Replace it with
>> -EINVAL to report the error.
>
> I would prefer to use adequate error codes like ENOMEM and so on. I 
> agree simply replacing all VCHIQ_ERROR with -EINVAL is easier, but 
> wasn't the real intention of the TODO item.

I agree with you on that front - I am still trying to understand the 
bits of pieces of the vchiq driver as you can see it's not obvious to me.

I will try to address this is in v2 - after the series a bit more feedback.
>
> The rest of the series looks good to me.

Okay :-)
Thanks for prompt review.
>
> Best regards
>

