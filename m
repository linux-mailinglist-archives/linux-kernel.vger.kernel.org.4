Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06AC6BF144
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCQS7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQS73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:59:29 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894C580F4;
        Fri, 17 Mar 2023 11:59:05 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id t129so2714824iof.12;
        Fri, 17 Mar 2023 11:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0TbDdQ3QLlUV3UCI/G6yBl8lRtCcpf5R7Q9zzKErgQ=;
        b=8HjTlez1Kl1jSYo8WcaqMB2y3aAiMmqhloEQSgsOcYe0XELRLNcZhNQ9DCU3eQ/nT8
         4e+D1F16ZW3NEnJVRSAmWBRh8S8Lq8Ya2Y2P5AHC9k9z6xdb14XXnYBoBW4LLUv2s9Be
         9p1BiG3WHSk/MenKrPGKQTqlmtxmy0wUxtd73EWpjRjUQVStdf/f/kc1DG6Crnj88mk6
         au0e0iOrxn2k/SUKPyvZ4JauxevCvpJOzIRU6lVGHqIhKy/Txcw3qyts+jVNwTJkZet6
         Q09wT/3T71EH7gbBzqOp474xCfIR4yNJHDw1+aKaBMA+d+7L1JYtwovTqXCWNqNs4F3i
         j5cw==
X-Gm-Message-State: AO0yUKX581M9b56oQgxqpSji/KYyZqYXZYbLCbBsAP/EiJxxMzMDqhLV
        RCW/SQqXyzxotmK8OOJc5A==
X-Google-Smtp-Source: AK7set/VqFzGMnKynkjAkFXNOkx24rXWwGo/c6U7j30ey6ipT3ryl914aNf7a7OJ/zVMZdHG52Pb+Q==
X-Received: by 2002:a5d:8994:0:b0:752:2f97:80bb with SMTP id m20-20020a5d8994000000b007522f9780bbmr310121iol.19.1679079492785;
        Fri, 17 Mar 2023 11:58:12 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a22-20020a6b6616000000b007530bbfa577sm740911ioc.18.2023.03.17.11.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:58:12 -0700 (PDT)
Received: (nullmailer pid 2624114 invoked by uid 1000);
        Fri, 17 Mar 2023 18:58:10 -0000
Date:   Fri, 17 Mar 2023 13:58:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 09/21] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
Message-ID: <20230317185810.GA2619692-robh@kernel.org>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-10-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313205921.35342-10-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:59:09PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Rename schemas of pin controllers for MediaTek MT7620 and MT7621 SoCs to be
> on par with other pin controllers for MediaTek SoCs.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> 
> I'm not changing the compatible string. I asked if it's accepted to do this
> whilst keeping the compatible string but haven't received a response.

It's fine with me though I'd somewhat rather keep the filename matching 
the compatible. Either way:

Reviewed-by: Rob Herring <robh@kernel.org>
