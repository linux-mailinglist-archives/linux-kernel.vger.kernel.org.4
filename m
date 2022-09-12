Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F475B6019
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiILSWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiILSWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:22:47 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5FDCD3;
        Mon, 12 Sep 2022 11:22:45 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CDDBB8455E;
        Mon, 12 Sep 2022 20:22:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1663006962;
        bh=C3UfO7sgLj7nw8J5opt1/M7XAxeFtflzXuG6MeZHKvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rD2CYMJlwQJvspgz4M1VNWmPZNvDx6FvyBOmJofeOo1jG4AcgMMp3VIyzDThWl0lx
         RcMys5VBvO+fwVqZ0zYW6eK6N2UsZw+MnCylsJsi4FRfdwJkzZzbm/LkdoWsmaANGx
         YC1pQR4qWxoOSCRTkUKfZEvwMQmVC9DXF2gO2yN5Dw/jdsAj5pip6R/I63wfwJl+dz
         3v2Z7oTeX4X1WSt9DdH+e9QQ33+1ewD1a9dZ/29zD8fLYBk9UVAOsXkNgm/3i6/bol
         +Hz2medwoewwUmliLrhKu7DpJ9wXq4TP67sDdeD364iB8J96AssjnZsSoxsrlaguLk
         sU9dQIzb/UIlw==
Message-ID: <bde49ca9-6515-63c1-2161-66ab0443fc33@denx.de>
Date:   Mon, 12 Sep 2022 20:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH -next] power: supply: bq25890: Fix enum conversion in
 bq25890_power_supply_set_property()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
References: <20220912141553.1743568-1-nathan@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220912141553.1743568-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 16:15, Nathan Chancellor wrote:
> Clang warns:
> 
>    drivers/power/supply/bq25890_charger.c:625:40: error: implicit conversion from enumeration type 'enum bq25890_fields' to different enumeration type 'enum bq25890_table_ids' [-Werror,-Wenum-conversion]
>                    lval = bq25890_find_idx(val->intval, F_IINLIM);
>                           ~~~~~~~~~~~~~~~~              ^~~~~~~~
>    1 error generated.
> 
> Use the proper value from the right enumerated type, TBL_IINLIM, so
> there is no more implcit conversion. The numerical values of F_IINLIM
> and TBL_IINLIM happen to be the same so there is no change in behavior.
> 
> Fixes: 4a4748f28b0b ("power: supply: bq25890: Add support for setting IINLIM")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1707
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
