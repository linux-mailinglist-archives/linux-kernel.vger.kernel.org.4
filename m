Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD006D9181
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbjDFI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjDFI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:28:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B118F;
        Thu,  6 Apr 2023 01:27:58 -0700 (PDT)
Received: from [192.168.1.137] (unknown [213.194.153.37])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA0E466031BB;
        Thu,  6 Apr 2023 09:27:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680769677;
        bh=1nBklH4kyqbA31Jsg1oOEp2EERFF+Vrfj/F3mYi+aao=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SruWHcSsbj2C2KnJCzfZlaR0GuuxfeXygXfWBpd9MBjiOmLtj6I620IIvivr6uaII
         gMvxevXHYgyOWJsWq4jV7/Khiu1LlbCpgQzY79qtHaPOtaT7AeEOgjMXwEaSdlY6Gy
         1/cmH67DUFfbzERz3UWOAmuVN4N9GbxHIob+e1VCujylS3HQPOFRFR+Pqxtz+Wq6vc
         +FxYWsdvJC+/IXVt6qnHqmwArtciCpZ0aGaBmZLNlo9qA/pnDo8tIcwcIwSthWtWVJ
         qw91F2H8rvzbFaYDJbZP18MpM3mqQOonkFtPLLoSy7EsEbFpIi9kMRkIhrm149MNPN
         mAUdKmf4qpfpw==
Message-ID: <44556911-e56e-6171-07dd-05cc0e30c732@collabora.com>
Date:   Thu, 6 Apr 2023 10:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] ARM: dts: meson: Fix the UART compatible strings
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
 <20211227180026.4068352-2-martin.blumenstingl@googlemail.com>
 <20230405132900.ci35xji3xbb3igar@rcn-XPS-13-9305>
 <fdffc009-47cf-e88d-5b9e-d6301f7f73f2@leemhuis.info>
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <fdffc009-47cf-e88d-5b9e-d6301f7f73f2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/4/23 19:14, Thorsten Leemhuis wrote:
> Wait, what? A patch (5225e1b87432 ("ARM: dts: meson: Fix the UART
> compatible strings")) that was merged for v5.17-rc4 and is not in the
> list of patches that were in 4.14.312-rc1
> (https://lore.kernel.org/all/20230403140351.636471867@linuxfoundation.org/
> ) is meant to suddenly cause this? How is this possible? Am I totally on
> the wrong track here and misunderstanding something, or is this a
> bisection that went horribly sideways?

I didn't say this was introduced in 4.14.312-rc1, this has been failing
for a long time and it was merged for 4.14.267: https://lwn.net/Articles/884977/

Sorry I wasn't clear before.

Regards,
Ricardo
