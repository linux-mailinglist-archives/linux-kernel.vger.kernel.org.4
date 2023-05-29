Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBC2714781
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjE2JzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjE2Jy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:54:56 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3CA4;
        Mon, 29 May 2023 02:54:55 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1EC8885727;
        Mon, 29 May 2023 11:54:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685354094;
        bh=9GUyg9+gt7TVBcEa/jnDJGhoVSQTLctlj2bS4yr1fZY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mIyaKHlWyKDfRge7rpO4RsQnmyhSUWEcSRJY7Fi1gP8w06+cu8xmBDWbLPOeDzS/U
         +Rxtd1qQWyV4rmnUmCnnsst7K60Lgw0CDnehN4+eCmv9Fmi6D0STvSJ5OUR5KniP1d
         oCbvGPJNCLY5P0BamRPTDIR8hd1yNtKFgGlCKF+CmI4sxge1EEZ9N5HmO5P/wXAWou
         oIHnhcQtyIoYoQWOHXDTVCgdVNvRr5/MITRXfNir+a8DLvyBRXarvucXBPg5PrAKfH
         uU4CpcV8SFsQqI0s95yjCf/eAjEuX4h8CO0WJhVAFHv06gfO35PxuUmZfjA/3pOBHi
         4Rc9MkON9wEOw==
Message-ID: <f5b83a37-f448-64e5-1d7a-b297106ce22a@denx.de>
Date:   Mon, 29 May 2023 11:54:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/4] ARM: dts: stm32: fix ltdc warnings in stm32mp15
 boards
Content-Language: en-US
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230529091359.71987-1-raphael.gallais-pou@foss.st.com>
 <20230529091359.71987-5-raphael.gallais-pou@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230529091359.71987-5-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 11:13, Raphael Gallais-Pou wrote:
> Those concern:
>    * "#size-cells" and "#address-cells" wrongly used
>    * residual "reg" property appearing on endpoints where it could be
>      avoided
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Reviewed-by: Marek Vasut <marex@denx.de>
