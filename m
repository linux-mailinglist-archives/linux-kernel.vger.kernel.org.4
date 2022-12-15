Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4720064D9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLOKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiLOKjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:39:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1434C2C66B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:39:34 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6AD676602C5F;
        Thu, 15 Dec 2022 10:39:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671100772;
        bh=2bISjDNevUUXA/pacloGgIUfL2hLr+aw4OOKkXlr8iE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XRpz5tw1x65KWU/KAlTdp5EWKfZ4eFoAPYH9kFW+pITcrqhQKuSqDNTlP2fp6TYsv
         oKecz4t5Inp13m3YW7nAJrHOv/6c7tkERM2XwANpjnhWQ3N/Dz7JfEEbPRhNMbjq0T
         C8TBaF4JRAjANmA/w7lSLzWKk0/buSA1+r/MGjQx+bkt01hqYQUCMU/oyR97YMJIn9
         MT1LntRa8Kw3VyIgC+sIkkha2GjRABTuvRy1li5lhfktexi1OSBK0pfJ2/6hS0kwzF
         sNEDU7+eVNo8YOdEHn1T6mg9VrUqoMqfJdnB0EfV4rAHRe3hEdlbDvMOc2OZaHoM91
         hgwN+Tnd0Eesg==
Message-ID: <9f1e3b06-dc7c-0d82-d7e0-ab7aa5837b20@collabora.com>
Date:   Thu, 15 Dec 2022 11:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCHv2 1/1] ARM: improve Cortex A8/A9 errata help text
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20221214175327.57703-1-sebastian.reichel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221214175327.57703-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/12/22 18:53, Sebastian Reichel ha scritto:
> Docuemnt that !ARCH_MULTIPLATFORM is necessary because accessing
> the the errata workaround registers may not work in non-secure
> mode and mention that these erratas should be applied by the
> bootloader instead.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Followed the discussion... adding this information makes a lot of sense
and it's definitely helpful for developers (especially when some platform
encounters *strange* issues..)

So,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!
