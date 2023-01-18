Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649AF6724E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjARR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjARR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:29:44 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8FB21A0D;
        Wed, 18 Jan 2023 09:29:41 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MzTCy-1oW1VW1Hhg-00vQLu; Wed, 18 Jan 2023 18:29:26 +0100
Message-ID: <89377474-bcd4-452a-973f-dd5092dea4d6@i2se.com>
Date:   Wed, 18 Jan 2023 18:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/4] staging: vc04_services: vchiq_core: Drop custom
 logging
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20230118115810.21979-1-umang.jain@ideasonboard.com>
 <20230118115810.21979-2-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230118115810.21979-2-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:c9i/D17w64yXKdNX4GYL2ssWp34kom0i30U5afG6wwqxgpXdqhi
 1rIOQKRsuPAZltULVkvkcj+vsAfhnmYBXEXOZH1R8xJnLDv1X1Pk1U33zSBx8cqfgu7dth1
 Pijywyamf+gBZJDuCT0uYu10sfEr20Us0TzrMZwU4xSvw6PDOzjxg1q0eqisTejQAL2yYA5
 vijcLbazpZcrg6NzG8jMg==
UI-OutboundReport: notjunk:1;M01:P0:2/yHPKPMUzY=;AX4aNqWm+UcOr38RvvoFo4+LBaH
 5i03g5b1GY2b81uiDhYPcXzdSilZwjHjPwz/me18F3l0rzllt9vPIM5p/RoZlzcGGUQ6lRlHJ
 olfjLnxM0quAeM0w/cVZpQiDSSjQAm91cNhCWXMMIWmtGgwgzAp0VE6tB41Q4wi7nZnY6r3nj
 cPuGqeb3Voq6FI1kfocQ7D6NajcY5qYIeapk84MItCEKJ9npkPc8WcdTEEt7c1s7z5ULWxBS7
 i7M6ViDenl3bzSyvOUz8yASQ0Wux4H384miofvAmzuvNNcFD+74haLUNet4D4ee4JllHrEcb+
 SJ9nZuC8e9jss7N1L5+y7gJTY1nIdgtPgm7cPnfUY3mpebBWUMjtfsMJ6Joio/U+8txyPEFub
 uAi1OmWb9XoCb+ywifWTfxbtEvTliSK5d4FAima5iy2INq+i/3dPju0KCiUvg9Qc2LpBIIuXe
 Cjejg1XyZw/IuF39Y4GZwB2GRzlAcvEN1gwm/eUgtBZi9DNavwV74KA3z14OMLJwfClWNmLpZ
 HAQj8VlnonAiyuJE94UEkxCzSYpp/OGVfN8uQ6WE4hQ9jgXbom8XVOk5cwlykbX3qrI6UUWB5
 dLoitT5DV1EdGkFS5dCymtzgi75DYHJHBF1mBeAANqDwCovagkyGIe91JqUvNKiDsQX3+nCXC
 45WB38MByLX6amyJ8+gMsNc/2MuR+Mp7UefeSgoLSg==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 18.01.23 um 12:58 schrieb Umang Jain:
> Drop custom logging from the vchiq_core.c and use standard kernel
> logging infrastructure (dev_dbg() and friends for struct Device
> stuff) and pr_info (and similar) for vchiq_services/instances things.
i'm sorry but your "staging: vc04_services: vchiq: Register devices with 
a custom bus_type" is still in my backlog. I was busy with some 
regressions on bcm2835/bcm2711.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../interface/vchiq_arm/vchiq_core.c          | 450 ++++++++----------
>   1 file changed, 204 insertions(+), 246 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 4e705a447a62..7b3c57326d28 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -227,10 +227,11 @@ static const char *msg_type_str(unsigned int msg_type)
>   static inline void
>   set_service_state(struct vchiq_service *service, int newstate)
>   {
> -	vchiq_log_info(vchiq_core_log_level, "%d: srv:%d %s->%s",
> -		       service->state->id, service->localport,
> -		       srvstate_names[service->srvstate],
> -		       srvstate_names[newstate]);
> +	struct vchiq_state *state = service->state;
> +
> +	dev_info(state->dev, "%d: srv:%d %s->%s", state->id,
> +		 service->localport, srvstate_names[service->srvstate],
> +		 srvstate_names[newstate]);
>   	service->srvstate = newstate;
>   }
>   
> @@ -255,8 +256,7 @@ find_service_by_handle(struct vchiq_instance *instance, unsigned int handle)
>   		return service;
>   	}
>   	rcu_read_unlock();
> -	vchiq_log_info(vchiq_core_log_level,
> -		       "Invalid service handle 0x%x", handle);
> +	pr_info("vchiq: Invalid service handle 0x%x", handle);

Some log levels like this here doesn't make sense. I would expect here a 
warning or an error. Could you please have look at it in a separate patch?

Thanks

