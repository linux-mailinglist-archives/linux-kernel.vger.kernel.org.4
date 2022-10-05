Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311665F4F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJEF6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJEF63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:58:29 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 22:58:23 PDT
Received: from 5.mo576.mail-out.ovh.net (5.mo576.mail-out.ovh.net [46.105.43.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7F44A114
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 22:58:23 -0700 (PDT)
Received: from player756.ha.ovh.net (unknown [10.110.208.62])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id E81B424412
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:43:17 +0000 (UTC)
Received: from milecki.pl (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player756.ha.ovh.net (Postfix) with ESMTPSA id C48D22E82651C;
        Wed,  5 Oct 2022 05:43:09 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-110S004340fc13b-2247-436a-8360-a4b6b64fba82,
                    2DE15A13EDCDDB6B6D72EC5EB2EA3218AD07B46E) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp: 194.187.74.233
Message-ID: <9633ebc4-6c5d-f507-04e7-e61db97e5af4@milecki.pl>
Date:   Wed, 5 Oct 2022 07:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: linux-next: build warnings after merge of the broadcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
References: <20220725095913.31e859ec@canb.auug.org.au>
 <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
 <20220815105419.4df1005b@canb.auug.org.au>
 <20220831091654.45d5ed41@canb.auug.org.au>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <20220831091654.45d5ed41@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1834372427063077656
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeivddgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeefveetfeffgedvudehhfekgeefvdejgfduueffuedthefggeegvdeivefhgeetjeenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdhrmhhilhgvtghkihdrlhhotggrlhenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejheeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeei
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.2022 01:16, Stephen Rothwell wrote:> On Mon, 15 Aug 2022 10:54:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
 >>
 >> On Mon, 25 Jul 2022 12:33:48 +0200 Rafał Miłecki <rafal@milecki.pl> wrote:
 >>>
 >>> On 25.07.2022 01:59, Stephen Rothwell wrote:
 >>>> After merging the broadcom tree, today's linux-next build (arm
 >>>> multi_v7_defconfig) produced these warnings:
 >>>>
 >>>> arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
 >>>> arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
 >>>> arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
 >>>
 >>> This is expected. My commit ef126d3f58d25 ("ARM: dts: BCM5301X: Add
 >>> basic PCI controller properties") reduced following warnings:
 >>>
 >>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'device_type' is a required property
 >>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
 >>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' is a required property
 >>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
 >>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#address-cells' is a required property
 >>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
 >>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#size-cells' is a required property
 >>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
 >>>
 >>>
 >>> down to this one:
 >>>
 >>> arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' is a required property
 >>>           From schema: /lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
 >>>
 >>>
 >>> and basically does the right thing (adds required properties).
 >>>
 >>>
 >>> I'm fully aware "ranges" need to be added (it's mentioned in the commit)
 >>> and it's one of next things on my BCM5301X list.
 >>>
 >>> So while my commits triggers that problem it also reduces warnings so
 >>> I'd say it's acceptable.
 >
 > Not from my point of view:  I was not getting any warnings and now I am
 > getting 254 lines of warnings :-(

Consider verifying / fixing your system setup. This will be long output
but I don't know how else to prove my point.





Testing with the latest Linux code (there are no warnings about missing
"device_type", "#address-cells" and "#size-cells" - I claim that it an
improvement):

[scroll long long to see the rest of e-mail]

$ make ARCH=arm dtbs_check
   SYNC    include/config/auto.conf.cmd
   LINT    Documentation/devicetree/bindings
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
./Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTC_CHK arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: leds: '2ghz', 'all', 'lan', 'power', 'usb2', 'usb3', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: leds: 'logo', 'power', 'usb2', 'usb3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi: gpio-sck: False schema does not allow [[8, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi: gpio-mosi: False schema does not allow [[8, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'usb', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
         ['buffalo,wzr-1166dhp', 'brcm,bcm4708'] is too short
         'buffalo,wzr-1166dhp' is not one of ['asus,rt-ac56u', 'asus,rt-ac68u', 'buffalo,wzr-1750dhp', 'linksys,ea6300-v1', 'linksys,ea6500-v2', 'luxul,xap-1510v1', 'luxul,xwc-1000', 'netgear,r6250v1', 'netgear,r6300v2', 'smartrg,sr400ac', 'brcm,bcm94708']
         'buffalo,wzr-1166dhp' is not one of ['asus,rt-n18u', 'buffalo,wzr-600dhp2', 'buffalo,wzr-900dhp', 'luxul,xap-1410v1', 'luxul,xwr-1200v1', 'tplink,archer-c5-v2']
         'buffalo,wzr-1166dhp' is not one of ['asus,rt-ac87u', 'buffalo,wxr-1900dhp', 'linksys,ea9200', 'netgear,r7000', 'netgear,r8000', 'tplink,archer-c9-v1', 'brcm,bcm94709']
         'buffalo,wzr-1166dhp' is not one of ['asus,rt-ac88u', 'dlink,dir-885l', 'linksys,panamera', 'luxul,abr-4500-v1', 'luxul,xap-1610-v1', 'luxul,xbr-4500-v1', 'luxul,xwc-2000-v1', 'luxul,xwr-3100v1', 'luxul,xwr-3150-v1', 'netgear,r8500', 'phicomm,k3']
         'buffalo,wzr-1166dhp' is not one of ['brcm,bcm953012er', 'brcm,bcm953012hr', 'brcm,bcm953012k']
         'buffalo,wzr-1166dhp' is not one of ['meraki,mr26']
         'buffalo,wzr-1166dhp' is not one of ['meraki,mr32']
         'brcm,bcm47081' was expected
         'brcm,bcm4709' was expected
         'brcm,bcm47094' was expected
         'brcm,bcm53012' was expected
         'brcm,bcm53015' was expected
         'brcm,bcm53016' was expected
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb:0:0: /: failed to match any schema with compatible: ['buffalo,wzr-1166dhp', 'brcm,bcm4708']
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi: gpio-sck: False schema does not allow [[8, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi: gpio-mosi: False schema does not allow [[8, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'usb', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
         ['buffalo,wzr-1166dhp2', 'brcm,bcm4708'] is too short
         'buffalo,wzr-1166dhp2' is not one of ['asus,rt-ac56u', 'asus,rt-ac68u', 'buffalo,wzr-1750dhp', 'linksys,ea6300-v1', 'linksys,ea6500-v2', 'luxul,xap-1510v1', 'luxul,xwc-1000', 'netgear,r6250v1', 'netgear,r6300v2', 'smartrg,sr400ac', 'brcm,bcm94708']
         'buffalo,wzr-1166dhp2' is not one of ['asus,rt-n18u', 'buffalo,wzr-600dhp2', 'buffalo,wzr-900dhp', 'luxul,xap-1410v1', 'luxul,xwr-1200v1', 'tplink,archer-c5-v2']
         'buffalo,wzr-1166dhp2' is not one of ['asus,rt-ac87u', 'buffalo,wxr-1900dhp', 'linksys,ea9200', 'netgear,r7000', 'netgear,r8000', 'tplink,archer-c9-v1', 'brcm,bcm94709']
         'buffalo,wzr-1166dhp2' is not one of ['asus,rt-ac88u', 'dlink,dir-885l', 'linksys,panamera', 'luxul,abr-4500-v1', 'luxul,xap-1610-v1', 'luxul,xbr-4500-v1', 'luxul,xwc-2000-v1', 'luxul,xwr-3100v1', 'luxul,xwr-3150-v1', 'netgear,r8500', 'phicomm,k3']
         'buffalo,wzr-1166dhp2' is not one of ['brcm,bcm953012er', 'brcm,bcm953012hr', 'brcm,bcm953012k']
         'buffalo,wzr-1166dhp2' is not one of ['meraki,mr26']
         'buffalo,wzr-1166dhp2' is not one of ['meraki,mr32']
         'brcm,bcm47081' was expected
         'brcm,bcm4709' was expected
         'brcm,bcm47094' was expected
         'brcm,bcm53012' was expected
         'brcm,bcm53015' was expected
         'brcm,bcm53016' was expected
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb:0:0: /: failed to match any schema with compatible: ['buffalo,wzr-1166dhp2', 'brcm,bcm4708']
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi: gpio-sck: False schema does not allow [[8, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi: gpio-mosi: False schema does not allow [[8, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'usb', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: leds: '2ghz', '5ghz' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 15, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 15, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 0, 0]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 0, 0]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-netgear-r6250.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6250.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: leds: 'logo', 'power0', 'power1', 'usb', 'wireless' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: leds: 'logo', 'power0', 'power1', 'usb', 'wireless' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: leds: 'power-amber', 'power-white', 'status-blue', 'status-green', 'status-red', 'usb2', 'usb3-green', 'usb3-white', 'wan-red', 'wan-white', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: leds: 'lan', 'power', 'usb2', 'usb3', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi: gpio-sck: False schema does not allow [[17, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi: gpio-mosi: False schema does not allow [[17, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi: gpio-sck: False schema does not allow [[16, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi: gpio-mosi: False schema does not allow [[16, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'usb', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: leds: '2ghz', '5ghz' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 15, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 15, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: leds: '2ghz', '5ghz', 'lan1', 'lan2', 'lan3', 'lan4', 'power', 'usb', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[8, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[8, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: leds: '2ghz', '5ghz', 'lan', 'power', 'usb2-port1', 'usb2-port2', 'wan-amber', 'wan-green', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: leds: 'power', 'wan', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: leds: 'power-amber', 'power-white', 'router-amber', 'router-white', 'usb', 'wan-amber', 'wan-white', 'wireless-amber', 'wireless-white' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-netgear-r7000.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r7000.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: leds: '2ghz', '5ghz', 'power-amber', 'power-white', 'usb2', 'usb3', 'wireless', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-netgear-r8000.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
   also defined at arch/arm/boot/dts/bcm4709-netgear-r8000.dts:129.8-144.3
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
   also defined at arch/arm/boot/dts/bcm4709-netgear-r8000.dts:146.8-175.3
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-netgear-r8000.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: leds: '2ghz', '5ghz-1', '5ghz-2', 'power-amber', 'power-white', 'usb2', 'usb3', 'wan-amber', 'wan-white', 'wireless', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: leds: '2ghz', '5ghz', 'lan', 'power', 'usb2', 'usb3', 'wan-amber', 'wan-blue', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: ethernet-switch@18007000: ports:port@7: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('dsa,member', 'ports' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: leds: 'lan', 'power', 'usb2', 'usb3', 'wan-red', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: leds: '2ghz', '5ghz', 'power-amber', 'power-white', 'usb3-white', 'wan-amber', 'wan-white' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-linksys-panamera.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: mdio-mux@18003000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/mdio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: switch@0: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: switch@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dsa,member', 'ports', 'reset-gpios', 'reset-names' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: switch@0: 'resets' is a dependency of 'reset-names'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/reset/reset.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('dsa,member', 'ports' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: leds: 'bluebar1', 'bluebar2', 'bluebar3', 'bluebar4', 'bluebar5', 'bluebar6', 'bluebar7', 'bluebar8', 'power', 'usb2', 'usb3', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: leds: 'usb3' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 20, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 20, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: leds: '2ghz', '5ghz' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 0, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 0, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: leds: 'usb3' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 20, 0]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 20, 0]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 18, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 18, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: leds: '2ghz', '5ghz', 'lan1', 'lan2', 'lan3', 'lan4', 'power', 'usb3', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: leds: '2ghz', '5ghz', 'power', 'usb3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-netgear-r8500.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-netgear-r8500.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: leds: '2ghz', '5ghz-1', '5ghz-2', 'power0', 'power1', 'usb2', 'usb3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-phicomm-k3.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm47094-phicomm-k3.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm53015-meraki-mr26.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53015-meraki-mr26.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: eeprom@56: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/eeprom/at24.yaml
Traceback (most recent call last):
   File "/home/rmilecki/.local/bin/dt-validate", line 175, in <module>
     sg.check_trees(filename, testtree)
   File "/home/rmilecki/.local/bin/dt-validate", line 122, in check_trees
     self.check_subtree(dt, subtree, False, "/", "/", filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 111, in check_subtree
     self.check_subtree(tree, value, disabled, name, fullname + name, filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 106, in check_subtree
     self.check_node(tree, subtree, disabled, nodename, fullname, filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 84, in check_node
     print(dtschema.format_error(filename, error, nodename=nodename, verbose=verbose) +
   File "/home/rmilecki/.local/lib/python3.9/site-packages/dtschema/lib.py", line 1332, in format_error
     msg += '\n' + format_error(filename, suberror, prefix=prefix+"\t", nodename=nodename, verbose=verbose)
   File "/home/rmilecki/.local/lib/python3.9/site-packages/dtschema/lib.py", line 1310, in format_error
     if error.linecol[0] >= 0:
AttributeError: 'ValidationError' object has no attribute 'linecol'
   DTC_CHK arch/arm/boot/dts/bcm53016-meraki-mr32.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm53016-meraki-mr32.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: eeprom@50: '#address-cells', '#size-cells', 'mac-address@66' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/eeprom/at24.yaml
Traceback (most recent call last):
   File "/home/rmilecki/.local/bin/dt-validate", line 175, in <module>
     sg.check_trees(filename, testtree)
   File "/home/rmilecki/.local/bin/dt-validate", line 122, in check_trees
     self.check_subtree(dt, subtree, False, "/", "/", filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 111, in check_subtree
     self.check_subtree(tree, value, disabled, name, fullname + name, filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 106, in check_subtree
     self.check_node(tree, subtree, disabled, nodename, fullname, filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 84, in check_node
     print(dtschema.format_error(filename, error, nodename=nodename, verbose=verbose) +
   File "/home/rmilecki/.local/lib/python3.9/site-packages/dtschema/lib.py", line 1332, in format_error
     msg += '\n' + format_error(filename, suberror, prefix=prefix+"\t", nodename=nodename, verbose=verbose)
   File "/home/rmilecki/.local/lib/python3.9/site-packages/dtschema/lib.py", line 1310, in format_error
     if error.linecol[0] >= 0:
AttributeError: 'ValidationError' object has no attribute 'linecol'
   DTC_CHK arch/arm/boot/dts/bcm94708.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm94708.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm94708.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm94708.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm94708.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm94709.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm94709.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm94709.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm94709.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm94709.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm953012er.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm953012er.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012er.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012er.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012er.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm953012hr.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm953012hr.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012hr.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: flash@0: Unevaluated properties are not allowed ('m25p,default-addr-width' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
   DTC_CHK arch/arm/boot/dts/bcm953012k.dtb
arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
arch/arm/boot/dts/bcm953012k.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012k.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012k.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
arch/arm/boot/dts/bcm953012k.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: flash@0: Unevaluated properties are not allowed ('m25p,default-addr-width' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
   DTC_CHK arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb
arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb:0:0: /: failed to match any schema with compatible: ['luxul,xap-1440-v1', 'brcm,bcm47189', 'brcm,bcm53573']
arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb:0:0: /: failed to match any schema with compatible: ['luxul,xap-1440-v1', 'brcm,bcm47189', 'brcm,bcm53573']
arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb:0:0: /: failed to match any schema with compatible: ['luxul,xap-1440-v1', 'brcm,bcm47189', 'brcm,bcm53573']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/simple-bus.yaml
arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/simple-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: pcie@2000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: pcie@2000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: pcie@2000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: pcie@2000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: usb@4000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: usb@4000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: usb@4000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: usb@d000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: usb@d000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: usb@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: pmu@12000: compatible: ['simple-mfd', 'syscon'] is too short
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/mfd/syscon.yaml
arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb:0:0: /axi@18000000/pmu@12000/ilp: failed to match any schema with compatible: ['brcm,bcm53573-ilp']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dtb: leds: 'system', 'wlan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb
arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb:0:0: /: failed to match any schema with compatible: ['luxul,xap-810-v1', 'brcm,bcm47189', 'brcm,bcm53573']
arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb:0:0: /: failed to match any schema with compatible: ['luxul,xap-810-v1', 'brcm,bcm47189', 'brcm,bcm53573']
arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb:0:0: /: failed to match any schema with compatible: ['luxul,xap-810-v1', 'brcm,bcm47189', 'brcm,bcm53573']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/simple-bus.yaml
arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/simple-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: pcie@2000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: usb@4000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: usb@4000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: usb@4000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: usb@d000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: usb@d000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: usb@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: pmu@12000: compatible: ['simple-mfd', 'syscon'] is too short
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/mfd/syscon.yaml
arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb:0:0: /axi@18000000/pmu@12000/ilp: failed to match any schema with compatible: ['brcm,bcm53573-ilp']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: leds: '5ghz', 'system' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-luxul-xap-810.dtb: pcie0_leds: '2ghz' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47189-tenda-ac9.dtb
arch/arm/boot/dts/bcm47189-tenda-ac9.dtb:0:0: /: failed to match any schema with compatible: ['tenda,ac9', 'brcm,bcm47189', 'brcm,bcm53573']
arch/arm/boot/dts/bcm47189-tenda-ac9.dtb:0:0: /: failed to match any schema with compatible: ['tenda,ac9', 'brcm,bcm47189', 'brcm,bcm53573']
arch/arm/boot/dts/bcm47189-tenda-ac9.dtb:0:0: /: failed to match any schema with compatible: ['tenda,ac9', 'brcm,bcm47189', 'brcm,bcm53573']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/simple-bus.yaml
arch/arm/boot/dts/bcm47189-tenda-ac9.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/simple-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: pcie@2000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: usb@4000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: usb@4000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: usb@4000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: usb@d000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: usb@d000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: usb@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: switch@1e: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: switch@1e: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: switch@1e: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: pmu@12000: compatible: ['simple-mfd', 'syscon'] is too short
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/mfd/syscon.yaml
arch/arm/boot/dts/bcm47189-tenda-ac9.dtb:0:0: /axi@18000000/pmu@12000/ilp: failed to match any schema with compatible: ['brcm,bcm53573-ilp']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: leds: '5ghz', 'system', 'usb', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47189-tenda-ac9.dtb: pcie0_leds: '2ghz' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm947189acdbmr.dtb
arch/arm/boot/dts/bcm947189acdbmr.dtb:0:0: /: failed to match any schema with compatible: ['brcm,bcm947189acdbmr', 'brcm,bcm47189', 'brcm,bcm53573']
arch/arm/boot/dts/bcm947189acdbmr.dtb:0:0: /: failed to match any schema with compatible: ['brcm,bcm947189acdbmr', 'brcm,bcm47189', 'brcm,bcm53573']
arch/arm/boot/dts/bcm947189acdbmr.dtb:0:0: /: failed to match any schema with compatible: ['brcm,bcm947189acdbmr', 'brcm,bcm47189', 'brcm,bcm53573']
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: mpcore@18310000: $nodename:0: 'mpcore@18310000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/simple-bus.yaml
arch/arm/boot/dts/bcm947189acdbmr.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: chipcommon@0: $nodename:0: 'chipcommon@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/simple-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: pcie@2000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: usb@4000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: usb@4000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: usb@4000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: usb@d000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: usb@d000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: usb@d000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: pmu@12000: compatible: ['simple-mfd', 'syscon'] is too short
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/mfd/syscon.yaml
arch/arm/boot/dts/bcm947189acdbmr.dtb:0:0: /axi@18000000/pmu@12000/ilp: failed to match any schema with compatible: ['brcm,bcm53573-ilp']
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: leds: '2ghz', '5ghz', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: spi: gpio-sck: False schema does not allow [[3, 21, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: spi: gpio-miso: False schema does not allow [[3, 22, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: spi: gpio-mosi: False schema does not allow [[3, 23, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm947189acdbmr.dtb: spi: Unevaluated properties are not allowed ('gpio-miso', 'gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml





Testing with the patch you are complaining about reverted. Reverting
ADDS warnings about missing "device_type", "#address-cells" and
"#size-cells".

$ git revert 61dc1e3850a6b88903f6f3912db35575ab78ab50
[detached HEAD 193437d59b13] Revert "ARM: dts: BCM5301X: Add basic PCI controller properties"
  1 file changed, 12 deletions(-)

$ make ARCH=arm dtbs_check
   DTC_CHK arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb
arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dtb: leds: '2ghz', 'all', 'lan', 'power', 'usb2', 'usb3', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb
arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dtb: leds: 'logo', 'power', 'usb2', 'usb3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb
arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi: gpio-sck: False schema does not allow [[8, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi: gpio-mosi: False schema does not allow [[8, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'usb', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
         ['buffalo,wzr-1166dhp', 'brcm,bcm4708'] is too short
         'buffalo,wzr-1166dhp' is not one of ['asus,rt-ac56u', 'asus,rt-ac68u', 'buffalo,wzr-1750dhp', 'linksys,ea6300-v1', 'linksys,ea6500-v2', 'luxul,xap-1510v1', 'luxul,xwc-1000', 'netgear,r6250v1', 'netgear,r6300v2', 'smartrg,sr400ac', 'brcm,bcm94708']
         'buffalo,wzr-1166dhp' is not one of ['asus,rt-n18u', 'buffalo,wzr-600dhp2', 'buffalo,wzr-900dhp', 'luxul,xap-1410v1', 'luxul,xwr-1200v1', 'tplink,archer-c5-v2']
         'buffalo,wzr-1166dhp' is not one of ['asus,rt-ac87u', 'buffalo,wxr-1900dhp', 'linksys,ea9200', 'netgear,r7000', 'netgear,r8000', 'tplink,archer-c9-v1', 'brcm,bcm94709']
         'buffalo,wzr-1166dhp' is not one of ['asus,rt-ac88u', 'dlink,dir-885l', 'linksys,panamera', 'luxul,abr-4500-v1', 'luxul,xap-1610-v1', 'luxul,xbr-4500-v1', 'luxul,xwc-2000-v1', 'luxul,xwr-3100v1', 'luxul,xwr-3150-v1', 'netgear,r8500', 'phicomm,k3']
         'buffalo,wzr-1166dhp' is not one of ['brcm,bcm953012er', 'brcm,bcm953012hr', 'brcm,bcm953012k']
         'buffalo,wzr-1166dhp' is not one of ['meraki,mr26']
         'buffalo,wzr-1166dhp' is not one of ['meraki,mr32']
         'brcm,bcm47081' was expected
         'brcm,bcm4709' was expected
         'brcm,bcm47094' was expected
         'brcm,bcm53012' was expected
         'brcm,bcm53015' was expected
         'brcm,bcm53016' was expected
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb:0:0: /: failed to match any schema with compatible: ['buffalo,wzr-1166dhp', 'brcm,bcm4708']
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi: gpio-sck: False schema does not allow [[8, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi: gpio-mosi: False schema does not allow [[8, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'usb', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
         ['buffalo,wzr-1166dhp2', 'brcm,bcm4708'] is too short
         'buffalo,wzr-1166dhp2' is not one of ['asus,rt-ac56u', 'asus,rt-ac68u', 'buffalo,wzr-1750dhp', 'linksys,ea6300-v1', 'linksys,ea6500-v2', 'luxul,xap-1510v1', 'luxul,xwc-1000', 'netgear,r6250v1', 'netgear,r6300v2', 'smartrg,sr400ac', 'brcm,bcm94708']
         'buffalo,wzr-1166dhp2' is not one of ['asus,rt-n18u', 'buffalo,wzr-600dhp2', 'buffalo,wzr-900dhp', 'luxul,xap-1410v1', 'luxul,xwr-1200v1', 'tplink,archer-c5-v2']
         'buffalo,wzr-1166dhp2' is not one of ['asus,rt-ac87u', 'buffalo,wxr-1900dhp', 'linksys,ea9200', 'netgear,r7000', 'netgear,r8000', 'tplink,archer-c9-v1', 'brcm,bcm94709']
         'buffalo,wzr-1166dhp2' is not one of ['asus,rt-ac88u', 'dlink,dir-885l', 'linksys,panamera', 'luxul,abr-4500-v1', 'luxul,xap-1610-v1', 'luxul,xbr-4500-v1', 'luxul,xwc-2000-v1', 'luxul,xwr-3100v1', 'luxul,xwr-3150-v1', 'netgear,r8500', 'phicomm,k3']
         'buffalo,wzr-1166dhp2' is not one of ['brcm,bcm953012er', 'brcm,bcm953012hr', 'brcm,bcm953012k']
         'buffalo,wzr-1166dhp2' is not one of ['meraki,mr26']
         'buffalo,wzr-1166dhp2' is not one of ['meraki,mr32']
         'brcm,bcm47081' was expected
         'brcm,bcm4709' was expected
         'brcm,bcm47094' was expected
         'brcm,bcm53012' was expected
         'brcm,bcm53015' was expected
         'brcm,bcm53016' was expected
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb:0:0: /: failed to match any schema with compatible: ['buffalo,wzr-1166dhp2', 'brcm,bcm4708']
arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi: gpio-sck: False schema does not allow [[8, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi: gpio-mosi: False schema does not allow [[8, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp2.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'usb', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb
arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb
arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb
arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: leds: '2ghz', '5ghz' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 15, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 15, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb
arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 0, 0]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 0, 0]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-netgear-r6250.dtb
arch/arm/boot/dts/bcm4708-netgear-r6250.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6250.dtb: leds: 'logo', 'power0', 'power1', 'usb', 'wireless' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb
arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dtb: leds: 'logo', 'power0', 'power1', 'usb', 'wireless' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb
arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dtb: leds: 'power-amber', 'power-white', 'status-blue', 'status-green', 'status-red', 'usb2', 'usb3-green', 'usb3-white', 'wan-red', 'wan-white', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb
arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dtb: leds: 'lan', 'power', 'usb2', 'usb3', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb
arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi: gpio-sck: False schema does not allow [[17, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi: gpio-mosi: False schema does not allow [[17, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb
arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi: gpio-sck: False schema does not allow [[16, 7, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi: gpio-mosi: False schema does not allow [[16, 4, 0]]
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi: 'sck-gpios' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: spi: Unevaluated properties are not allowed ('gpio-mosi', 'gpio-sck' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dtb: leds: 'power0', 'power1', 'router0', 'router1', 'usb', 'wan', 'wireless0', 'wireless1' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb
arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: leds: '2ghz', '5ghz' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 15, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 15, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb
arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: leds: '2ghz', '5ghz', 'lan1', 'lan2', 'lan3', 'lan4', 'power', 'usb', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[8, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[8, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb
arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dtb: leds: '2ghz', '5ghz', 'lan', 'power', 'usb2-port1', 'usb2-port2', 'wan-amber', 'wan-green', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb
arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dtb: leds: 'power', 'wan', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb
arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dtb: leds: 'power-amber', 'power-white', 'router-amber', 'router-white', 'usb', 'wan-amber', 'wan-white', 'wireless-amber', 'wireless-white' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb
arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-linksys-ea9200.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-netgear-r7000.dtb
arch/arm/boot/dts/bcm4709-netgear-r7000.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r7000.dtb: leds: '2ghz', '5ghz', 'power-amber', 'power-white', 'usb2', 'usb3', 'wireless', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-netgear-r8000.dtb
arch/arm/boot/dts/bcm4709-netgear-r8000.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-netgear-r8000.dtb: leds: '2ghz', '5ghz-1', '5ghz-2', 'power-amber', 'power-white', 'usb2', 'usb3', 'wan-amber', 'wan-white', 'wireless', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb
arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dtb: leds: '2ghz', '5ghz', 'lan', 'power', 'usb2', 'usb3', 'wan-amber', 'wan-blue', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: ethernet-switch@18007000: ports:port@7: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('dsa,member', 'ports' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: leds: 'lan', 'power', 'usb2', 'usb3', 'wan-red', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb
arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dtb: leds: '2ghz', '5ghz', 'power-amber', 'power-white', 'usb3-white', 'wan-amber', 'wan-white' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-linksys-panamera.dtb
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: mdio-mux@18003000: mdio@200:reg:0:0: 512 is greater than the maximum of 31
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/mdio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: switch@0: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: switch@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dsa,member', 'ports', 'reset-gpios', 'reset-names' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: switch@0: 'resets' is a dependency of 'reset-names'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/reset/reset.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: ethernet-switch@18007000: ports:port@8: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('dsa,member', 'ports' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: leds: 'bluebar1', 'bluebar2', 'bluebar3', 'bluebar4', 'bluebar5', 'bluebar6', 'bluebar7', 'bluebar8', 'power', 'usb2', 'usb3', 'wps' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb
arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: leds: 'usb3' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 20, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 20, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb
arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: leds: '2ghz', '5ghz' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 0, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 0, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb
arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: leds: 'usb3' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 20, 0]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 20, 0]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb
arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 18, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[17, 18, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb
arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: leds: '2ghz', '5ghz', 'lan1', 'lan2', 'lan3', 'lan4', 'power', 'usb3', 'wan' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb
arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: leds: '2ghz', '5ghz', 'power', 'usb3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dtb: leds: status: {'label': ['bcm53xx:green:status'], 'gpios': [[9, 10, 1]], 'linux,default-trigger': ['timer']} is not of type 'array'
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/dt-core.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-netgear-r8500.dtb
arch/arm/boot/dts/bcm47094-netgear-r8500.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-netgear-r8500.dtb: leds: '2ghz', '5ghz-1', '5ghz-2', 'power0', 'power1', 'usb2', 'usb3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/leds/leds-gpio.yaml
   DTC_CHK arch/arm/boot/dts/bcm47094-phicomm-k3.dtb
arch/arm/boot/dts/bcm47094-phicomm-k3.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm47094-phicomm-k3.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm53015-meraki-mr26.dtb
arch/arm/boot/dts/bcm53015-meraki-mr26.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53015-meraki-mr26.dtb: eeprom@56: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/eeprom/at24.yaml
Traceback (most recent call last):
   File "/home/rmilecki/.local/bin/dt-validate", line 175, in <module>
     sg.check_trees(filename, testtree)
   File "/home/rmilecki/.local/bin/dt-validate", line 122, in check_trees
     self.check_subtree(dt, subtree, False, "/", "/", filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 111, in check_subtree
     self.check_subtree(tree, value, disabled, name, fullname + name, filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 106, in check_subtree
     self.check_node(tree, subtree, disabled, nodename, fullname, filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 84, in check_node
     print(dtschema.format_error(filename, error, nodename=nodename, verbose=verbose) +
   File "/home/rmilecki/.local/lib/python3.9/site-packages/dtschema/lib.py", line 1332, in format_error
     msg += '\n' + format_error(filename, suberror, prefix=prefix+"\t", nodename=nodename, verbose=verbose)
   File "/home/rmilecki/.local/lib/python3.9/site-packages/dtschema/lib.py", line 1310, in format_error
     if error.linecol[0] >= 0:
AttributeError: 'ValidationError' object has no attribute 'linecol'
   DTC_CHK arch/arm/boot/dts/bcm53016-meraki-mr32.dtb
arch/arm/boot/dts/bcm53016-meraki-mr32.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm53016-meraki-mr32.dtb: eeprom@50: '#address-cells', '#size-cells', 'mac-address@66' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/eeprom/at24.yaml
Traceback (most recent call last):
   File "/home/rmilecki/.local/bin/dt-validate", line 175, in <module>
     sg.check_trees(filename, testtree)
   File "/home/rmilecki/.local/bin/dt-validate", line 122, in check_trees
     self.check_subtree(dt, subtree, False, "/", "/", filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 111, in check_subtree
     self.check_subtree(tree, value, disabled, name, fullname + name, filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 106, in check_subtree
     self.check_node(tree, subtree, disabled, nodename, fullname, filename)
   File "/home/rmilecki/.local/bin/dt-validate", line 84, in check_node
     print(dtschema.format_error(filename, error, nodename=nodename, verbose=verbose) +
   File "/home/rmilecki/.local/lib/python3.9/site-packages/dtschema/lib.py", line 1332, in format_error
     msg += '\n' + format_error(filename, suberror, prefix=prefix+"\t", nodename=nodename, verbose=verbose)
   File "/home/rmilecki/.local/lib/python3.9/site-packages/dtschema/lib.py", line 1310, in format_error
     if error.linecol[0] >= 0:
AttributeError: 'ValidationError' object has no attribute 'linecol'
   DTC_CHK arch/arm/boot/dts/bcm94708.dtb
arch/arm/boot/dts/bcm94708.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94708.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm94709.dtb
arch/arm/boot/dts/bcm94709.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm94709.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm953012er.dtb
arch/arm/boot/dts/bcm953012er.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: ethernet-switch@18007000: ports:port@5: 'phy-mode' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: ethernet-switch@18007000: ports:port@5: 'oneOf' conditional failed, one must be fixed:
         'fixed-link' is a required property
         'phy-handle' is a required property
         'managed' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: ethernet-switch@18007000: Unevaluated properties are not allowed ('ports' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012er.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
   DTC_CHK arch/arm/boot/dts/bcm953012hr.dtb
arch/arm/boot/dts/bcm953012hr.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012hr.dtb: flash@0: Unevaluated properties are not allowed ('m25p,default-addr-width' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
   DTC_CHK arch/arm/boot/dts/bcm953012k.dtb
arch/arm/boot/dts/bcm953012k.dtb:0:0: /axi@18000000: failed to match any schema with compatible: ['brcm,bus-axi']
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@12000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@12000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@12000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@12000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@13000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@13000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@13000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@13000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@14000: 'device_type' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@14000: 'ranges' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@14000: '#address-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: pcie@14000: '#size-cells' is a required property
         From schema: /home/rmilecki/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@21000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@21000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@21000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ehci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@22000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@22000: port@2: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@22000: '#address-cells', '#size-cells', '#usb-cells', 'port@1', 'port@2' do not match any of the regexes: 'pinctrl-[0-9]+'
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-ohci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@23000: port@1: 'compatible' is a required property
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: usb@23000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', '#usb-cells', 'phy-names', 'phys', 'port@1' were unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/usb/generic-xhci.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: spi@18029200: Unevaluated properties are not allowed ('clock-names' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/home/rmilecki/linux/arch/arm/boot/dts/bcm953012k.dtb: flash@0: Unevaluated properties are not allowed ('m25p,default-addr-width' was unexpected)
         From schema: /home/rmilecki/linux/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
