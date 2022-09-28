Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E4B5ED32E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiI1Cyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiI1Cy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311B21BCAFF;
        Tue, 27 Sep 2022 19:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889E461940;
        Wed, 28 Sep 2022 02:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D7BC433C1;
        Wed, 28 Sep 2022 02:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664333664;
        bh=eccnPEsVI/nH1CUcrbHa5Df+aFQ1BtqOCkP1lMAnNYw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h1DgvfOOLclk3O06J9AIxjv8MFTjTspiaGvXjxqn4FV57F6QyQStC4W3dm3sNKKHs
         Cb1JQCMvyxT/ULT/J8iS+wnajJYlpg0Dqhd+l1hyS+K+eYcNn+oIU4hzUAwHHs5OXG
         5dhUmWKcm7aZjSLMIAQKHMkGdSxBZRzZqPLqjAP32IqkN+Y6nO+cBjFoK2jO8zGD4c
         vKuR7XOWEboyzqgNkHF3berwb0Zwi0HdPux/745cyA3pyS24Qe2i8scMCyYHx3f1xI
         EQVl9LKroY7lEqrbElDcZ/PX4OujtHXn+gyffVHrMFerXfQSqmUjoaYaeL33qVSPQL
         ScfycXDXdl0KQ==
Message-ID: <9f4ef7ff-7b62-c0a2-6be4-dd51992acae1@kernel.org>
Date:   Tue, 27 Sep 2022 21:54:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv3 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        jh80.chung@samsung.com, linux-mmc@vger.kernel.org,
        robh+dt@kernel.org
References: <20220926140932.820050-1-dinguyen@kernel.org>
 <1664289558.354045.943214.nullmailer@robh.at.kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <1664289558.354045.943214.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 9/27/22 09:39, Rob Herring wrote:
> On Mon, 26 Sep 2022 09:09:30 -0500, Dinh Nguyen wrote:
>> Document the optional "altr,sysmgr-syscon" binding that is used to 
>> access the System Manager register that controls the SDMMC clock 
>> phase.
>> 
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org> --- v3: document
>> that the "altr,sysmgr-syscon" binding is only applicable to 
>> "altr,socfpga-dw-mshc" v2: document "altr,sysmgr-syscon" in the MMC
>> section --- .../bindings/mmc/synopsys-dw-mshc.yaml        | 28
>> +++++++++++++++++-- 1 file changed, 25 insertions(+), 3
>> deletions(-)
>> 
> 
> Running 'make dtbs_check' with the schema in this patch gives the 
> following warnings. Consider if they are expected or the schema is 
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for
> dtbs_check. This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> dwmmc0@ff704000: $nodename:0: 'dwmmc0@ff704000' does not match
> '^mmc(@.*)?$' arch/arm/boot/dts/socfpga_arria5_socdk.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_sockit.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_socrates.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_sodia.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dtb 
> arch/arm/boot/dts/socfpga_vt.dtb
> 
> dwmmc0@ff704000: Unevaluated properties are not allowed
> ('#address-cells', '#size-cells', 'broken-cd', 'bus-width',
> 'cap-mmc-highspeed', 'cap-sd-highspeed', 'cd-gpios', 'fifo-depth',
> 'resets', 'vmmc-supply', 'vqmmc-supply' were unexpected) 
> arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_sodia.dtb
> 
> dwmmc0@ff704000: Unevaluated properties are not allowed
> ('#address-cells', '#size-cells', 'broken-cd', 'bus-width',
> 'cap-mmc-highspeed', 'cap-sd-highspeed', 'fifo-depth', 'resets',
> 'vmmc-supply', 'vqmmc-supply' were unexpected) 
> arch/arm/boot/dts/socfpga_arria5_socdk.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_sockit.dtb
> 
> dwmmc0@ff704000: Unevaluated properties are not allowed
> ('#address-cells', '#size-cells', 'broken-cd', 'bus-width',
> 'cap-mmc-highspeed', 'cap-sd-highspeed', 'fifo-depth', 'resets' were
> unexpected) arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_socrates.dtb 
> arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dtb 
> arch/arm/boot/dts/socfpga_vt.dtb
> 
> dwmmc0@ff808000: $nodename:0: 'dwmmc0@ff808000' does not match
> '^mmc(@.*)?$' arch/arm/boot/dts/socfpga_arria10_chameleonv3.dtb 
> arch/arm/boot/dts/socfpga_arria10_socdk_nand.dtb 
> arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb 
> arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dtb
> 
> dwmmc0@ff808000: Unevaluated properties are not allowed
> ('#address-cells', '#size-cells', 'broken-cd', 'bus-width',
> 'cap-mmc-highspeed', 'cap-sd-highspeed', 'fifo-depth', 'resets' were
> unexpected) arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dtb
> 
> dwmmc0@ff808000: Unevaluated properties are not allowed
> ('#address-cells', '#size-cells', 'broken-cd', 'bus-width',
> 'cap-sd-highspeed', 'fifo-depth', 'resets' were unexpected) 
> arch/arm/boot/dts/socfpga_arria10_chameleonv3.dtb
> 
> dwmmc0@ff808000: Unevaluated properties are not allowed
> ('#address-cells', '#size-cells', 'fifo-depth', 'resets' were
> unexpected) arch/arm/boot/dts/socfpga_arria10_socdk_nand.dtb 
> arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb
> 
> mmc@ff808000: Unevaluated properties are not allowed
> ('altr,dw-mshc-ciu-div', 'altr,dw-mshc-sdr-timing', 'iommus' were
> unexpected) arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dtb
> 
> mmc@ff808000: Unevaluated properties are not allowed ('iommus' was
> unexpected) arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dtb 
> arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dtb 
> arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dtb 
> arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb 
> arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dtb 
> arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dtb
> 
> mmcsd@40004000: $nodename:0: 'mmcsd@40004000' does not match
> '^mmc(@.*)?$' arch/arm/boot/dts/lpc4337-ciaa.dtb 
> arch/arm/boot/dts/lpc4350-hitex-eval.dtb 
> arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb 
> arch/arm/boot/dts/lpc4357-myd-lpc4357.dtb
> 
> mmcsd@40004000: clock-names:0: 'biu' was expected 
> arch/arm/boot/dts/lpc4337-ciaa.dtb 
> arch/arm/boot/dts/lpc4350-hitex-eval.dtb 
> arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb 
> arch/arm/boot/dts/lpc4357-myd-lpc4357.dtb
> 
> mmcsd@40004000: clock-names:1: 'ciu' was expected 
> arch/arm/boot/dts/lpc4337-ciaa.dtb 
> arch/arm/boot/dts/lpc4350-hitex-eval.dtb 
> arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb 
> arch/arm/boot/dts/lpc4357-myd-lpc4357.dtb
> 
> mmcsd@40004000: Unevaluated properties are not allowed ('bus-width',
> 'clock-names', 'resets', 'vmmc-supply' were unexpected) 
> arch/arm/boot/dts/lpc4357-ea4357-devkit.dtb 
> arch/arm/boot/dts/lpc4357-myd-lpc4357.dtb
> 
> mmcsd@40004000: Unevaluated properties are not allowed
> ('clock-names', 'resets' were unexpected) 
> arch/arm/boot/dts/lpc4337-ciaa.dtb 
> arch/arm/boot/dts/lpc4350-hitex-eval.dtb
> 

Hmm, I see these warnings on the standard v6.0-rc1 and 
linux-next(next-20220923), but with this patch applied I don't see any 
warnings regarding MMC.


DTC     arch/arm/boot/dts/socfpga_arria5_socdk.dtb
   DTC     arch/arm/boot/dts/socfpga_arria10_chameleonv3.dtb
   DTC     arch/arm/boot/dts/socfpga_arria10_socdk_nand.dtb
   DTC     arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb
   CHECK   arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb
   CHECK   arch/arm/boot/dts/socfpga_arria5_socdk.dtb
   CHECK   arch/arm/boot/dts/socfpga_arria10_chameleonv3.dtb
   CHECK   arch/arm/boot/dts/socfpga_arria10_socdk_nand.dtb
/home/dinguyen/linux_dev/linux/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb:
pmu@ff111000: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
         From schema:
/home/dinguyen/linux_dev/linux/Documentation/devicetree/bindings/arm/pmu.yaml
/home/dinguyen/linux_dev/linux/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb:
soc: amba: {'compatible': ['simple-bus'], '#address-cells': [[1]],
'#size-cells': [[1]], 'ranges': True, 'pdma@ffda1000': {'compatible':
['arm,pl330', 'arm,primecell'], 'reg': [[4292481024, 4096]],
'interrupts': [[0, 83, 4], [0, 84, 4], [0, 85, 4], [0, 86, 4], [0, 87,
4], [0, 88, 4], [0, 89, 4], [0, 90, 4], [0, 91, 4]], '#dma-cells':
[[1]], 'clocks': [[5]], 'clock-names': ['apb_pclk'], 'resets': [[6, 48],
[6, 53]], 'reset-names': ['dma', 'dma-ocp'], 'phandle': [[34]]}} should
not be valid under {'type': 'object'}
         From schema:
/home/dinguyen/.local/lib/python3.8/site-packages/dtschema/schemas/simple-bus.yaml
/home/dinguyen/linux_dev/linux/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb:
soc: base_fpga_region: {'#address-cells': [[1]], '#size-cells': [[1]],
'compatible': ['fpga-region'], 'fpga-mgr': [[7]]} should not be valid
under {'type': 'object'}
         From schema:
/home/dinguyen/.local/lib/python3.8/site-packages/dtschema/schemas/simple-bus.yaml
/home/dinguyen/linux_dev/linux/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb:
soc: stmmac-axi-config: {'snps,wr_osr_lmt': [[15]], 'snps,rd_osr_lmt':
[[15]], 'snps,blen': [[0, 0, 0, 0, 16, 0, 0]], 'phandle': [[30]]} should
not be valid under {'type': 'object'}
         From schema:
/home/dinguyen/.local/lib/python3.8/site-packages/dtschema/schemas/simple-bus.yaml
/home/dinguyen/linux_dev/linux/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb:
soc: eccmgr: {'compatible': ['altr,socfpga-a10-ecc-manager'],
'altr,sysmgr-syscon': [[28]], '#address-cells': [[1]], '#size-cells':
[[1]], 'interrupts': [[0, 2, 4], [0, 0, 4]], 'interrupt-controller':
True, '#interrupt-cells': [[2]], 'ranges': True, 'sdramedac':
{'compatible': ['altr,sdram-edac-a10'], 'altr,sdr-syscon': [[39]],
'interrupts': [[17, 4], [49, 4]]}, 'l2-ecc@ffd06010': {'compatible':
['altr,socfpga-a10-l2-ecc'], 'reg': [[4291846160, 4]], 'interrupts':
[[0, 4], [32, 4]]}, 'ocram-ecc@ff8c3000': {'compatible':
['altr,socfpga-a10-ocram-ecc'], 'reg': [[4287377408, 1024]],
'interrupts': [[1, 4], [33, 4]]}, 'emac0-rx-ecc@ff8c0800':
{'compatible': ['altr,socfpga-eth-mac-ecc'], 'reg': [[4287367168,
1024]], 'altr,ecc-parent': [[40]], 'interrupts': [[4, 4], [36, 4]]},
'emac0-tx-ecc@ff8c0c00': {'compatible': ['altr,socfpga-eth-mac-ecc'],
'reg': [[4287368192, 1024]], 'altr,ecc-parent': [[40]], 'interrupts':
[[5, 4], [37, 4]]}, 'sdmmca-ecc@ff8c2c00': {'compatible':
['altr,socfpga-sdmmc-ecc'], 'reg': [[4287376384, 1024]],
'altr,ecc-parent': [[41]], 'interrupts': [[15, 4], [47, 4], [16, 4],
[48, 4]]}, 'dma-ecc@ff8c8000': {'compatible': ['altr,socfpga-dma-ecc'],
'reg': [[4287397888, 1024]], 'altr,ecc-parent': [[34]], 'interrupts':
[[10, 4], [42, 4]]}, 'usb0-ecc@ff8c8800': {'compatible':
['altr,socfpga-usb-ecc'], 'reg': [[4287399936, 1024]],
'altr,ecc-parent': [[42]], 'interrupts': [[2, 4], [34, 4]]}} should not
be valid under {'type': 'object'}
         From schema:
/home/dinguyen/.local/lib/python3.8/site-packages/dtschema/schemas/simple-bus.yaml
/home/dinguyen/linux_dev/linux/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb:
soc: usbphy: {'#phy-cells': [[0]], 'compatible': ['usb-nop-xceiv'],
'status': ['okay'], 'phandle': [[47]]} should not be valid under
{'type': 'object'}
         From schema:
/home/dinguyen/.local/lib/python3.8/site-packages/dtschema/schemas/simple-bus.yaml
/home/dinguyen/linux_dev/linux/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb:
amba: $nodename:0: 'amba' does not match
'^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
         From schema:
/home/dinguyen/.local/lib/python3.8/site-packages/dtschema/schemas/simple-bus.yaml
/home/dinguyen/linux_dev/linux/arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dtb:
pdma@ffda1000: $nodename:0: 'pdma@ffda1000' does not match
'^dma-controller(@.*)?$'
         From schema:
/home/dinguyen/linux_dev/linux/Documentation/devicetree/bindings/dma/arm,pl330.yaml



Dinh
