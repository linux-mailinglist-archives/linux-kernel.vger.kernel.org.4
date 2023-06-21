Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8732773845A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjFUNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjFUNEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:04:50 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61BB3E57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:04:48 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxiMVu9ZJkOyMAAA--.263S3;
        Wed, 21 Jun 2023 21:04:46 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM5s9ZJkrKsAAA--.3938S3;
        Wed, 21 Jun 2023 21:04:44 +0800 (CST)
Message-ID: <c7b2265c-1fe2-cb6e-ca97-750225aa6a64@loongson.cn>
Date:   Wed, 21 Jun 2023 21:04:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 05/11] drm/etnaviv: Allow bypass component framework
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sui Jingfeng <18949883232@163.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230620094716.2231414-1-18949883232@163.com>
 <20230620094716.2231414-6-18949883232@163.com>
 <2c48ad0d1277f880d4d758fe3a3ad24d33e2fabe.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <2c48ad0d1277f880d4d758fe3a3ad24d33e2fabe.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrM5s9ZJkrKsAAA--.3938S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3KFWkJw45ZrWrAr4fJw1rKrX_yoWkWry3pF
        Z7JFWYkr48uFyqg342qrs5ZF9Ikw1Sq34Sk34kK3s3Kws0yr95tFyUtFyj93sxAr95WF43
        tr1UtrsruF4Fy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb_-
        PUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/21 17:29, Lucas Stach wrote:
> Am Dienstag, dem 20.06.2023 um 17:47 +0800 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> Originally, component frameworks were used to bind multiple GPU cores to a
>> virtual master. But there are chips that have only one GPU core integrated.
>> The component framework can be avoided under some circumstances, Another
>> reason is that usperspace programs such as X server and Mesa will try to
>> find the PCI device to use by default. Creating a virtual master device
>> for PCI GPUs cause unnecessary troubles.
>>
>> This patch add additional code paths to allow bypassing the component
>> frameworks, platforms with a single GPU core could probably try the
>> non-component code path also. This patch is for code shaing between the
>> PCI driver and the platform driver.
>>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 47 ++++++++++-----
>>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 83 +++++++++++++++++----------
>>   drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  3 +
>>   3 files changed, 91 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> index 6a048be02857..93ca240cd4c0 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> @@ -536,10 +536,9 @@ static const struct drm_driver etnaviv_drm_driver = {
>>   	.minor              = 3,
>>   };
>>   
>> -/*
>> - * Platform driver:
>> - */
>> -static int etnaviv_bind(struct device *dev)
>> +static struct etnaviv_drm_private *etna_private_ptr;
> That's not going to fly. You are dropping the virtual master device,
> which bundles multiple GPUs together, but you are also only allowing a
> single GPU instance via this global private data pointer.
>
> I'm okay with dropping the virtual master and instantiating a DRM
> device for each PCI device, but then the driver at least needs to be
> able to handle multiple instances.

Nice catch!


By multiple instances, do you means that multiple vivante GPU core ?


Currently we don't know how to handle multiple PCI GPU instances,

The main reason is that we don't have such a hardware.

I still think,

the PCI device itself still should be the master, other GPU cores can be 
initialized manually.

or bind to this PCI device master with priori knowledge./
/

> Also what exactly is the problem with the virtual master device?

mesa's piple loader will find the PCI device to use by default.

the virtual master device is a platform device.

PCI device go first.

> Couldn't we just instantiate one of those for each PCI device to
> minimize the changes needed to the bind/unbind logic?
If we have such a hardware,

I don't expect each of them could populate to be a stand alone PCI 
device instance.

Often, the mmio registers of the multiple instantiate are offset-ed 
within the same PCI BAR.

Multiple PCI device usually means multiple device driver.


To be honest, this is already the minimal change we can do,

which don't introduce duplication like the patch we made one years ago.


>
> Regards,
> Lucas
>
>> +
>> +static int etnaviv_drm_bind(struct device *dev, bool component)
>>   {
>>   	struct etnaviv_drm_private *priv;
>>   	struct drm_device *drm;
>> @@ -556,12 +555,15 @@ static int etnaviv_bind(struct device *dev)
>>   	}
>>   
>>   	drm->dev_private = priv;
>> +	etna_private_ptr = priv;
>>   
>>   	dma_set_max_seg_size(dev, SZ_2G);
>>   
>> -	dev_set_drvdata(dev, drm);
>> +	if (component)
>> +		ret = component_bind_all(dev, drm);
>> +	else
>> +		ret = etnaviv_gpu_bind(dev, NULL, drm);
>>   
>> -	ret = component_bind_all(dev, drm);
>>   	if (ret < 0)
>>   		goto out_free_priv;
>>   
>> @@ -574,7 +576,10 @@ static int etnaviv_bind(struct device *dev)
>>   	return 0;
>>   
>>   out_unbind:
>> -	component_unbind_all(dev, drm);
>> +	if (component)
>> +		component_unbind_all(dev, drm);
>> +	else
>> +		etnaviv_gpu_unbind(dev, NULL, drm);
>>   out_free_priv:
>>   	etnaviv_free_private(priv);
>>   out_put:
>> @@ -583,14 +588,17 @@ static int etnaviv_bind(struct device *dev)
>>   	return ret;
>>   }
>>   
>> -static void etnaviv_unbind(struct device *dev)
>> +static void etnaviv_drm_unbind(struct device *dev, bool component)
>>   {
>> -	struct drm_device *drm = dev_get_drvdata(dev);
>> -	struct etnaviv_drm_private *priv = drm->dev_private;
>> +	struct etnaviv_drm_private *priv = etna_private_ptr;
>> +	struct drm_device *drm = priv->drm;
>>   
>>   	drm_dev_unregister(drm);
>>   
>> -	component_unbind_all(dev, drm);
>> +	if (component)
>> +		component_unbind_all(dev, drm);
>> +	else
>> +		etnaviv_gpu_unbind(dev, NULL, drm);
>>   
>>   	etnaviv_free_private(priv);
>>   
>> @@ -599,9 +607,22 @@ static void etnaviv_unbind(struct device *dev)
>>   	drm_dev_put(drm);
>>   }
>>   
>> +/*
>> + * Platform driver:
>> + */
>> +static int etnaviv_master_bind(struct device *dev)
>> +{
>> +	return etnaviv_drm_bind(dev, true);
>> +}
>> +
>> +static void etnaviv_master_unbind(struct device *dev)
>> +{
>> +	return etnaviv_drm_unbind(dev, true);
>> +}
>> +
>>   static const struct component_master_ops etnaviv_master_ops = {
>> -	.bind = etnaviv_bind,
>> -	.unbind = etnaviv_unbind,
>> +	.bind = etnaviv_master_bind,
>> +	.unbind = etnaviv_master_unbind,
>>   };
>>   
>>   static int etnaviv_pdev_probe(struct platform_device *pdev)
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> index 5e88fa95dac2..059be8c89c5a 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> @@ -1737,8 +1737,7 @@ static const struct thermal_cooling_device_ops cooling_ops = {
>>   	.set_cur_state = etnaviv_gpu_cooling_set_cur_state,
>>   };
>>   
>> -static int etnaviv_gpu_bind(struct device *dev, struct device *master,
>> -	void *data)
>> +int etnaviv_gpu_bind(struct device *dev, struct device *master, void *data)
>>   {
>>   	struct drm_device *drm = data;
>>   	struct etnaviv_drm_private *priv = drm->dev_private;
>> @@ -1769,7 +1768,6 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
>>   	if (ret < 0)
>>   		goto out_sched;
>>   
>> -
>>   	gpu->drm = drm;
>>   	gpu->fence_context = dma_fence_context_alloc(1);
>>   	xa_init_flags(&gpu->user_fences, XA_FLAGS_ALLOC);
>> @@ -1798,8 +1796,7 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
>>   	return ret;
>>   }
>>   
>> -static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
>> -	void *data)
>> +void etnaviv_gpu_unbind(struct device *dev, struct device *master, void *data)
>>   {
>>   	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
>>   
>> @@ -1867,9 +1864,11 @@ static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
>>   	return 0;
>>   }
>>   
>> -static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>> +/* platform independent */
>> +
>> +static int etnaviv_gpu_driver_create(struct device *dev, void __iomem *mmio,
>> +				     int irq, bool component, bool has_clk)
>>   {
>> -	struct device *dev = &pdev->dev;
>>   	struct etnaviv_gpu *gpu;
>>   	int err;
>>   
>> @@ -1877,24 +1876,22 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>>   	if (!gpu)
>>   		return -ENOMEM;
>>   
>> -	gpu->dev = &pdev->dev;
>> +	gpu->dev = dev;
>> +	gpu->mmio = mmio;
>>   	mutex_init(&gpu->lock);
>>   	mutex_init(&gpu->sched_lock);
>>   
>> -	/* Map registers: */
>> -	gpu->mmio = devm_platform_ioremap_resource(pdev, 0);
>> -	if (IS_ERR(gpu->mmio))
>> -		return PTR_ERR(gpu->mmio);
>> -
>>   	/* Get Interrupt: */
>> -	err = etnaviv_gpu_register_irq(gpu, platform_get_irq(pdev, 0));
>> +	err = etnaviv_gpu_register_irq(gpu, irq);
>>   	if (err)
>>   		return err;
>>   
>>   	/* Get Clocks: */
>> -	err = etnaviv_gpu_clk_get(gpu);
>> -	if (err)
>> -		return err;
>> +	if (has_clk) {
>> +		err = etnaviv_gpu_clk_get(gpu);
>> +		if (err)
>> +			return err;
>> +	}
>>   
>>   	/* TODO: figure out max mapped size */
>>   	dev_set_drvdata(dev, gpu);
>> @@ -1904,24 +1901,27 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>>   	 * autosuspend delay is rather arbitary: no measurements have
>>   	 * yet been performed to determine an appropriate value.
>>   	 */
>> -	pm_runtime_use_autosuspend(gpu->dev);
>> -	pm_runtime_set_autosuspend_delay(gpu->dev, 200);
>> -	pm_runtime_enable(gpu->dev);
>> -
>> -	err = component_add(&pdev->dev, &gpu_ops);
>> -	if (err < 0) {
>> -		dev_err(&pdev->dev, "failed to register component: %d\n", err);
>> -		return err;
>> +	pm_runtime_use_autosuspend(dev);
>> +	pm_runtime_set_autosuspend_delay(dev, 200);
>> +	pm_runtime_enable(dev);
>> +
>> +	if (component) {
>> +		err = component_add(dev, &gpu_ops);
>> +		if (err < 0) {
>> +			dev_err(dev, "failed to register component: %d\n", err);
>> +			return err;
>> +		}
>>   	}
>>   
>>   	return 0;
>>   }
>>   
>> -static int etnaviv_gpu_platform_remove(struct platform_device *pdev)
>> +static void etnaviv_gpu_driver_destroy(struct device *dev, bool component)
>>   {
>> -	component_del(&pdev->dev, &gpu_ops);
>> -	pm_runtime_disable(&pdev->dev);
>> -	return 0;
>> +	if (component)
>> +		component_del(dev, &gpu_ops);
>> +
>> +	pm_runtime_disable(dev);
>>   }
>>   
>>   static int etnaviv_gpu_rpm_suspend(struct device *dev)
>> @@ -1971,6 +1971,31 @@ static const struct dev_pm_ops etnaviv_gpu_pm_ops = {
>>   	RUNTIME_PM_OPS(etnaviv_gpu_rpm_suspend, etnaviv_gpu_rpm_resume, NULL)
>>   };
>>   
>> +static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	void __iomem *mmio;
>> +	int irq;
>> +
>> +	/* Map registers: */
>> +	mmio = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(mmio))
>> +		return PTR_ERR(mmio);
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +
>> +	return etnaviv_gpu_driver_create(dev, mmio, irq, true, true);
>> +}
>> +
>> +static int etnaviv_gpu_platform_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +
>> +	etnaviv_gpu_driver_destroy(dev, true);
>> +
>> +	return 0;
>> +}
>> +
>>   struct platform_driver etnaviv_gpu_driver = {
>>   	.driver = {
>>   		.name = "etnaviv-gpu",
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
>> index 98c6f9c320fc..1ec829a649b5 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
>> @@ -206,6 +206,9 @@ void etnaviv_gpu_pm_put(struct etnaviv_gpu *gpu);
>>   int etnaviv_gpu_wait_idle(struct etnaviv_gpu *gpu, unsigned int timeout_ms);
>>   void etnaviv_gpu_start_fe(struct etnaviv_gpu *gpu, u32 address, u16 prefetch);
>>   
>> +int etnaviv_gpu_bind(struct device *dev, struct device *master, void *data);
>> +void etnaviv_gpu_unbind(struct device *dev, struct device *master, void *data);
>> +
>>   extern struct platform_driver etnaviv_gpu_driver;
>>   
>>   #endif /* __ETNAVIV_GPU_H__ */

-- 
Jingfeng

