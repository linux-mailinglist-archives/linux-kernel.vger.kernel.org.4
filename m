Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2073661E0CB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKFIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiKFIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:09:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE665F4;
        Sun,  6 Nov 2022 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1667722110;
        bh=psAl4xYsagSw7D6c6rdl/M3zRR70g8jwLLUhLUJBJqU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dRjipgN4EbNkFq7tBqeTvNTbZq7vuPIyMWfkHIgZsw7gMJzKK4kiUBR3G9rHMnurS
         QGKL2HNY2oAD1n6RzRBlbb06JD7Tlj4VyJ6w4qJVL3Ys/tNodMgbXWIDaFEi/ezfrU
         3YI4igH1sDiH6ZEMaAn/dNHdT0Px1K9CemNe0zPc21UDGRGZLVObSzxj2upb5+GMnt
         ZMo/Q6TAVxqwUcSUdgJmKdjoWUl8UNH8oa+mPyf+83Fo4mharKTsCQumreaMe8uG5p
         5dNkn/g+VzXoPRc6sFAR9ID0z99UypA/y68I0EtyaZYR7vIkxvo/IsF1Kx7cpgT4jb
         xUUYWLLZaysqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.79.199] ([80.245.79.199]) by web-mail.gmx.net
 (3c-app-gmx-bap30.server.lan [172.19.172.100]) (via HTTP); Sun, 6 Nov 2022
 09:08:30 +0100
MIME-Version: 1.0
Message-ID: <trinity-f782418a-8148-4eab-93ff-dd213cf05fd0-1667722110396@3c-app-gmx-bap30>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH] dt-bindings: pinctrl: update pcie/pwm/spi bindings
 for MT7986 SoC
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 6 Nov 2022 09:08:30 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <cd2e3ae3-6a30-f6cd-fbbb-9c5c6071fb9b@linaro.org>
References: <20221024074349.7777-1-linux@fw-web.de>
 <cd2e3ae3-6a30-f6cd-fbbb-9c5c6071fb9b@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:fGz1/KhXbeWnAd5zd1PUJkVWwdG90UbiMcUADj/KY9NVZ64iNeWLh5R3z4PuC3tn5idoq
 OnYe9WSqSZCcNF65fbJyQ9TB/5Rv/lsh7lS04dncSEJ0BxhauWps0hrR+aOIcLbKwVQJTXnEwhAk
 k1Psgh39gkWRR5FNMKXX/ZEY2Dky5Lv19AXjUnSlYlwsWqbLErtMJ3jeqbnby66L5mi4bheYRLPg
 9G6LiFiiCdjAxs2sJvG2716qMmzCEtLy6Ckp8vq0eP+4Btj8bhoYp9xIWKJUIu/ij1RD7/+B3E1w
 S4=
UI-OutboundReport: notjunk:1;M01:P0:8nvazYWkGJg=;FwFz1MwnXoUa4YfGZurYexOPqXw
 CxVMnOUfJ2JK0FMvysjx12hyt8/tpoMGfvhBvgTamqfzFMZJJuQ+L+wVR6DjKwbvfEHKVQQi6
 sIUyAQjB7gOrAWm8vnvm+NmcrxbrKQvxOMhhc/9sFBUh7LmAJCsMiTBfnDCQidPhfqDR0Bu/E
 zrlJuXSNon/0KRJ064M0WupyXutK5dqHsx0isz8Qw5IUbiL8lbHu48g/Yzjp4hhefvGp+oqJ3
 6dIVFZ5bebaznflaFKrlB4rZQ6dIrMcPobsY/nAYA637tPKmPiOczFhDaf6m1E5mUl8v7CaH1
 F7Rq0T7wlEb/FUCePeCqKoeu8BX6c0TqL0juWvSECooWzVNrsMcWAq9IWT5sHCwMXuRDKTLOy
 abIIBwOSPjB6mOeflSyy1LXP9S/OMjBQu69MYdtGMVm9gPBXogcmoDOher1FgWhKkOs8Z/4LX
 JCpra3G6xZQ7I2zRWYpPFj6jCwScX41SNw5VSdxIfQolp47QcOMjWIHQhf00LmlzemkUTTqVN
 oGxgQ/fGwnYfcMZx81xbI4GZOB8GmCQzGpYNFcX8yPk1RWFT2xqPJJhyzMmmW3yDvX1R7+jQE
 Mid92tV6aofbLxOxPO1s4NFvNGpoNiVBa4U4fxl+dMyGZmlrQbZiRv9MowJIuHLj4LqFK89he
 5ZCahZLDPUBW/6dyixESHu2pRm0UAHfq5qLKEIM6Zjl1NyKA/W7BS0+V5VDoeFzgInY0iCT5i
 KatrVDjqzJ1jQY07VFVkdCIyOpotJpJCkkZ/Bk1LSYl5U3MbOFZi5+GSwk1VgwpwgAZ23LmOS
 c+CEq0OD9W4n5xIQLcMFs6Ww==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

included this Patch into the pinctl series to have binding checks clean

https://patchwork.kernel.org/project/linux-mediatek/list/?series=692462

regards Frank
