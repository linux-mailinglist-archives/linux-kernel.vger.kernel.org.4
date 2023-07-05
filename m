Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48CA747CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGEGVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjGEGVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:21:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D37910E3;
        Tue,  4 Jul 2023 23:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 754A06143D;
        Wed,  5 Jul 2023 06:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03CFC433C7;
        Wed,  5 Jul 2023 06:21:29 +0000 (UTC)
Message-ID: <cd9bcc6d-dc69-cd25-d621-d97a7ba2866d@xs4all.nl>
Date:   Wed, 5 Jul 2023 08:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] drivers: media: remove duplicate assignments
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230705044750.8498-1-duminjie@vivo.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230705044750.8498-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 06:47, Minjie Du wrote:
> make second_timeout avoid double assignment.

Please post a v2 where you mention the driver name in the subject.

"drivers: media:" suggests a patch touching on many media drivers instead
of just a single driver.

Regards,

	Hans

> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/media/pci/saa7164/saa7164-fw.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/pci/saa7164/saa7164-fw.c b/drivers/media/pci/saa7164/saa7164-fw.c
> index 363689484..cc9f384f7 100644
> --- a/drivers/media/pci/saa7164/saa7164-fw.c
> +++ b/drivers/media/pci/saa7164/saa7164-fw.c
> @@ -271,7 +271,6 @@ int saa7164_downloadfirmware(struct saa7164_dev *dev)
>  			dprintk(DBGLVL_FW, "%s() Loader 1 has loaded.\n",
>  				__func__);
>  			first_timeout = SAA_DEVICE_TIMEOUT;
> -			second_timeout = 60 * SAA_DEVICE_TIMEOUT;
>  			second_timeout = 100;
>  
>  			err_flags = saa7164_readl(SAA_SECONDSTAGEERROR_FLAGS);

