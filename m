Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029B16F3EDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjEBIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjEBIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:12:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59276DD;
        Tue,  2 May 2023 01:12:36 -0700 (PDT)
Received: from [192.168.4.220] ([91.47.48.20]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MbRXj-1qVIpj1Rk1-00bwHO; Tue, 02 May 2023 10:06:22 +0200
Message-ID: <10a2e893-18b6-d9c2-1db7-3d500cc0891c@in-circuit.de>
Date:   Tue, 2 May 2023 10:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 0/2] arm: dts: sunxi: Add ICnova A20 ADB4006 board
 support
Content-Language: de-DE
From:   Ludwig Kormann <ludwig.kormann@in-circuit.de>
To:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andre.przywara@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230420102409.1394618-1-ludwig.kormann@in-circuit.de>
Organization: In-Circuit GmbH
In-Reply-To: <20230420102409.1394618-1-ludwig.kormann@in-circuit.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BZP4xb+RWZ7PqlXjFE/uNSiirW28Q+PM1TXFqzYbS0oaUj9wJdZ
 jD0KwhUB+YexK2scZoHXG2GKeFXakH38VefYWHKtbp0SX1PEcHbzI0nY1nDNLRK4DWMM4oo
 P+x+Uj0ZACMSLSpKCVbThkexaRsCT/aO0+eQVhGJRSvlYj2Le+Miv4AvVZUhdIQIkG7IRdE
 xIUiBQyyaQ9joF/dW8S+Q==
UI-OutboundReport: notjunk:1;M01:P0:MdRMuQvq/c8=;VRnsa4oOgrw0cnDmn+nEh2j5fQr
 pDOXgA/fyya5YU4mfJIFWUOry8IubeHJJRydIxjNs8qNJ6KeguneZ5924Nw+vpehuXEmF9BIe
 +PsXBJ48AqtDbQht20uYsfHnfZJyresWMuSmox2oXW4VkEd+SQwb0Q7bo65W2J8KCMPTPmOSf
 zwYi8c+Z4CeHHGx6iy9lxh+JeNSTs6cTXU2jEVMsfZjFWazQgHDLuGTqrlw/p6Bx19JW8AcT5
 CzJQsc/nv2aB1GxUP1Ply2AR5IoBJa6bruT74S0vc1zLPzJ2wp+9ZC3mC855A8EaAgbjvjNYB
 w8UlQRGpKE7ud4TFLRFdWmVeINKeUgWEuS4M6wkW1rFMWHvG1KejjlEheFGH1eyzgHOtBb98P
 fsauQYofyswOVVGmGd0B4GdMPRFLGaI7SzJgynYvfYBlYin7ehtubq90nnVHyl6RnCcZE67qs
 dJpCI54ecOrpwTvJr+tm/cqshScTpcG3djWbBDxO5nKQ4cJad+Egl7DswWhWJZ511E49Q5jpj
 JcDg8OXp9Q+pVHCQOXIexdQ2Mqh1Jdl29oBJmhsa/DKQdDC8hKl/tghpEme0palYs5V4OLfnC
 xCi7WD2PPfXl7cXncHF2Po78X+wye9CMr+rpI9FxRjdbmMr3ivA+Zw/toZdKBiG3RFf8+cf7K
 pSE+Uq8RH2zMtaYAbArmsvcErgSxW1VQtyQmGxE2vA==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thanks for the reviews so far!

Is there anything I can do / need to do for my patch series for it to 
get merged before -rc1?

The patch series was based on the "for-next" branch in jernej's tree, 
but it seems that it was too late for the "dt-for-6.4" merge.

So I'm just trying to understand in general what the best way in this 
situation would be:
- wait if someone else takes the patch series before -rc1
- wait for -rc1 and rebase, rework, send a new version of the patch 
series (because of the planned restructuring of the ARM dts directory)
- wait for -rc3 (?) and rebase & rework the patch series for jernej's 
tree for the "dt-for-6.5" branch

Thanks for your help.

kind regards
Ludwig Kormann


Am 20.04.23 um 12:24 schrieb Ludwig Kormann:
> Add board support for ICnova A20 SomPi compute module on
> ICnova ADB4006 development board.
>
> v3:
> - drop stray blank lines at end of files
> - separate patch for bindings
> - update licensing to "GPL-2.0 OR MIT"
> - fix typo: ICNova -> ICnova
>
> v2:
> - use short licensing header
> - remove deprecated elements from led nodes
> - disable csi power supply
> - add missing pins in usbphy node
> - split dts into SoM dtsi and carrier board dts
>
> v1 of this patch was sent to the uboot mailing list [1].
>
> [1] https://lists.denx.de/pipermail/u-boot/2023-April/514605.html
>
> Ludwig Kormann (2):
>    dt-bindings: arm: sunxi: add ICnova A20 ADB4006 binding
>    arm: dts: sunxi: Add ICnova A20 ADB4006 board
>
>   .../devicetree/bindings/arm/sunxi.yaml        |   6 +
>   arch/arm/boot/dts/Makefile                    |   1 +
>   .../boot/dts/sun7i-a20-icnova-a20-adb4006.dts | 137 ++++++++++++++++++
>   arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi   |  62 ++++++++
>   4 files changed, 206 insertions(+)
>   create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20-adb4006.dts
>   create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-a20.dtsi
>
