Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40E5723FCE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbjFFKlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbjFFKkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5AB10F8;
        Tue,  6 Jun 2023 03:38:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9605762772;
        Tue,  6 Jun 2023 10:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D7DC433EF;
        Tue,  6 Jun 2023 10:37:55 +0000 (UTC)
Message-ID: <c4676e35-322c-7091-65d0-4e50ba04ca85@xs4all.nl>
Date:   Tue, 6 Jun 2023 12:37:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 3/7] dt-bindings: arm: nuvoton: Add NPCM GFXI
Content-Language: en-US
To:     Kun-Fa Lin <milkfafa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mchehab@kernel.org, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrzej.p@collabora.com,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
References: <20230207091902.2512905-1-milkfafa@gmail.com>
 <20230207091902.2512905-4-milkfafa@gmail.com>
 <867ec517-ef29-e8ac-8e0c-6f7ca440cf3d@linaro.org>
 <CADnNmFpf8kMeHYrUcab5Mg3P0zZ=kUi3o8bLCz-EdyAHVKoLNw@mail.gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CADnNmFpf8kMeHYrUcab5Mg3P0zZ=kUi3o8bLCz-EdyAHVKoLNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 01:40, Kun-Fa Lin wrote:
> Hi Krzysztof,
> 
> Thank you for the review.
> 
>>>  .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 39 +++++++++++++++++++
>>
>> This is still wrong location. arm is only for top-level pieces. You
>> wanted to put it in soc.
> 
> I'll move it to Documentation/devicetree/bindings/soc/npcm/nuvoton,gfxi.yaml.

v12 still has this in the old location, so it appears you forgot this.

Regards,

	Hans

> 
> Regards,
> Marvin

