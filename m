Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB1E63910D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKYV0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKYV0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:26:36 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A702657E;
        Fri, 25 Nov 2022 13:26:34 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2EB908515A;
        Fri, 25 Nov 2022 22:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669411591;
        bh=U1nRHVQ/fPoMk3HLKaNxEGFr0z4UyO2K4tB07JboXz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MXOS7zwU+38QBevVlcZVaZ+1sO8IrMtcWXKe8yRJU4EEdEQw67uYLKV9d13axuFo1
         avjPEizro9WtGh7+ZHlpJXGEaV7P/gYQpRe+3jyZXgocMeGU4jKA3jcIPzgibtvHHK
         URxmjZ9iXm3Y0iiUVD7vPAF8TH+XSCTRoGdrf7iR+TUdDFTXASrMCcaHej7twTXsWl
         j00EXeBR+aGStZ8AUT2Cw9ks4blCI04Wc4/PB6nIGy0C+a5I5IY2iDokrkdStBE5l4
         SxeDZriKy0CBneGzpEAQ8CTdRqsMIU+CBiBuFEs5wbM6uRsV8+IYZpgzl28eixwcB3
         y0FwlB1evbnyg==
Message-ID: <3f4c89a3-8955-ce41-ac2a-cee9b0ed5210@denx.de>
Date:   Fri, 25 Nov 2022 22:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: leds: Mark label property as deprecated
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        kernel@dh-electronics.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <Y3y/S5COG7VPbsqL@duo.ucw.cz>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <Y3y/S5COG7VPbsqL@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 13:23, Pavel Machek wrote:
> Hi!

Hi,

>> Mark the label property as deprecated as it is mentioned
>> in the description.
> 
> Lets do it the other way around. Functions (etc) don't really provide
> good enough description of LED, and label is still needed.

Can you please provide a clear explanation which property or approach is 
the correct one for new DTs ?

So far, the documentation states that "label" is deprecated, and users 
should replace it with "function" and "color".
