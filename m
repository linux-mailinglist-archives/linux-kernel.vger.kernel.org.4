Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D8671BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjARMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjARMQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:16:31 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B5355A3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:39:33 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mzhf5-1oVDME2ySf-00vh3u; Wed, 18 Jan 2023 12:38:55 +0100
Message-ID: <3a69e1fc-c266-d75c-32e3-9b5f655a8258@i2se.com>
Date:   Wed, 18 Jan 2023 12:38:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: vchiq_arm: fix enum vchiq_status return types
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Adrien Thierry <athierry@redhat.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230117163957.1109872-1-arnd@kernel.org>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230117163957.1109872-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bE+E8XE68j3zl+0fnDlSb98h/UaHtTjyymUHTNvgiGdds9/oltj
 918u4SKlyhsiJibaNHwYuxy3fZvzWrx3UNut1u/M9TsZ42R/k/83eG9AsXRVdX6/ZTrccG3
 z2sgl1HmAd4NMGEgbecVuY4jULanL8MF2J5WJHOprpRxPPGxVk9zGHe+5l7VpuahxAfHEB7
 dHXjCfk9jK84ja9DT/GrA==
UI-OutboundReport: notjunk:1;M01:P0:0ZAPRhgUbRg=;qisLkRvOSeHwlorjvSv8FYvYoQN
 CzDnOGUE5PEtR6kInxGeFhJocuOxslMAf2YExgCG6xmz6IYaW2KcQsnJbUil6zvp+Zb//tS5q
 cymXyGSVn6hb1TDbfWgTf7kKOk2vkc/1hsZcPzm+NI/G8z4sAbe1nSIt1g1/hjTOkEikBpov9
 62Q5/xEcDwM0tmC32apXiBdGyJUXbUQZxrhbbuNwskIU3Yh63e8b08ysO2tbrOA6NWntI/qBV
 1yh/e/y7HtxAMrKPm5yQSleq9KdBXfXeGjgh9E4MMPt5twduG1Co7Xvo2ZlnYAM4amiK2hM8f
 emSOxkyl5RxuPOs62ZKxFITNdeeN5+lRxgzdWSUtYTu2QPZ+NDjVpdIpvZVenmofe3GIS5qxU
 kiKl6T64oKh0hNoV8urMHvr44H/8V9DDR7SRW/S2pSmhupuSUj11SJ/JK8DRukFBvOAPE70C6
 lOW0pINql7g0WLS5Uk0bcDDYaNMQO/hPJwRwlKVXd1/maoijSy+9PrI1F+0VJF1GdPWsUf7lc
 YRUQRxrmyvCVRsvdL9J1vd7T+QhHoXTeojno2HwverFkzB24wrXo3jyYfhteolbzxdH3MGmQA
 7/K4ASA+EPstCUArQ6GpkZm1XghG6YIagARRrUASgd0QpBJRC+PATrR3lfDuwZwSVuUSrfHRR
 oOYBiZU4dinYwluedNOwRbl5reTnS43mwH1NAAWUVA==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Am 17.01.23 um 17:39 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc-13 notices a type mismatch between function declaration
> and definition for a few functions that have been converted
> from returning vchiq specific status values to regular error
> codes:
>
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:662:5: error: conflicting types for 'vchiq_initialise' due to enum/integer mismatch; have 'int(struct vchiq_instance **)' [-Werror=enum-int-mismatch]
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1411:1: error: conflicting types for 'vchiq_use_internal' due to enum/integer mismatch; have 'int(struct vchiq_state *, struct vchiq_service *, enum USE_TYPE_E)' [-Werror=enum-int-mismatch]
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1468:1: error: conflicting types for 'vchiq_release_internal' due to enum/integer mismatch; have 'int(struct vchiq_state *, struct vchiq_service *)' [-Werror=enum-int-mismatch]
>
> Change the declarations to match the actual function definition.
>
> Fixes: a9fbd828be7f ("staging: vchiq_arm: drop enum vchiq_status from vchiq_*_internal")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

thanks for fixing this.

Greg applied a series [1] from Umang which completely removes this enum 
completely. This series has been applied to today and will likely cause 
a conflict tomorrow in linux-next.

[1] - 
https://lore.kernel.org/linux-arm-kernel/ba52e6b4-33ec-622e-00b6-1b098f529a90@ideasonboard.com/T/

> ---
>   .../staging/vc04_services/include/linux/raspberrypi/vchiq.h   | 2 +-
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> index db1441c0cc66..690ab7165b2c 100644
> --- a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> +++ b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> @@ -86,7 +86,7 @@ struct vchiq_service_params_kernel {
>   
>   struct vchiq_instance;
>   
> -extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
> +extern int vchiq_initialise(struct vchiq_instance **pinstance);
>   extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
>   extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
>   extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
> index 2851ef6b9cd0..cd20eb18f275 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
> @@ -100,10 +100,10 @@ vchiq_dump_platform_use_state(struct vchiq_state *state);
>   extern void
>   vchiq_dump_service_use_state(struct vchiq_state *state);
>   
> -extern enum vchiq_status
> +extern int
>   vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
>   		   enum USE_TYPE_E use_type);
> -extern enum vchiq_status
> +extern int
>   vchiq_release_internal(struct vchiq_state *state,
>   		       struct vchiq_service *service);
>   
