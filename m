Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C036794C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjAXKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXKHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:07:06 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5FC12F30;
        Tue, 24 Jan 2023 02:07:03 -0800 (PST)
Received: from [192.168.1.141] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmD6U-1otgns42Vs-00i8Qx; Tue, 24 Jan 2023 11:06:29 +0100
Message-ID: <45528830-d59a-4c8b-5b76-2e683c2c6964@i2se.com>
Date:   Tue, 24 Jan 2023 11:06:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 03/12] dt-bindings: serial: pl011: allow ARM Primecell
 properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230124091602.44027-1-krzysztof.kozlowski@linaro.org>
 <20230124091916.45054-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230124091916.45054-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:93ulo0PlqXqG5/52B3bZ3mfpX/fbI2HdhNtc3AuLxgKQl2dxSyA
 /kJkZ7NeRKreYzG5ax4gsYEQSTwH8yygbh7vEtHYYFwTpBZPdev84Mx3OJaAU1mPR2u2MKv
 vnOjns7+asiWML/aEgPvFrMy3n7cCAB7qWD90wKMTlXMsTG2OvRrP0vJoFgY7ANNIySelYu
 fM48s9RMBQWREZhb7cuBQ==
UI-OutboundReport: notjunk:1;M01:P0:VczEPCxySYQ=;U0Lzc/tH6qc3i8FdF6E0O/w2p33
 Rf11TjOB+akTwm0k3YDF/CofSRH8x/BDseAI/U/Tn594gBt0St1mGo09JEYietjXutJGqAa38
 zaL10VqH0zF7IKZzZ5Z1m08FP08Hku7dGolSylwNAaZ2y1rLGrHYqFyc+M37tlOd4V/KYz/s/
 yPTfVxC1z8FodPfbMSQcVSl+rUIPp/vGCjgLT/ut4XDlL6w+TK7v/HFgJl0sHHVNaieHwS1Ea
 b4NV0O0fSO7293v0aENxUFLcK06FbqeaifKcoESN4aA8zQAFHfrYcQMOIEW282GMu10cwpWFd
 AdBAUt1TOyQGva+5yTnreOJjQuxcR5RsWNwO6OIj7FVzwe8OYZpcfvtzWiyAQPvaNDlZTFXOZ
 4x9WSxOjyQMQo1PyKhAUMTtuQx85DunFFoRMThVzMM/6QUENiZuW9Rcd3PeP5Vnc/bgLd6rbl
 H4jigRxjDGgJuKqrKb5GnE23xpYOgwb8v4NX72tbbq/9P/kyvziwUZFOyeN/pDyt7VDJDlByy
 jZKE/3ERTx1japcd0XrLKLJAhUfA2UrgguOdT1zBQZpe7Nu3Xsa0vJSz07Orp1L8GV41dZTOk
 57XR3M44hao1bm5JYn6UzhqkyhT70Zi3Iy8m3UNpsTcXFBzpT8t7SEoIryrsEG4qXm0djOnTI
 h58bXWDP2g/fsSCP4wz1Hu2KLbYyzj7GsP1bgbwh9Q==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.01.23 um 10:19 schrieb Krzysztof Kozlowski:
> Reference ARM Primecell bindings to allow typical Primecell device node properties:
>
>    broadcom/bcm2711-rpi-400.dtb: serial@7e201000: Unevaluated properties are not allowed ('arm,primecell-periphid' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

