Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301F564DBFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLONKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLONKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:10:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF32BB25;
        Thu, 15 Dec 2022 05:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC6261CF8;
        Thu, 15 Dec 2022 13:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10104C433EF;
        Thu, 15 Dec 2022 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671109817;
        bh=eXqB5wBx6ldyx3WnmnFI9DbCmJ6qg7OnLYn5htvtC+o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GlJeLrmBOBHAew9fzsQmTrx1TmEuLtTIP+BbFQjFJWSzHlcrjgx98QVTC+pXu2WS/
         UMq7CmEQFnnnLrhvT4oSCXmr35Khx8wQVeeS7LgXQTBGSEVM5hC+4HQIAvDjO/dFeb
         NbwMlCO4T+WBvu78R25apZo47roRd0ES1carQew0q4M5bfSF5SJaMhm9Lwp5NYERyh
         aEmolh2zEyA9ZQTR94CofDW1vR8flsy9hkPL8VQGaLzBYo9ceqVfzWkt+GX0X2Eyud
         xUE4Ls8kILiIZTXA4Hnuv07neG1du0AYbCqbLxJGzjV09eqNUmH0A7JKM+N1907/4G
         MUNF0iC2Y8wPA==
Message-ID: <5a8c636f-b8b4-69d2-344b-66dbcfd2b710@kernel.org>
Date:   Thu, 15 Dec 2022 14:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v14 2/2] dt-bindings: thermal: Add Sunplus schema
To:     Li-hao Kuo <lhjeff911@gmail.com>, rafael@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com
References: <cover.1665990345.git.lhjeff911@gmail.com>
 <038211f33e4d5dd5129712aef2738a83577c7745.1665990345.git.lhjeff911@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <038211f33e4d5dd5129712aef2738a83577c7745.1665990345.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/2022 09:23, Li-hao Kuo wrote:
> Add bindings for Sunplus thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v12:
>  - no change.
> 
> Changes in v13:
>  - no change.

You got comment which you ignored. Stop sending the same while ignoring
feedback.

Best regards,
Krzysztof

