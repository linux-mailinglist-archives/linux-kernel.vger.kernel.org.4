Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F6632284
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKUMnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKUMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:43:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC77EBE878;
        Mon, 21 Nov 2022 04:43:13 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8DxndpfcntjxBoJAA--.25537S3;
        Mon, 21 Nov 2022 20:43:11 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VZbcntj7pkXAA--.43255S2;
        Mon, 21 Nov 2022 20:43:10 +0800 (CST)
Subject: Re: [PATCH v4 1/2] gpio: loongson: add dts and acpi support
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20221117035902.13995-1-zhuyinbo@loongson.cn>
 <9aa20e9a-92b1-4268-921f-11209785acb7@app.fastmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <c11971af-a878-cd7a-7d7f-46d2934c4c6c@loongson.cn>
Date:   Mon, 21 Nov 2022 20:43:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9aa20e9a-92b1-4268-921f-11209785acb7@app.fastmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VZbcntj7pkXAA--.43255S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW3Xr1DAw48Kr4kAFyDWr48JFb_yoW7GFy3pF
        W5Gay3Kr47WF1jy34kX3ykAF1Yyws3twnxJF4xG34vg34DZr95XrW7KFy5urZxArW8Zw4Y
        vFWFgFZruF4Du37anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r1q6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIApnDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Arnd,

I had adop your advice and as v5 series patch.
and about move the legacy gpio driver to other deposition that I have
internal talk in loongson team and think it should be okay.

BRs,
Yinbo.
ÔÚ 2022/11/17 ÏÂÎç5:55, Arnd Bergmann Ð´µÀ:
> On Thu, Nov 17, 2022, at 04:59, Yinbo Zhu wrote:
>>
>>   config GPIO_LOONGSON
>> -	bool "Loongson-2/3 GPIO support"
>> -	depends on CPU_LOONGSON2EF || CPU_LOONGSON64
>> +	bool "Loongson series GPIO support"
>> +	depends on LOONGARCH || COMPILE_TEST
> 
> This looks like it will introduce a regression for users of the
> older machines CPU_LOONGSON2EF and CPU_LOONGSON64 machines.
> 
> While the driver previously called 'platform_device_register_simple'
> to create the platform device itself, this call is no longer
> done anywhere, so it also cannot work here, but whatever was
> working should not be broken. I can see two possible ways to do
> this:
> 
> a) create the platform_device in the mips code in a way that
> the driver can handle it as before
> 
> b) duplicate the entire driver and leave the old code untouched.
> 
> The second one is probably easier here, but the first one would
> be nicer in the end, depending on how much of the original
> code remains.
> 
>>   	help
>> -	  Driver for GPIO functionality on Loongson-2F/3A/3B processors.
>> +	  Driver for GPIO functionality on Loongson seires processors.
> 
> s/seires/series/
> 
>> +static void of_loongson_gpio_get_props(struct device_node *np,
>> +				  struct loongson_gpio_chip *lgpio)
>> +{
>> +	const char *name;
>> +
>> +	of_property_read_u32(np, "ngpios", (u32 *)&lgpio->chip.ngpio);
> 
> This does not work: chip.ngpio is a 16-bit field, so you
> cannot overwrite it using a 32-bit pointer dereference. Just
> use a local variable as an intermediate
> 
>> +	of_property_read_string(np, "compatible", &name);
>> +	lgpio->chip.label = kstrdup(name, GFP_KERNEL);
>> +	if (!strcmp(name, "loongson,ls2k-gpio")) {
>> +		lgpio->conf_offset = 0x0;
> 
> This probably works, but is not reliable since "compatible"
> is an enumeration rather than a single string. Using
> of_device_is_compatible() would work here, or even better
> you can have a configuration that is referenced from
> the 'data' field of the 'of_device_id'
> 
>> +static void acpi_loongson_gpio_get_props(struct platform_device *pdev,
>> +				  struct loongson_gpio_chip *lgpio)
>> +{
>> +
>> +	struct device *dev = &pdev->dev;
>> +	int rval;
>> +
>> +	device_property_read_u32(dev, "ngpios", (u32 *)&lgpio->chip.ngpio);
>> +	device_property_read_u32(dev, "gpio_base", (u32 *)&lgpio->chip.base);
>> +	device_property_read_u32(dev, "conf_offset",
>> +					(u32 *)&lgpio->conf_offset);
>> +	device_property_read_u32(dev, "out_offset",
>> +					(u32 *)&lgpio->out_offset);
>> +	device_property_read_u32(dev, "in_offset", (u32 *)&lgpio->in_offset);
> 
> This looks worrying: While you addressed the feedback in the
> DT binding, the ACPI version still uses the old format, which
> the binding is different depending on the firmware.
> 
> A modern driver should not set the "gpio_base" any more, and
> the firmware should not care either.
> 
> The other fields appear to correspond to the ones that the DT
> version decides based on the device identifier. There isn't
> really a point in doing this differently, so pick one version
> or the other and then use the same method for both DT and ACPI.
> 
>> +static void platform_loongson_gpio_get_props(struct platform_device *pdev,
>> +				  struct loongson_gpio_chip *lgpio)
>> +{
>> +}
> 
>> +	if (np)
>> +		of_loongson_gpio_get_props(np, lgpio);
>> +	else if (ACPI_COMPANION(&pdev->dev))
>> +		acpi_loongson_gpio_get_props(pdev, lgpio);
>> +	else
>> +		platform_loongson_gpio_get_props(pdev, lgpio);
> 
> The third branch is clearly broken now as it fails to assign
> anything. Using device_property_read_u32() etc should really
> work in all three cases, so if you fold the
> of_loongson_gpio_get_props and acpi_loongson_gpio_get_props
> functions into one, that will solve the third case as well.
> 
>> +static const struct of_device_id loongson_gpio_dt_ids[] = {
>> +	{ .compatible = "loongson,ls2k-gpio"},
>> +	{ .compatible = "loongson,ls7a-gpio"},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_gpio_dt_ids);
>> +
>> +static const struct acpi_device_id loongson_gpio_acpi_match[] = {
>> +	{"LOON0002"},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
>> +
>>   static struct platform_driver loongson_gpio_driver = {
>>   	.driver = {
>>   		.name = "loongson-gpio",
>> +		.owner = THIS_MODULE,
>> +		.of_match_table = loongson_gpio_dt_ids,
>> +		.acpi_match_table = ACPI_PTR(loongson_gpio_acpi_match),
>>   	},
> 
> The ACPI_PTR() macro here means that you get an "unused variable"
> warning when the driver is build with CONFIG_ACPI disabled.
> I think you should just reference the variable directly. If you
> want to save a few bytes, you can keep the ACPI_PTR() here
> and enclose the struct definition in #ifdef CONFIG_ACPI.
> 
>      Arnd
> 

