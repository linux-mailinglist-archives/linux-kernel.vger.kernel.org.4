Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B521173FDF1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjF0Ofs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF0Ofo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:35:44 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6990B1994;
        Tue, 27 Jun 2023 07:35:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxKsa685pkqScDAA--.4935S3;
        Tue, 27 Jun 2023 22:35:38 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx5sy285pkUF4MAA--.28626S3;
        Tue, 27 Jun 2023 22:35:34 +0800 (CST)
Message-ID: <7e995baa-22ed-c5ee-6fd1-51bb4440af03@loongson.cn>
Date:   Tue, 27 Jun 2023 22:35:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 6/8] PCI/VGA: Introduce is_boot_device function
 callback to vga_client_register
Content-Language: en-US
To:     Sui Jingfeng <15330273260@189.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230613030151.216625-1-15330273260@189.cn>
 <20230613030151.216625-7-15330273260@189.cn>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230613030151.216625-7-15330273260@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx5sy285pkUF4MAA--.28626S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Cw4UWry5GF4DJr47Xr43urX_yoWDZF13pF
        4rJF15Ar97ZF4I9w47Xa4UAFyYv3y0va4fGrW7Aw1Y9a43Ar9YgF9YyFy5tryxJrZrCF43
        tryDKFWxuF1jvFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUd529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
        vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1U
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
        Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
        7IUev_M7UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING ?

On 2023/6/13 11:01, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>
> The vga_is_firmware_default() function is arch-dependent, it's probably
> wrong if we simply remove the arch guard. As the VRAM BAR which contains
> firmware framebuffer may move, while the lfb_base and lfb_size members of
> the screen_info does not change accordingly. In short, it should take the
> re-allocation of the PCI BAR into consideration.
>
> With the observation that device drivers or video aperture helpers may
> have better knowledge about which PCI bar contains the firmware fb,
> which could avoid the need to iterate all of the PCI BARs. But as a PCI
> function at pci/vgaarb.c, vga_is_firmware_default() is not suitable to
> make such an optimization since it is loaded too early.
>
> There are PCI display controllers that don't have a dedicated VRAM bar,
> this function will lose its effectiveness in such a case. Luckily, the
> device driver can provide an accurate workaround.
>
> Therefore, this patch introduces a callback that allows the device driver
> to tell the VGAARB if the device is the default boot device. This patch
> only intends to introduce the mechanism, while the implementation is left
> to the device driver authors. Also honor the comment: "Clients have two
> callback mechanisms they can use"
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Pan Xinhui <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: YiPeng Chai <YiPeng.Chai@amd.com>
> Cc: Bokun Zhang <Bokun.Zhang@amd.com>
> Cc: Likun Gao <Likun.Gao@amd.com>
> Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> CC: Kevin Tian <kevin.tian@intel.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Abhishek Sahu <abhsahu@nvidia.com>
> Cc: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>   drivers/gpu/drm/i915/display/intel_vga.c   |  3 +--
>   drivers/gpu/drm/nouveau/nouveau_vga.c      |  2 +-
>   drivers/gpu/drm/radeon/radeon_device.c     |  2 +-
>   drivers/pci/vgaarb.c                       | 21 ++++++++++++++++++++-
>   drivers/vfio/pci/vfio_pci_core.c           |  2 +-
>   include/linux/vgaarb.h                     |  8 +++++---
>   7 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5c7d40873ee2..7a096f2d5c16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3960,7 +3960,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	/* this will fail for cards that aren't VGA class devices, just
>   	 * ignore it */
>   	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> -		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
> +		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode, NULL);
>   
>   	px = amdgpu_device_supports_px(ddev);
>   
> diff --git a/drivers/gpu/drm/i915/display/intel_vga.c b/drivers/gpu/drm/i915/display/intel_vga.c
> index 286a0bdd28c6..98d7d4dffe9f 100644
> --- a/drivers/gpu/drm/i915/display/intel_vga.c
> +++ b/drivers/gpu/drm/i915/display/intel_vga.c
> @@ -115,7 +115,6 @@ intel_vga_set_decode(struct pci_dev *pdev, bool enable_decode)
>   
>   int intel_vga_register(struct drm_i915_private *i915)
>   {
> -
>   	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>   	int ret;
>   
> @@ -127,7 +126,7 @@ int intel_vga_register(struct drm_i915_private *i915)
>   	 * then we do not take part in VGA arbitration and the
>   	 * vga_client_register() fails with -ENODEV.
>   	 */
> -	ret = vga_client_register(pdev, intel_vga_set_decode);
> +	ret = vga_client_register(pdev, intel_vga_set_decode, NULL);
>   	if (ret && ret != -ENODEV)
>   		return ret;
>   
> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
> index f8bf0ec26844..162b4f4676c7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
> @@ -92,7 +92,7 @@ nouveau_vga_init(struct nouveau_drm *drm)
>   		return;
>   	pdev = to_pci_dev(dev->dev);
>   
> -	vga_client_register(pdev, nouveau_vga_set_decode);
> +	vga_client_register(pdev, nouveau_vga_set_decode, NULL);
>   
>   	/* don't register Thunderbolt eGPU with vga_switcheroo */
>   	if (pci_is_thunderbolt_attached(pdev))
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index afbb3a80c0c6..71f2ff39d6a1 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1425,7 +1425,7 @@ int radeon_device_init(struct radeon_device *rdev,
>   	/* if we have > 1 VGA cards, then disable the radeon VGA resources */
>   	/* this will fail for cards that aren't VGA class devices, just
>   	 * ignore it */
> -	vga_client_register(rdev->pdev, radeon_vga_set_decode);
> +	vga_client_register(rdev->pdev, radeon_vga_set_decode, NULL);
>   
>   	if (rdev->flags & RADEON_IS_PX)
>   		runtime = true;
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index ceb914245383..c574898380f0 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -53,6 +53,7 @@ struct vga_device {
>   	bool bridge_has_one_vga;
>   	bool is_firmware_default;	/* device selected by firmware */
>   	unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
> +	bool (*is_boot_device)(struct pci_dev *pdev);
>   };
>   
>   static LIST_HEAD(vga_list);
> @@ -969,6 +970,10 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
>    * @set_decode callback: If a client can disable its GPU VGA resource, it
>    * will get a callback from this to set the encode/decode state.
>    *
> + * @is_boot_device: callback to the device driver, query if a client is the
> + * default boot device, as the device driver typically has better knowledge
> + * if specific device is the boot device. But this callback is optional.
> + *
>    * Rationale: we cannot disable VGA decode resources unconditionally, some
>    * single GPU laptops seem to require ACPI or BIOS access to the VGA registers
>    * to control things like backlights etc. Hopefully newer multi-GPU laptops do
> @@ -984,7 +989,8 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
>    * Returns: 0 on success, -1 on failure
>    */
>   int vga_client_register(struct pci_dev *pdev,
> -		unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
> +		unsigned int (*set_decode)(struct pci_dev *pdev, bool decode),
> +		bool (*is_boot_device)(struct pci_dev *pdev))
>   {
>   	int ret = -ENODEV;
>   	struct vga_device *vgadev;
> @@ -996,6 +1002,7 @@ int vga_client_register(struct pci_dev *pdev,
>   		goto bail;
>   
>   	vgadev->set_decode = set_decode;
> +	vgadev->is_boot_device = is_boot_device;
>   	ret = 0;
>   
>   bail:
> @@ -1523,6 +1530,18 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>   		notify = vga_arbiter_add_pci_device(pdev);
>   	else if (action == BUS_NOTIFY_DEL_DEVICE)
>   		notify = vga_arbiter_del_pci_device(pdev);
> +	else if (action == BUS_NOTIFY_BOUND_DRIVER) {
> +		struct vga_device *vgadev = vgadev_find(pdev);
> +		bool boot_dev = false;
> +
> +		if (vgadev && vgadev->is_boot_device)
> +			boot_dev = vgadev->is_boot_device(pdev);
> +
> +		if (boot_dev) {
> +			vgaarb_info(&pdev->dev, "Set as boot device (dictated by driver)\n");
> +			vga_set_default_device(pdev);
> +		}
> +	}
>   
>   	vgaarb_dbg(dev, "%s: action = %lu\n", __func__, action);
>   
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a5ab416cf476..2a8873a330ba 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2067,7 +2067,7 @@ static int vfio_pci_vga_init(struct vfio_pci_core_device *vdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = vga_client_register(pdev, vfio_pci_set_decode);
> +	ret = vga_client_register(pdev, vfio_pci_set_decode, NULL);
>   	if (ret)
>   		return ret;
>   	vga_set_legacy_decoding(pdev, vfio_pci_set_decode(pdev, false));
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 97129a1bbb7d..dfde5a6ba55a 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -33,7 +33,8 @@ struct pci_dev *vga_default_device(void);
>   void vga_set_default_device(struct pci_dev *pdev);
>   int vga_remove_vgacon(struct pci_dev *pdev);
>   int vga_client_register(struct pci_dev *pdev,
> -		unsigned int (*set_decode)(struct pci_dev *pdev, bool state));
> +		unsigned int (*set_decode)(struct pci_dev *pdev, bool state),
> +		bool (*is_boot_device)(struct pci_dev *pdev));
>   #else /* CONFIG_VGA_ARB */
>   static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
>   		unsigned int decodes)
> @@ -59,7 +60,8 @@ static inline int vga_remove_vgacon(struct pci_dev *pdev)
>   	return 0;
>   }
>   static inline int vga_client_register(struct pci_dev *pdev,
> -		unsigned int (*set_decode)(struct pci_dev *pdev, bool state))
> +		unsigned int (*set_decode)(struct pci_dev *pdev, bool state),
> +		bool (*is_boot_device)(struct pci_dev *pdev))
>   {
>   	return 0;
>   }
> @@ -97,7 +99,7 @@ static inline int vga_get_uninterruptible(struct pci_dev *pdev,
>   
>   static inline void vga_client_unregister(struct pci_dev *pdev)
>   {
> -	vga_client_register(pdev, NULL);
> +	vga_client_register(pdev, NULL, NULL);
>   }
>   
>   #endif /* LINUX_VGA_H */

-- 
Jingfeng

