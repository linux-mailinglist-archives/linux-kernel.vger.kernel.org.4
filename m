Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F0653EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiLVLIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLVLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:08:33 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB33B861;
        Thu, 22 Dec 2022 03:08:32 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.22]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MacjC-1obzTr3ClG-00c7RZ; Thu, 22 Dec 2022 12:07:57 +0100
Message-ID: <8fcbdf54-98ae-6a06-ecaf-591a43b863a1@i2se.com>
Date:   Thu, 22 Dec 2022 12:07:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/7] vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage
 on disconnect
To:     Umang Jain <umang.jain@ideasonboard.com>,
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
References: <20221219115725.11992-1-umang.jain@ideasonboard.com>
 <20221219115725.11992-6-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20221219115725.11992-6-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ow/FZUP+RKjclWSiCtRIaLt7Bf7HqGbYjZOp9iWu0B/tP44u6ME
 OX1XZE9IOt7yjDKIPhox6tUfd0mvsbzBdeWXUEW/FbnRnRxlJfokQTdRyRkQzuZ1AD4HeWJ
 K58g7bsv6D8irvrrvSRSKMg3qyUYEfgfm6oNVudouzpxtRouV+smCpSQNQY7H+oYTgUAtiR
 RrZiVOK9YBcABgjeNjUeQ==
UI-OutboundReport: notjunk:1;M01:P0:NIzVU/U6y2I=;ntISWqAzkY8Sol7nfKIpq0ArtHF
 OEAUdqhoO0+ln1uLQUUV3BATXP8NI6raoZsgxFYp+8KNkADoltuBDozq3eKQeXkUlBW2qC5VU
 uB3oCBgUsGDG2O3HwXYGuGBRmIRnyAkWaJxIZSS/ymtzKC/qCzQ3XXc8TqtIQekj/S64/hQzu
 54/yrdQaUV6bF8mqgLii3khsYhTNvDwFeb1ByMP1+E9lodGgwGThuSkOFgYQPcS663BranzzU
 Ep1tPlUdS6xSto7F8EIB06WCxFtawf8Nx/r25qHt+UYvPBlnUhpnYOqYlQNeta95tPcHujcSM
 H5VbOCuLb9CypWEwWD+tRTOXjCHmSRb8tvVrw4QIcYabNQl8MjhmH0CCRP6EGc2zKhCZSklQ2
 M0sGAYJrM76ib/yynCXJETnVXdxbsb7ig2fre1JITN1VZ5C4faTIiGIiY+98WU3cjxTKcQ0tE
 YBjrV+UJhFzuIya03PSxLZ7frSZ+M5Xj/mmbVB2xXSRZOUhVbSLWBKiMzkK6e6kG79bDJCZ90
 qG9rS/oIHZ2P0Vlt7QQdLHgnwRY7NCvDS9wH1v3s9o1JVUV/Vwh6MQZMgfKPWaKFNdwQWokCj
 G9Mb3NuCb+FoCBmjqP6kDso00Hjxa+k2buzqwOTCaEeG+3yWfoDKk0zNssHgXWdE9WHhcTYGw
 zg5RMBsY2e4q2EhQXd9BHVpIBxyXASfZurv9QlOwWw==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 19.12.22 um 12:57 schrieb Umang Jain:
> Drop the usage of VCHIQ_RETRY when the vchiq has connection status
> VCHIQ_CONNSTATE_DISCONNECTED. Disconnected status will not be valid to
> carry on a retry, replace the VCHIQ_RETRY with -ENOTCONN.
>
> This patch removes the usage of vCHIQ_RETRY completely and act as
> intermediatory to address the TODO item:
> 	* Get rid of custom function return values
> for vc04_services/interface.
>
> Fixes: 71bad7f08641 ("staging: add bcm2708 vchiq driver")
please drop this fixes tag since this commit doesn't fix a real issue 
and also shouldn't be applied to stable.
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 9c64d5de810e..ddb6d0f4daed 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -3641,7 +3641,7 @@ vchiq_loud_error_footer(void)
>   int vchiq_send_remote_use(struct vchiq_state *state)
>   {
>   	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
> -		return VCHIQ_RETRY;
> +		return -ENOTCONN;
>   
>   	return queue_message(state, NULL, MAKE_REMOTE_USE, NULL, NULL, 0, 0);
>   }
> @@ -3649,7 +3649,7 @@ int vchiq_send_remote_use(struct vchiq_state *state)
>   int vchiq_send_remote_use_active(struct vchiq_state *state)
>   {
>   	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED)
> -		return VCHIQ_RETRY;
> +		return -ENOTCONN;
>   
>   	return queue_message(state, NULL, MAKE_REMOTE_USE_ACTIVE,
>   			     NULL, NULL, 0, 0);
