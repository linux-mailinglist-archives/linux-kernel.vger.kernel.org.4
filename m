Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC0F5F8617
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJHQqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJHQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:46:34 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E53F316
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 09:46:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 91E4F604F0;
        Sat,  8 Oct 2022 18:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665247591; bh=b5AGVb6RueKSW+3xo8yRh/gT/ciofDsTJS+2EhRTK4Q=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=kzM8HnPSCyHFVUl1DUXr6QJH+z3Taas2HlKtQCfKy6hUAgZQSfEktlH109hASE2DU
         c/6Q0d3256nURXKVn2pdsKs6uPK0lEhiDbpE8g4/kfgZYkwnwn93gLEMuq3BBJmgQm
         DrqfnMNXVdLF5GsfJQBBiudpeiWwtsb6uSTgBzNeGwp+bHRGcwGaR0a8j+Y264KhHD
         zNuROj9bxBNsDGAPFB55EA4rhapIAOrS56nYp56kutb8Y1UmdQdFj5AvzASRWu5T8f
         RqK0UE+0Y4scxXL2lLDn3sZkMwMkvOgpKxKMf+42xn0FCxXrBxlsBlTNuGaM0701R5
         3+7zd6PyFAvKw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2NZq40T-HWNL; Sat,  8 Oct 2022 18:46:28 +0200 (CEST)
Received: from [192.168.0.12] (unknown [188.252.198.203])
        by domac.alu.hr (Postfix) with ESMTPSA id E860D604EF;
        Sat,  8 Oct 2022 18:46:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665247588; bh=b5AGVb6RueKSW+3xo8yRh/gT/ciofDsTJS+2EhRTK4Q=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=iKDGer9QH814JHeY31hCEvgpa3wdTdW06DHWE/jwUe5OQFrVXJoH3dptWHfDS43Pd
         riKVJ4Z8acFVg8SdBkfq8XznIEqT+4b3dqndLZu2n8K85mFPmNFTYIKt5D6YlLnxMY
         Mck+Xi/VAZViU3wneLLA6LsQ3FFsytoOCHIYk2j7qonQKjEAm17rJSnLAInsSBNhwp
         gcdAOCVtWrh4RUnLvBlWlUcAt0uMK/RAMxmW+yBe2rBqSb2brr1IaXXRncZWOtE0Jt
         v47dFNReRlvtGHKGIZbnhgI0JMvxMUWu3XdZ6Pm7ELXEcyvupLjZAzPFAY24/UrsZ0
         IowD8ZN73FPBA==
Message-ID: <87246802-7402-5913-78ec-4b579ba75198@alu.unizg.hr>
Date:   Sat, 8 Oct 2022 18:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through
 6.0.0-rc7
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info>
 <0fb2a9ff-df76-8af9-e54a-c2dc6bfd9478@leemhuis.info>
 <bdab45d3-c893-42ff-dbb9-5fa93d0dff55@alu.unizg.hr>
 <dd62210d-d095-f971-2b7b-0ec54fd189a9@leemhuis.info>
 <c05134cc-92fa-dac2-e738-cf6fae194521@alu.unizg.hr>
 <6ba15505-1c04-df2b-237f-b3060f26d2e6@leemhuis.info>
 <25cd0e21-ed8e-1836-b0ec-c052c2276cd8@alu.unizg.hr>
In-Reply-To: <25cd0e21-ed8e-1836-b0ec-c052c2276cd8@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 10. 2022. 15:41, Mirsad Goran Todorovac wrote:

> On 06. 10. 2022. 18:58, Thorsten Leemhuis wrote:
>
>> On 06.10.22 18:43, Mirsad Goran Todorovac wrote:
>>> Hey Thorsten,
>>>
>>> On 06. 10. 2022. 15:23, Thorsten Leemhuis wrote:
>>>> On 06.10.22 14:43, Mirsad Todorovac wrote:
>>>>> On 10/6/22 14:25, Thorsten Leemhuis wrote:
>>>>>
>>>>>> One more question:
>>>>>>
>>>>>> On 06.10.22 14:00, Thorsten Leemhuis wrote:
>>>>>> Were those two vanilla kernels? I asked in #snappy on IRC and was 
>>>>>> told
>>>>>> that "snapd simply expects some ubuntu bit in patched into the 
>>>>>> kernel if
>>>>>> it detects that it runs on an official ubuntu install...". This 
>>>>>> was also
>>>>>> suggested "it probably makes sense to file a but in LP to make the
>>>>>> kernel team aware".
>>>>> Yes, last time I tried it with git clone from linux_stable on 
>>>>> kernel.org
>>>>> and
>>>>> config-6.0.0-060000-generic from the official Ubuntu mainline build
>>>> You don't want to do that. Better take the config used to build a
>>>> working kernel (say 5.19.y) and then build 6.0 with it (after running
>>>> "make olddefconfig"), because it might be a new kernel option (say 
>>>> for a
>>>> new security technique) that might cause the problem, as explained 
>>>> here:
>>>> https://docs.kernel.org/admin-guide/reporting-regressions.html
>>> If I understood well, that would mean building www.kernel.org git
>>> linux_stable
>>> source with Ubuntu's config-5.9.13-051903?
>> I meant "please download Linux 6.0 (ideally through git, that you have
>> everything to perform a bisection), add the config from a working kernel
>> (if config-5.9.13-051903 is one, yeah, then take that) as .config and
>> then run "make olddefconfig" before compiling and installing the kernel
>> to see if 6.0 fails with that config that was working.
>
> Hi, Thorsten,
>
> Having done this build with mentioned config-5.19.13-051903-config from
> Ubuntu's mainline build and your recommended make option
> had produced a kernel that so far did not exhibit the Firefox snap
> "tab crash/wrong Verneed record version" bug.
>
> However, the uptime is 1d 18h50min, so it might be too early to draw
> a definite general conclusion.
>
> Now, the brave conlusion seems to be that the culprit is one of the 
> modules
> added in config-6.0.0-060000-generic.
>
> I am new to this, but is seems that we should look at some compiled-in
> modules (147 loadable and 41 compiled-in):
>
> mtodorov@domac:~/linux/kernel$ diff -u config-5.19.13-051913-generic 
> config-6.0.0-060000-generic | grep -e ^+CONFIG | less
> +CONFIG_CONTEXT_TRACKING=y
> +CONFIG_CONTEXT_TRACKING_IDLE=y
> +CONFIG_X86_PM_TIMER=y
> +CONFIG_HAVE_IMA_KEXEC=y
> +CONFIG_HAVE_CONTEXT_TRACKING_USER=y
> +CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
> +CONFIG_SOFTIRQ_ON_OWN_STACK=y
> +CONFIG_GET_FREE_REGION=y
> +CONFIG_NET_DSA_TAG_RZN1_A5PSW=m
> +CONFIG_PCI_DOE=y
> +CONFIG_PCI_EPF_VNTB=m
> +CONFIG_CXL_REGION=y
> +CONFIG_NVME_COMMON=m
> +CONFIG_NVME_AUTH=y
> +CONFIG_NVME_TARGET_AUTH=y
> +CONFIG_NET_DSA_MICROCHIP_KSZ_SPI=m
> +CONFIG_NET_DSA_QCA8K=m
> +CONFIG_NET_VENDOR_WANGXUN=y
> +CONFIG_TXGBE=m
> +CONFIG_BCM_NET_PHYPTP=m
> +CONFIG_CAN_DEV=m
> +CONFIG_CAN_VCAN=m
> +CONFIG_CAN_VXCAN=m
> +CONFIG_CAN_NETLINK=y
> +CONFIG_CAN_CALC_BITTIMING=y
> +CONFIG_CAN_RX_OFFLOAD=y
> +CONFIG_CAN_CAN327=m
> +CONFIG_CAN_JANZ_ICAN3=m
> +CONFIG_CAN_KVASER_PCIEFD=m
> +CONFIG_CAN_SLCAN=m
> +CONFIG_CAN_C_CAN=m
> +CONFIG_CAN_C_CAN_PLATFORM=m
> +CONFIG_CAN_C_CAN_PCI=m
> +CONFIG_CAN_CC770=m
> +CONFIG_CAN_CC770_ISA=m
> +CONFIG_CAN_CC770_PLATFORM=m
> +CONFIG_CAN_CTUCANFD=m
> +CONFIG_CAN_CTUCANFD_PCI=m
> +CONFIG_CAN_IFI_CANFD=m
> +CONFIG_CAN_M_CAN=m
> +CONFIG_CAN_M_CAN_PCI=m
> +CONFIG_CAN_M_CAN_PLATFORM=m
> +CONFIG_CAN_M_CAN_TCAN4X5X=m
> +CONFIG_CAN_PEAK_PCIEFD=m
> +CONFIG_CAN_SJA1000=m
> +CONFIG_CAN_EMS_PCI=m
> +CONFIG_CAN_EMS_PCMCIA=m
> +CONFIG_CAN_F81601=m
> +CONFIG_CAN_KVASER_PCI=m
> +CONFIG_CAN_PEAK_PCI=m
> +CONFIG_CAN_PEAK_PCIEC=y
> +CONFIG_CAN_PEAK_PCMCIA=m
> +CONFIG_CAN_PLX_PCI=m
> +CONFIG_CAN_SJA1000_ISA=m
> +CONFIG_CAN_SJA1000_PLATFORM=m
> +CONFIG_CAN_SOFTING=m
> +CONFIG_CAN_SOFTING_CS=m
> +CONFIG_CAN_HI311X=m
> +CONFIG_CAN_MCP251X=m
> +CONFIG_CAN_MCP251XFD=m
> +CONFIG_CAN_8DEV_USB=m
> +CONFIG_CAN_EMS_USB=m
> +CONFIG_CAN_ESD_USB=m
> +CONFIG_CAN_ETAS_ES58X=m
> +CONFIG_CAN_GS_USB=m
> +CONFIG_CAN_KVASER_USB=m
> +CONFIG_CAN_MCBA_USB=m
> +CONFIG_CAN_PEAK_USB=m
> +CONFIG_CAN_UCAN=m
> +CONFIG_TOUCHSCREEN_COLIBRI_VF50=m
> +CONFIG_TCG_TIS_I2C=m
> +CONFIG_SPI_MICROCHIP_CORE=m
> +CONFIG_PINCTRL_METEORLAKE=m
> +CONFIG_GPIO_I8255=m
> +CONFIG_SENSORS_LT7182S=m
> +CONFIG_VIDEO_AR0521=m
> +CONFIG_APERTURE_HELPERS=y
> +CONFIG_SND_HDA_CS_DSP_CONTROLS=m
> +CONFIG_SND_SOC_AMD_ST_ES8336_MACH=m
> +CONFIG_SND_AMD_ASOC_REMBRANDT=m
> +CONFIG_SND_SOC_AMD_RPL_ACP6x=m
> +CONFIG_SND_SOC_FSL_UTILS=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_RT274=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_RT286=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_RT298=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682=m
> +CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567=m
> +CONFIG_SND_SOC_SOF_IPC3=y
> +CONFIG_SND_SOC_SOF_INTEL_IPC4=y
> +CONFIG_SND_SOC_SOF_INTEL_MTL=m
> +CONFIG_SND_SOC_SOF_METEORLAKE=m
> +CONFIG_SND_SOC_HDA=m
> +CONFIG_SND_SOC_RT274=m
> +CONFIG_SND_SOC_TAS2780=m
> +CONFIG_SND_SOC_WSA883X=m
> +CONFIG_UCSI_STM32G0=m
> +CONFIG_TYPEC_ANX7411=m
> +CONFIG_LEDS_IS31FL319X=m
> +CONFIG_INFINIBAND_BNXT_RE=m
> +CONFIG_INFINIBAND_ERDMA=m
> +CONFIG_INFINIBAND_HFI1=m
> +CONFIG_INFINIBAND_MTHCA=m
> +CONFIG_INFINIBAND_QIB=m
> +CONFIG_INFINIBAND_QIB_DCA=y
> +CONFIG_INFINIBAND_USNIC=m
> +CONFIG_INFINIBAND_VMWARE_PVRDMA=m
> +CONFIG_VIDEO_IPU3_IMGU=m
> +CONFIG_VME_BUS=y
> +CONFIG_VME_TSI148=m
> +CONFIG_VME_FAKE=m
> +CONFIG_CHROME_PLATFORMS=y
> +CONFIG_CHROMEOS_ACPI=m
> +CONFIG_CHROMEOS_LAPTOP=m
> +CONFIG_CHROMEOS_PSTORE=m
> +CONFIG_CHROMEOS_TBMC=m
> +CONFIG_CROS_EC=m
> +CONFIG_CROS_EC_I2C=m
> +CONFIG_CROS_EC_ISHTP=m
> +CONFIG_CROS_EC_SPI=m
> +CONFIG_CROS_EC_LPC=m
> +CONFIG_CROS_EC_PROTO=y
> +CONFIG_CROS_KBD_LED_BACKLIGHT=m
> +CONFIG_CROS_EC_CHARDEV=m
> +CONFIG_CROS_EC_LIGHTBAR=m
> +CONFIG_CROS_EC_DEBUGFS=m
> +CONFIG_CROS_EC_SENSORHUB=m
> +CONFIG_CROS_EC_SYSFS=m
> +CONFIG_CROS_EC_TYPEC=m
> +CONFIG_CROS_USBPD_LOGGER=m
> +CONFIG_CROS_USBPD_NOTIFY=m
> +CONFIG_CHROMEOS_PRIVACY_SCREEN=m
> +CONFIG_WILCO_EC=m
> +CONFIG_WILCO_EC_DEBUGFS=m
> +CONFIG_WILCO_EC_EVENTS=m
> +CONFIG_WILCO_EC_TELEMETRY=m
> +CONFIG_MELLANOX_PLATFORM=y
> +CONFIG_MLXREG_HOTPLUG=m
> +CONFIG_MLXREG_IO=m
> +CONFIG_MLXREG_LC=m
> +CONFIG_NVSW_SN2201=m
> +CONFIG_SURFACE_PLATFORMS=y
> +CONFIG_SURFACE3_WMI=m
> +CONFIG_SURFACE_3_POWER_OPREGION=m
> +CONFIG_SURFACE_ACPI_NOTIFY=m
> +CONFIG_SURFACE_AGGREGATOR_CDEV=m
> +CONFIG_SURFACE_AGGREGATOR_HUB=m
> +CONFIG_SURFACE_AGGREGATOR_REGISTRY=m
> +CONFIG_SURFACE_AGGREGATOR_TABLET_SWITCH=m
> +CONFIG_SURFACE_DTX=m
> +CONFIG_SURFACE_GPE=m
> +CONFIG_SURFACE_HOTPLUG=m
> +CONFIG_SURFACE_PLATFORM_PROFILE=m
> +CONFIG_SURFACE_PRO3_BUTTON=m
> +CONFIG_SURFACE_AGGREGATOR=m
> +CONFIG_SURFACE_AGGREGATOR_BUS=y
> +CONFIG_P2SB=y
> +CONFIG_ENVELOPE_DETECTOR=m
> +CONFIG_SD_ADC_MODULATOR=m
> +CONFIG_VF610_ADC=m
> +CONFIG_PWM_CLK=m
> +CONFIG_RESET_SIMPLE=y
> +CONFIG_RESET_TI_TPS380X=m
> +CONFIG_FPGA_MGR_MICROCHIP_SPI=m
> +CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
> +CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
> +CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
> +CONFIG_IMA_KEXEC=y
> +CONFIG_CRYPTO_XCTR=m
> +CONFIG_CRYPTO_HCTR2=m
> +CONFIG_CRYPTO_POLYVAL=m
> +CONFIG_CRYPTO_POLYVAL_CLMUL_NI=m
> +CONFIG_CRYPTO_ARIA=m
> +CONFIG_CRYPTO_LIB_SHA1=y
> +CONFIG_POLYNOMIAL=m
> +CONFIG_DA_MON_EVENTS=y
> +CONFIG_DA_MON_EVENTS_ID=y
> +CONFIG_RV=y
> +CONFIG_RV_MON_WWNR=y
> +CONFIG_RV_REACTORS=y
> +CONFIG_RV_REACT_PRINTK=y
> +CONFIG_RV_REACT_PANIC=y
>
> However, I'm stuck on this. Disecting the modules to one that caused 
> the problem seems
> infeasible, for it takes me two hours for a build ...
>
> Hope this helps ...

I know that it is uncool to reply one's own email, but this is new 
development:

After starting a zoom spawned session, the Firefox snap tab crash 
reappeared.

I will reinstate that if was done with the config-5.19.13-generic and 
"make olddefconfig"
followed by a "make -j 10 deb-pkg" build.

Here is the exact log of my actions:

   678  10/06/2022 06:44:58 PM  vi config-5.19.13-051913-generic
   679  10/06/2022 06:45:21 PM  time rm -rf linux_stable_build/
   680  10/06/2022 06:45:31 PM  time cp -rp linux_stable linux_stable_build
   681  10/06/2022 06:46:39 PM  time diff -ur linux_stable 
linux_stable_build
   682  10/06/2022 06:47:38 PM  cp config-5.19.13-051913-generic 
linux_stable_build/.config
   683  10/06/2022 06:47:46 PM  cd linux_stable_build
   684  10/06/2022 06:47:51 PM  make olddefconfig
   685  10/06/2022 06:48:05 PM  time nice make -j10 deb-pkg

Regards,
-mt

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

