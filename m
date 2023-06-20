Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB6D736DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjFTNqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjFTNq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:46:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E027AFC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:46:24 -0700 (PDT)
Received: from [192.168.1.108] (unknown [103.86.18.208])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29D7915E9;
        Tue, 20 Jun 2023 15:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687268748;
        bh=210yMTE/YnxmjqCowrx9IHlGko5mFvl1PAVuwmvyK44=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LBM3zWZ209vtCznxpTvPEJjZLirco60wNXT7WM9mOuQLf12r4gtGb/cmZkDyrcSlF
         3apGkQi52fYoT2MLKQBkuDe0s5DjUwJsYX37R7LFnzI0KjGj86uLEWRIGQSxeGS6IZ
         ob5Zjxm2m+Bddsdw6B1y72B3jTLjsyC637NQTEZ0=
Message-ID: <52a40c60-f044-c757-f8fd-241f456fb722@ideasonboard.com>
Date:   Tue, 20 Jun 2023 19:16:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: vchiq_arm: Remove extra struct vchiq_instance
 declaration
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20221221074047.233473-1-umang.jain@ideasonboard.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20221221074047.233473-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Can this be collected please?. The series has two R-b tags and I think 
it got skipped during the last window?

On 12/21/22 1:10 PM, Umang Jain wrote:
> Additional declaration of struct vchiq_instance was introduced in the
> commit 726e79f8a648 ("staging: vchiq_arm: pass vchiq instance to
> service callbacks"). Drop the extra declaration.
>
> Fixes: 726e79f8a648 ("staging: vchiq_arm: pass vchiq instance to service callbacks")
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> index 66965da11443..52e106f117da 100644
> --- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> +++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> @@ -78,8 +78,6 @@ struct vchiq_service_params_kernel {
>   	short version_min;   /* Update for incompatible changes */
>   };
>   
> -struct vchiq_instance;
> -
>   extern int vchiq_initialise(struct vchiq_instance **pinstance);
>   extern int vchiq_shutdown(struct vchiq_instance *instance);
>   extern int vchiq_connect(struct vchiq_instance *instance);

