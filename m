Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB4704827
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjEPIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjEPIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:48:07 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13BAD;
        Tue, 16 May 2023 01:48:05 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A98008471B;
        Tue, 16 May 2023 10:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684226884;
        bh=F3oF8gjPg+wqvMzDvDvZE3E+sKx0iVquzRz+tJ942qU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d/ezhZwzGyy4lxuLZ2fIlLcvq8awSi/jF/kc0z+8adhC4cMo5Z07YMVKYlveM2mN/
         ncDHPNCxQjYxqRaHu0rpKVdi6hA5so66Y3vdMReIWwSXWyILWZ1jDOvjGQHbncCIiJ
         gHVB2JtY4RU19yQrZ9FF2lPWOV2C9j5QS5tzVFBkDp84J6W6G0c8UqSMo7WLgKgKai
         1oHZTJKUbmuoaY6jeBYwJBgidbwzzqQtyYCKOzhZw9rZmjovTB6afA8Ngmw2qR0ey+
         CMnOVnDyZVVGoLpVL4MGhxb20XqOLsWpJvI3dHwSwIof5ay0azvvF1YNIp7TAi8Krj
         mk/Mo5gnMoMig==
Message-ID: <d3d479f0-2f96-74b3-24c0-f8c5df3e1b4a@denx.de>
Date:   Tue, 16 May 2023 10:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: usb: usb251xb: correct swap-dx-lanes type
 to uint32
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Leitner <richard.leitner@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mike.looijmans@topic.nl
References: <20230516083432.18579-1-krzysztof.kozlowski@linaro.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230516083432.18579-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 10:34, Krzysztof Kozlowski wrote:
> The "swap-dx-lanes" was never described as uint8 in original TXT
> bindings and Linux driver expects uint32.  Fix the type to match Linux
> driver expectation.
> 
> Fixes: fff61d4ccf3d ("dt-bindings: usb: usb251xb: Convert to YAML schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
